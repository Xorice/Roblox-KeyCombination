# KeyCombination for Roblox

Roblox 的简单按键组合系统，支持自定义热键绑定。

## 功能特性

- 支持简单按键组合，格式：`ctrl + alt + shift + tab + esc + ANY`（修饰键可选）。
- 使用 `Lib:SimpleSetup()` 快速安装。
- `ANY` 键应为大写字母，对应 `KeyCode.Name`。

## 使用注意事项

- 可用 KeyCode：`LeftShift`、`LeftControl`、`LeftAlt`、`Tab`、`Escape`、`Space`、`Return`、`ANY`。
- 缩写（不区分大小写）：`shift`、`ctrl`、`alt`、`tab`、`esc`、`space`、`enter`。
- 组合键最小长度：大于 1。
- 为提高效率，无按键缓冲；不支持如 `ctrl+k s` 的复合序列。

## 示例

```lua
local KeyCombo = require "KeyCombination"
KeyCombo:SimpleSetup()

local function Example()
    print("Hello World!")
end
KeyCombo:BindCombo("LeftShift LeftAlt A", Example)
-- 替代写法：KeyCombo:BindCombo("shift alt A", Example)
-- 不区分大小写：KeyCombo:BindCombo("sHiFt AlT A", Example)
```

注意：`Release()` 接受自定义参数，因此 `SimpleSetup()` 是可选的。

## 高级示例

```lua
local KeyCombo = require "KeyCombination"

local function Example(num)
    print("数字是 " .. num)
end
KeyCombo:BindCombo("shift A", Example)

-- 按住 shift 时：
KeyCombo:Release(Enum.KeyCode.A, 9.0) -- 输出：数字是 9
```

## API

- **绑定按键组合**
  ```lua
  KeyCombination:BindCombo(str: string, Action: (any) -> (any))
  ```

- **简单设置**
  ```lua
  KeyCombination:SimpleSetup()
  ```

- **释放按键输入**（未使用 `SimpleSetup()` 时使用）
  ```lua
  KeyCombination:Release(KeyCode: Enum.KeyCode, ...) -- 放置在输入事件下
  ```