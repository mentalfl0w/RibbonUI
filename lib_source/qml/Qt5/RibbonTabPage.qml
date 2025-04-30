import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.1

Item {
    property string title
    default property alias content: container.data
    clip: true
    Flickable{
        id: view
        anchors.fill: parent
        ScrollIndicator.horizontal: RibbonScrollIndicator{
            anchors.bottom: view.bottom
            anchors.horizontalCenter: view.horizontalCenter
            width: view.width - 10
        }
        contentWidth: container.width
        RowLayout{
            id: container
            spacing: 0
            height: parent.height
        }
    }
}
