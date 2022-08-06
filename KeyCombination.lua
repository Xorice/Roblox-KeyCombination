--[[----------------------------------------------------
MIT License

Copyright (c) 2022 Xorice

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]------------------------------------------------------
-- # 2022/8/6 Xorice : KeyCombination For Roblox
--------------------------------------------------------
-- More information:
-- https://github.com/Xorice/Roblox-KeyCombination
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
