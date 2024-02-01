import QtQuick
import RibbonUI
import org.wangwenx190.FramelessHelper

Window {
    id:window
    default property alias content: container.data
    property alias title_bar: titleBar
    property alias popup: pop
    property bool comfirmed_quit: false
    visible: false
    color: {
        if (FramelessHelper.blurBehindWindowEnabled) {
            return "transparent";
        }
        if (FramelessUtils.systemTheme === FramelessHelperConstants.Dark) {
            return FramelessUtils.defaultSystemDarkColor;
        }
        return FramelessUtils.defaultSystemLightColor;
    }
    FramelessHelper.onReady: {
        if (Qt.platform.os === 'windows')
        {
            FramelessHelper.setSystemButton(titleBar.minimizeBtn, FramelessHelperConstants.Minimize);
            FramelessHelper.setSystemButton(titleBar.maximizeBtn, FramelessHelperConstants.Maximize);
            FramelessHelper.setSystemButton(titleBar.closeBtn, FramelessHelperConstants.Close);
        }
        FramelessHelper.setHitTestVisible(titleBar.left_container)
        FramelessHelper.setHitTestVisible(titleBar.right_container)
        FramelessHelper.titleBarItem = titleBar;
        FramelessHelper.moveWindowToDesktopCenter();
        window.visible = true;
    }
    RibbonTitleBar {
        id: titleBar
    }
    Item{
        id:container
        anchors{
            top: titleBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true
    }
    Connections{
        target: RibbonTheme
        function onTheme_modeChanged() {
            if (RibbonTheme.dark_mode)
                FramelessUtils.systemTheme = FramelessHelperConstants.Dark
            else
                FramelessUtils.systemTheme = FramelessHelperConstants.Light
        }
    }
    Rectangle{
        z:99
        anchors.fill: parent
        color: !RibbonTheme.dark_mode ? Qt.rgba(255,255,255,0.3) : Qt.rgba(0,0,0,0.3)
        visible: !Window.active
    }
    RibbonPopup{
        id: pop
    }
    RibbonPopupDialog{
        id: dialog
        positiveText: qsTr("Quit")
        neutralText: qsTr("Minimize")
        negativeText: qsTr("Cancel")
        message: "Do you want to quit the APP?"
        title: "Please note"
        buttonFlags: RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton | RibbonPopupDialogType.NeutralButton
        onNeutralClicked: window.visibility =  Window.Minimized
        onPositiveClicked: {
            comfirmed_quit = true
            Qt.quit()
        }
    }
    onClosing:function(event){
        window.raise()
        event.accepted = comfirmed_quit
        if (!comfirmed_quit)
            dialog.open()
    }
}
