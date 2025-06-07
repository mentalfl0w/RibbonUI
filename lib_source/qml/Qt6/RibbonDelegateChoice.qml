import QtQuick
import Qt.labs.qmlmodels
import RibbonUI

DelegateChoice {
    id: control
    property real itemWidth
    property real itemHeight
    delegate: Rectangle{
        id: delegate_item
        implicitWidth: control.itemWidth
        implicitHeight: control.itemHeight
        required property var model
        property var view: TableView.view
        property var viewModel: view ? TableView.view.model : undefined
        property bool hasHeader: TableView.view ? TableView.view.showHeader : false
        property bool isHeader: hasHeader && row === 0
        property bool isRowIndex: column === 0 && view ? TableView.view.showRowIndex : false
        property bool showToolTip: view ? view.showCellToolTip : false
        property bool needToolTip: !needConvert && loader.item ? loader.item.needToolTip : false
        property bool needConvert: typeof model.display === "string" ? model.display.startsWith("RibbonTableView: Need convert to $") : false
        property string convertTargetKey: needConvert ? model.display.substring(model.display.indexOf('$') + 1) : ""
        property bool isCurrentCell: delegate_item.view.modelCurrentColumn === column && delegate_item.view.modelCurrentRow === row
        property var currentRowData: delegate_item.view.rowsData[delegate_item.hasHeader && !delegate_item.isHeader ? row - 1 : row] ? delegate_item.view.rowsData[delegate_item.hasHeader && !delegate_item.isHeader ? row - 1 : row] : undefined

        border.color: isCurrentCell && !isHeader ? "#3A714A" : RibbonTheme.isDarkMode ? "#565656" : "#D4D4D4"
        border.width: isCurrentCell && !isHeader ? 2 : !isRowIndex && !isHeader ? 0.5 : 0

        Rectangle{
            visible: viewModel ? viewModel.columnsCount !== column && delegate_item.isHeader : false
            height: parent.height
            width: 1
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
            }
            gradient: Gradient {
                GradientStop { position: column === row && row === 0 ? 1.0 : 0.0; color: RibbonTheme.isDarkMode ? "#363636" : "#F9F9F9" }
                GradientStop { position: 1.0; color: RibbonTheme.isDarkMode ? "#565656" : "#DDDCDA" }
            }
        }
        Rectangle{
            visible: viewModel ? viewModel.columnsCount !== column && delegate_item.isHeader : false
            height: 1
            width: parent.width
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            color: RibbonTheme.isDarkMode ? "#565656" : "#BCBBBA"
        }
        Rectangle{
            visible: delegate_item.isRowIndex
            height: parent.height
            width: 1
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            color: RibbonTheme.isDarkMode ? "#565656" : "#BCBBBA"
        }
        Rectangle{
            visible: delegate_item.isRowIndex
            width: parent.width
            height: 1
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
            }
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: column === row && row === 0 ? 1.0 : 0.0; color: RibbonTheme.isDarkMode ? "#363636" : "#F9F9F9" }
                GradientStop { position: 1.0; color: RibbonTheme.isDarkMode ? "#565656" : "#DDDCDA" }
            }
        }
        clip: true
        color: {
            if(isHeader || isRowIndex){
                if(isCurrentCell)
                    return RibbonTheme.isDarkMode ? "#565656" : "#F3F3F3"
                else
                    return RibbonTheme.isDarkMode ? "#161616" : "#FBFBFB"
            }
            else{
                if(isCurrentCell)
                    return RibbonTheme.isDarkMode ? "#262626" : "#FCFCFC"
                else
                    return RibbonTheme.isDarkMode ? "black" : "white"
            }
        }
        Loader{
            id: loader
            anchors.centerIn: parent
            anchors.margins: 5
            width: parent.width - 2 * anchors.margins
            height: parent.height - 2 * anchors.margins
            clip: true
            sourceComponent: delegate_item.needConvert ? delegate_item.currentRowData ? delegate_item.currentRowData[delegate_item.convertTargetKey]  : undefined : text_item
            onLoaded: {
                item["model"] = model
                item["view"] = delegate_item.view
            }
        }
        RibbonToolTip{
            text: delegate_item.needConvert ? "" : model.display
            visible: hover.hovered && !delegate_item.needConvert &&
                     !delegate_item.isHeader && delegate_item.showToolTip &&
                        delegate_item.needToolTip
        }
        HoverHandler{
            id: hover
        }
        TapHandler{
            id: tap
            onSingleTapped: {
                if(delegate_item.view.modelCurrentColumn === column && delegate_item.view.modelCurrentRow === row){
                    delegate_item.view.modelCurrentColumn = -1
                    delegate_item.view.modelCurrentRow = -1
                }
                else{
                    delegate_item.view.modelCurrentColumn = column
                    delegate_item.view.modelCurrentRow = row
                }
            }
            onDoubleTapped: {
                if(!delegate_item.needConvert){
                    loader.item.readOnly = false
                    delegate_item.view.editingBegin()
                }
                else{
                    delegate_item.view.editingNeedBegin(row, column, delegate_item.convertTargetKey)
                }
            }
        }
        Component{
            id: text_item
            Flickable {
                id: flick
                property var model
                property var view
                property alias readOnly: edit.readOnly
                property bool needToolTip: edit.width < edit.implicitWidth

                contentWidth: edit.contentWidth
                contentHeight: edit.contentHeight
                clip: true

                function ensureVisible(r)
                {
                    if (contentX >= r.x)
                        contentX = r.x;
                    else if (contentX+width <= r.x+r.width)
                        contentX = r.x+r.width-width;
                    if (contentY >= r.y)
                        contentY = r.y;
                    else if (contentY+height <= r.y+r.height)
                        contentY = r.y+r.height-height;
                }
                RibbonText{
                    id: edit
                    text: model ? model.display : ""
                    width: flick.width
                    font.pixelSize: 13
                    horizontalAlignment: RibbonText.AlignHCenter
                    verticalAlignment: RibbonText.AlignVCenter
                    Component.onCompleted: {
                        if(model){
                            if (!Object.keys(model.args).length)
                                return
                            else if(Object.keys(model.args).length){
                                for (let arg in model.args){
                                    loader.item[arg] = model.args[arg]
                                }
                            }
                        }
                    }
                    onEditingFinished: {
                        model.display = text
                        readOnly = true
                        view.editingFinished()
                    }
                    onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                }
            }
        }
    }
}
