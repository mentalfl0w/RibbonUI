import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonView{
    id: view
    spacing: 0

    property int max_msg_num: 10
    property bool auto_scroll_to_bottom: false
    property int animation_time: 200
    property alias delegate: message_list.delegate
    property alias message_model: message_model
    property alias view: message_list

    ListModel{
        id: message_model
        onCountChanged: auto_scroll_btn_timer.restart()
    }

    Timer{
        id: auto_scroll_btn_timer
        interval: animation_time
        repeat: false
        onTriggered: {
            if(view.auto_scroll_to_bottom)
                view.scroll_to_bottom()
        }
    }

    ListView{
        id: message_list
        cacheBuffer: message_list.height * 2
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.width
        model: message_model
        add: Transition {
            NumberAnimation {
                properties: "y"
                from: message_list.height
                duration: animation_time
            }
        }
        ScrollBar.vertical: RibbonScrollBar {
            anchors.right: message_list.right
            anchors.rightMargin: 2
        }
    }

    function scroll_to_up(){
        message_list.positionViewAtBeginning()
    }

    function scroll_to_bottom(){
        message_list.positionViewAtEnd()
    }

}
