import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import RibbonUI

Item {
    id:control
    implicitHeight: layout.implicitHeight
    implicitWidth: 300
    property real content_margins: 20

    ColumnLayout{
        id:layout
        anchors.centerIn: parent
        width: parent.width
        RibbonText{
            Layout.preferredWidth: parent.width - leftPadding - rightPadding
            font.pixelSize: 22
            text: popup.targetList[popup.currentIndex].title
            view_only: true
            topPadding: content_margins * 3 / 4
            leftPadding: content_margins
            rightPadding: content_margins
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            color: RibbonTheme.modern_style ?
                       dark_mode ? '#8AAAEB' : '#2C59B7' :
                       dark_mode ? "white" : "black"
            verticalAlignment: Text.AlignVCenter
        }
        RibbonText{
            Layout.preferredWidth: parent.width - leftPadding - rightPadding
            font.pixelSize: 13
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            verticalAlignment: Text.AlignVCenter
            text: popup.targetList[popup.currentIndex].text
            view_only: true
            topPadding: content_margins * 3 / 4
            leftPadding: content_margins
            rightPadding: content_margins
            bottomPadding: content_margins * 3 / 4
        }
    }
}
