#ifndef LOCALIZATION_H
#define LOCALIZATION_H

#include <QObject>
#include <QQmlEngine>
#include "ribbonlocalization.h"

class Localization : public RibbonLocalization
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    RIBBON_SINGLETON(Localization)
public:
    virtual void loadCurrentLanguage() override;
    virtual void saveCurrentLanguage(const QString &language)override;
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
private:
#endif
    Localization() = default;
    ~Localization() = default;
};

#endif // LOCALIZATION_H
