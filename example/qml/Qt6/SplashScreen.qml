import QtQuick
import RibbonUI

RibbonSplashScreen {
    id: root
    homeUrl: "qrc:/qt/qml/RibbonUIAPP/example.qml"
    delayMS: 10000
    contentArgs: {
        "implicitHeight": 250,
        "implicitWidth": 450,
        "titleText": qsTr("Example App"),
        "subTitleText": qsTr("A example for users to use RibbonUI.")
    }

    Timer{
        interval: 1000
        triggeredOnStart: true
        repeat: true
        running: true
        property int remainSeconds: root.delayMS / 1000
        onTriggered: {
            remainSeconds -= 1
            root.showLoadingLog(qsTr("Loading...Remain %1s...").arg(remainSeconds), {})
        }
    }
}
