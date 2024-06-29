import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import RibbonUI 1.0

BusyIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 2
    property real barWidth: 200
    property real barHeight: 4
    property real indicatorWidth: 4
    property real indicatorHeight: 4
    property int indicatorNumber: 5
    property int animationDurarion: 2000
    property bool reversed: false

    QtObject{
        id: private_property
    }

    contentItem: Item {
        id: item
        implicitWidth: barWidth
        implicitHeight: barHeight
        clip: true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle{
                implicitWidth: item.width
                implicitHeight: item.height
                radius: item.height / 2
            }
        }
        Repeater {
            id: repeater
            anchors.centerIn: parent
            model: indicatorNumber
            delegate: Rectangle {
                width: indicatorWidth
                height: indicatorHeight
                color: RibbonTheme.isDarkMode ? "white" : "black"
                x: -(index + 1) * indicatorWidth
                y: (barHeight.height / 2 - height / 2)
                radius: Math.min(width,height)/2
                opacity: 0.5
                SequentialAnimation {
                    loops: Animation.Infinite
                    running: control.running

                    PropertyAnimation {
                        target: repeater.itemAt(index)
                        property: "opacity"
                        from: 0
                        to: 0.5
                        duration: 50 * index
                        easing.type: Easing.OutExpo
                    }

                    NumberAnimation {
                        target: repeater.itemAt(index)
                        property: "x"
                        from: control.reversed ? barWidth + (index + 1) * indicatorWidth : -(index + 1) * indicatorWidth
                        to: control.reversed ? (index + 1) * indicatorWidth : barWidth - (index + 1) * indicatorWidth
                        duration: animationDurarion * 9 / 10
                        easing.type: Easing.OutInCubic
                    }

                    ParallelAnimation{
                        NumberAnimation {
                            target: repeater.itemAt(index)
                            property: "x"
                            from: control.reversed ? (index + 1) * indicatorWidth : barWidth - (index + 1) * indicatorWidth
                            to: control.reversed ? -(index + 1) * indicatorWidth - control.indicatorNumber*indicatorWidth : barWidth + (index + 1) * indicatorWidth + control.indicatorNumber*indicatorWidth
                            duration: animationDurarion / 10
                            easing.type: Easing.OutInCubic
                        }

                        PropertyAnimation {
                            target: repeater.itemAt(index)
                            property: "opacity"
                            from: 0.5
                            to: 0
                            duration: animationDurarion / 10
                            easing.type: Easing.OutExpo
                        }
                    }

                    PauseAnimation {
                        duration: 50 * (control.indicatorNumber - index - 1)
                    }
                }
            }
        }
    }
}
