/*
 * Slamtec CHASSIS SDK
 *
 *  Copyright (c) 2014 - 2020 Shanghai Slamtec Co., Ltd.
 *  http://www.slamtec.com
 *
 */
 /*
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
  *
  * 1. Redistributions of source code must retain the above copyright notice,
  *    this list of conditions and the following disclaimer.
  *
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
  * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
  * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  */

#include "sl_chassis_driver.h"
#include "hal/usb/libusb/include/libusb.h"
#include <string.h>


namespace sl {
    enum
    {
        MAX_RX_BUFFER_SIZE = 1224
    };
    class USBChannel : public IChannel
    {
    public:
        USBChannel(std::uint16_t venderId, std::uint16_t productId,
            std::uint16_t interfaceId, std::uint16_t txEndpoint, std::uint16_t rxEndpoint) 
            : _dev_handle(NULL)
            , _is_interface_clamed(false)
            , _rx_size(0)
            , ctx(NULL)
        {
            _venderId = venderId;
            _productId = productId;
            _interfaceId = interfaceId;
            _txEndpoint = txEndpoint;
            _rxEndpoint = rxEndpoint;
        }

        ~USBChannel()
        {
            if (_is_interface_clamed)
            {
                int err = libusb_release_interface(_dev_handle, _interfaceId);

                if(err != LIBUSB_SUCCESS )
                {
                    printf("libusb_release_interface wrong %x:%x->%d , handle: %x error msg:  %s \n",
                     _venderId, _productId,_interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));
                }
            }
            _is_interface_clamed = false;

            if (_dev_handle)
            {
                libusb_close(_dev_handle);
            }
            _dev_handle = NULL;
            ctx = NULL;
            
        }

        // bool bind(const std::string & ip, sl_s32 port)
        // {
        //     _socket = rp::net::SocketAddress(ip.c_str(), port);
        //     return SL_RESULT_OK;
        // }

        bool open()
        {
            int err = libusb_init(&ctx);
            if(err != LIBUSB_SUCCESS )
            {
                printf("libusb_init wrong %x:%x->%d , handle: %x error msg:  %s \n",
                     _venderId, _productId, _interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));
                return false;
            }

            _dev_handle = libusb_open_device_with_vid_pid(ctx, _venderId, _productId);	
            if(_dev_handle == NULL)
            {
                printf("open my_device %x:%x wrong\n", _venderId, _productId);
                return false;
            }
            else
            {
                printf("open my_device %x:%x ok, handle: %x \n",  _venderId, _productId, _dev_handle);
            }

