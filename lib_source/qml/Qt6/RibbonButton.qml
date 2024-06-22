import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Button {
    id: root
    property bool isDarkMode: RibbonTheme.isDarkMode
    property bool showBg: true
    property bool showHoveredBg: true
    property bool adaptHeight: false
    property bool showTooltip: true
    property var iconSource
    property var iconSourceFilled
    property alias imageIcon: pic_icon
    property alias ribbonIcon: rib_icon
    property string bgColor: isDarkMode ? "#626262" : "white"
    property string hoverColor: isDarkMode ? showBg ? "#818181" : "#5E5D5D" : showBg ? "#ECEAE9" : "#B0B0B1"
    property string pressedColor: isDarkMode ? showBg ? "#424242" : "#5C5C5C" : showBg ? "#CCCBCB" : "#9D9B9B"
    property string checkedColor: pressedColor
    property string textColor: isDarkMode ? "white" : "black"
    property bool textColorReverse: true
    property string tipText: text
    opacity: enabled ? 1.0 : 0.3
    padding: 0
    leftPadding: 0
    rightPadding: 0
    focusPolicy:Qt.TabFocus
    background: Rectangle{
        implicitWidth: contentItem.implicitWidth
        implicitHeight: contentItem.implicitHeight
        visible: showBg
        border.color: isDarkMode ? "#7F7F7F" : "#D2D1CE"
        border.width: 1
        radius: 3
        color: bgColor
    }
    contentItem: Item{
        clip: true
        implicitWidth: layout.width + 13
        implicitHeight: adaptHeight?root.parent.height>=layout.height?root.parent.height:layout.height:layout.height + 10
        Rectangle{
            anchors.fill: parent
            radius: 3
            color: {
                if (root.pressed)
                    return pressedColor
                if (root.hovered)
                    return hoverColor
                if (root.checked)
                    return checkedColor
                return "transparent"
            }
            visible: showHoveredBg
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
                iconSource: typeof(root.iconSource) === "number" ? root.iconSource : 0
                iconSourceFilled: typeof(root.iconSourceFilled) === "number" ? root.iconSourceFilled : iconSource
                iconSize: label.visible ? label.contentHeight : 16
                visible: typeof(root.iconSource) === "number"
                Layout.alignment: Qt.AlignVCenter
                filled: pressed || checked
                color: {
                    if (!showBg && (hovered || checked || pressed) && textColorReverse)
                        return Qt.lighter(textColor)
                    else
                        return textColor
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
                source: typeof(root.iconSource) === "string" ? root.iconSource : ""
                visible: typeof(root.iconSource) === "string"
                fillMode:Image.PreserveAspectFit
                height: label.visible ? label.contentHeight : 16
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
                renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                visible: text
                color: {
                    if (!showBg && (hovered || checked || pressed) && textColorReverse)
                        return Qt.lighter(textColor)
                    else
                        return textColor
                }
            }
        }
        RibbonToolTip{
            text: tipText
            visible: hovered && showTooltip && text
        }
    }
}
