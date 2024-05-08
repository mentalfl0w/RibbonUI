import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import RibbonUI
import Qt5Compat.GraphicalEffects

Popup {
    id: popup
    parent: Overlay.overlay
    property var targetList: []
    property bool blur_enabled: false
    property alias target: blur.target
    property alias target_rect: blur.target_rect
    property alias radius: blur.radius
    property string content_source: "RibbonTourContent.qml"
    property var content_items: undefined
    property bool destroy_after_close: true
    property var currentTarget: targetList ? targetList[0].target : parent
    property int currentIndex: 0
    property bool preferShowAbove: true
    property bool useHighlightOrRect: true
    property real contentEdgeMargin: 10
    property alias content_args: control.args
    property alias alwaysNotAutoPopup: always_hide_ckbox.checked
    modal: true
    margins: 0
    padding: 0
    topInset: 0
    leftInset: 0
    rightInset: 0
    bottomInset: 0
    closePolicy: Popup.NoAutoClose
    Overlay.modal:Rectangle{
        color: !RibbonTheme.dark_mode ? Qt.alpha("white", 0.5) : Qt.alpha("black", 0.5)
    }
    Overlay.modeless:Rectangle{
        color:"transparent"
    }
    background: Item{
        RectangularGlow {
            id: effect
            anchors.fill: blur
            anchors.margins: blur.mask_border.width
            glowRadius: 10
            spread: 0
            color: RibbonTheme.dark_mode ? Qt.rgba(0,0,0,0.7) : Qt.rgba(0,0,0,0.45)
            cornerRadius: blur.radius + glowRadius + 10
        }
        RibbonBlur{
            implicitHeight: parent.height
            implicitWidth: parent.width
            id: blur
            radius: 10
            mask_opacity: blur_enabled ? 0.9 : 1
            mask_border.color: RibbonTheme.modern_style ?
                                   RibbonTheme.dark_mode ? "#7A7A7A" : "#2C59B7" :
            RibbonTheme.dark_mode ? "#5C5D5D" : "#B5B4B5"
            mask_border.width: 1
        }
    }
    contentItem: Item{
        id: control
        x:0
        y:0
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
            show_bg: false
            show_hovered_bg: false
            icon_source: RibbonIcons.Dismiss
            onClicked: popup.close()
        }
        ColumnLayout{
            id: container
            spacing: 10
            Loader{
                id: loader
                width: item ? item.implicitWidth : 50
                height: item ? item.implicitHeight : 50
                sourceComponent: content_source ? undefined : content_items
                source: content_source
                onLoaded: {
                    if (!control.args)
                        return
                    else if(Object.keys(control.args).length){
                        for (let arg in control.args){
                            item[arg] = control.args[arg]
                        }
                    }
                    else{
                        console.error("RibbonTour: Arguments error, please check.")
                    }
                }
            }
            RowLayout{
                Layout.leftMargin: 10
                Layout.rightMargin: Layout.leftMargin
                Layout.bottomMargin: Layout.leftMargin
                spacing: 20
                RibbonCheckBox{
                    id: always_hide_ckbox
                    show_tooltip: false
                    text: qsTr("Don't auto pop up")
                }
                RibbonButton{
                    id: previous_btn
                    text: qsTr("Previous")
                    show_tooltip: false
                    enabled: popup.currentIndex
                    onClicked: {
                        if(popup.targetList[popup.currentIndex].exit_func)
                            popup.targetList[popup.currentIndex].exit_func()
                        popup.currentIndex--
                        popup.currentTarget = popup.targetList[popup.currentIndex].target
                    }
                }
                RibbonButton{
                    id: next_btn
                    text: (popup.currentIndex + 1) === popup.targetList.length ? qsTr("Finish") : qsTr("Next")
                    show_tooltip: false
                    onClicked: {
                        if ((popup.currentIndex + 1) === popup.targetList.length)
                        {
                            popup.close()
                        }
                        else
                        {
                            if(popup.targetList[popup.currentIndex].exit_func)
                                popup.targetList[popup.currentIndex].exit_func()
                            popup.currentIndex++
                            popup.currentTarget = popup.targetList[popup.currentIndex].target
                        }
                    }
                }
            }
        }
    }

    Popup{
        id: rec
        parent: Overlay.overlay
        margins: 0
        padding: 0
        topInset: 0
        leftInset: 0
        rightInset: 0
        bottomInset: 0
        closePolicy: Popup.NoAutoClose
        property int borderWidth: popup.useHighlightOrRect ? 0 : 3
        Overlay.modal:Rectangle{
            color:"transparent"
        }
        Overlay.modeless:Rectangle{
            color:"transparent"
        }
        background: Item{}
        contentItem:Rectangle{
            color: 'transparent'
            border.width: rec.borderWidth
            border.color: RibbonTheme.dark_mode ? "#3B69DA" : "#2C59B7"
            radius: 5
            ShaderEffectSource {
                anchors.centerIn: parent
                width: currentTarget.width
                height: currentTarget.height
                sourceRect: Qt.rect(0, 0, currentTarget.width, currentTarget.height)
                sourceItem: currentTarget
                visible: popup.useHighlightOrRect
            }
        }
        Behavior on x {
            enabled: !popup.useHighlightOrRect
            NumberAnimation {
                id: ani
                duration: 300
                easing.type: Easing.OutSine
            }
        }
        Behavior on y {
            enabled: !popup.useHighlightOrRect
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }
        Behavior on contentWidth {
            enabled: !popup.useHighlightOrRect
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }
        Behavior on contentHeight {
            enabled: !popup.useHighlightOrRect
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }
    }

    onCurrentTargetChanged: {
        Qt.callLater(function() {
            popup.update()
            if(popup.targetList[popup.currentIndex].enter_func)
                popup.targetList[popup.currentIndex].enter_func()
        })
    }

    Behavior on x {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutSine
        }
    }

    Behavior on y {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutSine
        }
    }

    onAboutToHide: {
        rec.close()
        if(popup.targetList[popup.currentIndex].exit_func)
            popup.targetList[popup.currentIndex].exit_func()
        loader.sourceComponent = undefined
        loader.source = ""
    }

    onAboutToShow: {
        loader.sourceComponent = content_source ? undefined : content_items
        loader.source = content_source
        rec.open()
        currentTarget = targetList[0].target
        currentIndex = 0
    }

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

    Timer{
        id: refresh_timer
        interval: 200
        repeat: false
        triggeredOnStart: false
        onTriggered: Qt.callLater(()=>{
                                      popup.update()
                                      rec.visible = true
                                  })
    }

    function getX()
    {
        let targetX = currentTarget.mapToGlobal(0,0).x
        let showX = (targetX + currentTarget.width/2) - (width/2)
        showX = Overlay.overlay.mapFromGlobal(showX,0).x
        if(showX < contentEdgeMargin)
            return contentEdgeMargin
        if((showX + width + contentEdgeMargin) >Overlay.overlay.width)
            return Overlay.overlay.width - width - contentEdgeMargin
        return showX
    }

    function getY()
    {
        let targetY = currentTarget.mapToGlobal(0,0).y
        let showY = targetY + (preferShowAbove ? - height - contentEdgeMargin : currentTarget.height + contentEdgeMargin)
        let sub_showY = targetY + (preferShowAbove ? currentTarget.height + contentEdgeMargin : - height - contentEdgeMargin)
        showY = Overlay.overlay.mapFromGlobal(0,showY).y
        sub_showY = Overlay.overlay.mapFromGlobal(0,sub_showY).y
        if(showY < 30)
        {
            if (sub_showY < 30)
                return 30
            else
                return sub_showY
        }
        if((showY + height + contentEdgeMargin) > Overlay.overlay.height)
        {
            if ((sub_showY + height + contentEdgeMargin) > Overlay.overlay.height)
                return Overlay.overlay.height - height - contentEdgeMargin
            else
                return sub_showY
        }
        return showY
    }

    function refresh(delay)
    {
        rec.visible = false
        if(typeof(delay) != 'undefined')
            refresh_timer.interval = delay
        refresh_timer.start()
    }

    function update()
    {
        popup.x = getX()
        popup.y = getY()
        rec.x = Overlay.overlay.mapFromGlobal(currentTarget.mapToGlobal(0,0).x,0).x - rec.borderWidth*2
        rec.y = Overlay.overlay.mapFromGlobal(0, currentTarget.mapToGlobal(0,0).y).y - rec.borderWidth*2
        rec.contentWidth = currentTarget.width + rec.borderWidth*4
        rec.contentHeight = currentTarget.height + rec.borderWidth*4
    }
}
