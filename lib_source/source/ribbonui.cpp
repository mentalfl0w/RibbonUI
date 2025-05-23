#include "ribbonui.h"
#include <QMutex>
#include <QOperatingSystemVersion>
#include <QWKQuick/qwkquickglobal.h>
#include <QtQuick/QQuickWindow>
#include <QGuiApplication>
#include <QDir>
#include "ribbonui_version.h"

RibbonUI::RibbonUI(QQuickItem *parent)
    : QQuickItem(parent)
{
    _version = RIBBONUI_VERSION;
    _qtVersion = QString(qVersion()).replace('.',"").toInt();
    _isWin11 = QOperatingSystemVersion::current() >= QOperatingSystemVersion(QOperatingSystemVersion::Windows, 10, 0, 22000);
    _translator = RibbonLocalization::instance();
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
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(
        Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
}

void RibbonUI::registerTypes(const char *uri)
{
    Q_UNUSED(uri);
    QWK::registerTypes(nullptr);
}

void RibbonUI::setTranslator(RibbonLocalization *translator){
    _translator = translator;
    initTranslator();
}

void RibbonUI::initTranslator(){
    QDir dir(":/i18n");
    QStringList filters;
    filters<<"*.qm";
    dir.setNameFilters(filters);
    QStringList matchedFiles = dir.entryList();
    for(auto file : matchedFiles){
        QString project, lang;
        int start = 0;
        int end = file.indexOf('_');

        if (end > start)
            project = file.mid(start, end - start);

        start = file.indexOf('_') + 1;
        end = file.lastIndexOf('.');
        if (start > 0 && end > start)
            lang = file.mid(start, end - start);

        if(!lang.isEmpty() && !project.isEmpty()){
            if(_autoLoadLanguage || (!_autoLoadLanguage && project == "RibbonUI")){
                _translator->registerLanguage(lang, ":/i18n/" + file, project);
                continue;
            }
        }
    }
}

void RibbonUI::setAutoLoadLanguage(bool value){
    _autoLoadLanguage = value;
    initTranslator();
}

#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
Q_INVOKABLE QColor RibbonUI::color(QString colorName){
    return QColor(colorName);
}

Q_INVOKABLE QColor RibbonUI::alpha(QString colorName, float alpha){
    QColor c(colorName);
    if(alpha > 1)
        c.setAlpha(alpha);
    else
        c.setAlphaF(alpha);
    return c;
}
#endif
