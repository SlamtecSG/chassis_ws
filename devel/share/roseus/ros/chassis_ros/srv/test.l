;; Auto-generated. Do not edit!


(when (boundp 'chassis_ros::test)
  (if (not (find-package "CHASSIS_ROS"))
    (make-package "CHASSIS_ROS"))
  (shadow 'test (find-package "CHASSIS_ROS")))
(unless (find-package "CHASSIS_ROS::TEST")
  (make-package "CHASSIS_ROS::TEST"))
(unless (find-package "CHASSIS_ROS::TESTREQUEST")
  (make-package "CHASSIS_ROS::TESTREQUEST"))
(unless (find-package "CHASSIS_ROS::TESTRESPONSE")
  (make-package "CHASSIS_ROS::TESTRESPONSE"))

(in-package "ROS")





(defclass chassis_ros::testRequest
  :super ros::object
  :slots (_num1 ))

(defmethod chassis_ros::testRequest
  (:init
   (&key
    ((:num1 __num1) 0)
    )
   (send-super :init)
   (setq _num1 (round __num1))
   self)
  (:num1
   (&optional __num1)
   (if __num1 (setq _num1 __num1)) _num1)
  (:serialization-length
   ()
   (+
    ;; int32 _num1
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _num1
       (write-long _num1 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _num1
     (setq _num1 (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass chassis_ros::testResponse
  :super ros::object
  :slots (_battery_percentage _battery_status ))

(defmethod chassis_ros::testResponse
  (:init
   (&key
    ((:battery_percentage __battery_percentage) 0)
    ((:battery_status __battery_status) 0)
    )
   (send-super :init)
   (setq _battery_percentage (round __battery_percentage))
   (setq _battery_status (round __battery_status))
   self)
  (:battery_percentage
   (&optional __battery_percentage)
   (if __battery_percentage (setq _battery_percentage __battery_percentage)) _battery_percentage)
  (:battery_status
   (&optional __battery_status)
   (if __battery_status (setq _battery_status __battery_status)) _battery_status)
  (:serialization-length
   ()
   (+
    ;; int32 _battery_percentage
    4
    ;; int32 _battery_status
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _battery_percentage
       (write-long _battery_percentage s)
     ;; int32 _battery_status
       (write-long _battery_status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _battery_percentage
     (setq _battery_percentage (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _battery_status
     (setq _battery_status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass chassis_ros::test
  :super ros::object
  :slots ())

(setf (get chassis_ros::test :md5sum-) "b57d716f787aff42a104de42df410317")
(setf (get chassis_ros::test :datatype-) "chassis_ros/test")
(setf (get chassis_ros::test :request) chassis_ros::testRequest)
(setf (get chassis_ros::test :response) chassis_ros::testResponse)

(defmethod chassis_ros::testRequest
  (:response () (instance chassis_ros::testResponse :init)))

(setf (get chassis_ros::testRequest :md5sum-) "b57d716f787aff42a104de42df410317")
(setf (get chassis_ros::testRequest :datatype-) "chassis_ros/testRequest")
(setf (get chassis_ros::testRequest :definition-)
      "# 电池状态 服务
# 客户端请求时发送
int32 num1
---
# 服务器响应发送的数据
int32 battery_percentage
int32 battery_status
")

(setf (get chassis_ros::testResponse :md5sum-) "b57d716f787aff42a104de42df410317")
(setf (get chassis_ros::testResponse :datatype-) "chassis_ros/testResponse")
(setf (get chassis_ros::testResponse :definition-)
      "# 电池状态 服务
# 客户端请求时发送
int32 num1
---
# 服务器响应发送的数据
int32 battery_percentage
int32 battery_status
")



(provide :chassis_ros/test "b57d716f787aff42a104de42df410317")


