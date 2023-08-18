; Auto-generated. Do not edit!


(cl:in-package chassis_ros-srv)


;//! \htmlinclude battery-request.msg.html

(cl:defclass <battery-request> (roslisp-msg-protocol:ros-message)
  ((num1
    :reader num1
    :initarg :num1
    :type cl:integer
    :initform 0))
)

(cl:defclass battery-request (<battery-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <battery-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'battery-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name chassis_ros-srv:<battery-request> is deprecated: use chassis_ros-srv:battery-request instead.")))

(cl:ensure-generic-function 'num1-val :lambda-list '(m))
(cl:defmethod num1-val ((m <battery-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:num1-val is deprecated.  Use chassis_ros-srv:num1 instead.")
  (num1 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <battery-request>) ostream)
  "Serializes a message object of type '<battery-request>"
  (cl:let* ((signed (cl:slot-value msg 'num1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <battery-request>) istream)
  "Deserializes a message object of type '<battery-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<battery-request>)))
  "Returns string type for a service object of type '<battery-request>"
  "chassis_ros/batteryRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'battery-request)))
  "Returns string type for a service object of type 'battery-request"
  "chassis_ros/batteryRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<battery-request>)))
  "Returns md5sum for a message object of type '<battery-request>"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'battery-request)))
  "Returns md5sum for a message object of type 'battery-request"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<battery-request>)))
  "Returns full string definition for message of type '<battery-request>"
  (cl:format cl:nil "# 电池状态 服务~%# 客户端请求时发送~%int32 num1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'battery-request)))
  "Returns full string definition for message of type 'battery-request"
  (cl:format cl:nil "# 电池状态 服务~%# 客户端请求时发送~%int32 num1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <battery-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <battery-request>))
  "Converts a ROS message object to a list"
  (cl:list 'battery-request
    (cl:cons ':num1 (num1 msg))
))
;//! \htmlinclude battery-response.msg.html

(cl:defclass <battery-response> (roslisp-msg-protocol:ros-message)
  ((battery_percentage
    :reader battery_percentage
    :initarg :battery_percentage
    :type cl:integer
    :initform 0)
   (battery_status
    :reader battery_status
    :initarg :battery_status
    :type cl:integer
    :initform 0))
)

(cl:defclass battery-response (<battery-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <battery-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'battery-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name chassis_ros-srv:<battery-response> is deprecated: use chassis_ros-srv:battery-response instead.")))

(cl:ensure-generic-function 'battery_percentage-val :lambda-list '(m))
(cl:defmethod battery_percentage-val ((m <battery-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:battery_percentage-val is deprecated.  Use chassis_ros-srv:battery_percentage instead.")
  (battery_percentage m))

(cl:ensure-generic-function 'battery_status-val :lambda-list '(m))
(cl:defmethod battery_status-val ((m <battery-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:battery_status-val is deprecated.  Use chassis_ros-srv:battery_status instead.")
  (battery_status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <battery-response>) ostream)
  "Serializes a message object of type '<battery-response>"
  (cl:let* ((signed (cl:slot-value msg 'battery_percentage)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'battery_status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <battery-response>) istream)
  "Deserializes a message object of type '<battery-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'battery_percentage) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'battery_status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<battery-response>)))
  "Returns string type for a service object of type '<battery-response>"
  "chassis_ros/batteryResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'battery-response)))
  "Returns string type for a service object of type 'battery-response"
  "chassis_ros/batteryResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<battery-response>)))
  "Returns md5sum for a message object of type '<battery-response>"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'battery-response)))
  "Returns md5sum for a message object of type 'battery-response"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<battery-response>)))
  "Returns full string definition for message of type '<battery-response>"
  (cl:format cl:nil "# 服务器响应发送的数据~%int32 battery_percentage~%int32 battery_status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'battery-response)))
  "Returns full string definition for message of type 'battery-response"
  (cl:format cl:nil "# 服务器响应发送的数据~%int32 battery_percentage~%int32 battery_status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <battery-response>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <battery-response>))
  "Converts a ROS message object to a list"
  (cl:list 'battery-response
    (cl:cons ':battery_percentage (battery_percentage msg))
    (cl:cons ':battery_status (battery_status msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'battery)))
  'battery-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'battery)))
  'battery-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'battery)))
  "Returns string type for a service object of type '<battery>"
  "chassis_ros/battery")