#include <ros/ros.h>
#include <geometry_msgs/Twist.h>

#include <nav_msgs/Odometry.h>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2/LinearMath/Matrix3x3.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf2_ros/transform_broadcaster.h>
#include <geometry_msgs/TransformStamped.h>

#include <sensor_msgs/LaserScan.h>
#include <sensor_msgs/Range.h>
#include <sensor_msgs/Imu.h>

#include <std_srvs/Empty.h>
#include <sl_chassis.h>
#include <sl_chassis_driver.h>

#include "chassis_ros/battery.h"
#include "chassis_ros/health_info.h"

// 定义了 RAD2DEG 宏，用于将弧度转换为角度
#define DEG2RAD(x) ((x)*M_PI / 180.0)
#define SHIFT15BITS 32768.00
#define SCALE_FACTOR 16384.00
// 使用了sl命名空间
using namespace sl;

// 声明指针变量并将其初始化为NULL
IBaseDriver * drv1 = NULL;
ICp0Driver * drv2 = NULL;

sl_chassis_set_velocity_request_t vel_data;


// -------------------------Part1 velocity control -------------------------------
// 声明一个变量用于记录上一个速度命令
geometry_msgs::Twist last_cmd_vel;
// 声明变量来记录当前速度和目标速度
double current_vel = 0.0;
double target_vel = 0.0;

// 声明加速度和减速度
const double acceleration = 0.01;
const double deceleration = 0.01;
const double stop_acceleration = 0.03;  // 更快的加速度用于停止

// 1. 回调函数，用于处理速度话题的数据
void velocityCallback(const geometry_msgs::Twist::ConstPtr& msg)
{
    target_vel = msg->linear.x;

    if (target_vel > current_vel) {
        // 加速
        if (target_vel == 0.0) {
            // 如果目标速度为零，使用更快的加速度停止
            current_vel += stop_acceleration;
        } else {
            current_vel += acceleration;
        }
        if (current_vel > target_vel) {
            current_vel = target_vel;
        }
    } else if (target_vel < current_vel) {
        // 减速
        if (target_vel == 0.0) {
            // 如果目标速度为零，使用更快的加速度停止
            current_vel -= stop_acceleration;
        } else {
            current_vel -= deceleration;
        }
        if (current_vel < target_vel) {
            current_vel = target_vel;
        }
    }

    // 更新速度命令
    last_cmd_vel.linear.x = current_vel;

    // 发布平滑过渡后的速度命令
    vel_data.velocity_x_q16 = last_cmd_vel.linear.x * 65536.0;


    
    // vel_data.velocity_x_q16 = msg->linear.x * 65536.0;
    vel_data.velocity_y_q16 = msg->linear.y * 65536.0;
    vel_data.angular_velocity_q16 = msg->angular.z * 65536.0;

    // ROS_INFO("Received velocity message: x: %f, delta_vx: %f, yaw: %f", last_cmd_vel.linear.x, delta_vx, msg->angular.z);
    // ROS_INFO("Received velocity message: x: %f, y: %f, yaw: %f", msg->linear.x, msg->linear.y, msg->angular.z);
}

// -------------------------Part2** odom try base controller-------------------------------
// ros::Time then;
// double x;
// double y;
// double yaw;

// void publish_Odom(ros::Publisher* pub1, ros::Publisher* pub2, const sl_chassis_deadreckon_response_t& odom_data)
// {
//     ros::Time now = ros::Time::now();
//     ros::Duration dt = now - then;
//     then = now;
//     double dt_sec = dt.toSec();

//     double dx = odom_data.base_dx_mm_q16 / 65536.0 / 1000.0;
//     double dy = odom_data.base_dy_mm_q16 / 65536.0 / 1000.0;
//     // double dy = 0.0;
//     double dyaw = DEG2RAD(odom_data.base_dtheta_degree_q16 / 65536.0);

//     double vx = dx / dt_sec;
//     double vy = dy / dt_sec;
//     double vyaw = dyaw / dt_sec;

//     x += (cos(dyaw) * dx - sin(dyaw) * dy);
//     y += (sin(dyaw) * dx + cos(dyaw) * dy);
//     yaw += dyaw;

//     // Create a Quaternion for the orientation
//     tf2::Quaternion quaternion;
//     quaternion.setRPY(0.0, 0.0, yaw);

