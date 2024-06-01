import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

RibbonView {
    id: control
    property int pageWidth: width * 0.7
    property int pageHeight: container.height + pageMargin*2
    property int pageMargin: 50
    default property alias content: container.data
    Flickable{
        id:flickview
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height
        contentWidth: control.width
        contentHeight: container_bg.height + container_bg.anchors.topMargin + container_bg.anchors.bottomMargin
        ScrollBar.vertical: RibbonScrollBar {
            anchors.right: flickview.right
            anchors.rightMargin: 2
        }
        boundsBehavior: Flickable.DragOverBounds
        Rectangle{
            id: container_bg
            anchors{
                top: parent.top
                topMargin: modernStyle ? 20 : 30
                bottomMargin: modernStyle ? 20 : 30
                horizontalCenter: parent.horizontalCenter
            }
            radius: modernStyle ? 10 : 5
            color: isDarkMode ? "#262626" : "white"
            implicitWidth: control.pageWidth
            implicitHeight: control.pageHeight
            layer.enabled: true
            layer.effect: RibbonShadow {
                id: effect
                shadowOpacity:modernStyle ? 0.2 : 0.5
            }
            ColumnLayout{
                id:container
                spacing: control.spacing
                clip: true
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                width: parent.width
            }
        }
    }
}
