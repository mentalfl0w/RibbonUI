import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import RibbonUI 1.0

Button {
    id: control
    padding: 0
    leftPadding: 0
    rightPadding: 0
    focusPolicy:Qt.TabFocus
    checkable: true

    property bool isDarkMode: RibbonTheme.isDarkMode
    property int btnSize: 20
    property string borderColor: isDarkMode ? "white" : "black"
    property real borderWidth: 1.4
    property string iconColor: "white"
    property string iconFilledBgColor: "#2143AB"
    property string textColor: isDarkMode ? "white" : "black"
    property int textSize: 11
    property bool textBold: false
    property bool textOnLeft: false
    property bool showTooltip: false
    property string tipText: text

    background: Item{}
    contentItem: Item{
        id: item
        implicitHeight: btn_layout.height + btn_layout.margins*2
        implicitWidth: btn_layout.width + btn_layout.margins*2
        RowLayout{
            id: btn_layout
            property int margins: 4
            anchors.centerIn: parent
            layoutDirection: control.textOnLeft ? Qt.RightToLeft : Qt.LeftToRight
            Rectangle {
                id: bg
                implicitHeight: control.btnSize
                implicitWidth: implicitHeight
                color: "transparent"
                border{
                    color: control.borderColor
                    width: control.borderWidth
                }
                radius: 4.5
                Rectangle{
                    id: bg_fill
                    anchors.fill: parent
                    scale: control.hovered || control.pressed ? 0.6 : 1.05
                    radius: 4.5
                    color: !control.pressed?control.iconFilledBgColor:Qt.darker(control.iconFilledBgColor)
                    visible: control.hovered || control.pressed || control.checked
                    Behavior on scale{
                        NumberAnimation{
                            duration: 150
                            easing.type: Easing.OutSine
                        }
                    }
                }
                RibbonIcon{
                    id: check_icon
                    anchors.centerIn: bg
                    iconSource: RibbonIcons.Checkmark
                    iconSourceFilled: RibbonIcons_Filled.Checkmark
                    font.pixelSize: bg.height-4
                    filled: checked
                    visible: control.pressed || control.checked
                    color: !control.pressed?control.iconColor:Qt.darker(control.iconColor)
                }
                RibbonToolTip{
                    text: tipText
                    visible: hovered && showTooltip && text
                }
            }
            Text {
                id:label
                text:control.text
                Layout.alignment: Qt.AlignVCenter
                font{
                    family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                    pixelSize: control.textSize
                    bold: control.textBold
                }
                renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                color: textColor
                visible: text
            }
        }
    }
}
