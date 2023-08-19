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
    property string font_color: dark_mode ? "white" : "black"
    property string border_color: dark_mode ? "#525252" : "#D4D4D4"
    Layout.fillHeight: true
    clip: true

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
}
