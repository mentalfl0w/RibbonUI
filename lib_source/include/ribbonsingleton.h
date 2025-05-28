#ifndef RIBBONSINGLETON_H
#define RIBBONSINGLETON_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QMutex>
#include <QTimer>
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
#include "ribbonui_version.h"
#endif

#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
#define RIBBON_SINGLETON(X)                                                                     \
public:                                                                                         \
    static X* create (QQmlEngine *qmlEngine, QJSEngine *jsEngine){return getInstance();}        \
    static X* getInstance(){                                                                    \
        static QMutex mutex;                                                                    \
        QMutexLocker locker(&mutex);                                                            \
        static X *singleton = nullptr;                                                          \
        if (!singleton || needRefresh) {                                                        \
            needRefresh() = false;                                                              \
            if(getTypeId() == -1 || !getEngine())                                               \
                singleton = new X();                                                            \
            else                                                                                \
                singleton = getEngine()->singletonInstance<X *>(getTypeId());                   \
        }                                                                                       \
        return singleton;                                                                       \
    };                                                                                          \
    static void destroy(){                                                                      \
        needRefresh() = true;                                                                   \
        X::getInstance()->~X();                                                                 \
    };                                                                                          \
protected:                                                                                      \
    static int getTypeId(){                                                                     \
        static int typeId = -1;                                                                 \
        if(typeId == -1){                                                                       \
            QString version(RIBBONUI_VERSION);                                                  \
            QStringList versionList = version.split('.');                                       \
            typeId = qmlTypeId("RibbonUI", versionList[0].toInt(),                              \
                        versionList[1].toInt(), staticMetaObject.className());                  \
        }                                                                                       \
        return typeId;                                                                          \
    };                                                                                          \
    static QQmlApplicationEngine*& getEngine(){                                                 \
        static QQmlApplicationEngine* engine = nullptr;                                         \
        return engine;                                                                          \
    }                                                                                           \
    static bool& needRefresh(){                                                                 \
        static bool need = false;                                                               \
        return need;                                                                            \
    }                                                                                           \
    bool bindEngineBegin(){                                                                     \
        QQmlApplicationEngine* &engine = getEngine();                                           \
        engine = dynamic_cast<QQmlApplicationEngine*>(qmlEngine(this));                         \
        if (!engine){                                                                           \
            dynamic_cast<X*>(this)->~X();                                                       \
            return false;                                                                       \
        }                                                                                       \
        return true;                                                                            \
    };                                                                                          \
    void initialBind(){                                                                         \
        QTimer::singleShot(1, this, &X::bindEngine);                                            \
    };
#else
#define RIBBON_SINGLETON(X)                                                                     \
public:                                                                                         \
    static X* create (QQmlEngine *qmlEngine, QJSEngine *jsEngine){return getInstance();}        \
    static X* getInstance(){                                                                    \
        static QMutex mutex;                                                                    \
        QMutexLocker locker(&mutex);                                                            \
        static X *singleton = nullptr;                                                          \
        if (!singleton) {                                                                       \
            singleton = new X();                                                                \
        }                                                                                       \
        return singleton;                                                                       \
    };                                                                                          \
    static void destroy(){                                                                      \
        X::getInstance()->~X();                                                                 \
    };                                                                                          \
protected:                                                                                      \
    bool bindEngineBegin(){                                                             \
        QQmlApplicationEngine *engine = dynamic_cast<QQmlApplicationEngine*>(qmlEngine(this));  \
        if (!engine){                                                                           \
            return false;                                                                       \
        }                                                                                       \
        return true;                                                                            \
    };                                                                                          \
    void initialBind(){QTimer::singleShot(1000, this, &X::bindEngine);};                    \
private:                                                                                        \
    Q_DISABLE_COPY_MOVE(X)
#endif
#endif // RIBBONSINGLETON_H
