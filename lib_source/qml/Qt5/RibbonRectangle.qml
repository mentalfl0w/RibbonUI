import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtGraphicalEffects 1.15

Item {
    id: control
    property color color
    property int radius: 0
    property int topLeftRadius: radius
    property int topRightRadius: radius
    property int bottomLeftRadius: radius
    property int bottomRightRadius: radius
    property int topPadding: 0
    property int leftPadding: 0
    property int rightPadding: 0
    property int bottomPadding: 0
    property real borderWidth: 0
    property string borderColor: "transparent"
    default property alias contentItem: container.data

    onColorChanged: shape.requestPaint()
    onBorderColorChanged: border.requestPaint()

    Canvas {
        id: shape
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var tl = control.topLeftRadius;
            var tr = control.topRightRadius;
            var br = control.bottomRightRadius;
            var bl = control.bottomLeftRadius;

            ctx.beginPath();
            ctx.moveTo(tl, 0);
            ctx.lineTo(width - tr, 0);
            ctx.arc(width - tr, tr, tr, -Math.PI / 2, 0, false); // top-right
            ctx.lineTo(width, height - br);
            ctx.arc(width - br, height - br, br, 0, Math.PI / 2, false); // bottom-right
            ctx.lineTo(bl, height);
            ctx.arc(bl, height - bl, bl, Math.PI / 2, Math.PI, false); // bottom-left
            ctx.lineTo(0, tl);
            ctx.arc(tl, tl, tl, Math.PI, Math.PI * 3 / 2, false); // top-left
            ctx.closePath();

            ctx.fillStyle = control.color;
            ctx.fill();
        }
    }

    Canvas {
        id: border
        width: shape.width
        height: shape.height
        anchors.centerIn: parent
        layer.enabled: true
        layer.samples: 4

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var tl = control.topLeftRadius;
            var tr = control.topRightRadius;
            var br = control.bottomRightRadius;
            var bl = control.bottomLeftRadius;

            ctx.beginPath();
            ctx.moveTo(tl, 0);
            ctx.lineTo(width - tr, 0);
            ctx.arc(width - tr, tr, tr, -Math.PI / 2, 0, false); // top-right
            ctx.lineTo(width, height - br);
            ctx.arc(width - br, height - br, br, 0, Math.PI / 2, false); // bottom-right
            ctx.lineTo(bl, height);
            ctx.arc(bl, height - bl, bl, Math.PI / 2, Math.PI, false); // bottom-left
            ctx.lineTo(0, tl);
            ctx.arc(tl, tl, tl, Math.PI, Math.PI * 3 / 2, false); // top-left
            ctx.closePath();

            ctx.strokeStyle = control.borderColor;
            ctx.lineWidth = control.borderWidth * 2;
            ctx.stroke();
        }
    }

    Item{
        id: container
        anchors{
            fill: parent
            topMargin: control.topPadding
            bottomMargin: control.bottomPadding
            leftMargin: control.leftPadding
            rightMargin: control.rightPadding
        }
        clip: true
        layer.enabled: true
        layer.effect: OpacityMask {
            visible: false
            implicitHeight: container.height
            implicitWidth: container.width
            maskSource: shape
            invert: control.color.a === 0
        }
    }
}