            err = libusb_set_auto_detach_kernel_driver(_dev_handle, 1);
            if(err != LIBUSB_SUCCESS )
            {
                printf("libusb_set_auto_detach_kernel_driver wrong %x:%x->%d , handle: %x error msg:  %s \n",
                     _venderId, _productId, _interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));
                return false;
            }

            err = libusb_claim_interface(_dev_handle, _interfaceId);
            if(err != LIBUSB_SUCCESS )
            {
                printf("libusb_claim_interface wrong %x:%x->%d , handle: %x error msg:  %s \n",
                     _venderId, _productId, _interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));
                return false;
            }
            _is_interface_clamed = true;

            return true;
        }

        void close()
        {
            if (_is_interface_clamed)
            {
                int err = libusb_release_interface(_dev_handle, _interfaceId);

                if(err != LIBUSB_SUCCESS )
                {
                    printf("libusb_release_interface wrong %x:%x->%d , handle: %x error msg:  %s \n",
                     _venderId, _productId,_interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));
                }
            }
            _is_interface_clamed = false;

            if (_dev_handle)
            {
                libusb_close(_dev_handle);
            }
            _dev_handle = NULL;
            ctx = NULL;
        }

        void flush()
        {
            //_rx_size = 0;
        }

        bool waitForData(size_t size, sl_u32 timeoutInMs, size_t* actualReady)
        {
            if (size > MAX_RX_BUFFER_SIZE)
            {
                printf("usb channel rx data too big, max %d\n", MAX_RX_BUFFER_SIZE);
                return false;
            }
            

            int ready_size = 0;
            int err = libusb_bulk_transfer(_dev_handle, 0x80 + _rxEndpoint, (unsigned char*)_rx_buffer, size, &ready_size, timeoutInMs);
            if (err != LIBUSB_SUCCESS)
            {
                printf("libusb_bulk_transfer read wrong %x:%x->%d , handle: %x error msg:  %s \n",
                     _venderId, _productId,_interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));

                if (actualReady)
                {
                   * actualReady = 0;
                }
                
               
                //return false;
            }

            int offset = 0, rsize = 0;
            if (ready_size != size) 
            {
                offset = size - ready_size;
                err = libusb_bulk_transfer(_dev_handle, 0x80 + _rxEndpoint,(unsigned char*) _rx_buffer + offset, offset, &rsize, timeoutInMs);
                
                if (actualReady)
                {
                    * actualReady = offset + rsize;
                   
                }
                 _rx_size = offset + rsize;
                
                if (err != LIBUSB_SUCCESS)
                {
                    printf("libusb_bulk_transfer read wrong 2: %x:%x->%d , handle: %x error msg:  %s \n",
                        _venderId, _productId,_interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));

                    
                    return false;
                }
            }
            else
            {
                if (actualReady)
                {
                    * actualReady = ready_size;
                }
                _rx_size = ready_size;
            }

            

            return true;
        }

        int write(const void* data, size_t size)
        {
            #if 0
            printf("send: ");
            u_int8_t * pdata = (u_int8_t * )data;
            for (size_t i = 0; i < size; i++)
            {
                printf(" %02x", pdata[i]);
            }
            printf("\n");
            #endif


            int ready_size = 0;
            int err = libusb_bulk_transfer(_dev_handle, _txEndpoint, (unsigned char*)data, size, &ready_size, 1000);
            if (err != LIBUSB_SUCCESS)
            {
                printf("libusb_bulk_transfer write wrong %x:%x->%d , handle: %x error msg:  %s \n",
                     _venderId, _productId,_interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));                
               
                return SL_RESULT_OPERATION_FAIL;
            }

            int offset = 0, rsize = 0;
            if (ready_size != size) 
            {
                offset = size - ready_size;
                err = libusb_bulk_transfer(_dev_handle, _txEndpoint,(unsigned char*) data + offset, offset, &rsize, 1000);
                if (err != LIBUSB_SUCCESS)
                {
                    printf("libusb_bulk_transfer read wrong 2: %x:%x->%d , handle: %x error msg:  %s \n",
                        _venderId, _productId,_interfaceId, _dev_handle,  libusb_strerror((enum libusb_error)err));

                    return ready_size;
                }

                if ((offset + rsize) != size)
                {
                    return offset + rsize;
                }
                
            }

            return ready_size;
        }

        int read(void* buffer, size_t size)
        {
            //size_t lenRec = 0;
            if (size <= _rx_size)
            {
                memcpy(buffer, _rx_buffer, size);
                _rx_size -= size;

                return size;
            }
            else
            {
                memcpy(buffer, _rx_buffer, _rx_size);
                _rx_size = 0;

                return _rx_size;
            }
        }

        void clearReadCache() 
        {
            _rx_size = 0;
        }

        void setStatus(uint32_t flag){}
    private:
        libusb_device_handle *_dev_handle;
        libusb_context *	ctx;

        bool    _is_interface_clamed;
        std::uint16_t _venderId;
        std::uint16_t _productId;
        std::uint16_t _interfaceId;
        std::uint16_t _txEndpoint;
        std::uint16_t _rxEndpoint;

        std::uint16_t _rx_size;
        std::uint8_t _rx_buffer[MAX_RX_BUFFER_SIZE];

    };
    Result<IChannel*> createUSBChannel(std::uint16_t venderId, std::uint16_t productId,
            std::uint16_t interfaceId, std::uint16_t txEndpoint, std::uint16_t rxEndpoint)
    {
        return new USBChannel(venderId, productId, interfaceId, txEndpoint, rxEndpoint);
    }
}