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
    property bool show_grabber_text: true
    property string grabber_text: control.checked ? qsTr("Open") : qsTr("Close")
    property string text_color: dark_mode ? "white" : "black"
    property int text_size: 11
    property string grabber_checked_color: dark_mode ? "#8AAAEB" : "#2850A4"
    property string grabber_unchecked_color: dark_mode ? "#292929" : "white"
    property string grabber_text_checked_color: dark_mode ? "black" : "white"
    property string grabber_text_unchecked_color: dark_mode ? "white" : "black"
    property string grabber_color: dark_mode ? control.pressed ? "#F8F8F8" : "white" : control.pressed ? "#4D4D4D":"#616161"
    property string border_color: dark_mode ? "white" : "#616161"
    property double border_width: 1.4
    property bool text_bold: false
    property bool text_on_left: false
    property bool show_tooltip: false
    property string tip_text: text

    background:Item{}
    contentItem:Item{
        id: item
        implicitHeight: btn_layout.height + btn_layout.margins*2
        implicitWidth: btn_layout.width + btn_layout.margins*2
        RowLayout{
            id: btn_layout
            property int margins: 4
            spacing: 4
            anchors.centerIn: parent
            layoutDirection: control.text_on_left ? Qt.RightToLeft : Qt.LeftToRight
            Item{
                id: btn
                implicitHeight: 20
                implicitWidth: control.show_grabber_text ? 20 + grabber_text.anchors.margins * 2 + grabber_text.contentWidth : 40
                Rectangle{
                    id:bg
                    implicitWidth: btn.implicitWidth + border.width
                    implicitHeight: btn.implicitHeight + border.width
                    anchors.verticalCenter: parent.verticalCenter
                    border.color: border_color
                    border.width: border_width
                    radius: 12
                    states: [
                        State{
                            name:"checked"
                            when: control.checked
                            PropertyChanges {
                                target: bg
                                color: grabber_checked_color
                            }
                        },
                        State{
                            name:"unchecked"
                            when: !control.checked
                            PropertyChanges {
                                target: bg
                                color: grabber_unchecked_color
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "checked"
                            to:"unchecked"
                            ColorAnimation {
                                from: grabber_checked_color
                                to: grabber_unchecked_color
                                duration: 200
                                easing.type: Easing.OutSine
                            }
                        },
                        Transition {
                            from: "unchecked"
                            to:"checked"
                            ColorAnimation {
                                from: grabber_unchecked_color
                                to: grabber_checked_color
                                duration: 200
                                easing.type: Easing.OutSine
                            }
                        }
                    ]
                }
                Rectangle{
                    id: grabber
                    implicitHeight: bg.implicitHeight - anchors.margins*2
                    implicitWidth:implicitHeight
                    radius: width / 2
                    color: grabber_color
                    anchors{
                        verticalCenter: parent.verticalCenter
                        margins: 4
                    }
                    scale: control.hovered && !control.pressed ? 1.2 : control.pressed ? 1.1 : 1.0
                    x: control.checked ? btn.implicitWidth - anchors.margins - implicitWidth : anchors.margins
                    z: 1
                    Behavior on x {
                        NumberAnimation{
                            duration: 150
                            easing.type: Easing.OutSine
                        }
                    }
                    Behavior on scale {
                        NumberAnimation{
                            duration: 150
                            easing.type: Easing.OutSine
                        }
                    }
                    layer.enabled: true
                    layer.effect: RibbonShadow{
                        shadow_opacity: 0.2
                        shadow_color: "black"
                    }
                }
                Text {
                    id: grabber_text
                    text: control.grabber_text
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 4
                    visible: control.show_grabber_text
                    x: control.checked ? grabber.x - anchors.margins - contentWidth : grabber.x + grabber.width + anchors.margins
                    z: 0
                    font{
                        family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                        pixelSize: 9
                        bold: true
                    }
                    Behavior on x {
                        NumberAnimation{
                            duration: 150
                            easing.type: Easing.OutSine
                        }
                    }
                    states: [
                        State{
                            name:"checked"
                            when: control.checked
                            PropertyChanges {
                                target: grabber_text
                                color: grabber_text_checked_color
                            }
                        },
                        State{
                            name:"unchecked"
                            when: !control.checked
                            PropertyChanges {
                                target: grabber_text
                                color: grabber_text_unchecked_color
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "checked"
                            to:"unchecked"
                            ColorAnimation {
                                from: grabber_text_checked_color
                                to: grabber_text_unchecked_color
                                duration: 200
                                easing.type: Easing.OutSine
                            }
                        },
                        Transition {
                            from: "unchecked"
                            to:"checked"
                            ColorAnimation {
                                from: grabber_text_checked_color
                                to: grabber_text_unchecked_color
                                duration: 200
                                easing.type: Easing.OutSine
                            }
                        }
                    ]
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
