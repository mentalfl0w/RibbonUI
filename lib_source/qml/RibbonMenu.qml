import QtQuick
import QtQuick.Controls
import RibbonUI

Menu {
    id:control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.min(Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding))
    overlap: 1
    padding: 5
    property bool dark_mode: RibbonTheme.dark_mode
    property string bg_color: !dark_mode ? "#E8E9E9" : "#303131"
    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from:0
            to: 1
            duration: 70
            easing.type: Easing.OutSine
        }
    }
    exit:Transition {
        NumberAnimation {
            property: "opacity"
            from: 1
            to:0
            duration: 70
            easing.type: Easing.OutSine
        }
    }
    delegate: RibbonMenuItem{}
    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        interactive: Window.window
                     ? contentHeight + control.topPadding + control.bottomPadding > Window.window.height
                     : false
        clip: true
        currentIndex: control.currentIndex
        ScrollBar.vertical: RibbonScrollBar {}
    }

    background: Rectangle {
        implicitWidth: 250
        implicitHeight: 20
        layer.enabled: true
        layer.effect: RibbonShadow{
            shadow_color: "black"
        }
        border.color: dark_mode ? "#5C5D5D" : "#B5B4B5"
        border.width: 1
        color: bg_color
        radius: 4
    }
}
