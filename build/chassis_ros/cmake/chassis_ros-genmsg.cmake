# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "chassis_ros: 0 messages, 3 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(chassis_ros_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv" NAME_WE)
add_custom_target(_chassis_ros_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "chassis_ros" "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv" ""
)

get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv" NAME_WE)
add_custom_target(_chassis_ros_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "chassis_ros" "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv" ""
)

get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv" NAME_WE)
add_custom_target(_chassis_ros_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "chassis_ros" "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/chassis_ros
)
_generate_srv_cpp(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/chassis_ros
)
_generate_srv_cpp(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/chassis_ros
)

### Generating Module File
_generate_module_cpp(chassis_ros
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/chassis_ros
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(chassis_ros_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(chassis_ros_generate_messages chassis_ros_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_cpp _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_cpp _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_cpp _chassis_ros_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(chassis_ros_gencpp)
add_dependencies(chassis_ros_gencpp chassis_ros_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS chassis_ros_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/chassis_ros
)
_generate_srv_eus(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/chassis_ros
)
_generate_srv_eus(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/chassis_ros
)

### Generating Module File
_generate_module_eus(chassis_ros
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/chassis_ros
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(chassis_ros_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(chassis_ros_generate_messages chassis_ros_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_eus _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_eus _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_eus _chassis_ros_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(chassis_ros_geneus)
add_dependencies(chassis_ros_geneus chassis_ros_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS chassis_ros_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/chassis_ros
)
_generate_srv_lisp(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/chassis_ros
)
_generate_srv_lisp(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/chassis_ros
)

### Generating Module File
_generate_module_lisp(chassis_ros
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/chassis_ros
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(chassis_ros_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(chassis_ros_generate_messages chassis_ros_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_lisp _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_lisp _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_lisp _chassis_ros_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(chassis_ros_genlisp)
add_dependencies(chassis_ros_genlisp chassis_ros_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS chassis_ros_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/chassis_ros
)
_generate_srv_nodejs(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/chassis_ros
)
_generate_srv_nodejs(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/chassis_ros
)

### Generating Module File
_generate_module_nodejs(chassis_ros
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/chassis_ros
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(chassis_ros_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(chassis_ros_generate_messages chassis_ros_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_nodejs _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_nodejs _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_nodejs _chassis_ros_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(chassis_ros_gennodejs)
add_dependencies(chassis_ros_gennodejs chassis_ros_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS chassis_ros_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/chassis_ros
)
_generate_srv_py(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/chassis_ros
)
_generate_srv_py(chassis_ros
  "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/chassis_ros
)

### Generating Module File
_generate_module_py(chassis_ros
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/chassis_ros
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(chassis_ros_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(chassis_ros_generate_messages chassis_ros_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/health_info.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_py _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/test.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_py _chassis_ros_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/slamtec/chassis_ws/src/chassis_ros/srv/battery.srv" NAME_WE)
add_dependencies(chassis_ros_generate_messages_py _chassis_ros_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(chassis_ros_genpy)
add_dependencies(chassis_ros_genpy chassis_ros_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS chassis_ros_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/chassis_ros)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/chassis_ros
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(chassis_ros_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/chassis_ros)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/chassis_ros
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(chassis_ros_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/chassis_ros)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/chassis_ros
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(chassis_ros_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/chassis_ros)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/chassis_ros
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(chassis_ros_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/chassis_ros)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/chassis_ros\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/chassis_ros
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(chassis_ros_generate_messages_py std_msgs_generate_messages_py)
endif()
