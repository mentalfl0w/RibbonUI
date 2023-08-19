import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import RibbonUI

Item {
    id: control
    height: horizontal ? container.implicitHeight : container.implicitWidth
    width: horizontal ? container.implicitWidth : show_button ? Math.max(container.implicitHeight,subtract_button.width,add_button.width) : container.implicitHeight
    property bool show_tooltip: true
    property bool show_filled_color: true
    property bool show_button: true
    property bool horizontal: true
    property int slide_width: 150
    property int slide_height: 4
    property alias value: slide.value
    property bool dark_mode: RibbonTheme.dark_mode

    Item{
        id: container
        anchors.centerIn: parent
        implicitHeight: slide.implicitHeight
        implicitWidth: slide.implicitWidth + add_button.width + subtract_button.width
        rotation: horizontal ? 0 : -90
        RibbonButton{
            id: add_button
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            height: parent.height -3
            icon_source: RibbonIcons.Add
            icon_source_filled: RibbonIcons_Filled.Add
            show_bg: false
            show_tooltip: false
            show_hovered_bg: false
            rotation: horizontal ? 0 : 90
            visible: show_button
            enabled: slide.value !== 100
            text_color: dark_mode ? "white" : "black"
            opacity: enabled ? 1 : 0.2
            onClicked:
            {
                tooltip.show(slide.value,1000)
                slide.increase()
            }
            Behavior on text_color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }

        RibbonButton{
            id: subtract_button
            anchors{
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            height: parent.height -3
            show_bg: false
            show_tooltip: false
            show_hovered_bg: false
            icon_source: RibbonIcons.Subtract
            icon_source_filled: RibbonIcons_Filled.Subtract
            rotation: horizontal ? 0 : 90
            visible: show_button
            text_color: dark_mode ? "white" : "black"
            opacity: enabled ? 1 : 0.2
            enabled: slide.value !== 0
            onClicked:
            {
                tooltip.show(slide.value,1000)
                slide.decrease()
            }
            Behavior on text_color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }

        Slider {
            id: slide
            to: 100
            stepSize: 1
            anchors{
                leftMargin: -5
                left: show_button ? subtract_button.right : parent.left
                right: show_button ? add_button.left : parent.right
                rightMargin: -5
                verticalCenter: add_button.verticalCenter
            }
            implicitWidth: Math.max(implicitBackgroundWidth + leftPadding + rightPadding, implicitHandleWidth + leftPadding + rightPadding)
            implicitHeight: Math.max(implicitBackgroundHeight + topPadding + bottomPadding, implicitHandleHeight + topPadding + bottomPadding)
            property int slide_length: 150
            property int slide_width: 5
            handle: Rectangle{
                x: slide.leftPadding + (slide.horizontal ? slide.visualPosition * (slide.availableWidth - width) : (slide.availableWidth - width) / 2)
                y: slide.topPadding + (slide.horizontal ? (slide.availableHeight - height) / 2 : slide.visualPosition * (slide.availableHeight - height)) - 1
                implicitWidth: 12
                implicitHeight: 12
                color: dark_mode ? "#A1A2A1" : "#EDEEEE"
                radius: 12
                layer.enabled: true
                layer.effect: RibbonShadow {
                    shadow_opacity: 0.2
                    shadow_color: "black"
                }
                scale: slide.pressed ? 1.1 : slide.hovered ? 1.2 : 1
                Behavior on color {
                    ColorAnimation {
                        duration: 60
                        easing.type: Easing.OutSine
                    }
                }
                Behavior on scale {
                    NumberAnimation{
                        duration: 150
                        easing.type: Easing.OutSine
                    }
                }
            }
            background: Item {
                x: slide.leftPadding + (slide.horizontal ? 0 : (slide.availableWidth - width) / 2)
                y: slide.topPadding + (slide.horizontal ? (slide.availableHeight - height) / 2 : 0) - 1
                implicitWidth: slide.horizontal ? control.slide_width : control.slide_height
                implicitHeight: slide.horizontal ? control.slide_height : control.slide_width
                width: slide.horizontal ? slide.availableWidth : implicitWidth
                height: slide.horizontal ? implicitHeight : slide.availableHeight
                Rectangle{
                    anchors.fill: parent
                    radius: 2
                    color: dark_mode ? "#7C7C7C" : "#8F8F8F"
                    Behavior on color {
                        ColorAnimation {
                            duration: 60
                            easing.type: Easing.OutSine
                        }
                    }
                }
                scale: slide.horizontal && slide.mirrored ? -1 : 1
                Rectangle {
                    y: slide.horizontal ? 0 : slide.visualPosition * parent.height
                    width: slide.horizontal ? slide.position * parent.width : control.slide_height
                    height: slide.horizontal ? control.slide_height : slide.position * parent.height
                    radius: 3
                    color: show_filled_color ? dark_mode ? "#8AAAEB" : "#5DA3E8" : dark_mode ? "#7C7C7C" : "#8F8F8F"
                    Behavior on color {
                        ColorAnimation {
                            duration: 60
                            easing.type: Easing.OutSine
                        }
                    }
                }
            }
        }

        RibbonToolTip{
            id: tooltip
            parent: slide.handle
            visible: show_tooltip && slide.pressed
            text: slide.value
        }
    }
}

