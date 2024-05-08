import QtQuick
import QtQuick.Layouts
import RibbonUI

Item {
    id:control
    width: container.width
    property alias text: label.text
    property alias show_border: line.visible
    default property alias content: container.data
    property int contenHeight: container.height
    property bool dark_mode: RibbonTheme.dark_mode
    property bool showOpenExternal: false
    property string font_color: dark_mode ? "white" : "black"
    property string border_color: dark_mode ? "#525252" : "#D4D4D4"
    property alias externalToolTipText: open_external_btn.tip_text
    property alias showExternalToolTipText: open_external_btn.show_tooltip
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
        color: font_color
        height: contentHeight
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
        color: border_color
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
        implicitWidth: ribbon_icon.width + 10
        implicitHeight: ribbon_icon.height + 10
        checkable: false
        ribbon_icon.icon_size: 14
        ribbon_icon.rotation: 90
        show_bg: false
        tip_text: qsTr("Open ") + label.text + qsTr("'s external")
        icon_source: RibbonIcons.Open
        onClicked: openExternal()
        visible: control.showOpenExternal
    }
}
