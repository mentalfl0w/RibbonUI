import QtQuick 2.15
import QtGraphicalEffects 1.0
import RibbonUI 1.1

DropShadow {
    property real shadowOpacity: 0.2
    property color shadowColor: RibbonTheme.isDarkMode ? "white" : "black"
    transparentBorder: true
    color:  Qt.rgba(shadowColor.r,shadowColor.g,shadowColor.b,shadowOpacity)
    radius: 8
    horizontalOffset: 0
    verticalOffset: 0
    spread: 0
}
