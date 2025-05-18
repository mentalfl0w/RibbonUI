import QtQuick
import RibbonUI

RibbonObject {
    id: control
    required property string title
    property int id
    property string text
    property var target
    property var enterFunc
    property var exitFunc
    property_names: ['title','text','target','enterFunc','exitFunc']
}
