import QtQuick
import Qt5Compat.GraphicalEffects
import RibbonUI

Item {
    id: control
    property int radius: 0
    property int topLeftRadius: radius
    property int bottomLeftRadius: radius
    property int topRightRadius: radius
    property int bottomRightRadius: radius
    property int blurRadius: 32
    property alias target: effect.sourceItem
    property rect targetRect : Qt.rect(control.x, control.y, control.width, control.height)
    property color maskColor: RibbonTheme.isDarkMode ? RibbonTheme.modernStyle ? '#292929' : "#212629" : RibbonTheme.modernStyle ? "#F5F5F5" : "#FFFFFF"
    property real maskOpacity: 0.5
    property alias maskBorder: mask.border
    property bool useSolidBg: true

    ShaderEffectSource {
        id: effect
        anchors.fill: parent
        sourceRect: control.targetRect
        visible: false
    }

    GaussianBlur{
        id: blur
        anchors.fill: parent
        radius: control.blurRadius
        deviation: 8
        samples: (control.blurRadius / 4) * 3
        source: effect
        visible: false
    }

    RibbonRectangle{
        anchors.fill: parent
        color: control.useSolidBg ? control.maskColor : 'transparent'
        radius: control.radius
        topLeftRadius: control.topLeftRadius
        bottomLeftRadius: control.bottomLeftRadius
        topRightRadius: control.topRightRadius
        bottomRightRadius: control.bottomRightRadius
        OpacityMask {
            anchors.fill: parent
            source: blur
            maskSource: RibbonRectangle{
                width: control.width
                height: control.height
                radius: control.radius
                topLeftRadius: control.topLeftRadius
                bottomLeftRadius: control.bottomLeftRadius
                topRightRadius: control.topRightRadius
                bottomRightRadius: control.bottomRightRadius
            }
        }
    }

    Rectangle{
        id: mask
        anchors.fill: parent
        color: control.maskColor
        opacity: control.maskOpacity
        radius: control.radius
    }
}
