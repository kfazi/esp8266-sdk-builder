set(NAME sdk)

add_library(${NAME} STATIC)

target_sources(${NAME}
    PRIVATE
        src/dummy.cpp
)

target_include_directories(${NAME}
    PUBLIC
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/bootloader_support/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/esp_ringbuf/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/esp_ringbuf/include/freertos
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/esp8266/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/esp8266/include/driver
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/esp_http_client/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/esp_http_server/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/http_parser/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/freertos/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/freertos/include/freertos
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/freertos/include/freertos/private
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/freertos/port/esp8266/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/freertos/port/esp8266/include/freertos
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/heap/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/heap/port/esp8266/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/log/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/lwip/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/lwip/include/lwip
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/lwip/include/lwip/apps
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/lwip/lwip/src/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/lwip/lwip/src/include/posix
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/lwip/port/esp8266/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/lwip/port/esp8266/include/port
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/mbedtls/port/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/mbedtls/port/esp8266/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/mbedtls/mbedtls/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/newlib/newlib/port/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/newlib/newlib/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/nvs_flash/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/spi_flash/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/tcpip_adapter/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/util/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/vfs/include
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/wpa_supplicant/include
        #${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/include/wpa_supplicant/port/include
)

target_link_libraries(${NAME}
    PUBLIC
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwpa_supplicant.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libtcpip_adapter.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_ringbuf.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libbootloader_support.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnvs_flash.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp8266.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libutil.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libvfs.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblwip.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblog.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libheap.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libfreertos.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnewlib.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libspi_flash.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libapp_update.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libjsmn.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libhttp_parser.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp-tls.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libcoap.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_common.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libtcp_transport.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_http_client.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_http_server.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_https_ota.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libjson.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblibsodium.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libopenssl.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmqtt.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libprotobuf-c.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libsmartconfig_ack.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libspi_ram.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwifi_provisioning.a

        -Wl,--cref

        -Wl,--start-group

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libjsmn.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libcoap.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_common.a

        -Wl,--gc-sections

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_http_server.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_https_ota.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libapp_update.a

        "-u esp_app_desc"

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_http_client.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libjson.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblibsodium.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmqtt.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libtcp_transport.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp-tls.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libhttp_parser.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libopenssl.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libsmartconfig_ack.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libspi_ram.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwifi_provisioning.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libprotobuf-c.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwpa_supplicant.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libtcpip_adapter.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_ringbuf.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libbootloader_support.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnvs_flash.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp8266.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libutil.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libvfs.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblwip.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblog.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libheap.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libfreertos.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnewlib.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libspi_flash.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmbedtls.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmbedcrypto.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmbedx509.a

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libgcc.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libhal.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libcore.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnet80211.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libphy.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/librtc.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libclk.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libpp.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libsmartconfig.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libssc.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwpa.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libespnow.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwps.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwpa2.a

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libc_fnano.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libm.a

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwpa_supplicant.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libtcpip_adapter.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp_ringbuf.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libbootloader_support.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnvs_flash.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libesp8266.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libutil.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libvfs.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblwip.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/liblog.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libheap.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libfreertos.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnewlib.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libspi_flash.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmbedtls.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmbedcrypto.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libmbedx509.a

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libgcc.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libhal.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libcore.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libnet80211.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libphy.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/librtc.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libclk.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libpp.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libsmartconfig.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libssc.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwpa.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libespnow.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwps.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libwpa2.a

        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libc_fnano.a
        ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/lib/libm.a

        -lstdc++

        -Wl,--end-group

        -T${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/ld/esp8266.ld
        -T${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/ld/esp8266.project.ld
        -T${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/ld/esp8266.rom.ld
        -T${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/ld/esp8266.peripherals.ld

        "-u call_user_start"

        "-u uxTopUsedPriority"

        "-u _printf_float"
        "-u _scanf_float"
)

set_target_properties(${NAME} PROPERTIES LINK_INTERFACE_MULTIPLICITY 2)
