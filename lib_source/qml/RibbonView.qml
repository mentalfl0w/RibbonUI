import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import RibbonUI

Item {
    id: root
    default property alias content: container.data
    property bool modern_style: RibbonTheme.modern_style
    property bool dark_mode: RibbonTheme.dark_mode
    property int spacing: 5
    property int top_padding: 0
    property int bottom_padding: 0
    property alias bg_color: bg.color
    property alias bg_visible: bg.visible
    z:-2
    clip: true
    width: parent.width

    Rectangle{
        id:bg
        anchors.fill: parent
        color: dark_mode ? "#282828" : "#ECECEC"
        visible: !modern_style
    }

    RibbonBlur{
        id: top_mask
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: Math.abs(top_padding)
        target: container
        mask_opacity: 0
        visible: top_padding
        clip: true
        target_rect: Qt.rect(x,y-top_padding,width,height)
        use_solid_bg: false
    }

    Item{
        id: clipper
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:top_mask.bottom
        implicitHeight: parent.height - Math.abs(top_padding) - Math.abs(bottom_padding)
        implicitWidth: parent.width
        clip: true
        ColumnLayout{
            id:container
            anchors{
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            width: parent.width
        }
    }

    RibbonBlur{
        id: bottom_mask
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: Math.abs(bottom_padding)
        target: container
        mask_opacity: 0
        visible: bottom_padding
        clip: true
        target_rect: Qt.rect(x,y-top_padding,width,height)
        use_solid_bg: false
    }
}
