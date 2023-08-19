# RibbonUI

<div align="center">
    <img src="lib_source/resources/imgs/icon.png" alt="Logo" style="width:40%; height:auto;">
</div>

<h1 align="center">Qt RibbonUI </h1>

- [RibbonUI](#ribbonui)
  - [1. 介绍](#1-介绍)
  - [2. 组件列表](#2-组件列表)
  - [3. 支持平台](#3-支持平台)
    - [Qt 6 分支 (main 分支)](#qt-6-分支-main-分支)
    - [Qt 5 分支 (***TODO***)](#qt-5-分支-todo)
  - [4. 鸣谢](#4-鸣谢)
  - [5. 与我联系](#5-与我联系)

## 1. 介绍
RibbonUI是一个参考微软Ribbon风格（即Office 2016后的风格）设计的轻量级、简约且优雅的Qt组件库，用QML写就。

***[Click to view English README](README.md)***

<div align="center">
    <div align="center">
        <img src="documents/pictures/home-light-classic.png" alt="Home Light Classic" style="width:45%; height:auto;">
        <img src="documents/pictures/home-dark-classic.png" alt="Home Light Classic" style="width:45%; height:auto;">
    </div>
    <p align="center">主界面浅色/深色主题 (经典风格) </p>
</div>
<div align="center">
    <div align="center">
        <img src="documents/pictures/home-light-modern.png" alt="Home Light Modern" style="width:45%; height:auto;">
        <img src="documents/pictures/home-dark-modern.png" alt="Home Light Modern" style="width:45%; height:auto;">
    </div>
    <p align="center">主界面浅色/深色主题 (现代风格) </p>
</div>

## 2. 组件列表
目前支持***30***种组件，后续会添加更多。
| 名称 | 介绍 | 展示图片|
|:----:|:----:|:----:|
| RibbonWindow | 基于framelesshelper实现的无边框窗口，支持退出确认弹窗及模糊/亚克力化背景。|![RibbonWindow](documents/pictures/home-light-modern.png)|
| RibbonTabBar | 支持多分组页面切换、自定义右上角工具栏、自由收放的工具栏，如同Word的。| ![RibbonTabBar](documents/pictures/RibbonTabBar.png) |
| RibbonTitleBar | 支持自定义背景色、自由添加工具按钮的窗口标题栏，针对Windows和macOS有不同的窗口按钮设计。| ![RibbonTitleBar](documents/pictures/RibbonTitleBar.png) |
| RibbonBottomBar | 支持添加自定义工具的底栏。 |![RibbonBottomBar](documents/pictures/RibbonBottomBar.png) |

其他组件的介绍会陆续更新。

## 3. 支持平台
目前是基于Qt 6 设计的，之后有时间会加入Qt 5的支持, ***因此目前仅支持Qt 6支持的平台***。
### Qt 6 分支 (main 分支)
+ Windows: Windows 10 (1809+), Windows 11.(X86/AMD64, aarch64)
+ macOS: macOS 11+.(AMD64, aarch64)
+ Linux: Ubuntu 22.04+ (X86/AMD64)
### Qt 5 分支 (***TODO***)
+ Windows: Windows 7+.(X86/AMD64)
+ macOS: MacOS X 10.13 - 10.15, macOS 11+.(AMD64, aarch64)
+ Linux: Ubuntu 18.04+ (X86/AMD64)

## 4. 鸣谢
+ 感谢[@wangwenx190](https://github.com/wangwenx190)的[framelesshelper](https://github.com/wangwenx190/framelesshelper)让RibbonWindow能实现无边框。
+ [@Microsoft](https://github.com/microsoft)的[fluentui-system-icons](https://github.com/zhuzichu520/FluentUI)提供的漂亮图标库.
+ 感谢[@zhuzichu520](https://github.com/zhuzichu520)的[FluentUI](https://github.com/zhuzichu520/FluentUI) 为我提供的灵感和参考。

## 5. 与我联系
+ Email: mentalflow@ourdocs.cn
+ Blog: [菜鸟技术猿的折腾史.](https://blog.ourdocs.cn)
+ ***欢迎发起PR或Issues，我会在空余时间尽快完善功能或修复bug，希望能一起让RibbonUI变得更好，尽情享受吧🎉！***