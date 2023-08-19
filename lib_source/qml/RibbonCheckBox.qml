import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import RibbonUI

Button {
    id: control
    padding: 0
    leftPadding: 0
    rightPadding: 0
    focusPolicy:Qt.TabFocus
    checkable: true

    property bool dark_mode: RibbonTheme.dark_mode
    property int btn_size: 20
    property string border_color: dark_mode ? "white" : "black"
    property double border_width: 1.4
    property string icon_color: "white"
    property string icon_filled_bg_color: "#2143AB"
    property string text_color: dark_mode ? "white" : "black"
    property int text_size: 11
    property bool text_bold: false
    property bool text_on_left: false
    property bool show_tooltip: false
    property string tip_text: text

    background: Item{}
    contentItem: Item{
        id: item
        implicitHeight: btn_layout.height + btn_layout.margins*2
        implicitWidth: btn_layout.width + btn_layout.margins*2
        RowLayout{
            id: btn_layout
            property int margins: 4
            anchors.centerIn: parent
            layoutDirection: control.text_on_left ? Qt.RightToLeft : Qt.LeftToRight
            Rectangle {
                id: bg
                implicitHeight: control.btn_size
                implicitWidth: implicitHeight
                color: "transparent"
                border{
                    color: control.border_color
                    width: control.border_width
                }
                radius: 4.5
                Rectangle{
                    id: bg_fill
                    anchors.fill: parent
                    scale: control.hovered || control.pressed ? 0.6 : 1.05
                    radius: 4.5
                    color: !control.pressed?control.icon_filled_bg_color:Qt.darker(control.icon_filled_bg_color)
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
                    icon_source: RibbonIcons.Checkmark
                    icon_source_filled: RibbonIcons_Filled.Checkmark
                    font.pixelSize: bg.height-4
                    filled: checked
                    visible: control.pressed || control.checked
                    color: !control.pressed?control.icon_color:Qt.darker(control.icon_color)
                }
                RibbonToolTip{
                    text: tip_text
                    visible: hovered && show_tooltip && text
                }
            }
            Text {
                id:label
                text:control.text
                Layout.alignment: Qt.AlignVCenter
                font{
                    family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                    pixelSize: control.text_size
                    bold: control.text_bold
                }
                color: text_color
                visible: text
            }
        }
    }
}
