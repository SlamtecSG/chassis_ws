
"use strict";

let battery = require('./battery.js')
let test = require('./test.js')
let health_info = require('./health_info.js')

module.exports = {
  battery: battery,
  test: test,
  health_info: health_info,
};
