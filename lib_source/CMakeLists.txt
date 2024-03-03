cmake_minimum_required(VERSION 3.21)

project(RibbonUI VERSION ${CMAKE_PROJECT_VERSION} LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

find_package(Qt6 COMPONENTS Core Quick Qml ShaderTools REQUIRED)

set(version_str "${CMAKE_PROJECT_VERSION_MAJOR},${CMAKE_PROJECT_VERSION_MINOR},${CMAKE_PROJECT_VERSION_PATCH}")
add_definitions(-DRIBBONUI_VERSION=${version_str})

if (RIBBONUI_BUILD_STATIC_LIB)
    set(LIB_TYPE "STATIC")
    set(PLUGIN_TARGET_NAME "")
    qt_add_resources(${PROJECT_NAME} RibbonUI.qmltypes qmldir)
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
    qml/RibbonComboBox.qml qml/RibbonSpinBox.qml
)

foreach(qmlfile ${qml_files})
    string(REPLACE "qml/" "" fixedfile ${qmlfile})
    set_source_files_properties(${qmlfile} PROPERTIES QT_RESOURCE_ALIAS ${fixedfile})
endforeach(qmlfile)

qt_add_library(${PROJECT_NAME} ${LIB_TYPE})
qt_add_qml_module(${PROJECT_NAME}
    PLUGIN_TARGET ${PLUGIN_TARGET_NAME}
    OUTPUT_DIRECTORY ${CMAKE_PREFIX_PATH}/qml/RibbonUI
    URI ${PROJECT_NAME}
    VERSION ${CMAKE_PROJECT_VERSION_MAJOR}.${CMAKE_PROJECT_VERSION_MINOR}
    QML_FILES ${qml_files}
    SOURCES ribbonui.cpp ribbonui.h definitions.h ribbontheme.h ribbontheme.cpp
    RESOURCES resources/FluentSystemIcons-Resizable.ttf resources/imgs/icon.png
)

qt_add_shaders(${PROJECT_NAME} "shaders"
    BATCHABLE
    PRECOMPILE
    OPTIMIZED
    PREFIX
        "RibbonUI"
    FILES
        "effects/gaussianblur.frag"
)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Quick
    Qt::CorePrivate
    Qt::QuickPrivate
    Qt::QmlPrivate
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
