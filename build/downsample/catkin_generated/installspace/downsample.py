#!/usr/bin/env python2
import rospy
from sensor_msgs.msg import LaserScan

def downsample_scan(original_scan, target_points):
    if len(original_scan.ranges) <= target_points:
        return original_scan

    step_size = len(original_scan.ranges) // target_points

    downsampled_ranges = original_scan.ranges[::step_size]
    downsampled_scan = LaserScan(
        header=original_scan.header,
        angle_min=original_scan.angle_min,
        angle_max=original_scan.angle_max,
        angle_increment=original_scan.angle_increment * step_size,
        time_increment=original_scan.time_increment * step_size,
        scan_time=original_scan.scan_time,
        range_min=original_scan.range_min,
        range_max=original_scan.range_max,
        ranges=downsampled_ranges,
        intensities=original_scan.intensities[::step_size] if original_scan.intensities else []
    )

    return downsampled_scan

def scan_callback(scan_data):
    target_points = 1440

    downsampled_scan = downsample_scan(scan_data, target_points)

    downsampled_pub.publish(downsampled_scan)

if __name__ == '__main__':
    rospy.init_node('scan_downsampler')

    scan_sub = rospy.Subscriber('/scan_filtered', LaserScan, scan_callback)

    downsampled_pub = rospy.Publisher('/scan_downsampled', LaserScan, queue_size=10)

    rospy.spin()