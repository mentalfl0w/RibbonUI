import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import RibbonUI 1.1

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
        height: {
            var w = topBorderFix
            if(isMainView && Window.window){
                if(Window.window.tabBar)
                    w += Math.abs(Window.window.tabBar.height - Window.window.tabBar.modernMargin)
                if(Window.window.messageBar)
                    w += (Window.window.messageBar.folded ? Window.window.messageBar.currentMessageHeight : 0) + Window.window.messageBar.topMargin
            }
            return w
        }
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
        height: {
            var w = bottomBorderFix
            if(isMainView && Window.window){
                if(Window.window.bottomBar)
                    w += Math.abs(Window.window.bottomBar.height)
            }
            return w
        }
    }

    Component.onCompleted: {
        if(isMainView && Window.window)
            Window.window.viewItems = container
    }
}
