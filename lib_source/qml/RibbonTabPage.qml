import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Item {
    property string title
    default property alias content: container.data
    clip: true
    ScrollView{
        id: view
        anchors.fill: parent
        ScrollBar.horizontal: RibbonScrollBar{
            anchors.bottom: view.bottom
            width: view.width
        }
        RowLayout{
            id: container
            spacing: 0
            height: parent.height
        }
    }
}
