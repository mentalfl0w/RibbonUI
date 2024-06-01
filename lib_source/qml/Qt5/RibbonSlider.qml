import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.0
import RibbonUI 1.0

Item {
    id: control
    height: horizontal ? container.implicitHeight : container.implicitWidth
    width: horizontal ? container.implicitWidth : showButton ? Math.max(container.implicitHeight,subtract_button.width,add_button.width) : container.implicitHeight
    property bool showTooltip: true
    property bool showFilledColor: true
    property bool showButton: true
    property bool horizontal: true
    property int slideWidth: 150
    property int slideHeight: 4
    property alias value: slide.value
    property bool isDarkMode: RibbonTheme.isDarkMode

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
            iconSource: RibbonIcons.Add
            iconSourceFilled: RibbonIcons_Filled.Add
            showBg: false
            showTooltip: false
            showHoveredBg: false
            rotation: horizontal ? 0 : 90
            visible: showButton
            enabled: slide.value !== 100
            textColor: isDarkMode ? "white" : "black"
            opacity: enabled ? 1 : 0.2
            onClicked:
            {
                tooltip.show(slide.value,1000)
                slide.increase()
            }
            Behavior on textColor {
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
            showBg: false
            showTooltip: false
            showHoveredBg: false
            iconSource: RibbonIcons.Subtract
            iconSourceFilled: RibbonIcons_Filled.Subtract
            rotation: horizontal ? 0 : 90
            visible: showButton
            textColor: isDarkMode ? "white" : "black"
            opacity: enabled ? 1 : 0.2
            enabled: slide.value !== 0
            onClicked:
            {
                tooltip.show(slide.value,1000)
                slide.decrease()
            }
            Behavior on textColor {
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
                left: showButton ? subtract_button.right : parent.left
                right: showButton ? add_button.left : parent.right
                rightMargin: -5
                verticalCenter: add_button.verticalCenter
            }
            implicitWidth: Math.max(implicitBackgroundWidth + leftPadding + rightPadding, implicitHandleWidth + leftPadding + rightPadding)
            implicitHeight: Math.max(implicitBackgroundHeight + topPadding + bottomPadding, implicitHandleHeight + topPadding + bottomPadding)
            property int slide_length: 150
            property int slideWidth: 5
            handle: Rectangle{
                x: slide.leftPadding + (slide.horizontal ? slide.visualPosition * (slide.availableWidth - width) : (slide.availableWidth - width) / 2)
                y: slide.topPadding + (slide.horizontal ? (slide.availableHeight - height) / 2 : slide.visualPosition * (slide.availableHeight - height)) - 1
                implicitWidth: 12
                implicitHeight: 12
                color: isDarkMode ? "#A1A2A1" : "#EDEEEE"
                radius: 12
                layer.enabled: true
                layer.effect: RibbonShadow {
                    shadowOpacity: 0.2
                    shadowColor: "black"
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
                implicitWidth: slide.horizontal ? control.slideWidth : control.slideHeight
                implicitHeight: slide.horizontal ? control.slideHeight : control.slideWidth
                width: slide.horizontal ? slide.availableWidth : implicitWidth
                height: slide.horizontal ? implicitHeight : slide.availableHeight
                Rectangle{
                    anchors.fill: parent
                    radius: 2
                    color: isDarkMode ? "#7C7C7C" : "#8F8F8F"
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
                    width: slide.horizontal ? slide.position * parent.width : control.slideHeight
                    height: slide.horizontal ? control.slideHeight : slide.position * parent.height
                    radius: 3
                    color: showFilledColor ? isDarkMode ? "#8AAAEB" : "#5DA3E8" : isDarkMode ? "#7C7C7C" : "#8F8F8F"
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
            visible: showTooltip && slide.pressed
            text: slide.value
        }
    }
}

