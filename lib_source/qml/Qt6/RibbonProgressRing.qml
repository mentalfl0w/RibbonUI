import QtQuick
import RibbonUI

RibbonProgressBar {
    id: control
    barWidth: centerInTextLabel && showText ? Math.max(textLabel.contentWidth + ringWidth * 2 + textLabelMargin * 2, 50) : 50
    barHeight: barWidth
    animationDurarion: 2000
    property real ringWidth: 6
    property bool centerInTextLabel: false

    QtObject{
        id: private_property
        property var backup_anchors
        property var backup_position
        property real radius: control.barWidth/2-control.ringWidth/2
    }

    Connections{
        target: RibbonTheme
        function onIsDarkModeChanged(){
            canvas.requestPaint()
        }
    }

    bar.background: Rectangle {
        implicitWidth: barWidth
        implicitHeight: barHeight
        radius: control.width/2
        color:"transparent"
        border.color: control.bgColor
        border.width: control.ringWidth
    }

    onIndeterminateChanged:{
        canvas.requestPaint()
    }

    onVisualPositionChanged: canvas.requestPaint()

    bar.contentItem: Canvas {
        id:canvas
        implicitHeight: barHeight
        implicitWidth: barWidth
        antialiasing: true
        renderTarget: Canvas.Image
        property real startAngle: 0
        property real sweepAngle: 0
        SequentialAnimation on startAngle {
            loops: Animation.Infinite
            running: control.visible && control.indeterminate
            PropertyAnimation { from: 0; to: 450; duration: control.animationDurarion/2; easing.type: Easing.OutSine }
            PropertyAnimation { from: 450; to: 1080; duration: control.animationDurarion/2; easing.type: Easing.OutSine }
        }
        SequentialAnimation on sweepAngle {
            loops: Animation.Infinite
            running: control.visible && control.indeterminate
            PropertyAnimation { from: 0; to: 180; duration: control.animationDurarion/2; easing.type: Easing.OutSine }
            PropertyAnimation { from: 180; to: 0; duration: control.animationDurarion/2; easing.type: Easing.OutSine }
        }
        onStartAngleChanged: {
            requestPaint()
        }
        onPaint: {
            var ctx = canvas.getContext("2d")
            ctx.clearRect(0, 0, canvas.width, canvas.height)
            ctx.save()
            ctx.lineWidth = control.ringWidth
            ctx.strokeStyle = control.indicatorColor
            ctx.lineCap = "round"
            ctx.beginPath()
            if(control.indeterminate){
                ctx.arc(width/2, height/2, private_property.radius , Math.PI * (startAngle - 90) / 180,  Math.PI * (startAngle - 90 + sweepAngle) / 180)
            }else{
                ctx.arc(width/2, height/2, private_property.radius , -0.5 * Math.PI , -0.5 * Math.PI + (control.indeterminate ? 0.0 :  control.visualPosition) * 2 * Math.PI)
            }
            ctx.stroke()
            ctx.closePath()
        }
    }

    onCenterInTextLabelChanged: {
        if(centerInTextLabel){
            private_property.backup_anchors = textLabel.anchors
            private_property.backup_position = textLabelPosition
            textLabel.anchors.top = undefined
            textLabel.anchors.left = undefined
            textLabel.anchors.right = undefined
            textLabel.anchors.bottom = undefined
            textLabel.anchors.horizontalCenter = undefined
            textLabel.anchors.verticalCenter = undefined
            textLabel.anchors.centerIn = control
            textLabelPosition = RibbonProgressBar.LabelPosition.None
        }
        else{
            textLabel.anchors = private_property.backup_anchors
            textLabelPosition = private_property.backup_position
        }
    }
}
