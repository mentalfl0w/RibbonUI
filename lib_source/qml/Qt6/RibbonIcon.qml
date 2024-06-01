import QtQuick
import QtQuick.Controls
import RibbonUI

Text {
    property int iconSource
    property int iconSize: 20
    property bool filled: false
    property int iconSourceFilled

    onIconSourceChanged: {
        if (typeof(iconSourceFilled) === 'undefined' || iconSourceFilled === iconSource)
            iconSourceFilled = iconSource - 1
    }

    color: "black"
    id:text_icon
    font.family: loader.name
    font.pixelSize: iconSize
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
    text: (String.fromCharCode(filled ? iconSourceFilled : iconSource).toString(16))

    FontLoader{
        id: loader
        source: "resources/FluentSystemIcons-Resizable.ttf"
    }

}
