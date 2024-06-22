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

    property bool isDarkMode: RibbonTheme.isDarkMode
    property bool showGrabberText: true
    property string grabberText: control.checked ? qsTr("Open") : qsTr("Close")
    property string textColor: isDarkMode ? "white" : "black"
    property int textSize: 12
    property string grabberCheckedColor: isDarkMode ? "#8AAAEB" : "#2850A4"
    property string grabberUncheckedColor: isDarkMode ? "#292929" : "white"
    property string grabberTextCheckedColor: isDarkMode ? "black" : "white"
    property string grabberTextUncheckedColor: isDarkMode ? "white" : "black"
    property string grabberColor: isDarkMode ? control.pressed ? "#F8F8F8" : "white" : control.pressed ? "#4D4D4D":"#616161"
    property string borderColor: isDarkMode ? "white" : "#616161"
    property real borderWidth: 1.4
    property bool textBold: false
    property bool textOnLeft: false
    property bool showTooltip: false
    property string tipText: text

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
            layoutDirection: control.textOnLeft ? Qt.RightToLeft : Qt.LeftToRight
            Item{
                id: btn
                implicitHeight: 20
                implicitWidth: control.showGrabberText ? 20 + grabberText.anchors.margins * 2 + grabberText.contentWidth : 40
                Rectangle{
                    id:bg
                    implicitWidth: btn.implicitWidth + border.width
                    implicitHeight: btn.implicitHeight + border.width
                    anchors.verticalCenter: parent.verticalCenter
                    border.color: borderColor
                    border.width: borderWidth
                    radius: 12
                    states: [
                        State{
                            name:"checked"
                            when: control.checked
                            PropertyChanges {
                                target: bg
                                color: grabberCheckedColor
                            }
                        },
                        State{
                            name:"unchecked"
                            when: !control.checked
                            PropertyChanges {
                                target: bg
                                color: grabberUncheckedColor
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "checked"
                            to:"unchecked"
                            ColorAnimation {
                                from: grabberCheckedColor
                                to: grabberUncheckedColor
                                duration: 200
                                easing.type: Easing.OutSine
                            }
                        },
                        Transition {
                            from: "unchecked"
                            to:"checked"
                            ColorAnimation {
                                from: grabberUncheckedColor
                                to: grabberCheckedColor
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
                    color: grabberColor
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
                        shadowOpacity: 0.2
                        shadowColor: "black"
                    }
                }
                Text {
                    id: grabberText
                    text: control.grabberText
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: 4
                    renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                    visible: control.showGrabberText
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
                                target: grabberText
                                color: grabberTextCheckedColor
                            }
                        },
                        State{
                            name:"unchecked"
                            when: !control.checked
                            PropertyChanges {
                                target: grabberText
                                color: grabberTextUncheckedColor
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            from: "checked"
                            to:"unchecked"
                            ColorAnimation {
                                from: grabberTextCheckedColor
                                to: grabberTextUncheckedColor
                                duration: 200
                                easing.type: Easing.OutSine
                            }
                        },
                        Transition {
                            from: "unchecked"
                            to:"checked"
                            ColorAnimation {
                                from: grabberTextCheckedColor
                                to: grabberTextUncheckedColor
                                duration: 200
                                easing.type: Easing.OutSine
                            }
                        }
                    ]
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
                renderType: RibbonTheme.nativeText ? Text.NativeRendering : Text.QtRendering
                font{
                    family: Qt.platform.os === "osx" ? "PingFang SC" : "Microsoft YaHei UI"
                    pixelSize: control.textSize
                    bold: control.textBold
                }
                color: textColor
                visible: text
            }
        }
    }
}
