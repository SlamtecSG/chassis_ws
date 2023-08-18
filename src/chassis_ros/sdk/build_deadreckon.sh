#!/bin/bash

g++ deakreckon_test.cpp -no-pie -o deakreckon_test -lsl_chassis_sdk -lusb-1.0 -lpthread -Loutput/Linux/Release/ -Lsrc/hal/usb/libusb/lib/ -std=c++11 -ggdb
