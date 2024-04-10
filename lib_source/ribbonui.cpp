#include "ribbonui.h"
#include <QMutex>
#include <QOperatingSystemVersion>
#define STR(x) #x
#define JOIN(a,b,c) STR(a.b.c)
#define VER_JOIN(x) JOIN x

RibbonUI::RibbonUI(QQuickItem *parent)
    : QQuickItem(parent)
{
    _version = VER_JOIN((RIBBONUI_VERSION));
    _qt_version = QString(qVersion()).replace('.',"").toInt();
    _is_win11 = QOperatingSystemVersion::current() >= QOperatingSystemVersion(QOperatingSystemVersion::Windows, 10, 0, 22000);
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
#ifdef Q_OS_WINDOWS
    FramelessConfig::instance()->set(Global::Option::ForceNonNativeBackgroundBlur);
    FramelessConfig::instance()->set(Global::Option::DisableLazyInitializationForMicaMaterial);
    if(QOperatingSystemVersion::current() < QOperatingSystemVersion(QOperatingSystemVersion::Windows, 10, 0, 22000))
        FramelessConfig::instance()->set(Global::Option::WindowUseRoundCorners);
#endif
    FramelessConfig::instance()->set(Global::Option::ForceHideWindowFrameBorder);
    FramelessConfig::instance()->set(Global::Option::CenterWindowBeforeShow);
    FramelessConfig::instance()->set(Global::Option::EnableBlurBehindWindow);
}

void RibbonUI::registerTypes(QQmlEngine *qmlEngine)
{
    FramelessHelper::Quick::registerTypes(qmlEngine);
}
