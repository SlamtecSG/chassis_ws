; Auto-generated. Do not edit!


(cl:in-package chassis_ros-srv)


;//! \htmlinclude test-request.msg.html

(cl:defclass <test-request> (roslisp-msg-protocol:ros-message)
  ((num1
    :reader num1
    :initarg :num1
    :type cl:integer
    :initform 0))
)

(cl:defclass test-request (<test-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <test-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'test-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name chassis_ros-srv:<test-request> is deprecated: use chassis_ros-srv:test-request instead.")))

(cl:ensure-generic-function 'num1-val :lambda-list '(m))
(cl:defmethod num1-val ((m <test-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:num1-val is deprecated.  Use chassis_ros-srv:num1 instead.")
  (num1 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <test-request>) ostream)
  "Serializes a message object of type '<test-request>"
  (cl:let* ((signed (cl:slot-value msg 'num1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <test-request>) istream)
  "Deserializes a message object of type '<test-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<test-request>)))
  "Returns string type for a service object of type '<test-request>"
  "chassis_ros/testRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'test-request)))
  "Returns string type for a service object of type 'test-request"
  "chassis_ros/testRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<test-request>)))
  "Returns md5sum for a message object of type '<test-request>"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'test-request)))
  "Returns md5sum for a message object of type 'test-request"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<test-request>)))
  "Returns full string definition for message of type '<test-request>"
  (cl:format cl:nil "# 电池状态 服务~%# 客户端请求时发送~%int32 num1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'test-request)))
  "Returns full string definition for message of type 'test-request"
  (cl:format cl:nil "# 电池状态 服务~%# 客户端请求时发送~%int32 num1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <test-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <test-request>))
  "Converts a ROS message object to a list"
  (cl:list 'test-request
    (cl:cons ':num1 (num1 msg))
))
;//! \htmlinclude test-response.msg.html

(cl:defclass <test-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass test-response (<test-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <test-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'test-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name chassis_ros-srv:<test-response> is deprecated: use chassis_ros-srv:test-response instead.")))

(cl:ensure-generic-function 'battery_percentage-val :lambda-list '(m))
(cl:defmethod battery_percentage-val ((m <test-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:battery_percentage-val is deprecated.  Use chassis_ros-srv:battery_percentage instead.")
  (battery_percentage m))

(cl:ensure-generic-function 'battery_status-val :lambda-list '(m))
(cl:defmethod battery_status-val ((m <test-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader chassis_ros-srv:battery_status-val is deprecated.  Use chassis_ros-srv:battery_status instead.")
  (battery_status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <test-response>) ostream)
  "Serializes a message object of type '<test-response>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <test-response>) istream)
  "Deserializes a message object of type '<test-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<test-response>)))
  "Returns string type for a service object of type '<test-response>"
  "chassis_ros/testResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'test-response)))
  "Returns string type for a service object of type 'test-response"
  "chassis_ros/testResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<test-response>)))
  "Returns md5sum for a message object of type '<test-response>"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'test-response)))
  "Returns md5sum for a message object of type 'test-response"
  "b57d716f787aff42a104de42df410317")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<test-response>)))
  "Returns full string definition for message of type '<test-response>"
  (cl:format cl:nil "# 服务器响应发送的数据~%int32 battery_percentage~%int32 battery_status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'test-response)))
  "Returns full string definition for message of type 'test-response"
  (cl:format cl:nil "# 服务器响应发送的数据~%int32 battery_percentage~%int32 battery_status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <test-response>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <test-response>))
  "Converts a ROS message object to a list"
  (cl:list 'test-response
    (cl:cons ':battery_percentage (battery_percentage msg))
    (cl:cons ':battery_status (battery_status msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'test)))
  'test-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'test)))
  'test-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'test)))
  "Returns string type for a service object of type '<test>"
  "chassis_ros/test")