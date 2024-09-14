# 🔘按钮类组件
- [🔘按钮类组件](#按钮类组件)
  - [1.RibbonButton](#1ribbonbutton)
    - [1.1 概述](#11-概述)
    - [1.2 属性](#12-属性)
    - [1.3 示例代码](#13-示例代码)
      - [1.3.1 普通按钮](#131-普通按钮)
        - [1.3.1.1 代码](#1311-代码)
        - [1.3.1.2 代码预览](#1312-代码预览)
      - [1.3.2 带图标的普通按钮](#132-带图标的普通按钮)
        - [1.3.2.1 代码](#1321-代码)
        - [1.3.2.2 代码预览](#1322-代码预览)
      - [1.3.3 图标按钮](#133-图标按钮)
        - [1.3.3.1 代码](#1331-代码)
        - [1.3.3.2 代码预览](#1332-代码预览)

## 1.RibbonButton
### 1.1 概述
+ 父类：Button
+ 展示：
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-light.png" alt="RibbonButton Light Style" style="width:30%; height:auto;">
        <img src="../pictures/RibbonButton/RB-dark.png" alt="RibbonButton Dark Style" style="width:30%; height:auto;">
    </div>
    <p align="center">RibbonButton Light/Dark Style</p>
</div>

### 1.2 属性
<!-- | `` | ``， |  |-->
| 名称 | 说明 | 示例图片 |
|:----:|:----:|:----:|
| `isDarkMode` | `bool`, 夜间模式，默认由`RibbonTheme`的同名属性控制 | \ |
| `showBg` | `bool`, 显示按钮背景，默认为`True` | ![showBg-pic](../pictures/RibbonButton/RB-showBg.png) |
| `showHoveredBg` | `bool`, 显示鼠标覆盖背景，默认为`True` | ![showHoveredBg-pic-1](../pictures/RibbonButton/RB-showHoveredBg-1.png) ![showHoveredBg-pic-2](../pictures/RibbonButton/RB-showHoveredBg-2.png) |
| `adaptHeight` | `bool`, 自适应按键高度至父容器高度，默认为`False` | ![adaptHeight-pic](../pictures/RibbonButton/RB-adaptHeight.png) |
| `showTooltip` | `bool`, 显示按钮提示浮窗，默认为`True` | ![showTooltip-pic](../pictures/RibbonButton/RB-showTooltip.png) |
| `iconSource` | `var`, 按钮图标，支持输入图片链接（`qrc://`或`file://`）或者使用内嵌微软图标（`RibbonIcons`） | ![iconSource-pic](../pictures/RibbonButton/RB-iconSource.png) |
| `iconSourceFilled` | `var`，由于微软图标空心版和实心版对应的代码并不完全一致，当使用内嵌微软图标且仅使用`iconSource`时实心图标出现异常，请将`RibbonIcons`替换为`RibbonIcons_Filled`并为此属性赋值，如`RibbonIcons.Home -> RibbonIcons_Filled.Home` | \ |
| `imageIcon` | `alias`, 供直接访问按钮的图片图标对象 | \ |
| `ribbonIcon` | `alias`，供直接访问按钮的内嵌图标对象 | \ |
| `bgColor` | `string`，定义按钮的背景颜色，默认会随着亮/暗色主题切换 | \ |
| `hoverColor` | `string`，定义鼠标放在按钮上的颜色，默认会随着亮/暗色主题和是否显示按钮背景切换 | \ |
| `pressedColor` | `string`，定义按钮按下的颜色，默认会随着亮/暗色主题和是否显示按钮背景切换 | \ |
| `checkedColor` | `string`，定义按钮被选中时的颜色，默认与`pressedColor`一致 | \ |
| `textColor` | `string`，定义按钮文字的颜色，默认亮色主题为黑，暗色主题为白 | \ |
| `textColorReverse` | `bool`，文字颜色凸显，默认为`True`, 在按钮无背景时，按钮若被鼠标覆盖/按下/选中，按钮文字颜色会变淡以凸显（仅当使用深色时才明显，此属性有被取消的可能） | \ |

### 1.3 示例代码
#### 1.3.1 普通按钮
##### 1.3.1.1 代码
```qml
RibbonButton{
    text:"Button"
}

RibbonButton{
    text:"Button"
    showTooltip: false //不显示按钮提示浮窗
}
```
##### 1.3.1.2 代码预览
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-basicBtn.png" alt="RibbonButton Light Style" style="width:20%; height:auto;">
    </div>
    <p align="center">Basic button</p>
</div>

#### 1.3.2 带图标的普通按钮
##### 1.3.2.1 代码
```qml
RibbonButton{
    text:"Button"
    iconSource: RibbonIcons.Accessibility
}

RibbonButton{
    text:"Button"
    showBg:false // 不显示背景
    iconSource: RibbonIcons.Beaker
    checkable: true // 可被选中
}
```
##### 1.3.2.2 代码预览
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-basicBtnWithIcon.png" alt="RibbonButton Light Style" style="width:30%; height:auto;">
    </div>
    <p align="center">Basic button with icon</p>
</div>

#### 1.3.3 图标按钮
##### 1.3.3.1 代码
```qml
RibbonButton{
    showBg:false // 不显示背景
    iconSource: RibbonIcons.Badge
    iconSourceFilled: RibbonIcons_Filled.Badge // 定义实心图标
    checkable: true // 可被选中
    tipText: "Button" // 提示信息文本
}
RibbonButton{
    showBg:false
    iconSource: RibbonIcons.Clock
    iconSourceFilled: RibbonIcons_Filled.Clock
    tipText: "Button"
}
RibbonButton{
    showBg:false
    iconSource: RibbonIcons.Board
    iconSourceFilled: RibbonIcons_Filled.Board
    checkable: true
    tipText: "Button"
    showTooltip: false // 不显示提示信息
}
```
##### 1.3.3.2 代码预览
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-iconBtn.png" alt="RibbonButton Light Style" style="width:5%; height:auto;">
    </div>
    <p align="center">Icon button</p>
</div>
