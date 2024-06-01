import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: control
    property string color
    property int radius: 0
    property int topLeftRadius: radius
    property int topRightRadius: radius
    property int bottomLeftRadius: radius
    property int bottomRightRadius: radius
    default property alias contentItem: container.data
    onWidthChanged: {
        canvas.requestPaint()
    }
    onHeightChanged: {
        canvas.requestPaint()
    }
    onTopLeftRadiusChanged: {
        canvas.requestPaint()
    }
    onTopRightRadiusChanged: {
        canvas.requestPaint()
    }
    onBottomLeftRadiusChanged: {
        canvas.requestPaint()
    }
    onBottomRightRadiusChanged: {
        canvas.requestPaint()
    }
    onColorChanged: {
        canvas.requestPaint()
    }
    Canvas {
        id: canvas
        anchors.fill: parent
        visible: false
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.beginPath()
            ctx.moveTo(control.topLeftRadius, 0)
            ctx.lineTo(width - control.topRightRadius, 0)
            ctx.arcTo(width, 0, width, control.topRightRadius, control.topRightRadius)
            ctx.lineTo(width, height - control.bottomRightRadius)
            ctx.arcTo(width, height, width - control.bottomRightRadius, height, control.bottomRightRadius)
            ctx.lineTo(control.bottomLeftRadius, height)
            ctx.arcTo(0, height, 0, height - control.bottomLeftRadius, control.bottomLeftRadius)
            ctx.lineTo(0, control.topLeftRadius)
            ctx.arcTo(0, 0, control.topLeftRadius, 0, control.topLeftRadius)
            ctx.closePath()
            ctx.fillStyle = control.color
            ctx.fill()
        }
    }
    Rectangle {
        id: container
        anchors.fill: parent
        color: control.color
        opacity: 0
    }
    OpacityMask {
        anchors.fill: parent
        source: container
        maskSource: canvas
        invert: control.color === "transparent" || control.color === "#00000000"
    }
}
