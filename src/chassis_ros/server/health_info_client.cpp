// 1.包含头文件
#include "ros/ros.h"
#include "chassis_ros/health_info.h"


int main(int argc, char *argv[])
{
    setlocale(LC_ALL,"");

    // // 调用时动态传值,如果通过 launch 的 args 传参，需要传递的参数个数 +3
    // if (argc != 3)
    // // if (argc != 5)//launch 传参(0-文件路径 1传入的参数 2传入的参数 3节点名称 4日志路径)
    // {
    //     ROS_ERROR("请提交两个整数");
    //     return 1;
    // }


    // 2.初始化 ROS 节点
    ros::init(argc,argv,"Health_Info");
    // 3.创建 ROS 句柄
    ros::NodeHandle nh;
    // 4.创建 客户端 对象
    ros::ServiceClient health_info_client = nh.serviceClient<chassis_ros::health_info>("Health_Info");
    //等待服务启动成功
    //方式1
    ros::service::waitForService("Health_Info");
    //方式2
    // client.waitForExistence();
    // 5.组织请求数据
    chassis_ros::health_info health_info_srv;
    health_info_srv.request.num1 = 0;
    // ai.request.num1 = atoi(argv[1]);
    // ai.request.num2 = atoi(argv[2]);
    // 6.发送请求,返回 bool 值，标记是否成功
    if (health_info_client.call(health_info_srv))
    {
        ROS_INFO("health flag = %d ", health_info_srv.response.health_flag);
        ROS_INFO("error count = %d ", health_info_srv.response.error_count);

        for (size_t i = 0; i < health_info_srv.response.error_codes.size(); ++i)
        {
            ROS_INFO("error code[%zu] = %d", i, health_info_srv.response.error_codes[i]);
            ROS_INFO("error msg[%zu] = %s", i, health_info_srv.response.error_msgs[i].c_str());
        }

      
    }
    else
    {
        ROS_ERROR("service error....");
        return 1;
    }


    return 0;
}
