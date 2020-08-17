
local OUF_ABU, ns = ...
local OUF_ABUOPTIONS = "oUF_AbuOptions"

ns.fontstrings = {} -- For number fonstrings
ns.fontstringsB = {}-- For name fonstrings
ns.fontstringsC = {} -- For bar fonstrings
ns.fontstringsD = {}-- For level fonstrings
ns.statusbars = {}  -- For statusbars
ns.paintframes = {} -- For coloring frames

ns.L = {}
ns.locale = GetLocale()

ns.Classic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

------------------------------------------------------------------------
--  Colors
-- oUF.colors.uninterruptible = { 1, 0.7, 0 }
oUF.colors.fallback = { 1, 1, 1 }
--oUF.colors.smooth = {1, 0, 0,	1, 1, 0,	0, 1, 0}
--oUF.colors.disconnected = {.6, .6, .6}
--oUF.colors.tapped = {.6,.6,.6}

--oUF.colors.reaction[1] = { 0.8, 0.3, 0.22} --:Exceptionally hostile
--oUF.colors.reaction[2] = { 0.8, 0.3, 0.22}
--oUF.colors.reaction[3] = { 0.75, 0.27, 0}
--oUF.colors.reaction[4] = { 0.9, 0.7, 0}
--oUF.colors.reaction[5] = { 0, 0.6, 0.1}
--oUF.colors.reaction[6] = { 0, 0.6, 0.1}
--oUF.colors.reaction[7] = { 0, 0.6, 0.1}
--oUF.colors.reaction[8] = { 0, 0.6, 0.1}	--: Exalted

oUF.colors.health = {49/255, 207/255, 37/255}
oUF.colors.power["MANA"] = { 0.00, 0.5, 1.00 }
--oUF.colors.power["RAGE"] = { 1.00, 0.00, 0.00 }
--oUF.colors.power["FOCUS"] = { 1.00, 0.50, 0.25 }
--oUF.colors.power["ENERGY"] = { 1.00, 1.00, 0.00 }
--oUF.colors.power["CHI"] = { 0.71, 1.0, 0.92 }
--oUF.colors.power["RUNES"] = { 0.50, 0.50, 0.50 }
--oUF.colors.power["RUNIC_POWER"] = { 0.00, 0.82, 1.00 }
--oUF.colors.power["SOUL_SHARDS"] = { 0.50, 0.32, 0.55 }
--oUF.colors.power["HOLY_POWER"] = { 0.95, 0.90, 0.60 }
--oUF.colors.power["AMMOSLOT"] = { 0.80, 0.60, 0.00 }
--oUF.colors.power["FUEL"] = { 0.0, 0.55, 0.5 }

if not ns.Classic then
	-- To change class colors use a custom class color addon like Class Colors
	ALT_MANA_BAR_PAIR_DISPLAY_INFO.DRUID[1] = true
	ALT_MANA_BAR_PAIR_DISPLAY_INFO.DRUID[3] = true
end

------------------------------------------------------------------------
--  Event handler
local oUFAbu = CreateFrame("Frame", "oUFAbu")
oUFAbu:RegisterEvent("ADDON_LOADED")
oUFAbu:SetScript("OnEvent", function(self, event, ...)
	return self[event] and self[event](self, event, ...)
end)

