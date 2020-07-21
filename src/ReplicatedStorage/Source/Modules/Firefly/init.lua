--> Arvorian Industries Firefly 1.0.0
--> Written by ShaneSloth


--> Services
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--> Firefly Codebase
local Firefly = {
	Preset = "Medium",
	Loaded = false,

	Presets = {

		["Min"] = {
			Materials = false,
			PostEffects = false,
			Textures = false,
			Atmosphere = false,
			
			Lighting = {
				["GlobalShadows"] = false
			}
		},

		["Low"] = {
			Materials = true,
			PostEffects = false,
			Textures = false,
			Atmosphere = false,
			
			Lighting = {
				["GlobalShadows"] = false
			}
		},

		["Medium"] = {
			Materials = true,
			PostEffects = true,
			Textures = false,
			Atmosphere = false,
			
			Lighting = {
				["GlobalShadows"] = false
			}
		},

		["High"] = { 
			Materials = true,
			PostEffects = true,
			Textures = true,
			Atmosphere = false,
			
			Lighting = {
				["GlobalShadows"] = true
			}
		},

		["Max"] = {
			Materials = true,
			PostEffects = true,
			Textures = true,
			Atmosphere = true,
			
			Lighting = {
				["GlobalShadows"] = true
			}
		}

	},

	["Current"] = { }
}

Firefly.PartsCollection = { }
Firefly.ParticleEmittersCollection = { }
Firefly.PostEffectsCollection = { }
Firefly.TexturesCollection = { }


--[[
	Initialise Firefly, set default preset for client on player join

	\code Informs client of Firefly initialisation call and warns it could take time scanning the game
	Begins by grabbing the initial run time of Firefly
	Scans the workspace and other DataModel containers for relevant Instances
	{ Parts, ParticleEmitters, PostEffects, Textures }

	Clones the Lighting's current Atmosphere if one exists to the ReplicatedStorage for quick enabling

	Initialisation is complete, grab the finish time
	Inform the client of setup completion and give duration of setup ( Generally < 1s )

	Allow Firefly operations to run by setting Firefly.Loaded to true

	If a preset is given and autoAdjustToPreset is true adjust the client to the new default preset

	@param {String} [preset]					a string value representing which preset to load the client with ("Min", "Low", etc.)
	@param {boolean} [autoAdjustToPreset]	a boolean value indicating whether to allow initialisation adjustment
]]
function Firefly:Initialise(preset, autoAdjustToPreset)
	-- initialises by collecting all default information
	print("Initialising Firefly... This may take some time... Scanning workspace & other containers")
	local s = tick()
	self:CollectParts()
	self:CollectParticleEmitters()
	self:CollectPostEffects()
	self:CollectTextures()

	if Lighting:FindFirstChild("Atmosphere") then
		Lighting:FindFirstChild("Atmosphere"):Clone().Parent = ReplicatedStorage
	end

	local d = tick() - s
	print("Finished initialisation! Time taken (s): " .. tostring(math.floor(d)))
	self.Loaded = true

	if preset and autoAdjustToPreset then
		self:AdjustGraphicsQuality(preset)
	end
end

--[[
	Adjust the client's Graphics Quality setting to a new preset

	\code Check if a new preset is given otherwise default to the current preset 
	Check that the new preset exists within Firefly's preset list

	If Firefly is not yet loaded before this operation occurs hang the calling thread --> This should probably be handled better. Coroutines preferred.

	Acquire the preset from Firefly's preset list

	Using the given preset update the client's toggles.
	Set Firefly's in-use preset to the given preset

	@param {String} newPreset	a string value representing the preset to adjust the client to, falls back onto the current preset 
]]
function Firefly:AdjustGraphicsQuality(newPreset)
	newPreset = newPreset or self.Preset
	assert(self.Presets[newPreset], "Firefly: The Preset {" .. newPreset .. "} is not a valid preset")

	if not self.Loaded then print("Firefly has not finished initialising, awaiting initialisation...") end

	coroutine.wrap(function()
		while not self.Loaded do wait() end
		
		local presetInformation = self.Presets[newPreset]

		self:ToggleMaterials(presetInformation.Materials)
			:TogglePostFX(presetInformation.PostEffects)
			:ToggleTextures(presetInformation.Textures)
			:ToggleAtmosphere(presetInformation.Atmosphere)
			:ToggleLighting(presetInformation.Lighting)
		self.Preset = newPreset
		self.Current = self.Presets[self.Preset]
	end)()
end

