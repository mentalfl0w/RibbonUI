#include "ribbonui.h"
#include <QMutex>
#define STR(x) #x
#define JOIN(a,b,c) STR(a.b.c)
#define VER_JOIN(x) JOIN x

RibbonUI::RibbonUI(QQuickItem *parent)
    : QQuickItem(parent)
{
    version(VER_JOIN((RIBBONUI_VERSION)));
    qt_version(QString(qVersion()).replace('.',"").toInt());
}

RibbonUI* RibbonUI::instance(){
    static QMutex mutex;
    QMutexLocker locker(&mutex);

    static RibbonUI *singleton = nullptr;
    if (!singleton) {
        singleton = new RibbonUI();
    }
    return singleton;
}

void RibbonUI::init()
{
    qputenv("QT_QUICK_CONTROLS_STYLE","Basic");
    FramelessHelper::Quick::initialize();
#ifdef Q_OS_WIN
    FramelessConfig::instance()->set(Global::Option::ForceHideWindowFrameBorder);
#endif
    FramelessConfig::instance()->set(Global::Option::DisableLazyInitializationForMicaMaterial);
    FramelessConfig::instance()->set(Global::Option::CenterWindowBeforeShow);
    FramelessConfig::instance()->set(Global::Option::EnableBlurBehindWindow);
}

void RibbonUI::registerTypes(QQmlEngine *qmlEngine)
{
    FramelessHelper::Quick::registerTypes(qmlEngine);
}
