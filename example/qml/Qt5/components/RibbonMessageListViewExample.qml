import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.1

Item {
    id: root
    implicitHeight: layout.height + layout.anchors.margins * 2
    implicitWidth: 500
    ColumnLayout{
        id: layout
        width: parent.width - anchors.margins * 2
        anchors.centerIn: parent
        anchors.margins: 30
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Message List View Example")
            font.pixelSize: 20
        }
        RibbonMessageListView{
            id: view
            autoScrollToBottom: true
            Layout.preferredHeight: 500
            Layout.preferredWidth: parent.width
            delegate: RibbonMessage{
                id: msg
                senderText: `${model.time} ${model.recieved ? qsTr('Recieved') : qsTr('Sent')}`
                RibbonText{
                    font.pixelSize: msg.fontSize
                    color: RibbonTheme.isDarkMode ? "white" : !model.recieved ? "white" : "black"
                    text: model.text ? model.text : ""
                    visible: model.text ? true : false
                    Layout.preferredWidth: implicitWidth < (view.width / 2 - padding) ? implicitWidth : (view.width / 2 - padding)
                    wrapMode: RibbonText.Wrap
                }
            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignHCenter
            RibbonButton{
                iconSource: RibbonIcons.AddCircle
                text: qsTr('Add Message')
                onClicked: {
                    view.messageModel.append({
                                                  time: Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss.zzz"),
                                                  text: String(Math.random()*10),
                                                  recieved: (Math.floor(Math.random()*10))%2===0,
                                              })
                }
            }
            RibbonButton{
                iconSource: RibbonIcons.DismissCircle
                text: qsTr('Clear Message')
                onClicked: {
                    view.messageModel.clear()
                }
            }
        }
    }
}
