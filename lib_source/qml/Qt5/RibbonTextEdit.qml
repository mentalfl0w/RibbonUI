import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

Item{
    id: control
    property alias text: textedit.text
    property alias iconSource: textedit.iconSource
    property alias showClearBtn: textedit.showClearBtn
    property alias textedit: textedit
    property alias placeholderText: textedit.placeholderText
    property alias readOnly: textedit.readOnly
    property int maxHeight: 80
    property bool isDarkMode: RibbonTheme.isDarkMode
    signal commit()
    width: 150
    height: Math.min(flickview.contentHeight, maxHeight)
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
            property int iconSource
            property bool showClearBtn: true
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
            wrapMode: Text.WrapAnywhere
            renderType: RibbonTheme.nativeText ? TextArea.NativeRendering : TextArea.QtRendering
            opacity: enabled ? 1.0 : 0.3

            signal commit()
            onCommit: {
                cursorVisible = false
                control.commit()
            }
            background: Rectangle{
                id:bg
                radius: 4
                color: isDarkMode ? "#383838" : "#FFFFFF"
                border.color: textedit.cursorVisible ? isDarkMode ? "#869CCD" : "#486495" : isDarkMode ? "#5E5F5E" : "#B9B9B8"
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
                inputItem: textedit
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
        iconSource: textedit.iconSource
        iconSize: 26 - textedit.padding
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
            rightMargin: textedit.padding
            verticalCenter: parent.verticalCenter
        }
        showBg: false
        showHoveredBg: false
        tipText: qsTr("Clear")
        iconSource: RibbonIcons.Dismiss
        height: 26 - textedit.padding
        width: height
        visible: textedit.text&&showClearBtn&&textedit.cursorVisible
        onClicked: textedit.clear()
    }
}
