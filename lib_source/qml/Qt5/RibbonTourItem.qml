import QtQuick 2.15
import RibbonUI 1.1

RibbonObject {
    id: control
    required property string title
    property int id
    property string text
    property var target
    property var enterFunc
    property var exitFunc
    property_names: ['title','text','target','enterFunc','exitFunc']

    signal propertiesUpdated()

    onTitleChanged: propertiesUpdated()
    onTextChanged: propertiesUpdated()
    onTargetChanged: propertiesUpdated()
    onEnterFuncChanged: propertiesUpdated()
    onExitFuncChanged: propertiesUpdated()
}
