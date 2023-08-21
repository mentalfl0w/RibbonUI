import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Item{
    id: control
    property alias text: textedit.text
    property alias icon_source: textedit.icon_source
    property alias show_clear_btn: textedit.show_clear_btn
    property alias textedit: textedit
    property alias placeholderText: textedit.placeholderText
    property alias readOnly: textedit.readOnly
    property int max_height: 80
    property bool dark_mode: RibbonTheme.dark_mode
    signal commit()
    width: 150
    height: Math.min(flickview.contentHeight, max_height)
    Flickable{
        id: flickview
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: textedit.implicitHeight
        ScrollBar.vertical: ScrollBar {
            anchors.right: flickview.right
            anchors.rightMargin: 2
        }
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        TextArea.flickable:TextArea {
            id: textedit
            property int icon_source
            property bool show_clear_btn: true
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
            wrapMode: Text.WrapAnywhere
            opacity: enabled ? 1.0 : 0.3

            signal commit()
            onCommit: {
                cursorVisible = false
                control.commit()
            }
            background: Rectangle{
                id:bg
                radius: 4
                color: dark_mode ? "#383838" : "#FFFFFF"
                border.color: textedit.cursorVisible ? dark_mode ? "#869CCD" : "#486495" : dark_mode ? "#5E5F5E" : "#B9B9B8"
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
                onClicked: textedit.echoMode !== TextInput.Password && menu.popup()
                focus: true
            }
            RibbonTextBoxMenu{
                id:menu
                input_item: textedit
            }
        }
    }
    RibbonIcon{
        id: icon
        anchors{
            left: parent.left
            leftMargin: textedit.padding
            verticalCenter: parent.verticalCenter
        }
        icon_source: textedit.icon_source
        icon_size: 26 - textedit.padding
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
            rightMargin: textedit.padding
            verticalCenter: parent.verticalCenter
        }
        show_bg: false
        show_hovered_bg: false
        tip_text: qsTr("Clear")
        icon_source: RibbonIcons.Dismiss
        height: 26 - textedit.padding
        width: height
        visible: textedit.text&&show_clear_btn&&textedit.cursorVisible
        onClicked: textedit.clear()
    }
}
