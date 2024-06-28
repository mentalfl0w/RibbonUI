import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import RibbonUI

Item{
    id: control
    implicitHeight: (textLabelPosition === RibbonProgressBar.LabelPosition.Top || textLabelPosition === RibbonProgressBar.LabelPosition.Bottom && showText ?
                         (text_label.contentHeight + textLabelMargin + bar.implicitHeight) : showText && textLabelPosition !== RibbonProgressBar.LabelPosition.None ? Math.max(bar.implicitHeight, text_label.contentHeight) : bar.implicitHeight)
    implicitWidth: bar.implicitWidth + (textLabelPosition === RibbonProgressBar.LabelPosition.Left || textLabelPosition === RibbonProgressBar.LabelPosition.Right && showText ?
                                            (text_label.contentWidth + textLabelMargin) : 0)
    enum LabelPosition {
        None,
        Top,
        Left,
        Right,
        Bottom
    }
    property color indicatorColor: RibbonTheme.isDarkMode ? "#8AAAEB" : "#5DA3E8"
    property color bgColor: RibbonTheme.isDarkMode ? "#6C6C6C" : "#EFEFEF"
    property int barWidth: 200
    property int barHeight: 6
    property bool showText: true
    property int textLabelMargin: textLabelPosition === RibbonProgressBar.LabelPosition.Top || textLabelPosition === RibbonProgressBar.LabelPosition.Bottom ? 0 : 5
    property int animationDurarion: 800
    property int indeterminateWidth: barWidth * 0.25
    property int textLabelPosition: bar.mirrored ? RibbonProgressBar.LabelPosition.Left : RibbonProgressBar.LabelPosition.Right
    property string text: qsTr("Loading")
    property alias value: bar.value
    property alias visualPosition: bar.visualPosition
    property alias position: bar.position
    property alias indeterminate: bar.indeterminate
    property alias bar: bar
    property alias textLabel: text_label

    ProgressBar {
        id: bar
        clip: true
        implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
        implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                 implicitContentHeight + topPadding + bottomPadding)
        anchors{
            left: textLabelPosition === RibbonProgressBar.LabelPosition.Right ? control.left : undefined
            right: textLabelPosition === RibbonProgressBar.LabelPosition.Left ? control.right : undefined
            bottom: textLabelPosition === RibbonProgressBar.LabelPosition.Top ? control.bottom : undefined
            top: textLabelPosition === RibbonProgressBar.LabelPosition.Bottom ? control.top : undefined
            verticalCenter: textLabelPosition === RibbonProgressBar.LabelPosition.Left ||
                            textLabelPosition === RibbonProgressBar.LabelPosition.Right ?
                                control.verticalCenter : undefined
            horizontalCenter: textLabelPosition === RibbonProgressBar.LabelPosition.Top ||
                              textLabelPosition === RibbonProgressBar.LabelPosition.Bottom ?
                                  control.horizontalCenter : undefined
        }

        contentItem: Item{
            id: item
            implicitHeight: barHeight
            implicitWidth: barWidth
            height: implicitHeight
            clip: true
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle{
                    implicitWidth: item.width
                    implicitHeight: item.height
                    radius: item.height / 2
                }
            }
            Rectangle{
                x:0
                anchors.verticalCenter: parent.verticalCenter
                implicitHeight: barHeight
                implicitWidth: {
                    if(!indeterminate)
                    {
                        return barWidth * visualPosition
                    }
                    else
                        return indeterminateWidth
                }
                radius: height / 2
                color: indicatorColor
                PropertyAnimation on x {
                    running: indeterminate && visible
                    from: -indeterminateWidth
                    to:barWidth+indeterminateWidth
                    loops: Animation.Infinite
                    duration: animationDurarion
                    easing.type: Easing.OutInQuad
                }
            }
        }

        background: Rectangle {
            implicitWidth: barWidth
            implicitHeight: barHeight
            height: barHeight
            radius: height / 2
            color: bgColor
        }
    }

    RibbonText{
        id: text_label
        viewOnly: true
        text: indeterminate ? control.text : (visualPosition * 100).toFixed(0) + "%"
        visible: showText
        anchors{
            top: textLabelPosition === RibbonProgressBar.LabelPosition.Bottom ? bar.bottom : undefined
            topMargin: textLabelPosition === RibbonProgressBar.LabelPosition.Bottom ? textLabelMargin : 0
            right: textLabelPosition === RibbonProgressBar.LabelPosition.Left ? bar.left : undefined
            rightMargin: textLabelPosition === RibbonProgressBar.LabelPosition.Left ? textLabelMargin : 0
            left: textLabelPosition === RibbonProgressBar.LabelPosition.Right ? bar.right : undefined
            leftMargin: textLabelPosition === RibbonProgressBar.LabelPosition.Right ? textLabelMargin : 0
            bottom: textLabelPosition === RibbonProgressBar.LabelPosition.Top ? bar.top : undefined
            bottomMargin: textLabelPosition === RibbonProgressBar.LabelPosition.Top ? textLabelMargin : 0
            verticalCenter: textLabelPosition === RibbonProgressBar.LabelPosition.Left ||
                            textLabelPosition === RibbonProgressBar.LabelPosition.Right ?
                                bar.verticalCenter : undefined
            horizontalCenter: textLabelPosition === RibbonProgressBar.LabelPosition.Top ||
                              textLabelPosition === RibbonProgressBar.LabelPosition.Bottom ?
                                  bar.horizontalCenter : undefined
        }
    }
}
