import QtQuick 2.15
import QtQuick.Controls 2.15
import RibbonUI 1.1

TextEdit {
    id: control
    readOnly: true
    color: isDarkMode ? "white" : "black"
    property bool isDarkMode: RibbonTheme.isDarkMode
    property bool viewOnly: false
    padding: 0
    topPadding: 0
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0
    selectByMouse: true
    selectionColor: isDarkMode ? "#4F5E7F" : "#BECDE8"
    selectedTextColor: isDarkMode ? "white" : "black"
    wrapMode: TextEdit.WrapAnywhere
    enabled: !viewOnly
    font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
    renderType: RibbonTheme.nativeText ? TextEdit.NativeRendering : TextEdit.QtRendering
    onRenderTypeChanged: {
        selectAll()
        deselect()
    }

    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.RightButton
        onClicked: control.echoMode !== TextInput.Password && menu.popup()
    }
    RibbonTextBoxMenu{
        id:menu
        inputItem: control
    }
}
