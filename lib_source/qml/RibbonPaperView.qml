import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

RibbonView {
    id: control
    property int page_width: width * 0.7
    property int page_height: 1000
    default property alias content: container.data
    Rectangle{
        id: container_bg
        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        Layout.topMargin: modern_style ? 20 : 30
        Layout.bottomMargin: modern_style ? 20 : 30
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
