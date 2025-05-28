#include "ribbonconfig.h"
#include <QCoreApplication>
#include <QDebug>

RibbonConfig::RibbonConfig(QString qstrfilename):
    QObject(nullptr)
{
    if (qstrfilename.isEmpty())
    {
        qstrFileName = QCoreApplication::applicationDirPath() + "/config.ini";
    }
    else
    {
        qstrFileName = qstrfilename;
    }

    setting = new QSettings(qstrFileName, QSettings::IniFormat);
    initialBind();
}

RibbonConfig::~RibbonConfig()
{
    delete setting;
    setting = nullptr;
}

void RibbonConfig::set(QString qstrnodename,QString qstrkeyname,QVariant qvarvalue)
{
    QMutexLocker locker(&mutex);
    setting->setValue(QString("/%1/%2").arg(qstrnodename, qstrkeyname), qvarvalue);
}

void RibbonConfig::setArray(QString qstrnodename,QString qstrkeyname,QVariant qvarvalue)
{
    QMutexLocker locker(&mutex);
    setting->beginWriteArray(QString("/%1/%2").arg(qstrnodename, qstrkeyname));
    QList<QVariant> list = qvarvalue.toList();
    for (int i = 0; i< list.length(); i++)
    {
        setting->setArrayIndex(i);
        setting->setValue(qstrkeyname, list.at(i));
    }
    setting->endArray();
}

QVariant RibbonConfig::get(QString qstrnodename,QString qstrkeyname)
{
    QMutexLocker locker(&mutex);
    QVariant qvar = setting->value(QString("/%1/%2").arg(qstrnodename, qstrkeyname));
    return qvar;
}

QVariant RibbonConfig::getArray(QString qstrnodename,QString qstrkeyname)
{
    QMutexLocker locker(&mutex);
    QList<QVariant> list;
    int size = setting->beginReadArray(QString("/%1/%2").arg(qstrnodename, qstrkeyname));
    for (int i = 0; i< size; i++)
    {
        setting->setArrayIndex(i);
        list.append(setting->value(qstrkeyname));
    }
    setting->endArray();
    return list;
}

void RibbonConfig::clear()
{
    QMutexLocker locker(&mutex);
    setting->clear();
}
