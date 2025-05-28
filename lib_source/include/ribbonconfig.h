#ifndef RIBBONCONFIG_H
#define RIBBONCONFIG_H

#include <QVariant>
#include <QSettings>
#include "ribbonsingleton.h"

class RibbonConfig : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    RIBBON_SINGLETON(RibbonConfig)
public:
    Q_INVOKABLE void set(QString qstrnodename,QString qstrkeyname,QVariant qvarvalue);
    Q_INVOKABLE void setArray(QString qstrnodename,QString qstrkeyname,QVariant qvarvalue);
    Q_INVOKABLE QVariant get(QString qstrnodename,QString qstrkeyname);
    Q_INVOKABLE QVariant getArray(QString qstrnodename,QString qstrkeyname);
    void clear();

#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
private:
#endif
    explicit RibbonConfig(QString qstrfilename = "");
    ~RibbonConfig() override;
protected:
    virtual bool bindEngine(){return bindEngineBegin();};
    QString qstrFileName;
    QSettings *setting=nullptr;
    QMutex mutex;
};
#endif // RIBBONCONFIG_H

