import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Popup {
    id: control
    padding: 0
    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.NoAutoClose
    property bool blurEnabled: false
    property var blurTarget: control
    property bool showBackBtn: true
    property string backText: qsTr("Back")
    property int radius: 0
    property var pageModel: []

    signal backBtnClicked()

    background: Item{}
    exit: Transition {
        NumberAnimation {
            property: "opacity"
            duration: 300
            from:1
            to:0
            easing.type: Easing.OutSine
        }
    }

    Component.onCompleted: refreshModel()
    onPageModelChanged: refreshModel()
    onAboutToShow: show()
    onBackBtnClicked: hide()

    RibbonBlur{
        id: blur_bg
        anchors.fill: parent
        target: blurTarget
        target_rect: Qt.rect(control.x + control.leftMargin, control.y + control.topMargin, control.width, control.height)
        visible: blurEnabled
        mask_color: content_bg.color
        mask_opacity: 0
        blur_radius: 0
        radius: control.radius

        Behavior on mask_opacity {
            enabled: parent.visible
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }

        Behavior on blur_radius {
            enabled: parent.visible
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }

        Behavior on opacity {
            enabled: parent.visible
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }
    }

    RibbonRectangle{
        id: menu_bg
        anchors{
            top: parent.top
            bottom: parent.bottom
        }
        width: 150
        x: -width
        color: Qt.alpha(RibbonTheme.dark_mode ? "#363636" : RibbonTheme.modern_style ? "white" : "#365695", blurEnabled ? RibbonTheme.modern_style ? 0.8 : 0.9 : 1)
        topLeftRadius: control.topMargin === 0 ? control.radius : 0
        bottomLeftRadius: topLeftRadius
        property int currentMenu: 0

        RibbonButton{
            id: back_btn
            show_bg: false
            show_hovered_bg: false
            show_tooltip: false
            text: backText
            font.pixelSize: 30
            icon_source: RibbonIcons.ArrowCircleLeft
            implicitWidth: ribbon_icon.width
            implicitHeight: ribbon_icon.height
            text_color: RibbonTheme.modern_style && !RibbonTheme.dark_mode ? "black" : "white"
            ribbon_icon.filled: hovered
            anchors{
                top: parent.top
                topMargin: 30
                left: parent.left
                leftMargin: 30
            }
            visible: showBackBtn
            ribbon_icon.icon_size: 30
            ribbon_icon.color: {
                if (RibbonTheme.modern_style && !RibbonTheme.dark_mode)
                {
                    if(pressed)
                        return Qt.alpha("black", 0.8)
                    else
                        return "black"
                }
                else
                {
                    if(pressed)
                        return Qt.alpha("white", 0.8)
                    else
                        return "white"
                }
            }

            onClicked: backBtnClicked()
        }

        Component{
            id: list_item
            Rectangle{
                id: item_bg
                property int margins: 10
                property var view: ListView.view
                property bool clickOnly: typeof(model.clickOnly) !== 'undefined' ? model.clickOnly : false
                property bool isCurrentMenu: {
                    if (item_bg.view.type === "head" && menu_bg.currentMenu === 0)
                        return true
                    else if (item_bg.view.type === "tail" && menu_bg.currentMenu === 2)
                        return true
                    else if (item_bg.view.type === "body" && menu_bg.currentMenu === 1)
                        return true
                    return false
                }

                width: view.width
                height: item.height + margins * 2
                color: {
                    if(RibbonTheme.modern_style)
                        return "transparent"
                    if(view.currentIndex === index && item_bg.isCurrentMenu)
                    {
                        if(mouse.containsMouse)
                        {
                            if(mouse.pressed)
                                return Qt.alpha(back_btn.text_color, 0.4)
                            return Qt.alpha(back_btn.text_color, 0.3)
                        }
                        else
                            return Qt.alpha(back_btn.text_color, 0.2)
                    }
                    else
                    {
                        if(mouse.containsMouse)
                        {
                            let color = back_btn.text_color === 'black' ? "white" : "black"
                            if(mouse.pressed)
                                return Qt.alpha(color, 0.3)
                            return Qt.alpha(color, 0.2)
                        }
                        else
                            return 'transparent'
                    }
                }

                Rectangle{
                    id: modern_border
                    anchors{
                        left: parent.left
                        leftMargin: 3
                        verticalCenter: parent.verticalCenter
                    }
                    radius: width / 2
                    color: {
                        if (mouse.containsMouse)
                            return RibbonTheme.dark_mode ? "#666666" : "#D1D1D1"
                        return "transparent"
                    }
                    width: 2
                    height: parent.height - 4
                    visible: RibbonTheme.modern_style
                }

                RowLayout{
                    id: item
                    anchors{
                        left: modern_border.visible ? modern_border.right : parent.left
                        leftMargin: (modern_border.visible ? -(modern_border.width + modern_border.anchors.leftMargin) : 0) + item_bg.margins * 2
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    RibbonIcon{
                        id :rib_icon
                        icon_source: typeof(model.menu_icon) === "number" ? model.menu_icon : 0
                        icon_source_filled: typeof(model.menu_icon_filled) === "number" ? model.menu_icon_filled : icon_source
                        icon_size: menu_label.contentHeight
                        visible: typeof(model.menu_icon) === "number" && model.menu_icon
                        Layout.alignment: Qt.AlignVCenter
                        filled: item_bg.view.currentIndex === index && item_bg.isCurrentMenu
                        color: model.menu_icon_color ? model.menu_icon_color : back_btn.text_color
                    }
                    Image {
                        id: pic_icon
                        source: typeof(model.menu_icon) === "string" ? model.menu_icon : ""
                        visible: typeof(model.menu_icon) === "string"
                        fillMode:Image.PreserveAspectFit
                        height: menu_label.contentHeight
                        width: height
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Text{
                        id: menu_label
                        text: model.menu_text
                        color: !mouse.containsMouse && RibbonTheme.modern_style && item_bg.view.currentIndex === index && item_bg.isCurrentMenu ? RibbonTheme.dark_mode ? "#779CDB" : "#5882BB" : back_btn.text_color
                        Layout.alignment: Qt.AlignVCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 13
                        elide: Text.ElideRight
                        font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                        renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                        Layout.preferredWidth: {
                            let w = 0
                            w += rib_icon.visible ? rib_icon.contentWidth : 0
                            w += pic_icon.visible ? pic_icon.width : 0
                            w += (rib_icon.visible || pic_icon.visible) && menu_label.text ? item.spacing : 0
                            return item_bg.width - w - item_bg.margins * 4
                        }
                        Layout.leftMargin: (!model.menu_icon && model.menu_text) ? menu_label.contentHeight + item.spacing : 0
                    }
                }

                RibbonToolTip{
                    id: tooltip
                    visible: mouse.containsMouse && typeof(model.show_tooltip) != "undefined" ? model.show_tooltip : false
                                                                                                && typeof(model.tool_text) != "undefined" ? model.tool_text : false
                    text: model.tool_text ? model.tool_text : ""
                }

                MouseArea{
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if (item_bg.clickOnly)
                        {
                            control.pageModel[model.globalIndex].clickFunc()
                        }
                        else{
                            if (item_bg.view.type === "head")
                            {
                                menu_bg.currentMenu = 0
                                ani_modern_border.targetMenu = head_menu_list
                            }
                            else if (item_bg.view.type === "tail")
                            {
                                menu_bg.currentMenu = 2
                                ani_modern_border.targetMenu = tail_menu_list
                            }
                            else
                            {
                                menu_bg.currentMenu = 1
                                ani_modern_border.targetMenu = body_menu_list
                            }
                            item_bg.view.currentIndex = index
                            content_view.currentIndex = model.globalIndex
                        }
                    }
                }
            }
        }

        ColumnLayout{
            id: list_layout
            anchors{
                top: back_btn.bottom
                topMargin: 10
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                bottomMargin: anchors.topMargin * 3
            }
            ListView{
                id: head_menu_list
                model: ListModel{
                }
                delegate: list_item
                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: contentHeight
                clip: true
                interactive: false
                property string type: "head"
            }
            Rectangle{
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 1
                Layout.preferredWidth: parent.width - 40
                color: RibbonTheme.modern_style ? RibbonTheme.dark_mode ? "#666666" : "#D1D1D1" :RibbonTheme.dark_mode ? "#B1B1B1" : Qt.alpha("white", 0.2)
                visible: body_menu_list.count
            }
            ListView{
                id: body_menu_list
                model: ListModel{
                }
                delegate: list_item
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: parent.height - head_menu_list.contentHeight - tail_menu_list.contentHeight
                ScrollIndicator.vertical: RibbonScrollIndicator {
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                }
                clip: true
                property string type: "body"
            }
            Rectangle{
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 1
                Layout.preferredWidth: parent.width - 40
                color: RibbonTheme.modern_style ? RibbonTheme.dark_mode ? "#666666" : "#D1D1D1" :RibbonTheme.dark_mode ? "#B1B1B1" : Qt.alpha("white", 0.2)
                visible: tail_menu_list.count
            }
            ListView{
                id: tail_menu_list
                model: ListModel{
                }
                delegate: list_item
                Layout.alignment: Qt.AlignBottom
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: contentHeight
                clip: true
                interactive: false
                property string type: "tail"
            }
        }

        Rectangle{
            id: ani_modern_border
            property int leftMargin: 3
            property var targetMenu: head_menu_list
            x: leftMargin
            y: list_layout.y + targetMenu.y + (typeof(targetMenu.currentItem) !== 'undefined' && targetMenu.currentItem ? (targetMenu.currentItem.y + 2) : 0)
            radius: width / 2
            color: {
                if(RibbonTheme.dark_mode)
                    return "#82ABF1"
                else
                    return "#1651AA"
            }
            width: 2
            height: (typeof(targetMenu.currentItem) !== 'undefined' && targetMenu.currentItem) ? targetMenu.currentItem.height - 4 : 0
            visible: RibbonTheme.modern_style
            Behavior on y {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuart
                }
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }
    }

    RibbonRectangle{
        id: content_bg
        anchors{
            top: parent.top
            left: menu_bg.right
            right: parent.right
            bottom: parent.bottom
        }
        topRightRadius: control.topMargin === 0 ? control.radius : 0
        bottomRightRadius: topRightRadius
        color: Qt.alpha(RibbonTheme.dark_mode ? RibbonTheme.modern_style ? "#0A0A0A" : "#262626" : RibbonTheme.modern_style ? "#F0F0F0" : "white", 0)

        Behavior on color {
            ColorAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }

        SwipeView{
            id: content_view
            interactive: false
            anchors.fill: parent
            spacing: 0
            orientation: Qt.Vertical
            Repeater{
                model: control.pageModel
                Loader {
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    source: typeof(modelData.sourceUrl) !== 'undefined' ? modelData.sourceUrl : ""
                    sourceComponent: typeof(control.pageModel[modelData.globalIndex].sourceComponent) !== 'undefined' && typeof(modelData.sourceUrl) === 'undefined' ? control.pageModel[modelData.globalIndex].sourceComponent : undefined
                    onLoaded: {
                        if (typeof(modelData.sourceArgs) === 'undefined')
                            return
                        else if(Object.keys(modelData.sourceArgs).length){
                            for (let arg in modelData.sourceArgs){
                                item[arg] = modelData.sourceArgs[arg]
                            }
                        }
                        else{
                            console.error("RibbonBackStageView: Arguments error, please check.")
                        }
                    }
                }
            }
        }
    }


    Connections{
        target: RibbonTheme
        function onTheme_modeChanged(){
            refresh()
        }
    }

    function show(){
        menu_bg.x = 0
        content_bg.color = Qt.alpha(RibbonTheme.dark_mode ? RibbonTheme.modern_style ? "#0A0A0A" : "#262626" : RibbonTheme.modern_style ? "#F0F0F0" : "white", blurEnabled ? RibbonTheme.modern_style ? 0.95 : 0.9 : 1)
        blur_bg.mask_opacity = blurEnabled ? 0.5 : 1
        blur_bg.blur_radius = blurEnabled ? 32 : 0
        blur_bg.opacity = 1
    }

    function hide(){
        menu_bg.x = -menu_bg.width
        content_bg.color = Qt.alpha(RibbonTheme.dark_mode ? RibbonTheme.modern_style ? "#0A0A0A" : "#262626" : RibbonTheme.modern_style ? "#F0F0F0" : "white", 0)
        blur_bg.mask_opacity = 0
        blur_bg.blur_radius = 0
        blur_bg.opacity = 0
        close()
    }

    function refresh(){
        content_bg.color = Qt.alpha(RibbonTheme.dark_mode ? RibbonTheme.modern_style ? "#0A0A0A" : "#262626" : RibbonTheme.modern_style ? "#F0F0F0" : "white", blurEnabled ? RibbonTheme.modern_style ? 0.95 : 0.9 : 1)
        blur_bg.mask_opacity = blurEnabled ? 0.5 : 1
        blur_bg.blur_radius = blurEnabled ? 32 : 0
        blur_bg.opacity = 1
    }

    function refreshModel(){
        head_menu_list.model.clear()
        body_menu_list.model.clear()
        tail_menu_list.model.clear()
        for (let i=0; i < pageModel.length; i++)
        {
            let item = pageModel[i]
            item['globalIndex'] = i
            if(pageModel[i].type === 'head')
            {
                head_menu_list.model.append(item)
            }
            else if(pageModel[i].type === 'tail')
            {
                tail_menu_list.model.append(item)
            }
            else
            {
                body_menu_list.model.append(item)
            }
        }
    }
}
