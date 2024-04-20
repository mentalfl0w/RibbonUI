#ifndef PLATFORMSUPPORT_H
#define PLATFORMSUPPORT_H
#include <QQuickItem>
#include <QWindow>
#include <QMutex>

class PlatformSupport : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    QML_NAMED_ELEMENT(PlatformSupport)
public:
    static PlatformSupport* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
    static PlatformSupport* instance(){
        static QMutex mutex;
        QMutexLocker locker(&mutex);

        static PlatformSupport *singleton = nullptr;
        if (!singleton) {
            singleton = new PlatformSupport();
        }
        return singleton;
    }
#ifdef Q_OS_MACOS
    Q_INVOKABLE void showSystemTitleBtns(QWindow *window, bool enable);
#endif
private:
    PlatformSupport(QObject *parent = nullptr) : QObject(parent){}
    Q_DISABLE_COPY_MOVE(PlatformSupport)
};

#endif // PLATFORMSUPPORT_H