//     // Create the odometry transform frame broadcaster.
//     geometry_msgs::TransformStamped odomTrans;
//     tf2_ros::TransformBroadcaster odomBroadcaster;
//     odomTrans.header.stamp = ros::Time::now();
//     odomTrans.header.frame_id = "odom";
//     odomTrans.child_frame_id = "base_link";
//     odomTrans.transform.translation.x = x;
//     odomTrans.transform.translation.y = y;
//     odomTrans.transform.translation.z = 0.0;
//     odomTrans.transform.rotation = tf2::toMsg(quaternion);
//     odomBroadcaster.sendTransform(odomTrans);

//     // Create an Odometry message
//     nav_msgs::Odometry odom;
//     odom.header.frame_id = "odom";
//     odom.child_frame_id = "base_link";
//     odom.header.stamp = ros::Time::now();
//     odom.pose.pose.position.x = x;
//     odom.pose.pose.position.y = y;
//     odom.pose.pose.position.z = 0.0;
//     odom.pose.pose.orientation = tf2::toMsg(quaternion);
//     odom.twist.twist.linear.x = vx;
//     odom.twist.twist.linear.y = 0.0;
//     odom.twist.twist.linear.z = 0.0;  // Assuming 2D motion
//     odom.twist.twist.angular.x = 0.0;
//     odom.twist.twist.angular.y = 0.0;
//     odom.twist.twist.angular.z = vyaw;

//     pub1->publish(odom);
// }


// -------------------------Part2 odom -------------------------------
double accumulated_x = 0.0;
double accumulated_y = 0.0;
double accumulated_yaw = 0.0;
ros::Time prev_time;  // 上一次位置信息的时间戳

// 声明一个计数器和一个用于累积速度的缓冲区
int velocity_count = 0;
double accumulated_vx = 0.0;
double accumulated_vy = 0.0;
double accumulated_vtheta = 0.0;
double accumulated_dt = 0.0;

// 上一次的速度信息
double last_vx = 0.0;
double last_vy = 0.0;
double last_vtheta = 0.0;

const double time_window = 0.1; // 单位：秒

