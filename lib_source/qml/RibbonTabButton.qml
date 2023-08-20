import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

TabButton {
    id: control
    signal need_fold(bool needed, int index)
    property bool folded: false
    property int index
    property bool dark_mode: RibbonTheme.dark_mode
    property string underline_unchecked_color: dark_mode ? "#666666" : RibbonTheme.modern_style ? "#A2A2A2" : "#D1D1D1"
    property string underline_checked_color: dark_mode ? "#8AAAEB" : "#2E4C93"
    property string font_color: dark_mode ? "white" : "black"

    background: Item{}
    contentItem: Item{
        implicitHeight:btn_text.contentHeight + 8
        implicitWidth: btn_text.contentWidth

        Text {
            id :btn_text
            text: control.text
            font{
                family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                pixelSize: 13
                bold: true
            }
            color: font_color
            height: contentHeight
            anchors{
                centerIn: parent
            }
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }

        Rectangle{
            id: btn_underline
            height: 3
            width: control.hovered && control.checked && !folded ? btn_text.contentWidth + 15 : btn_text.contentWidth
            color: {

                if (control.hovered && (!control.checked || folded))
                    return underline_unchecked_color
                if (control.checked && !folded)
                    return underline_checked_color
                return "transparent"
            }
            radius: 3
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 1
            }
            Behavior on width {
                NumberAnimation{
                    duration: 150
                    easing.type: Easing.OutSine
                }
            }
        }
    }
    width: implicitWidth + 15
    height: implicitHeight + 6
    Timer{
        id: timer
        property bool first_run: true
        interval: 200
        triggeredOnStart: false
        onTriggered: need_fold(checked&&!folded, index)
    }

    onClicked: {
        timer.running = false
        need_fold(checked&&!folded, index)
    }

    onCheckedChanged: {
        if (checked&&!(timer.first_run&&index===0))
        {
            timer.start()
        }
        else
            timer.first_run = false
    }

    function setFolded(value)
    {
        folded = value
    }
}
