#ifndef RIBBONTHEME_H
#define RIBBONTHEME_H

#include <QQuickItem>
#include "definitions.h"

class RibbonTheme : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
    QML_NAMED_ELEMENT(RibbonTheme)

    Q_PROPERTY(bool isDarkMode READ isDarkMode() NOTIFY isDarkModeChanged FINAL)
    Q_PROPERTY_RW(RibbonThemeType::ThemeMode,themeMode)
    Q_PROPERTY_RW(bool,modernStyle)
    Q_PROPERTY_RW(bool,nativeText)
public:
    static RibbonTheme* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
    static RibbonTheme* instance();
    Q_SIGNAL void isDarkModeChanged();
    bool isDarkMode();
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
public:
#else
private:
    Q_DISABLE_COPY_MOVE(RibbonTheme)
#endif
    RibbonTheme();
    bool eventFilter(QObject *obj, QEvent *event);
    RibbonThemeType::ThemeMode currentTheme();
    RibbonThemeType::ThemeMode _system_themeMode;
};

#endif // RIBBONTHEME_H
