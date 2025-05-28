#ifndef RIBBONTHEME_H
#define RIBBONTHEME_H

#include "ribbonsingleton.h"
#include "definitions.h"

class RibbonTheme : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(bool isDarkMode READ isDarkMode NOTIFY isDarkModeChanged FINAL)
    Q_PROPERTY_RW(RibbonThemeType::ThemeMode,themeMode)
    Q_PROPERTY_RW(bool,modernStyle)
    Q_PROPERTY_RW(bool,nativeText)

    RIBBON_SINGLETON(RibbonTheme)
public:
    Q_SIGNAL void isDarkModeChanged();
    bool isDarkMode();
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
private:
#endif
    RibbonTheme();
private:
    bool eventFilter(QObject *obj, QEvent *event);
    bool bindEngine(){return bindEngineBegin();};
    RibbonThemeType::ThemeMode currentTheme();
    RibbonThemeType::ThemeMode _system_themeMode;
};
#endif // RIBBONTHEME_H
