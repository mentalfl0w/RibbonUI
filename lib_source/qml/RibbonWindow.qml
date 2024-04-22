import QtQuick
import RibbonUI
import QWindowKit

Window {
    id:window
    minimumWidth: title_bar.minimumWidth
    enum Status {
        Stardard,
        SingleTask,
        SingleInstance
    }
    default property alias content: container.data
    property int windowStatus: RibbonWindow.Status.Stardard
    property alias window_items: window_items
    property alias title_bar: titleBar
    property alias popup: pop
    property bool comfirmed_quit: false
    property bool blurBehindWindow: true
    property int windows_top_fix: Qt.platform.os === 'windows' ? 1 : 0 // a trick to fix Qt or QWindowKit's bug
    visible: false
    color: {
        if (blurBehindWindow) {
            return "transparent"
        }
        if (RibbonTheme.dark_mode) {
            return '#2C2B29'
        }
        return '#FFFFFF'
    }
    onBlurBehindWindowChanged: {
        if (Qt.platform.os === 'windows')
            windowAgent.setWindowAttribute("dwm-blur", blurBehindWindow)
        else if (Qt.platform.os === 'osx')
            windowAgent.setWindowAttribute("blur-effect", blurBehindWindow ? RibbonTheme.dark_mode ? "dark" : "light" : "none")
    }

    Component.onCompleted: {
        windowAgent.setup(window)
        if (Qt.platform.os === 'windows')
        {
            windowAgent.setSystemButton(WindowAgent.Minimize, titleBar.minimizeBtn);
            windowAgent.setSystemButton(WindowAgent.Maximize, titleBar.maximizeBtn);
            windowAgent.setSystemButton(WindowAgent.Close, titleBar.closeBtn);
        }
        windowAgent.setHitTestVisible(titleBar.left_container)
        windowAgent.setHitTestVisible(titleBar.right_container)
        windowAgent.setTitleBar(titleBar)
        window.visible = true
        windowAgent.centralize()
        windowAgent.setWindowAttribute("dark-mode", RibbonTheme.dark_mode)
        if (Qt.platform.os === 'windows')
        {
            windowAgent.setWindowAttribute("dwm-blur", blurBehindWindow)
        }
        if(Qt.platform.os === "osx")
        {
            windowAgent.setWindowAttribute("blur-effect", blurBehindWindow ? RibbonTheme.dark_mode ? "dark" : "light" : "none")
            PlatformSupport.showSystemTitleBtns(window, true)
        }
    }
    Item{
        id: window_items
        anchors{
            fill: parent
            topMargin: border_rect.border.width + windows_top_fix
            leftMargin: border_rect.border.width
            rightMargin: border_rect.border.width
            bottomMargin: border_rect.border.width
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
    }
    Connections{
        target: RibbonTheme
        function onTheme_modeChanged() {
            windowAgent.setWindowAttribute("dark-mode", RibbonTheme.dark_mode)
            if (Qt.platform.os === 'osx')
                windowAgent.setWindowAttribute("blur-effect", blurBehindWindow ? RibbonTheme.dark_mode ? "dark" : "light" : "none")
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
        z: -1
        anchors.fill: parent
        anchors.topMargin: windows_top_fix
        color: {
            if (Qt.platform.os === 'windows')
            {
                if (RibbonTheme.dark_mode) {
                    return Qt.alpha('#2C2B29', 0.8)
                }
                return Qt.alpha('#FFFFFF',0.8)
            }
            return 'transparent'
        }
        border.color: RibbonTheme.dark_mode ? "#7A7A7A" : "#2C59B7"
        border.width: RibbonTheme.modern_style ?  1 : 0
        radius: Qt.platform.os === 'windows' ? 7 : 10
        visible: RibbonTheme.modern_style || blurBehindWindow
    }
    RibbonPopup{
        id: pop
        target: window_items
        target_rect: Qt.rect(window_items.x + x, window_items.y + y, width, height)
        blur_enabled: true
    }

    RibbonPopupDialog{
        id: close_dialog
        target: window_items
        blur_enabled: true
        target_rect: Qt.rect(window_items.x + x, window_items.y + y, width, height)
        positiveText: qsTr("Quit")
        neutralText: qsTr("Minimize")
        negativeText: qsTr("Cancel")
        message: qsTr("Do you want to close this window?")
        title: qsTr("Please note")
        buttonFlags: RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton | RibbonPopupDialogType.NeutralButton
        onNeutralClicked: window.visibility =  Window.Minimized
        onPositiveClicked: {
            comfirmed_quit = false
            Qt.quit()
        }
    }

    WindowAgent {
        id: windowAgent
    }

    onClosing:function(event){
        window.raise()
        event.accepted = !comfirmed_quit
        if (comfirmed_quit)
            close_dialog.open()
    }

    function show_window(window_url, args){
        let sub_windows = RibbonUI.windowsSet
        if (sub_windows.hasOwnProperty(window_url)&&sub_windows[window_url]['windowStatus'] !== RibbonWindow.Status.Stardard)
        {
            if (sub_windows[window_url]['windowStatus'] === RibbonWindow.Status.SingleInstance)
            {
                if (args && Object.keys(args).length)
                {
                    for (let arg in args){
                        sub_windows[window_url][arg] = args[arg]
                    }
                }
                if (!sub_windows[window_url].visible)
                {
                    sub_windows[window_url].show()
                }
                sub_windows[window_url].raise()
                sub_windows[window_url].requestActivate()
                RibbonUI.windowsSet = sub_windows
                return
            }
            else
            {
                sub_windows[window_url].close()
            }
        }
        var component = Qt.createComponent(window_url, Component.PreferSynchronous, undefined);
        if (component.status === Component.Ready) {
            var window = component.createObject(undefined, args)
            if (!(window instanceof Window))
            {
                console.error("RibbonWindow: Error loading Window: Instance is not Window.")
                return
            }
            sub_windows[window_url] = window
            RibbonUI.windowsSet = sub_windows
            window.onClosing.connect(function() {
                window.destroy()
                let sub_windows = RibbonUI.windowsSet
                delete sub_windows[window_url]
                RibbonUI.windowsSet = sub_windows
            });
            window.raise()
            window.requestActivate()
        } else if (component.status === Component.Error) {
            console.error("RibbonWindow: Error loading Window:", component.errorString())
        }
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
