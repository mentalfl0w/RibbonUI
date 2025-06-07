import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels
import RibbonUI

TableView {
    id: control

    property var modelColumns: model.columns
    property var modelRows: model.rows
    property var columnsData: []
    property var rowsData: []
    property double cellWidth: 100
    property double cellHeight: 30
    property var columnsWidth: []
    property var rowsHeight: []
    property bool showRowIndex: true
    property bool showHeader: true
    property bool showCellToolTip: true
    property double rowIndexWidth: 30
    property double rowIndexHeight: 30
    property int modelCurrentColumn: -1
    property int modelCurrentRow: -1

    boundsBehavior: Flickable.StopAtBounds
    clip: true

    signal editingNeedBegin(row:int, column:int, display:string)
    signal editingBegin()
    signal editNeedFinished(row:int, column:int, display:string)
    signal editingFinished()

    model: TableModel{
        id: table_model
    }

    delegate: DelegateChooser {
        id: chooser
    }

    ScrollBar.horizontal: RibbonScrollBar{}

    ScrollBar.vertical: RibbonScrollBar{}

    onColumnsDataChanged: {
        modelColumns.length = 0
        if(columnsData.length){
            if(showRowIndex){
                let item = column_item.createObject(model, {display: 'rowIndex'})
                modelColumns.push(item)
            }
            for(var i = 0; i < columnsData.length; i++){
                let item = column_item.createObject(model, {display: columnsData[i]})
                modelColumns.push(item)
            }
        }
    }

    onRowsDataChanged: {
        if(rowsData.length){
            delegate.choices.length = 0
            model.clear()
            internal.createDelegateChoice()
            internal.initialData()
            internal.loadRowData()
        }
    }

    Component{
        id: column_item
        TableModelColumn{
        }
    }

    QtObject{
        id: internal
        function initialData(){
            let header_row = {}
            if(showRowIndex)
                header_row['rowIndex'] = "\\"
            if(columnsData.length){
                for(var i = 0; i < columnsData.length; i++){
                    if(showHeader){
                        header_row[columnsData[i]] = columnsData[i]
                    }
                }
            }
            if(showHeader)
                model.setRow(0,header_row)
        }

        function loadRowData(){
            if(rowsData.length){
                for(let i = 0; i < rowsData.length; i++){
                    let row = {}
                    for(let key in rowsData[i]){
                        if(Object.prototype.toString.call(rowsData[i][key]) === '[object Object]'){
                            row[key] = "RibbonTableView: Need convert to $" + key
                        }
                        else
                            row[key] = rowsData[i][key]
                    }
                    if(showRowIndex)
                        row['rowIndex'] = i
                    model.appendRow(row)
                }
            }
        }

        function createDelegateChoice(){
            for(let i = 0; i < columnsData.length + (showRowIndex ? 1 : 0); i++){
                let component = Qt.createComponent("RibbonDelegateChoice.qml", Component.PreferSynchronous, delegate)
                if(component.status === Component.Ready){
                    console.debug("RibbonTableView:", "Component", component, "is now ready.")
                    let itemWidth = !columnsWidth[i] ? cellWidth :columnsWidth[i]
                    let itemHeight = !rowsHeight[i] ? cellHeight :rowsHeight[i]
                    if(showRowIndex){
                        if(i === 0){
                            itemWidth = rowIndexWidth
                            itemHeight = rowIndexHeight
                        }
                        else{
                            itemWidth = !columnsWidth[i - 1] ? cellWidth :columnsWidth[i - 1]
                            itemHeight = !rowsHeight[i - 1] ? cellHeight :rowsHeight[i - 1]
                        }
                    }

                    let item = component.createObject(delegate, {column: i,
                                                          itemWidth: itemWidth,
                                                          itemHeight: itemHeight
                                                      })
                    chooser.choices.push(item)
                }
                else{
                    console.error("RibbonTableView: Error loading Window Component:", component.errorString())
                }
            }
        }
    }

    function clear(){ // You must use this to clear data rather than use model's clear(), otherwise the header will disappear
        model.clear()
        rowsData.length = 0
        modelCurrentColumn = -1
        modelCurrentRow = -1
        internal.initialData()
    }

    function appendRow(row){
        rowsData.push(row)
        let _row = {}
        for(let key in row){
            if(Object.prototype.toString.call(row[key]) === '[object Object]'){
                _row[key] = "RibbonTableView: Need convert to $" + key
            }
            else
                _row[key] = row[key]
        }
        if(showRowIndex)
            _row['rowIndex'] = model.rows.length - 1
        model.appendRow(_row)
    }
}
