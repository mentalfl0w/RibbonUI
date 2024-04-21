import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonWindow {
    id: window
    width: Math.max(content.width, content.height + title_bar.height, title_bar.minimumWidth) + content.anchors.margins * 2
    minimumWidth: title_bar.minimumWidth
    minimumHeight: content.height + title_bar.height + content.anchors.margins * 2
    title: qsTr("About")
    title_bar.show_darkmode_btn: false
    title_bar.show_style_switch: false
    windowStatus: RibbonWindow.Status.SingleInstance

    ColumnLayout{
        id: content
        anchors{
            centerIn: parent
            margins: 10
        }
        spacing: 5
        Image {
            source: "qrc:/qt/qml/RibbonUI/resources/imgs/icon.png"
            fillMode:Image.PreserveAspectFit
            Layout.preferredHeight: 120
            Layout.preferredWidth: height
            Layout.alignment: Qt.AlignHCenter
            layer.enabled: true
            layer.effect: RibbonShadow{}
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: "RibbonUI"
            font.pixelSize: 16
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: `©${new Date().getFullYear()} mentalfl0w`
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: `Version: V${RibbonUI.version}`
        }
    }
}
