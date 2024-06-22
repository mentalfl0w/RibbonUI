import QtQuick 2.15
import QtQuick.Controls 2.15
import RibbonUI 1.0

RadioButton {
    id: control

    property color labelColor: RibbonTheme.isDarkMode ? "white" : "black"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 0
    spacing: 6

    indicator: Rectangle {
        implicitWidth: 16
        implicitHeight: implicitWidth

        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        radius: width / 2
        color: {
            if(control.checked)
                return RibbonTheme.modernStyle ? RibbonTheme.isDarkMode ? "#658EE5" : "#2C59B7" : RibbonTheme.isDarkMode ? "#2E4BB3" : "#2E4FB1"
            return RibbonTheme.isDarkMode ? "black" : "white"
        }

        border.width: (control.visualFocus ? 0.7 : 0.5) + (RibbonTheme.modernStyle ? 0.5 : 0)
        border.color: RibbonTheme.modernStyle ? RibbonTheme.isDarkMode ? "#646463" : "#C8C7C7" : RibbonTheme.isDarkMode ? "#757575" : "#8A8A8A"

        Rectangle {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: parent.implicitWidth - RibbonTheme.modernStyle ? 7 : 8
            height: width
            radius: width / 2
            color: RibbonTheme.isDarkMode ? "black" : "white"
            visible: control.checked
        }

        Rectangle{
            anchors.fill: parent
            radius: width/2
            color: {
                if(control.down)
                    return RibbonTheme.isDarkMode ? Qt.rgba(255,255,255,0.2) : Qt.rgba(0,0,0,0.2)
                if(control.hovered)
                    return RibbonTheme.isDarkMode ? Qt.rgba(255,255,255,0.1) : Qt.rgba(0,0,0,0.1)
                return 'transparent'
            }
        }
    }

    contentItem: RibbonText {
        viewOnly: true
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        font: control.font
        color: control.labelColor
    }
}
