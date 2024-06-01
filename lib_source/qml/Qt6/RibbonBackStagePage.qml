import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Item {
    id: control
    property string pageName: qsTr("Name")
    property string bgColor: "transparent"
    property real bgRadius: 0
    property int margins: 10
    property int titleFontSize: 25
    default property alias contentItem: container.data

    RibbonText{
        id: title
        anchors{
            top: parent.top
            topMargin: margins
            left: parent.left
            leftMargin: margins
        }
        font.pixelSize: control.titleFontSize
        text: control.pageName
    }

    Rectangle{
        id: container
        color: control.bgColor
        radius: control.bgRadius
        anchors{
            top: title.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: control.margins
        }
    }
}
