import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonBlur {
    id: control
    parent: Overlay.overlay
    implicitWidth: parent.width
    implicitHeight: folded ? barHeight : Window.window.viewItems.height
    maskColor: folded ? "transparent" : RibbonTheme.isDarkMode ? Qt.rgba(0,0,0,1) : Qt.rgba(1,1,1,1)
    maskOpacity: 0
    bottomLeftRadius: folded ? 0 : 5
    bottomRightRadius: bottomLeftRadius
    leftPadding: Window.window.tabBar && folded ? Window.window.tabBar.modernMargin : 0
    rightPadding: leftPadding
    enableEffect: !folded
    readonly property alias folded: folded_btn.checked
    property int animationTime: 400
    readonly property real currentMessageHeight: message_list.currentItem ? message_list.currentItem.height : 0
    readonly property real barHeight: folded ? currentMessageHeight + handler.height : 0
    property alias messageModel: messageModel
    property real topMargin: RibbonTheme.modernStyle && !folded ? 10 : 0

    Behavior on implicitHeight {
        NumberAnimation {
            duration: control.animationTime
            easing.type: Easing.OutSine
        }
    }

    ListModel{
        id: messageModel
        onCountChanged: {
            message_list.currentIndex = count ? count - 1 : 0
            if(count === 0)
                clearMessages()
        }
    }

    Timer{
        id: auto_scroll_btn_timer
        interval: control.animationTime * 2
        repeat: false
        onTriggered: {
            message_list.positionViewAtIndex(message_list.currentIndex, ListView.Center)
        }
    }

    RibbonRectangle{
        id: message_list_rect
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        color: folded ? RibbonTheme.isDarkMode ? "black" : "white" : "transparent"
        height: control.implicitHeight - (folded ? handler.height : 0)
        topLeftRadius: RibbonTheme.modernStyle && RibbonWindow.window.tabBar.folded ? 10 : 0
        topRightRadius: topLeftRadius
        bottomLeftRadius: RibbonTheme.modernStyle && folded ? 10 : 0
        bottomRightRadius: bottomLeftRadius
        ListView{
            id: message_list
            cacheBuffer: Math.abs(message_list.height * 2)
            interactive: !folded
            clip: true
            anchors.fill: parent
            model: messageModel
            delegate: Item{
                id: item
                implicitHeight: bar.contentHeight + (control.folded ? 0 : 10)
                implicitWidth: message_list.width
                RibbonMessageBar{
                    id: bar
                    anchors.centerIn: parent
                    property bool isCurrentItem: item === message_list.currentItem

                    text: model.text
                    externalURL: model.externalURL ? model.externalURL : ""
                    dismissAction: ()=>messageModel.remove(index)
                    Component.onCompleted: {
                        if(model.disableMultiline)
                            isMultiline = !model.disableMultiline
                        if(model.type)
                            type = model.type
                        if(model.rounded)
                            rounded = model.rounded
                        if(model.externalURLLabel)
                            externalURLLabel = model.externalURLLabel
                        if(model.dismissLabel)
                            dismissLabel = model.dismissLabel
                        if(model.overflowLabel)
                            overflowLabel = model.overflowLabel
                        if(model.actionALabel){
                            actionALabel = model.actionALabel
                            showActionA = true
                            if(model.actionA){
                                actionA = model.actionA
                            }else{
                                actionA = ()=>console.log(index+qsTr(`'s ${model.actionALabel} Clicked`))
                            }
                        }
                        if(model.actionBLabel){
                            actionBLabel = model.actionBLabel
                            showActionB = true
                            if(model.actionB){
                                actionB = model.actionB
                            }else{
                                actionB = ()=>console.log(index+qsTr(`'s ${model.actionBLabel} Clicked`))
                            }
                        }
                    }
                }
            }

            verticalLayoutDirection: ListView.BottomToTop

            add: Transition {
                NumberAnimation {
                    properties: "y"
                    from: -message_list.height
                    duration: control.animationTime
                }
            }
            remove: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: control.animationTime
                }
            }
            ScrollBar.vertical: RibbonScrollBar {
                anchors.right: message_list.right
                anchors.rightMargin: 2
                interactive: !folded
            }
            onCurrentItemChanged: {
                auto_scroll_btn_timer.restart()
            }
            Behavior on height {
                NumberAnimation {
                    duration: control.animationTime
                    easing.type: Easing.OutSine
                }
            }
        }
    }
    HoverHandler{
        id: hover
    }

    RibbonRectangle{
        id: handler
        x: message_list.x + (message_list.width - width) / 2
        y: message_list.y + message_list.height * (folded ? 1 : 0)
        implicitHeight: folded ? 10 : 20
        implicitWidth: folded ? 100 : control.width
        visible: hover.hovered && messageModel.count > 1
        bottomLeftRadius: folded ? 10 : 0
        bottomRightRadius: bottomLeftRadius
        color: RibbonTheme.isDarkMode ? Qt.rgba(0,0,0,1) : Qt.rgba(1,1,1,1)
        Behavior on color {
            ColorAnimation {
                duration: control.animationTime
                easing.type: Easing.OutSine
            }
        }

        RowLayout{
            anchors.centerIn: parent
            RibbonButton{
                checkable: true
                showBg: false
                showHoveredBg: false
                iconSource: RibbonIcons.DismissCircle
                ribbonIcon.iconSize: handler.implicitHeight - 2
                tipText: qsTr("Clear All")
                onClicked: clearMessages()
                visible: !folded
            }

            RibbonButton{
                id: folded_btn
                checkable: true
                showBg: false
                showHoveredBg: false
                ribbonIcon.iconSize: handler.implicitHeight - 2
                iconSource: RibbonIcons.TriangleDown
                rotation: checked ? 0 : 180
                checked: true
                tipText: checked ? qsTr("Show all messages") : qsTr("Hide all messages")
                textColor: RibbonTheme.isDarkMode ? "white" : "black"
                onClicked:{
                    auto_scroll_btn_timer.restart()
                }

                Behavior on rotation {
                    NumberAnimation {
                        duration: control.animationTime
                        easing.type: Easing.OutSine
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        message_list.currentIndex = messageModel.count > 0 ? messageModel.count - 1 : 0
        Window.window.messageBar = control
    }

    function showMessage(type, text, actionALabel, actionBLabel, externalURL,
                         externalURLLabel, disableMultiline, rounded){
        let item = {}
        if(type)
            item['type'] = type
        if(text)
            item['text'] = text
        if(actionALabel)
            item['actionALabel'] = actionALabel
        if(actionBLabel)
            item['actionBLabel'] = actionBLabel
        if(externalURL)
            item['externalURL'] = externalURL
        if(externalURLLabel)
            item['externalURLLabel'] = externalURLLabel
        if(disableMultiline)
            item['disableMultiline'] = disableMultiline
        if(rounded)
            item['rounded'] = rounded
        messageModel.append(item)
    }

    function clearMessages(){
        folded_btn.checked = true
        messageModel.clear()
    }
}
