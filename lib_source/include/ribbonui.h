#ifndef RIBBONUI_H
#define RIBBONUI_H

#include <QQuickItem>
#include "definitions.h"
#include "ribbonlocalization.h"

class RibbonUI : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY_R(QString, version)
    Q_PROPERTY_R(int, qtVersion)
    Q_PROPERTY_R(int, isWin11)
    Q_PROPERTY_RW(QVariantMap, windowsSet)
    Q_PROPERTY(bool autoLoadLanguage READ autoLoadLanguage WRITE setAutoLoadLanguage NOTIFY autoLoadLanguageChanged FINAL)
public:
    static RibbonUI* instance();
    static RibbonUI* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
    RIBBONUI_API static void init();
    RIBBONUI_API static void registerTypes(const char *uri);
    RIBBONUI_API Q_INVOKABLE void setTranslator(RibbonLocalization *translator = RibbonLocalization::instance());
    Q_INVOKABLE void initTranslator();
    bool autoLoadLanguage(){return _autoLoadLanguage;};
    void setAutoLoadLanguage(bool value);
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
private:
    Q_DISABLE_COPY_MOVE(RibbonUI)
#endif
    explicit RibbonUI(QQuickItem *parent = nullptr);
private:
    RibbonLocalization* _translator;
    bool _autoLoadLanguage = false;

signals:
    void autoLoadLanguageChanged();
};

#endif // RIBBONUI_H
