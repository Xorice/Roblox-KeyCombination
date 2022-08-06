# KeyCombination For Roblox
Simple Key Combination system in Roblox

## 欢迎使用KeyCombination
这是一款为Roblox打造的简单快捷键绑定系统
* 本库仅支持简单快捷键 格式 `ctrl + alt + shift + tab + esc + ANY` (可选
* 要求快捷键长度最低大于 `1`
* 可以使用 `Lib:SimpleSetup()` 快速安装
* * `ANY` 项应当是大写字母 总之是要对应 `KeyCode.Name`
--------------------------------------------------------
Example:
```
local KeyCombo = Require "KeyCombination";
KeyCombo:SimpleSetup()

local function Example()
  print("Hello World!");
end
KeyCombo:BindCombo("LeftShift A",Example)

```
* 注: `Release()` 可以加自定义参数 所以用 `SimpleSetup()` 不是必要的
