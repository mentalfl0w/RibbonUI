import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonWindow {
    id:root
    width: 1200
    height: 800
    title: qsTr("RibbonUI APP")
    comfirmed_quit: true
    property bool modern_style: RibbonTheme.modern_style
    RibbonTabBar {
        id: tab_bar
        modern_style: root.modern_style
        right_tool_bar: RowLayout{
            spacing: 10
            RibbonButton{
                text:"Test Button 1"
                icon_source: RibbonIcons.Alert
                checkable: true
            }
            RibbonButton{
                text:"Test Button 2"
            }
        }

        RibbonTabPage{
            id: basic_page
            title: qsTr("Basic")
            RibbonTabGroup{
                width: slider_layout.width + 20
                text: qsTr("Slider")
                RowLayout{
                    id: slider_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 0
                    RibbonSlider{
                        Layout.alignment: Qt.AlignVCenter
                        slide_width: 40
                        horizontal: false
                        value: 20
                    }
                    RibbonSlider{
                        Layout.alignment: Qt.AlignVCenter
                        slide_width: 40
                        horizontal: false
                        show_button: false
                        value: 40
                    }
                    ColumnLayout{
                        spacing: 0
                        Layout.alignment: Qt.AlignVCenter
                        RibbonSlider{
                            Layout.alignment: Qt.AlignHCenter
                            slide_width: 40
                            value: 60
                        }
                        RibbonSlider{
                            Layout.alignment: Qt.AlignHCenter
                            slide_width: 40
                            show_button: false
                            value: 80
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: switch_layout.width + 30
                text: qsTr("Switch Button")
                RowLayout{
                    id: switch_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 0
                    ColumnLayout{
                        spacing: 5
                        RibbonSwitchButton{
                            text: "Button"
                            grabber_checked_color: "red"
                            checked: true
                        }
                        RibbonSwitchButton{
                            text: "Button"
                            text_on_left: true
                            grabber_checked_color: "orange"
                            checked: true
                        }
                        RibbonSwitchButton{
                            grabber_checked_color: "blue"
                        }
                    }
                    ColumnLayout{
                        spacing: 5
                        RibbonSwitchButton{
                            text: "Button"
                            show_grabber_text: false
                            grabber_checked_color: "green"
                        }
                        RibbonSwitchButton{
                            text: "Button"
                            show_grabber_text: false
                            text_on_left: true
                            grabber_checked_color: "indigo"
                            checked: true
                        }
                        RibbonSwitchButton{
                            show_grabber_text: false
                            grabber_checked_color: "yellow"
                            checked: true
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: checkbox_layout.width + 30
                text: qsTr("CheckBox")
                RowLayout{
                    id: checkbox_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 0
                    ColumnLayout{
                        spacing: 10
                        RibbonCheckBox{
                            text: "CheckBox"
                            icon_filled_bg_color: "blue"
                            checked: true
                        }
                        RibbonCheckBox{
                            text: "CheckBox"
                            text_on_left: true
                            icon_filled_bg_color: "red"
                        }
                        RowLayout{
                            spacing: 30
                            RibbonCheckBox{
                                icon_filled_bg_color:"orange"
                                tip_text: "CheckBox"
                                show_tooltip: true
                                checked: true
                            }
                            RibbonCheckBox{
                                icon_filled_bg_color:"purple"
                            }
                        }
                    }
                }
            }
            RibbonTabGroup{
                width: button_layout.width + 30
                text: qsTr("Button")
                RowLayout{
                    id: button_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 1
                    ColumnLayout{
                        spacing: 10
                        RibbonButton{
                            text:"Button"
                            icon_source: RibbonIcons.Accessibility
                            checkable: true
                        }
                        RibbonButton{
                            text:"Button"
                        }
                        RibbonButton{
                            text:"Button"
                            show_tooltip: false
                        }
                    }
                    ColumnLayout{
                        spacing: 10
                        RibbonButton{
                            text:"Button"
                            show_bg:false
                            icon_source: RibbonIcons.Beaker
                            checkable: true
                        }
                        RibbonButton{
                            text:"Button"
                            show_bg:false
                        }
                        RibbonButton{
                            text:"Button"
                            show_bg:false
                            show_tooltip: false
                        }
                    }
                    ColumnLayout{
                        spacing: 10
                        RibbonButton{
                            show_bg:false
                            icon_source: RibbonIcons.Badge
                            icon_source_filled: RibbonIcons_Filled.Badge
                            checkable: true
                            tip_text: "Button"
                        }
                        RibbonButton{
                            show_bg:false
                            icon_source: RibbonIcons.Clock
                            icon_source_filled: RibbonIcons_Filled.Clock
                            tip_text: "Button"
                        }
                        RibbonButton{
                            show_bg:false
                            icon_source: RibbonIcons.Board
                            icon_source_filled: RibbonIcons_Filled.Board
                            checkable: true
                            tip_text: "Button"
                            show_tooltip: false
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
                        icon_source: RibbonIcons.AttachText
                    }
                    RibbonPushButton{
                        text: qsTr("Menu")
                        icon_source: RibbonIcons.MeetNow
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
                        icon_source: "qrc:/qt/qml/RibbonUIAPP/resources/imgs/heart.png"
                        icon_size: height-5
                    }
                    RibbonPushButton{
                        text: qsTr("Menu")
                        icon_source: "qrc:/qt/qml/RibbonUIAPP/resources/imgs/search.png"
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
                            show_clear_btn:false
                        }
                    }
                    ColumnLayout{
                        spacing: 10
                        Layout.fillHeight: true
                        RibbonLineEdit{
                            icon_source:RibbonIcons.Search
                        }
                        RibbonLineEdit{
                            icon_source:RibbonIcons.Keyboard
                            show_clear_btn:false
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
                            max_height: 50
                        }
                        RibbonTextEdit{
                            max_height: 30
                            show_clear_btn:false
                        }
                    }
                    ColumnLayout{
                        spacing: 30
                        Layout.fillHeight: true
                        RibbonTextEdit{
                            max_height: 50
                            icon_source:RibbonIcons.Search
                        }
                        RibbonTextEdit{
                            max_height: 30
                            icon_source:RibbonIcons.Keyboard
                            show_clear_btn:false
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
                            icon_source: RibbonIcons.Beaker
                        }
                        RibbonComboBox{
                            editable: true
                            model: ListModel {
                                id: model_1
                                ListElement { text: "Test Item 1" }
                                ListElement { text: "Test Item 2" }
                                ListElement { text: "Test Item 3" }
                            }
                            icon_source: RibbonIcons.Calendar
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
                show_border: false
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
                            icon_source: RibbonIcons.DataPie
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
                        icon_source: RibbonIcons.Open
                        onClicked: {
                            Window.window.popup.show_content("qrc:/qt/qml/RibbonUIAPP/components/RibbonMessageListViewExample.qml")
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
                            view_only: true
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
                        icon_source: RibbonIcons.Open
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
                            icon_source: RibbonIcons.Open
                            onClicked: popup.open()
                        }
                        RibbonButton{
                            text: qsTr("Open Popup Dialog (Double Choices)")
                            icon_source: RibbonIcons.Open
                            onClicked: {
                                dialog.buttonFlags = RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton
                                dialog.open()
                            }
                        }
                        RibbonButton{
                            text: qsTr("Open Popup Dialog (Triple Choices)")
                            icon_source: RibbonIcons.Open
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
                        target: window_items
                        blur_enabled: true
                        target_rect: Qt.rect(window_items.x + x, window_items.y + y, width, height)
                    }
                    RibbonPopupDialog{
                        id: dialog
                        target: window_items
                        blur_enabled: true
                        target_rect: Qt.rect(window_items.x + x, window_items.y + y, width, height)
                    }
                }
            }
            RibbonTabGroup{
                width: theme_layout.width + 30
                text: qsTr("Theme")
                RowLayout{
                    id: theme_layout
                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 10
                    RibbonComboBox{
                        id: theme_combo
                        model: ListModel {
                            id: model_theme
                            ListElement { text: "Light" }
                            ListElement { text: "Dark" }
                            ListElement { text: "System" }
                        }
                        icon_source: RibbonIcons.DarkTheme
                        Component.onCompleted: update_state()
                        onActivated: {
                            if (currentText === "System")
                                RibbonTheme.theme_mode = RibbonThemeType.System
                            else if (currentText === "Light")
                                RibbonTheme.theme_mode = RibbonThemeType.Light
                            else
                                RibbonTheme.theme_mode = RibbonThemeType.Dark
                        }
                        Connections{
                            target: RibbonTheme
                            function onTheme_modeChanged(){
                                theme_combo.update_state()
                            }
                        }
                        function update_state(){
                            let str = (RibbonTheme.theme_mode === RibbonThemeType.System ? "System" : RibbonTheme.theme_mode === RibbonThemeType.Light ? "Light" : "Dark")
                            currentIndex = find(str)
                        }
                    }
                }
            }
        }
    }

    RibbonPaperView{
        id: view
        anchors.fill: parent
        top_padding: tab_bar.height
        bottom_padding: bottom_bar.height
        page_width: (page_slider.value / 100.0) * width
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
        right_content: RowLayout{
            clip: true
            spacing:1
            Layout.preferredHeight: parent.height
            layoutDirection: Qt.RightToLeft
            RibbonSlider{
                id: page_slider
                slide_width: 80
                show_filled_color: false
                value: 70
            }
            RibbonButton{
                text:"Test Button 3"
                show_bg:false
                adapt_height:true
                icon_source: RibbonIcons.Airplane
            }
            RibbonButton{
                text:"Test Button 4"
                show_bg:false
                adapt_height:true
            }
        }
        RibbonButton{
            text:"Test Button 5"
            show_bg:false
            adapt_height:true
            icon_source: RibbonIcons.AccessTime
            checkable: true
        }
        RibbonButton{
            text:"Test Button 6"
            show_bg:false
            adapt_height:true
        }
        RibbonButton{
            show_bg:false
            adapt_height:true
            icon_source: RibbonIcons.AppStore
            checkable: true
            tip_text: "Test Button 7"
        }
    }

    title_bar.right_content:RowLayout{
        spacing: 1
        layoutDirection: Qt.RightToLeft
        RibbonButton{
            show_bg:false
            icon_source: RibbonIcons.Info
            icon_source_filled: RibbonIcons_Filled.Info
            tip_text: qsTr("About")
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color: title_bar.title_text_color
            text_color_reverse: false
            onClicked: root.show_window(Qt.resolvedUrl("about.qml"))
        }
        RibbonButton{
            show_bg:false
            icon_source: RibbonIcons.CalendarStar
            icon_source_filled: RibbonIcons_Filled.CalendarStar
            checkable: true
            tip_text: "Test Button 11"
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color: title_bar.title_text_color
            text_color_reverse: false
        }

    }
    title_bar.left_content:RowLayout{
        spacing: 1
        RibbonButton{
            show_bg:false
            icon_source: RibbonIcons.ChevronDown
            tip_text: "Test Button 8"
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color: title_bar.title_text_color
            text_color_reverse: false
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
            show_bg:false
            icon_source: RibbonIcons.Apps
            icon_source_filled: RibbonIcons_Filled.Apps
            checkable: true
            tip_text: "Test Button 9"
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color: title_bar.title_text_color
            text_color_reverse: false
            enabled: false
        }
    }
}
