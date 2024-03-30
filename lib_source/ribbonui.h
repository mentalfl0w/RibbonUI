#ifndef RIBBONUI_H
#define RIBBONUI_H

#include <QQuickItem>
#include "definitions.h"
#include <FramelessHelper/Quick/framelessquickmodule.h>
#include <FramelessHelper/Core/private/framelessconfig_p.h>

FRAMELESSHELPER_USE_NAMESPACE
class RibbonUI : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    QML_NAMED_ELEMENT(RibbonUI)
    Q_PROPERTY_RW(QString, version)
    Q_PROPERTY_RW(int, qt_version)
public:
    static RibbonUI* instance();
    static RibbonUI* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
    static void init();
    static void registerTypes(QQmlEngine *qmlEngine);
private:
    explicit RibbonUI(QQuickItem *parent = nullptr);
    Q_DISABLE_COPY_MOVE(RibbonUI)
};

#endif // RIBBONUI_H
