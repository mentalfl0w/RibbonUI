#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/qqmlextensionplugin.h>
#include <FramelessHelper/Quick/framelessquickmodule.h>
#include <FramelessHelper/Core/private/framelessconfig_p.h>

FRAMELESSHELPER_USE_NAMESPACE
#ifdef RIBBONUI_BUILD_STATIC_LIB
Q_IMPORT_QML_PLUGIN(RibbonUIPlugin)
#endif
int main(int argc, char *argv[])
{
    qputenv("QT_QUICK_CONTROLS_STYLE","Basic");
    FramelessHelper::Quick::initialize();
    QGuiApplication app(argc, argv);

#ifdef Q_OS_WIN
    FramelessConfig::instance()->set(Global::Option::ForceHideWindowFrameBorder);
#endif
    FramelessConfig::instance()->set(Global::Option::DisableLazyInitializationForMicaMaterial);
    FramelessConfig::instance()->set(Global::Option::CenterWindowBeforeShow);
    FramelessConfig::instance()->set(Global::Option::EnableBlurBehindWindow);

    QQmlApplicationEngine engine;
    FramelessHelper::Quick::registerTypes(&engine);
    const QUrl url(u"qrc:/qt/qml/RibbonUIAPP/example.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
