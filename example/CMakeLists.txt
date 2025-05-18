cmake_minimum_required(VERSION 3.21)

project(RibbonUIAPP VERSION ${PROJECT_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Qt version check to set up standard project settings
if(QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
else()
    # Automatic Qt moc, rcc, and uic processing for older Qt versions
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_AUTOUIC ON)
endif()

# Project metadata
string(TIMESTAMP TIME_YEAR %Y)
set(PROJECT_COMPANY "Mentalflow's Lab")
set(PROJECT_COPYRIGHT "Copyright (c) ${TIME_YEAR} Mentalflow's Lab. All rights reserved.")
set(PROJECT_DOMAIN "dev.ourdocs.cn.ribbonuiapp")
set(PROJECT_BUNDLE_NAME RibbonUI-APP)
set(version_str "${PROJECT_VERSION_MAJOR},${PROJECT_VERSION_MINOR},${PROJECT_VERSION_PATCH}")

# Output directory based on build type
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(output_dir ${CMAKE_BINARY_DIR}/app/debug)
else()
    set(output_dir ${CMAKE_BINARY_DIR}/app/release)
endif()

# Find Qt package
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick LinguistTools REQUIRED)

# List all ts files to be used in the project
set(ts_files i18n/${PROJECT_NAME}_zh_CN.ts i18n/${PROJECT_NAME}_en_US.ts)

# Source and QML files
set(sources_files example.cpp)
set(qml_files example.qml about.qml components/RibbonMessageListViewExample.qml pages/SettingsMenuPage.qml components/TabBar.qml)
set(qml_prefix "qml/Qt${QT_VERSION_MAJOR}/")
list(TRANSFORM qml_files PREPEND ${qml_prefix})

# Set properties for QML files
foreach(qmlfile ${qml_files})
    string(REPLACE "${qml_prefix}" "" fixedfile ${qmlfile})
    set_source_files_properties(${qmlfile} PROPERTIES QT_RESOURCE_ALIAS ${fixedfile})
endforeach(qmlfile)

# Configure version header
set(__example_project_version "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
string(TOUPPER ${PROJECT_NAME} __example_project_version)
string(TOLOWER ${PROJECT_NAME} __example_project_version_lower)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../.cmake/version.h.in ${CMAKE_CURRENT_BINARY_DIR}/${__example_project_version_lower}_version.h)
list(APPEND source_files ${CMAKE_CURRENT_BINARY_DIR}/${__example_project_version_lower}_version.h)

# Define the executable
qt_add_executable(${PROJECT_NAME}
    ${sources_files})

# Add i18n files
set_source_files_properties(${ts_files} PROPERTIES OUTPUT_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/i18n)

if(QT_VERSION VERSION_LESS 6.0)
    qt5_create_translation_plus(qm_files ${CMAKE_CURRENT_SOURCE_DIR} ${ts_files})
    foreach(qm_file ${qm_files})
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" r_qm_file ${qm_file})
        list(APPEND r_qm_files ${r_qm_file})
    endforeach()
    qt5_add_resources_plus(${PROJECT_NAME} "${PROJECT_NAME}-translations"
        PREFIX "/"
        FILES ${r_qm_files}
    )
else()
    qt6_create_translation(qm_files ${CMAKE_CURRENT_SOURCE_DIR} ${ts_files})
    foreach(qm_file ${qm_files})
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" r_qm_file ${qm_file})
        list(APPEND r_qm_files ${r_qm_file})
    endforeach()
    qt6_add_resources(${PROJECT_NAME} "${PROJECT_NAME}-translations"
        PREFIX "/"
        FILES ${r_qm_files}
    )
endif()

# Windows-specific settings
if (WIN32)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../.cmake/win_app.rc.in ${CMAKE_BINARY_DIR}/win_app.rc)
    set(app_icon_resource_windows ${CMAKE_BINARY_DIR}/win_app.rc)
    target_sources(${PROJECT_NAME} PRIVATE ${app_icon_resource_windows})

    file(TO_CMAKE_PATH "/" PATH_SEPARATOR)
    if(MSVC)
        set(DLLPATH ${CMAKE_CURRENT_SOURCE_DIR}/../3rdparty/msvc/*.dll)
    else()
        set(DLLPATH ${CMAKE_CURRENT_SOURCE_DIR}/../3rdparty/mingw/*.dll)
    endif()
    string(REPLACE "/" ${PATH_SEPARATOR} DLLPATH "${DLLPATH}")
    file(GLOB DLL_FILES ${DLLPATH})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${DLL_FILES}
        ${output_dir}
    )

    # macOS-specific settings
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

    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../.cmake/MacOSXBundleInfo.plist.in ${CMAKE_BINARY_DIR}/Info.plist)
    set(App_ICON "${PROJECT_SOURCE_DIR}/resources/imgs/AppIcon.icns")
    set_source_files_properties(${App_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
    target_sources(${PROJECT_NAME} PRIVATE ${App_ICON})
endif()

# Include Qt5 QML plugin for Qt versions less than 6
if (${QT_VERSION_MAJOR} LESS 6)
    include(Qt5QMLPlugin)
endif()

# Define the QML module
qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    RESOURCE_PREFIX "/qt/qml/"
    QML_FILES ${qml_files}
    RESOURCES resources/imgs/heart.png resources/imgs/search.png
)

# Set target properties
set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_BINARY_DIR}/Info.plist
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME ${PROJECT_BUNDLE_NAME}
    RUNTIME_OUTPUT_DIRECTORY ${output_dir}
    LIBRARY_OUTPUT_DIRECTORY ${output_dir}
    ARCHIVE_OUTPUT_DIRECTORY ${output_dir}
)

# Link RibbonUI library based on build type
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

# Link required libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Quick
    RibbonUI
)

target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})
