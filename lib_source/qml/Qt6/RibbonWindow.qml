import QtQuick
import RibbonUI
import QtQuick.Window
import QWindowKit

Window {
    id:window
    minimumWidth: titleBar.minimumWidth
    enum Status {
        Stardard,
        SingleTask,
        SingleInstance
    }
    default property alias content: container.data
    property int windowStatus: RibbonWindow.Status.Stardard
    property alias windowItems: windowItems
    property alias titleBar: titleBar
    property alias popup: pop
    property bool comfirmedQuit: false
    property bool blurBehindWindow: false
    property int windowsTopFix: Qt.platform.os === 'windows' ? 1 : 0 // a trick to fix Qt or QWindowKit's bug
    property var viewItems
    property var tabBar
    property var bottomBar
    readonly property int borderWidth: border_rect.border.width
    readonly property int borderRadius: border_rect.radius
    visible: false
    color: {
        if (blurBehindWindow) {
            return "transparent"
        }
        if (RibbonTheme.isDarkMode) {
            return '#2C2B29'
        }
        return '#FFFFFF'
    }

    onActiveChanged: {
        if(Qt.platform.os === "osx")
            PlatformSupport.showSystemTitleBtns(window,active)
    }

    onBlurBehindWindowChanged: {
        if (Qt.platform.os === 'windows')
            windowAgent.setWindowAttribute("dwm-blur", blurBehindWindow)
        else if (Qt.platform.os === 'osx')
            windowAgent.setWindowAttribute("blur-effect", blurBehindWindow ? RibbonTheme.isDarkMode ? "dark" : "light" : "none")
    }

    Component.onCompleted: {
        windowAgent.setup(window)
        if (Qt.platform.os === 'windows')
        {
            windowAgent.setSystemButton(WindowAgent.Minimize, titleBar.minimizeBtn);
            windowAgent.setSystemButton(WindowAgent.Maximize, titleBar.maximizeBtn);
            windowAgent.setSystemButton(WindowAgent.Close, titleBar.closeBtn);
        }
        windowAgent.setSystemButton(WindowAgent.WindowIcon, titleBar.titleIcon);
        windowAgent.setHitTestVisible(titleBar.leftContainer)
        windowAgent.setHitTestVisible(titleBar.rightContainer)
        windowAgent.setTitleBar(titleBar)
        window.visible = true
        windowAgent.centralize()
        raise()
        windowAgent.setWindowAttribute("dark-mode", RibbonTheme.isDarkMode)
        blurBehindWindow =  Qt.platform.os === 'windows' && !RibbonUI.isWin11 ? false : true
        if (Qt.platform.os === 'windows')
        {
            windowAgent.setWindowAttribute("dwm-blur", blurBehindWindow)
        }
        if(Qt.platform.os === "osx")
        {
            windowAgent.setWindowAttribute("blur-effect", blurBehindWindow ? RibbonTheme.isDarkMode ? "dark" : "light" : "none")
        }
    }
    Item{
        id: windowItems
        anchors{
            fill: parent
            topMargin: border_rect.border.width + windowsTopFix
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
        function onThemeModeChanged() {
            windowAgent.setWindowAttribute("dark-mode", RibbonTheme.isDarkMode)
            if (Qt.platform.os === 'osx')
                windowAgent.setWindowAttribute("blur-effect", blurBehindWindow ? RibbonTheme.isDarkMode ? "dark" : "light" : "none")
        }
    }
    Rectangle{
        z:99
        anchors.fill: parent
        color: !RibbonTheme.isDarkMode ? Qt.rgba(255,255,255,0.3) : Qt.rgba(0,0,0,0.3)
        visible: !Window.active
    }
    Rectangle{
        id: border_rect
        z: -1
        anchors.fill: parent
        anchors.topMargin: windowsTopFix
        color: {
            if (Qt.platform.os === 'windows')
            {
                if (RibbonTheme.isDarkMode) {
                    return Qt.alpha('#2C2B29', 0.8)
                }
                return Qt.alpha('#FFFFFF',0.8)
            }
            return 'transparent'
        }
        border.color: RibbonTheme.isDarkMode ? "#7A7A7A" : "#2C59B7"
        border.width: RibbonTheme.modernStyle && window.visibility === Window.Windowed ?  1 : 0
        radius: Qt.platform.os === 'windows' ? RibbonUI.isWin11 ? 7 : 0 : 10
        visible: RibbonTheme.modernStyle || blurBehindWindow
    }
    RibbonPopup{
        id: pop
        target: windowItems
        targetRect: Qt.rect(windowItems.x + x, windowItems.y + y, width, height)
        blurEnabled: true
    }

    RibbonPopupDialog{
        id: close_dialog
        target: windowItems
        blurEnabled: true
        targetRect: Qt.rect(windowItems.x + x, windowItems.y + y, width, height)
        positiveText: qsTr("Quit")
        neutralText: qsTr("Minimize")
        negativeText: qsTr("Cancel")
        message: qsTr("Do you want to close this window?")
        title: qsTr("Please note")
        buttonFlags: RibbonPopupDialogType.NegativeButton | RibbonPopupDialogType.PositiveButton | RibbonPopupDialogType.NeutralButton
        onNeutralClicked: window.visibility =  Window.Minimized
        onPositiveClicked: {
            comfirmedQuit = false
            Qt.quit()
        }
    }

    WindowAgent {
        id: windowAgent
    }

    onClosing:function(event){
        window.raise()
        event.accepted = !comfirmedQuit
        if (comfirmedQuit)
            close_dialog.open()
    }

    function showWindow(window_url, args){
        if(typeof args === "undefined")
            args = {}
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
        var component = Qt.createComponent(window_url, Component.PreferSynchronous, null);
        if (component.status === Component.Ready) {
            var window = component.createObject(null, args)
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
}
