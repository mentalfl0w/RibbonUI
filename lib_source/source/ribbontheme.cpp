#include "ribbontheme.h"
#include <QMutex>
#if (QT_VERSION >= QT_VERSION_CHECK(6, 5, 0))
#include <QStyleHints>
#elif (QT_VERSION >= QT_VERSION_CHECK(6, 2, 1))
#include <QtGui/qpa/qplatformtheme.h>
#include <QtGui/private/qguiapplication_p.h>
#else
#include <QPalette>
#endif

#include <QGuiApplication>

RibbonTheme::RibbonTheme()
{
    connect(this, &RibbonTheme::themeModeChanged, this, [=](){
        emit isDarkModeChanged();
    });
    _themeMode = RibbonThemeType::ThemeMode::System;
    _system_themeMode = currentTheme();
    modernStyle(false);
    nativeText(true);
    qApp->installEventFilter(this);
    initialBind();
}

bool RibbonTheme::eventFilter(QObject *obj, QEvent *event)
{
    Q_UNUSED(obj);
    if (event->type() == QEvent::ApplicationPaletteChange || event->type() == QEvent::ThemeChange)
    {
        _system_themeMode = currentTheme();
        if (_themeMode == RibbonThemeType::ThemeMode::System)
            Q_EMIT themeModeChanged();
        event->accept();
        return true;
    }
    return false;
}

RibbonThemeType::ThemeMode RibbonTheme::currentTheme()
{
#if (QT_VERSION >= QT_VERSION_CHECK(6, 5, 0))
    return (QGuiApplication::styleHints()->colorScheme() == Qt::ColorScheme::Light) ?
               RibbonThemeType::ThemeMode::Light : RibbonThemeType::ThemeMode::Dark;
#elif ((QT_VERSION >= QT_VERSION_CHECK(6, 2, 1)))
    if (const QPlatformTheme * const theme = QGuiApplicationPrivate::platformTheme()) {
        return (theme->appearance() == QPlatformTheme::Appearance::Light) ?
                   RibbonThemeType::ThemeMode::Light : RibbonThemeType::ThemeMode::Dark;
    }
    return RibbonThemeType::ThemeMode::Light;
#else
    QPalette palette = qApp->palette();
    QColor color = palette.color(QPalette::Window).rgb();
    return (color.red() * 0.2126 + color.green() * 0.7152 + color.blue() * 0.0722 > 255 / 2) ? RibbonThemeType::ThemeMode::Light : RibbonThemeType::ThemeMode::Dark;
#endif
}

bool RibbonTheme::isDarkMode()
{
    return _themeMode == RibbonThemeType::ThemeMode::System ? _system_themeMode == RibbonThemeType::ThemeMode::Dark
                                                             : _themeMode == RibbonThemeType::ThemeMode::Dark;
}