void publish_Odom(ros::Publisher* pub1, ros::Publisher* pub2, const sl_chassis_deadreckon_response_t& odom_data)
{
    

    double dx = odom_data.base_dx_mm_q16 / 65536.0 / 1000.0;
    double dy = odom_data.base_dy_mm_q16 / 65536.0 / 1000.0;
    // double dy = 0.0;
    double dyaw = DEG2RAD(odom_data.base_dtheta_degree_q16 / 65536.0);

   

    // 累加用于求速度的delta值到缓冲区中
    // accumulated_vx += dx;
    // accumulated_vy += dy;
    // accumulated_vtheta += dyaw;
    // accumulated_dt += dt;

    tf2::Transform incremental_transform;
    incremental_transform.setOrigin(tf2::Vector3(dx, dy, 0.0));
    tf2::Quaternion delta_quat;
    delta_quat.setRPY(0.0, 0.0, dyaw);
    incremental_transform.setRotation(delta_quat);

    tf2::Transform accumulated_transform;
    accumulated_transform.setOrigin(tf2::Vector3(accumulated_x, accumulated_y, 0.0));
    tf2::Quaternion accumulated_quat;
    accumulated_quat.setRPY(0.0, 0.0, accumulated_yaw);
    accumulated_transform.setRotation(accumulated_quat);

    accumulated_transform = accumulated_transform * incremental_transform;

    accumulated_x = accumulated_transform.getOrigin().getX();
    accumulated_y = accumulated_transform.getOrigin().getY();

    // Calculate the yaw from the accumulated quaternion
    tf2::Matrix3x3 mat(accumulated_transform.getRotation());
    double roll, pitch;
    mat.getRPY(roll, pitch, accumulated_yaw);

 
    // geometry_msgs::Twist twistMsg;
    
    nav_msgs::Odometry odomMsg;
    odomMsg.header.stamp = ros::Time::now();
    odomMsg.header.frame_id = "odom";
    odomMsg.child_frame_id = "base_link";

    odomMsg.pose.pose.position.x = accumulated_x;
    odomMsg.pose.pose.position.y = accumulated_y;
    odomMsg.pose.pose.position.z = 0.0;

    tf2::Quaternion quat;
    quat.setRPY(0.0, 0.0, accumulated_yaw);
    geometry_msgs::Quaternion odomQuat = tf2::toMsg(quat);
    odomMsg.pose.pose.orientation = odomQuat;

    // if (accumulated_dt >= 0.098 )
    // {
    //     // 计算平均速度
    //     double avg_vx = accumulated_vx / accumulated_dt;
    //     double avg_vy = accumulated_vy / accumulated_dt;
    //     double avg_vtheta = accumulated_vtheta / accumulated_dt;
    //     // ROS_INFO("accumulated_dt = %f, vx = %f, vy = %f, vtheta = %f",accumulated_dt, avg_vx, avg_vy, avg_vtheta);

    //     // 更新速度信息
    //     odomMsg.twist.twist.linear.x = avg_vx;
    //     odomMsg.twist.twist.linear.y = avg_vy;
    //     odomMsg.twist.twist.linear.z = 0.0;

    //     odomMsg.twist.twist.angular.x = 0.0;
    //     odomMsg.twist.twist.angular.y = 0.0;
    //     odomMsg.twist.twist.angular.z = avg_vtheta;


    //     // 为发布实际速度话题
    //     twistMsg.linear.x = avg_vx;
    //     twistMsg.linear.y = avg_vy;
    //     twistMsg.linear.z = 0.0;

    //     twistMsg.angular.x = 0.0;
    //     twistMsg.angular.y = 0.0;
    //     twistMsg.angular.z = avg_vtheta;

    //     // 保存当前速度信息到上一次速度变量中
    //     last_vx = avg_vx;
    //     last_vy = avg_vy;
    //     last_vtheta = avg_vtheta;

    //     // 重置计数器和速度缓冲区
    //     accumulated_dt = 0.0;
    //     accumulated_vx = 0.0;
    //     accumulated_vy = 0.0;
    //     accumulated_vtheta = 0.0;
    // }
    // else
    // {
    //     // 未达到计算平均速度的条件，保持上一次的速度信息
    //     odomMsg.twist.twist.linear.x = last_vx;
    //     odomMsg.twist.twist.linear.y = last_vy;
    //     odomMsg.twist.twist.linear.z = 0.0;

    //     odomMsg.twist.twist.angular.x = 0.0;
    //     odomMsg.twist.twist.angular.y = 0.0;
    //     odomMsg.twist.twist.angular.z = last_vtheta;


    //     // 为发布实际速度话题
    //     twistMsg.linear.x = last_vx;
    //     twistMsg.linear.y = last_vy;
    //     twistMsg.linear.z = 0.0;

    //     twistMsg.angular.x = 0.0;
    //     twistMsg.angular.y = 0.0;
    //     twistMsg.angular.z = last_vtheta;
    // }

    static tf2_ros::TransformBroadcaster broadcaster;
    geometry_msgs::TransformStamped transformStamped;
    transformStamped.header.stamp = ros::Time::now();
    transformStamped.header.frame_id = "odom";
    transformStamped.child_frame_id = "base_link";
    transformStamped.transform.translation.x = accumulated_x;
    transformStamped.transform.translation.y = accumulated_y;
    transformStamped.transform.translation.z = 0.0;
    transformStamped.transform.rotation = odomQuat;
    broadcaster.sendTransform(transformStamped);

    pub1->publish(odomMsg);
    // pub2->publish(twistMsg);
    
}

