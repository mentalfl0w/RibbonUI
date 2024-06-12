cmake_minimum_required(VERSION 3.21)

project(RibbonUIAPP VERSION ${PROJECT_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
else()
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_AUTOUIC ON)
endif()

string(TIMESTAMP TIME_YEAR %Y)
set(PROJECT_COMPANY "Mentalflow's Lab")
set(PROJECT_COPYRIGHT "Copyright (c) ${TIME_YEAR} Mentalflow's Lab. All rights reserved.")
set(PROJECT_DOMAIN "dev.ourdocs.cn.ribbonuiapp")
set(PROJECT_BUNDLE_NAME RibbonUI-APP)
set(version_str "${PROJECT_VERSION_MAJOR},${PROJECT_VERSION_MINOR},${PROJECT_VERSION_PATCH}")
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
set(output_dir ${CMAKE_BINARY_DIR}/app/debug)
else()
set(output_dir ${CMAKE_BINARY_DIR}/app/release)
endif()

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick REQUIRED)

set(sources_files example.cpp)
set(qml_files example.qml about.qml components/RibbonMessageListViewExample.qml pages/SettingsMenuPage.qml)
set(qml_prefix "qml/Qt${QT_VERSION_MAJOR}/")
list(TRANSFORM qml_files PREPEND ${qml_prefix})
foreach(qmlfile ${qml_files})
    string(REPLACE "${qml_prefix}" "" fixedfile ${qmlfile})
    set_source_files_properties(${qmlfile} PROPERTIES QT_RESOURCE_ALIAS ${fixedfile})
endforeach(qmlfile)

set(__example_project_version "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
string(TOUPPER ${PROJECT_NAME} __example_project_version)
string(TOLOWER ${PROJECT_NAME} __example_project_version_lower)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/..//.cmake/version.h.in ${CMAKE_CURRENT_BINARY_DIR}/${__example_project_version_lower}_version.h)
list(APPEND source_files ${CMAKE_CURRENT_BINARY_DIR}/${__example_project_version_lower}_version.h)

qt_add_executable(${PROJECT_NAME}
    ${sources_files})

if (WIN32)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/..//.cmake/win_app.rc.in ${CMAKE_BINARY_DIR}/win_app.rc)
    set(app_icon_resource_windows ${CMAKE_BINARY_DIR}/win_app.rc)
    target_sources(${PROJECT_NAME} PRIVATE ${app_icon_resource_windows})
    file(TO_CMAKE_PATH "/" PATH_SEPARATOR)
    if(MSVC)
        set(DLLPATH ${CMAKE_CURRENT_SOURCE_DIR}/..//3rdparty/msvc/*.dll)
    else()
        set(DLLPATH ${CMAKE_CURRENT_SOURCE_DIR}/..//3rdparty/mingw/*.dll)
    endif()
    string(REPLACE "/" ${PATH_SEPARATOR} DLLPATH "${DLLPATH}")
    file(GLOB DLL_FILES ${DLLPATH})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${DLL_FILES}
        ${output_dir}
    )
elseif(APPLE)
    set(MACOSX_BUNDLE_GUI_IDENTIFIER ${PROJECT_DOMAIN})
    set(MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR})
    set(MACOSX_BUNDLE_BUNDLE_NAME ${PROJECT_BUNDLE_NAME})
    set(MACOSX_BUNDLE_COPYRIGHT ${PROJECT_COPYRIGHT})
    set(MACOSX_BUNDLE_DEVELOPMENT_REGION "Chinese")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0" CACHE STRING "Minimum OS X deployment version" FORCE)
    set(MACOSX_BUNDLE_EXECUTABLE_NAME ${PROJECT_BUNDLE_NAME})
    set(MACOSX_BUNDLE_ICON_FILE AppIcon)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/..//.cmake/MacOSXBundleInfo.plist.in ${CMAKE_BINARY_DIR}/Info.plist)
    set(App_ICON "${PROJECT_SOURCE_DIR}/resources/imgs/AppIcon.icns")
    set_source_files_properties(${App_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
    target_sources(${PROJECT_NAME} PRIVATE ${App_ICON})
endif()
if (${QT_VERSION_MAJOR} LESS 6)
    include(Qt5QMLPlugin)
endif()

qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    RESOURCE_PREFIX "/qt/qml/"
    QML_FILES ${qml_files}
    RESOURCES resources/imgs/heart.png resources/imgs/search.png
)
set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_BINARY_DIR}/Info.plist
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME ${PROJECT_BUNDLE_NAME}
    RUNTIME_OUTPUT_DIRECTORY ${output_dir}
    LIBRARY_OUTPUT_DIRECTORY ${output_dir}
    ARCHIVE_OUTPUT_DIRECTORY ${output_dir}
)

if(RIBBONUI_BUILD_STATIC_LIB)
    if (${QT_VERSION_MAJOR} GREATER_EQUAL 6)
        target_link_libraries(${PROJECT_NAME} PRIVATE
            RibbonUIplugin)
    endif()
else()
    if(WIN32)
        if (MINGW)
            add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${RIBBONUI_QML_PLUGIN_DIRECTORY}/RibbonUI.dll"
                ${output_dir})
        else()
            if (NOT RIBBONUI_BUILD_STATIC_LIB)
                if (CMAKE_BUILD_TYPE MATCHES "Debug")
                    set(DEBUG_POSTFIX "d")
                endif()
                add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
                    COMMAND ${CMAKE_COMMAND} -E copy_if_different
                    "${RIBBONUI_QML_PLUGIN_DIRECTORY}/RibbonUI${DEBUG_POSTFIX}.dll"
                    ${output_dir})
            endif()
        endif()
    endif()
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Quick
    RibbonUI
)

target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})

