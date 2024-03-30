import QtQuick
import QtQuick.Controls
import RibbonUI

ScrollBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    verticalPadding: control.hovered || control.pressed ? (control.vertical ? 8 + 5 : 0) + (18 - 8) / 2 : 2
    horizontalPadding: control.hovered || control.pressed ? (control.vertical ? 0 : 8 + 5) + (18 - 8) / 2 : 2
    visible: control.policy !== ScrollBar.AlwaysOff
    minimumSize: orientation === Qt.Horizontal ? height / width : width / height

    contentItem: Rectangle {
        implicitWidth: control.hovered || control.pressed ? 8 : 4
        implicitHeight: control.hovered || control.pressed ? 8 : 4
        visible: control.size < 1.0
        radius: width / 2
        color: RibbonTheme.dark_mode ? hover_handler.hovered ? '#D6D6D6' : hover_handler.hovered && control.pressed ? '#E5E5E5' : '#999999'
        : hover_handler.hovered ? '#424242' : hover_handler.hovered && control.pressed ? '#333333' : '#707070'
        opacity: 0.0

        states: State {
            name: "active"
            when: control.policy === ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
            PropertyChanges { control.contentItem.opacity: 0.75 }
        }

        transitions: Transition {
            from: "active"
            SequentialAnimation {
                PauseAnimation { duration: 450 }
                NumberAnimation { target: control.contentItem; duration: 200; property: "opacity"; to: 0.0 }
            }
        }

        Behavior on implicitWidth {
            SequentialAnimation {
                PauseAnimation { duration: hover_handler.hovered ? 0 : 300 }
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutSine
                }
            }
        }

        Behavior on implicitHeight {
            SequentialAnimation {
                PauseAnimation { duration: hover_handler.hovered ? 0 : 300 }
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutSine
                }
            }
        }

        HoverHandler{
            id:hover_handler
        }
    }

    background: Rectangle{
        implicitWidth: control.hovered || control.pressed ? 18 : 0
        implicitHeight: control.hovered || control.pressed ? 18 : 0
        color: RibbonTheme.dark_mode ? '#141414' : '#F5F5F5'
        opacity: 0.0
        radius: implicitWidth / 2
        visible: control.contentItem.visible
        states: State {
            name: "active"
            when: control.active && control.hovered
            PropertyChanges { control.background.opacity: 0.75 }
        }

        transitions: [
            Transition {
                from: "active"
                SequentialAnimation {
                    NumberAnimation { target: control.background; duration: 200; property: "opacity"; to: 0.0 }
                }
            },
            Transition {
                to: "active"
                SequentialAnimation {
                    NumberAnimation { target: control.background; duration: 200; property: "opacity";}
                }
            }
        ]

        RibbonButton{
            id: decrease_btn
            width: control.vertical ? control.contentItem.width : control.contentItem.height
            height: width
            show_bg: false
            show_hovered_bg: false
            icon_source: control.vertical ? RibbonIcons.CaretUp : RibbonIcons.CaretLeft
            onClicked: control.decrease()
            Component.onCompleted: setup()
            ribbon_icon.filled: true
            ribbon_icon.icon_size: 15
            ribbon_icon.color: RibbonTheme.dark_mode ? hovered ? '#D6D6D6' : pressed ? '#E5E5E5' : '#999999'
            : hovered ? '#424242' : pressed ? '#333333' : '#707070'
            Connections{
                target: control
                function onVerticalChanged(){
                    setup()
                }
            }
            function setup()
            {
                if (control.vertical)
                {
                    anchors.top = parent.top
                    anchors.left = undefined
                    anchors.topMargin = 5
                    anchors.leftMargin = 0
                    anchors.horizontalCenter = parent.horizontalCenter
                }
                else
                {
                    anchors.left = parent.left
                    anchors.top = undefined
                    anchors.leftMargin = 5
                    anchors.topMargin = 0
                    anchors.verticalCenter = parent.verticalCenter
                }
            }
        }

        RibbonButton{
            id: increase_btn
            width: control.vertical ? control.contentItem.width : control.contentItem.height
            height: width
            show_bg: false
            show_hovered_bg: false
            icon_source: control.vertical ? RibbonIcons.CaretDown : RibbonIcons.CaretRight
            onClicked: control.increase()
            Component.onCompleted: setup()
            ribbon_icon.filled: true
            ribbon_icon.icon_size: 15
            ribbon_icon.color: RibbonTheme.dark_mode ? hovered ? '#D6D6D6' : pressed ? '#E5E5E5' : '#999999'
            : hovered ? '#424242' : pressed ? '#333333' : '#707070'
            Connections{
                target: control
                function onVerticalChanged(){
                    setup()
                }
            }
            function setup()
            {
                if (control.vertical)
                {
                    anchors.bottom = parent.bottom
                    anchors.right = undefined
                    anchors.bottomMargin = 5
                    anchors.rightMargin = 0
                    anchors.horizontalCenter = parent.horizontalCenter
                }
                else
                {
                    anchors.right = parent.right
                    anchors.bottom = undefined
                    anchors.rightMargin = 5
                    anchors.bottomMargin = 0
                    anchors.verticalCenter = parent.verticalCenter
                }
            }
        }
    }

    Behavior on verticalPadding {
        enabled: control.hovered
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutSine
        }
    }

    Behavior on horizontalPadding {
        enabled: control.hovered
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutSine
        }
    }
}
