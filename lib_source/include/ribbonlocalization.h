#ifndef RIBBONLOCALIZATION_H
#define RIBBONLOCALIZATION_H

#include <QQuickItem>
#include <QLocale>
#include <QTranslator>

class RibbonLocalization : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    QML_NAMED_ELEMENT(RibbonLocalization)
    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged FINAL)
public:
    typedef QPair<QString, QString> LangItem; // example: <"zh_CN", "qrc://i18n/xxx_zh_CN.qm">
    typedef QMap<QString, QSharedPointer<QTranslator>> Translator; // example: <"main", mainTranslator>
    typedef QMap<LangItem, QString> ModuleTranslator; // example: <zhItem, "main">
    static RibbonLocalization* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
    static RibbonLocalization* instance();
    Q_INVOKABLE bool registerLanguage(QString langName, QString path, QString moduleName);
    Q_INVOKABLE bool removeLanguage(QString langName, QString path);
    Q_INVOKABLE void bindEngine();
    Q_INVOKABLE QList<QString> languageList();
    QString currentLanguage();
    bool setCurrentLanguage(QString langName);
    // Use if you need to directly save/load language from config files
    Q_INVOKABLE virtual void loadCurrentLanguage(){};
    virtual bool saveCurrentLanguage(const QString &language){return false;};
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
private:
    Q_DISABLE_COPY_MOVE(RibbonLocalization)
#endif
    RibbonLocalization();
    ~RibbonLocalization();
private:
    ModuleTranslator moduleLangList;
    Translator transList;
    QString _currentLang;
signals:
    void currentLanguageChanged();
};

#endif // RIBBONLOCALIZATION_H
