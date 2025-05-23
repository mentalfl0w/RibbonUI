import QtQuick
import RibbonUI

RibbonObject {
    id: control
    required property string menuText
    property int id
    property var menuIcon
    property var menuIconFilled
    required property var type
    property var sourceComponent
    property var sourceArgs
    property bool clickOnly: false
    property var sourceUrl
    property var clickFunc
    property_names: ['menuText','menuIcon','menuIconFilled','type','sourceComponent','sourceArgs','clickOnly','sourceUrl','clickFunc']

    signal propertiesUpdated()

    onMenuTextChanged: propertiesUpdated()
    onMenuIconChanged: propertiesUpdated()
    onMenuIconFilledChanged: propertiesUpdated()
    onTypeChanged: propertiesUpdated()
    onSourceComponentChanged: propertiesUpdated()
    onSourceArgsChanged: propertiesUpdated()
    onClickOnlyChanged: propertiesUpdated()
    onSourceUrlChanged: propertiesUpdated()
    onClickFuncChanged: propertiesUpdated()
}
