import QtQuick
import QtQuick.Controls
import RibbonUI

SpinBox {
    id: control
    property bool dark_mode: RibbonTheme.dark_mode
    property int icon_source

    font.pixelSize: 13

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            90 /* minimum */ )
    implicitHeight: Math.max(implicitBackgroundHeight, up.implicitIndicatorHeight + down.implicitIndicatorHeight)
                    + topInset + bottomInset

    spacing: 2


    // Push the background right to make room for the indicators
    rightInset: up.implicitIndicatorWidth + spacing

    leftPadding: 0
    topPadding: 0
    rightPadding: 0
    bottomPadding: 0


    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: RibbonLineEdit {
        text: control.displayText
        font: control.font
        color: dark_mode ? "white" : "black"
        selectionColor: dark_mode ? "#4F5E7F" : "#BECDE8"
        selectedTextColor: dark_mode ? "white" : "black"
        horizontalAlignment: Qt.AlignLeft
        verticalAlignment: Qt.AlignVCenter
        icon_source: control.icon_source
        icon.icon_size: 16

        topPadding: 2
        bottomPadding: 2
        leftPadding: icon.visible ? icon.contentWidth + padding*2 : 10
        rightPadding: (clear_btn.visible ? clear_btn.width + padding*2 : 10) + up.indicator.width

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    up.indicator: RibbonButton{
        z: 1
        x: parent.width - width
        y: (parent.height / 2) - height + 2
        implicitWidth: 20 - 2
        implicitHeight: 12 - 2
        icon_source: RibbonIcons.ChevronUp
        ribbon_icon.icon_size: 10
        show_bg: false
        show_tooltip: false
        onHoveredChanged: control.up.hovered = hovered
        onPressedChanged: control.up.pressed = pressed
        onClicked: increase()
    }

    down.indicator: RibbonButton{
        z:1
        x: parent.width - width
        y: (parent.height / 2) - height - 1 + up.indicator.height
        implicitWidth: 20 - 2
        implicitHeight: 12 - 2
        icon_source: RibbonIcons.ChevronDown
        ribbon_icon.icon_size: 10
        show_bg: false
        show_tooltip: false
        onHoveredChanged: control.down.hovered = hovered
        onPressedChanged: control.down.pressed = pressed
        onClicked: decrease()
    }

    background: Rectangle {
        implicitWidth: 80
        implicitHeight: 25
        radius: 4
        color: {
            color: {
                if (control.down)
                    return dark_mode ? "#858585" : "#C9CACA"
                if (control.hovered)
                    return dark_mode ? "#5A5B5A" : "#E4E4E4"
                return dark_mode ? "#383838" : "#FFFFFF"
            }
        }
    }
}
