cmake_minimum_required(VERSION 3.0.2)
project(chassis_ros)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)


set(CHASSIS_SDK_PATH "./sdk/")  # 设置 SDK_PATH 变量，指定 SDK 的路径
set(CMAKE_BUILD_TYPE "Release") # 设置构建类型为 Release。
set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}") # 设置 C++ 编译标志，包括使用 C++11 标准

# 使用文件通配符匹配方式，将  SDK 中的源文件添加到 SDK_SRC 变量中
FILE(GLOB CHASSIS_SDK_SRC 
  "${CHASSIS_SDK_PATH}/src/arch/linux/*.cpp"
  "${CHASSIS_SDK_PATH}/src/hal/*.cpp"
  "${CHASSIS_SDK_PATH}/src/*.cpp"
)



find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  nav_msgs
  rosconsole
  roscpp
  rospy
  sensor_msgs
  std_msgs
  tf2
  tf2_ros
  tf2_geometry_msgs
  message_generation
)
add_service_files(
  FILES
  battery.srv
  health_info.srv
)
generate_messages(
  DEPENDENCIES
  std_msgs
)

# 包含所需的头文件路径，包括  SDK 的 include 目录、src 目录和 catkin 包的 include 目录
include_directories(
  ${CHASSIS_SDK_PATH}/include
  ${CHASSIS_SDK_PATH}/src
  ${catkin_INCLUDE_DIRS}
)




find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBUSB REQUIRED libusb-1.0)
include_directories(${LIBUSB_INCLUDE_DIRS})
link_directories(${LIBUSB_LIBRARY_DIRS})






# 声明当前包是一个 catkin 包
catkin_package()

# 定义一个可执行文件，包括 src/chassis_node.cpp 和 CHASSIS_SDK的源文件
add_executable(chassis_node src/chassis_node.cpp ${CHASSIS_SDK_SRC})
add_executable(battery_client server/battery_client.cpp ${CHASSIS_SDK_SRC})
add_executable(health_info_client server/health_info_client.cpp)

# add_dependencies(chassis_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})



## Specify libraries to link a library or executable target against
target_link_libraries(chassis_node
  ${catkin_LIBRARIES}
  ${LIBUSB_LIBRARIES}
)

target_link_libraries(battery_client
${catkin_LIBRARIES}
${LIBUSB_LIBRARIES}
)

target_link_libraries(health_info_client
${catkin_LIBRARIES}
${LIBUSB_LIBRARIES}
)

# 安装目标文件，包括 Node  可执行文件，安装到适当的目录
install(TARGETS chassis_node
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# 安装目录，包括 launch、rviz 和 sdk 目录，将它们复制到适当的目录
install(DIRECTORY launch rviz sdk
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  USE_SOURCE_PERMISSIONS
)
