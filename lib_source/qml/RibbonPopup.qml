import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import RibbonUI
import Qt5Compat.GraphicalEffects

Popup {
    id: popup
    padding: 0
    modal: true
    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property bool show_close_btn: true
    property bool blur_enabled: false
    property alias target: blur.target
    property alias target_rect: blur.target_rect
    property alias radius: blur.radius
    enter: Transition {
        NumberAnimation {
            properties: "scale"
            from:0.5
            to:1
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
            properties: "scale"
            from:1
            to:0.5
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
    background: Item{
        RectangularGlow {
            id: effect
            anchors.fill: blur
            anchors.margins: blur.border.width
            glowRadius: 20
            spread: 0
            color: RibbonTheme.dark_mode ? Qt.rgba(255,255,255,0.1) : Qt.rgba(0,0,0,0.1)
            cornerRadius: blur.radius + glowRadius + 10
        }
        RibbonBlur{
            implicitHeight: parent.height
            implicitWidth: parent.width
            id: blur
            radius: 20
            mask_opacity: blur_enabled ? 0.5 : 1
            mask_border.color: RibbonTheme.dark_mode ? "#5C5D5D" : "#B5B4B5"
            mask_border.width: 1
        }
    }
    contentItem: Item{
        RibbonButton{
            anchors{
                top:parent.top
                topMargin: 8
                right:parent.right
                rightMargin: topMargin
            }
            show_bg: false
            show_hovered_bg: false
            icon_source: RibbonIcons.Dismiss
            onClicked: close()
            visible: show_close_btn
        }
    }
    Overlay.modal:Rectangle{
        color:"transparent"
    }
    Overlay.modeless:Rectangle{
        color:"transparent"
    }
}
