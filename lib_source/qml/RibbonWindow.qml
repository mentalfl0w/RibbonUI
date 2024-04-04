import QtQuick
import RibbonUI
import org.wangwenx190.FramelessHelper

Window {
    id:window
    default property alias content: container.data
    property alias window_items: window_items
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
    Item{
        id: window_items
        anchors.fill: parent
        RibbonTitleBar {
            id: titleBar
            anchors.topMargin: border_rect.border.width
            anchors.leftMargin: border_rect.border.width
            anchors.rightMargin: border_rect.border.width
        }
        Item{
            id:container
            anchors{
                top: titleBar.bottom
                left: parent.left
                leftMargin: border_rect.border.width
                right: parent.right
                rightMargin: border_rect.border.width
                bottom: parent.bottom
                bottomMargin: border_rect.border.width
            }
            clip: true
        }
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
    Rectangle{
        id: border_rect
        anchors.fill: parent
        color: 'transparent'
        border.color: RibbonTheme.dark_mode ? "#7A7A7A" : "#2C59B7"
        border.width: RibbonTheme.modern_style ? 1 : 0
        radius: 10
        visible: RibbonTheme.modern_style
    }
    RibbonPopup{
        id: pop
        target: window_items
        target_rect: Qt.rect(window_items.x + x, window_items.y + y, width, height)
        blur_enabled: true
    }
    RibbonPopupDialog{
        id: dialog
        target: window_items
        blur_enabled: true
        target_rect: Qt.rect(window_items.x + x, window_items.y + y, width, height)
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

    function show_popup(content_url, arguments)
    {
        console.warn(qsTr("RibbonWindow: This \"show_popup()\" function is deprecated, please use RibbonPopup.open_content()"))
        popup.show_close_btn = !popup.show_close_btn
        popup.show_content(content_url, arguments)
    }

    function close_popup()
    {
        console.warn(qsTr("RibbonWindow: This \"close_popup()\" function is deprecated, please use RibbonPopup.close_content()"))
        popup.show_close_btn = !popup.show_close_btn
        pop.close_content()
    }
}
