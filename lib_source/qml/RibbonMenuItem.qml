import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

MenuItem {
    id: control
    property bool dark_mode: RibbonTheme.dark_mode
    property var icon_source
    property var icon_source_filled
    property bool show_tooltip: label.contentWidth < label.implicitWidth
    property alias image_icon: pic_icon
    property alias ribbon_icon: rib_icon
    property string bg_color: !dark_mode ? "#E8E9E9" : "#303131"
    property string hover_color: !dark_mode ? "#506BBD" : "#2A4299"
    property string text_color: dark_mode ? "white" : hovered ? "white" : "black"
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: visible ? Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding) : 0
    opacity: enabled ? 1.0 : 0.3
    padding: 0
    leftPadding: 12
    rightPadding: 0
    verticalPadding: 0
    focusPolicy:Qt.TabFocus
    spacing: 5

    indicator: RibbonIcon {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.checkable || control.checked
        filled: control.hovered || control.pressed
        icon_source: control.checked ? RibbonIcons.CheckmarkCircle : RibbonIcons.Circle
        icon_source_filled: control.checked ? RibbonIcons_Filled.CheckmarkCircle : RibbonIcons_Filled.Circle
        color: text_color
        icon_size: label.contentHeight
    }

    arrow: RibbonIcon {
        x: control.mirrored ? control.padding : control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2
        color: text_color
        visible: control.subMenu
        icon_source: RibbonIcons.ChevronCircleRight
        icon_source_filled: RibbonIcons_Filled.ChevronCircleRight
        icon_size: label.contentHeight
    }

    contentItem: Item{
        RowLayout{
            readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
            readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
            anchors.leftMargin: !control.mirrored ? indicatorPadding : arrowPadding
            anchors.rightMargin: control.mirrored ? indicatorPadding : arrowPadding
            anchors.fill: parent
            spacing: control.spacing
            height: Math.max(rib_icon.visible ? rib_icon.contentHeight : 0, pic_icon.visible ? pic_icon.height : 0, label.contentHeight)
            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight
            width: {
                let w = control.width
                w = w - arrowPadding - indicatorPadding - 25
                return w
            }

            RibbonIcon{
                id :rib_icon
                icon_source: typeof(control.icon_source) === "number" ? control.icon_source : 0
                icon_source_filled: typeof(control.icon_source_filled) === "number" ? control.icon_source_filled : icon_source
                icon_size: label.contentHeight
                visible: typeof(control.icon_source) === "number"
                Layout.alignment: Qt.AlignVCenter
                filled: pressed || checked
                color: text_color
            }
            Image {
                id: pic_icon
                source: typeof(control.icon_source) === "string" ? control.icon_source : ""
                visible: typeof(control.icon_source) === "string"
                fillMode:Image.PreserveAspectFit
                height: label.contentHeight
                width: height
                Layout.alignment: Qt.AlignVCenter
            }
            Text {
                id: label
                text: control.text
                Layout.alignment: Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 13
                elide: Text.ElideRight
                font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                color: text_color
                Layout.preferredWidth:{
                    let w = 0
                    w += rib_icon.visible ? rib_icon.contentWidth : 0
                    w += pic_icon.visible ? pic_icon.width : 0
                    w += (rib_icon.visible || pic_icon.visible) && label.text ? spacing : 0
                    return parent.width - w
                }
            }
            RibbonToolTip{
                id: tooltip
                visible: hovered && show_tooltip && control.text
                text: control.text
            }
        }
    }

    background: Item {
        implicitWidth: 230
        implicitHeight: label.contentHeight + 14
        Rectangle {
            anchors.centerIn: parent
            anchors.margins: 6
            width: parent.width
            height: parent.height - anchors.margins / 2

            clip: visible
            radius: 4
            color: control.hovered ?hover_color : bg_color
        }
    }
}
