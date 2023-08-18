RPLIDAR Public SDK v0.1.0 Release Note
======================================
## init release
### support features
- please refer to sl_chassis_driver.h

### known issues
- Currently use synchronous device I/O interface of libusb, only wait const number bytet to read, so far this SDK api didn't supprot interchip pkt fail answers
- the write / read data have more delay period during communication

### improvement in the feature
- Use asynchronous device I/O interface to support variable answer data and less delay during communication
