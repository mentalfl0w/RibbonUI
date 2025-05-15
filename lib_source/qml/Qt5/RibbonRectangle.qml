import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15
import QtGraphicalEffects 1.15

Item {
    id: control
    property string color
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

    Shape {
        id: shape
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4 // Workaround for Qt 6.5 and below, for Qt 6.6, just set "preferredRendererType" to "Shape.CurveRenderer"
        ShapePath {
            capStyle: ShapePath.RoundCap
            strokeWidth: 0
            strokeColor: "transparent"
            fillColor: control.color
            joinStyle: ShapePath.RoundJoin
            startX: control.topLeftRadius; startY: 0
            PathLine { x: shape.width - control.topRightRadius; y: 0 }
            PathArc { x: shape.width; y: control.topRightRadius; radiusX: control.topRightRadius; radiusY: radiusX }
            PathLine { x: shape.width; y: shape.height - control.bottomRightRadius }
            PathArc { x: shape.width - control.bottomRightRadius; y: shape.height; radiusX: control.bottomRightRadius; radiusY: radiusX }
            PathLine { x: control.bottomLeftRadius; y: shape.height }
            PathArc { x: 0; y: shape.height - control.bottomLeftRadius; radiusX: control.bottomLeftRadius; radiusY: radiusX }
            PathLine { x: 0; y: control.topLeftRadius }
            PathArc { x: control.topLeftRadius; y: 0; radiusX: control.topLeftRadius; radiusY: radiusX }
        }
    }

    Shape {
        id: border
        width: shape.width
        height: shape.height
        anchors.centerIn: parent
        layer.enabled: true
        layer.samples: 4
        ShapePath {
            capStyle: ShapePath.RoundCap
            strokeWidth: control.borderWidth * 2
            strokeColor: control.borderColor
            fillColor: "transparent"
            joinStyle: ShapePath.RoundJoin
            startX: control.topLeftRadius; startY: 0
            PathLine { x: border.width - control.topRightRadius; y: 0 }
            PathArc { x: border.width; y: control.topRightRadius; radiusX: control.topRightRadius; radiusY: radiusX }
            PathLine { x: border.width; y: border.height - control.bottomRightRadius }
            PathArc { x: border.width - control.bottomRightRadius; y: border.height; radiusX: control.bottomRightRadius; radiusY: radiusX }
            PathLine { x: control.bottomLeftRadius; y: border.height }
            PathArc { x: 0; y: border.height - control.bottomLeftRadius; radiusX: control.bottomLeftRadius; radiusY: radiusX }
            PathLine { x: 0; y: control.topLeftRadius }
            PathArc { x: control.topLeftRadius; y: 0; radiusX: control.topLeftRadius; radiusY: radiusX }
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
            implicitHeight: container.height
            implicitWidth: container.width
            maskSource: shape
            invert: control.color === "transparent" || control.color === "#00000000"
        }
    }
}
