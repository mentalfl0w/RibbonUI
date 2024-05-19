import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

Rectangle{
    id: bubble
    color: "transparent"
    property real padding: 10
    default property alias content: message_layout.data
    property var dataModel: model
    property int fontSize: 13
    property string senderText: "sender"
    width: ListView.view.width
    height: bubble_layout.height + padding*2

    ColumnLayout{
        id: bubble_layout
        anchors{
            top: parent.top
            topMargin: parent.padding
        }
        layoutDirection: dataModel.recieved ? Qt.LeftToRight : Qt.RightToLeft
        Component.onCompleted: {
            if (dataModel.recieved)
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
            id: senderText
            text: bubble.senderText
            padding: bubble.padding
            color: RibbonTheme.isDarkMode ? "white" : "black"
        }
        RibbonRectangle{
            id: bubble_bg
            color: dataModel.recieved ? RibbonTheme.isDarkMode ? "#202020" : "#FFFFFF" : RibbonTheme.isDarkMode ? "#2F2F2F" : "#4397F7"
            height: message_layout.height + bubble.padding*2
            width: message_layout.width + bubble.padding*2
            radius: 10
            topLeftRadius: dataModel.recieved ? 2 : bubble.padding
            topRightRadius: !dataModel.recieved ? 2 : bubble.padding
            ColumnLayout{
                id: message_layout
                anchors.centerIn: parent
            }
        }
    }
}
