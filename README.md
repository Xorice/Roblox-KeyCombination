# KeyCombination for Roblox

[中文版介绍](README.chs.md)

A simple key combination system for Roblox, supporting customizable hotkey bindings.

## Features

- Supports simple key combinations in the format: `ctrl + alt + shift + tab + esc + ANY` (optional modifiers).
- Use `Lib:SimpleSetup()` for quick installation.
- The `ANY` key should be an uppercase letter corresponding to `KeyCode.Name`.

## Usage Notes

- Available KeyCodes: `LeftShift`, `LeftControl`, `LeftAlt`, `Tab`, `Escape`, `Space`, `Return`, `ANY`.
- Abbreviations (case-insensitive): `shift`, `ctrl`, `alt`, `tab`, `esc`, `space`, `enter`.
- Minimum combination length: greater than 1.
- No key buffering for efficiency; does not support complex sequences like `ctrl+k s`.

## Example

```lua
local KeyCombo = require "KeyCombination"
KeyCombo:SimpleSetup()

local function Example()
    print("Hello World!")
end
KeyCombo:BindCombo("LeftShift LeftAlt A", Example)
-- Alternatively: KeyCombo:BindCombo("shift alt A", Example)
-- Case-insensitive: KeyCombo:BindCombo("sHiFt AlT A", Example)
```

Note: `Release()` accepts custom parameters, so `SimpleSetup()` is optional.

## Advanced Example

```lua
local KeyCombo = require "KeyCombination"

local function Example(num)
    print("The number is " .. num)
end
KeyCombo:BindCombo("shift A", Example)

-- While holding shift:
KeyCombo:Release(Enum.KeyCode.A, 9.0) -- Output: The number is 9
```

## API

- **Bind Key Combination**
  ```lua
  KeyCombination:BindCombo(str: string, Action: (any) -> (any))
  ```

- **Simple Setup**
  ```lua
  KeyCombination:SimpleSetup()
  ```

- **Release Key Input** (Use when `SimpleSetup()` is not called)
  ```lua
  KeyCombination:Release(KeyCode: Enum.KeyCode, ...) -- Place under input event
  ```
