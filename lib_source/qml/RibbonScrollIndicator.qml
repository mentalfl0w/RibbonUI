import QtQuick
import QtQuick.Controls
import RibbonUI

ScrollIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: control.hovered ? (control.background.implicitWidth - control.contentItem.implicitWidth)/2 : 2

    contentItem: Rectangle {
        implicitWidth: control.hovered ? 8 : 4
        implicitHeight: control.hovered ? 8 : 4

        color: RibbonTheme.dark_mode ? '#999999' : '#707070'
        visible: control.size < 1.0
        opacity: 0.0
        radius: implicitWidth / 2

        states: State {
            name: "active"
            when: control.active
            PropertyChanges { control.contentItem.opacity: 0.75 }
        }

        transitions: [
            Transition {
                from: "active"
                SequentialAnimation {
                    NumberAnimation { target: control.contentItem; duration: 200; property: "opacity"; to: 0.0 }
                }
            }
        ]

        Behavior on implicitWidth {
            SequentialAnimation {
                PauseAnimation { duration: control.hovered ? 0 : 300 }
                NumberAnimation {
                    duration: 50
                    easing.type: Easing.OutSine
                }
            }
        }

        Behavior on implicitHeight {
            SequentialAnimation {
                PauseAnimation { duration: control.hovered ? 0 : 300 }
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.OutSine
                }
            }
        }
    }

    background: Rectangle{
        implicitWidth: control.hovered ? 18 : 0
        implicitHeight: control.hovered ? 18 : 0
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
    }
}
