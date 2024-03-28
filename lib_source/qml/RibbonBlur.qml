import QtQuick
import Qt5Compat.GraphicalEffects
import RibbonUI

Item {
    id: control
    property int radius: 0
    property int blur_radius: 32
    property alias target: effect.sourceItem
    property rect target_rect : Qt.rect(control.x, control.y, control.width, control.height)
    property color mask_color: RibbonTheme.dark_mode ? "#212629" : "white"
    property double mask_opacity: 0.5
    property alias mask_border: mask.border

    ShaderEffectSource {
        id: effect
        anchors.fill: parent
        sourceRect: target_rect
        sourceItem: target
        visible: false
        Rectangle{
            radius: control.radius
            visible: false
        }
    }

    GaussianBlur{
        id: blur
        anchors.fill: parent
        radius: blur_radius
        deviation: 8
        samples: (radius / 4) * 3
        source: effect
        visible: false
    }

    OpacityMask {
        anchors.fill: parent
        source: blur
        maskSource: Rectangle{
            width: control.width
            height: control.height
            radius: control.radius
        }
    }

    Rectangle{
        id: mask
        anchors.fill: parent
        color: mask_color
        opacity: mask_opacity
        radius: control.radius
    }


}
