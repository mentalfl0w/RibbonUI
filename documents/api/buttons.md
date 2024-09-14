# 🔘Button Components
- [🔘Button Components](#button-components)
  - [1.RibbonButton](#1ribbonbutton)
    - [1.1 Overview](#11-overview)
    - [1.2 Properties](#12-properties)
    - [1.3 Example Code](#13-example-code)
      - [1.3.1 Basic Button](#131-basic-button)
        - [1.3.1.1 Code](#1311-code)
        - [1.3.1.2 Code Preview](#1312-code-preview)
      - [1.3.2 Basic Button With Icon](#132-basic-button-with-icon)
        - [1.3.2.1 Code](#1321-code)
        - [1.3.2.2 Code Preview](#1322-code-preview)
      - [1.3.3 Icon Button](#133-icon-button)
        - [1.3.3.1 Code](#1331-code)
        - [1.3.3.2 Code Preview](#1332-code-preview)

## 1.RibbonButton
### 1.1 Overview
+ Parent：Button
+ Demonstrate：
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-light.png" alt="RibbonButton Light Style" style="width:30%; height:auto;">
        <img src="../pictures/RibbonButton/RB-dark.png" alt="RibbonButton Dark Style" style="width:30%; height:auto;">
    </div>
    <p align="center">RibbonButton Light/Dark Style</p>
</div>

### 1.2 Properties
<!-- | `` | ``， |  |-->
| Name | Description | Demo picture |
|:----:|:----:|:----:|
| `isDarkMode` | `bool`, night mode, default is controlled by `RibbonTheme` property of the same name | \ |
| `showBg` | `bool`, show button background, default is `True` | ![showBg-pic](../pictures/RibbonButton/RB-showBg.png) |
| `showHoveredBg` | `bool`, show mouse overlay background, default is `True` | ![showHoveredBg-pic-1](../pictures/RibbonButton/RB-showHoveredBg-1.png) ![showHoveredBg-pic-2](../pictures/RibbonButton/RB-showHoveredBg-2.png) |
| `adaptHeight` | `bool`, adapt the height of the button to the height of the parent container, default is `False` | ![adaptHeight-pic](../pictures/RibbonButton/RB-adaptHeight.png) |
| `showTooltip` | `bool`, show `Tooltip` floating window, default is `True` | ![showTooltip-pic](../pictures/RibbonButton/RB-showTooltip.png) |
| `iconSource` | `var`, button icon, support input image link (`qrc://` or `file://`) or use embedded Microsoft icons (`RibbonIcons`)  | ![iconSource-pic](../pictures/RibbonButton/RB-iconSource.png) |
| `iconSourceFilled` | `var`，since the code for the hollow and solid versions of Microsoft icons are not fully matched, if the solid icon is abnormal when using inline Microsoft icons and only using iconSource, please replace `RibbonIcons` with `RibbonIcons_Filled` , just like `RibbonIcons.Home -> RibbonIcons_Filled.Home`, and assign the value to this attribute | \ |
| `imageIcon` | `alias`,  for direct access to button's image icon object | \ |
| `ribbonIcon` | `alias`，for direct access to button's embeded icon object | \ |
| `bgColor` | `string`，defines the background color of the button, by default it will switch with the light/dark theme | \ |
| `hoverColor` | `string`，defines the color when the mouse over the button, default will switch with light/dark theme and whether to show the button background or not | \ |
| `pressedColor` | `string`，define the color of the button pressed, default will switch with light/dark theme and whether to show button background or not | \ |
| `checkedColor` | `string`，define the color of the button when it is checked, default is same as `pressedColor` | \ |
| `textColor` | `string`，define the color of the button text, default is black for light theme and white for dark theme | \ |
| `textColorReverse` | `bool`，text color rendering, default is `True`, when the button has no background, if the button is covered/pressed/selected by the mouse, the text color of the button will be lightened to render it as a highlight (only noticeable when dark color is used, this attribute has the possibility to be cancelled) | \ |

### 1.3 Example Code
#### 1.3.1 Basic Button
##### 1.3.1.1 Code
```qml
RibbonButton{
    text:"Button"
}

RibbonButton{
    text:"Button"
    showTooltip: false // don't show the button tip floater
}
```
##### 1.3.1.2 Code Preview
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-basicBtn.png" alt="RibbonButton Light Style" style="width:20%; height:auto;">
    </div>
    <p align="center">Basic button</p>
</div>

#### 1.3.2 Basic Button With Icon
##### 1.3.2.1 Code
```qml
RibbonButton{
    text:"Button"
    iconSource: RibbonIcons.Accessibility
}

RibbonButton{
    text:"Button"
    showBg:false // don't show background
    iconSource: RibbonIcons.Beaker
    checkable: true // let it could be checked
}
```
##### 1.3.2.2 Code Preview
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-basicBtnWithIcon.png" alt="RibbonButton Light Style" style="width:30%; height:auto;">
    </div>
    <p align="center">Basic button with icon</p>
</div>

#### 1.3.3 Icon Button
##### 1.3.3.1 Code
```qml
RibbonButton{
    showBg:false // don't show background
    iconSource: RibbonIcons.Badge
    iconSourceFilled: RibbonIcons_Filled.Badge // define solid icon
    checkable: true // let it could be checked
    tipText: "Button" // define the button tip floater's text
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
    showTooltip: false // don't show the button tip floater
}
```
##### 1.3.3.2 Code Preview
<div align="center">
    <div align="center">
        <img src="../pictures/RibbonButton/RB-iconBtn.png" alt="RibbonButton Light Style" style="width:5%; height:auto;">
    </div>
    <p align="center">Icon button</p>
</div>