// ------------------------- Part3 Raw IMU -----------------
void publish_Imu(ros::Publisher* pub, const sl_imu_raw_data_t& Imu_data)
{
    
    //根据datasheet,其sensitivity scale factor is 16384, 正负2g
    double acc_x = Imu_data.acc_x / SHIFT15BITS * 2 * 9.8;
    double acc_y = Imu_data.acc_y / SHIFT15BITS * 2 * 9.8;
    double acc_z = Imu_data.acc_z / SHIFT15BITS * 2 * 9.8;
    
    //double acc_x_test = static_cast<double>(Imu_data.acc_x);

    double gyro_x = Imu_data.gyro_x / SHIFT15BITS * 500 / 180 * 3.1415926;
    double gyro_y = Imu_data.gyro_y / SHIFT15BITS * 500 / 180 * 3.1415926;
    double gyro_z = Imu_data.gyro_z / SHIFT15BITS * 500 / 180 * 3.1415926;

    // double mag_x = Imu_data.mag_x / 65536.0;
    // double mag_y = Imu_data.mag_y / 65536.0;
    // double mag_z = Imu_data.mag_z / 65536.0;

    
    //ROS_INFO("Received velocity message: raw_acc_x: %d, acc_x_test: %d, acc_y: %d, acc_z: %d", acc_x, acc_y, acc_y, acc_z);
    //ROS_INFO("Received velocity message: gyro_x: %d, gyro_x: %d, gyro_x: %d", Imu_data.gyro_x , Imu_data.gyro_y , Imu_data.gyro_z);
    //ROS_INFO("Received velocity message: acc_x: %d, acc_x: %d, acc_x: %d", Imu_data.acc_x , Imu_data.acc_y , Imu_data.acc_z);
    sensor_msgs::Imu Imu;
    
    
    Imu.header.stamp = ros::Time::now();
    Imu.header.frame_id = "Imu";
    Imu.linear_acceleration.x =  acc_x;
    Imu.linear_acceleration.y =  acc_y;
    Imu.linear_acceleration.z =  acc_z;

    Imu.angular_velocity.x = gyro_x;
    Imu.angular_velocity.y = gyro_y;
    Imu.angular_velocity.z = gyro_z;

    // Imu.linear_acceleration.x = Imu_data.acc_x;
    // Imu.linear_acceleration.y = Imu_data.acc_y;
    // Imu.linear_acceleration.z = Imu_data.acc_z;

    // Imu.angular_velocity.x = Imu_data.gyro_x;
    // Imu.angular_velocity.y = Imu_data.gyro_y;
    // Imu.angular_velocity.z = Imu_data.gyro_z;


    tf2::Quaternion quat;
    //quat.setRPY(0, 0, 0);
    //geometry_msgs::Quaternion ImuQuat = tf2::toMsg(quat);
    //Imu.orientation = ImuQuat;


    // static tf2_ros::TransformBroadcaster broadcaster;
    // geometry_msgs::TransformStamped transformStamped;
    // transformStamped.header.stamp = ros::Time::now();
    // transformStamped.header.frame_id = "Imu";
    // transformStamped.child_frame_id = "base_link";
    // transformStamped.transform.translation.x = gyro_x;
    // transformStamped.transform.translation.y = gyro_y;
    // transformStamped.transform.translation.z = gyro_z;
    // //transformStamped.transform.rotation = ImuQuat;
    // broadcaster.sendTransform(transformStamped);


    pub->publish(Imu);
}


// ------------------------- Part4 Processed IMU -----------------
void publish_PImu(ros::Publisher* pub, const sl_cp0_read_imu_processed_response_t& PImu_data)
{
    

    double acc_x = PImu_data.acc.x_d4 * 4.0;
    // double acc_y = Imu_data.acc_y / 16.0;
    // double acc_z = Imu_data.acc_z / 16.0;
    
    // double acc_x_test = static_cast<double>(Imu_data.acc_x);

    // double gyro_x = Imu_data.gyro_x / 65536.0;
    // double gyro_y = Imu_data.gyro_y / 65536.0;
    // double gyro_z = Imu_data.gyro_z / 65536.0;

    // double mag_x = Imu_data.mag_x / 65536.0;
    // double mag_y = Imu_data.mag_y / 65536.0;
    // double mag_z = Imu_data.mag_z / 65536.0;

    
    // ROS_INFO("Received PIMU message: acc_x_raw: %f, ACC_X_TEST: %f", PImu_data.acc.x_d4, acc_x);
    
    // sensor_msgs::Imu Imu;
    
    // nav_msgs::Odometry odomMsg;
    // odomMsg.header.stamp = ros::Time::now();
    // odomMsg.header.frame_id = "odom";
    // odomMsg.child_frame_id = "base_link";

    // odomMsg.pose.pose.position.x = accumulated_x;
    // odomMsg.pose.pose.position.y = accumulated_y;
    // odomMsg.pose.pose.position.z = 0.0;

    // tf2::Quaternion quat;
    // quat.setRPY(0.0, 0.0, accumulated_yaw);
    // geometry_msgs::Quaternion odomQuat = tf2::toMsg(quat);
    // odomMsg.pose.pose.orientation = odomQuat;
}

