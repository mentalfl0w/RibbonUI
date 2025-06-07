import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
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
            text: qsTr("Table View Example")
            font.pixelSize: 20
        }
        RibbonTableView{
            id: view
            Layout.preferredHeight: 400
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter
            columnsWidth: [150, 150, 100]
            columnsData: ["name", "price","action"]
            rowsData: [
                {
                    price: 5.1,
                    name: "Test 0",
                    action: button,
                },
                {
                    price: 1.9,
                    name: "Test 11111231233131231231dsadasdasdadasdsdadsaa",
                    action: button,
                },
                {
                    price: 7.2,
                    name: "Test 2222",
                    action: button,
                },
                {
                    price: 5.3,
                    name: "Test 323",
                    action: button,
                }
            ]
        }
        RowLayout{
            Layout.alignment: Qt.AlignHCenter
            RibbonButton{
                iconSource: RibbonIcons.AddCircle
                text: qsTr('Add Table Item')
                onClicked: {
                    view.appendRow({
                                       price: String(Math.random()*10),
                                       name: String(Math.random()*10.5),
                                       action: button,
                                   })
                }
            }
            RibbonButton{
                iconSource: RibbonIcons.DismissCircle
                text: qsTr('Clear Table')
                onClicked: {
                    view.clear()
                }
            }
        }
        Component{
            id: button
            RibbonButton{
                property var model
                property var view
                text: `Button ${model ? view.showHeader ? model.row - 1 : model.row : ""}`
                onClicked: messageBar.showMessage(RibbonMessageBar.Info, `${text} clicked!`)
            }
        }
    }
}
