import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

RibbonBackStagePage{
    id: page
    pageName: qsTr("Settings")
    ColumnLayout{
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        spacing: 100
        RibbonBackStageGroup{
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: theme_combo.height + 40
            Layout.fillWidth: true
            groupName: qsTr("Theme")
            ColumnLayout{
                RowLayout{
                    RibbonText{
                        text: qsTr("Current Theme: ")
                    }
                    RibbonComboBox{
                        id: theme_combo
                        model: ListModel {
                            id: model_theme
                            ListElement { text: "Light" }
                            ListElement { text: "Dark" }
                            ListElement { text: "System" }
                        }
                        iconSource: RibbonIcons.DarkTheme
                        Component.onCompleted: update_state()
                        onActivated: {
                            if (currentText === "System")
                                RibbonTheme.themeMode = RibbonThemeType.System
                            else if (currentText === "Light")
                                RibbonTheme.themeMode = RibbonThemeType.Light
                            else
                                RibbonTheme.themeMode = RibbonThemeType.Dark
                        }
                        Connections{
                            target: RibbonTheme
                            function onThemeModeChanged(){
                                theme_combo.update_state()
                            }
                        }
                        function update_state(){
                            let str = (RibbonTheme.themeMode === RibbonThemeType.System ? "System" : RibbonTheme.themeMode === RibbonThemeType.Light ? "Light" : "Dark")
                            currentIndex = find(str)
                        }
                    }
                }
                RowLayout{
                    RibbonText{
                        text: qsTr("Current Style: ")
                    }
                    RibbonSwitchButton{
                        text: qsTr("Style")
                        grabberText: checked ? qsTr("Modern") : qsTr("Classic")
                        onClicked: RibbonTheme.modernStyle = checked
                        checked: RibbonTheme.modernStyle
                    }
                }
            }
        }
        RibbonBackStageGroup{
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: render_btn.height + 40
            Layout.fillWidth: true
            groupName: qsTr("Text Render")
            RowLayout{
                RibbonText{
                    text: qsTr("Current Text Render: ")
                }
                RibbonSwitchButton{
                    id: render_btn
                    text: "Render"
                    grabberText: RibbonTheme.nativeText ? "Native" : "Qt"
                    checked: true
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        RibbonTheme.nativeText = checked
                    }
                }
            }
        }
    }
}
