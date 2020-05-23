set(FLASH_TARGETS "" CACHE INTERNAL "FLASH_TARGETS")
set(ESPTOOL_FLASH_COMMAND_LINE "" CACHE INTERNAL "ESPTOOL_FLASH_COMMAND_LINE")
set(PARTITIONS "" CACHE INTERNAL "PARTITIONS")

function(list_to_multilinestring DEST SRC)
    string(REGEX REPLACE "(^|[^\\\\]);" "\\1\n" TMP "${SRC}")
    set(${DEST} ${TMP} PARENT_SCOPE)
endfunction()

function(target_generate_binary TARGET)
    set(BIN_NAME ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.bin)
    set(MAP_NAME ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.map)
    set(ELF_NAME $<TARGET_FILE:${TARGET}>)
    add_custom_command(
        TARGET ${TARGET}
        POST_BUILD
        COMMAND ${Python3_venv_EXECUTABLE} ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/tools/esptool.py --chip esp8266 -b 460800 elf2image --version 3 --flash_mode dio --flash_freq 40m --flash_size 2MB -o ${BIN_NAME} ${ELF_NAME}
    )
    add_custom_target(${TARGET}.size
        COMMAND ${Python3_venv_EXECUTABLE} ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/tools/idf_size.py --archives ${MAP_NAME}
        DEPENDS install_deps ${ELF_NAME}
        USES_TERMINAL
    )
    add_dependencies(${TARGET} install_deps)
endfunction(target_generate_binary)

function(add_partition NAME TYPE SUBTYPE FLASH_OFFSET FLASH_SIZE)
    if(${ARGC} EQUAL 6)
        set(FLAGS ${ARGV5})
    else()
        set(FLAGS "")
    endif()

    set(TMP ${PARTITIONS})
    list(APPEND TMP "${NAME},${TYPE},${SUBTYPE},${FLASH_OFFSET},${FLASH_SIZE},${FLAGS}")
    set(PARTITIONS ${TMP} CACHE INTERNAL "PARTITIONS")
endfunction()

function(add_flash_file BIN_NAME TYPE SUBTYPE FLASH_OFFSET FLASH_SIZE)
    add_custom_target(${BIN_NAME}.flash
        COMMAND ${Python3_venv_EXECUTABLE} ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/tools/flash.py --chip esp8266 -b 460800 -p ${ESP_PORT0} write_flash --flash_mode dio --flash_freq 40m --flash_size 2MB ${FLASH_OFFSET} ${BIN_NAME}
        DEPENDS install_deps ${BIN_NAME}
        USES_TERMINAL
    )

    set(TMP_ARGS ${ARGV})
    list(REMOVE_AT TMP_ARGS 0)

    add_partition(${TMP_ARGS})

    set(ESPTOOL_FLASH_COMMAND_LINE ${ESPTOOL_FLASH_COMMAND_LINE} ${FLASH_OFFSET} ${BIN_NAME} CACHE INTERNAL "FLASH_TARGETS")
    set(FLASH_TARGETS ${FLASH_TARGETS} ${BIN_NAME} CACHE INTERNAL "ESPTOOL_FLASH_COMMAND_LINE")
endfunction(add_flash_file)

function(target_add_flash TARGET PARTITION_NAME TYPE SUBTYPE FLASH_OFFSET FLASH_SIZE)
    set(BIN_NAME ${CMAKE_CURRENT_BINARY_DIR}/${TARGET}.bin)
    add_custom_target(${TARGET}.flash
        COMMAND ${Python3_venv_EXECUTABLE} ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/tools/flash.py --chip esp8266 -b 460800 -p ${ESP_PORT0} write_flash --flash_mode dio --flash_freq 40m --flash_size 2MB ${FLASH_OFFSET} ${BIN_NAME}
        DEPENDS install_deps ${BIN_NAME}
        USES_TERMINAL
    )

    add_partition(${PARTITION_NAME} ${TYPE} ${SUBTYPE} ${FLASH_OFFSET} ${FLASH_SIZE})

    set(ESPTOOL_FLASH_COMMAND_LINE ${ESPTOOL_FLASH_COMMAND_LINE} ${FLASH_OFFSET} ${BIN_NAME} CACHE INTERNAL "FLASH_TARGETS")
    set(FLASH_TARGETS ${FLASH_TARGETS} ${TARGET} CACHE INTERNAL "ESPTOOL_FLASH_COMMAND_LINE")
endfunction(target_add_flash)

function(add_flash)
    add_custom_target(flash
        COMMAND ${Python3_venv_EXECUTABLE} ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/tools/flash.py --chip esp8266 -b 460800 -p ${ESP_PORT0} write_flash --flash_mode dio --flash_freq 40m --flash_size 2MB 0x0 ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/bin/bootloader.bin 0x8000 ${CMAKE_BINARY_DIR}/partitions.bin ${ESPTOOL_FLASH_COMMAND_LINE}
        DEPENDS ${FLASH_TARGETS} partition_table
        USES_TERMINAL
    )
endfunction(add_flash)

function(configure_partitions)
    list_to_multilinestring(PARTITIONS_LIST "${PARTITIONS}")

    configure_file(${CMAKE_SOURCE_DIR}/cmake/partitions.csv.in
        ${CMAKE_BINARY_DIR}/partitions.csv
        NEWLINE_STYLE UNIX
    )

    add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/partitions.bin
        COMMAND ${Python3_venv_EXECUTABLE} ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/tools/gen_esp32part.py -q --offset 0x8000 --disable-md5sum --flash-size 2MB ${CMAKE_BINARY_DIR}/partitions.csv ${CMAKE_BINARY_DIR}/partitions.bin
        DEPENDS install_deps ${FLASH_TARGETS} ${CMAKE_BINARY_DIR}/partitions.csv
    )

    add_custom_target(partition_table
        DEPENDS ${CMAKE_BINARY_DIR}/partitions.bin
    )
endfunction(configure_partitions)

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/install_deps_timestamp
    COMMAND ${Python3_venv_EXECUTABLE} -m pip install -r ${CMAKE_SOURCE_DIR}/requirements.txt --upgrade
    COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_BINARY_DIR}/install_deps_timestamp
    DEPENDS ${CMAKE_SOURCE_DIR}/requirements.txt
    USES_TERMINAL
)

add_custom_target(install_deps
    DEPENDS ${CMAKE_BINARY_DIR}/install_deps_timestamp
)

add_custom_target(terminal
    COMMAND ${Python3_venv_EXECUTABLE} ${TOOLCHAIN_XTENSA_LX106_ELF}/SDK/tools/terminal.py ${ESP_PORT0}
    USES_TERMINAL
)

configure_file(${CMAKE_SOURCE_DIR}/cmake/run_terminal.py.in
    ${CMAKE_BINARY_DIR}/run_terminal.py
    NEWLINE_STYLE UNIX
)
