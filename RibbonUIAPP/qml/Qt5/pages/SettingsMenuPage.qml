import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import RibbonUI 1.1
import RibbonUIAPP 1.1

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
                        textRole: "text"
                        model: ListModel {
                            ListElement { text: qsTr("Light"); value: RibbonThemeType.Light }
                            ListElement { text: qsTr("Dark"); value: RibbonThemeType.Dark }
                            ListElement { text: qsTr("System"); value: RibbonThemeType.System }
                        }
                        iconSource: RibbonIcons.DarkTheme
                        Component.onCompleted: update_state()
                        onActivated: RibbonTheme.themeMode = model.get(currentIndex).value
                        Connections{
                            target: RibbonTheme
                            function onThemeModeChanged(){
                                theme_combo.update_state()
                            }
                        }
                        function update_state(){
                            let str = (RibbonTheme.themeMode === RibbonThemeType.System ? qsTr("System") : RibbonTheme.themeMode === RibbonThemeType.Light ? qsTr("Light") : qsTr("Dark"))
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
                    text: qsTr("Render")
                    grabberText: RibbonTheme.nativeText ? qsTr("Native") : qsTr("Qt")
                    checked: true
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        RibbonTheme.nativeText = checked
                    }
                }
            }
        }
        RibbonBackStageGroup{
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: render_btn.height + 40
            Layout.fillWidth: true
            groupName: qsTr("TitleBar")
            RowLayout{
                RibbonText{
                    text: qsTr("Show TitleBar Icon: ")
                }
                RibbonSwitchButton{
                    text: qsTr("Icon")
                    grabberText: RibbonTheme.nativeText ? qsTr("Show") : qsTr("Hide")
                    checked: true
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        Window.window.titleBar.titleIcon.visible = checked
                    }
                }
            }
        }
        RibbonBackStageGroup{
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: lang_combo.height + 40
            Layout.fillWidth: true
            groupName: qsTr("Language")
            ColumnLayout{
                RowLayout{
                    RibbonText{
                        text: qsTr("Current Language: ")
                    }
                    RibbonComboBox{
                        id: lang_combo
                        model: ListModel {
                        }
                        textRole: "text"
                        iconSource: RibbonIcons.LocalLanguage
                        Component.onCompleted: update_state()
                        onActivated: Localization.currentLanguage = model.get(currentIndex).value
                        Connections{
                            target: Localization
                            function onCurrentLanguageChanged(){
                                lang_combo.update_state()
                            }
                        }
                        function update_state(){
                            model.clear()
                            let langs = Localization.languageList()
                            for(let i = 0; i < langs.length; i++){
                                model.append({
                                                      text:Localization.languageTranslate(langs[i]),
                                                      value:langs[i]
                                                  })
                            }

                            currentIndex = find(Localization.languageTranslate(Localization.currentLanguage))
                        }
                    }
                }
            }
        }
    }
}
