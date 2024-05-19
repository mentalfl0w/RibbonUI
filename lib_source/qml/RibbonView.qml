import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import RibbonUI

Item {
    id: root
    default property alias content: container.data
    property bool modernStyle: RibbonTheme.modernStyle
    property bool isDarkMode: RibbonTheme.isDarkMode
    property int spacing: 5
    property int topPadding: 0
    property int bottomPadding: 0
    property alias bgColor: bg.color
    property alias bgVisible: bg.visible
    z:-2
    clip: true
    width: parent.width

    Rectangle{
        id:bg
        anchors.fill: parent
        color: isDarkMode ? "#282828" : "#ECECEC"
        visible: !modernStyle
    }

    RibbonBlur{
        id: top_mask
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: Math.abs(topPadding)
        target: container
        maskOpacity: 0
        visible: topPadding
        clip: true
        targetRect: Qt.rect(x,y-topPadding,width,height)
        useSolidBg: false
    }

    Item{
        id: clipper
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:top_mask.bottom
        implicitHeight: parent.height - Math.abs(topPadding) - Math.abs(bottomPadding)
        implicitWidth: parent.width
        clip: true
        ColumnLayout{
            id:container
            anchors{
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            width: parent.width
        }
    }

    RibbonBlur{
        id: bottom_mask
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: Math.abs(bottomPadding)
        target: container
        maskOpacity: 0
        visible: bottomPadding
        clip: true
        targetRect: Qt.rect(x,y-topPadding,width,height)
        useSolidBg: false
    }
}
