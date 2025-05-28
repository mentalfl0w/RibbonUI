#include "localization.h"
#include "ribbonconfig.h"

void Localization::loadCurrentLanguage(){
    QString language = RibbonConfig::getInstance()->get("Settings", "Current Language").toString();
    setCurrentLanguage(language);
}

void Localization::saveCurrentLanguage(const QString &language){
    RibbonConfig::getInstance()->set("Settings", "Current Language", language);
}
