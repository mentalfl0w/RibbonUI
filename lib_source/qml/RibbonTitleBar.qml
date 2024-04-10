import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Item {
    id: control
    height: 30
    property int minimumWidth: title_text.implicitWidth + Math.max(left_container.width, right_container.width) * 2 + (Qt.platform.os === "osx" ? 65 : 0) + 20
    property string title: Window.window.title
    property bool show_style_switch: true
    property bool show_darkmode_btn: true
    property bool show_pin_btn: true
    property bool dark_mode: RibbonTheme.dark_mode
    property bool modern_style: RibbonTheme.modern_style
    property string title_color: modern_style ? "transparent" : dark_mode ? "#282828" : "#2C59B7"
    property string title_text_color: modern_style ? dark_mode ? "white" : "black" : "white"
    default property alias content: left_container.data
    property alias left_content: left_container.data
    property alias right_content: right_container.data
    property alias left_container: left_container
    property alias right_container: right_container
    property alias maximizeBtn: maximizeBtn
    property alias minimizeBtn: minimizeBtn
    property alias closeBtn: closeBtn
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }
    z: 100

    Rectangle{
        id: bg
        anchors.fill: parent
        color: title_color
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    Text {
        id: title_text
        anchors.centerIn: parent
        text: control.title
        font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
        color: title_text_color
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    RowLayout{
        id: left_container
        spacing: 1
        anchors{
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            leftMargin: Qt.platform.os === "osx" ? 65 : 10
        }
        Layout.maximumWidth: (parent.width - title_text.contentWidth) / 2
    }

    RowLayout{
        id: right_container
        spacing: 1
        anchors{
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
        }
        Layout.maximumWidth: (parent.width - title_text.contentWidth) / 2
        layoutDirection: Qt.RightToLeft
        RowLayout{
            visible: Qt.platform.os !== "osx"
            layoutDirection: Qt.RightToLeft
            spacing: 0
            Layout.rightMargin: Qt.platform.os === "osx" ? -5 : 0
            RibbonButton{
                id: closeBtn
                show_bg:false
                icon_source: RibbonIcons.Dismiss
                icon_source_filled: RibbonIcons_Filled.Dismiss
                text_color: titleBar.title_text_color
                hover_color: "#ED6B5E"
                pressed_color: "#B55149"
                text_color_reverse: false
                tip_text: qsTr("Close")
                onClicked: Window.window.close()
            }

            RibbonButton{
                id: minimizeBtn
                show_bg:false
                icon_source: RibbonIcons.Subtract
                icon_source_filled: RibbonIcons_Filled.Subtract
                text_color: titleBar.title_text_color
                hover_color: "#F4BE4F"
                pressed_color: "#B78F3B"
                text_color_reverse: false
                tip_text: qsTr("Minimize")
                font.bold: pressed || checked
                onClicked: Window.window.visibility = Window.Minimized
            }

            RibbonButton{
                id: maximizeBtn
                show_bg:false
                icon_source: Window.window.visibility === Window.Maximized ? RibbonIcons.ArrowMinimize : RibbonIcons.ArrowMaximize
                text_color: titleBar.title_text_color
                hover_color: "#61C554"
                pressed_color: "#48953F"
                text_color_reverse: false
                tip_text: Window.window.visibility === Window.Maximized ? qsTr("Restore") : qsTr("Maximize")
                onClicked: {
                    if (Window.window.visibility === Window.Maximized)
                        Window.window.visibility = Window.Windowed
                    else
                        Window.window.visibility = Window.Maximized
                }
            }
        }
        RibbonSwitchButton{
            text: qsTr("Style")
            grabber_text: checked ? qsTr("Modern") : qsTr("Classic")
            text_color: titleBar.title_text_color
            grabber_color: "#F9F9F9"
            grabber_checked_color: "#BEC1C9"
            grabber_unchecked_color: "#334668"
            grabber_text_unchecked_color: "white"
            grabber_text_checked_color: "black"
            onClicked: RibbonTheme.modern_style = checked
            checked: RibbonTheme.modern_style
            visible: show_style_switch
        }
        RibbonButton{
            show_bg:false
            icon_source: RibbonIcons.DarkTheme
            icon_source_filled: RibbonIcons_Filled.DarkTheme
            checkable: true
            tip_text: qsTr("Dark Mode")
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color: title_text_color
            text_color_reverse: false
            onClicked: {
                RibbonTheme.theme_mode = checked ? RibbonThemeType.Dark : RibbonThemeType.Light
            }
            checked: RibbonTheme.dark_mode
            visible: show_darkmode_btn
        }
        RibbonButton{
            id: pinBtn
            show_bg:false
            icon_source: checked ? RibbonIcons.Pin : RibbonIcons.PinOff
            icon_source_filled: checked ? RibbonIcons_Filled.Pin : RibbonIcons_Filled.PinOff
            checkable: true
            text_color: title_text_color
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color_reverse: false
            tip_text: qsTr("Stay on Top")
            onClicked: Window.window.flags ^= Qt.WindowStaysOnTopHint
            visible: control.show_pin_btn
        }
    }
}
