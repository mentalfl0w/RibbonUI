import QtQuick 2.15
import QtQuick.Controls 2.15
import RibbonUI 1.0

BusyIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    property real ringWidth: RibbonTheme.modernStyle ? radiusWidth : radiusLength * 7 / 12
    property real radiusLength: 15
    property real radiusWidth: 4
    property int lineNumber: RibbonTheme.modernStyle ? 10 : 8
    property real default_saturation: 0
    property int animationDurarion: RibbonTheme.modernStyle ? 4000 : 1000
    property bool clockwise: true

    onAnimationDurarionChanged: {
        running = !running
        Qt.callLater(()=>running = !running) // Fix Qt 5 animation duration doesn't change
    }

    QtObject{
        id: private_property
        property real angle: 360 / lineNumber
        property real saturation: (1 - default_saturation) / lineNumber
    }

    contentItem: Item {
        id: item
        implicitWidth: radiusLength * 2
        implicitHeight: radiusLength * 2
        property real dynamic_index: 0

        PropertyAnimation on dynamic_index {
            running: control.running && !RibbonTheme.modernStyle
            from: clockwise ? lineNumber : 0
            to: clockwise ? 0 : lineNumber
            loops: Animation.Infinite
            duration: animationDurarion
        }

        Repeater {
            id: repeater
            anchors.centerIn: parent
            model: RibbonTheme.modernStyle ? lineNumber / 2 : lineNumber
            delegate: Rectangle {
                width: radiusWidth
                height: ringWidth
                property real item_saturation: (index + item.dynamic_index) % lineNumber * private_property.saturation + default_saturation
                color: Qt.hsla(0, 0, RibbonTheme.modernStyle ? RibbonTheme.isDarkMode ? 1 : 0 : item_saturation, 1)
                rotation: index * private_property.angle
                x: (parent.width / 2) - (radiusLength - ringWidth) * Math.sin(rotation/180 * Math.PI)
                y: (parent.height / 2 - height / 2) + (radiusLength - ringWidth) * Math.cos(rotation/180 * Math.PI)
                transformOrigin: Item.Top
                radius: Math.min(width,height)/2
                opacity: RibbonTheme.modernStyle ? 0 : 0.5
                SequentialAnimation {
                    loops: Animation.Infinite
                    running: control.running && RibbonTheme.modernStyle

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
                        property: "rotation"
                        from: (clockwise ? 1 : -1) * 0
                        to: (clockwise ? 1 : -1) * (360 - (index - lineNumber / 4 + 0.5) * private_property.angle * 1.4)
                        duration: animationDurarion / 2
                        easing.type: Easing.OutInQuad
                    }

                    ParallelAnimation{
                        NumberAnimation {
                            target: repeater.itemAt(index)
                            property: "rotation"
                            from: (clockwise ? 1 : -1) * (360 - (index - lineNumber / 4 + 0.5) * private_property.angle * 1.4)
                            to: (clockwise ? 1 : -1) * 720
                            duration: animationDurarion / 2
                            easing.type: Easing.OutInQuad
                        }
                        SequentialAnimation{
                            PauseAnimation {
                                duration: animationDurarion / 2 - animationDurarion / 20
                            }
                            PropertyAnimation {
                                target: repeater.itemAt(index)
                                property: "opacity"
                                from: 0.5
                                to: 0
                                duration: animationDurarion / 20
                                easing.type: Easing.OutExpo
                            }
                        }
                    }

                    PauseAnimation {
                        duration: 50 * (control.lineNumber - index - 1)
                    }
                }
            }
        }
    }
}
