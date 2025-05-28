#include "ribbonlocalization.h"
#include <QMutex>
#include <QGuiApplication>
#include <QTimer>

RibbonLocalization::RibbonLocalization(){
    _currentLang = "en_US";
    _enabled = true;
    initialBind();
    connect(this, &RibbonLocalization::enabledChanged, this, &RibbonLocalization::switchState);
}

RibbonLocalization::~RibbonLocalization() {
    for (auto item : std::as_const(transList))
        item.clear();
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
        emit registerLanguageFinished();
        return true;
    }
    emit registerLanguageFinished();
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
    auto keys = moduleLangList.keys();
    for(auto &langItem : keys){
        if(langItem.first == langName){
            isNeeded[moduleLangList[langItem]] = true;
            Q_UNUSED(transList[moduleLangList[langItem]].get()->load(langItem.second));
            _currentLang = langName;
            qApp->installTranslator(transList[moduleLangList[langItem]].get());
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

bool RibbonLocalization::bindEngine(){
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    QQmlApplicationEngine* &engine = getEngine();
    engine = dynamic_cast<QQmlApplicationEngine*>(qmlEngine(this));
#else
    QQmlApplicationEngine *engine = dynamic_cast<QQmlApplicationEngine*>(qmlEngine(this));
#endif
    if(bindEngineBegin()){
        QObject::connect(this, &RibbonLocalization::currentLanguageChanged, engine, [engine]() -> void {
            engine->retranslate();
        });
        loadCurrentLanguage();
        return true;
    }
    return false;
}

QList<QString> RibbonLocalization::languageList(){
    QList<QString> list;
    QSet<QString> set;
    auto keys = moduleLangList.keys();
    for(auto &langItem : keys){
        set.insert(langItem.first);
    }
    for(auto &setItem : set){
        list.append(setItem);
    }
    return list;
}

QString RibbonLocalization::languageTranslate(QString langStr){
    if(langList.contains(langStr)){
        return qApp->translate("langList", langList[langStr]);
    }
    else
        return tr("Not Found");
}

void RibbonLocalization::switchState(){
    if(_enabled){
        setCurrentLanguage(_currentLang);
    }
    else{
        auto keys = moduleLangList.keys();
        for(auto &langItem : keys){
            if(langItem.first == _currentLang){
                qApp->removeTranslator(transList[moduleLangList[langItem]].get());
            }
        }
    }
}
