local _, ns = ...
ns.classModule = {}

local function updateTotemPosition()
	local _, class = UnitClass("player")
	TotemFrame:ClearAllPoints()
	if (class == "PALADIN" or class == "DEATHKNIGHT") then
		local hasPet = oUF_AbuPet and oUF_AbuPet:IsShown()
		if (hasPet) then
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", -18, -12)
		else
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 17, 0)
		end
	elseif (class == "DRUID") then
		local form  = GetShapeshiftFormID()
		if (form == CAT_FORM) then
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 37, -5)
		else
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 57, 0)
		end
	elseif (class == "MAGE") then
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 0, -12)
	elseif (class == "MONK") then
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", -18, -12)
	elseif (class == "SHAMAN") then
		local form  = GetShapeshiftFormID()
		TotemFrame:SetPoint("TOP", oUF_AbuPlayer, "BOTTOM", 27, -10)
		if not ns.Classic then
			if ((GetSpecialization() == SPEC_SHAMAN_RESTORATION) or (form == 16)) then -- wolf form
				TotemFrame:SetPoint("TOP", oUF_AbuPlayer, "BOTTOM", 27, 2)
			end
		end
	elseif (class == "WARLOCK") then
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", -18, -12)
	end
end

function ns.classModule.Totems(self, config, uconfig)
	TotemFrame:ClearAllPoints()
	TotemFrame:SetParent(self)
	TotemFrame:SetScale(uconfig.scale * 0.81)

	for i = 1, MAX_TOTEMS do
		local _, totemBorder = _G["TotemFrameTotem"..i]:GetChildren()
		ns.PaintFrames(totemBorder:GetRegions())

		_G["TotemFrameTotem"..i]:SetFrameStrata("LOW")
		_G["TotemFrameTotem"..i.. "Duration"]:SetParent(totemBorder)
		_G["TotemFrameTotem"..i.. "Duration"]:SetDrawLayer("OVERLAY")
		_G["TotemFrameTotem"..i.. "Duration"]:ClearAllPoints()
		_G["TotemFrameTotem"..i.. "Duration"]:SetPoint("BOTTOM", _G["TotemFrameTotem"..i], 0, 3)
		_G["TotemFrameTotem"..i.. "Duration"]:SetFont(config.fontNumber, 10, "OUTLINE")
		_G["TotemFrameTotem"..i.. "Duration"]:SetShadowOffset(0, 0)
	end

	_G.TotemFrame_AdjustPetFrame = function() end -- noop these else we"ll get taint
	_G.PlayerFrame_AdjustAttachments = function() end

	hooksecurefunc("TotemFrame_Update", updateTotemPosition)
	updateTotemPosition()
end

function ns.classModule.additionalPowerBar(self)
	self.AdditionalPower = ns.CreateOutsideBar(self, false, 0, 0, 1)
	self.AdditionalPower.colorPower = true

	self.AdditionalPower.Value = ns.CreateFontStringNumber(self.AdditionalPower, 13, "CENTER")
	self.AdditionalPower.Value:SetPoint("CENTER", self.AdditionalPower, 0, 0.5)
	self.AdditionalPower.Value:Hide()
	self:Tag(self.AdditionalPower.Value, "[abu:additionalpower]")
end

function ns.classModule.DEATHKNIGHT(self, config)
	if (config.DEATHKNIGHT.showRunes) then
		RuneFrame:SetParent(self)
		RuneFrame:ClearAllPoints()
		RuneFrame:SetPoint("TOP", self, "BOTTOM", 33, -1)
		if (ns.config.playerStyle == "normal") then
			RuneFrame:SetFrameStrata("LOW")
		end
		for _, v in next, RuneFrame.Runes do
			ns.PaintFrames(v.Rune, 0.3)
		end
	end
end

function ns.classModule.MAGE(self, config)
	if (config.MAGE.showArcaneStacks) then
		MageArcaneChargesFrame:SetParent(self)
		MageArcaneChargesFrame:ClearAllPoints()
		MageArcaneChargesFrame:SetPoint("TOP", self, "BOTTOM", 30, -0.5)
		--ns.PaintFrames(select(2, MonkHarmonyBar:GetRegions()), 0.1)
		return MageArcaneChargesFrame
	end
