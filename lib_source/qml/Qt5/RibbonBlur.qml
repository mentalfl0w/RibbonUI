import QtQuick 2.15
import QtGraphicalEffects 1.0
import RibbonUI 1.0

RibbonRectangle {
    id: control
    property bool enableEffect: true
    property int blurRadius: 32
    property alias target: effect.sourceItem
    property rect targetRect : Qt.rect(control.x, control.y, control.width, control.height)
    property color maskColor: RibbonTheme.isDarkMode ? RibbonTheme.modernStyle ? '#292929' : "#212629" : RibbonTheme.modernStyle ? "#F5F5F5" : "#FFFFFF"
    property real maskOpacity: 0.5
    property alias maskBorderColor: mask.borderColor
    property alias maskBorderWidth: mask.borderWidth
    property bool useSolidBg: true
    color: control.useSolidBg ? control.maskColor : 'transparent'

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
        visible: enableEffect
    }

    RibbonRectangle{
        id: mask
        anchors.fill: parent
        color: control.maskColor
        opacity: control.maskOpacity
        radius: control.radius
        topLeftRadius: control.topLeftRadius
        bottomLeftRadius: control.bottomLeftRadius
        topRightRadius: control.topRightRadius
        bottomRightRadius: control.bottomRightRadius
    }
}
