import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

MenuItem {
    id: control
    property bool isDarkMode: RibbonTheme.isDarkMode
    property var iconSource
    property var iconSourceFilled
    property bool showTooltip: label.contentWidth < label.implicitWidth
    property alias imageIcon: pic_icon
    property alias ribbonIcon: rib_icon
    property string bgColor: !isDarkMode ? "#E8E9E9" : "#303131"
    property string hoverColor: !isDarkMode ? "#506BBD" : "#2A4299"
    property string textColor: isDarkMode ? "white" : hovered ? "white" : "black"
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
        iconSource: control.checked ? RibbonIcons.CheckmarkCircle : RibbonIcons.Circle
        iconSourceFilled: control.checked ? RibbonIcons_Filled.CheckmarkCircle : RibbonIcons_Filled.Circle
        color: textColor
        iconSize: label.contentHeight
    }

    arrow: RibbonIcon {
        x: control.mirrored ? control.padding : control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2
        color: textColor
        visible: control.subMenu
        iconSource: RibbonIcons.ChevronCircleRight
        iconSourceFilled: RibbonIcons_Filled.ChevronCircleRight
        iconSize: label.contentHeight
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
                iconSource: typeof(control.iconSource) === "number" ? control.iconSource : 0
                iconSourceFilled: typeof(control.iconSourceFilled) === "number" ? control.iconSourceFilled : iconSource
                iconSize: label.visible ? label.contentHeight : 16
                visible: typeof(control.iconSource) === "number" && control.iconSource
                Layout.alignment: Qt.AlignVCenter
                filled: pressed || checked
                color: textColor
            }
            Image {
                id: pic_icon
                source: typeof(control.iconSource) === "string" ? control.iconSource : ""
                visible: typeof(control.iconSource) === "string"
                fillMode:Image.PreserveAspectFit
                mipmap: true
                autoTransform: true
                height: label.visible ? label.contentHeight : 16
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
                color: textColor
                renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                visible: text
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
                visible: hovered && showTooltip && control.text
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
            color: control.hovered ?hoverColor : bgColor
        }
    }
}
