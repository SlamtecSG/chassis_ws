// Auto-generated. Do not edit!

// (in-package chassis_ros.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class testRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.num1 = null;
    }
    else {
      if (initObj.hasOwnProperty('num1')) {
        this.num1 = initObj.num1
      }
      else {
        this.num1 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type testRequest
    // Serialize message field [num1]
    bufferOffset = _serializer.int32(obj.num1, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type testRequest
    let len;
    let data = new testRequest(null);
    // Deserialize message field [num1]
    data.num1 = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'chassis_ros/testRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8ebc68ae8e22b48f76a983ce033a6149';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 电池状态 服务
    # 客户端请求时发送
    int32 num1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new testRequest(null);
    if (msg.num1 !== undefined) {
      resolved.num1 = msg.num1;
    }
    else {
      resolved.num1 = 0
    }

    return resolved;
    }
};

class testResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.battery_percentage = null;
      this.battery_status = null;
    }
    else {
      if (initObj.hasOwnProperty('battery_percentage')) {
        this.battery_percentage = initObj.battery_percentage
      }
      else {
        this.battery_percentage = 0;
      }
      if (initObj.hasOwnProperty('battery_status')) {
        this.battery_status = initObj.battery_status
      }
      else {
        this.battery_status = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type testResponse
    // Serialize message field [battery_percentage]
    bufferOffset = _serializer.int32(obj.battery_percentage, buffer, bufferOffset);
    // Serialize message field [battery_status]
    bufferOffset = _serializer.int32(obj.battery_status, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type testResponse
    let len;
    let data = new testResponse(null);
    // Deserialize message field [battery_percentage]
    data.battery_percentage = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [battery_status]
    data.battery_status = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'chassis_ros/testResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b6fbe9033580990101a748eb87aa0234';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 服务器响应发送的数据
    int32 battery_percentage
    int32 battery_status
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new testResponse(null);
    if (msg.battery_percentage !== undefined) {
      resolved.battery_percentage = msg.battery_percentage;
    }
    else {
      resolved.battery_percentage = 0
    }

    if (msg.battery_status !== undefined) {
      resolved.battery_status = msg.battery_status;
    }
    else {
      resolved.battery_status = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: testRequest,
  Response: testResponse,
  md5sum() { return 'b57d716f787aff42a104de42df410317'; },
  datatype() { return 'chassis_ros/test'; }
};
