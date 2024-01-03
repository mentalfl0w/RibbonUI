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

    Q_PROPERTY(bool dark_mode READ dark_mode() NOTIFY dark_modeChanged FINAL)
    Q_PROPERTY_RW(RibbonThemeType::ThemeMode,theme_mode)
    Q_PROPERTY_RW(bool,modern_style)
public:
    static RibbonTheme* create(QQmlEngine *qmlEngine, QJSEngine *jsEngine){return instance();}
    static RibbonTheme* instance();
    Q_SIGNAL void dark_modeChanged();
    bool dark_mode();
private:
    RibbonTheme();
    Q_DISABLE_COPY_MOVE(RibbonTheme)
    bool eventFilter(QObject *obj, QEvent *event);
    RibbonThemeType::ThemeMode current_theme();
    RibbonThemeType::ThemeMode _system_theme_mode;
};

#endif // RIBBONTHEME_H
