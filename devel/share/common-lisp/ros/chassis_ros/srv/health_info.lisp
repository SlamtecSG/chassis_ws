; Auto-generated. Do not edit!


(cl:in-package chassis_ros-srv)


;//! \htmlinclude health_info-request.msg.html

(cl:defclass <health_info-request> (roslisp-msg-protocol:ros-message)
  ((num1
    :reader num1
    :initarg :num1
    :type cl:integer
    :initform 0))
)

(cl:defclass health_info-request (<health_info-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <health_info-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'health_info-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name chassis_ros-srv:<health_info-request> is deprecated: use chassis_ros-srv:health_info-request instead.")))

(cl:ensure-generic-function 'num1-val :lambda-list '(m))
(cl:defmethod num1-val ((m <health_info-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:num1-val is deprecated.  Use chassis_ros-srv:num1 instead.")
  (num1 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <health_info-request>) ostream)
  "Serializes a message object of type '<health_info-request>"
  (cl:let* ((signed (cl:slot-value msg 'num1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <health_info-request>) istream)
  "Deserializes a message object of type '<health_info-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<health_info-request>)))
  "Returns string type for a service object of type '<health_info-request>"
  "chassis_ros/health_infoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'health_info-request)))
  "Returns string type for a service object of type 'health_info-request"
  "chassis_ros/health_infoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<health_info-request>)))
  "Returns md5sum for a message object of type '<health_info-request>"
  "565180820d1c91abffd3fb243c7cf391")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'health_info-request)))
  "Returns md5sum for a message object of type 'health_info-request"
  "565180820d1c91abffd3fb243c7cf391")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<health_info-request>)))
  "Returns full string definition for message of type '<health_info-request>"
  (cl:format cl:nil "# 客户端请求时发送~%int32 num1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'health_info-request)))
  "Returns full string definition for message of type 'health_info-request"
  (cl:format cl:nil "# 客户端请求时发送~%int32 num1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <health_info-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <health_info-request>))
  "Converts a ROS message object to a list"
  (cl:list 'health_info-request
    (cl:cons ':num1 (num1 msg))
))
;//! \htmlinclude health_info-response.msg.html

(cl:defclass <health_info-response> (roslisp-msg-protocol:ros-message)
  ((health_flag
    :reader health_flag
    :initarg :health_flag
    :type cl:integer
    :initform 0)
   (error_count
    :reader error_count
    :initarg :error_count
    :type cl:integer
    :initform 0)
   (error_codes
    :reader error_codes
    :initarg :error_codes
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (error_msgs
    :reader error_msgs
    :initarg :error_msgs
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass health_info-response (<health_info-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <health_info-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'health_info-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name chassis_ros-srv:<health_info-response> is deprecated: use chassis_ros-srv:health_info-response instead.")))

(cl:ensure-generic-function 'health_flag-val :lambda-list '(m))
(cl:defmethod health_flag-val ((m <health_info-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:health_flag-val is deprecated.  Use chassis_ros-srv:health_flag instead.")
  (health_flag m))

(cl:ensure-generic-function 'error_count-val :lambda-list '(m))
(cl:defmethod error_count-val ((m <health_info-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:error_count-val is deprecated.  Use chassis_ros-srv:error_count instead.")
  (error_count m))

(cl:ensure-generic-function 'error_codes-val :lambda-list '(m))
(cl:defmethod error_codes-val ((m <health_info-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:error_codes-val is deprecated.  Use chassis_ros-srv:error_codes instead.")
  (error_codes m))

(cl:ensure-generic-function 'error_msgs-val :lambda-list '(m))
(cl:defmethod error_msgs-val ((m <health_info-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:error_msgs-val is deprecated.  Use chassis_ros-srv:error_msgs instead.")
  (error_msgs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <health_info-response>) ostream)
  "Serializes a message object of type '<health_info-response>"
  (cl:let* ((signed (cl:slot-value msg 'health_flag)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'error_count)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'error_codes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'error_codes))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'error_msgs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'error_msgs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <health_info-response>) istream)
  "Deserializes a message object of type '<health_info-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'health_flag) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error_count) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'error_codes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'error_codes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'error_msgs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'error_msgs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<health_info-response>)))
  "Returns string type for a service object of type '<health_info-response>"
  "chassis_ros/health_infoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'health_info-response)))
  "Returns string type for a service object of type 'health_info-response"
  "chassis_ros/health_infoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<health_info-response>)))
  "Returns md5sum for a message object of type '<health_info-response>"
  "565180820d1c91abffd3fb243c7cf391")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'health_info-response)))
  "Returns md5sum for a message object of type 'health_info-response"
  "565180820d1c91abffd3fb243c7cf391")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<health_info-response>)))
  "Returns full string definition for message of type '<health_info-response>"
  (cl:format cl:nil "# 服务器响应发送的数据~%int32 health_flag~%int32 error_count~%int32[] error_codes~%string[] error_msgs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'health_info-response)))
  "Returns full string definition for message of type 'health_info-response"
  (cl:format cl:nil "# 服务器响应发送的数据~%int32 health_flag~%int32 error_count~%int32[] error_codes~%string[] error_msgs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <health_info-response>))
  (cl:+ 0
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'error_codes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'error_msgs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <health_info-response>))
  "Converts a ROS message object to a list"
  (cl:list 'health_info-response
    (cl:cons ':health_flag (health_flag msg))
    (cl:cons ':error_count (error_count msg))
    (cl:cons ':error_codes (error_codes msg))
    (cl:cons ':error_msgs (error_msgs msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'health_info)))
  'health_info-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'health_info)))
  'health_info-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'health_info)))
  "Returns string type for a service object of type '<health_info>"
  "chassis_ros/health_info")