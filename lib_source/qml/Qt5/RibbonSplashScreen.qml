import QtQuick 2.15
import RibbonUI 1.1
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QWindowKit 1.0

Window {
    id: root
    required property string homeUrl
    width: container.width
    height: container.height
    color: "transparent"
    property real delayMS: 2000
    property alias contentArgs: container.args
    property var homeArgs: ({})
    property string contentSource: "RibbonSplashScreenContent.qml"
    property var contentItems: undefined
    property bool blurBehindWindow :  Qt.platform.os === 'windows' && !RibbonUI.isWin11 ? false : true

    signal showLoadingLog(log: string, others: var)
    signal finished()

    ColumnLayout{
        id: container
        spacing: 10
        property var args: ({})
        Loader{
            id: loader
            sourceComponent: contentSource ? undefined : contentItems
            source: contentSource ? contentSource : ""
            onLoaded: {
                root.showLoadingLog.connect(item.dealWithLog)
                if (!Object.keys(container.args).length)
                    return
                else if(Object.keys(container.args).length){
                    for (let arg in container.args){
                        item[arg] = container.args[arg]
                    }
                }
                else{
                    console.error("RibbonSplashScreen: Arguments error, please check.")
                }
            }
        }
    }

    QtObject{
        id: internal
        property bool isComponentReady: false
        property var component
        property var home

        onIsComponentReadyChanged: {
            if(isComponentReady)
                timer.running = true
        }

        function dealWithHome(component, home){
            if (!(home.object instanceof Window))
            {
                console.error("RibbonSplashScreen: Error loading Home because instance is not Window.")
                return
            }
            home = home.object
            home.onClosing.connect(function() {
                if(!home.visible){
                    component.destroy()
                    home.destroy()
                }
            });
            home.raise()
            home.requestActivate()
        }

        function configHome(){
            let home = internal.component.incubateObject(null, root.homeArgs)
            if (home.status !== Component.Ready) {
                home.onStatusChanged = function(status) {
                    if (status === Component.Ready) {
                        console.debug("RibbonSplashScreen:", "Object", home.object, "is now ready.")
                        dealWithHome(internal.component, home)
                    }
                }
            } else {
                console.debug("RibbonSplashScreen:", "Object", home.object, "is ready immediately.")
                dealWithHome(internal.component, home)
            }
        }
    }

    Timer{
        id: timer
        interval: root.delayMS
        repeat: false
        running: false
        onTriggered: {
            internal.isComponentReady = false
            root.visible = false
            internal.configHome()
            finished()
        }
    }

    WindowAgent {
        id: windowAgent
    }

    Component.onCompleted: {
        windowAgent.setup(root)
        root.flags |= Qt.WindowStaysOnTopHint
        if (Qt.platform.os === 'windows')
        {
            windowAgent.setWindowAttribute("dwm-blur", blurBehindWindow)
        }
        if(Qt.platform.os === "osx")
        {
            windowAgent.setWindowAttribute("blur-effect", blurBehindWindow ? RibbonTheme.isDarkMode ? "dark" : "light" : "none")
            PlatformSupport.showSystemTitleBtns(root, false)
        }
        root.visible = true
        windowAgent.centralize()
        raise()
        requestActivate()

        const component = Qt.createComponent(root.homeUrl, Component.Asynchronous, null)

        if(component.status !== Component.Ready){
            component.statusChanged.connect(function(){
                if (component.status === Component.Ready) {
                    console.debug("RibbonSplashScreen:", "Component", component, "is now ready.")
                    internal.component = component
                    internal.isComponentReady = true
                } else if (component.status === Component.Error) {
                    console.error("RibbonSplashScreen: Error loading Window Component:", component.errorString())
                }
            })
        }
        else{
            console.debug("RibbonSplashScreen:", component, "is ready immediately.")
            internal.component = component
            internal.isComponentReady = true
        }
    }
}
