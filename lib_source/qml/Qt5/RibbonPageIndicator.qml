import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

PageIndicator {
    id: control

    property real paginationHeight: 12
    property real paginationWidth: 12
    property int headCount: 4
    property int tailCount: 4
    property int previewWindow: 2
    property bool showPagination: true
    property bool startWithZero: false
    property bool modernStyle: RibbonTheme.modernStyle

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    delegate: Rectangle {
        id: item
        implicitWidth: showPagination ? Math.max(pagination_text.contentWidth + padding * 2, paginationWidth,
                                                 pagination_text.contentHeight + padding * 3 / 4, paginationHeight) : paginationWidth
        implicitHeight: showPagination ? previous_btn.height : paginationHeight

        radius: showPagination ? modernStyle ? Math.min(width, height) * 0.22 : Math.min(width, height) * 0.15 : Math.min(width, height) / 2
        color: {
            if(!mouse.containsMouse)
                return RibbonTheme.isDarkMode ? "#2F2F2F" : "white"
            let alpha = (mouse.containsPress ? 0.55 : mouse.containsMouse ? 0.75 : (modelData ? modelData : index) === control.currentIndex ? 0.95 : 0.45) - (showPagination ? 0.65 : 0)
            return RibbonTheme.isDarkMode ? Qt.rgba(255,255,255,alpha) : Qt.rgba(0,0,0,alpha)
        }
        border.width: (modelData ? modelData : index) === control.currentIndex ? 2 : 1
        border.color: RibbonTheme.isDarkMode ? "#5C5D5D" : "#B5B4B5"

        scale: {
            if(showPagination)
                return 1
            let minimumScale = 0.5
            let ave = 0
            if(mouse.containsMouse)
                return 1.1
            else if((modelData ? modelData : index) === control.currentIndex)
                return 1
            else{
                if(index < control.currentIndex){
                    ave = (1 - minimumScale) / control.currentIndex
                }
                else if(index > control.currentIndex){
                    ave = (1 - minimumScale) / (control.count - control.currentIndex - 1)
                }
                return 1 - ave * Math.abs(index - control.currentIndex)
            }
        }

        required property int index
        required property int modelData

        RibbonText{
            id: pagination_text
            viewOnly: true
            visible: showPagination
            anchors.centerIn: parent
            text: startWithZero ? modelData ? modelData : index : (modelData ? modelData : index) + 1
            font.bold: (modelData ? modelData : index) === control.currentIndex
        }

        Behavior on opacity { OpacityAnimator { duration: 100 } }

        MouseArea{
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: control.currentIndex = modelData ? modelData : index
        }
    }

    contentItem: RowLayout {
        id: row
        spacing: control.spacing
        property int head: headCount
        property int middle: Math.max(head,tail)
        property int tail: tailCount

        RibbonButton{
            id: previous_btn
            text: qsTr("Previous")
            iconSource: RibbonIcons.Previous
            onClicked: control.currentIndex--
            enabled: control.currentIndex !== 0
            visible: showPagination
        }

        Repeater {
            id: head_repeater
            model: showPagination ? ((control.currentIndex + 1 > row.head - control.previewWindow) && (control.count > row.head + row.tail) ? control.previewWindow : control.count > row.head ? row.head : control.count ) : control.count
            delegate: control.delegate
        }

        RibbonText{
            viewOnly: true
            visible: showPagination && control.currentIndex > row.head - control.previewWindow && (control.count > row.head + row.tail)
            text: "...."
            font.bold: true
        }

        Repeater {
            id: mid_repeater
            property int begin: (control.currentIndex - Math.floor((row.middle - control.previewWindow)/2)) + row.middle > control.count - 1 ? end - row.middle + 1: (control.currentIndex - Math.floor((row.middle - control.previewWindow)/2)) < row.head ? control.currentIndex : (control.currentIndex - Math.floor((row.middle - control.previewWindow)/2))
            property int end: control.count - 1 - control.currentIndex < row.middle ? control.count - 1 : control.currentIndex + row.middle - Math.ceil((row.middle - control.previewWindow)/2)
            model: {
                let list = []
                if(showPagination && (control.currentIndex + 1 > row.head - control.previewWindow) && (control.count > (control.previewWindow * 2 + row.middle)) && row.head + row.tail < control.count){
                    for(let i = begin; i <= end; i++){
                        list.push(i)
                    }
                }
                return list
            }
            delegate: control.delegate
        }

        RibbonText{
            viewOnly: true
            visible: showPagination && (control.currentIndex + 1 < control.count - 1 - row.tail) && (control.count > (control.previewWindow * 2 + row.middle)) && head_repeater.model + tail_repeater.model.length < control.count
            text: "...."
            font.bold: true
        }

        Repeater {
            id: tail_repeater
            model: {
                let list = [], begin = mid_repeater.model.length ? control.count - 1 - mid_repeater.end < control.previewWindow ? mid_repeater.end + 1 : control.count - control.previewWindow : control.count < row.head + row.tail ? row.head : control.count - row.tail
                if(showPagination && ((control.count >= row.head + row.tail) && (control.currentIndex < control.count - row.tail) || !mid_repeater.model.length)){
                    for(let i = begin; i < control.count; i++){
                        list.push(i)
                    }
                }
                return list
            }
            delegate: control.delegate
        }

        RibbonButton{
            id: next_btn
            text: qsTr("Next")
            iconSource: RibbonIcons.Next
            onClicked: control.currentIndex++
            enabled: control.currentIndex !== control.count - 1
            visible: showPagination
        }
    }
}
