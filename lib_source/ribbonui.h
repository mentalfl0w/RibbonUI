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
    Q_PROPERTY_RW(QString, version)
    Q_PROPERTY_RW(int, qt_version)
public:
    static RibbonUI* instance();
    static RibbonUI* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
private:
    explicit RibbonUI(QQuickItem *parent = nullptr);
    Q_DISABLE_COPY_MOVE(RibbonUI)
};

#endif // RIBBONUI_H
