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
public:
    explicit RibbonUI(QQuickItem *parent = nullptr);
    static RibbonUI* instance();
};

#endif // RIBBONUI_H
