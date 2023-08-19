import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

TextField{
    id: control
    autoScroll:true
    property bool dark_mode: RibbonTheme.dark_mode
    property int icon_source
    property bool show_clear_btn: true
    property alias clear_btn: clear_btn
    property alias icon: icon
    focus: true
    color: dark_mode ? "white" : "black"
    padding: 5
    leftPadding: icon.visible ? icon.contentWidth + padding*2 : padding
    rightPadding: clear_btn.visible ? clear_btn.width + padding*2 : padding
    placeholderText: qsTr("Please input:")
    placeholderTextColor: dark_mode ? Qt.rgba(255,255,255,0.5) : Qt.rgba(0,0,0,0.5)
    selectByMouse: true
    selectionColor: dark_mode ? "#4F5E7F" : "#BECDE8"
    selectedTextColor: dark_mode ? "white" : "black"
    opacity: enabled ? 1.0 : 0.3
    signal commit()
    width:150
    height:20
    onCommit: cursorVisible = false
    background: Rectangle{
        radius: 4
        implicitHeight: 20
        implicitWidth: 150
        color: dark_mode ? "#383838" : "#FFFFFF"
        border.color: control.cursorVisible ? dark_mode ? "#869CCD" : "#486495" : dark_mode ? "#5E5F5E" : "#B9B9B8"
        border.width: 1
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }
    Keys.onEnterPressed: commit()
    Keys.onReturnPressed: commit()
    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.RightButton
        onClicked: control.echoMode !== TextInput.Password && menu.popup()
        focus: true
    }
    RibbonTextBoxMenu{
        id:menu
        input_item: control
    }
    RibbonIcon{
        id: icon
        anchors{
            left: parent.left
            leftMargin: parent.padding
            verticalCenter: parent.verticalCenter
        }
        icon_source: parent.icon_source
        icon_size: parent.height - parent.padding
        visible: icon_source
        color: dark_mode ? "white" : "black"
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }
    RibbonButton{
        id: clear_btn
        anchors{
            right: parent.right
            rightMargin: parent.padding
            verticalCenter: parent.verticalCenter
        }
        show_bg: false
        show_hovered_bg: false
        tip_text: qsTr("Clear")
        icon_source: RibbonIcons.Dismiss
        height: parent.height - parent.padding
        width: height
        visible: parent.text&&show_clear_btn&&control.cursorVisible
        onClicked: parent.clear()
    }
}
