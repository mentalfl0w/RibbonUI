import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.15
import QtGraphicalEffects 1.0
import RibbonUI 1.0

Item{
    id: root
    height: folded ? top_border.height + bar.contentHeight + bottom_border.height: modernStyle ? 200 : 180
    anchors{
        top: parent.top
        left: parent.left
        right:parent.right
    }
    clip: true
    property bool folded: false
    property int lastIndex
    default property alias content: stack.contentData
    property alias rightToolBar: tool_bar.data
    property bool modernStyle: RibbonTheme.modernStyle
    property bool isDarkMode: RibbonTheme.isDarkMode
    property string bgColor: isDarkMode ? "#2D2D2D" : "#F4F5F3"
    property real bgOpacity: blurEnabled ? 0.8 : 1
    property string borderColor: isDarkMode ? "black" : "#CCCCCC"
    property bool showSettingsBtn: true
    property alias count: bar.count
    property bool blurEnabled: typeof Window.window.viewItems !== "undefined"
    property real modernMargin: modernStyle ? 10 : 0

    signal settingsBtnClicked()

    Component {
        id: ribbonTabButton
        RibbonTabButton{
            height: bar.contentHeight
        }
    }

    Rectangle {
        id: top_border
        anchors.top: parent.top
        width: parent.width
        height: 1
        color: modernStyle ? "transparent" : bgColor
        opacity:bgOpacity
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    Item {
        id:bg
        anchors
        {
            top: modernStyle ? bar_view.bottom : top_border.bottom
            left: parent.left
            right: parent.right
            bottom: bottom_border.top
            topMargin: modernMargin
            leftMargin: anchors.topMargin
            rightMargin: anchors.topMargin
            bottomMargin: anchors.topMargin
        }
        clip: true

        RibbonBlur{
            id: blur
            anchors.fill: parent
            maskColor: bgColor
            maskOpacity: bgOpacity
            useSolidBg: true
            radius: modernStyle ? 10 :0
            clip: true
            target: Window.window.viewItems
            targetRect: mapToItem(Window.window.viewItems, blur.x, blur.y, width, height)
            Behavior on maskColor {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
    }

    RibbonShadow {
        id: effect
        enabled: modernStyle
        visible: modernStyle
        source: bg
        anchors.fill: bg
    }

    Flickable{
        id: bar_view
        anchors{
            top:top_border.bottom
            left: parent.left
            right:tool_bar.left
        }
        height: bar_layout.height
        z:1
        contentWidth: bar_layout.width
        ScrollIndicator.horizontal: RibbonScrollIndicator{visible:false}
        RowLayout
        {
            id: bar_layout
            spacing: 0
            RibbonTabButton{
                id: setting_btn
                height: bar.contentHeight
                checkable: false
                Layout.alignment: Qt.AlignHCenter
                Layout.leftMargin: 5
                Layout.rightMargin: 10
                text: qsTr("Settings")
                onClicked: settingsBtnClicked()
                visible: root.showSettingsBtn
            }
            TabBar {
                id: bar
                Layout.alignment: Qt.AlignHCenter
                background: Item{}
                position: TabBar.Header
                currentIndex: stack.currentIndex
            }
        }
    }

    RowLayout{
        id: tool_bar
        z:2
        spacing: 10
        width: 200
        height: bar.contentHeight
        layoutDirection: Qt.RightToLeft
        anchors{
            top:top_border.bottom
            right:parent.right
            rightMargin: tool_bar.spacing
        }
    }

    SwipeView {
        id: stack
        z:0
        anchors{
            top: bar_view.bottom
            left: parent.left
            right:parent.right
        }
        interactive: false
        clip: true
        property int origin_height: root.height - bar.contentHeight - top_border.height * 2
        height: folded ? 0 :origin_height
        currentIndex: bar.currentIndex
        background: Item{
            anchors{
                fill: parent
                topMargin: modernStyle ? 10 :0
                leftMargin: modernStyle ? 10 :0
                rightMargin: modernStyle ? 10 :0
                bottomMargin: modernStyle ? 10 :0
            }
        }
        contentItem: ListView {
            anchors{
                fill: parent
                topMargin: modernStyle ? 10 :0
                leftMargin: modernStyle ? 10 :0
                rightMargin: modernStyle ? 10 :0
                bottomMargin: modernStyle ? 10 :0
            }
            clip: true
            model: stack.contentModel
            interactive: stack.interactive
            currentIndex: stack.currentIndex
            focus: stack.focus

            spacing: stack.spacing
            orientation: stack.orientation
            snapMode: ListView.SnapOneItem
            boundsBehavior: Flickable.StopAtBounds

            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: 0
            preferredHighlightEnd: 0
            highlightMoveDuration: 250
            maximumFlickVelocity: 4 * (stack.orientation === Qt.Horizontal ? width : height)
            RibbonButton{
                anchors{
                    right: parent.right
                    bottom: parent.bottom
                    rightMargin: 5
                    bottomMargin: 5
                }
                iconSource: RibbonIcons.ChevronDown
                Behavior on rotation {
                    NumberAnimation{
                        duration: 100
                        easing.type: Easing.OutSine
                    }
                }
                rotation: folded ? 0 : 180
                onClicked: folded = !folded
                showBg: false
                showHoveredBg: false
                tipText: folded ? qsTr("Show") : qsTr("Hide")
                textColor: isDarkMode ? "white" : "black"
            }
        }

        Behavior on height {
            enabled: folded
            NumberAnimation {
                duration: 167
                easing.type: Easing.OutSine
            }
        }

        Component.onCompleted: {
            for (let i=0,sign=0; i < stack.contentData.length; i++)
            {
                let item = stack.contentData[i]
                if(item instanceof RibbonTabPage){
                    let btn = ribbonTabButton.createObject(bar,{text:qsTr(item.title),index:sign})
                    if (sign===0)
                    {
                        btn.checked = true
                    }
                    sign++
                    btn.need_fold.connect(hideStack)
                    root.foldedChanged.connect(function(){btn.setFolded(folded)})
                }
            }
        }
    }

    Rectangle {
        id: bottom_border
        anchors.top: stack.bottom
        width: parent.width
        height: 1
        color: modernStyle ? "transparent" : bgColor
        opacity:bgOpacity
        Rectangle{
            anchors{
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            z: 3
            color: borderColor
            height: 1
            visible: !modernStyle
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: 60
                easing.type: Easing.OutSine
            }
        }
    }

    Behavior on height {
        NumberAnimation {
            duration: 167
            easing.type: Easing.OutSine
        }
    }

    Timer{
        id: timer
        interval: 500
        repeat: false
        onTriggered: folded = false
    }

    Component.onCompleted: Window.window.tabBar = root
    //onModern_styleChanged: refresh()

    function addPage(content, is_highlight)
    {
        var item
        if (content instanceof Component)
            item = content
        else
        {
            item = Qt.createComponent(content, bar)
            if (component.status === Component.Error) {
                console.log(qsTr("RibbonTabBar: Error loading component:"), component.errorString());
                return
            }
        }
        if(item instanceof RibbonTabPage){
            let btn = ribbonTabButton.createObject(bar,{text:qsTr(item.title),index:bar.count-1,highlight:is_highlight})
            btn.need_fold.connect(hideStack)
            root.foldedChanged.connect(function(){btn.setFolded(folded)})
        }
    }

    function deletePage(index)
    {
        for (var i=0, count = 0; i < bar.contentChildren.length; i++)
        {
            var item = bar.itemAt(i)
            if(item instanceof RibbonTabButton){
                if (count === index)
                {
                    item.destroy()
                    break
                }
                count++
            }
        }
        for (let i=0, count = 0; i < stack.contentChildren.length; i++)
        {
            let item = stack.itemAt(i)
            if(item instanceof RibbonTabGroup){
                if (count === index)
                {
                    item.destroy()
                    break
                }
                count++
            }
        }
    }

    function hideStack(need_hide, index)
    {
        if (typeof(lastIndex)==='undefined'||lastIndex===index||lastIndex!==index&&!need_hide)
        {
            folded = need_hide && !folded
        }
        lastIndex = index
    }

    function refresh()
    {
        if(!folded)
        {
            folded = true
            timer.start()
        }
    }

    function setPage(index)
    {
        for (let i=0, count = 0; i < bar.contentChildren.length; i++)
        {
            let item = bar.itemAt(i)
            if(item instanceof RibbonTabButton){
                if (count === index)
                {
                    item.checked = true
                    break
                }
                count++
            }
        }
    }
}
