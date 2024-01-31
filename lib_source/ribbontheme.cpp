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
    connect(this, &RibbonTheme::theme_modeChanged, this, [=](){
        emit dark_modeChanged();
    });
    _theme_mode = RibbonThemeType::ThemeMode::System;
    _system_theme_mode = current_theme();
    modern_style(false);
    qApp->installEventFilter(this);
}

RibbonTheme* RibbonTheme::instance(){
    static QMutex mutex;
    QMutexLocker locker(&mutex);

    static RibbonTheme *singleton = nullptr;
    if (!singleton) {
        singleton = new RibbonTheme();
    }
    return singleton;
}

bool RibbonTheme::eventFilter(QObject *obj, QEvent *event)
{
    Q_UNUSED(obj);
    if (event->type() == QEvent::ApplicationPaletteChange || event->type() == QEvent::ThemeChange)
    {
        _system_theme_mode = current_theme();
        if (_theme_mode == RibbonThemeType::ThemeMode::System)
            Q_EMIT theme_modeChanged();
        event->accept();
        return true;
    }
    return false;
}

RibbonThemeType::ThemeMode RibbonTheme::current_theme()
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

bool RibbonTheme::dark_mode()
{
    return _theme_mode == RibbonThemeType::ThemeMode::System ? _system_theme_mode == RibbonThemeType::ThemeMode::Dark
                                                             : _theme_mode == RibbonThemeType::ThemeMode::Dark;
}
