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
    parent: Overlay.overlay
    x: (Overlay.overlay.width - width) / 2
    y: (Overlay.overlay.height - height) / 2
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property bool showCloseBtn: true
    property bool blurEnabled: false
    property alias target: blur.target
    property alias targetRect: blur.targetRect
    property alias radius: blur.radius
    property string contentSource: ""
    property var contentItems: undefined
    property bool destroyAfterClose: true

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
            anchors.margins: blur.maskBorderWidth
            glowRadius: 20
            spread: 0
            color: RibbonTheme.isDarkMode ? Qt.rgba(0,0,0,0.7) : Qt.rgba(0,0,0,0.45)
            cornerRadius: blur.radius + glowRadius + 10
        }
        RibbonBlur{
            implicitHeight: parent.height
            implicitWidth: parent.width
            id: blur
            radius: 7
            maskOpacity: blurEnabled ? 0.9 : 1
            maskBorderColor: RibbonTheme.modernStyle ?
                                   RibbonTheme.isDarkMode ? "#7A7A7A" : "#2C59B7" :
            RibbonTheme.isDarkMode ? "#5C5D5D" : "#B5B4B5"
            maskBorderWidth: 1
        }
    }
    contentItem: Item{
        id: control
        implicitHeight: container.height
        implicitWidth: container.width
        property var args
        RibbonButton{
            anchors{
                top:parent.top
                topMargin: 8
                right:parent.right
                rightMargin: anchors.topMargin
            }
            showBg: false
            showHoveredBg: false
            iconSource: RibbonIcons.Dismiss
            onClicked: popup.closeContent()
            visible: showCloseBtn
        }
        Loader{
            id: container
            sourceComponent: contentSource ? undefined : contentItems
            source: contentSource
            onLoaded: {
                if (!control.args)
                    return
                else if(Object.keys(control.args).length){
                    for (let arg in control.args){
                        item[arg] = control.args[arg]
                    }
                }
                else{
                    console.error("RibbonPopup: Arguments error, please check.")
                }
            }
        }
    }
    Overlay.modal:Rectangle{
        color:"transparent"
    }
    Overlay.modeless:Rectangle{
        color:"transparent"
    }
    onClosed: freeContent()
    function showContent(content, args){
        popup.contentItem.args = args
        if (content instanceof Component)
        {
            contentItems = content
            content.parent = popup
        }
        else
        {
            contentSource = content
        }
        open()
    }
    function closeContent(){
        close()
    }
    function freeContent(){
        if (destroyAfterClose)
        {
            contentSource = ""
            contentItems = undefined
        }
    }
}
