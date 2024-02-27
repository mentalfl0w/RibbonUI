import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import RibbonUI

Item {
    id: root
    default property alias content: container.data
    property bool modern_style: RibbonTheme.modern_style
    property bool dark_mode: RibbonTheme.dark_mode
    property int spacing: 5
    property int top_padding: 0
    property int bottom_padding: 0
    property double pull_threshold: 10
    property alias flickview: flickview
    signal pull_up_triggered()
    signal pull_down_triggered()
    z:-2
    clip: true
    anchors{
        left: parent.left
        right:parent.right
    }

    Rectangle{
        id:bg
        anchors.fill: parent
        color: dark_mode ? "#282828" : "#ECECEC"
        visible: !modern_style
    }

    RibbonBlur{
        id: top_mask
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: Math.abs(top_padding)
        target: flickview
        mask_opacity: 0
        visible: top_padding
        clip: true
        target_rect: Qt.rect(x,y-top_padding,width,height)
    }

    Item{
        id: clipper
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:top_mask.bottom
        implicitHeight: parent.height - Math.abs(top_padding) - Math.abs(bottom_padding)
        implicitWidth: parent.width
        clip: true
        Flickable{
            id:flickview
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: container.height
            ScrollBar.vertical: ScrollBar {
                anchors.right: flickview.right
                anchors.rightMargin: 2
            }
            boundsBehavior: Flickable.DragOverBounds
            ColumnLayout{
                id:container
                anchors{
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width
            }
        }
    }

    RibbonBlur{
        id: bottom_mask
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: Math.abs(bottom_padding)
        target: flickview
        mask_opacity: 0
        visible: bottom_padding
        clip: true
        target_rect: Qt.rect(x,y-top_padding,width,height)
    }

    Timer
    {
        id: timer
        property int type: 0
        interval:200
        repeat: false
        onTriggered: {
            if (type == 1)
                pull_up_triggered()
            else if (type == 2)
                pull_down_triggered()
            type = 0
        }
    }

    states: [
        State {
            id: pull_up
            name: "pullUp"; when: (flickview.contentY < -pull_threshold)
            StateChangeScript {
                name: "pullUp_func"
                script: {
                    timer.type = 1
                    timer.start()
                }
            }
        },
        State {
            id: pull_bottom
            name: "pullBottom"; when: (flickview.contentHeight > 0) && (flickview.contentY > (flickview.contentHeight - flickview.height + pull_threshold))
            StateChangeScript {
                name: "pullBottom_func"
                script: {
                    timer.type = 2
                    timer.start()
                }
            }
        }
    ]

    function scroll_to_up(){
        flickview.contentY = flickview.height
    }

    function scroll_to_bottom(){
        flickview.contentY = flickview.contentHeight > flickview.height ? flickview.contentHeight - flickview.height : flickview.contentY
    }
}
