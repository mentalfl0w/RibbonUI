import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.15
import RibbonUI 1.0

Item {
    id: root
    height: 25
    clip: true

    property alias leftContent: left.data
    property alias rightContent: right.data
    default property alias content: left.data
    property bool modernStyle: RibbonTheme.modernStyle
    property bool isDarkMode: RibbonTheme.isDarkMode
    property bool showVersion: true
    property real bgOpacity: blurEnabled ? 0.8 : 1
    property bool blurEnabled: typeof Window.window.viewItems !== "undefined"

    anchors{
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    RibbonBlur{
        id: blur
        anchors.fill: parent
        maskColor: modernStyle ? isDarkMode ? "#141414" : "#F5F5F5" : isDarkMode ? "#3D3D3D" : "#D9D9D9"
        maskOpacity: bgOpacity
        useSolidBg: true
        clip: true
        target: Window.window.viewItems ?  Window.window.viewItems : null
        targetRect:  Window.window.viewItems ?
                         Qt.rect(x, Window.window.viewItems.y + Window.window.viewItems.height, width, height) :
                         Qt.rect(0,0,0,0)
        bottomLeftRadius: Qt.platform.os === 'windows' ? RibbonUI.isWin11 ? 7 : 0 : 10
        bottomRightRadius: bottomLeftRadius
        Behavior on maskColor {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    Rectangle{
        visible: !modernStyle
        color: "#3D3D3D"
        anchors.fill: parent
        opacity: bgOpacity
        gradient: Gradient {
            GradientStop { position: 0.0; color: isDarkMode ? "#474949" : "#E4E3E4" }
            GradientStop { position: 0.5; color: isDarkMode ? "#434444" : "#DFDEDE" }
            GradientStop { position: 1.0; color: isDarkMode ? "#3D3D3D" : "#D9D9D9" }
        }
    }

    RibbonRectangle{
        visible: modernStyle
        color: isDarkMode ? "#141414" : "#F5F5F5"
        opacity: bgOpacity
        anchors.fill: parent
        bottomLeftRadius: Qt.platform.os === 'windows' ? RibbonUI.isWin11 ? 7 : 0 : 10
        bottomRightRadius: bottomLeftRadius
    }

    Rectangle{
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        color: isDarkMode ? modernStyle ? "#3B3A39":"#282828" : modernStyle ? "white":"#A1A2A2"
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
            verticalCenter: parent.verticalCenter
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
            verticalCenter: parent.verticalCenter
        }
        layoutDirection: Qt.RightToLeft
        RibbonButton{
            visible: showVersion
            showBg:false
            text: `Designed with RibbonUI V${RibbonUI.version}`
            adaptHeight: true
            showTooltip: false
            onClicked: Qt.openUrlExternally("https://github.com/mentalfl0w/RibbonUI")
        }
    }

    Component.onCompleted: Window.window.bottomBar = root
}
