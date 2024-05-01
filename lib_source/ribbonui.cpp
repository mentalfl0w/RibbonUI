#include "ribbonui.h"
#include <QMutex>
#include <QOperatingSystemVersion>
#include <QWKQuick/qwkquickglobal.h>
#include <QtQuick/QQuickWindow>
#define STR(x) #x
#define JOIN(a,b,c) STR(a.b.c)
#define VER_JOIN(x) JOIN(x)

RibbonUI::RibbonUI(QQuickItem *parent)
    : QQuickItem(parent)
{
    _version = VER_JOIN(RIBBONUI_VERSION);
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
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
    qputenv("QT_QUICK_CONTROLS_STYLE", "Basic");
#else
    qputenv("QT_QUICK_CONTROLS_STYLE", "Default");
#endif
#ifdef Q_OS_WIN
    qputenv("QSG_RHI_BACKEND", "opengl");
#endif
    QQuickWindow::setDefaultAlphaBuffer(true);
}

void RibbonUI::registerTypes(QQmlEngine *qmlEngine)
{
    QWK::registerTypes(qmlEngine);
}
