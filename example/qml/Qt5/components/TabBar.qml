import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import RibbonUI 1.1

RibbonTabBar {
    id: tab_bar
    property alias tab_bar_tool: tab_bar_tool
    property alias slider_layout: slider_layout
    property alias slider_with_btn: slider_with_btn
    property alias slider_without_btn: slider_without_btn
    property alias switch_layout: switch_layout
    property alias btn_with_color_and_grabberText: btn_with_color_and_grabberText
    property alias checkbox_layout: checkbox_layout
    property alias button_layout: button_layout
    property alias btn_without_bg_and_label: btn_without_bg_and_label
    property alias pushbutton_layout: pushbutton_layout
    property alias lineedit_layout: lineedit_layout
    property alias lineedit_with_icon: lineedit_with_icon

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
        RibbonTabGroup{
            width: radiobtn_layout.width + 30
            text: qsTr("Radio Button")
            ColumnLayout{
                id: radiobtn_layout
                anchors.centerIn: parent
                height: parent.height
                RibbonRadioButton{
                    text: "Item A"
                }
                RibbonRadioButton{
                    text: "Item B"
                }
                RibbonRadioButton{
                    text: "Item C"
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
        title: qsTr("Progress")
        RibbonTabGroup{
            width: progressbar_slider.width + 30
            RibbonSlider{
                id: progressbar_slider
                anchors.centerIn: parent
                slideWidth: 40
                horizontal: false
                showButton: false
                value: 40
            }
        }
        RibbonTabGroup{
            width: progressbar_layout.width + 30
            text: qsTr("ProgressBar")
            RowLayout{
                id: progressbar_layout
                anchors.centerIn: parent
                height: parent.height
                spacing: 10
                ColumnLayout{
                    RibbonProgressBar{
                        barWidth: 100
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Top
                    }
                    RibbonProgressBar{
                        barWidth: 100
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Left
                    }
                    RibbonProgressBar{
                        barWidth: 100
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Right
                    }
                    RibbonProgressBar{
                        barWidth: 100
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Bottom
                    }
                }
                ColumnLayout{
                    RibbonProgressBar{
                        barWidth: 100
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Top
                    }
                    RibbonProgressBar{
                        barWidth: 100
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Left
                    }
                    RibbonProgressBar{
                        barWidth: 100
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Right
                    }
                    RibbonProgressBar{
                        barWidth: 100
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Bottom
                    }
                }
                ColumnLayout{
                    RibbonProgressBar{
                        barWidth: 100
                        indeterminate: true
                        showText: false
                    }
                    RibbonProgressBar{
                        barWidth: 100
                        indeterminate: false
                        showText: false
                        value: progressbar_slider.value / 100
                    }
                }
            }
        }
        RibbonTabGroup{
            width: progressring_layout.width + 30
            text: qsTr("ProgressRing")
            RowLayout{
                id: progressring_layout
                anchors.centerIn: parent
                height: parent.height
                spacing: 10
                RowLayout{
                    RibbonProgressRing{
                        barWidth: 30
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Top
                    }
                    RibbonProgressRing{
                        barWidth: 30
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Left
                    }
                    RibbonProgressRing{
                        barWidth: 30
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Right
                    }
                    RibbonProgressRing{
                        barWidth: 30
                        value: progressbar_slider.value / 100
                        textLabelPosition: RibbonProgressBar.LabelPosition.Bottom
                    }
                    RibbonProgressRing{
                        value: progressbar_slider.value / 100
                        centerInTextLabel: true
                    }
                }
                RowLayout{
                    RibbonProgressRing{
                        barWidth: 30
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Top
                    }
                    RibbonProgressRing{
                        barWidth: 30
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Left
                    }
                    RibbonProgressRing{
                        barWidth: 30
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Right
                    }
                    RibbonProgressRing{
                        barWidth: 30
                        indeterminate: true
                        textLabelPosition: RibbonProgressBar.LabelPosition.Bottom
                    }
                    RibbonProgressRing{
                        indeterminate: true
                        centerInTextLabel: true
                    }
                }
                ColumnLayout{
                    RibbonProgressRing{
                        barWidth: 30
                        indeterminate: true
                        showText: false
                    }
                    RibbonProgressRing{
                        barWidth: 30
                        indeterminate: false
                        showText: false
                        value: progressbar_slider.value / 100
                    }
                }
            }
        }
    }
    RibbonTabPage{
        title: qsTr("Indicator")
        RibbonTabGroup{
            text: qsTr("BusyRing")
            width: busyring_layout.width + 30
            RowLayout{
                id: busyring_layout
                anchors.centerIn: parent
                height: parent.height
                RibbonBusyRing{
                    running: true
                }
                RibbonBusyRing{
                    running: true
                    clockwise: false
                }
            }
        }
        RibbonTabGroup{
            text: qsTr("BusyBar")
            width: busybar_layout.width + 30
            ColumnLayout{
                id: busybar_layout
                anchors.centerIn: parent
                height: parent.height
                RibbonBusyBar{
                    running: true
                    barWidth: 100
                }
                RibbonBusyBar{
                    running: true
                    reversed: true
                    barWidth: 100
                }
            }
        }
        RibbonTabGroup{
            text: qsTr("PageIndicator")
            width: pageindicator_layout.width + 30
            ColumnLayout{
                id: pageindicator_layout
                anchors.centerIn: parent
                height: parent.height
                RibbonPageIndicator{
                    count: 100
                    showPagination: true
                    Layout.alignment: Qt.AlignHCenter
                }
                RibbonPageIndicator{
                    count: 10
                    showPagination: false
                    Layout.alignment: Qt.AlignHCenter
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
        RibbonTabGroup{
            width: messagebar_layout.width + 30
            text: qsTr("MessageBar")
            ColumnLayout{
                id: messagebar_layout
                anchors.centerIn: parent
                height: parent.height
                spacing: 10
                RibbonButton{
                    text: qsTr("Generate One Message")
                    iconSource: RibbonIcons.Add
                    onClicked: {
                        messageBar.showMessage(Math.floor(Math.random()*6), "test"+Math.floor(Math.random()*6))
                    }
                }
                RibbonButton{
                    text: qsTr("Clear All Messages")
                    iconSource: RibbonIcons.DismissCircle
                    onClicked: {
                        messageBar.clearMessages()
                    }
                }
            }
        }
    }
}
