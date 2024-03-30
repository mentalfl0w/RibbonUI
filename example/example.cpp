#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/qqmlextensionplugin.h>
#include "ribbonui.h"

#ifdef RIBBONUI_BUILD_STATIC_LIB
Q_IMPORT_QML_PLUGIN(RibbonUIPlugin)
#endif
int main(int argc, char *argv[])
{
    RibbonUI::init(); // Must set before QGuiApplication
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    RibbonUI::registerTypes(&engine);
    const QUrl url(u"qrc:/qt/qml/RibbonUIAPP/example.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
