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
    show_close_btn: false
    radius: 5
    signal neutralClicked
    signal negativeClicked
    signal positiveClicked
    property int buttonFlags: RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton
    focus: true
    implicitWidth: 250
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
            topPadding: 15
            leftPadding: 15
            rightPadding: 15
            wrapMode: Text.WrapAnywhere
            horizontalAlignment: Text.AlignHCenter
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
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text:message
            view_only: true
            topPadding: 15
            leftPadding: 15
            rightPadding: 15
            bottomPadding: 15
            anchors{
                top:text_title.bottom
                left: parent.left
                right: parent.right
            }
        }
        RowLayout{
            id:layout_actions
            anchors{
                topMargin: 15
                left: parent.left
                leftMargin: 15
                right: parent.right
                rightMargin: 15
                bottom: parent.bottom
                bottomMargin: 15
            }
            height: 30
            spacing: 15
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
