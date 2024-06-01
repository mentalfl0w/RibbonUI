import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

TextField{
    id: control
    autoScroll:true
    property bool isDarkMode: RibbonTheme.isDarkMode
    property int iconSource
    property bool showClearBtn: true
    property alias clearBtn: clearBtn
    property alias icon: icon
    focus: true
    color: isDarkMode ? "white" : "black"
    padding: 5
    leftPadding: icon.visible ? icon.contentWidth + padding*2 : padding
    rightPadding: clearBtn.visible ? clearBtn.width + padding*2 : padding
    placeholderText: qsTr("Please input:")
    placeholderTextColor: isDarkMode ? Qt.rgba(255,255,255,0.5) : Qt.rgba(0,0,0,0.5)
    selectByMouse: true
    selectionColor: isDarkMode ? "#4F5E7F" : "#BECDE8"
    selectedTextColor: isDarkMode ? "white" : "black"
    opacity: enabled ? 1.0 : 0.3
    signal commit()
    width:150
    height:20
    onCommit: cursorVisible = false
    renderType: RibbonTheme.nativeText ? TextField.NativeRendering : TextField.QtRendering
    background: Rectangle{
        radius: 4
        implicitHeight: 20
        implicitWidth: 150
        color: isDarkMode ? "#383838" : "#FFFFFF"
        border.color: control.cursorVisible ? isDarkMode ? "#869CCD" : "#486495" : isDarkMode ? "#5E5F5E" : "#B9B9B8"
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
        inputItem: control
    }
    RibbonIcon{
        id: icon
        anchors{
            left: parent.left
            leftMargin: parent.padding
            verticalCenter: parent.verticalCenter
        }
        iconSource: parent.iconSource
        iconSize: parent.height - parent.padding
        visible: iconSource
        color: isDarkMode ? "white" : "black"
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }
    RibbonButton{
        id: clearBtn
        anchors{
            right: parent.right
            rightMargin: parent.padding
            verticalCenter: parent.verticalCenter
        }
        showBg: false
        showHoveredBg: false
        tipText: qsTr("Clear")
        iconSource: RibbonIcons.Dismiss
        height: parent.height - parent.padding
        width: height
        visible: parent.text&&showClearBtn&&control.cursorVisible
        onClicked: parent.clear()
    }
}
