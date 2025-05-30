cmake_minimum_required(VERSION 3.21)

project(RibbonUI_Project VERSION 1.1.1 LANGUAGES CXX)

# Find Qt Package
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core)

# Set Qt SDK Directory
set(QT_SDK_DIR ${Qt${QT_VERSION_MAJOR}_DIR}/../../..)
cmake_path(SET QT_SDK_DIR NORMALIZE ${QT_SDK_DIR})
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/.cmake/ ${CMAKE_CURRENT_LIST_DIR}/3rdparty/Qt5QMLPlugin)

# Set RibbonUI QML Plugin Directory
option(RIBBONUI_BUILD_EXAMPLES "Build RibbonUI APP." ON)
option(RIBBONUI_BUILD_QWINDOWKIT "Build QWindowKit." ON)
option(RIBBONUI_BUILD_STATIC_LIB "Build RibbonUI static library." OFF)
option(RIBBONUI_UNIVERSAL_BUILD_MACOS "Universal build RibbonUI for macOS." ON)

if(APPLE AND RIBBONUI_UNIVERSAL_BUILD_MACOS)
    if(QT_VERSION VERSION_GREATER_EQUAL 6.0)
        set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
    else()
        set(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE STRING "" FORCE)
        set(RIBBONUI_UNIVERSAL_BUILD_MACOS OFF)
    endif()
else()
    set(RIBBONUI_UNIVERSAL_BUILD_MACOS OFF)
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
    add_subdirectory(RibbonUIAPP)
endif()

message("---------------------------- RibbonUI ----------------------------")
message("Build RibbonUI APP: ${RIBBONUI_BUILD_EXAMPLES}")
message("Build RibbonUI static library: ${RIBBONUI_BUILD_STATIC_LIB}")
message("Build QWindowKit: ${RIBBONUI_BUILD_QWINDOWKIT}")
message("Universal build RibbonUI for macOS: ${RIBBONUI_UNIVERSAL_BUILD_MACOS}")
message("RibbonUI QML Plugin Path: ${RIBBONUI_QML_PLUGIN_DIRECTORY}")
message("------------------------------------------------------------------")
