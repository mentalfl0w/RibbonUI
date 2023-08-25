import QtQuick
import QtQuick.Controls
import RibbonUI

TextEdit {
    id: control
    readOnly: true
    color: dark_mode ? "white" : "black"
    property bool dark_mode: RibbonTheme.dark_mode
    property bool view_only: false
    padding: 0
    topPadding: 0
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0
    selectByMouse: true
    selectionColor: dark_mode ? "#4F5E7F" : "#BECDE8"
    selectedTextColor: dark_mode ? "white" : "black"
    wrapMode: TextEdit.WrapAnywhere
    enabled: !view_only
    font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.RightButton
        onClicked: control.echoMode !== TextInput.Password && menu.popup()
    }
    RibbonTextBoxMenu{
        id:menu
        input_item: control
    }
}
