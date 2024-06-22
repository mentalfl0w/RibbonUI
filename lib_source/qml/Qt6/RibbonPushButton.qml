import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Item {
    id: root
    property bool isDarkMode: RibbonTheme.isDarkMode
    property bool showTooltip: true
    property var iconSource
    property string hoverColor: isDarkMode ? "#414140" : "#D8D9D9"
    property string pressedColor: isDarkMode ? "#5B5B5C" : "#BCBCBC"
    property string buddyHoverColor: isDarkMode ? "#383838" : "#E1E1E1"
    property string textColor: isDarkMode ? "white" : "black"
    property string tipText: text
    property string text
    default property alias content: m.contentData
    property int iconSize: Math.floor(height * 0.7)
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
                    return pressedColor
                if (left_hh.hovered)
                    return hoverColor
                if (right_hh.hovered)
                    return buddyHoverColor
                return "transparent"
            }
            RibbonIcon{
                id :rib_icon
                anchors.centerIn: parent
                iconSource: typeof(root.iconSource) === "number" ? root.iconSource : 0
                iconSourceFilled: typeof(root.iconSource) === "number" ? root.iconSource - 1 : 0
                iconSize: root.iconSize
                visible: typeof(root.iconSource) === "number"
                Layout.alignment: Qt.AlignVCenter
                filled: left_th.pressed
                color: textColor
            }
            Image {
                id: pic_icon
                anchors.centerIn: parent
                source: typeof(root.iconSource) === "string" ? root.iconSource : ""
                visible: typeof(root.iconSource) === "string"
                fillMode:Image.PreserveAspectFit
                mipmap: true
                autoTransform: true
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
                    return pressedColor
                if (right_hh.hovered)
                    return hoverColor
                if (left_hh.hovered)
                    return buddyHoverColor
                return "transparent"
            }
            RibbonIcon{
                anchors.centerIn: parent
                iconSource: RibbonIcons.ChevronDown
                iconSourceFilled: RibbonIcons.ChevronDown - 1
                iconSize: 15
                Layout.alignment: Qt.AlignVCenter
                filled: right_th.pressed
                color: textColor
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
        renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
        color: textColor
    }

    RibbonToolTip{
        text: tipText
        visible: (left_hh.hovered || right_hh.hovered)&& showTooltip && text
    }

    RibbonMenu{
        id:m
        width: 100
    }
}
