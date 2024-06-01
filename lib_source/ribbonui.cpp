#include "ribbonui.h"
#include <QMutex>
#include <QOperatingSystemVersion>
#include <QWKQuick/qwkquickglobal.h>
#include <QtQuick/QQuickWindow>
#include <QGuiApplication>
#include "ribbonui_version.h"

RibbonUI::RibbonUI(QQuickItem *parent)
    : QQuickItem(parent)
{
    _version = RIBBONUI_VERSION;
    _qtVersion = QString(qVersion()).replace('.',"").toInt();
    _isWin11 = QOperatingSystemVersion::current() >= QOperatingSystemVersion(QOperatingSystemVersion::Windows, 10, 0, 22000);
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
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
}

void RibbonUI::registerTypes(const char *uri)
{
    Q_UNUSED(uri);
    QWK::registerTypes(nullptr);
}
