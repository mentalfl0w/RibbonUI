import QtQuick 2.15
import QtGraphicalEffects 1.0
import RibbonUI 1.0

Item {
    id: control
    property int radius: 0
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
        sourceItem: control.target
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

    Rectangle{
        anchors.fill: parent
        color: control.useSolidBg ? control.maskColor : 'transparent'
        radius: control.radius
        OpacityMask {
            anchors.fill: parent
            source: blur
            maskSource: Rectangle{
                width: control.width
                height: control.height
                radius: control.radius
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