function oUFAbu:ADDON_LOADED(event, addon)
	if addon == OUF_ABU then
		local SharedMedia = LibStub("LibSharedMedia-3.0", true)
		if SharedMedia then
			SharedMedia:Register("font", "Accidental Presidency",   [[Interface\AddOns\oUF_Abu\Media\Font\fontNumber.ttf]])
			SharedMedia:Register("font", "Expressway Free",         [[Interface\AddOns\oUF_Abu\Media\Font\fontSmall.ttf]])
			SharedMedia:Register("font", "Expressway RG",           [[Interface\AddOns\oUF_Abu\Media\Font\fontThick.ttf]])

			SharedMedia:Register("statusbar", "Flat", 		[[Interface\BUTTONS\WHITE8X8]])
			SharedMedia:Register("statusbar", "Neal", 		[[Interface\AddOns\oUF_Abu\Media\Texture\statusbarNeal]])
			SharedMedia:Register("statusbar", "Neal Dark", 	[[Interface\AddOns\oUF_Abu\Media\Texture\statusbarNealDark]])
			SharedMedia:Register("statusbar", "Flat Dark", 	[[Interface\AddOns\oUF_Abu\Media\Texture\Raid-Bar-Hp-Fill]])
			SharedMedia:Register("statusbar", "Hal G", 		[[Interface\AddOns\oUF_Abu\Media\Texture\statusbarHalH.tga]])
			SharedMedia:Register("statusbar", "Hal M", 		[[Interface\AddOns\oUF_Abu\Media\Texture\statusbarHalM.tga]])
		end
		
		self:SetupSettings()

		-- Focus Key
		if (ns.config.focBut ~= "NONE") then
			--Blizzard raid frame
			hooksecurefunc("CompactUnitFrame_SetUpFrame", function(frame, ...)
				if ((UnitAffectingCombat("player") or UnitAffectingCombat("pet"))) then return; end
				frame:SetAttribute(ns.config.focMod.."type"..ns.config.focBut, "focus")
			end)
			-- World Models
			local foc = CreateFrame("CheckButton", "Focuser", UIParent, "SecureActionButtonTemplate")
			foc:SetAttribute("type1", "macro")
			foc:SetAttribute("macrotext", "/focus mouseover")
			SetOverrideBindingClick(Focuser, true, ns.config.focMod.."BUTTON"..ns.config.focBut, "Focuser")
		end

		-- Border Texture
		local prefix = ""
		if (ns.config.borderType == "neal") then
			prefix = ""
		elseif(ns.config.borderType == "abu") then
			prefix = "2"
		end	
		ns.config.textureBorder = "Interface\\AddOns\\oUF_Abu\\Media\\Border\\"..prefix.."borderNormal" 
		ns.config.textureBorderWhite = "Interface\\AddOns\\oUF_Abu\\Media\\Border\\"..prefix.."borderWhite"
		ns.config.textureBorderShadow = "Interface\\AddOns\\oUF_Abu\\Media\\Border\\"..prefix.."borderShadow"

		self:UnregisterEvent(event)
		self:RegisterEvent("PLAYER_LOGOUT") -- For cleaning DB on logout

		self:RegisterEvent("MODIFIER_STATE_CHANGED") -- Showing auras
		self:RegisterEvent("PLAYER_TARGET_CHANGED") -- Target sounds
		if not ns.Classic then
			self:RegisterEvent("PLAYER_FOCUS_CHANGED") -- Focus Sounds
		end

		-- Setup Options
		self:SetupOptions()

		-- Skin the Countdown/BG timers:
		self:RegisterEvent("START_TIMER")

		self.ADDON_LOADED = nil
	end
end
----------------------------------------------------------------------
-- Target changed sounds
local memory = { }
local function PlayTargetSounds(unit)
	if ( UnitExists(unit) ) then
		memory[unit] = true
		if ( UnitIsEnemy(unit, "player") ) then
			PlaySound(SOUNDKIT.IG_CREATURE_AGGRO_SELECT);
		elseif ( UnitIsFriend("player", unit) ) then
			PlaySound(SOUNDKIT.IG_CHARACTER_NPC_SELECT);
		else
			PlaySound(SOUNDKIT.IG_CHARACTER_NPC_SELECT);
		end
	elseif memory[unit] then
		memory[unit] = false
		PlaySound(SOUNDKIT.INTERFACE_SOUND_LOST_TARGET_UNIT);
	end
end

function oUFAbu:PLAYER_TARGET_CHANGED(self, event, ...)
	CloseDropDownMenus()
	PlayTargetSounds("target")
end

function oUFAbu:PLAYER_FOCUS_CHANGED(self, event, ...)
	PlayTargetSounds("focus")
end

----------------------------------------------------------------------
--	Skin the blizzard Countdown Timers
function oUFAbu:START_TIMER(event)
	for _, b in pairs(TimerTracker.timerList) do
		local bar = b["bar"]
		if (not bar.borderTextures) then
			bar:SetScale(1.132)
			bar:SetSize(220, 18)

			for i = 1, select("#", bar:GetRegions()) do
				local region = select(i, bar:GetRegions())

				if (region and region:GetObjectType() == "Texture") then
					region:SetTexture(nil)
				end

				if (region and region:GetObjectType() == "FontString") then
					region:ClearAllPoints()
					region:SetPoint("CENTER", bar)
				end
			end

			ns.CreateBorder(bar, 11, 3)

			local backdrop = select(1, bar:GetRegions())
			backdrop:SetTexture("Interface\\Buttons\\WHITE8x8")
			backdrop:SetVertexColor(0, 0, 0, 0.5)
			backdrop:SetAllPoints(bar)
		end

		bar:SetStatusBarTexture(ns.config.statusbar)
		for i = 1, select("#", bar:GetRegions()) do
			local region = select(i, bar:GetRegions())
			if (region and region:GetObjectType() == "FontString") then
				region:SetFont(ns.config.fontNumber, 13*ns.config.fontNumberSize, ns.config.fontNumberOutline)
			end
		end
	end
