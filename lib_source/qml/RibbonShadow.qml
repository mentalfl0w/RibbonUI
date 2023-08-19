import QtQuick
import Qt5Compat.GraphicalEffects
import RibbonUI

DropShadow {
    property double shadow_opacity: 0.2
    property color shadow_color: RibbonTheme.dark_mode ? "white" : "black"
    transparentBorder: true
    color:  Qt.rgba(shadow_color.r,shadow_color.g,shadow_color.b,shadow_opacity)
    radius: 8
    horizontalOffset: 0
    verticalOffset: 0
    spread: 0
}
