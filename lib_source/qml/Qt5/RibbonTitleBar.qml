import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.15
import RibbonUI 1.0

Item {
    id: control
    height: 30
    property int minimumWidth: mid_layout.implicitWidth + Math.max(leftContainer.width, rightContainer.width) * 2 + (Qt.platform.os === "osx" ? 65 : 0) + 20
    property string title: Window.window.title
    property bool showStyleSwitch: true
    property bool showDarkmodeBtn: true
    property bool showPinBtn: true
    property bool isDarkMode: RibbonTheme.isDarkMode
    property bool modernStyle: RibbonTheme.modernStyle
    property string titleColor: modernStyle ? "transparent" : isDarkMode ? "#282828" : "#2C59B7"
    property string titleTextColor: modernStyle ? isDarkMode ? "white" : "black" : "white"
    property var titleIconSource
    property var titleIconSourceFilled
    property var titleIcon: typeof(control.titleIconSource) === "string" ? pic_icon : rib_icon
    default property alias content: leftContainer.data
    property alias leftContent: leftContainer.data
    property alias rightContent: rightContainer.data
    property alias leftContainer: leftContainer
    property alias rightContainer: rightContainer
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
        color: titleColor
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }


    RowLayout{
        id: mid_layout
        anchors.centerIn: parent
        RibbonIcon{
            id :rib_icon
            iconSource: typeof(control.titleIconSource) === "number" ? control.titleIconSource : 0
            iconSourceFilled: typeof(control.titleIconSourceFilled) === "number" ? control.titleIconSourceFilled : iconSource
            iconSize: title_text.contentHeight
            visible: typeof(control.titleIconSource) === "number"
            Layout.preferredHeight: title_text.visible ? title_text.contentHeight : 16
            Layout.preferredWidth: Layout.preferredHeight
            Layout.alignment: Qt.AlignVCenter
            filled: mouse.pressed
            color: {
                if (mouse.containsMouse || mouse.pressed)
                    return Qt.lighter(titleTextColor)
                else
                    return titleTextColor
            }
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
            MouseArea{
                id: mouse
                hoverEnabled: true
            }
        }
        Image {
            id: pic_icon
            source: typeof(control.titleIconSource) === "string" ? control.titleIconSource : ""
            visible: typeof(control.titleIconSource) === "string"
            fillMode:Image.PreserveAspectFit
            mipmap: true
            autoTransform: true
            Layout.preferredHeight: title_text.visible ? title_text.contentHeight : 16
            Layout.preferredWidth: Layout.preferredHeight
            Layout.alignment: Qt.AlignVCenter
        }
        Text {
            id: title_text
            text: control.title
            font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
            color: titleTextColor
            renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
            Layout.alignment: Qt.AlignVCenter
            visible: text
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
    }

    RowLayout{
        id: leftContainer
        spacing: 1
        anchors{
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            leftMargin: Qt.platform.os === "osx" && Window.window.visibility === Window.Windowed && Window.active ? 65 : 10
        }
        Behavior on anchors.leftMargin {
            NumberAnimation{
                duration: 50
                easing.type: Easing.OutSine
            }
        }
        Layout.maximumWidth: (parent.width - mid_layout.contentWidth) / 2
    }

    RowLayout{
        id: rightContainer
        spacing: 1
        anchors{
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
        }
        Layout.maximumWidth: (parent.width - mid_layout.contentWidth) / 2
        layoutDirection: Qt.RightToLeft
        RowLayout{
            visible: Qt.platform.os !== "osx"
            layoutDirection: Qt.RightToLeft
            spacing: 0
            Layout.rightMargin: Qt.platform.os === "osx" ? -5 : 0
            RibbonButton{
                id: closeBtn
                showBg:false
                iconSource: RibbonIcons.Dismiss
                iconSourceFilled: RibbonIcons_Filled.Dismiss
                textColor: titleBar.titleTextColor
                hoverColor: "#ED6B5E"
                pressedColor: "#B55149"
                textColorReverse: false
                tipText: qsTr("Close")
                onClicked: Window.window.close()
            }

            RibbonButton{
                id: minimizeBtn
                showBg:false
                iconSource: RibbonIcons.Subtract
                iconSourceFilled: RibbonIcons_Filled.Subtract
                textColor: titleBar.titleTextColor
                hoverColor: "#F4BE4F"
                pressedColor: "#B78F3B"
                textColorReverse: false
                tipText: qsTr("Minimize")
                font.bold: pressed || checked
                onClicked: Window.window.visibility = Window.Minimized
            }

            RibbonButton{
                id: maximizeBtn
                showBg:false
                iconSource: Window.window.visibility === Window.Maximized ? RibbonIcons.ArrowMinimize : RibbonIcons.ArrowMaximize
                textColor: titleBar.titleTextColor
                hoverColor: "#61C554"
                pressedColor: "#48953F"
                textColorReverse: false
                tipText: Window.window.visibility === Window.Maximized ? qsTr("Restore") : qsTr("Maximize")
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
            grabberText: checked ? qsTr("Modern") : qsTr("Classic")
            textColor: titleBar.titleTextColor
            grabberColor: "#F9F9F9"
            grabberCheckedColor: "#BEC1C9"
            grabberUncheckedColor: "#334668"
            grabberTextUncheckedColor: "white"
            grabberTextCheckedColor: "black"
            onClicked: RibbonTheme.modernStyle = checked
            checked: RibbonTheme.modernStyle
            visible: showStyleSwitch
        }
        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.DarkTheme
            iconSourceFilled: RibbonIcons_Filled.DarkTheme
            checkable: true
            tipText: qsTr("Dark Mode")
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColor: titleTextColor
            textColorReverse: false
            onClicked: {
                RibbonTheme.themeMode = checked ? RibbonThemeType.Dark : RibbonThemeType.Light
            }
            checked: RibbonTheme.isDarkMode
            visible: showDarkmodeBtn
        }
        RibbonButton{
            id: pinBtn
            showBg:false
            iconSource: checked ? RibbonIcons.Pin : RibbonIcons.PinOff
            iconSourceFilled: checked ? RibbonIcons_Filled.Pin : RibbonIcons_Filled.PinOff
            checkable: true
            textColor: titleTextColor
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColorReverse: false
            tipText: qsTr("Stay on Top")
            onClicked: Window.window.flags ^= Qt.WindowStaysOnTopHint
            visible: control.showPinBtn
        }
    }
}
