#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "include/sl_chassis.h" 
#include "include/sl_chassis_driver.h"


using namespace sl;

int main(int argc, const char * argv[])
{
    sl_result   op_result;

#if 1
    //printf("1 \n");
    // create the driver instance
	IBaseDriver * drv = *createBaseDriver();

    //printf("2 \n");

    IChannel* _channel = *createUSBChannel(64719, 61696, 2, 4, 4);

    //printf("3 drv: %u channel :%u\n", drv, _channel);

    if (SL_IS_FAIL((drv)->connect(_channel)))
    {
        printf("can not open usb device.\n");
    }
    
#endif
        //printf("1 \n");
    // create the driver instance
	ICp0Driver * drv_cp0 = *createCp0Driver();

    //printf("2 \n");

    IChannel* _channel_cp0 = *createUSBChannel(64719, 61696, 3, 5, 5);

    //printf("3 drv: %u channel :%u\n", drv, _channel);

    if (SL_IS_FAIL((drv_cp0)->connect(_channel_cp0)))
    {
        printf("can not open usb device cp0.\n");
    }
    
    int loop = 1;
    if (argc > 1) 
    {
        loop = strtoul(argv[1], NULL, 10);
    }
    
    
    while(loop--)
    {
#if 0
        sl_chassis_set_velocity_request_t set_v;
        sl_chassis_deadreckon_response_t deadreckon;

        memset(&set_v, 0, sizeof(set_v));
        memset(&deadreckon, 0, sizeof(deadreckon));
        //printf("4 \n");
        op_result = drv->set_v_and_get_deadreckon(set_v, deadreckon);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get deadreckon.\n");
            break;
        }
        //printf("6 \n");
        printf("deadreckon: ts: %u dx: %d dy: %d dyaw: %d\n"
                    , deadreckon.timestamp
                    , deadreckon.base_dx_mm_q16>>16
                    , deadreckon.base_dy_mm_q16>>16
                    , deadreckon.base_dtheta_degree_q16>>16);
#endif
#if 0

        sl_chassis_base_device_info_t info;
        op_result = drv->getDeviceInfo(info);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get device info.\n");
            break;
        }
        
        // model
        char model[sizeof(info.model) + 1];
        memcpy(model, info.model, sizeof(info.model));
        model[sizeof(info.model)] = 0;
        printf("Model: %s\n", model);

        
        char suffix[sizeof(info.firmware_version_suffix) + 1];
        memcpy(suffix, info.firmware_version_suffix, sizeof(info.firmware_version_suffix));
        suffix[sizeof(info.firmware_version_suffix)] = 0;
        if (strlen(suffix) == 0)
        {
            memcpy(suffix, "xxx", sizeof("xxx"));
        }
        // firmware version
        printf("Firmware Version: %d.%d.%d_%s\n", info.firmware_version >> 8, info.firmware_version & 0xf0u, info.firmware_version & 0x0fu, suffix);

        // hardware version
        printf("Hardware version: %d.%d\n", info.hardware_version >> 8, info.hardware_version & 0xffu);

        // serial number
        size_t snStringLength = sizeof(info.serial_number) * 2;
        char* snString = new char[snStringLength + 1];

        for (size_t i = 0; i < (sizeof(info.serial_number)/sizeof(sl_u32)); i++)
        {
            sprintf(snString + i * (sizeof(sl_u32)*2), "%08X", info.serial_number[i]);
        }

        snString[snStringLength] = 0;

        printf("Serial Number: %s\n", snString);

#endif

#if 0
        sl_chassis_bat_status_response_t status;
        op_result = drv->getBatteryStatus(status);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get battery status.\n");
            break;
        }

        printf("Battery: %d %%", status.battery_percentage);
        if (status.power_status & PowerStatusCharging)
        {
            printf("Charging status: Charging \n");
        }
        else
        {
            printf("Charging status: NOT Charging \n");
        }
        

#endif
#if 0
        //should check how many ultrasonic sensors are used
        // if no sensor, will get time out error
        sl_chassis_ultrasonic_data_response_t data;
        op_result = drv->getUltraData(data);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get ultrasonic data.\n");
            break;
        }

        printf("Ultrasonic sensor data: \n");
        for (size_t i = 0; i < sizeof(data.ultrasonic_data_mm_q16); i++)
        {
            printf("[%d] : %5.2f mm \n", i, data.ultrasonic_data_mm_q16[i]/65536.0f);
        }       

#endif

