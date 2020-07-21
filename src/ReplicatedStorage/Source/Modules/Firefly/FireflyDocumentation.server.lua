--[[

--> Produced under association with Arvorian Industries <--	
		  ->> Written & Maintained by ShaneSloth <<-		
					--> Version 1.0.0 <--					


Firefly is a Graphics Quality Adjuster at it's core.

For best practice, Firefly should be located inside a folder named "Modules" under "ReplicatedStorage"
	However, if you know what you're doing, carry on. :THumbsUp:

Firefly is designed to be simple to use, simply require the module,
run the Initialise() method and take advantage of the 
AdjustGraphicsQuality(newPreset) method.

A Sample script can be found as a child of the module (sibling of the Documentation)
With enough tweaking it should be extremely simple to utilise this in a Gui to control the toggled preset.



================================================================================================================

										!!!!! CODE DOCUMENTATION BELOW !!!!!									

================================================================================================================

Firefly:Initialise(preset: string, autoAdjustToPreset: boolean)
	This will initialise the client with the given preset
		so long as autoAdjustToPreset is set to true
	
	Both paramaters are optional and can be discarded and Firefly will
		initialise with "Medium" settings.

Firefly:AdjustGraphicsQuality(newPreset: string)
	Use this method to easily adjust the graphics settings
		to a given preset.

Firefly:SetToggle(property: string, value: boolean)
	Use this method to toggle a specific setting on or off
		If no value is given, will default to toggling (flipping the currently set value)

Firefly:GetToggle(property: string)
	Use this method to get the currently set value of the given property

Presets:
	Min -
		Materials: Off
		PostEffects: Off
		Textures: Off
		Lighting.GlobalShadows: Off
		Atmosphere: Off
	Low -
		Materials: On
		PostEffects: Off
		Textures: Off
		Lighting.GlobalShadows: Off
		Atmosphere: Off
	Medium -
		Materials: On
		PostEffects: On
		Textures: Off
		Lighting.GlobalShadows: Off
		Atmosphere: Off
	High -
		Materials: On
		PostEffects: On
		Textures: On
		Lighting.GlobalShadows: On
		Atmosphere: Off
	Max -
		Materials: On
		PostEffects: On
		Textures: On
		Lighting.GlobalShadows: On
		Atmosphere: On
]]