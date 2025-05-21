import QtQuick 2.15
import RibbonUI 1.1 
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

RibbonRectangle {
    id: control

    property var dealWithLog: showLog
    property string picSource: "qrc:/qt/qml/RibbonUI/resources/imgs/icon.png"
    property string labelText: "Dylan Liu's Lab"
    property string titleText: "RibbonUI"
    property string subTitleText: "A lightweight UI framework."

    color: {
        if (Window.window.blurBehindWindow) {
            return "transparent"
        }
        if (RibbonTheme.isDarkMode) {
            return '#2C2B29'
        }
        return '#FFFFFF'
    }
    implicitHeight: Math.max(250, btn_layout.height + title_layout.height + log_text.height + btn_layout.anchors.topMargin * 2)
    implicitWidth: Math.max(450, title_layout.width + btn_layout.anchors.topMargin * 2)
    radius: 20

    Behavior on color {
        ColorAnimation {
            duration: 60
            easing.type: Easing.OutSine
        }
    }

    RowLayout{
        id: btn_layout
        layoutDirection: Qt.platform.os === 'osx' ? Qt.RightToLeft : Qt.LeftToRight
        anchors{
            top:parent.top
            topMargin: 8
            right: Qt.platform.os === 'osx' ? undefined : parent.right
            rightMargin: Qt.platform.os === 'osx' ? undefined : anchors.topMargin
            left: Qt.platform.os === 'osx' ? parent.left : undefined
            leftMargin: Qt.platform.os === 'osx' ? anchors.topMargin : undefined
        }
        RibbonButton{
            showBg: false
            showHoveredBg: false
            iconSource: RibbonIcons.Subtract
            onClicked: Window.window.visibility = Window.Minimized
        }
        RibbonButton{
            showBg: false
            showHoveredBg: false
            iconSource: RibbonIcons.Dismiss
            onClicked: Qt.quit()
        }
    }
    RowLayout{
        anchors{
            top: parent.top
            topMargin: btn_layout.anchors.topMargin
            right: Qt.platform.os !== 'osx' ? undefined : parent.right
            rightMargin: Qt.platform.os !== 'osx' ? undefined : anchors.topMargin
            left: Qt.platform.os !== 'osx' ? parent.left : undefined
            leftMargin: Qt.platform.os !== 'osx' ? anchors.topMargin : undefined
        }
        Image {
            id: pic
            source: control.picSource
            visible: typeof(control.picSource) === "string"
            fillMode:Image.PreserveAspectFit
            mipmap: true
            autoTransform: true
            Layout.preferredHeight: label_text.visible ? label_text.contentHeight : 16
            Layout.preferredWidth: Layout.preferredHeight
            Layout.alignment: Qt.AlignVCenter
        }
        Text {
            id: label_text
            text: control.labelText
            Layout.alignment: Qt.AlignVCenter
            font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
            font.pixelSize: 16
            color: RibbonTheme.isDarkMode ? "white" : "black"
            renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
            visible: text
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
    }
    ColumnLayout{
        id: title_layout
        anchors.centerIn: parent
        spacing: -5
        Text {
            id: title_text
            text: control.titleText
            Layout.alignment: Qt.AlignHCenter
            font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
            font.pixelSize: 50
            color: RibbonTheme.isDarkMode ? "white" : "black"
            renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
            visible: text
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
        Text {
            id: subtitle_text
            text: control.subTitleText
            Layout.alignment: Qt.AlignHCenter
            font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
            font.pixelSize: 15
            color: RibbonTheme.isDarkMode ? "white" : "black"
            renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
            visible: text
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
        RibbonBusyBar{
            Layout.topMargin: btn_layout.anchors.topMargin - title_layout.spacing
            running: true
            barWidth: control.width - btn_layout.anchors.topMargin * 4
        }
    }

    Text {
        id: log_text
        anchors{
            left: parent.left
            leftMargin: btn_layout.anchors.topMargin
            bottom: parent.bottom
            bottomMargin: btn_layout.anchors.topMargin
        }
        text: qsTr("Loading...")
        font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
        font.pixelSize: 10
        color: RibbonTheme.isDarkMode ? "white" : "black"
        renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
        visible: text
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    function showLog(log, others){
        log_text.text = log
    }
}
