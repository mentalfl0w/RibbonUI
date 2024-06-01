import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonView{
    id: view
    spacing: 0

    property int maxMsgNum: 10
    property bool autoScrollToBottom: false
    property int animationTime: 200
    property alias delegate: message_list.delegate
    property alias messageModel: messageModel
    property alias view: message_list

    ListModel{
        id: messageModel
        onCountChanged: auto_scroll_btn_timer.restart()
    }

    Timer{
        id: auto_scroll_btn_timer
        interval: animationTime
        repeat: false
        onTriggered: {
            if(view.autoScrollToBottom)
                view.scrollToBottom()
        }
    }

    ListView{
        id: message_list
        cacheBuffer: message_list.height * 2
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredHeight: parent.height
        Layout.preferredWidth: parent.width
        model: messageModel
        add: Transition {
            NumberAnimation {
                properties: "y"
                from: message_list.height
                duration: animationTime
            }
        }
        ScrollBar.vertical: RibbonScrollBar {
            anchors.right: message_list.right
            anchors.rightMargin: 2
        }
    }

    function scrollToUp(){
        message_list.positionViewAtBeginning()
    }

    function scrollToBottom(){
        message_list.positionViewAtEnd()
    }

}
