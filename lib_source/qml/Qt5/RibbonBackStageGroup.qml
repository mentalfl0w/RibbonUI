import QtQuick 2.15
import RibbonUI 1.1

Item {
    id: control
    property string groupName: qsTr("Title")
    property string bgColor: "transparent"
    property int titleFontSize: 15
    default property alias contentItem: container.data
    property real bgRadius: 0
    RibbonText{
        id: title
        anchors{
            top: parent.top
            left: parent.left
        }
        font.pixelSize: control.titleFontSize
        font.bold: true
        text: control.groupName
    }
    Rectangle{
        id: border
        anchors{
            top: title.bottom
            topMargin: 10
            bottomMargin: anchors.topMargin
            horizontalCenter: parent.horizontalCenter
        }
        height: 1
        width: parent.width
        color: RibbonTheme.isDarkMode ? "#666666" : "#D1D1D1"
    }

    Rectangle{
        id: container
        color: control.bgColor
        radius: control.bgRadius
        anchors{
            top: border.bottom
            topMargin: border.anchors.bottomMargin
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
}
