import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Item {
    id: root
    property bool dark_mode: RibbonTheme.dark_mode
    property bool show_tooltip: true
    property var icon_source
    property string hover_color: dark_mode ? "#414140" : "#D8D9D9"
    property string pressed_color: dark_mode ? "#5B5B5C" : "#BCBCBC"
    property string buddy_hover_color: dark_mode ? "#383838" : "#E1E1E1"
    property string text_color: dark_mode ? "white" : "black"
    property string tip_text: text
    property string text
    default property alias content: m.contentData
    property int icon_size: Math.floor(height * 0.7)
    signal clicked()
    opacity: enabled ? 1.0 : 0.3
    implicitHeight: 50
    implicitWidth: (label.contentWidth > 40 ? label.contentWidth - (m.count ? 5 : -5) : 40) + 12
    RowLayout{
        id: btn
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        spacing: 0
        RibbonRectangle{
            id: left
            topLeftRadius: 3
            bottomLeftRadius: topLeftRadius
            topRightRadius:m.count ? 0 : topLeftRadius
            bottomRightRadius:m.count ? 0 : topLeftRadius
            implicitWidth: root.width - (right.visible ? right.width : 0)
            implicitHeight: root.height - label.contentHeight
            color: {
                if (left_th.pressed)
                    return pressed_color
                if (left_hh.hovered)
                    return hover_color
                if (right_hh.hovered)
                    return buddy_hover_color
                return "transparent"
            }
            RibbonIcon{
                id :rib_icon
                anchors.centerIn: parent
                icon_source: typeof(root.icon_source) === "number" ? root.icon_source : 0
                icon_source_filled: typeof(root.icon_source) === "number" ? root.icon_source - 1 : 0
                icon_size: root.icon_size
                visible: typeof(root.icon_source) === "number"
                Layout.alignment: Qt.AlignVCenter
                filled: left_th.pressed
                color: text_color
            }
            Image {
                id: pic_icon
                anchors.centerIn: parent
                source: typeof(root.icon_source) === "string" ? root.icon_source : ""
                visible: typeof(root.icon_source) === "string"
                fillMode:Image.PreserveAspectFit
                height: left.height
                width: height
                Layout.alignment: Qt.AlignVCenter
            }
            HoverHandler{
                id: left_hh
            }
            TapHandler{
                id: left_th
                onTapped: clicked()
            }
        }
        RibbonRectangle{
            id: right
            topRightRadius:3
            bottomRightRadius:3
            implicitWidth: 12
            implicitHeight: left.height
            visible: m.count
            color: {
                if (right_th.pressed||m.opened)
                    return pressed_color
                if (right_hh.hovered)
                    return hover_color
                if (left_hh.hovered)
                    return buddy_hover_color
                return "transparent"
            }
            RibbonIcon{
                anchors.centerIn: parent
                icon_source: RibbonIcons.ChevronDown
                icon_source_filled: RibbonIcons.ChevronDown - 1
                icon_size: 15
                Layout.alignment: Qt.AlignVCenter
                filled: right_th.pressed
                color: text_color
            }
            HoverHandler{
                id: right_hh
            }
            TapHandler{
                id: right_th
                onTapped: m.popup()
            }
        }
    }

    Text {
        id: label
        text: root.text
        anchors{
            top: btn.bottom
            horizontalCenter: btn.horizontalCenter
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
        color: text_color
    }

    RibbonToolTip{
        text: tip_text
        visible: (left_hh.hovered || right_hh.hovered)&& show_tooltip && text
    }

    RibbonMenu{
        id:m
        width: 100
    }
}