end

function ns.classModule.MONK(self, config, uconfig)
	if (config.MONK.showStagger) then
		-- Stagger Bar for tank monk
		MonkStaggerBar:SetParent(self)
		MonkStaggerBar:SetScale(uconfig.scale * .81)
		MonkStaggerBar_OnLoad(MonkStaggerBar)
		MonkStaggerBar:ClearAllPoints()
		MonkStaggerBar:SetPoint("TOP", self, "BOTTOM", 31, 0)
		ns.PaintFrames(MonkStaggerBar.MonkBorder, 0.3)
		MonkStaggerBar:SetFrameLevel(1)
	end

	if (config.MONK.showChi) then
		-- Monk combo points for Windwalker
		MonkHarmonyBarFrame:SetParent(self)
		MonkHarmonyBarFrame:SetScale(uconfig.scale * 0.81)
		MonkHarmonyBarFrame:ClearAllPoints()
		MonkHarmonyBarFrame:SetPoint("TOP", self, "BOTTOM", 31, 18)
		local _, bg = MonkHarmonyBarFrame:GetRegions()
		bg:SetDrawLayer("BACKGROUND")
		MonkHarmonyBarFrame:SetFrameLevel(2)
		ns.PaintFrames(bg, 0.1)

		for _,ball in pairs({MonkHarmonyBarFrame:GetChildren()}) do
			ball:EnableMouse(false)
		end
		return MonkHarmonyBarFrame
	end
end

function ns.classModule.PALADIN(self, config, uconfig)
	if (config.PALADIN.showHolyPower) then
		PaladinPowerBarFrame:SetParent(self)
		PaladinPowerBarFrame:SetScale(uconfig.scale * 0.81)
		PaladinPowerBarFrame:ClearAllPoints()
		PaladinPowerBarFrame:SetPoint("TOP", self, "BOTTOM", 27, 4)
		PaladinPowerBarFrame:SetFrameStrata("LOW")
		ns.PaintFrames(PaladinPowerBarFrameBG, 0.1)
		return PaladinPowerBarFrame
	end
end

function ns.classModule.PRIEST(self, config)
	if (config.PRIEST.showInsanity) then
		InsanityBarFrame:SetParent(self)
		InsanityBarFrame:ClearAllPoints()
		InsanityBarFrame:SetPoint("BOTTOMRIGHT", self, "TOPLEFT", 52, -50)
		return InsanityBarFrame
	end
end

function ns.classModule.WARLOCK(self, config)
	if (config.WARLOCK.showShards) then
		WarlockPowerFrame:SetParent(self)
		WarlockPowerFrame:ClearAllPoints()
		WarlockPowerFrame:SetPoint("TOP", self, "BOTTOM", 29, -2)
		if (ns.config.playerStyle == "normal") then
			WarlockPowerFrame:SetFrameStrata("LOW")
		end
		local shard = WarlockPowerFrame.Shards[#WarlockPowerFrame.Shards]
		while shard do
			--ns.PaintFrames(select(5,shard:GetRegions()), .2)

			shard = shard.previousShard
		end
		ns.PaintFrames(WarlockPowerFrame:GetRegions(), 0)
		return WarlockPowerFrame
	end
end

function ns.classModule.addAuraBar(self, config)
	local Aurabar = ns.CreateOutsideBar(self, true, 1, 0, 0)
	Aurabar:SetFrameLevel(1)

	Aurabar.Visibility = function(self)
		local bar = self.Aurabar
		if ns.Classic then return false end
		local index = GetSpecialization()
		if not index then return false end

		local specID = GetSpecializationInfo(index)
		local barconfig = config.classBar[specID]
		if barconfig then
			bar:SetStatusBarColor(barconfig.r, barconfig.g, barconfig.b)
			bar.spellID = barconfig.spellID
			return GetSpellInfo(bar.spellID)
		end
		return false
	end
	return Aurabar
end
