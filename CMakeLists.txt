cmake_minimum_required(VERSION 3.16)

project(RibbonUI_Project VERSION 1.0.4 LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core)
set(QT_SDK_DIR ${Qt6_DIR}/../../..)
cmake_path(SET QT_SDK_DIR NORMALIZE ${QT_SDK_DIR})

option(RIBBONUI_BUILD_EXAMPLES "Build RibbonUI APP." ON)
option(RIBBONUI_BUILD_QWINDOWKIT "Build QWindowKit." ON)
option(RIBBONUI_BUILD_STATIC_LIB "Build RibbonUI static library." OFF)
option(RIBBONUI_UNIVERSAL_BUILD_MACOS "Universal build RibbonUI for macOS." ON)

if(APPLE AND RIBBONUI_UNIVERSAL_BUILD_MACOS)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

if(NOT RIBBONUI_QML_PLUGIN_DIRECTORY)
    set(RIBBONUI_QML_PLUGIN_DIRECTORY ${QT_SDK_DIR}/qml/RibbonUI CACHE PATH "RibbonUI Plugin Path")
endif()

if (RIBBONUI_BUILD_QWINDOWKIT)
    set(QWINDOWKIT_BUILD_STATIC ON)
    set(QWINDOWKIT_BUILD_EXAMPLES OFF)
    set(QWINDOWKIT_BUILD_QUICK ON)
    set(QWINDOWKIT_BUILD_WIDGETS OFF)
    set(QWINDOWKIT_ENABLE_STYLE_AGENT ON)
    set(QWINDOWKIT_INSTALL OFF)
    add_subdirectory(3rdparty/qwindowkit)
endif()

add_subdirectory(lib_source)

if (RIBBONUI_BUILD_EXAMPLES)
    add_subdirectory(example)
endif()

message("---------------------------- RibbonUI ----------------------------")
message("Build RibbonUI APP: ${RIBBONUI_BUILD_EXAMPLES}")
message("Build RibbonUI static library: ${RIBBONUI_BUILD_STATIC_LIB}")
message("Build QWindowKit: ${RIBBONUI_BUILD_QWINDOWKIT}")
message("Universal build RibbonUI for macOS: ${RIBBONUI_UNIVERSAL_BUILD_MACOS}")
message("RibbonUI QML Plugin Path: ${RIBBONUI_QML_PLUGIN_DIRECTORY}")
message("------------------------------------------------------------------")
