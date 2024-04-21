cmake_minimum_required(VERSION 3.21)

project(RibbonUI VERSION ${PROJECT_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/.cmake/)
include(GNUInstallDirs)

if(QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
    qt_policy(SET QTP0001 NEW)
else()
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_AUTOUIC ON)
endif()

if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
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

find_package(Qt6 COMPONENTS Core Quick Qml REQUIRED)

set(version_str "${PROJECT_VERSION_MAJOR},${PROJECT_VERSION_MINOR},${PROJECT_VERSION_PATCH}")
add_definitions(-DRIBBONUI_VERSION=${version_str})

if (RIBBONUI_BUILD_STATIC_LIB)
    set(LIB_TYPE "STATIC")
    set(PLUGIN_TARGET_NAME "")
    set(RIBBONUI_QML_PLUGIN_DIRECTORY ${CMAKE_BINARY_DIR}/RibbonUI)
else()
    set(LIB_TYPE "SHARED")
    set(PLUGIN_TARGET_NAME ${PROJECT_NAME})
endif()

set(
    qml_files qml/RibbonTabBar.qml qml/RibbonTabButton.qml qml/RibbonView.qml
    qml/RibbonTabPage.qml qml/RibbonTabGroup.qml qml/RibbonButton.qml
    qml/RibbonBottomBar.qml qml/RibbonIcon.qml qml/RibbonToolTip.qml
    qml/RibbonTitleBar.qml qml/RibbonSlider.qml qml/RibbonSwitchButton.qml
    qml/RibbonCheckBox.qml qml/RibbonMenu.qml qml/RibbonMenuItem.qml
    qml/RibbonShadow.qml qml/RibbonBlur.qml qml/RibbonMenuSeparator.qml
    qml/RibbonPaperView.qml qml/RibbonPushButton.qml qml/RibbonRectangle.qml
    qml/RibbonText.qml qml/RibbonTextBoxMenu.qml qml/RibbonPopup.qml
    qml/RibbonPopupDialog.qml qml/RibbonLineEdit.qml qml/RibbonTextEdit.qml
    qml/RibbonComboBox.qml qml/RibbonSpinBox.qml qml/RibbonScrollIndicator.qml
    qml/RibbonScrollBar.qml qml/RibbonWindow.qml qml/RibbonMessage.qml
    qml/RibbonMessageListView.qml
)

set (
    source_files ribbonui.cpp ribbonui.h definitions.h ribbontheme.h ribbontheme.cpp
    platformsupport.h
)

if(APPLE)
    list(APPEND source_files platformsupport.mm)
endif()

foreach(qmlfile ${qml_files})
    string(REPLACE "qml/" "" fixedfile ${qmlfile})
    set_source_files_properties(${qmlfile} PROPERTIES QT_RESOURCE_ALIAS ${fixedfile})
endforeach(qmlfile)

qt_add_library(${PROJECT_NAME} ${LIB_TYPE})
qt_add_qml_module(${PROJECT_NAME}
    PLUGIN_TARGET ${PLUGIN_TARGET_NAME}
    OUTPUT_DIRECTORY ${RIBBONUI_QML_PLUGIN_DIRECTORY}
    URI ${PROJECT_NAME}
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    QML_FILES ${qml_files}
    SOURCES ${source_files}
    RESOURCES resources/FluentSystemIcons-Resizable.ttf resources/imgs/icon.png
    RESOURCE_PREFIX "/qt/qml/"
)

if (MINGW)
    set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")
endif()

if (MSVC)
    set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")
endif()

if (RIBBONUI_BUILD_STATIC_LIB)
    target_compile_definitions(${PROJECT_NAME} PRIVATE
        RIBBONUI_BUILD_STATIC_LIB
    )
endif()

target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    RIBBONUI_LIBRARY
)
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Quick
    Qt::CorePrivate
    Qt::QuickPrivate
    Qt::QmlPrivate
)
target_link_libraries(${PROJECT_NAME} PUBLIC
    QWindowKit::Quick
)
target_include_directories(${PROJECT_NAME} PUBLIC
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/3rdparty/qwindowkit/include
)

install(DIRECTORY ${RIBBONUI_QML_PLUGIN_DIRECTORY} DESTINATION ${CMAKE_INSTALL_PREFIX}/imports)

