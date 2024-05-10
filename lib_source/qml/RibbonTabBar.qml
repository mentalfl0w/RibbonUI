import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import RibbonUI

Item{
    id: root
    height: folded ? top_border.height + bar.contentHeight + bottom_border.height: modern_style ? 200 : 180
    anchors{
        top: parent.top
        left: parent.left
        right:parent.right
    }
    clip: true
    property bool folded: false
    property int last_index
    default property alias content: stack.contentData
    property alias right_tool_bar: tool_bar.data
    property bool modern_style: RibbonTheme.modern_style
    property bool dark_mode: RibbonTheme.dark_mode
    property string bg_color: dark_mode ? "#2D2D2D" : "#F4F5F3"
    property double bg_opacity: 0.8
    property string border_color: dark_mode ? "black" : "#CCCCCC"
    property bool showSettingsBtn: true
    property alias count: bar.count

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
        color: modern_style ? "transparent" : bg_color
        opacity:bg_opacity
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
            top: modern_style ? bar_view.bottom : top_border.bottom
            left: parent.left
            right: parent.right
            bottom:bottom_border.top
            topMargin: modern_style ? 10 :0
            leftMargin: modern_style ? 10 :0
            rightMargin: modern_style ? 10 :0
            bottomMargin: modern_style ? 10 :0
        }
        clip: true
        opacity:bg_opacity

        Rectangle{
            anchors.fill: parent
            color: bg_color
            opacity:bg_opacity
            radius: modern_style ? 10 :0
            Behavior on color {
                ColorAnimation {
                    duration: 60
                    easing.type: Easing.OutSine
                }
            }
        }
    }

    RibbonShadow {
        id: effect
        enabled: modern_style
        visible: modern_style
        source: bg
        anchors.fill: bg
    }

    ScrollView{
        id: bar_view
        anchors{
            top:top_border.bottom
            left: parent.left
            right:tool_bar.left
        }
        height: bar_layout.height
        z:1
        ScrollBar.horizontal: RibbonScrollBar{
            anchors.bottom: bar_view.bottom
            anchors.horizontalCenter: bar_view.horizontalCenter
            width: bar_view.width - 10
            height: 5
        }
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
                topMargin: modern_style ? 10 :0
                leftMargin: modern_style ? 10 :0
                rightMargin: modern_style ? 10 :0
                bottomMargin: modern_style ? 10 :0
            }
        }
        contentItem: ListView {
            anchors{
                fill: parent
                topMargin: modern_style ? 10 :0
                leftMargin: modern_style ? 10 :0
                rightMargin: modern_style ? 10 :0
                bottomMargin: modern_style ? 10 :0
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
                icon_source: RibbonIcons.ChevronDown
                Behavior on rotation {
                    NumberAnimation{
                        duration: 100
                        easing.type: Easing.OutSine
                    }
                }
                rotation: folded ? 0 : 180
                onClicked: folded = !folded
                show_bg: false
                show_hovered_bg: false
                tip_text: folded ? qsTr("Show") : qsTr("Hide")
                text_color: dark_mode ? "white" : "black"
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
                    btn.need_fold.connect(hide_stack)
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
        color: modern_style ? "transparent" : bg_color
        opacity:bg_opacity
        Rectangle{
            anchors{
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            z: 3
            color: border_color
            height: 1
            visible: !modern_style
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
            btn.need_fold.connect(hide_stack)
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

    function hide_stack(need_hide, index)
    {
        if (typeof(last_index)==='undefined'||last_index===index||last_index!==index&&!need_hide)
        {
            folded = need_hide && !folded
        }
        last_index = index
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
