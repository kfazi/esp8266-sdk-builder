set(CMAKE_EXECUTABLE_SUFFIX .elf)
set(CMAKE_ASM_SOURCE_SUFFIX .s)
set(CMAKE_ASM_OUTPUT_EXTENSION .o)
set(CMAKE_C_OUTPUT_EXTENSION .o)
set(CMAKE_CXX_OUTPUT_EXTENSION .o)

set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE)

set(CMAKE_C_FLAGS "-fdiagnostics-color=always -U__STRICT_ANSI__ -D__ESP_FILE__=__FILE__ -DGCC_NOT_5_2_0 -DESP_PLATFORM -mlongcalls -mtext-section-literals -fstrict-volatile-bitfields -ffunction-sections -fdata-sections -Os" CACHE STRING "")
set(CMAKE_CXX_FLAGS "-fdiagnostics-color=always -U__STRICT_ANSI__ -D__ESP_FILE__=__FILE__ -DGCC_NOT_5_2_0 -DESP_PLATFORM -mlongcalls -mtext-section-literals -fstrict-volatile-bitfields -ffunction-sections -fdata-sections -Os -fno-rtti -fno-exceptions" CACHE STRING "")
set(CMAKE_ASM_FLAGS "-fdiagnostics-color=always -U__STRICT_ANSI__ -D__ESP_FILE__=__FILE__ -DGCC_NOT_5_2_0 -DESP_PLATFORM -mlongcalls -mtext-section-literals -fstrict-volatile-bitfields -x assembler-with-cpp" CACHE STRING "")
