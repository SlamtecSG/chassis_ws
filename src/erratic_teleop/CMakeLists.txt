cmake_minimum_required(VERSION 2.8.3)
project(erratic_teleop)


find_package(catkin REQUIRED COMPONENTS
  nav_msgs
  roscpp
  rospy
  rosconsole
  std_msgs
  tf
)


catkin_package()


include_directories(${catkin_INCLUDE_DIRS})
include_directories(src)

set(SRC
src/keyboard.cpp
)

add_executable(erratic_keyboard_teleop ${SRC})
target_link_libraries(erratic_keyboard_teleop boost_thread ${catkin_LIBRARIES})



