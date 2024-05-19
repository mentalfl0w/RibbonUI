import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import RibbonUI

Item {
    id:control
    implicitHeight: layout.implicitHeight
    implicitWidth: 300
    property real contentMargins: 20

    ColumnLayout{
        id:layout
        anchors.centerIn: parent
        width: parent.width
        RibbonText{
            Layout.preferredWidth: parent.width - leftPadding - rightPadding
            font.pixelSize: 22
            text: popup.targetList[popup.currentIndex].title
            viewOnly: true
            topPadding: contentMargins * 3 / 4
            leftPadding: contentMargins
            rightPadding: contentMargins
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            color: RibbonTheme.modernStyle ?
                       isDarkMode ? '#8AAAEB' : '#2C59B7' :
                       isDarkMode ? "white" : "black"
            verticalAlignment: Text.AlignVCenter
        }
        RibbonText{
            Layout.preferredWidth: parent.width - leftPadding - rightPadding
            font.pixelSize: 13
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            verticalAlignment: Text.AlignVCenter
            text: popup.targetList[popup.currentIndex].text
            viewOnly: true
            topPadding: contentMargins * 3 / 4
            leftPadding: contentMargins
            rightPadding: contentMargins
            bottomPadding: contentMargins * 3 / 4
        }
    }
}
