#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <nav_msgs/Odometry.h>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>

#include <sensor_msgs/LaserScan.h>
#include <sensor_msgs/Range.h>
#include <sensor_msgs/Imu.h>

#include <std_srvs/Empty.h>
#include "sl_chassis.h"
#include "sl_chassis_driver.h"


// 定义了 RAD2DEG 宏，用于将弧度转换为角度
#define DEG2RAD(x) ((x)*M_PI / 180)

// 使用了sl命名空间
using namespace sl;

// 声明指针变量并将其初始化为NULL
IBaseDriver * drv1 = NULL;
ICp0Driver * drv2 = NULL;


 

// 1. 回调函数，用于处理速度话题的数据
void velocityCallback(const geometry_msgs::Twist::ConstPtr& msg)
{
    ROS_INFO("Received velocity message");
    sl_chassis_deadreckon_response_t  odom_data;
    sl_chassis_set_velocity_request_t vel_data; 
    sl_result  op_result;

    vel_data.velocity_x_q16 = msg->linear.x * 65536.0 ;
    vel_data.velocity_y_q16 = msg->linear.y * 65536.0;
    vel_data.angular_velocity_q16 = msg->angular.z * 65536.0;
    
    ROS_INFO("Received velocity message: %f, %hx", msg->linear.x, vel_data.velocity_x_q16);
    op_result = drv1->set_v_and_get_deadreckon(vel_data, odom_data);
    
    if (SL_IS_FAIL(op_result))
        {
            ROS_ERROR("can not set vel .\n");
        }
}

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


    ros::NodeHandle nh_private("~");  // 私有节点句柄，用于获取私有命名空间下的参数
    // 获取参数 "channel_type" 的值，并将其存储在变量 channel_type 中。如果没有指定该参数，则使用默认值 "serial"
    
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
 


    ros::spin();  // 处理回调函数


    delete drv1;
    delete drv2;
    return 0;

}
