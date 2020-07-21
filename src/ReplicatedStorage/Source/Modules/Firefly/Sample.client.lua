--[[

	ShaneSloth & Arvorian Industries, v1.0.0

	Sample Script to be used as an example of how to utilise Firefly
	This example uses UserInputService to flick between Min and Max settings

]]

--[[ 
	SAMPLE PRESET UI CHANGING
]]

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Firefly = require(Modules.Firefly)
Firefly:Initialise() -- will default the presets to Firefly.Preset
--Firefly:Initialise("Max", true) -- will set the preset lighting on launch to Max settings
--Firefly:Initalise("Min", true) -- similarly, this will set the lighting to Min settings

UserInputService.InputBegan:Connect(function(input, GPE)
	if not GPE then
		-- not game processed, safe to run
		if input and input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.M then
				Firefly:AdjustGraphicsQuality("Max")
			elseif input.KeyCode == Enum.KeyCode.N then
				Firefly:AdjustGraphicsQuality("Min")
			end
		end
	end
end)



--[[ 
	SAMPLE RADIO BUTTON TOGGLE
]]

--> Suppose you have a TextButton you wish to turn into a radio button
--> For different graphics settings:

--> Sample radio button toggle
local Buttons = script.Parent:FindFirstChild("Buttons"):GetChildren() --> Assume "Buttons" is a folder/container with *only* TextButtons
--> The names of these TextButtons should correspond to their respective Graphic Toggles
--> { Materials, PostEffects, Textures, Lighting, Atmosphere }

--[[ Code just in case the above is not the case and you wish to filter out non text buttons

	for _, v in next, Buttons do
		if not v:IsA("TextButton") then
			table.remove(Buttons, v)
		end
	end
]]

local function updateButton(button, toggled)
	if toggled then
		-- button is turning on
		button.Text = "X"
		button.BorderColor3 = Color3.fromRGB(0, 170, 50)
	else
		-- button is turning off
		button.Text = ""
		button.BorderColor3 = Color3.fromRGB(170, 0, 50)
	end
end

local function toggleValue(button)
	local setting = button.Name
	local toggled = Firefly:GetToggle(setting)
	--Firefly:GetToggle()[setting] is also appropriate syntax
	local inverted = not toggled
	updateButton(button, inverted)
	Firefly:SetToggle(setting, inverted)
	--Firefly:SetToggle(setting) is also valid syntax if just toggling
	--The used syntax here is just to improve readability of the code
end

for index, button in pairs(Buttons) do
	--if not button:IsA("Button") then return end --code to filter out Instances that are not TextButton's

	updateButton(button, Firefly:GetToggle(button.Name))

	button.MouseButton1Click:Connect(function()
		toggleValue(button)
	end)
end