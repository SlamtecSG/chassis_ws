#!/usr/bin/env python

import rospy
from geometry_msgs.msg import Twist

class VelocitySmootherNode:
    def __init__(self):
        rospy.init_node('velocity_smoother_node', anonymous=True)

        self.rate = rospy.Rate(10)  
        self.smoothing_factor = 0.2  
        self.max_linear_change_rate = 0.1  
        self.max_angular_change_rate = 0.1  

        self.cmd_vel_sub = rospy.Subscriber('cmd_vel', Twist, self.cmd_vel_callback)
        self.smooth_cmd_vel_pub = rospy.Publisher('smooth_cmd_vel', Twist, queue_size=1)

        self.linear_vel = 0.0
        self.angular_vel = 0.0
        self.last_linear_vel = 0.0
        self.last_angular_vel = 0.0

    def cmd_vel_callback(self, msg):
        self.linear_vel = msg.linear.x
        self.angular_vel = msg.angular.z

    def run(self):
        while not rospy.is_shutdown():
            self.linear_vel = (1 - self.smoothing_factor) * self.linear_vel + self.smoothing_factor * self.last_linear_vel
            self.angular_vel = (1 - self.smoothing_factor) * self.angular_vel + self.smoothing_factor * self.last_angular_vel

            linear_change = self.linear_vel - self.last_linear_vel
            angular_change = self.angular_vel - self.last_angular_vel

            if abs(linear_change) > self.max_linear_change_rate:
                self.linear_vel = self.last_linear_vel + self.max_linear_change_rate * (linear_change / abs(linear_change))
            if abs(angular_change) > self.max_angular_change_rate:
                self.angular_vel = self.last_angular_vel + self.max_angular_change_rate * (angular_change / abs(angular_change))

            self.last_linear_vel = self.linear_vel
            self.last_angular_vel = self.angular_vel

            smooth_cmd_vel = Twist()
            smooth_cmd_vel.linear.x = self.linear_vel
            smooth_cmd_vel.angular.z = self.angular_vel
            self.smooth_cmd_vel_pub.publish(smooth_cmd_vel)

            self.rate.sleep()

if __name__ == '__main__':
    try:
        velocity_smoother_node = VelocitySmootherNode()
        velocity_smoother_node.run()
    except rospy.ROSInterruptException:
        pass
