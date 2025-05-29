import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import RibbonUI 1.1
import RibbonUIAPP 1.1

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
            mipmap: true
            autoTransform: true
            Layout.preferredHeight: 120
            Layout.preferredWidth: height
            Layout.alignment: Qt.AlignHCenter
            layer.enabled: true
            layer.effect: RibbonShadow{}
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("RibbonUI")
            font.pixelSize: 16
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("© 2023 - %1 mentalfl0w").arg(`${new Date().getFullYear()}`)
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: qsTr('Version: V%1').arg(`${RibbonUI.version}`)
        }
    }

    Component.onCompleted: {
        RibbonUI.autoLoadLanguage = true
        RibbonUI.setTranslator(Localization)
    }
}
