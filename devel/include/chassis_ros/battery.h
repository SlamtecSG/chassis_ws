// Generated by gencpp from file chassis_ros/battery.msg
// DO NOT EDIT!


#ifndef CHASSIS_ROS_MESSAGE_BATTERY_H
#define CHASSIS_ROS_MESSAGE_BATTERY_H

#include <ros/service_traits.h>


#include <chassis_ros/batteryRequest.h>
#include <chassis_ros/batteryResponse.h>


namespace chassis_ros
{

struct battery
{

typedef batteryRequest Request;
typedef batteryResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct battery
} // namespace chassis_ros


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::chassis_ros::battery > {
  static const char* value()
  {
    return "b57d716f787aff42a104de42df410317";
  }

  static const char* value(const ::chassis_ros::battery&) { return value(); }
};

template<>
struct DataType< ::chassis_ros::battery > {
  static const char* value()
  {
    return "chassis_ros/battery";
  }

  static const char* value(const ::chassis_ros::battery&) { return value(); }
};


// service_traits::MD5Sum< ::chassis_ros::batteryRequest> should match
// service_traits::MD5Sum< ::chassis_ros::battery >
template<>
struct MD5Sum< ::chassis_ros::batteryRequest>
{
  static const char* value()
  {
    return MD5Sum< ::chassis_ros::battery >::value();
  }
  static const char* value(const ::chassis_ros::batteryRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::chassis_ros::batteryRequest> should match
// service_traits::DataType< ::chassis_ros::battery >
template<>
struct DataType< ::chassis_ros::batteryRequest>
{
  static const char* value()
  {
    return DataType< ::chassis_ros::battery >::value();
  }
  static const char* value(const ::chassis_ros::batteryRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::chassis_ros::batteryResponse> should match
// service_traits::MD5Sum< ::chassis_ros::battery >
template<>
struct MD5Sum< ::chassis_ros::batteryResponse>
{
  static const char* value()
  {
    return MD5Sum< ::chassis_ros::battery >::value();
  }
  static const char* value(const ::chassis_ros::batteryResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::chassis_ros::batteryResponse> should match
// service_traits::DataType< ::chassis_ros::battery >
template<>
struct DataType< ::chassis_ros::batteryResponse>
{
  static const char* value()
  {
    return DataType< ::chassis_ros::battery >::value();
  }
  static const char* value(const ::chassis_ros::batteryResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // CHASSIS_ROS_MESSAGE_BATTERY_H
