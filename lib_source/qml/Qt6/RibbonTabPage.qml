import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

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
