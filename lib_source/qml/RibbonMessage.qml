import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

Rectangle{
    id: bubble
    color: "transparent"
    property double padding: 10
    default property alias content: message_layout.data
    property var data_model: model
    property int font_size: 13
    property string sender_text: "sender"
    width: ListView.view.width
    height: bubble_layout.height + padding*2

    ColumnLayout{
        id: bubble_layout
        anchors{
            top: parent.top
            topMargin: parent.padding
        }
        layoutDirection: data_model.recieved ? Qt.LeftToRight : Qt.RightToLeft
        Component.onCompleted: {
            if (data_model.recieved)
            {
                anchors.left = parent.left
                anchors.leftMargin = parent.padding
            }
            else{
                anchors.right = parent.right
                anchors.rightMargin = parent.padding
            }
        }
        RibbonText{
            id: sender_text
            text: bubble.sender_text
            padding: bubble.padding
            color: RibbonTheme.dark_mode ? "white" : "black"
        }
        RibbonRectangle{
            id: bubble_bg
            color: data_model.recieved ? RibbonTheme.dark_mode ? "#202020" : "#FFFFFF" : RibbonTheme.dark_mode ? "#2F2F2F" : "#4397F7"
            height: message_layout.height + bubble.padding*2
            width: message_layout.width + bubble.padding*2
            radius: 10
            topLeftRadius: data_model.recieved ? 2 : bubble.padding
            topRightRadius: !data_model.recieved ? 2 : bubble.padding
            ColumnLayout{
                id: message_layout
                anchors.centerIn: parent
            }
        }
    }
}