end
----------------------[[	View Auras      ]]-------------------------
function oUFAbu:MODIFIER_STATE_CHANGED(event, key, state)
	if 	
		( IsControlKeyDown() and (key == "LALT" or key == "RALT")) or
		( IsAltKeyDown() and (key == "LCTRL" or key == "RCTRL")) 
	then
		local a, b
		if state == 1 then
			a, b = "CustomFilter", "__CustomFilter"
		else
			a, b = "__CustomFilter", "CustomFilter"
		end
		for i = 1, #oUF.objects do
			local object = oUF.objects[i]
			if object.style == "oUF_Abu" then
				local buffs = object.Auras or object.Buffs
				local debuffs = object.Debuffs
				if buffs and buffs[a] then
					buffs[b] = buffs[a]
					buffs[a] = nil
					buffs:ForceUpdate()
				end
				if debuffs and debuffs[a] then
					debuffs[b] = debuffs[a]
					debuffs[a] = nil
					debuffs:ForceUpdate()
				end
			end
		end
	end
end

----------------------[[	Setup Options   ]]-------------------------
function oUFAbu:SetupOptions()
	local options = CreateFrame("Frame", OUF_ABUOPTIONS)
	options:Hide()
	options.name = "oUF Abu"

	local auras = CreateFrame("Frame", "oUF_AbuAuraFilters", options)
	auras.name = ns.L.AuraFilters
	auras.parent = options.name

	options:SetScript("OnShow", function(self)
		oUFAbu:LoadOptions()
		options:SetScript("OnShow", nil)
	end)

	InterfaceOptions_AddCategory(options)
	InterfaceOptions_AddCategory(auras)

	-- Nuke cancel button - prevents taint
	InterfaceOptionsFrameCancel:Hide()
	InterfaceOptionsFrameOkay:SetAllPoints(InterfaceOptionsFrameCancel)
	InterfaceOptionsFrameCancel:SetScript("OnClick", function()
		InterfaceOptionsFrameOkay:Click()
	end)

	_G.SLASH_OUFABU1 = "/ouf"
	_G.SLASH_OUFABU2 = "/oufabu"
	SlashCmdList["OUFABU"] = function(...)
		self:OnSlashCommand(...)
	end
end

function oUFAbu:LoadOptions()
	if IsAddOnLoaded(OUF_ABUOPTIONS) then return true; end

	if InCombatLockdown() then
		ns.Print(ns.L["OptionsLoadAfterCombat"])
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return false
	end
	self:PLAYER_REGEN_ENABLED()
end

function oUFAbu:PLAYER_REGEN_ENABLED(event)
	if event then
		self:UnregisterEvent(event)
	end

	self.localization = ns.L -- locale for options
	local loaded, reason = LoadAddOn(OUF_ABUOPTIONS)
	if not loaded then
		ns.Print(string.format(ADDON_LOAD_FAILED, OUF_ABUOPTIONS, _G["ADDON_"..reason]))
		return;
	end
	InterfaceOptionsFrame_OpenToCategory("oUF Abu")
	InterfaceOptionsFrame_OpenToCategory("oUF Abu")
end

function oUFAbu:OnSlashCommand(command)
	if (command == "lock" or command == "unlock") then
		self:ToggleAllAnchors()
	elseif self:LoadOptions() then
		InterfaceOptionsFrame_OpenToCategory("oUF Abu")
		InterfaceOptionsFrame_OpenToCategory("oUF Abu")
	end
end

function ns.Print(...)
	if (...) then
		return print("|cffffcf00oUF_Abu: |r"..select(1, ...), select(2, ...))
	end
end

-- i hate you effort
function oUFAbu:Print(...)
	return ns.Print(...)
end