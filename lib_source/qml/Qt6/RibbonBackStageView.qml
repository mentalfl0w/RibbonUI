import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Popup {
    id: control
    padding: 0
    parent: Overlay.overlay
    x: (Overlay.overlay.width - implicitWidth) / 2
    y: (Overlay.overlay.height - implicitHeight) / 2
    closePolicy: Popup.NoAutoClose
    enum MenuItemLocation {
        Head,
        Body,
        Tail
    }
    property bool blurEnabled: false
    property var blurTarget: control
    property bool showBackBtn: true
    property string backText: qsTr("Back")
    property int radius: 0
    property var pageModel: []
    property string bgColor: RibbonTheme.isDarkMode ? RibbonTheme.modernStyle ? "#0A0A0A" : "#262626" : RibbonTheme.modernStyle ? "#F0F0F0" : "white"
    property string menuBgColor: RibbonTheme.isDarkMode ? "#363636" : RibbonTheme.modernStyle ? "white" : "#365695"
    default property alias data: data_container.data
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

    Component.onCompleted: {
        for(let index = pageModel.length; index < data_container.resources.length; index++)
        {
            if(data_container.resources[index] instanceof RibbonBackStageMenuItem)
            {
                let item = data_container.resources[index]
                item.getPropertiesReady()
                pageModel.push(item.properties)
            }
        }
        if(pageModel.length)
            pageModelChanged()
        refreshModel()
    }
    onPageModelChanged: refreshModel()
    onAboutToShow: show()
    onBackBtnClicked: hide()

    Item{
        id: data_container
    }

    RibbonBlur{
        id: blur_bg
        anchors.fill: parent
        target: blurTarget
        targetRect: Qt.rect(control.x + control.leftMargin, control.y + control.topMargin, control.width, control.height)
        visible: blurEnabled
        maskColor: control.bgColor
        maskOpacity: 0
        blurRadius: 0
        radius: control.radius

        Behavior on maskOpacity {
            enabled: parent.visible
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }

        Behavior on blurRadius {
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
        color: Qt.alpha(control.menuBgColor, blurEnabled ? RibbonTheme.modernStyle ? 0.8 : 0.9 : 1)
        topLeftRadius: control.topMargin <= 0 ? control.radius : 0
        bottomLeftRadius: topLeftRadius
        property int currentMenu: 0

        RibbonButton{
            id: back_btn
            showBg: false
            showHoveredBg: false
            showTooltip: false
            text: backText
            font.pixelSize: 30
            iconSource: RibbonIcons.ArrowCircleLeft
            implicitHeight: ribbonIcon.height
            textColor: RibbonTheme.modernStyle && !RibbonTheme.isDarkMode ? "black" : "white"
            ribbonIcon.filled: hovered
            anchors{
                top: parent.top
                topMargin: 30
                left: parent.left
                leftMargin: 8
            }
            visible: showBackBtn
            ribbonIcon.iconSize: 30
            ribbonIcon.color: {
                if (RibbonTheme.modernStyle && !RibbonTheme.isDarkMode)
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
                    if (item_bg.view.type === RibbonBackStageView.MenuItemLocation.Head && menu_bg.currentMenu === 0)
                        return true
                    else if (item_bg.view.type === RibbonBackStageView.MenuItemLocation.Tail && menu_bg.currentMenu === 2)
                        return true
                    else if (item_bg.view.type === RibbonBackStageView.MenuItemLocation.Body && menu_bg.currentMenu === 1)
                        return true
                    return false
                }

                width: view.width
                height: item.height + margins * 2
                color: {
                    if(RibbonTheme.modernStyle)
                        return "transparent"
                    if(view.currentIndex === index && item_bg.isCurrentMenu)
                    {
                        if(mouse.containsMouse)
                        {
                            if(mouse.pressed)
                                return Qt.alpha(back_btn.textColor, 0.4)
                            return Qt.alpha(back_btn.textColor, 0.3)
                        }
                        else
                            return Qt.alpha(back_btn.textColor, 0.2)
                    }
                    else
                    {
                        if(mouse.containsMouse)
                        {
                            let color = back_btn.textColor === 'black' ? "white" : "black"
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
                            return RibbonTheme.isDarkMode ? "#666666" : "#D1D1D1"
                        return "transparent"
                    }
                    width: 2
                    height: parent.height - 4
                    visible: RibbonTheme.modernStyle
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
                        iconSource: typeof(model.menuIcon) === "number" ? model.menuIcon : 0
                        iconSourceFilled: typeof(model.menuIconFilled) === "number" ? model.menuIconFilled : iconSource
                        iconSize: menu_label.visible ? menu_label.contentHeight : 16
                        visible: typeof(model.menuIcon) === "number" && model.menuIcon
                        Layout.alignment: Qt.AlignVCenter
                        filled: item_bg.view.currentIndex === index && item_bg.isCurrentMenu
                        color: model.menuIconColor ? model.menuIconColor : back_btn.textColor
                    }
                    Image {
                        id: pic_icon
                        source: typeof(model.menuIcon) === "string" ? model.menuIcon : ""
                        visible: typeof(model.menuIcon) === "string"
                        fillMode:Image.PreserveAspectFit
                        mipmap: true
                        autoTransform: true
                        height: menu_label.visible ? menu_label.contentHeight : 16
                        width: height
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Text{
                        id: menu_label
                        text: model.menuText
                        color: !mouse.containsMouse && RibbonTheme.modernStyle && item_bg.view.currentIndex === index && item_bg.isCurrentMenu ? RibbonTheme.isDarkMode ? "#779CDB" : "#5882BB" : back_btn.textColor
                        Layout.alignment: Qt.AlignVCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 13
                        elide: Text.ElideRight
                        font.family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                        renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                        visible: text
                        Layout.preferredWidth: {
                            let w = 0
                            w += rib_icon.visible ? rib_icon.contentWidth : 0
                            w += pic_icon.visible ? pic_icon.width : 0
                            w += (rib_icon.visible || pic_icon.visible) && menu_label.text ? item.spacing : 0
                            return item_bg.width - w - item_bg.margins * 4
                        }
                        Layout.leftMargin: (!model.menuIcon && model.menuText) ? menu_label.contentHeight + item.spacing : 0
                    }
                }

                RibbonToolTip{
                    id: tooltip
                    visible: mouse.containsMouse && typeof(model.showTooltip) != "undefined" ? model.showTooltip : false
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
                            if (item_bg.view.type === RibbonBackStageView.MenuItemLocation.Head)
                            {
                                menu_bg.currentMenu = 0
                                ani_modern_border.targetMenu = head_menu_list
                            }
                            else if (item_bg.view.type === RibbonBackStageView.MenuItemLocation.Tail)
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
                property var type: RibbonBackStageView.MenuItemLocation.Head
            }
            Rectangle{
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 1
                Layout.preferredWidth: parent.width - 40
                color: RibbonTheme.modernStyle ? RibbonTheme.isDarkMode ? "#666666" : "#D1D1D1" :RibbonTheme.isDarkMode ? "#B1B1B1" : Qt.alpha("white", 0.2)
                visible: head_menu_list.count && (body_menu_list.count || tail_menu_list.count)
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
                property var type: RibbonBackStageView.MenuItemLocation.Body
            }
            Rectangle{
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 1
                Layout.preferredWidth: parent.width - 40
                color: RibbonTheme.modernStyle ? RibbonTheme.isDarkMode ? "#666666" : "#D1D1D1" :RibbonTheme.isDarkMode ? "#B1B1B1" : Qt.alpha("white", 0.2)
                visible: (head_menu_list.count || body_menu_list.count) && tail_menu_list.count
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
                property var type: RibbonBackStageView.MenuItemLocation.Tail
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
                if(RibbonTheme.isDarkMode)
                    return "#82ABF1"
                else
                    return "#1651AA"
            }
            width: 2
            height: (typeof(targetMenu.currentItem) !== 'undefined' && targetMenu.currentItem) ? targetMenu.currentItem.height - 4 : 0
            visible: RibbonTheme.modernStyle
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
        topRightRadius: control.topMargin <= 0 ? control.radius : 0
        bottomRightRadius: topRightRadius
        color: Qt.alpha(control.bgColor, 1)

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
                    source: typeof(modelData.sourceUrl) !== 'undefined' && modelData.sourceUrl !== ""? modelData.sourceUrl : ""
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

    RowLayout{
        visible: Qt.platform.os !== "osx"
        layoutDirection: Qt.RightToLeft
        spacing: 0
        anchors{
            top: parent.top
            right: parent.right
            margins: 5
        }

        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.Dismiss
            iconSourceFilled: RibbonIcons_Filled.Dismiss
            hoverColor: "#ED6B5E"
            pressedColor: "#B55149"
            textColorReverse: false
            tipText: qsTr("Close")
            onClicked: Window.window.close()
        }

        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.Subtract
            iconSourceFilled: RibbonIcons_Filled.Subtract
            hoverColor: "#F4BE4F"
            pressedColor: "#B78F3B"
            textColorReverse: false
            tipText: qsTr("Minimize")
            font.bold: pressed || checked
            onClicked: Window.window.visibility = Window.Minimized
        }

        RibbonButton{
            showBg:false
            iconSource: Window.window ? Window.window.visibility === Window.Maximized ? RibbonIcons.ArrowMinimize : RibbonIcons.ArrowMaximize : 0
            hoverColor: "#61C554"
            pressedColor: "#48953F"
            textColorReverse: false
            tipText: Window.window ? Window.window.visibility === Window.Maximized ? qsTr("Restore") : qsTr("Maximize") : ""
            onClicked: {
                if (Window.window.visibility === Window.Maximized)
                    Window.window.visibility = Window.Windowed
                else
                    Window.window.visibility = Window.Maximized
            }
        }
    }

    onBgColorChanged: {
        refresh()
    }

    function show(){
        control.opacity = 1
        menu_bg.x = 0
        content_bg.color = Qt.alpha(control.bgColor, blurEnabled ? RibbonTheme.modernStyle ? 0.95 : 0.9 : 1)
        blur_bg.maskOpacity = blurEnabled ? 0.5 : 1
        blur_bg.blurRadius = blurEnabled ? 32 : 0
        blur_bg.opacity = 1
    }

    function hide(){
        menu_bg.x = -menu_bg.width
        content_bg.color = Qt.alpha(control.bgColor, 0)
        blur_bg.maskOpacity = 0
        blur_bg.blurRadius = 0
        blur_bg.opacity = 0
        close()
    }

    function refresh(){
        content_bg.color = Qt.alpha(control.bgColor, blurEnabled ? RibbonTheme.modernStyle ? 0.95 : 0.9 : 1)
        blur_bg.maskOpacity = blurEnabled ? 0.5 : 1
        blur_bg.blurRadius = blurEnabled ? 32 : 0
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
            if(pageModel[i].type === RibbonBackStageView.MenuItemLocation.Head)
            {
                head_menu_list.model.append(item)
            }
            else if(pageModel[i].type === RibbonBackStageView.MenuItemLocation.Tail)
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
