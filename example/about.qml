import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonWindow {
    id: window
    width: Math.max(content.width, content.height + title_bar.height) + content.anchors.margins * 2
    height: width
    title: qsTr("About")
    title_bar.show_darkmode_btn: false
    title_bar.show_style_switch: false

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
