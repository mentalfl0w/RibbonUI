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
    Q_DISABLE_COPY(RibbonUI)
    Q_PROPERTY_RW(QString, version)
public:
    static RibbonUI* instance();
    static RibbonUI* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
private:
    explicit RibbonUI(QQuickItem *parent = nullptr);
};

#endif // RIBBONUI_H
