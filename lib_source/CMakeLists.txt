cmake_minimum_required(VERSION 3.21)

project(RibbonUI VERSION ${PROJECT_VERSION} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(GNUInstallDirs)

# Qt version check to set up standard project settings
if(QT_VERSION VERSION_GREATER_EQUAL "6.3")
    qt_standard_project_setup()
else()
    # Automatic Qt moc, rcc, and uic processing for older Qt versions
    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)
    set(CMAKE_AUTOUIC ON)
endif()

# Find Qt package
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Qml REQUIRED)

# Determine library type and plugin target name based on build type
if (RIBBONUI_BUILD_STATIC_LIB)
    set(LIB_TYPE "STATIC")
    set(PLUGIN_TARGET_NAME "")
    set(RIBBONUI_QML_PLUGIN_DIRECTORY ${CMAKE_BINARY_DIR}/RibbonUI)
else()
    set(LIB_TYPE "SHARED")
    set(PLUGIN_TARGET_NAME ${PROJECT_NAME})
endif()

# List of QML files to be included in the project
set(qml_files
    RibbonTabBar.qml RibbonTabButton.qml RibbonView.qml
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
    RibbonBusyBar.qml RibbonBusyRing.qml RibbonPageIndicator.qml)

# Set the QML prefix path
set(qml_prefix "qml/Qt${QT_VERSION_MAJOR}/")

# Add prefix to all QML files
list(TRANSFORM qml_files PREPEND ${qml_prefix})

# List of source files to be included in the project
set (source_files
    ribbonui.cpp ribbonui.h definitions.h ribbontheme.h ribbontheme.cpp
    platformsupport.h)

# Configure version header
set(__ribbonui_project_version "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
string(TOUPPER ${PROJECT_NAME} __ribbonui_project_name)
string(TOLOWER ${PROJECT_NAME} __ribbonui_project_name_lower)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../.cmake/version.h.in ${CMAKE_CURRENT_BINARY_DIR}/${__ribbonui_project_name_lower}_version.h)
list(APPEND source_files ${CMAKE_CURRENT_BINARY_DIR}/${__ribbonui_project_name_lower}_version.h)

# Add platform-specific source files for Apple
if(APPLE)
    list(APPEND source_files platformsupport.mm)
endif()

# Set properties for QML files
foreach(qmlfile ${qml_files})
    string(REPLACE "${qml_prefix}" "" fixedfile ${qmlfile})
    set_source_files_properties(${qmlfile} PROPERTIES QT_RESOURCE_ALIAS ${fixedfile})
endforeach(qmlfile)

# Include Qt5 QML plugin for Qt versions less than 6.0
if(QT_VERSION VERSION_LESS 6.0)
    include(Qt5QMLPlugin)
    set(__qml_plugin_depend_module "QWindowKit")
endif()

# Define the RibbonUI library
qt_add_library(${PROJECT_NAME} ${LIB_TYPE})

# Define the QML module for the library
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

# Set properties for MinGW and MSVC compilers
if (MINGW)
    set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "")
endif()

if (MSVC)
    set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")
endif()

# Set target compile definitions
target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    RIBBONUI_LIBRARY
)

# Link required libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Quick
    Qt::CorePrivate
    Qt::QuickPrivate
    Qt::QmlPrivate
)

target_link_libraries(${PROJECT_NAME} PUBLIC
    QWindowKit::Quick
)

# Include directories
target_include_directories(${PROJECT_NAME} PUBLIC
    ${PROJECT_SOURCE_DIR}
    ${PROJECT_SOURCE_DIR}/3rdparty/qwindowkit/include
)

target_include_directories(${PROJECT_NAME} PUBLIC
    ${PROJECT_BINARY_DIR}
)

# Install QML plugin directory
install(DIRECTORY ${RIBBONUI_QML_PLUGIN_DIRECTORY} DESTINATION ${CMAKE_INSTALL_PREFIX}/imports)
