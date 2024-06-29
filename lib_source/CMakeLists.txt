cmake_minimum_required(VERSION 3.21)

project(RibbonUI VERSION ${PROJECT_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(GNUInstallDirs)

if(QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
else()
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_AUTOUIC ON)
endif()

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Qml REQUIRED)

if (RIBBONUI_BUILD_STATIC_LIB)
    set(LIB_TYPE "STATIC")
    set(PLUGIN_TARGET_NAME "")
    set(RIBBONUI_QML_PLUGIN_DIRECTORY ${CMAKE_BINARY_DIR}/RibbonUI)
else()
    set(LIB_TYPE "SHARED")
    set(PLUGIN_TARGET_NAME ${PROJECT_NAME})
endif()

set(qml_files RibbonTabBar.qml RibbonTabButton.qml RibbonView.qml
    RibbonTabPage.qml RibbonTabGroup.qml RibbonButton.qml
    RibbonBottomBar.qml RibbonIcon.qml RibbonToolTip.qml
    RibbonTitleBar.qml RibbonSlider.qml RibbonSwitchButton.qml
    RibbonCheckBox.qml RibbonMenu.qml RibbonMenuItem.qml
    RibbonShadow.qml RibbonBlur.qml RibbonMenuSeparator.qml
    RibbonPaperView.qml RibbonPushButton.qml RibbonRectangle.qml
    RibbonText.qml RibbonTextBoxMenu.qml RibbonPopup.qml
    RibbonPopupDialog.qml RibbonLineEdit.qml RibbonTextEdit.qml
    RibbonComboBox.qml RibbonSpinBox.qml RibbonScrollIndicator.qml
    RibbonScrollBar.qml RibbonWindow.qml RibbonMessage.qml
    RibbonMessageListView.qml RibbonTour.qml RibbonTourContent.qml
    RibbonBackStageView.qml RibbonBackStagePage.qml RibbonBackStageGroup.qml
    RibbonRadioButton.qml RibbonBackStageMenuItem.qml RibbonTourItem.qml
    RibbonObject.qml RibbonProgressBar.qml RibbonProgressRing.qml
    RibbonBusyBar.qml RibbonBusyRing.qml)

set(qml_prefix "qml/Qt${QT_VERSION_MAJOR}/")

list(TRANSFORM qml_files PREPEND ${qml_prefix})

set (source_files ribbonui.cpp ribbonui.h definitions.h ribbontheme.h ribbontheme.cpp
    platformsupport.h)

set(__ribbonui_project_version "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
string(TOUPPER ${PROJECT_NAME} __ribbonui_project_name)
string(TOLOWER ${PROJECT_NAME} __ribbonui_project_name_lower)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/..//.cmake/version.h.in ${CMAKE_CURRENT_BINARY_DIR}/${__ribbonui_project_name_lower}_version.h)
list(APPEND source_files ${CMAKE_CURRENT_BINARY_DIR}/${__ribbonui_project_name_lower}_version.h)

if(APPLE)
    list(APPEND source_files platformsupport.mm)
endif()

foreach(qmlfile ${qml_files})
    string(REPLACE "${qml_prefix}" "" fixedfile ${qmlfile})
    set_source_files_properties(${qmlfile} PROPERTIES QT_RESOURCE_ALIAS ${fixedfile})
endforeach(qmlfile)

if(QT_VERSION VERSION_LESS 6.0)
    include(Qt5QMLPlugin)
    set(__qml_plugin_depend_module "QWindowKit")
endif()
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
target_include_directories(${PROJECT_NAME} PUBLIC
    ${PROJECT_BINARY_DIR}
)
install(DIRECTORY ${RIBBONUI_QML_PLUGIN_DIRECTORY} DESTINATION ${CMAKE_INSTALL_PREFIX}/imports)