// 服务1： 电池 信息
// bool 返回值由于标志是否处理成功
bool Battery_Req(chassis_ros::battery::Request& req, chassis_ros::battery::Response& resp){
 
    int num1 = req.num1;

    // ROS_INFO("服务器接收到的请求数据为:num1 = %d",num1);

    //逻辑处理
    if (num1 != 0)
    {
        ROS_ERROR("call service error");
        return false;
    }

    if(!drv1)
    {
        ROS_ERROR("drv1 error");
        
        return false;
    }

    sl_chassis_bat_status_response_t status;
    drv1->getBatteryStatus(status);
    
    //如果没有异常，那么将结果赋值给 resp
    resp.battery_percentage = status.battery_percentage;
    resp.battery_status = status.power_status;

    return true;


}


// 服务2：健康 信息
bool Health_Info_Req(chassis_ros::health_info::Request& req, chassis_ros::health_info::Response& resp){
 
    int num1 = req.num1;

    // ROS_INFO("服务器接收到的请求数据为:num1 = %d",num1);

    //逻辑处理
    if (num1 != 0)
    {
        ROS_ERROR("call service error");
        return false;
    }

    if(!drv1)
    {
        ROS_ERROR("drv1 error");
        
        return false;
    }

    sl_chassis_health_response_t health_resp;
    drv1->getHealthInfo(health_resp);

     //如果没有异常，那么将结果赋值给 resp
    resp.health_flag = health_resp.health_flag;
    resp.error_count = health_resp.error_count;

    sl_chassis_health_error_request_t error_id;
    sl_chassis_health_error_response_t error_data;

    for (error_id.error_id = 0; error_id.error_id < health_resp.error_count; ++error_id.error_id)
    {
        drv1->getSingleHealthData(error_id, error_data);
        resp.error_codes.push_back(error_data.error_code);
        resp.error_msgs.push_back(error_data.error_msg);
    }
    // test
  

    return true;


}


// 服务3：清除特定 健康错误 信息










