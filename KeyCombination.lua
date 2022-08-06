-- # 2022/8/6 Xorice : KeyCombination For Roblox
--------------------------------------------------------
-- 欢迎使用KeyCombination 这是一款为Roblox打造的简单快捷键绑定系统
-- * 本库仅支持简单快捷键 格式 `ctrl + alt + shift + tab + esc + ANY` (可选
-- * * `ANY` 项应当是大写字母 总之是要对应 `KeyCode.Name`
-- * 要求快捷键长度最低大于 `1`
-- * 可以使用 `Lib:SimpleSetup()` 快速安装
--------------------------------------------------------
-- Example:
-- ``` Lua
-- local KeyCombo = Require "KeyCombination";
-- KeyCombo:SimpleSetup()
--
-- local function Example()
--     print("Hello World!");
-- end
-- KeyCombo:BindCombo("LeftShift A",Example)
--
-- ```
-- * 注: `Release()` 可以加自定义参数 所以用 `SimpleSetup()` 不是必要的
--------------------------------------------------------
local KeyCombination = {
	Action = {};
	Kvalue = {
		[Enum.KeyCode.LeftShift]	= 1,
		[Enum.KeyCode.LeftControl]	= 2,
		[Enum.KeyCode.LeftAlt]		= 4,
        	[Enum.KeyCode.Tab]		= 8,
        	[Enum.KeyCode.Escape]		= 16,
	}
}
local uis = game:GetService "UserInputService";
function KeyCombination:BindCombo(str :string, Action )
	local chrs = string.split(str, " ")
	assert(#chrs>1, str.." 不是可用的热键 要求长度大于 1");

	local cost = 0;
	for i, chr in ipairs(chrs) do
		local value = self.Kvalue[Enum.KeyCode[chr]]
		if value then
			cost = cost + value;
			chrs[i] = "";
		end
	end

	local actionName = cost..table.concat(chrs);
	assert(self.Action[actionName]==nil, str.." 该热键已经被占用");
	self.Action[actionName] = Action;
end;

function KeyCombination:Release(KeyCode, ...)
	local keyName = KeyCode.Name;

	local cost = 0;
	for valuedKey, value in next, self.Kvalue do
		local pressed = uis:IsKeyDown(valuedKey)
		if pressed then
			cost = cost + value;
		end
	end

	local actionName = cost..keyName;
	local Action = self.Action[actionName];
	if Action then
		return Action(...)
	end
end;

function KeyCombination:SimpleSetup()
	assert(self.connection==nil, "已经启用过了`SimpleSetup`功能")
	self.connection = uis.InputBegan:Connect(function(input,gp)
		if gp then
			return
		end
		return KeyCombination:Release(input.KeyCode);
	end)
end

return KeyCombination
