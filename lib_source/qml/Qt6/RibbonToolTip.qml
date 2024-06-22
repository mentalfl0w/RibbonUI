import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import RibbonUI

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
