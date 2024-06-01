import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.15
import RibbonUI 1.0

RibbonWindow {
    id:root
    width: 1200
    height: 800
    title: qsTr("RibbonUI APP")
    comfirmedQuit: true
    property bool modernStyle: RibbonTheme.modernStyle
    RibbonTour{
        id: tour
        targetList: [
            {
                title: qsTr("Tab Bar"),
                text: qsTr("A tab bar for window, let user choose the controllers."),
                target: tab_bar,
                enter_func: ()=>{
                    tab_bar.folded = false
                    tour.refresh(300) // Use it if has animation
                }
            },
            {
                title: qsTr("Tab Bar Buttons"),
                text: qsTr("Tool buttons at the top of tab bar."),
                target: tab_bar_tool
            },
            {
                title: qsTr("Sliders"),
                text: qsTr("Vertical/Horizental sliders with/without buttons."),
                target: slider_layout,
                enter_func: ()=>{
                    tab_bar.setPage(0)
                    slider_with_btn.value = 70
                    slider_without_btn.value = 70
                    tour.refresh(500)
                },
                exit_func: ()=>{
                    slider_with_btn.value = 50
                    slider_without_btn.value = 50
                }
            },
            {
                title: qsTr("Switch Buttons"),
                text: qsTr("Switch buttons with/without background color or grabber text."),
                target: switch_layout,
                enter_func: ()=>btn_with_color_and_grabberText.checked = true,
                exit_func: ()=>btn_with_color_and_grabberText.checked = false
            },
            {
                title: qsTr("CheckBoxs"),
                text: qsTr("CheckBoxs with colorful background or with/without label text."),
                target: checkbox_layout
            },
            {
                title: qsTr("Buttons"),
                text: qsTr("Buttons with/without background or label text."),
                target: button_layout,
                enter_func: ()=>btn_without_bg_and_label.checked = true,
                exit_func: ()=>btn_without_bg_and_label.checked = false
            },
            {
                title: qsTr("Push Buttons"),
                text: qsTr("Push buttons with/without sub menu."),
                target: pushbutton_layout
            },
            {
                title: qsTr("Line Edits"),
                text: qsTr("Line edits with/without icon."),
                target: lineedit_layout,
                enter_func: ()=>{
                    tab_bar.setPage(1)
                    lineedit_with_icon.text = "Line Edit with icon."
                    tour.refresh(300)
                },
                exit_func: ()=>{
                    tab_bar.setPage(0)
                    lineedit_with_icon.clear()
                    tour.refresh(300)
                }
            },
            {
                title: qsTr("Bottom Bar"),
                text: qsTr("A bottom bar for window."),
                target: bottom_bar
            },
        ]
        target: windowItems
        blurEnabled: true
        targetRect: Qt.rect(windowItems.x + x, windowItems.y + y, width, height)
    }
    Component.onCompleted: tour.open()
    RibbonTabBar {
        id: tab_bar
        modernStyle: root.modernStyle
        rightToolBar: RowLayout{
            id: tab_bar_tool
            spacing: 10
            RibbonButton{
                text:"Test Button 1"
                iconSource: RibbonIcons.Alert
                checkable: true
            }
            RibbonButton{
                text:"Test Button 2"
            }
        }

        onSettingsBtnClicked:{
            backstagepopup.open()
        }

        RibbonTabPage{
            id: basic_page
            title: qsTr("Basic")
            RibbonTabGroup{
                showOpenExternal: true
                width: slider_layout.width + 20
                text: qsTr("Slider")
                RowLayout{
                    id: slider_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 0
                    RibbonSlider{
                        id: slider_with_btn
                        Layout.alignment: Qt.AlignVCenter
                        slideWidth: 40
                        horizontal: false
                        value: 20
                    }
                    RibbonSlider{
                        id: slider_without_btn
                        Layout.alignment: Qt.AlignVCenter
                        slideWidth: 40
                        horizontal: false
                        showButton: false
                        value: 40
                    }
                    ColumnLayout{
                        spacing: 0
                        Layout.alignment: Qt.AlignVCenter
                        RibbonSlider{
                            Layout.alignment: Qt.AlignHCenter
                            slideWidth: 40
                            value: 60
                        }
                        RibbonSlider{
                            Layout.alignment: Qt.AlignHCenter
                            slideWidth: 40
                            showButton: false
                            value: 80
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: switch_layout.width + 30
                text: qsTr("Switch Button")
                showOpenExternal: true
                RowLayout{
                    id: switch_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 0
                    ColumnLayout{
                        spacing: 5
                        RibbonSwitchButton{
                            id: btn_with_color_and_grabberText
                            text: "Button"
                            grabberCheckedColor: "red"
                            checked: true
                        }
                        RibbonSwitchButton{
                            text: "Button"
                            textOnLeft: true
                            grabberCheckedColor: "orange"
                            checked: true
                        }
                        RibbonSwitchButton{
                            grabberCheckedColor: "blue"
                        }
                    }
                    ColumnLayout{
                        spacing: 5
                        RibbonSwitchButton{
                            text: "Button"
                            showGrabberText: false
                            grabberCheckedColor: "green"
                        }
                        RibbonSwitchButton{
                            text: "Button"
                            showGrabberText: false
                            textOnLeft: true
                            grabberCheckedColor: "indigo"
                            checked: true
                        }
                        RibbonSwitchButton{
                            showGrabberText: false
                            grabberCheckedColor: "yellow"
                            checked: true
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: checkbox_layout.width + 30
                text: qsTr("CheckBox")
                showOpenExternal: true
                RowLayout{
                    id: checkbox_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 0
                    ColumnLayout{
                        spacing: 10
                        RibbonCheckBox{
                            text: "CheckBox"
                            iconFilledBgColor: "blue"
                            checked: true
                        }
                        RibbonCheckBox{
                            text: "CheckBox"
                            textOnLeft: true
                            iconFilledBgColor: "red"
                        }
                        RowLayout{
                            spacing: 30
                            RibbonCheckBox{
                                iconFilledBgColor:"orange"
                                tipText: "CheckBox"
                                showTooltip: true
                                checked: true
                            }
                            RibbonCheckBox{
                                iconFilledBgColor:"purple"
                            }
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: button_layout.width + 30
                text: qsTr("Button")
                showOpenExternal: true
                RowLayout{
                    id: button_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 1
                    ColumnLayout{
                        spacing: 10
                        RibbonButton{
                            text:"Button"
                            iconSource: RibbonIcons.Accessibility
                            checkable: true
                        }
                        RibbonButton{
                            text:"Button"
                        }
                        RibbonButton{
                            text:"Button"
                            showTooltip: false
                        }
                    }
                    ColumnLayout{
                        spacing: 10
                        RibbonButton{
                            text:"Button"
                            showBg:false
                            iconSource: RibbonIcons.Beaker
                            checkable: true
                        }
                        RibbonButton{
                            text:"Button"
                            showBg:false
                        }
                        RibbonButton{
                            text:"Button"
                            showBg:false
                            showTooltip: false
                        }
                    }
                    ColumnLayout{
                        spacing: 10
                        RibbonButton{
                            id: btn_without_bg_and_label
                            showBg:false
                            iconSource: RibbonIcons.Badge
                            iconSourceFilled: RibbonIcons_Filled.Badge
                            checkable: true
                            tipText: "Button"
                        }
                        RibbonButton{
                            showBg:false
                            iconSource: RibbonIcons.Clock
                            iconSourceFilled: RibbonIcons_Filled.Clock
                            tipText: "Button"
                        }
                        RibbonButton{
                            showBg:false
                            iconSource: RibbonIcons.Board
                            iconSourceFilled: RibbonIcons_Filled.Board
                            checkable: true
                            tipText: "Button"
                            showTooltip: false
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: pushbutton_layout.width + 30
                text: qsTr("Push Button")
                RowLayout{
                    id: pushbutton_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    RibbonPushButton{
                        text: qsTr("No Menu")
                        iconSource: RibbonIcons.AttachText
                    }
                    RibbonPushButton{
                        id: push_btn_with_menu
                        text: qsTr("Menu")
                        iconSource: RibbonIcons.MeetNow
                        Action{
                            text: "Test Item 1"
                        }
                        RibbonMenuSeparator{}
                        Action{
                            text: "Test Item 2"
                            enabled: false
                        }
                    }
                    RibbonPushButton{
                        text: qsTr("No Menu")
                        iconSource: "qrc:/qt/qml/RibbonUIAPP/resources/imgs/heart.png"
                        iconSize: height-5
                    }
                    RibbonPushButton{
                        text: qsTr("Menu")
                        iconSource: "qrc:/qt/qml/RibbonUIAPP/resources/imgs/search.png"
                        Action{
                            text: "Test Item 3"
                        }
                        RibbonMenuSeparator{}
                        Action{
                            text: "Test Item 4"
                            enabled: false
                        }
                    }
                }
            }
        }
        RibbonTabPage{
            title: qsTr("Input")
            RibbonTabGroup{
                width: lineedit_layout.width + 30
                text: qsTr("Line Edit")
                RowLayout{
                    id: lineedit_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonLineEdit{
                        }
                        RibbonLineEdit{
                            showClearBtn:false
                        }
                    }
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonLineEdit{
                            id: lineedit_with_icon
                            iconSource:RibbonIcons.Search
                        }
                        RibbonLineEdit{
                            iconSource:RibbonIcons.Keyboard
                            showClearBtn:false
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: lineedit_layout.width + 30
                text: qsTr("Text Edit")
                RowLayout{
                    id: textedit_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    ColumnLayout{
                        spacing: 30
                        Layout.fillHeight: true
                        RibbonTextEdit{
                            maxHeight: 50
                        }
                        RibbonTextEdit{
                            maxHeight: 30
                            showClearBtn:false
                        }
                    }
                    ColumnLayout{
                        spacing: 30
                        Layout.fillHeight: true
                        RibbonTextEdit{
                            maxHeight: 50
                            iconSource:RibbonIcons.Search
                        }
                        RibbonTextEdit{
                            maxHeight: 30
                            iconSource:RibbonIcons.Keyboard
                            showClearBtn:false
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: combobox_layout.width + 30
                text: qsTr("Combo Box")
                RowLayout{
                    id: combobox_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonComboBox{
                            model: ListModel {
                                ListElement { text: "Test Item 1" }
                                ListElement { text: "Test Item 2" }
                                ListElement { text: "Test Item 3" }
                            }
                        }
                        RibbonComboBox{
                            editable: true
                            model: ListModel {
                                id: model
                                ListElement { text: "Test Item 1" }
                                ListElement { text: "Test Item 2" }
                                ListElement { text: "Test Item 3" }
                            }
                            onAccepted: {
                                if (find(editText) === -1 && editText)
                                    model.append({text: editText})
                            }
                        }
                    }
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonComboBox{
                            model: ListModel {
                                ListElement { text: "Test Item 1" }
                                ListElement { text: "Test Item 2" }
                                ListElement { text: "Test Item 3" }
                            }
                            iconSource: RibbonIcons.Beaker
                        }
                        RibbonComboBox{
                            editable: true
                            model: ListModel {
                                id: model_1
                                ListElement { text: "Test Item 1" }
                                ListElement { text: "Test Item 2" }
                                ListElement { text: "Test Item 3" }
                            }
                            iconSource: RibbonIcons.Calendar
                            onAccepted: {
                                if (find(editText) === -1 && editText)
                                    model_1.append({text: editText})
                            }
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: spinbox_layout.width + 30
                text: qsTr("Spin Box")
                showBorder: false
                RowLayout{
                    id: spinbox_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonSpinBox{
                            width: 100
                        }
                        RibbonSpinBox{
                            id: spinbox
                            width: 80
                            iconSource: RibbonIcons.DataPie
                            validator: DoubleValidator {
                                bottom: Math.min(spinbox.from, spinbox.to)
                                top:  Math.max(spinbox.from, spinbox.to)
                                decimals: 2
                                notation: DoubleValidator.StandardNotation
                            }
                            textFromValue: function(value, locale) {
                                return Number(value / 100).toLocaleString(locale, 'f', 2)
                            }
                            valueFromText: function(text, locale) {
                                return Math.round(Number.fromLocaleString(locale, text) * 100)
                            }
                        }
                    }
                }
            }
        }
        RibbonTabPage{
            title: qsTr("Views")
            RibbonTabGroup{
                width: message_list_view_layout.width + 30
                text: qsTr("MessageListView")
                RowLayout{
                    id: message_list_view_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    RibbonButton{
                        text: qsTr('Open Message List View')
                        iconSource: RibbonIcons.Open
                        onClicked: {
                            Window.window.popup.showContent("qrc:/qt/qml/RibbonUIAPP/components/RibbonMessageListViewExample.qml")
                        }
                    }
                }
            }
        }
        RibbonTabPage{
            title: qsTr("Others")
            RibbonTabGroup{
                width: text_layout.width + 30
                text: qsTr("Text")
                RowLayout{
                    id: text_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonText{
                            font.pixelSize: 13
                            text: "Test Text"
                        }
                        RibbonText{
                            font.pixelSize: 13
                            text: "Test Text (Read Only)"
                            viewOnly: true
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: menu_layout.width + 30
                text: qsTr("Menu")
                RowLayout{
                    id: menu_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    RibbonButton{
                        text: qsTr("Open Menu")
                        iconSource: RibbonIcons.Open
                        onClicked: menu.popup()
                    }
                }
            }
            RibbonTabGroup{
                width: popup_layout.width + 30
                text: qsTr("Popup")
                RowLayout{
                    id: popup_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonButton{
                            text: qsTr("Open Popup")
                            iconSource: RibbonIcons.Open
                            onClicked: popup.open()
                        }
                        RibbonButton{
                            text: qsTr("Open Popup Dialog (Double Choices)")
                            iconSource: RibbonIcons.Open
                            onClicked: {
                                dialog.buttonFlags = RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton
                                dialog.open()
                            }
                        }
                        RibbonButton{
                            text: qsTr("Open Popup Dialog (Triple Choices)")
                            iconSource: RibbonIcons.Open
                            onClicked: {
                                dialog.buttonFlags = RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton | RibbonPopupDialogType.NeutralButton
                                dialog.open()
                            }
                        }
                    }
                    RibbonPopup{
                        id: popup
                        height: 200
                        width: height
                        target: windowItems
                        blurEnabled: true
                        targetRect: Qt.rect(windowItems.x + x, windowItems.y + y, width, height)
                    }
                    RibbonPopupDialog{
                        id: dialog
                        target: windowItems
                        blurEnabled: true
                        targetRect: Qt.rect(windowItems.x + x, windowItems.y + y, width, height)
                    }
                }
            }
        }
    }

    RibbonPaperView{
        id: view
        anchors.fill: parent
        topPadding: tab_bar.height
        bottomPadding: bottom_bar.height
        pageWidth: (page_slider.value / 100.0) * width
        spacing: 0
        ColumnLayout{
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 30
            spacing: 20
            RibbonText{
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 50
                text: "RibbonUI"
                font{
                    pixelSize: 50
                    bold: true
                    italic: true
                }
            }
            Image {
                source: "qrc:/qt/qml/RibbonUI/resources/imgs/icon.png"
                fillMode:Image.PreserveAspectFit
                Layout.preferredHeight: 300
                Layout.preferredWidth: height
                Layout.alignment: Qt.AlignHCenter
                layer.enabled: true
                layer.effect: RibbonShadow{}
            }
            RibbonText{
                Layout.alignment: Qt.AlignHCenter
                text: "A Lightweight, minimalist and \nelegant Qt component library."
                font{
                    pixelSize: 30
                    bold: true
                    italic: true
                }
            }
            RibbonText{
                Layout.alignment: Qt.AlignHCenter
                text: "Author: mentalfl0w"
                font{
                    pixelSize: 25
                    bold: true
                    italic: true
                }
            }
            RibbonText{
                Layout.alignment: Qt.AlignHCenter
                text: "Email: mentalflow@ourdocs.cn"
                font{
                    pixelSize: 25
                    bold: true
                    italic: true
                }
            }
            RibbonText{
                Layout.alignment: Qt.AlignHCenter
                text: `Current Version: V${RibbonUI.version}`
                font{
                    pixelSize: 20
                    bold: true
                    italic: true
                }
            }
        }
    }

    RibbonBottomBar{
        id: bottom_bar
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        rightContent: RowLayout{
            clip: true
            spacing:1
            Layout.preferredHeight: parent.height
            layoutDirection: Qt.RightToLeft
            RibbonSlider{
                id: page_slider
                slideWidth: 80
                showFilledColor: false
                value: 70
            }
            RibbonButton{
                text:"Test Button 3"
                showBg:false
                adaptHeight:true
                iconSource: RibbonIcons.Airplane
            }
            RibbonButton{
                text:"Test Button 4"
                showBg:false
                adaptHeight:true
            }
        }
        RibbonButton{
            text:"Test Button 5"
            showBg:false
            adaptHeight:true
            iconSource: RibbonIcons.AccessTime
            checkable: true
        }
        RibbonButton{
            text:"Test Button 6"
            showBg:false
            adaptHeight:true
        }
        RibbonButton{
            showBg:false
            adaptHeight:true
            iconSource: RibbonIcons.AppStore
            checkable: true
            tipText: "Test Button 7"
        }
    }

    titleBar.rightContent:RowLayout{
        spacing: 1
        layoutDirection: Qt.RightToLeft
        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.Info
            iconSourceFilled: RibbonIcons_Filled.Info
            tipText: qsTr("About")
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColor: titleBar.titleTextColor
            textColorReverse: false
            onClicked: root.showWindow(Qt.resolvedUrl("about.qml"))
        }
        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.Map
            iconSourceFilled: RibbonIcons_Filled.Map
            tipText: qsTr("Tour")
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColor: titleBar.titleTextColor
            textColorReverse: false
            onClicked: tour.open()
        }

    }
    titleBar.leftContent:RowLayout{
        spacing: 1
        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.ChevronDown
            tipText: "Test Button 8"
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColor: titleBar.titleTextColor
            textColorReverse: false
            RibbonMenu{
                id:menu
                width: 200
                Action{
                    text: "Test Long Text Test Long Text Test Long Text"
                    checkable: true
                }
                RibbonMenuSeparator{}
                Action{
                    text: "Test Item 1"
                    enabled: false
                }
                RibbonMenu{
                    width: parent.width
                    title: "Sub Menu"
                    Action { text: qsTr("Test Item 2") }
                    Action { text: qsTr("Test Item 3") }
                }
            }
            onClicked:menu.popup()
        }
        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.Apps
            iconSourceFilled: RibbonIcons_Filled.Apps
            checkable: true
            tipText: "Test Button 9"
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColor: titleBar.titleTextColor
            textColorReverse: false
            enabled: false
        }
    }
    Component{
        id: t_content
        RibbonBackStagePage{
            onPageNameChanged: t_text.text = pageName
            Rectangle{
                anchors.fill: parent
                color: "transparent"
                RibbonText{
                    id: t_text
                    anchors.centerIn: parent
                    font.pixelSize: 20
                }
            }
        }
    }

    RibbonBackStageView{
        id: backstagepopup
        implicitHeight: root.height - root.borderWidth * 2
        implicitWidth: root.width - root.borderWidth * 2
        blurEnabled: true
        blurTarget: root.windowItems
        radius: borderRadius
        pageModel: [{"menu_text":"Home", "menu_icon":RibbonIcons.Home, "type":RibbonBackStageView.MenuItemLocation.Head, "sourceComponent":t_content, "sourceArgs":{'pageName':"Home"}},
            {"menu_text":"File", "menu_icon":RibbonIcons.Document, "type":RibbonBackStageView.MenuItemLocation.Head, "sourceComponent":t_content, "sourceArgs":{'pageName':"File"}},
            {"menu_text":"Search", "menu_icon":RibbonIcons.Search, "type":RibbonBackStageView.MenuItemLocation.Body, "sourceComponent":t_content, "sourceArgs":{'pageName':"Search"}},
            {"menu_text":"Account", "menu_icon":RibbonIcons.PersonAccounts, "type":RibbonBackStageView.MenuItemLocation.Tail, "clickOnly":true, "clickFunc": ()=>console.log("Menu Account clicked")},
            {"menu_text":"About", "menu_icon":RibbonIcons.Info, "type":RibbonBackStageView.MenuItemLocation.Tail, "clickOnly":true, "clickFunc": ()=>root.showWindow(Qt.resolvedUrl("about.qml"))},
            {"menu_text":"Settings", "menu_icon":RibbonIcons.Settings, "type":RibbonBackStageView.MenuItemLocation.Tail, "sourceUrl":Qt.resolvedUrl("pages/SettingsMenuPage.qml")}]
    }
}
