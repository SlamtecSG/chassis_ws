;; Auto-generated. Do not edit!


(when (boundp 'chassis_ros::health_info)
  (if (not (find-package "CHASSIS_ROS"))
    (make-package "CHASSIS_ROS"))
  (shadow 'health_info (find-package "CHASSIS_ROS")))
(unless (find-package "CHASSIS_ROS::HEALTH_INFO")
  (make-package "CHASSIS_ROS::HEALTH_INFO"))
(unless (find-package "CHASSIS_ROS::HEALTH_INFOREQUEST")
  (make-package "CHASSIS_ROS::HEALTH_INFOREQUEST"))
(unless (find-package "CHASSIS_ROS::HEALTH_INFORESPONSE")
  (make-package "CHASSIS_ROS::HEALTH_INFORESPONSE"))

(in-package "ROS")





(defclass chassis_ros::health_infoRequest
  :super ros::object
  :slots (_num1 ))

(defmethod chassis_ros::health_infoRequest
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

(defclass chassis_ros::health_infoResponse
  :super ros::object
  :slots (_health_flag _error_count _error_codes _error_msgs ))

(defmethod chassis_ros::health_infoResponse
  (:init
   (&key
    ((:health_flag __health_flag) 0)
    ((:error_count __error_count) 0)
    ((:error_codes __error_codes) (make-array 0 :initial-element 0 :element-type :integer))
    ((:error_msgs __error_msgs) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _health_flag (round __health_flag))
   (setq _error_count (round __error_count))
   (setq _error_codes __error_codes)
   (setq _error_msgs __error_msgs)
   self)
  (:health_flag
   (&optional __health_flag)
   (if __health_flag (setq _health_flag __health_flag)) _health_flag)
  (:error_count
   (&optional __error_count)
   (if __error_count (setq _error_count __error_count)) _error_count)
  (:error_codes
   (&optional __error_codes)
   (if __error_codes (setq _error_codes __error_codes)) _error_codes)
  (:error_msgs
   (&optional __error_msgs)
   (if __error_msgs (setq _error_msgs __error_msgs)) _error_msgs)
  (:serialization-length
   ()
   (+
    ;; int32 _health_flag
    4
    ;; int32 _error_count
    4
    ;; int32[] _error_codes
    (* 4    (length _error_codes)) 4
    ;; string[] _error_msgs
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _error_msgs)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _health_flag
       (write-long _health_flag s)
     ;; int32 _error_count
       (write-long _error_count s)
     ;; int32[] _error_codes
     (write-long (length _error_codes) s)
     (dotimes (i (length _error_codes))
       (write-long (elt _error_codes i) s)
       )
     ;; string[] _error_msgs
     (write-long (length _error_msgs) s)
     (dolist (elem _error_msgs)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _health_flag
     (setq _health_flag (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _error_count
     (setq _error_count (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _error_codes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _error_codes (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _error_codes i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; string[] _error_msgs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _error_msgs (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _error_msgs i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass chassis_ros::health_info
  :super ros::object
  :slots ())

(setf (get chassis_ros::health_info :md5sum-) "565180820d1c91abffd3fb243c7cf391")
(setf (get chassis_ros::health_info :datatype-) "chassis_ros/health_info")
(setf (get chassis_ros::health_info :request) chassis_ros::health_infoRequest)
(setf (get chassis_ros::health_info :response) chassis_ros::health_infoResponse)

(defmethod chassis_ros::health_infoRequest
  (:response () (instance chassis_ros::health_infoResponse :init)))

(setf (get chassis_ros::health_infoRequest :md5sum-) "565180820d1c91abffd3fb243c7cf391")
(setf (get chassis_ros::health_infoRequest :datatype-) "chassis_ros/health_infoRequest")
(setf (get chassis_ros::health_infoRequest :definition-)
      "# 客户端请求时发送
int32 num1
---
# 服务器响应发送的数据
int32 health_flag
int32 error_count
int32[] error_codes
string[] error_msgs
")

(setf (get chassis_ros::health_infoResponse :md5sum-) "565180820d1c91abffd3fb243c7cf391")
(setf (get chassis_ros::health_infoResponse :datatype-) "chassis_ros/health_infoResponse")
(setf (get chassis_ros::health_infoResponse :definition-)
      "# 客户端请求时发送
int32 num1
---
# 服务器响应发送的数据
int32 health_flag
int32 error_count
int32[] error_codes
string[] error_msgs
")



(provide :chassis_ros/health_info "565180820d1c91abffd3fb243c7cf391")


