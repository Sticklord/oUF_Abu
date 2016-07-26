local _, ns = ...
ns.classModule = {}

local function updateTotemPosition()
	local _, class = UnitClass("player")
	TotemFrame:ClearAllPoints()
	
	if ( class == "PALADIN" or class == "DEATHKNIGHT"  ) then
		local hasPet = oUF_AbuPet and oUF_AbuPet:IsShown();
		if (hasPet) then
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", -18, -12);
		else
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 17, 0);
		end
	elseif ( class == "DRUID" ) then
		local form  = GetShapeshiftFormID();
		if ( form == CAT_FORM ) then
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 37, -5);
		else
			TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 57, 0);
		end	
	elseif ( class == "MAGE" ) then
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", 0, -12);
	elseif ( class == "MONK" ) then
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", -18, -12);
	elseif ( class == "SHAMAN" ) then
		local form  = GetShapeshiftFormID();
		if ( ( GetSpecialization() == SPEC_SHAMAN_RESTORATION ) or ( form == 16 ) ) then -- wolf form 
			TotemFrame:SetPoint('TOP', oUF_AbuPlayer, 'BOTTOM', 27, 2)
		else
			TotemFrame:SetPoint('TOP', oUF_AbuPlayer, 'BOTTOM', 27, -10)
		end		
	elseif ( class == "WARLOCK" ) then
		TotemFrame:SetPoint("TOPLEFT", oUF_AbuPlayer, "BOTTOMLEFT", -18, -12);
	end
end

function ns.classModule.Totems(self, config, uconfig) --totems overlap manabar but so did blizzards
	TotemFrame:ClearAllPoints()
	TotemFrame:SetParent(self)
	TotemFrame:SetScale(uconfig.scale * 0.81)

	for i = 1, MAX_TOTEMS do
		local _, totemBorder = _G['TotemFrameTotem'..i]:GetChildren()
		ns.PaintFrames(totemBorder:GetRegions())

		_G['TotemFrameTotem'..i]:SetFrameStrata('LOW')
		_G['TotemFrameTotem'..i.. 'Duration']:SetParent(totemBorder)
		_G['TotemFrameTotem'..i.. 'Duration']:SetDrawLayer('OVERLAY')
		_G['TotemFrameTotem'..i.. 'Duration']:ClearAllPoints()
		_G['TotemFrameTotem'..i.. 'Duration']:SetPoint('BOTTOM', _G['TotemFrameTotem'..i], 0, 3)
		_G['TotemFrameTotem'..i.. 'Duration']:SetFont(config.fontNormal, 10, 'OUTLINE')
		_G['TotemFrameTotem'..i.. 'Duration']:SetShadowOffset(0, 0)
	end
	
	_G.TotemFrame_AdjustPetFrame = function() end -- noop these else we'll get taint
	_G.PlayerFrame_AdjustAttachments = function() end
	
	hooksecurefunc("TotemFrame_Update", updateTotemPosition)
	updateTotemPosition()
end

function ns.classModule.alternatePowerBar(self, config, uconfig)
	self.DruidMana = ns.CreateOutsideBar(self, false, 0, 0, 1)
	self.DruidMana.colorPower = true

	self.DruidMana.Value = ns.CreateFontString(self.DruidMana, 13, 'CENTER')
	self.DruidMana.Value:SetPoint('CENTER', self.DruidMana, 0, 0.5)
	self.DruidMana.Value:Hide()
	self:Tag(self.DruidMana.Value, '[druidmana]')
end

function ns.classModule.DEATHKNIGHT(self, config, uconfig)
	if (config.DEATHKNIGHT.showRunes) then
		RuneFrame:SetParent(self)
		RuneFrame_OnLoad(RuneFrame)
		RuneFrame:ClearAllPoints()
		RuneFrame:SetPoint('TOP', self, 'BOTTOM', 33, -1)
		if (ns.config.playerStyle == 'normal') then 
			RuneFrame:SetFrameStrata("LOW");
		end
		for i = 1, 6 do
			local b = _G['RuneButtonIndividual'..i]
		end
	end
end

function ns.classModule.MAGE(self, config, uconfig) --part of ClassPowerBar
	if (config.MAGE.showArcaneStacks) then
		MageArcaneChargesFrame:SetParent(self)
		MageArcaneChargesFrame:ClearAllPoints()
		MageArcaneChargesFrame:SetPoint('TOP', self, 'BOTTOM', 30, -0.5)
	end
end

function ns.classModule.MONK(self, config, uconfig)
	if (config.MONK.showStagger) then
		MonkStaggerBar:SetParent(self)
		MonkStaggerBar:SetScale(uconfig.scale * .81)
		MonkStaggerBar_OnLoad(MonkStaggerBar)
		MonkStaggerBar:ClearAllPoints()
		MonkStaggerBar:SetPoint('TOP', self, 'BOTTOM', 31, 0)
		ns.PaintFrames(MonkStaggerBar.MonkBorder, 0.3)
		MonkStaggerBar:SetFrameLevel(1)
	end

	if (config.MONK.showChi) then
		MonkHarmonyBarFrame:SetParent(self)
		MonkHarmonyBarFrame:SetScale(uconfig.scale * 0.81)
		MonkHarmonyBarFrame:ClearAllPoints()
		MonkHarmonyBarFrame:SetPoint('TOP', self, 'BOTTOM', 31, 18)
		ns.PaintFrames(select(2, MonkHarmonyBarFrame:GetRegions()), 0.1)
	end
end

function ns.classModule.PALADIN(self, config, uconfig)
	if (config.PALADIN.showHolyPower) then
		PaladinPowerBarFrame:SetParent(self)
		PaladinPowerBarFrame:SetScale(uconfig.scale * 0.81)
		PaladinPowerBarFrame:ClearAllPoints()
		PaladinPowerBarFrame:SetPoint('TOP', self, 'BOTTOM', 27, 4)
		PaladinPowerBarFrame:SetFrameStrata("LOW");
	end
end

function ns.classModule.PRIEST(self, config, uconfig)
	if (config.PRIEST.showInsanity) then
		InsanityBarFrame:SetParent(self) 
		InsanityBarFrame:ClearAllPoints()
		InsanityBarFrame:SetPoint('BOTTOMRIGHT', self, 'TOPLEFT', 52, -50)
	end
end

function ns.classModule.WARLOCK(self, config, uconfig)
	if (config.WARLOCK.showShards) then
		WarlockPowerFrame:SetParent(self)
		WarlockPowerFrame:ClearAllPoints()
		WarlockPowerFrame:SetPoint('TOP', self, 'BOTTOM', 29, -2)
		if (ns.config.playerStyle == 'normal') then 
			WarlockPowerFrame:SetFrameStrata("LOW");
		end
		for i = 1, 5 do
			local shard = _G["WarlockPowerFrameShard"..i];
		end
	end
end
