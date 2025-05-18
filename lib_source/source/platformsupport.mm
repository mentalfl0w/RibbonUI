#include "platformsupport.h"
#include <AppKit/AppKit.h>

void PlatformSupport::showSystemTitleBtns(QWindow *window, bool enable)
{
  NSWindow* nswindow = [reinterpret_cast<NSView*>(window->winId()) window];
  [nswindow standardWindowButton:NSWindowCloseButton].hidden = (enable ? NO : YES);
  [nswindow standardWindowButton:NSWindowMiniaturizeButton].hidden = (enable ? NO : YES);
  [nswindow standardWindowButton:NSWindowZoomButton].hidden = (enable ? NO : YES);
}
