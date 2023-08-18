#include <stdio.h>
#include <string.h>
#include "include/libusb.h"
#include <unistd.h>


int main(void)
{
    libusb_device **devs;
    libusb_init(NULL);

    size_t dev_cnt = 0;

    // dev_cnt = libusb_get_device_list(NULL, &devs);
    // if (dev_cnt < 0)
    // {
    //     printf("error");
    //     libusb_exit(NULL);
    //     /* code */
    // }
    // else
    // {
    //     printf("cnt = %d \n", dev_cnt);
    // }
    

    libusb_device_handle * my_device = libusb_open_device_with_vid_pid(NULL, 64719, 61696);	
    if(my_device == NULL)
    {
        printf("open my_device %x:%x wrong\n", 64719, 61696);
    }
    else
    {
        printf("open my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device);
    }

    // if(my_device)
    // {
    //     libusb_close(my_device);
    //     my_device = NULL;
    // }

    libusb_device_handle * my_device_2 = libusb_open_device_with_vid_pid(NULL, 64719, 61696);	
    if(my_device_2 == NULL)
    {
        printf("open my_device_2%x:%x wrong\n", 64719, 61696);
    }
    else
    {
        printf("open my_device_2 %x:%x ok, handle: %x \n", 64719, 61696, my_device_2);
    }


    int test = libusb_set_auto_detach_kernel_driver(my_device, 1);
    if(test != LIBUSB_SUCCESS )
    {
        printf("auto detach wrong my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device);
    }

     test = libusb_set_auto_detach_kernel_driver(my_device_2, 1);
    if(test != LIBUSB_SUCCESS )
    {
        printf("auto detach wrong my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device_2);
    }

    test = libusb_claim_interface(my_device, 2);

    if(test != 0 )
    {
        printf("libusb_claim_interface wrong my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device);
    }

    test = libusb_claim_interface(my_device, 2);

    if(test != 0 )
    {
        printf("libusb_claim_interface wrong my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device);
    }

    test = libusb_claim_interface(my_device_2, 3);

    if(test != 0 )
    {
        printf("libusb_claim_interface wrong my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device_2);
    }

    int loop = 10000;
    while(loop--)
    {
        int offset = 0, rsize = 0;
        int size  = 0;

#if 1
        //set v and get deadreckon
        size  = 0;
        uint8_t buffer[17] = {0x10, 0x0e, 0xf8, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa7};
        test = libusb_bulk_transfer(my_device, 4, (unsigned char*)buffer, 17, &size, 1000);
        if (test<0)
        {
            printf("write:   %s\n", libusb_strerror((enum libusb_error)test));
            //return -1;
        }
        offset = 0, rsize = 0;
        if (size != 17) {
            offset = 17 - size;
            test = libusb_bulk_transfer(my_device, 4,(unsigned char*) buffer + offset, offset, &rsize, 1000);
            if (test < 0)
            {
                printf("write:   %s\n", libusb_strerror((enum libusb_error)test));
                //return -1;
            }
        }
        //sleep(1);
        size = 0;
        uint8_t buffer_2[22] = {0};
        test = libusb_bulk_transfer(my_device, 0x84, (unsigned char*)buffer_2, 22, &size, 1000);
        if (test<0)
        {
            printf("read:   %s\n", libusb_strerror((enum libusb_error)test));
            //return -1;
        }
        offset = 0, rsize = 0;
        if (size != 22) {
            offset = 22 - size;
            test = libusb_bulk_transfer(my_device, 0x84,(unsigned char*) buffer_2 + offset, offset, &rsize, 1000);
            if (test != 0)
            {
                printf("read:   %s\n", libusb_strerror((enum libusb_error)test));
                //return -1;
            }
        }
        printf("size %d rsize %d\n", size, rsize);
        printf("recev: ");
        for(int i=0; i<22;++i)
        {
            printf("%02x ", buffer_2[i]);
        }
        printf("\n");
#endif 
#if 1
        //get imu processed
        size  = 0;
        uint8_t buffer_3[22] = 
        {
            0x10, 0x13, 0xf1, 0x5d, 
            0x00, 0x00, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00,
            0x00, 0xaf
        };


        test = libusb_bulk_transfer(my_device_2, 5, (unsigned char*)buffer_3, 22, &size, 1000);
        if (test<0)
        {
            printf("write:   %s\n", libusb_strerror((enum libusb_error)test));
            //return -1;
        }

        offset = 0, rsize = 0;
        if (size != 22) {
            offset = 22 - size;
            test = libusb_bulk_transfer(my_device_2, 4,(unsigned char*) buffer_3 + offset, offset, &rsize, 1000);
            if (test < 0)
            {
                printf("write:   %s\n", libusb_strerror((enum libusb_error)test));
                //return -1;
            }
        }
        //sleep(1);
        size = 0;
        uint8_t buffer_4[46] = {0};
        test = libusb_bulk_transfer(my_device_2, 0x85, (unsigned char*)buffer_4, 46, &size, 1000);
        if (test<0)
        {
            printf("read:   %s\n", libusb_strerror((enum libusb_error)test));
            //return -1;
        }
        offset = 0, rsize = 0;
        if (size != 46) {
            offset = 46 - size;
            test = libusb_bulk_transfer(my_device_2, 0x84,(unsigned char*) buffer_4 + offset, offset, &rsize, 1000);
            if (test != LIBUSB_SUCCESS)
            {
                printf("read:   %s\n", libusb_strerror((enum libusb_error)test));
                //return -1;
            }
        }
        printf("size %d rsize %d\n", size, rsize);
        printf("recev: ");
        for(int i=0; i<46;++i)
        {
            printf("%02x ", buffer_4[i]);
        }
        printf("\n");
#endif
        //sleep(1);
    }


    test = libusb_release_interface(my_device, 2);

    if(test != 0 )
    {
        printf("libusb_release_interface wrong my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device);
    }

    test = libusb_release_interface(my_device_2, 3);

    if(test != 0 )
    {
        printf("libusb_release_interface wrong my_device %x:%x ok, handle: %x \n", 64719, 61696, my_device_2);
    }



    if(my_device)
    {
        libusb_close(my_device);
    }

    if(my_device_2)
    {
        libusb_close(my_device_2);
    }
    //libusb_close(my_device);

    libusb_exit(NULL);

    return 0;
}
