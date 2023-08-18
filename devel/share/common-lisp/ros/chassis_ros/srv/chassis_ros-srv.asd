
(cl:in-package :asdf)

(defsystem "chassis_ros-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "battery" :depends-on ("_package_battery"))
    (:file "_package_battery" :depends-on ("_package"))
    (:file "health_info" :depends-on ("_package_health_info"))
    (:file "_package_health_info" :depends-on ("_package"))
  ))