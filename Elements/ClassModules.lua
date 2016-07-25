local _, ns = ...
ns.classModule = {}

function ns.classModule.Totems(self, config, uconfig) --totems overlap manabar but so did blizzards
	if self.cUnit ~= "player" then return; end

	TotemFrame:ClearAllPoints()
	TotemFrame:SetPoint('TOP', self.Power, 'BOTTOM', -4, 2)
	TotemFrame:SetParent(self)
	TotemFrame:SetScale(uconfig.scale * 0.81)
	TotemFrame:Show()

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
	
	
end

function ns.classModule.alternatePowerBar(self, config, uconfig)
	if self.cUnit ~= "player" then return; end
	-- Druid Manabar
	self.DruidMana = ns.CreateOutsideBar(self, false, 0, 0, 1)
	self.DruidMana.colorPower = true

	self.DruidMana.Value = ns.CreateFontString(self.DruidMana, 13, 'CENTER')
	self.DruidMana.Value:SetPoint('CENTER', self.DruidMana, 0, 0.5)
	self.DruidMana.Value:Hide()
	self:Tag(self.DruidMana.Value, '[druidmana]')
end

function ns.classModule.DEATHKNIGHT(self, config, uconfig)
	if self.cUnit ~= "player" or not config.DEATHKNIGHT then return; end
	RuneFrame:SetParent(self)
	RuneFrame_OnLoad(RuneFrame)
	RuneFrame:ClearAllPoints()
	RuneFrame:SetPoint('TOP', self, 'BOTTOM', 33, -1)
	RuneFrame:SetFrameStrata("LOW");
	for i = 1, 6 do
		local b = _G['RuneButtonIndividual'..i]
	end
end

function ns.classModule.DRUID(self, config, uconfig)
	if self.cUnit ~= "player" or not config.DRUID then return; end
	
	hooksecurefunc("TotemFrame_Update", function()	
		local form  = GetShapeshiftFormID();
		if ( form == CAT_FORM ) then
			TotemFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 37, -5);
		else
			TotemFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 57, 0);
		end	
	end)
end

function ns.classModule.MAGE(self, config, uconfig) --part of ClassPowerBar
	if self.cUnit ~= "player" or not config.MAGE then return; end
		MageArcaneChargesFrame:SetParent(self)
		MageArcaneChargesFrame:ClearAllPoints()
		MageArcaneChargesFrame:SetPoint('TOP', self, 'BOTTOM', 30, -0.5)
		-- Arcane (Arcane Familiar)
		hooksecurefunc("TotemFrame_Update", function()	
			TotemFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -12);
		end)
end

function ns.classModule.MONK(self, config, uconfig)
	if self.cUnit ~= "player" or not config.MONK then return; end
	-- Stagger Bar for tank monk
	MonkStaggerBar:SetParent(self)
	MonkStaggerBar:SetScale(uconfig.scale * .81)
	MonkStaggerBar_OnLoad(MonkStaggerBar)
	MonkStaggerBar:ClearAllPoints()
	MonkStaggerBar:SetPoint('TOP', self, 'BOTTOM', 31, 0)
	ns.PaintFrames(MonkStaggerBar.MonkBorder, 0.3)
	MonkStaggerBar:SetFrameLevel(1)

	-- Monk combo points for Windwalker, part of ClassPowerBar
	MonkHarmonyBarFrame:SetParent(self)
	MonkHarmonyBarFrame:SetScale(uconfig.scale * 0.81)
	MonkHarmonyBarFrame:ClearAllPoints()
	MonkHarmonyBarFrame:SetPoint('TOP', self, 'BOTTOM', 31, 18)
	ns.PaintFrames(select(2, MonkHarmonyBarFrame:GetRegions()), 0.1)
end

function ns.classModule.PALADIN(self, config, uconfig)
	if self.cUnit ~= "player" or not config.PALADIN then return; end
	PaladinPowerBarFrame:SetParent(self)
	PaladinPowerBarFrame:SetScale(uconfig.scale * 0.81)
	PaladinPowerBarFrame:ClearAllPoints()
	PaladinPowerBarFrame:SetPoint('TOP', self, 'BOTTOM', 27, 4)
	PaladinPowerBarFrame:SetFrameStrata("LOW");
end

function ns.classModule.PRIEST(self, config, uconfig)
	if self.cUnit ~= "player" or not config.PRIEST then return; end
		InsanityBarFrame:SetParent(self) 
		InsanityBarFrame:ClearAllPoints()
		InsanityBarFrame:SetPoint('BOTTOMRIGHT', self, 'TOPLEFT', 52, -50)
end

function ns.classModule.WARLOCK(self, config, uconfig)
	if self.cUnit ~= "player" or not config.WARLOCK then return; end
	WarlockPowerFrame:SetParent(self)
	WarlockPowerFrame:ClearAllPoints()
	WarlockPowerFrame:SetPoint('TOP', self, 'BOTTOM', 29, -2)
	WarlockPowerFrame:SetFrameStrata("LOW");
	for i = 1, 5 do
		local shard = _G["WarlockPowerFrameShard"..i];
	end
	-- Affliction (Soul Effigl)
	hooksecurefunc("TotemFrame_Update", function()	
		TotemFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -18, -12);
	end)
end
