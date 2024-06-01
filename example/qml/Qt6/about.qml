import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonWindow {
    id: window
    width: Math.max(content.width, content.height + titleBar.height, titleBar.minimumWidth) + content.anchors.margins * 2
    minimumWidth: titleBar.minimumWidth
    minimumHeight: content.height + titleBar.height + content.anchors.margins * 2
    title: qsTr("About")
    titleBar.showDarkmodeBtn: false
    titleBar.showStyleSwitch: false
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
