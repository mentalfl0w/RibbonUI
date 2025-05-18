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
    property int propertyCount: 0
    property_names: ['menuText','menuIcon','menuIconFilled','type','sourceComponent','sourceArgs','clickOnly','sourceUrl','clickFunc']
}
