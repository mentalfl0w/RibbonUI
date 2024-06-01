import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

RibbonMenu{
    property var inputItem
    id:menu
    width: 100
    onVisibleChanged: {
        inputItem.forceActiveFocus()
    }
    Connections{
        target: inputItem
        function onTextChanged() {
            menu.close()
        }
    }
    RibbonMenuItem{
        text: qsTr("Cut")
        visible: inputItem.selectedText !== "" && !inputItem.readOnly
        onClicked: {
            inputItem.cut()
        }
    }
    RibbonMenuItem{
        text: qsTr("Copy")
        visible: inputItem.selectedText !== ""
        onClicked: {
            inputItem.copy()
        }
    }
    RibbonMenuItem{
        text: qsTr("Paste")
        visible: inputItem.canPaste
        onClicked: {
            inputItem.paste()
        }
    }
    RibbonMenuItem{
        text: qsTr("Select All")
        visible: inputItem.text !== ""
        onClicked: {
            inputItem.selectAll()
        }
    }
}
