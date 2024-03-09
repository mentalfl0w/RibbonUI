import QtQuick
import QtQuick.Controls
import RibbonUI

Text {
    property int icon_source
    property int icon_size: 20
    property bool filled: false
    property int icon_source_filled

    onIcon_sourceChanged: {
        if (typeof(icon_source_filled) === 'undefined' || icon_source_filled === icon_source)
            icon_source_filled = icon_source - 1
    }

    color: "black"
    id:text_icon
    font.family: loader.name
    font.pixelSize: icon_size
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    text: (String.fromCharCode(filled ? icon_source_filled : icon_source).toString(16))

    FontLoader{
        id: loader
        source: "qrc:/qt/qml/RibbonUI/resources/FluentSystemIcons-Resizable.ttf"
    }

}
