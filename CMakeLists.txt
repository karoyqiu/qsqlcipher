#*! ***********************************************************************************************
#
# \file        CMakeLists.txt
# \brief       qsqlcipher 主 CMakeLists。
#
# \version     0.1
# \date        2018/1/30
#
# \author      Roy QIU <karoyqiu@gmail.com>
# \copyright   © 2018 Roy QIU。
#
#*************************************************************************************************/
cmake_minimum_required(VERSION 3.8)

# 设置全局变量
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_C_VISIBILITY_PRESET "hidden")
set(CMAKE_CXX_VISIBILITY_PRESET "hidden")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_POLICY_DEFAULT_CMP0001 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0048 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0054 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0063 NEW)
set(CMAKE_POLICY_DEFAULT_CMP0069 NEW)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_USER_MAKE_RULES_OVERRIDE_C    ${CMAKE_SOURCE_DIR}/cmake/CFlagOverrides.cmake)
set(CMAKE_USER_MAKE_RULES_OVERRIDE_CXX  ${CMAKE_SOURCE_DIR}/cmake/CXXFlagOverrides.cmake)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
set(CMAKE_SKIP_BUILD_RPATH OFF)
set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "Enable/disable output of compile commands during generation." FORCE)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)

set(CMAKE_BUILD_TYPE Debug CACHE STRING
    "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel.")
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release RelWithDebInfo MinSizeRel)

# Project Shameless
project(qsqlcipher VERSION 0.1)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)

# 检查是否支持 IPO
if(POLICY CMP0069)
    cmake_policy(SET CMP0069 NEW)
endif()
include(CheckIPOSupported OPTIONAL)
if(COMMAND check_ipo_supported)
    check_ipo_supported(RESULT PROJECT_IS_IPO_SUPPORTED)

    if(PROJECT_IS_IPO_SUPPORTED)
        option(PROJECT_ENABLE_IPO "Enable IPO for non-debug build." OFF)
    endif()
endif()

if(PROJECT_ENABLE_IPO)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_MINSIZEREL ON)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO ON)
else()
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_MINSIZEREL OFF)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE OFF)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO OFF)
endif()

# 判断目标架构
include(TargetArch)
target_architecture(PROJECT_TARGET_ARCH)

# 检查编译器警告选项
include(WarningFlags)
check_warning_flags(PROJECT_WARNING_FLAGS)

include(EnableFolder)

# 第三方库
add_subdirectory("third_party")

# 源代码
add_subdirectory("src")
