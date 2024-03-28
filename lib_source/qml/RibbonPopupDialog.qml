import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import RibbonUI

RibbonPopup {
    id: control
    property string title: "Title"
    property string message: "Message"
    property string neutralText: "Neutral"
    property string negativeText: "Negative"
    property string positiveText: "Positive"
    property bool dark_mode: RibbonTheme.dark_mode
    property int content_margins: 20
    show_close_btn: false
    radius: 5
    signal neutralClicked
    signal negativeClicked
    signal positiveClicked
    property int buttonFlags: RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton
    focus: true
    implicitWidth: 300
    implicitHeight: text_title.height + text_message.height + layout_actions.height + layout_actions.anchors.topMargin + layout_actions.anchors.bottomMargin
    Rectangle {
        id:layout_content
        anchors.fill: parent
        color: 'transparent'
        radius:5
        RibbonText{
            id:text_title
            font.pixelSize: 24
            text:title
            view_only: true
            topPadding: content_margins * 3 / 4
            leftPadding: content_margins
            rightPadding: content_margins
            wrapMode: Text.WrapAnywhere
            color: RibbonTheme.modern_style ?
                       dark_mode ? '#8AAAEB' : '#2C59B7' :
                       dark_mode ? "white" : "black"
            verticalAlignment: Text.AlignVCenter
            anchors{
                top:parent.top
                left: parent.left
                right: parent.right
            }
        }
        RibbonText{
            id:text_message
            font.pixelSize: 13
            wrapMode: Text.WrapAnywhere
            verticalAlignment: Text.AlignVCenter
            text:message
            view_only: true
            topPadding: content_margins * 3 / 4
            leftPadding: content_margins
            rightPadding: content_margins
            bottomPadding: content_margins * 3 / 4
            anchors{
                top:text_title.bottom
                left: parent.left
                right: parent.right
            }
        }
        Rectangle{
            anchors{
                top: text_message.bottom
                topMargin: text_message.anchors.bottomMargin
                horizontalCenter: parent.horizontalCenter
            }
            height: 1
            width: parent.width - 4
            color: control.dark_mode ? "#666666" : "#D1D1D1"
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
        RowLayout{
            id:layout_actions
            anchors{
                topMargin: content_margins * 3 / 4
                left: parent.left
                leftMargin: content_margins
                right: parent.right
                rightMargin: content_margins
                bottom: parent.bottom
                bottomMargin: content_margins * 3 / 4
            }
            height: 30
            spacing: content_margins
            RibbonButton{
                id:negative_btn
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: control.buttonFlags&RibbonPopupDialogType.NegativeButton
                text: negativeText
                show_tooltip: false
                onClicked: {
                    negativeClicked()
                    control.close()
                }
            }
            RibbonButton{
                id:neutral_btn
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: control.buttonFlags&RibbonPopupDialogType.NeutralButton
                text: neutralText
                show_tooltip: false
                onClicked: {
                    neutralClicked()
                    control.close()
                }
            }
            RibbonButton{
                id:positive_btn
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: control.buttonFlags&RibbonPopupDialogType.PositiveButton
                text: positiveText
                show_tooltip: false
                bg_color: dark_mode ? "#8AAAEB" : "#2C59B7"
                text_color: "white"
                hover_color: dark_mode ? Qt.rgba(255, 255, 255, 0.3) : Qt.rgba(0, 0, 0, 0.3)
                pressed_color: dark_mode ? Qt.rgba(255, 255, 255, 0.5) : Qt.rgba(0,0,0, 0.5)
                onClicked: {
                    positiveClicked()
                    control.close()
                }
            }
        }
    }
}
