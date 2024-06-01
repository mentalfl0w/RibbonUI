import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

Item {
    id:control
    width: container.width
    property alias text: label.text
    property alias showBorder: line.visible
    default property alias content: container.data
    property int contenHeight: container.height
    property bool isDarkMode: RibbonTheme.isDarkMode
    property bool showOpenExternal: false
    property string fontColor: isDarkMode ? "white" : "black"
    property string borderColor: isDarkMode ? "#525252" : "#D4D4D4"
    property alias externalToolTipText: open_external_btn.tipText
    property alias showExternalToolTipText: open_external_btn.showTooltip
    Layout.fillHeight: true
    clip: true
    signal openExternal()

    Text {
        id :label
        text: control.text
        font{
            family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
            pixelSize: 12
            bold: true
        }
        color: fontColor
        height: contentHeight
        renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
        anchors{
            horizontalCenter: control.horizontalCenter
            bottom: control.bottom
            bottomMargin: 5
        }
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    Rectangle{
        id: line
        width: 1
        height: control.height - label.anchors.bottomMargin*3
        color: borderColor
        anchors{
            verticalCenter: control.verticalCenter
            right:control.right
        }
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    Item {
        id: container
        anchors{
            top: control.top
            left: control.left
            right: line.left
            bottom: label.text ? label.top : control.bottom
            margins: 5
        }
        clip: true
    }

    RibbonButton{
        id: open_external_btn
        anchors{
            right: control.right
            bottom: control.bottom
        }
        implicitWidth: ribbonIcon.width + 10
        implicitHeight: ribbonIcon.height + 10
        checkable: false
        ribbonIcon.iconSize: 14
        ribbonIcon.rotation: 90
        showBg: false
        tipText: qsTr("Open ") + label.text + qsTr("'s external")
        iconSource: RibbonIcons.Open
        onClicked: openExternal()
        visible: control.showOpenExternal
    }
}
