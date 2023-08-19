import QtQuick
import QtQuick.Controls
import RibbonUI

RibbonMenu{
    property var input_item
    id:menu
    width: 100
    onVisibleChanged: {
        input_item.forceActiveFocus()
    }
    Connections{
        target: input_item
        function onTextChanged() {
            menu.close()
        }
    }
    RibbonMenuItem{
        text: qsTr("Cut")
        visible: input_item.selectedText !== "" && !input_item.readOnly
        onClicked: {
            input_item.cut()
        }
    }
    RibbonMenuItem{
        text: qsTr("Copy")
        visible: input_item.selectedText !== ""
        onClicked: {
            input_item.copy()
        }
    }
    RibbonMenuItem{
        text: qsTr("Paste")
        visible: input_item.canPaste
        onClicked: {
            input_item.paste()
        }
    }
    RibbonMenuItem{
        text: qsTr("Select All")
        visible: input_item.text !== ""
        onClicked: {
            input_item.selectAll()
        }
    }
}
