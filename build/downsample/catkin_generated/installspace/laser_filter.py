#!/usr/bin/env python2
import rospy
from sensor_msgs.msg import LaserScan

class AngleBoundsFilter:
    def __init__(self):
        rospy.init_node('angle_bounds_filter')
        self.scan_sub = rospy.Subscriber('/scan', LaserScan, self.scan_callback)
        self.filtered_scan_pub = rospy.Publisher('/filtered_scan', LaserScan, queue_size=1)

        self.angle_bounds = [
            {"lower_angle": -2.86234, "upper_angle": -2.75762},
            {"lower_angle": -2.583087, "upper_angle": -1.466076},
            {"lower_angle": -1.134464, "upper_angle": 1.134464},
            {"lower_angle": 1.466077, "upper_angle": 2.583088},
            {"lower_angle": 2.75762, "upper_angle": 2.86234}
        ]

    def scan_callback(self, scan_msg):
        filtered_scan = LaserScan()
        filtered_scan.header = scan_msg.header
        filtered_scan.angle_min = scan_msg.angle_min
        filtered_scan.angle_max = scan_msg.angle_max
        filtered_scan.angle_increment = scan_msg.angle_increment
        filtered_scan.time_increment = scan_msg.time_increment
        filtered_scan.scan_time = scan_msg.scan_time
        filtered_scan.range_min = scan_msg.range_min
        filtered_scan.range_max = scan_msg.range_max

        for i, angle in enumerate(scan_msg.angle_min + i * scan_msg.angle_increment for i in range(len(scan_msg.ranges))):
            for bounds in self.angle_bounds:
                if bounds["lower_angle"] <= angle <= bounds["upper_angle"]:
                    filtered_scan.ranges.append(scan_msg.ranges[i])
                    break  # Only add the point once

        self.filtered_scan_pub.publish(filtered_scan)

if __name__ == '__main__':
    angle_bounds_filter = AngleBoundsFilter()
    rospy.spin()