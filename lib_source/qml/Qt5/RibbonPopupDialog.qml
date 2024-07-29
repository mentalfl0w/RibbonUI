import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

RibbonPopup {
    id: control
    property string title: "Title"
    property string message: "Message"
    property string neutralText: "Neutral"
    property string negativeText: "Negative"
    property string positiveText: "Positive"
    property bool isDarkMode: RibbonTheme.isDarkMode
    property int contentMargins: 20
    showCloseBtn: false
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
        radius:3
        RibbonText{
            id:text_title
            font.pixelSize: 24
            text:title
            viewOnly: true
            topPadding: contentMargins * 3 / 4
            leftPadding: contentMargins
            rightPadding: contentMargins
            wrapMode: Text.WrapAnywhere
            color: RibbonTheme.modernStyle ?
                       isDarkMode ? '#8AAAEB' : '#2C59B7' :
                       isDarkMode ? "white" : "black"
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
            viewOnly: true
            topPadding: contentMargins * 3 / 4
            leftPadding: contentMargins
            rightPadding: contentMargins
            bottomPadding: contentMargins * 3 / 4
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
            color: control.isDarkMode ? "#666666" : "#D1D1D1"
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
                topMargin: contentMargins * 3 / 4
                left: parent.left
                leftMargin: contentMargins
                right: parent.right
                rightMargin: contentMargins
                bottom: parent.bottom
                bottomMargin: contentMargins * 3 / 4
            }
            height: 30
            spacing: contentMargins
            RibbonButton{
                id:negative_btn
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: control.buttonFlags&RibbonPopupDialogType.NegativeButton
                text: negativeText
                showTooltip: false
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
                showTooltip: false
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
                showTooltip: false
                bgColor: isDarkMode ? "#8AAAEB" : "#2C59B7"
                textColor: "white"
                hoverColor: isDarkMode ? Qt.rgba(255, 255, 255, 0.3) : Qt.rgba(0, 0, 0, 0.3)
                pressedColor: isDarkMode ? Qt.rgba(255, 255, 255, 0.5) : Qt.rgba(0,0,0, 0.5)
                onClicked: {
                    positiveClicked()
                    control.close()
                }
            }
        }
    }
}
