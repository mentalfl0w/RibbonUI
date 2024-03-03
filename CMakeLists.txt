cmake_minimum_required(VERSION 3.16)

project(RibbonUI_Project VERSION 1.0.2 LANGUAGES CXX)

option(RIBBONUI_BUILD_EXAMPLES "Build RibbonUI APP." ON)
option(RIBBONUI_BUILD_FRAMELESSHEPLER "Build FramelessHelper." ON)
option(RIBBONUI_BUILD_STATIC_LIB "Build RibbonUI static library." OFF)

if (RIBBONUI_BUILD_EXAMPLES)
    add_subdirectory(example)
endif()

if (RIBBONUI_BUILD_FRAMELESSHEPLER)
    set(FRAMELESSHELPER_BUILD_STATIC ON)
    set(FRAMELESSHELPER_NO_SUMMARY OFF)
    set(FRAMELESSHELPER_NO_DEBUG_OUTPUT ON)
    set(FRAMELESSHELPER_BUILD_WIDGETS OFF)
    add_subdirectory(3rdparty/framelesshelper)
endif()

add_subdirectory(lib_source)

message("---------------------------- RibbonUI ----------------------------")
message("Build RibbonUI APP: ${RIBBONUI_BUILD_EXAMPLES}")
message("Build FramelessHelper: ${RIBBONUI_BUILD_FRAMELESSHEPLER}")
message("Build RibbonUI static library: ${RIBBONUI_BUILD_STATIC_LIB}")
message("------------------------------------------------------------------")
