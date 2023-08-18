;; Auto-generated. Do not edit!


(when (boundp 'chassis_ros::battery)
  (if (not (find-package "CHASSIS_ROS"))
    (make-package "CHASSIS_ROS"))
  (shadow 'battery (find-package "CHASSIS_ROS")))
(unless (find-package "CHASSIS_ROS::BATTERY")
  (make-package "CHASSIS_ROS::BATTERY"))
(unless (find-package "CHASSIS_ROS::BATTERYREQUEST")
  (make-package "CHASSIS_ROS::BATTERYREQUEST"))
(unless (find-package "CHASSIS_ROS::BATTERYRESPONSE")
  (make-package "CHASSIS_ROS::BATTERYRESPONSE"))

(in-package "ROS")





(defclass chassis_ros::batteryRequest
  :super ros::object
  :slots (_num1 ))

(defmethod chassis_ros::batteryRequest
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

(defclass chassis_ros::batteryResponse
  :super ros::object
  :slots (_battery_percentage _battery_status ))

(defmethod chassis_ros::batteryResponse
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

(defclass chassis_ros::battery
  :super ros::object
  :slots ())

(setf (get chassis_ros::battery :md5sum-) "b57d716f787aff42a104de42df410317")
(setf (get chassis_ros::battery :datatype-) "chassis_ros/battery")
(setf (get chassis_ros::battery :request) chassis_ros::batteryRequest)
(setf (get chassis_ros::battery :response) chassis_ros::batteryResponse)

(defmethod chassis_ros::batteryRequest
  (:response () (instance chassis_ros::batteryResponse :init)))

(setf (get chassis_ros::batteryRequest :md5sum-) "b57d716f787aff42a104de42df410317")
(setf (get chassis_ros::batteryRequest :datatype-) "chassis_ros/batteryRequest")
(setf (get chassis_ros::batteryRequest :definition-)
      "# 电池状态 服务
# 客户端请求时发送
int32 num1
---
# 服务器响应发送的数据
int32 battery_percentage
int32 battery_status
")

(setf (get chassis_ros::batteryResponse :md5sum-) "b57d716f787aff42a104de42df410317")
(setf (get chassis_ros::batteryResponse :datatype-) "chassis_ros/batteryResponse")
(setf (get chassis_ros::batteryResponse :definition-)
      "# 电池状态 服务
# 客户端请求时发送
int32 num1
---
# 服务器响应发送的数据
int32 battery_percentage
int32 battery_status
")



(provide :chassis_ros/battery "b57d716f787aff42a104de42df410317")


