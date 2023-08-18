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

class health_infoRequest {
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
    // Serializes a message object of type health_infoRequest
    // Serialize message field [num1]
    bufferOffset = _serializer.int32(obj.num1, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type health_infoRequest
    let len;
    let data = new health_infoRequest(null);
    // Deserialize message field [num1]
    data.num1 = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'chassis_ros/health_infoRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8ebc68ae8e22b48f76a983ce033a6149';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 客户端请求时发送
    int32 num1
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new health_infoRequest(null);
    if (msg.num1 !== undefined) {
      resolved.num1 = msg.num1;
    }
    else {
      resolved.num1 = 0
    }

    return resolved;
    }
};

class health_infoResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.health_flag = null;
      this.error_count = null;
      this.error_codes = null;
      this.error_msgs = null;
    }
    else {
      if (initObj.hasOwnProperty('health_flag')) {
        this.health_flag = initObj.health_flag
      }
      else {
        this.health_flag = 0;
      }
      if (initObj.hasOwnProperty('error_count')) {
        this.error_count = initObj.error_count
      }
      else {
        this.error_count = 0;
      }
      if (initObj.hasOwnProperty('error_codes')) {
        this.error_codes = initObj.error_codes
      }
      else {
        this.error_codes = [];
      }
      if (initObj.hasOwnProperty('error_msgs')) {
        this.error_msgs = initObj.error_msgs
      }
      else {
        this.error_msgs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type health_infoResponse
    // Serialize message field [health_flag]
    bufferOffset = _serializer.int32(obj.health_flag, buffer, bufferOffset);
    // Serialize message field [error_count]
    bufferOffset = _serializer.int32(obj.error_count, buffer, bufferOffset);
    // Serialize message field [error_codes]
    bufferOffset = _arraySerializer.int32(obj.error_codes, buffer, bufferOffset, null);
    // Serialize message field [error_msgs]
    bufferOffset = _arraySerializer.string(obj.error_msgs, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type health_infoResponse
    let len;
    let data = new health_infoResponse(null);
    // Deserialize message field [health_flag]
    data.health_flag = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [error_count]
    data.error_count = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [error_codes]
    data.error_codes = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [error_msgs]
    data.error_msgs = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.error_codes.length;
    object.error_msgs.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 16;
  }

  static datatype() {
    // Returns string type for a service object
    return 'chassis_ros/health_infoResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '218741a7ad4b8cd149aa0179c433c775';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 服务器响应发送的数据
    int32 health_flag
    int32 error_count
    int32[] error_codes
    string[] error_msgs
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new health_infoResponse(null);
    if (msg.health_flag !== undefined) {
      resolved.health_flag = msg.health_flag;
    }
    else {
      resolved.health_flag = 0
    }

    if (msg.error_count !== undefined) {
      resolved.error_count = msg.error_count;
    }
    else {
      resolved.error_count = 0
    }

    if (msg.error_codes !== undefined) {
      resolved.error_codes = msg.error_codes;
    }
    else {
      resolved.error_codes = []
    }

    if (msg.error_msgs !== undefined) {
      resolved.error_msgs = msg.error_msgs;
    }
    else {
      resolved.error_msgs = []
    }

    return resolved;
    }
};

module.exports = {
  Request: health_infoRequest,
  Response: health_infoResponse,
  md5sum() { return '565180820d1c91abffd3fb243c7cf391'; },
  datatype() { return 'chassis_ros/health_info'; }
};
