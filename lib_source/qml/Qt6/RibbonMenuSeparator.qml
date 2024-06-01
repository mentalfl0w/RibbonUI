import QtQuick
import QtQuick.Controls
import RibbonUI

MenuSeparator {
    id: control
    property bool isDarkMode: RibbonTheme.isDarkMode
    property string color: isDarkMode ? "#4A4B4C" : "#D1D2D2"
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    leftPadding: 10
    rightPadding: leftPadding
    verticalPadding: 0

    contentItem: Rectangle {
        implicitWidth: 230
        implicitHeight: 1
        color: control.color
    }
}
