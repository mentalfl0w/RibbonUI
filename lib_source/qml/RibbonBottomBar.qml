import QtQuick
import QtQuick.Layouts
import RibbonUI

Item {
    id: root
    height: 25
    clip: true

    property alias left_content: left.data
    property alias right_content: right.data
    default property alias content: left.data
    property bool modern_style: RibbonTheme.modern_style
    property bool dark_mode: RibbonTheme.dark_mode
    property bool show_version: true
    property double bg_opacity: 0.8

    anchors{
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    Rectangle{
        visible: !modern_style
        color: "#3D3D3D"
        anchors.fill: parent
        opacity: bg_opacity
        gradient: Gradient {
            GradientStop { position: 0.0; color: dark_mode ? "#474949" : "#E4E3E4" }
            GradientStop { position: 0.5; color: dark_mode ? "#434444" : "#DFDEDE" }
            GradientStop { position: 1.0; color: dark_mode ? "#3D3D3D" : "#D9D9D9" }
        }
    }

    Rectangle{
        visible: modern_style
        color: dark_mode ? "#141414" : "#F5F5F5"
        opacity: bg_opacity
        anchors.fill: parent
    }

    Rectangle{
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        color: dark_mode ? modern_style ? "#3B3A39":"#282828" : modern_style ? "white":"#A1A2A2"
        height: 1
    }

    RowLayout{
        id: left
        Layout.maximumWidth: parent.width - right.width
        height: parent.height
        spacing: 1
        anchors{
            left: parent.left
            leftMargin: 20
        }
    }

    RowLayout{
        id: right
        Layout.maximumWidth: parent.width - left.width
        height: parent.height
        spacing: 1
        anchors{
            right: parent.right
            rightMargin: 20
        }
        layoutDirection: Qt.RightToLeft
        RibbonButton{
            visible: show_version
            show_bg:false
            text: `Designed with RibbonUI V${RibbonUI.version}`
            adapt_height: true
            show_tooltip: false
            onClicked: Qt.openUrlExternally("https://github.com/mentalfl0w/RibbonUI")
        }
    }
}
