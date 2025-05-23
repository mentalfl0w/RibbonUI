import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.1

Item {
    id: control
    property int delegateCount: 0
    property string title
    required default property Component content
    property bool needActive: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
    property var delegateList: []

    readonly property var contentItem: main_loader.item ? main_loader.item.containerItem : undefined

    signal containerItemUpdated()
    clip: true

    onContentChanged: {
        delegateList.push({
                               "content": content,
                               "index": control.delegateCount++
                           })
    }

    Loader{
        id: main_loader
        active: control.needActive
        anchors.fill: parent
        asynchronous: true
        sourceComponent: Flickable{
            id: view
            property alias containerItem: container
            ScrollIndicator.horizontal: RibbonScrollIndicator{
                anchors.bottom: view.bottom
                anchors.horizontalCenter: view.horizontalCenter
                width: view.width - 10
            }
            contentWidth: container.width
            RowLayout{
                id: container
                spacing: 0
                height: parent.height
                Repeater{
                    model: control.delegateList
                    Loader{
                        required property var modelData
                        width: item ? item.width : 0
                        Layout.fillHeight: true
                        active: control.needActive
                        sourceComponent: control.delegateList[modelData.index].content
                    }
                }
            }
        }
        onLoaded: containerItemUpdated()
    }

    function getItem( index ){
        return contentItem.children[index].item
    }

}
