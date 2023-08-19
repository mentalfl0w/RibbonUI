# RibbonUI

<div align="center">
    <img src="lib_source/resources/imgs/icon.png" alt="Logo" style="width:40%; height:auto;">
</div>
<h1 align="center">Qt RibbonUI </h1>

- [RibbonUI](#ribbonui)
  - [1. Introduction](#1-introduction)
  - [2. Included Components](#2-included-components)
  - [3. Supported platforms](#3-supported-platforms)
    - [Qt 6 branch (main branch)](#qt-6-branch-main-branch)
    - [Qt 5 branch (***TODO***)](#qt-5-branch-todo)
  - [4. Acknowledgement](#4-acknowledgement)
  - [5. Get in touch with me](#5-get-in-touch-with-me)


## 1. Introduction
RibbonUI is a lightweight, minimalist and elegant Qt component library written in QML and designed with reference to the Microsoft Ribbon style. 

***[点击查看中文文档](README(zh-cn).md)***

<div align="center">
    <div align="center">
        <img src="documents/pictures/home-light-classic.png" alt="Home Light Classic" style="width:45%; height:auto;">
        <img src="documents/pictures/home-dark-classic.png" alt="Home Light Classic" style="width:45%; height:auto;">
    </div>
    <p align="center">Home Light/Dark Theme (Classic Style) </p>
</div>
<div align="center">
    <div align="center">
        <img src="documents/pictures/home-light-modern.png" alt="Home Light Modern" style="width:45%; height:auto;">
        <img src="documents/pictures/home-dark-modern.png" alt="Home Light Modern" style="width:45%; height:auto;">
    </div>
    <p align="center">Home Light/Dark Theme (Modern Style) </p>
</div>

## 2. Included Components
Currently supports ***30*** components, more will be added later.
| Components | Introduction | Demo Picture|
|:----:|:----:|:----:|
| RibbonWindow | A Window component that relies on framelesshelper to support exit confirmation popups and blur style backgrounds. |![RibbonWindow](documents/pictures/home-light-modern.png)|
| RibbonTabBar | A toolbar with support for page switching and retracting, and support for placing customized buttons in the upper right corner, just like Microsoft Word's. | ![RibbonTabBar](documents/pictures/RibbonTabBar.png) |
| RibbonTitleBar | A window title bar that supports custom colors and the free addition of secondary buttons, with different designs for Windows and macOS. | ![RibbonTitleBar](documents/pictures/RibbonTitleBar.png) |
| RibbonBottomBar | A bottom bar that supports adding custom tools. |![RibbonBottomBar](documents/pictures/RibbonBottomBar.png) |

***The introduction of other components will be updated later.***

## 3. Supported platforms
The current design is based on Qt 6, and support for Qt 5 will be added sometime later, ***so the current support list is consistent with Qt 6***.
### Qt 6 branch (main branch)
+ Windows: Windows 10 (1809+), Windows 11.(X86/AMD64, aarch64)
+ macOS: macOS 11+.(AMD64, aarch64)
+ Linux: Ubuntu 22.04+ (X86/AMD64)
### Qt 5 branch (***TODO***)
+ Windows: Windows 7+.(X86/AMD64)
+ macOS: MacOS X 10.13 - 10.15, macOS 11+.(AMD64, aarch64)
+ Linux: Ubuntu 18.04+ (X86/AMD64)

## 4. Acknowledgement
+ [@wangwenx190](https://github.com/wangwenx190)'s [framelesshelper](https://github.com/wangwenx190/framelesshelper) for frameless window (aka RibbonWindow's base).
+ [@Microsoft](https://github.com/microsoft)'s [fluentui-system-icons](https://github.com/zhuzichu520/FluentUI) for beautifully designed icons.
+ [@zhuzichu520](https://github.com/zhuzichu520)'s [FluentUI](https://github.com/zhuzichu520/FluentUI) for inspiration and reference.

## 5. Get in touch with me
+ Email: mentalflow@ourdocs.cn
+ Blog: [The Tossed History of a Rookie Technician.](https://blog.ourdocs.cn)
+ ***And PRs and Issues are welcome, I'll try to improve features or fix bugs as soon as I can in my spare time, let's make RibbonUI better together, enjoy!***