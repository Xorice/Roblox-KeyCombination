# KeyCombination For Roblox
Simple Key Combination system in Roblox

## 欢迎使用KeyCombination
这是一款为Roblox打造的简单快捷键绑定系统
* 本库仅支持简单快捷键 格式 `ctrl + alt + shift + tab + esc + ANY` (可选
* 可以使用 `Lib:SimpleSetup()` 快速安装
* * `ANY` 项应当是大写字母 总之是要对应 `KeyCode.Name`

## |注意事项   Matters Needing Attention|
* 可用的KeyCode: `LeftShift` `LeftControl` `LeftAlt` `Tab` `Escape` `Space` `Return` `ANY`   
* 可用的简写 (不区分大小写): `shift` `ctrl` `alt` `tab` `esc` `space` `enter`   
* 要求快捷键长度最低大于 `1`    
* 为了效率 本库没有Key Buffer. 所以不支持像 `ctrl+k s` 这样的复合组合键
--------------------------------------------------------
Example:
``` Lua
local KeyCombo = Require "KeyCombination";
KeyCombo:SimpleSetup()

local function Example()
  print("Hello World!");
end
KeyCombo:BindCombo("LeftShift LeftAlt A",Example)
-- It can be replaced by:  KeyCombo:BindCombo("shift alt A",Example)
-- Also can be:  KeyCombo:BindCombo("sHiFt AlT A",Example)

```
* 注: `Release()` 可以加自定义参数 所以用 `SimpleSetup()` 不是必要的

Example Ex:
``` Lua
local KeyCombo = Require "KeyCombination";

local function Example(num)
  print("The number is "..num);
end
KeyCombo:BindCombo("shift A",Example)

-- Suppose I held shift ↓
KeyCombo:Release(Enum.KeyCode.A, 9.0) -- > The number is 9
```
--------------------------------------------------------
Functions:
* 绑定按键 Bind Key Combination
``` Lua
KeyCombination:BindCombo(str :string, Action :(any)->(any))
```
* 快速安装 Simple Setup
``` Lua
KeyCombination:SimpleSetup()
```
* 应用结果 Release Key Input  ( 没有使用 `SimpleSetup()` 的时候使用. / Use it when `SimpleSetup()` is didn't called.
``` Lua
KeyCombination:Release(KeyCode: Enum.KeyCode, ...) -- Should be placed under input event
```
