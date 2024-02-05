cmake_minimum_required(VERSION 3.21)

project(RibbonUIAPP VERSION 1.0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

set(PROJECT_COMPANY "Mentalflow's Lab")
set(PROJECT_COPYRIGHT "Copyright (c) 2023 Mentalflow's Lab. All rights reserved.")
set(PROJECT_DOMAIN "dev.ourdocs.cn.ribbonuiapp")
set(PROJECT_BUNDLE_NAME RibbonUI-APP)

add_definitions(-DRIBBONUIAPP_VERSION=1,0,1)

find_package(Qt6 COMPONENTS Quick REQUIRED)

set(sources_files example.cpp)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/app/debug)
else()
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/app/release)
endif()

if (WIN32)
    set(app_icon_resource_windows "${CMAKE_CURRENT_SOURCE_DIR}/resources/icon.rc")
    qt_add_executable(${PROJECT_NAME}
        ${sources_files}
        "${CMAKE_CURRENT_SOURCE_DIR}/resources/icon.rc"
    )
    file(TO_CMAKE_PATH "/" PATH_SEPARATOR)
    if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        set(DLLPATH ${CMAKE_SOURCE_DIR}/3rdparty/msvc/*.dll)
    else()
        set(DLLPATH ${CMAKE_SOURCE_DIR}/3rdparty/mingw/*.dll)
    endif()
    string(REPLACE "/" ${PATH_SEPARATOR} DLLPATH "${DLLPATH}")
    file(GLOB DLL_FILES ${DLLPATH})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy
        ${DLL_FILES}
        ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    )
elseif(APPLE)
    set(MACOSX_BUNDLE_ICON_FILE AppIcon)
    set(App_ICON "${CMAKE_CURRENT_SOURCE_DIR}/resources/imgs/AppIcon.icns")
    set_source_files_properties(${App_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
    qt_add_executable(${PROJECT_NAME}
        ${sources_files}
        ${App_ICON}
    )
else ()
    qt_add_executable(${PROJECT_NAME}
        ${sources_files}
    )
endif ()

qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION 1.0
    QML_FILES example.qml components/RibbonWindow.qml
    RESOURCES resources/imgs/heart.png resources/imgs/search.png resources/icon.rc
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${PROJECT_DOMAIN}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE_BUNDLE_NAME ${PROJECT_BUNDLE_NAME}
    MACOSX_BUNDLE_COPYRIGHT ${PROJECT_COPYRIGHT}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME ${PROJECT_BUNDLE_NAME}
)

if(RIBBONUI_BUILD_STATIC_LIB)
    add_definitions(-DRIBBONUI_BUILD_STATIC_LIB)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt::Quick
        RibbonUIplugin
        FramelessHelper::Core
        FramelessHelper::Quick
    )

else()
    target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt::Quick
        RibbonUI
        FramelessHelper::Core
        FramelessHelper::Quick
    )

endif()
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
