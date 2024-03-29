import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

RibbonView {
    id: control
    property int page_width: width * 0.7
    property int page_height: container.height + page_margin*2
    property int page_margin: 50
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
                topMargin: modern_style ? 20 : 30
                bottomMargin: modern_style ? 20 : 30
                horizontalCenter: parent.horizontalCenter
            }
            radius: modern_style ? 10 : 5
            color: dark_mode ? "#262626" : "white"
            implicitWidth: control.page_width
            implicitHeight: control.page_height
            layer.enabled: true
            layer.effect: RibbonShadow {
                id: effect
                shadow_opacity:modern_style ? 0.2 : 0.5
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
