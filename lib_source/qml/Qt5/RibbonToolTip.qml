import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.15
import RibbonUI 1.1

ToolTip {
    id: control
    delay: 1000
    font.pixelSize: 10
    font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
    contentItem: Text {
        text: control.text
        font: control.font
        color: RibbonTheme.isDarkMode ? "white" : "black"
        renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
    }

    background: Rectangle {
        radius: 3
        color: RibbonTheme.modernStyle ? isDarkMode ? "black" : "white" : RibbonTheme.isDarkMode ? "#2C2C29" : "#E0E0E2"
        layer.enabled: !RibbonTheme.modernStyle
        layer.effect: RibbonShadow{}
        border.color: RibbonTheme.modernStyle ? isDarkMode ? "#ADADAD" : "#616161" : isDarkMode ? "#5C5D5D" : "#B5B4B5"
        border.width: 1
    }
}
