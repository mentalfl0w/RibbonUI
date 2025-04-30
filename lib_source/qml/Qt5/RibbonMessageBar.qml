import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import RibbonUI 1.1

Rectangle {
    id: control
    implicitWidth: parent ? parent.width : 100
    implicitHeight: contentHeight
    enum Type {
        Info,
        Success,
        SevereWarning,
        Blocked,
        Error,
        Warning
    }
    property real contentHeight: layout.height + layout.anchors.topMargin * 2
    property alias text: barText.text
    property int type: RibbonMessageBar.Info
    property bool rounded: false
    property string warningColor: RibbonTheme.isDarkMode ? "#41361D" : "#FDF4D2"
    property string successColor: RibbonTheme.isDarkMode ? "#3A3D1F" : "#E3F5DF"
    property string severeWarningColor: RibbonTheme.isDarkMode ? "#4A2C15" : "#F8DACE"
    property string blockedColor: RibbonTheme.isDarkMode ? "#402827" : "#F9E8E9"
    property string errorColor: RibbonTheme.isDarkMode ? "#402827" : "#F9E8E9"
    property string infoColor: RibbonTheme.isDarkMode ? "#323130" : "#F3F2F1"
    property string externalURL: ""
    property string externalURLLabel: qsTr("Link")
    property string dismissLabel: qsTr("Close")
    property string overflowLabel: qsTr("See More")
    property string actionALabel: qsTr("ActionA")
    property string actionBLabel: qsTr("ActionB")
    property bool isMultiline: type === RibbonMessageBar.SevereWarning || type === RibbonMessageBar.Warning
    property bool showActionA: false
    property bool showActionB: false
    property bool truncated: !(isMultiline || showActionA || showActionB) && type === RibbonMessageBar.Blocked
    property var actionA: ()=>console.log(qsTr("ActionA Clicked"))
    property var actionB: ()=>console.log(qsTr("ActionB Clicked"))
    property var dismissAction

    radius: rounded ? 3 : 0
    clip: true

    signal dismissClicked()
    signal actionAClicked()
    signal actionBClicked()

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutSine
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 200
            easing.type: Easing.OutSine
        }
    }

    Behavior on opacity{
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutSine
        }
    }

    onOpacityChanged: {
        if(opacity > 0)
            visible = true
        else
            visible = false
    }

    onVisibleChanged: {
        if(visible && opacity === 0)
            opacity = 1
    }

    Rectangle{
        anchors{
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width
        height: 1
        color: Qt.rgba(0,0,0,0.1)
        visible: RibbonTheme.modernStyle
    }

    Rectangle{
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width
        height: 1
        color: Qt.rgba(0,0,0,0.1)
    }

    gradient: Gradient {
        GradientStop { position: 0.0; color: calculateClassicColor(control.color)[0]}
        GradientStop { position: 1.0; color: calculateClassicColor(control.color)[1]}
    }

    Column{
        id: layout
        anchors{
            top: parent.top
            left: parent.left
            leftMargin: 12
            right: parent.right
            rightMargin: anchors.leftMargin
            topMargin: 8
            bottomMargin: anchors.topMargin
        }
        spacing: 5
        RowLayout{
            id: row_1
            RibbonIcon{
                id: icon
                iconSize: height
                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: Math.min(barText.contentHeight, 16)
            }
            Text{
                id: barText
                elide: truncated.checked ? Text.ElideNone : Text.ElideRight
                renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                wrapMode: truncated.checked ? Text.Wrap : Text.NoWrap
                color: RibbonTheme.isDarkMode ? "white" : "black"
                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: {
                    var w = 0
                    if(actiona.visible && !control.isMultiline)
                        w += actiona.width + row_1.spacing
                    if(actionb.visible && !control.isMultiline)
                        w += actionb.width + row_1.spacing
                    if(link.visible)
                        w += link.width + row_1.spacing
                    if(truncated.visible)
                        w += truncated.width + row_1.spacing
                    if(dismiss.visible)
                        w += dismiss.width + row_1.spacing
                    return control.implicitWidth - (w + icon.width + layout.anchors.leftMargin * 2)
                }
            }
            Text{
                id: link
                text: control.externalURLLabel
                font.underline: true
                elide: Text.ElideRight
                renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                color: tm.containsMouse ? RibbonTheme.isDarkMode ? "#91C5FA" : "#1A4474" :
                RibbonTheme.isDarkMode ? "#7EB6F1" : "#255999"
                Layout.alignment: Qt.AlignVCenter
                Layout.maximumWidth: 150
                Layout.preferredHeight: Math.min(barText.contentHeight, 16)
                visible: control.externalURL
                MouseArea{
                    id: tm
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.openUrlExternally(control.externalURL)
                }
            }
            Item{
                parent: control.isMultiline ? row_2 : row_1
                visible: control.isMultiline && (showActionA || showActionB)
                implicitHeight: 1
                implicitWidth: {
                    var w = 0
                    if(actiona.visible && control.isMultiline)
                        w += actiona.width + row_2.spacing
                    if(actionb.visible && control.isMultiline)
                        w += actionb.width + row_2.spacing
                    return layout.width - w
                }
            }
            RibbonButton{
                id: actiona
                parent: control.isMultiline ? row_2 : row_1
                text: control.actionALabel
                Layout.alignment: control.isMultiline ? Qt.AlignVCenter : Qt.AlignTop
                Layout.topMargin: control.isMultiline ? 0 : - layout.anchors.topMargin * 3 / 4
                Layout.bottomMargin: Layout.topMargin
                onClicked: {
                    actionA()
                    actionAClicked()
                }
                visible: control.showActionA
            }
            RibbonButton{
                id: actionb
                parent: control.isMultiline ? row_2 : row_1
                text: control.actionBLabel
                Layout.alignment: control.isMultiline ? Qt.AlignVCenter : Qt.AlignTop
                Layout.topMargin: control.isMultiline ? 0 : - layout.anchors.topMargin * 3 / 4
                Layout.bottomMargin: Layout.topMargin
                onClicked: {
                    actionB()
                    actionBClicked()
                }
                visible: control.showActionB
            }
            RibbonButton{
                id: truncated
                textColor: RibbonTheme.isDarkMode ? "#F1F0EF" : "#3E3D3C"
                showBg: false
                checkable: true
                showHoveredBg: false
                iconSource: RibbonIcons.ChevronDoubleDown
                rotation: checked ? 180 : 0
                tipText: control.overflowLabel
                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: Math.min(barText.contentHeight, 16)
                visible: control.truncated && ((barText.height > link.height) || barText.truncated)
                checked: control.isMultiline
                Behavior on rotation {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutSine
                    }
                }
            }
            RibbonButton{
                id: dismiss
                textColor: RibbonTheme.isDarkMode ? "#F1F0EF" : "#3E3D3C"
                showBg: false
                showHoveredBg: false
                iconSource: RibbonIcons.Dismiss
                Layout.alignment: Qt.AlignTop
                Layout.preferredHeight: Math.min(barText.contentHeight, 16)
                tipText: control.dismissLabel
                onClicked: {
                    dismissAction()
                    dismissClicked()
                    control.opacity = 0
                }
            }
        }
        RowLayout{
            id: row_2
            visible: control.isMultiline
            layoutDirection: Qt.RightToLeft
        }
    }

    onInfoColorChanged: refresh()
    onTypeChanged: refresh()
    Component.onCompleted: refresh()

    function refresh(){
        switch(type){
        case RibbonMessageBar.Info:{
            icon.color = !RibbonTheme.isDarkMode ? "#605E5C" : "#C8C6C4"
            icon.iconSource = RibbonIcons.Info
            control.color = infoColor
            break
        }
        case RibbonMessageBar.Warning:{
            icon.color = !RibbonTheme.isDarkMode ? "#605E5C" : "#C8C6C4"
            icon.iconSource = RibbonIcons.Info
            control.color = warningColor
            break
        }
        case RibbonMessageBar.Success:{
            icon.color = !RibbonTheme.isDarkMode ? "#387A26" : "#9CC262"
            icon.iconSource = RibbonIcons.CheckmarkCircle
            control.color = successColor
            break
        }
        case RibbonMessageBar.SevereWarning:{
            icon.color = !RibbonTheme.isDarkMode ? "#C74821" : "#F8E24B"
            icon.iconSource = RibbonIcons.Warning
            control.color = severeWarningColor
            break
        }
        case RibbonMessageBar.Blocked:{
            icon.color = !RibbonTheme.isDarkMode ? "#9A1E13" : "#E1777E"
            icon.iconSource = RibbonIcons.SubtractCircle
            control.color = blockedColor
            break
        }
        case RibbonMessageBar.Error:{
            icon.color = !RibbonTheme.isDarkMode ? "#9A1E13" : "#E1777E"
            icon.iconSource = RibbonIcons.DismissCircle
            control.color = errorColor
            break
        }
        }
    }

    function calculateClassicColor(modernColor){
        function limit(num){
            if(num < 0)
                return 0
            else if(num > 255)
                return 255
            else
                return num
        }

        if(!RibbonTheme.modernStyle){
            modernColor = String(modernColor)
            const num = parseInt(modernColor.slice(1), 16)
            if(modernColor.length === 7)
                return [Qt.rgba(limit((num >> 16) & 255) / 255,
                                limit(((num >> 8) & 255) + 0x03) / 255,
                                limit((num & 255) + 0x12) / 255,
                                1),
                        Qt.rgba(limit(((num >> 16) & 255) - 0x05) / 255,
                                limit(((num >> 8) & 255) - 0x01) / 255,
                                limit((num & 255) + 0x0C) / 255,
                                1)]
            else
                return [Qt.rgba(limit((num >> 24) & 255) / 255,
                                limit(((num >> 16) & 255) + 0x03) / 255,
                                limit(((num >> 8) & 255) + 0x12) / 255,
                                limit(num & 255) / 255),
                        Qt.rgba(limit(((num >> 24) & 255) - 0x05) / 255,
                                limit(((num >> 16) & 255) - 0x01) / 255,
                                limit(((num >> 8) & 255) + 0x0C) / 255,
                                limit(num & 255) / 255)]
        }
        else
            return [modernColor,modernColor]
    }
}
