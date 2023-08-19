import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Button {
    id: root
    property bool dark_mode: RibbonTheme.dark_mode
    property bool show_bg: true
    property bool show_hovered_bg: true
    property bool adapt_height: false
    property bool show_tooltip: true
    property var icon_source
    property var icon_source_filled
    property alias image_icon: pic_icon
    property alias ribbon_icon: rib_icon
    property string bg_color: dark_mode ? "#626262" : "white"
    property string hover_color: dark_mode ? show_bg ? "#818181" : "#5E5D5D" : show_bg ? "#ECEAE9" : "#B0B0B1"
    property string pressed_color: dark_mode ? show_bg ? "#424242" : "#5C5C5C" : show_bg ? "#CCCBCB" : "#9D9B9B"
    property string checked_color: pressed_color
    property string text_color: dark_mode ? "white" : "black"
    property bool text_color_reverse: true
    property string tip_text: text
    opacity: enabled ? 1.0 : 0.3
    padding: 0
    leftPadding: 0
    rightPadding: 0
    focusPolicy:Qt.TabFocus
    background: Rectangle{
        implicitWidth: contentItem.implicitWidth
        implicitHeight: contentItem.implicitHeight
        visible: show_bg
        border.color: dark_mode ? "#7F7F7F" : "#D2D1CE"
        border.width: 1
        radius: 3
        color: bg_color
    }
    contentItem: Item{
        implicitWidth: layout.width + 13
        implicitHeight: adapt_height?root.parent.height>=layout.height?root.parent.height:layout.height:layout.height + 10
        Rectangle{
            anchors.fill: parent
            radius: 3
            color: {
                if (root.pressed)
                    return pressed_color
                if (root.hovered)
                    return hover_color
                if (root.checked)
                    return checked_color
                return "transparent"
            }
            visible: show_hovered_bg
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
        RowLayout{
            id: layout
            anchors.centerIn: parent
            height: Math.max(rib_icon.visible ? rib_icon.contentHeight : 0, pic_icon.visible ? pic_icon.height : 0, label.contentHeight)

            width: {
                let w = 0
                w += rib_icon.visible ? rib_icon.contentWidth : 0
                w += pic_icon.visible ? pic_icon.width : 0
                w += label.text ? label.contentWidth : 0
                w += (rib_icon.visible || pic_icon.visible) && label.text ? spacing : 0
                return w
            }

            RibbonIcon{
                id :rib_icon
                icon_source: typeof(root.icon_source) === "number" ? root.icon_source : 0
                icon_source_filled: typeof(root.icon_source_filled) === "number" ? root.icon_source_filled : icon_source
                icon_size: label.contentHeight
                visible: typeof(root.icon_source) === "number"
                Layout.alignment: Qt.AlignVCenter
                filled: pressed || checked
                color: {
                    if (!show_bg && (hovered || checked || pressed) && text_color_reverse)
                        return Qt.lighter(text_color)
                    else
                        return text_color
                }
                Behavior on color {
                    ColorAnimation {
                        duration: 60
                        easing.type: Easing.OutSine
                    }
                }
            }
            Image {
                id: pic_icon
                source: typeof(root.icon_source) === "string" ? root.icon_source : ""
                visible: typeof(root.icon_source) === "string"
                fillMode:Image.PreserveAspectFit
                height: label.contentHeight
                width: height
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                id: label
                text: root.text
                Layout.alignment: Qt.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
                font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                color: {
                    if (!show_bg && (hovered || checked || pressed) && text_color_reverse)
                        return Qt.lighter(text_color)
                    else
                        return text_color
                }
            }
        }
        RibbonToolTip{
            text: tip_text
            visible: hovered && show_tooltip && text
        }
    }
}
