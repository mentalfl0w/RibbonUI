#include "ribbonlocalization.h"
#include <QMutex>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

RibbonLocalization::RibbonLocalization() {
    _currentLang = "en_US";
}

RibbonLocalization::~RibbonLocalization() {
    for (auto item : transList)
        item.clear();
}

RibbonLocalization* RibbonLocalization::instance(){
    static QMutex mutex;
    QMutexLocker locker(&mutex);

    static RibbonLocalization *singleton = nullptr;
    if (!singleton) {
        singleton = new RibbonLocalization();
    }
    return singleton;
}

bool RibbonLocalization::registerLanguage(QString langName, QString path, QString moduleName){
    LangItem temp(langName, path);
    if(!moduleLangList.contains(temp)){
        if(!transList.contains(moduleName)){
            transList.insert(moduleName, QSharedPointer<QTranslator>(new QTranslator));
            if(langName == _currentLang){
                Q_UNUSED(transList[moduleName].get()->load(path));
                qApp->installTranslator(transList[moduleName].get());
            }
        }
        moduleLangList.insert(temp, moduleName);
        return true;
    }
    return false;
}

bool RibbonLocalization::removeLanguage(QString langName, QString path){
    LangItem temp(langName, path);
    if(moduleLangList.contains(temp)){
        if(langName == _currentLang){
            qApp->removeTranslator(transList[moduleLangList[temp]].get());
            _currentLang = "en_US";
            emit currentLanguageChanged();
        }
        transList[moduleLangList[temp]].clear();
        transList.remove(moduleLangList[temp]);
        moduleLangList.remove(temp);
        return true;
    }
    return false;
}

QString RibbonLocalization::currentLanguage(){
    return _currentLang;
}

bool RibbonLocalization::setCurrentLanguage(QString langName){
    bool hasChanged = false;
    QMap<QString, bool> isNeeded;
    for(auto langItem : moduleLangList.keys()){
        if(langItem.first == langName){
            isNeeded[moduleLangList[langItem]] = true;
            Q_UNUSED(transList[moduleLangList[langItem]].get()->load(langItem.second));
            _currentLang = langName;
            qApp->installTranslator(transList[moduleLangList[langItem]].get());;
            hasChanged = true;
        }
        else{
            if(!isNeeded[moduleLangList[langItem]]){
                qApp->removeTranslator(transList[moduleLangList[langItem]].get());
            }
        }
    }
    if(hasChanged){
        saveCurrentLanguage(langName);
        emit currentLanguageChanged();
    }
    return hasChanged;
}

void RibbonLocalization::bindEngine(){
    QQmlApplicationEngine * engine = dynamic_cast<QQmlApplicationEngine*>(qmlEngine(this));
    Q_ASSERT(engine);
    if (!engine)
        return;
    QObject::connect(this, &RibbonLocalization::currentLanguageChanged, engine, [engine]() -> void {
        engine->retranslate();
    });
}

QList<QString> RibbonLocalization::languageList(){
    QList<QString> list;
    QSet<QString> set;
    for(auto langItem : moduleLangList.keys()){
        set.insert(langItem.first);
    }
    for(auto setItem : set){
        list.append(setItem);
    }
    return list;
}
