import QtQuick
import QtQuick.Layouts

Item {
    property string title
    default property alias content: container.data
    clip: true
    RowLayout{
        id: container
        spacing: 0
        anchors{
            top:parent.top
            bottom:parent.bottom
            left: parent.left
        }
    }
}
