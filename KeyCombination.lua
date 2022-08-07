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
local STRINGs = {
	'"%s" is not an available key combination. The length is required to be greater than 1.',
	'The key combination "%s" is already occupied',
	"The 'SimpleSetup' function has been enabled",
}
local KeyCombination = { -- Only the following keycodes are supported:
	Action = {};
	Kvalue = {
		[Enum.KeyCode.LeftShift]	= 1,
		[Enum.KeyCode.LeftControl]	= 2,
		[Enum.KeyCode.LeftAlt]		= 4,
		[Enum.KeyCode.Tab]		= 8,
		[Enum.KeyCode.Escape]		= 16,
		[Enum.KeyCode.Space]		= 32,
		[Enum.KeyCode.Return]		= 64,
	};
	Dictionariy = {
		["shift"]	= Enum.KeyCode.LeftShift;
		["ctrl"]	= Enum.KeyCode.LeftControl;
		["alt"]		= Enum.KeyCode.LeftAlt;
		["tab"]		= Enum.KeyCode.Tab;
		["esc"]		= Enum.KeyCode.Escape;
		["space"]	= Enum.KeyCode.Space;
		["enter"]	= Enum.KeyCode.Return;
	};
}
local uis = game:GetService "UserInputService";
function KeyCombination:BindCombo(str :string, Action )
	local chrs = string.split(str, " ");
	assert(#chrs>1, string.format(STRINGs[1],str));

	local cost = 0;
	for i, chr in ipairs(chrs) do
		local KeyCode = self.Dictionariy[chr:lower()] or Enum.KeyCode[chr];
		local value = self.Kvalue[KeyCode];
		if value then
			cost = cost + value;
			chrs[i] = "";
		end
	end

	local actionName = cost..table.concat(chrs);
	assert(self.Action[actionName]==nil, string.format(STRINGs[2],str));
	self.Action[actionName] = Action;
end;

function KeyCombination:Release(KeyCode, ...)
	local keyName = KeyCode.Name;

	local cost = 0;
	for _, input in next, uis:GetKeysPressed() do
		local value = self.Kvalue[input.KeyCode];
		if value then
			cost = cost + value
		end
	end
	if self.Kvalue[KeyCode] then
		keyName = "";
	end

	local actionName = cost..keyName;
	local Action = self.Action[actionName];
	if Action then
		return Action(...);
	end
end;

function KeyCombination:SimpleSetup()
	assert(self.connection==nil, STRINGs[3])
	self.connection = uis.InputBegan:Connect(function(input,gp)
		if gp then
			return
		end
		return KeyCombination:Release(input.KeyCode);
	end)
end

return KeyCombination
