cmake_minimum_required(VERSION 3.17)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

set(CMAKE_SYSTEM_NAME Embedded)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_SYSTEM_PROCESSOR xtensa)

set(PREFIX xtensa-lx106-elf-)
find_program(CMAKE_C_COMPILER NAMES ${PREFIX}gcc HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_ASM_COMPILER NAMES ${PREFIX}gcc HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_CXX_COMPILER NAMES ${PREFIX}g++ HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_AR NAMES ${PREFIX}gcc-ar HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_RANLIB NAMES ${PREFIX}gcc-ranlib HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_OBJCOPY NAMES ${PREFIX}objcopy HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_OBJDUMP NAMES ${PREFIX}objdump HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_CXX_FILT NAMES ${PREFIX}c++filt HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)
find_program(CMAKE_GCOV NAMES ${PREFIX}gcov HINTS ${TOOLCHAIN_XTENSA_LX106_ELF}/bin)

find_package(Doxygen)

find_package(Python3 REQUIRED COMPONENTS Interpreter)

if (NOT EXISTS ${CMAKE_BINARY_DIR}/venv)
    execute_process(COMMAND ${Python3_EXECUTABLE} -m pip -q install virtualenv)
    execute_process(COMMAND ${Python3_EXECUTABLE} -m virtualenv ${CMAKE_BINARY_DIR}/venv)
endif()
find_program(Python3_venv_EXECUTABLE
    NAMES python
    PATHS ${CMAKE_BINARY_DIR}/venv
    PATH_SUFFIXES bin Scripts
    NO_DEFAULT_PATH
)

option(FORCE_COLORED_OUTPUT "Always produce ANSI-colored output." TRUE)
if(${FORCE_COLORED_OUTPUT})
    add_compile_options(-fdiagnostics-color=always)
endif()
