import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

TabButton {
    id: control
    signal need_fold(bool needed, int index)
    property bool folded: false
    property int index
    property bool isDarkMode: RibbonTheme.isDarkMode
    property string underlineUncheckedColor: isDarkMode ? "#666666" : RibbonTheme.modernStyle ? "#A2A2A2" : "#D1D1D1"
    property string underlineCheckedColor: isDarkMode ? "#8AAAEB" : "#2E4C93"
    property string fontColor: highlight ? isDarkMode ? "white" : "#355795" : isDarkMode ? "white" : "black"
    property bool highlight: false

    background: Item{}
    contentItem: Item{
        implicitHeight:btn_text.contentHeight + 8
        implicitWidth: btn_text.contentWidth

        Text {
            id :btn_text
            text: qsTranslate("RibbonTabBar",control.text)
            font{
                family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                pixelSize: 13
                bold: checked
            }
            renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
            color: fontColor
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
            height: 2
            width: control.hovered && control.checked && !folded ? btn_text.contentWidth + 15 : btn_text.contentWidth
            color: {

                if (control.hovered && (!control.checked || folded))
                    return underlineUncheckedColor
                if (control.checked && !folded)
                    return underlineCheckedColor
                return "transparent"
            }
            radius: height / 2
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
