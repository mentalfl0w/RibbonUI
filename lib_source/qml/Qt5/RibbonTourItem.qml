import QtQuick 2.15
import RibbonUI 1.0

RibbonObject {
    id: control
    required property string title
    property string text
    property var target
    property var enterFunc
    property var exitFunc
    property_names: ['title','text','target','enterFunc','exitFunc']
}
