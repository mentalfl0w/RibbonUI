#ifndef RIBBONLOCALIZATION_H
#define RIBBONLOCALIZATION_H

#include <QLocale>
#include <QTranslator>
#include "ribbonsingleton.h"
#include "definitions.h"

class RIBBONUI_API RibbonLocalization : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged FINAL)
    Q_PROPERTY_RW(bool, enabled);
    RIBBON_SINGLETON(RibbonLocalization)
public:
    typedef QPair<QString, QString> LangItem; // example: <"zh_CN", "qrc://i18n/xxx_zh_CN.qm">
    typedef QMap<QString, QSharedPointer<QTranslator>> Translator; // example: <"main", mainTranslator>
    typedef QMap<LangItem, QString> ModuleTranslator; // example: <zhItem, "main">
    Q_INVOKABLE bool registerLanguage(QString langName, QString path, QString moduleName);
    Q_INVOKABLE bool removeLanguage(QString langName, QString path);
    Q_INVOKABLE QList<QString> languageList();
    Q_INVOKABLE QString languageTranslate(QString langStr);
    QString currentLanguage();
    bool setCurrentLanguage(QString langName);
    // Use if you need to directly save/load language from config files
    virtual void loadCurrentLanguage(){};
    virtual void saveCurrentLanguage(const QString &language){};
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
protected:
#endif
    RibbonLocalization();
    virtual ~RibbonLocalization() override;
protected:
    virtual bool bindEngine();
    virtual void switchState();
    ModuleTranslator moduleLangList;
    Translator transList;
    QString _currentLang;
    const QMap<QString, const char*> langList = {
        {"zh_CN", QT_TRANSLATE_NOOP("langList", "zh_CN")},
        {"zh_TW", QT_TRANSLATE_NOOP("langList", "zh_TW")},
        {"en_US", QT_TRANSLATE_NOOP("langList", "en_US")},
        {"en_UK", QT_TRANSLATE_NOOP("langList", "en_UK")},
    };
signals:
    void currentLanguageChanged();
    void registerLanguageFinished();
};
#endif // RIBBONLOCALIZATION_H
