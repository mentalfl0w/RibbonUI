import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import RibbonUI

Item {
    id: root
    default property alias content: container.data
    property bool modernStyle: RibbonTheme.modernStyle
    property bool isDarkMode: RibbonTheme.isDarkMode
    property int spacing: 5
    property bool isMainView: false
    property alias bgColor: bg.color
    property alias bgVisible: bg.visible
    property real topBorderFix: 0
    property real bottomBorderFix: 0
    z:-2
    clip: true
    width: parent.width

    Rectangle{
        id:bg
        anchors.fill: parent
        color: isDarkMode ? "#282828" : "#ECECEC"
        visible: !modernStyle
    }

    Item{
        id: top_border
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: (isMainView ? Window.window ? Window.window.tabBar ? Math.abs(Window.window.tabBar.height - Window.window.tabBar.modernMargin) : 0 : 0 : 0) + topBorderFix
    }

    Item{
        id: clipper
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: top_border.bottom
        implicitHeight: parent.height - Math.abs(top_border.height) - Math.abs(bottom_border.height)
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

    Item{
        id: bottom_border
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: (isMainView ? Window.window ? Window.window.tabBar ? Math.abs(Window.window.bottomBar.height) : 0 : 0 : 0) + bottomBorderFix
    }

    Component.onCompleted: {
        if(isMainView && Window.window)
            Window.window.viewItems = container
    }
}
