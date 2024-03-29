import QtQuick
import QtQuick.Controls
import RibbonUI

ComboBox {
    id: control
    property bool dark_mode: RibbonTheme.dark_mode
    property int icon_source
    property int component_width: 150
    property int component_height:20
    property string placeholderText: "Please Choose:"
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    leftPadding: padding + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    rightPadding: padding + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    font.pixelSize: 13

    opacity: enabled ? 1.0 : 0.3

    delegate: ItemDelegate {
        id: item
        padding: 6
        width: ListView.view.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        palette.text: control.palette.text
        palette.highlightedText: control.palette.highlightedText
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
        contentItem: RibbonText{
            id:label
            view_only: true
            text: item.text
            font.pixelSize: control.font.pixelSize
            font.weight: control.currentIndex === index ? Font.DemiBold : Font.Normal
            color: dark_mode ? "white" : highlighted ? "white" : "black"
        }
        background: Rectangle{
            implicitWidth: item.width - 10
            implicitHeight: label.contentHeight + 14
            color: !dark_mode ? "#506BBD" : "#2A4299"
            visible: down || highlighted || visualFocus
            radius: 4
        }
    }

    indicator: RibbonIcon{
        x: control.mirrored ? control.padding : control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2
        padding: 5
        icon_size: 15
        icon_source: RibbonIcons.ChevronDown
        rotation: control.down ? 180 : 0
        color: dark_mode ? "white" : "black"

        Behavior on rotation {
            NumberAnimation{
                duration: 100
                easing.type: Easing.OutSine
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    contentItem: RibbonLineEdit {
        id: edit
        leftPadding: (!control.mirrored ? 12 : control.editable && activeFocus ? 3 : 1) + (icon.visible ? icon.contentWidth + padding*2 : 0)
        rightPadding: (control.mirrored ? 12 : control.editable && activeFocus ? 3 : 1) + (clear_btn.visible ? clear_btn.width + padding*2 : 0)
        topPadding: 6 - control.padding
        bottomPadding: 6 - control.padding

        text: control.editable ? control.editText : control.displayText

        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        selectByMouse: control.selectTextByMouse
        placeholderText: control.placeholderText

        opacity: 1

        font: control.font
        color: dark_mode ? "white" : "black"
        selectionColor: dark_mode ? "#4F5E7F" : "#BECDE8"
        selectedTextColor: dark_mode ? "white" : "black"
        verticalAlignment: Text.AlignVCenter

        icon_source: control.icon_source

        onCommit: {
            accepted()
        }

        background: Rectangle{
            visible: control.enabled && control.editable && !control.flat
            radius: 4
            implicitHeight: control.component_height
            implicitWidth: control.component_width-10
            color: "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
    }

    background: Rectangle {
        implicitWidth: control.component_width
        implicitHeight: control.component_height
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
        RibbonRectangle{
            color: dark_mode ? "#383838" : "#FFFFFF"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.border.width
            radius: parent.radius
            topRightRadius: 0
            bottomRightRadius: 0
            width: parent.width - parent.border.width * 2 - indicator.width
            height: parent.height - parent.border.width * 2
        }

        border.color: edit.cursorVisible ? dark_mode ? "#869CCD" : "#486495" : dark_mode ? "#5E5F5E" : "#B9B9B8"
        border.width: 1
        visible: !control.flat || control.down
    }

    popup: Popup {
        id: pop
        y: control.height
        width: control.width
        height: origin_height
        property int origin_height: Math.min(contentItem.implicitHeight + topInset + topPadding + bottomPadding + bottomInset, control.Window.height - topMargin - bottomMargin)
        topMargin: 6
        bottomMargin: 6

        padding:5
        topPadding: 7
        bottomPadding: 7

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            ScrollBar.vertical: RibbonScrollBar { }
        }

        background: RibbonBlur{
            radius: 5
            mask_opacity: 1
            mask_border.color: RibbonTheme.dark_mode ? "#5C5D5D" : "#B5B4B5"
            mask_border.width: 1
        }

        enter: Transition {
            NumberAnimation {
                properties: "height"
                from:0
                to: pop.origin_height
                duration: 100
                easing.type: Easing.OutSine
            }
            NumberAnimation {
                property: "opacity"
                duration: 100
                from:0
                to:1
                easing.type: Easing.OutSine
            }
        }
        exit:Transition {
            NumberAnimation {
                properties: "height"
                from: pop.origin_height
                to:0
                duration: 100
                easing.type: Easing.OutSine
            }
            NumberAnimation {
                property: "opacity"
                duration: 100
                from:1
                to:0
                easing.type: Easing.OutSine
            }
        }
    }
}
