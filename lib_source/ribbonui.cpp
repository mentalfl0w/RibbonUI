#include "ribbonui.h"
#include <QMutex>
#define STR(x) #x
#define JOIN(a,b,c,d) STR(a.b.c.d)
#define VER_JOIN(x) JOIN x

RibbonUI::RibbonUI(QQuickItem *parent)
    : QQuickItem(parent)
{
    version(VER_JOIN((RIBBONUI_VERSION)));
}

RibbonUI* RibbonUI::instance(){
    static QMutex mutex;
    QMutexLocker locker(&mutex);

    static RibbonUI *singleton = nullptr;
    if (!singleton) {
        singleton = new RibbonUI();
    }
    return singleton;
}