// 主函数
int main(int argc, char * argv[])
{
    ros::init(argc, argv, "chassis_node");  // 初始化ROS节点
    
    // 声明并初始化一系列变量，用于存储参数和配置
    /*
    ROS node:
        启动参数：  （使用配置文件方式）param文件
        Base通信接口：
        Cp0通信接口：
        超声配置：id、数量及位置
        碰撞：id、数量及位置
        跌落：id、数量及位置
        Rplidar波特率（A/S系列）：串口版 网口版不需要
        Rplidar 转速（A系列）：
        常规数据发布频率（周期）：
        Imu raw数据发布频率（周期）：默认200hz 可能要快，看时间戳， 
    */

    int serial_baudrate = 1000000;  // 串口波特率，默认为 115200
    
    
    ros::NodeHandle nh;  // 创建ROS节点句柄
    // 1. 创建订阅器，订阅速度话题
    ros::Subscriber velocitySub = nh.subscribe("cmd_vel", 1000, velocityCallback);

    // // 2. 创建发布器，发布Deadreckon航位推算数据
    // ros::Publisher deadreckonPub = nh.advertise<robot_chassis::Deadreckon>("deadreckon", 1000);
    // 2. 发布 odom 信息
    ros::Publisher odomPub = nh.advertise<nav_msgs::Odometry>("odom", 1000);
    // 发布底盘速度
    ros::Publisher velPub = nh.advertise<geometry_msgs::Twist>("robot_vel", 1000);
    // 发布 Imu
    ros::Publisher ImuPub = nh.advertise<sensor_msgs::Imu>("imu_raw_data", 1000);

    ros::Publisher PImuPub = nh.advertise<sensor_msgs::Imu>("PImu", 1000);




    // 服务1：获取 电量 和 电池状态
    ros::ServiceServer battery_server = nh.advertiseService("Battery",Battery_Req);
    // 服务2： 获取 健康 信息
    ros::ServiceServer health_info_server = nh.advertiseService("Health_Info",Health_Info_Req);




    ros::NodeHandle nh_private("~");  // 私有节点句柄，用于获取私有命名空间下的参数
    // 获取参数 "channel_type" 的值，并将其存储在变量 channel_type 中。如果没有指定该参数，则使用默认值 "serial"
    
    
    // 获取 CHASSIS SDK 的版本号的主版本、次版本和修订版本
    int ver_major = SL_CHASSIS_SDK_VERSION_MAJOR;
    int ver_minor = SL_CHASSIS_SDK_VERSION_MINOR;
    int ver_patch = SL_CHASSIS_SDK_VERSION_PATCH;   
    // 使用 ROS 日志功能输出包含 BASE SDK 版本号的信息
    ROS_INFO("chassis running on ROS package chassis_ros, SDK Version:%d.%d.%d",ver_major,ver_minor,ver_patch);


    sl_result  op_result;




    // 这边创建两个 _channel 实现 base cp0 通道分别创建
    // 类 "IBaseDriver""ICp0Driver"  "connect", 注释掉了
    
    // 1. base
    drv1 = *createBaseDriver();
    IChannel* _channel1;
    _channel1 = *createUSBChannel(64719, 61696, 2, 4, 4);


    // 尝试通过指针 drv 指向的对象调用 connect 函数来连接到 base
    // 如果连接失败，根据通信通道类型输出相应的错误信息，并释放驱动程序实例的内存，然后返回错误码 -1
    if (SL_IS_FAIL((drv1)->connect(_channel1))) {
        ROS_ERROR("Error, cannot connect to base");
        delete drv1;
        return -1;
    }


    // 2. cp0
    // 创建 ILidarDriver 类型的驱动程序实例，将其赋值给指针 drv 指向的对象
    // create the driver instance
    drv2 = *createCp0Driver();
    IChannel* _channel2;

    _channel2 = *createUSBChannel(64719, 61696, 3, 5, 5);
    
    // 尝试通过指针 drv 指向的对象调用 connect 函数来连接
    // 如果连接失败，根据通信通道类型输出相应的错误信息，并释放驱动程序实例的内存，然后返回错误码 -1
    if (SL_IS_FAIL((drv2)->connect(_channel2))) {

        ROS_ERROR("Error, cannot connect to cp0.");
        delete drv2;
        return -1;
    }

    sl_cp0_set_lidar_baudrate_request_t baud;
    memset(&baud, 0, sizeof(baud));
    baud.baudrate = serial_baudrate;

    op_result = drv2->setLidarBaudrate(baud);
    if (SL_IS_FAIL(op_result))
    {

        ROS_ERROR("Error, cannot set cp0 <--> lidar baudrate %d.", serial_baudrate);
        delete drv2;
        return -1;
    }

    // 声明了用于记录扫描开始和结束时间的 ros::Time 类型变量
    ros::Time start_scan_time;
    ros::Time end_scan_time;
    // 声明了用于记录扫描持续时间的 double 类型变量
    double scan_duration;
 

    sl_chassis_deadreckon_response_t  odom_data;
    sl_imu_raw_data_t Imu_data;

    sl_cp0_read_imu_processed_request_t Imu_req;
    sl_cp0_read_imu_processed_response_t Imu_resp;


    // ROS主循环
    ros::Rate rate(50);  // 设置循环频率  note: 200Hz FOR imu
    while (ros::ok())
    {

        // 3. odom 信息
        // 获取 航位 > 组成odom  信息
        op_result = drv1->set_v_and_get_deadreckon(vel_data, odom_data);
        // ros::Time current_time = ros::Time::now();
        // double dt_test = (current_time - prev_time).toSec();
        // prev_time = current_time;

        // sl_chassis_set_velocity_request_t vel_data;


        if (SL_IS_FAIL(op_result))
        {
            ROS_ERROR("can not get deadreckon.\n");
        }

        publish_Odom(&odomPub, &velPub, odom_data);
    

        // 4. Imu 消息
        op_result = drv2->getImuRawData(Imu_data);
    
        if (SL_IS_FAIL(op_result))
        {
            ROS_ERROR("can not get Imu Raw Data.\n");
        }

        publish_Imu(&ImuPub, Imu_data);

        // 4. Imu Processed 消息
        op_result = drv2->set_motion_hit_and_get_imu_processed(Imu_req, Imu_resp);
    
        if (SL_IS_FAIL(op_result))
        {
            ROS_ERROR("can not get Imu Processed Data.\n");
        }

        publish_PImu(&PImuPub, Imu_resp);
        
        // 执行其他操作，例如发布其他消息

        ros::spinOnce();  // 处理回调函数
        rate.sleep();     // 控制循环频率
    }


    delete drv1;
    delete drv2;
    return 0;

}