--[[
	Toggle the given property to the given value or the oppsoite of what it was

	@param {String} property		the property to set the toggle value of
	@param {boolean} [value]		the value to assign to the property, if none specified defaults to opposite toggle value
]]
function Firefly:SetToggle(property, value) --> "Materials", "PostEffects", "Textures", "Atmosphere", "Lighting" | [true, false]
	local preset = self.Current --> grab the current preset configuration in use
	
	--> Modify the current preset 
	if property == "Lighting" then
		preset[property].GlobalShadows = (value~=nil and value) or (not preset[property].GlobalShadows)
	else
		preset[property] = (value~=nil and value) or (not preset[property])
	end
	--> update client's graphics quality
	self:AdjustGraphicsQuality(preset)

	return self
end

--[[
	Get the current setting of the given property

	@param {String} property	the property to check the toggle value of
	@return {boolean|dictionary} value|Current	--> The value of the toggle or the list of toggles
]]
function Firefly:GetToggle(property) --> "Materials", "PostEffects", "Textures", "Atmosphere", "Lighting"
	if property == "Lighting" then
		return self.Current[property].GlobalShadows --> Lighting only has GlobalShadows to be modified so until changed, this is how it be
	elseif property~="Lighting" and property~=nil then
		return self.Current[property]
	else
		return self.Current --> If the toggle doesn't exist or isn't requested will return the current preset
	end
end

function Firefly:ToggleMaterials(isMaterialsEnabled)
	for _, partInfo in next, self.PartsCollection do
		partInfo.Instance.Material = isMaterialsEnabled and partInfo.DefaultMaterial or Enum.Material.SmoothPlastic
	end
	return self
end

function Firefly:TogglePostFX(isPostFXEnabled)
	for _, postEffect in next, self.PostEffectsCollection do
		postEffect.Enabled = isPostFXEnabled
	end
	return self
end

function Firefly:ToggleTextures(isTexturesEnabled)
	for _, textureInfo in next, self.TexturesCollection do
		textureInfo.Instance.Texture = isTexturesEnabled and textureInfo.DefaultTexture or ""
	end
	return self
end

function Firefly:ToggleAtmosphere(isAtmosphereEnabled)
	if isAtmosphereEnabled then
		-- add the atmosphere / turn it on
		if not Lighting:FindFirstChild("Atmosphere") then
			-- doesn't already exist, clone it
			local defaultAtmosphere = ReplicatedStorage:FindFirstChild("Atmosphere")

			if defaultAtmosphere then
				defaultAtmosphere:Clone().Parent = Lighting
			else
				print("Atmosphere cannot be toggled; Default Atmosphere object does not exist")
				return self
			end
		else
			-- exists do nothing
			return self
		end
	else
		-- remove the atmosphere / turn it off
		if not (Lighting:FindFirstChild("Atmosphere")) then
			return self
		else
			Lighting:FindFirstChild("Atmosphere"):Destroy()
		end

	end
	return self
end

function Firefly:ToggleLighting(lightingProperties)
	for key, value in next, lightingProperties do
		Lighting[key] = value
	end
	return self
end

function Firefly:CollectParts(root)
	root = root or workspace
	for _, v in next, root:GetChildren() do
		if v:IsA("BasePart") then
			local info = {
				Instance = v,
				DefaultMaterial = v.Material
			}
			self.PartsCollection[#self.PartsCollection+1] = info
		end
		if #v:GetChildren() > 0 then
			self:CollectParts(v)
		end
	end
	return self
end

function Firefly:CollectParticleEmitters(root)
	root = root or workspace
	for _, v in next, root:GetChildren() do
		if v:IsA("ParticleEmitter") then
			self.ParticleEmittersCollection[#self.ParticleEmittersCollection+1] = v
		end
		if #v:GetChildren() > 0 then
			self:CollectParticleEmitters(v)
		end
	end
	return self
end

function Firefly:CollectPostEffects()
	local root = Lighting
	for _, v in next, root:GetChildren() do
		if v:IsA("PostEffect") then
			self.PostEffectsCollection[#self.PostEffectsCollection+1] = v
		end
	end
	return self
end

function Firefly:CollectTextures(root)
	root = root or workspace
	for _, v in next, root:GetChildren() do
		if v:IsA("Texture") then
			local info = {
				Instance = v,
				DefaultTexture = v.Texture
			}
			self.TexturesCollection[#self.TexturesCollection+1] = info
		end
		if #v:GetChildren() > 0 then
			self:CollectTextures(v)
		end
	end
	return self
end

return Firefly