#if 0

        sl_chassis_bumper_and_cliff_data_response_t data;
        op_result = drv->getBumperCliffData(data);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get bumper and cliff data.\n");
            break;
        }

        printf("bumper and cliff data data: 0x%08x\n", data.bumper_and_cliff);

#endif
#if 0
        //
        sl_chassis_health_response_t info;
        op_result = drv->getHealthInfo(info);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get health info.\n");
            break;
        }

        if (info.health_flag == SL_BASE_HEALTH_FLAG_HEALTHY)
        {
            printf("Chassis is healthy.\n");
        }
        else
        {
            printf("Chassis is unhealthy, level: %d\n", info.health_flag);

            sl_chassis_health_error_request_t error_id;
            sl_chassis_health_error_response_t error_data;

            for (int i = 0; i < info.error_count; i++)
            {
                memset(&error_data, 0, sizeof(error_data));
                op_result = drv->getSingleHealthData(error_id, error_data);

                if (SL_IS_FAIL(op_result))
                {
                    printf("can not get health data [%d].\n", i);
                    break;
                }

                printf("health data info: error code: %08X msg: %s.\n", error_data.error_code, error_data.error_msg);
            }
        }    

#endif
#if 0
        //before clear error code, should make sure the error code is exist, otherwise will casue to overflow
        sl_chassis_health_clear_error_request_t error_code;

        memset(&error_code, 0, sizeof(error_code));
        error_code.error_code = 0x2010700;
        op_result = drv->clearSingleHealthData(error_code);

        if (SL_IS_FAIL(op_result))
        {
            printf("can not clear health error code [%08X].\n", error_code.error_code);
            break;
        }

        printf("clear error code: %08X ok.\n", error_code.error_code);
        
           

#endif


#if 0
        sl_cp0_info_response_t  info;
        memset(&info, 0, sizeof(info));

        //printf("4 \n");
        op_result = drv_cp0->getDeviceInfo(info);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get cp0 info.\n");
        }
        
        printf("Model: %04X\n", info.model);

        
        // firmware version
        printf("Firmware Version: %d.%d.%d\n", info.firmware_version >> 8, info.firmware_version & 0xf0u, info.firmware_version & 0x0fu);

        // hardware version
        printf("Hardware version: %d.%d\n", info.hardware_version >> 8, info.hardware_version & 0xffu);

        // serial number
        size_t snStringLength = sizeof(info.serial_number) * 2;
        char* snString = new char[snStringLength + 1];

        for (size_t i = 0; i < (sizeof(info.serial_number)/sizeof(sl_u32)); i++)
        {
            sprintf(snString + i * (sizeof(sl_u32)*2), "%08X", info.serial_number[i]);
        }

        snString[snStringLength] = 0;

        printf("Serial Number: %s\n", snString);

#endif


#if 0
        sl_cp0_read_imu_processed_request_t req;
        sl_cp0_read_imu_processed_response_t processed_data;
        memset(&req, 0, sizeof(req));
        memset(&processed_data, 0, sizeof(processed_data));



        //printf("4 \n");
        op_result = drv_cp0->set_motion_hit_and_get_imu_processed(req, processed_data);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get imu processed data.\n");
        }
        //printf("6 \n");
        printf("processed: ts: %u gyro: x: %d y: %d z: %d\n"
                    , processed_data.timestamp
                    , processed_data.gyro.sum_x_d4
                    , processed_data.gyro.sum_y_d4
                    , processed_data.gyro.sum_z_d4);
#endif
#if 0
        sl_cp0_set_lidar_baudrate_request_t baud;
        memset(&baud, 0, sizeof(baud));
        baud.baudrate = 1000000;

        op_result = drv_cp0->setLidarBaudrate(baud);
#endif


#if 1
        sl_imu_raw_data_t imu_raw_data;
        memset(&imu_raw_data, 0, sizeof(imu_raw_data));

        //printf("4 \n");
        op_result = drv_cp0->getImuRawData(imu_raw_data);

        //printf("5 \n");

        if (SL_IS_FAIL(op_result))
        {
            printf("can not get imu raw data.\n");
        }
        //printf("6 \n");
        printf("ts: %8u raw acc: x: %8d y: %8d z: %8d gyro: x: %8d y: %8d z: %8d \n"
                    , imu_raw_data.timestamp
                    , imu_raw_data.acc_x
                    , imu_raw_data.acc_x
                    , imu_raw_data.acc_x
                    , imu_raw_data.gyro_x
                    , imu_raw_data.gyro_y
                    , imu_raw_data.gyro_z);

#endif


    }

    drv->disconnect();
    drv_cp0->disconnect();
    return 0;
}








