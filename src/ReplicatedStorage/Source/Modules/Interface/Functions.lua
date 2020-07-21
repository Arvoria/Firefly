local TweenService = game:GetService("TweenService")
local Interface = script.Parent
local TweeningService = require(Interface.TweeningService)
local Functions = { }

Functions.AsyncThreads = { }

function Functions.TweenElement(guiElement, tweenInfo, propertyGoals)
	TweeningService.Tween(guiElement, tostring(tweenInfo.EasingDirection) .. tostring(tweenInfo.EasingStyle), propertyGoals, tweenInfo.Time)
end

function Functions.TweenElementAsync(guiElement, tweenInfo, propertyGoals)
	coroutine.resume(
		coroutine.create(function()
			TweeningService.Tween(guiElement, tostring(tweenInfo.EasingDirection) .. tostring(tweenInfo.EasingStyle), propertyGoals, tweenInfo.Time)
		end)
	)
end

function Functions.Typewrite(guiElement, startText, endText, duration)
	local change = math.abs(string.len(endText) - string.len(startText)) * 2
	local t = change/duration
	for i = 1, change, 1 do
		if endText == "" or endText == " " then
			guiElement.Text = string.sub(startText, 1, startText:len()-i).."_"
		else
			guiElement.Text = string.sub(endText, 1, i) .. "_"
		end
		guiElement.Text = string.sub(guiElement.Text, 1, guiElement.Text:len()-1)
		wait(1/t)
	end
end

function Functions.TypewriteAsync(guiElement, startText, endText, duration)
	if Functions.AsyncThreads[guiElement] then
		Functions.AsyncThreads[guiElement] = false;
	end
	
	Functions.AsyncThreads[guiElement] = true;
	coroutine.resume(
		coroutine.create(function()
			local change = math.abs(string.len(endText) - string.len(startText))
			local t = change/duration
			Functions.TypeWriting = true
			for i = 1, change, 1 do
				if Functions.AsyncThreads[guiElement] == false then break end
				
				if endText == "" or endText == " " then
					guiElement.Text = string.sub(startText, 1, startText:len()-i).."_"
				else
					guiElement.Text = string.sub(endText, 1, i) .. "_"
				end
				wait(1/t)
			end
			guiElement.Text = (Functions.AsyncThreads[guiElement] == true and endText) or string.sub(guiElement.Text, 1, guiElement.Text:len()-1)
			Functions.AsyncThreads[guiElement] = false;
		end)
	)
end

return Functions;