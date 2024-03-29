import QtQuick
import QtQuick.Controls
import RibbonUI

ScrollIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: (control.background.implicitWidth - control.contentItem.implicitWidth)/2

    contentItem: Rectangle {
        implicitWidth: 8
        implicitHeight: 8

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
                    PauseAnimation { duration: 450 }
                    NumberAnimation { target: control.contentItem; duration: 200; property: "opacity"; to: 0.0 }
                }
            }
        ]
    }

    background: Rectangle{
        implicitWidth: 18
        implicitHeight: 18
        color: RibbonTheme.dark_mode ? '#141414' : '#F5F5F5'
        opacity: 0.0
        radius: implicitWidth / 2
        visible: control.contentItem.visible

        states: State {
            name: "active"
            when: control.active
            PropertyChanges { control.background.opacity: 0.75 }
        }

        transitions: [
            Transition {
                from: "active"
                SequentialAnimation {
                    PauseAnimation { duration: 450 }
                    NumberAnimation { target: control.background; duration: 200; property: "opacity"; to: 0.0 }
                }
            }
        ]
    }
}
