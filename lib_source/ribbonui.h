#ifndef RIBBONUI_H
#define RIBBONUI_H

#include <QQuickItem>
#include "definitions.h"

class RibbonUI : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    QML_NAMED_ELEMENT(RibbonUI)
    Q_PROPERTY_R(QString, version)
    Q_PROPERTY_R(int, qt_version)
    Q_PROPERTY_R(int, is_win11)
    Q_PROPERTY_RW(QVariantMap, windowsSet)
public:
    static RibbonUI* instance();
    static RibbonUI* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
    RIBBONUI_API static void init();
    RIBBONUI_API static void registerTypes(QQmlEngine *qmlEngine);
private:
    explicit RibbonUI(QQuickItem *parent = nullptr);
    Q_DISABLE_COPY_MOVE(RibbonUI)
};

#endif // RIBBONUI_H
