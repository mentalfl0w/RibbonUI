#ifndef RIBBONUI_H
#define RIBBONUI_H

#include "ribbonsingleton.h"
#include "definitions.h"
#include "ribbonlocalization.h"

class RibbonUI : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY_R(QString, version)
    Q_PROPERTY_R(int, qtVersion)
    Q_PROPERTY_R(int, isWin11)
    Q_PROPERTY_RW(QVariantMap, windowsSet)
    Q_PROPERTY(bool autoLoadLanguage READ autoLoadLanguage WRITE setAutoLoadLanguage NOTIFY autoLoadLanguageChanged FINAL)

    RIBBON_SINGLETON(RibbonUI)
public:
    RIBBONUI_API static void init();
    RIBBONUI_API static void registerTypes(const char *uri);
    RIBBONUI_API Q_INVOKABLE void setTranslator(RibbonLocalization *translator = RibbonLocalization::getInstance());
    Q_INVOKABLE void initTranslator();
    bool autoLoadLanguage(){return _autoLoadLanguage;};
    void setAutoLoadLanguage(bool value);
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    Q_INVOKABLE QColor color(QString colorName);
    Q_INVOKABLE QColor alpha(QString colorName, float alpha = 1);
public:
#else
private:
#endif
    explicit RibbonUI(QObject *parent = nullptr);
private:
    bool bindEngine(){return bindEngineBegin();};
    RibbonLocalization* _translator = nullptr;
    bool _autoLoadLanguage = false;

signals:
    void autoLoadLanguageChanged();
    void initTranslatorFinished();
};

#endif // RIBBONUI_H
