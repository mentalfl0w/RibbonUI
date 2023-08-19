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
        color: RibbonTheme.dark_mode ? "white" : "black"
    }

    background: Rectangle {
        radius: 3
        color: RibbonTheme.dark_mode ? "#2C2C29" : "#E0E0E2"
        layer.enabled: true
        layer.effect: RibbonShadow{}
        border.color: dark_mode ? "#5C5D5D" : "#B5B4B5"
        border.width: 1
    }
}
