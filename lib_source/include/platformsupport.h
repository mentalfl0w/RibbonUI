#ifndef PLATFORMSUPPORT_H
#define PLATFORMSUPPORT_H

#include <QWindow>
#include "ribbonsingleton.h"

class PlatformSupport : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    RIBBON_SINGLETON(PlatformSupport)
public:
#ifdef Q_OS_MACOS
    Q_INVOKABLE void showSystemTitleBtns(QWindow *window, bool enable);
#endif
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
private:
#endif
    PlatformSupport(QObject *parent = nullptr) : QObject(parent){}
private:
    bool bindEngine(){return bindEngineBegin();};
};
#endif // PLATFORMSUPPORT_H
