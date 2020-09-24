local _, ns = ...

local textPath = 'Interface\\AddOns\\oUF_Abu\\Media\\Frames\\'

local function postUpdateArenaPreparation(self)
	local specID = GetArenaOpponentSpec(tonumber(self.id))
	if specID and specID > 0 then
		local _, spec, _, icon, _, class = GetSpecializationInfoByID(specID)
		self.Portrait:Show()
		SetPortraitToTexture(self.Portrait, icon)
		self.Portrait:SetVertexColor(1, 1, 1, 1)
		self.Name:SetText(ARENA .. " " .. tostring(self.id))
		self.Health.Value:SetText(spec)
		self.Health:SetMinMaxValues(0, 1)
		self.Health:SetValue(1)
		self.Health:SetStatusBarColor(unpack(oUF.colors.class[class]))
	end
end

local function updatePortrait(self, event, unit)
	local specID = GetArenaOpponentSpec(self.id)
	if specID then
		local _, _, _, icon = GetSpecializationInfoByID(specID)
		SetPortraitToTexture(self.Portrait, icon)
	elseif unit and UnitIsUnit(self.unit, unit) then
		SetPortraitTexture(self.Portrait, unit)
	end
end

function ns.createArenaLayout(self)
	local config = ns.config
	local uconfig = config[self.cUnit]

	self.Texture = self:CreateTexture(nil, 'BORDER')
	self.Texture:SetTexture(textPath.. 'Arena')
	self.Texture:SetSize(230, 100)
	self.Texture:SetPoint('TOPLEFT', self, -22, 14)
	self.Texture:SetTexCoord(0, 0.90625, 0, 0.78125)

	ns.PaintFrames(self.Texture)

	self.Health = ns.CreateStatusBar(self, nil, nil, true)
	self.Health:SetFrameLevel(self:GetFrameLevel()-1)
	self.Health:SetSize(117, 18)
	self.Health:SetPoint('TOPRIGHT', self.Texture, -43, -17)

	self.Power = ns.CreateStatusBar(self, nil, nil, true)
	self.Power:SetFrameLevel(self:GetFrameLevel()-1)
	self.Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -3)
	self.Power:SetPoint('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -3)
	self.Power:SetHeight(self.Health:GetHeight())

	self.Portrait = self.Health:CreateTexture(nil, 'BACKGROUND')
	self.Portrait:SetSize(64, 64)
	self.Portrait:SetPoint('TOPLEFT', self.Health, -64, 13)
	self.Portrait.Override = updatePortrait

	self.Health.Value = ns.CreateFontStringNumber(self.Health, 13)
	self.Health.Value:SetPoint('CENTER', self.Health)

	self.Power.Value = ns.CreateFontStringNumber(self.Health, 13)
	self.Power.Value:SetPoint('CENTER', self.Power)

	self:SetSize(167, 46)
	self:SetScale(ns.config.arena.scale)

	self.Health:SetStatusBarColor(unpack(config.healthcolor))
	self.Health.colorClass = config.healthcolormode == 'CLASS'
	self.Health.colorReaction = config.healthcolormode == 'CLASS'
	self.Health.colorSmooth = config.healthcolormode == 'NORMAL'

	self.Health.Smooth = true
	self.Health.PostUpdate = ns.PostUpdateHealth
	table.insert(self.mouseovers, self.Health)

	self.Power:SetStatusBarColor(unpack(config.powercolor))
	self.Power.colorClass = config.powercolormode == 'CLASS'
	self.Power.colorPower = config.powercolormode == 'TYPE'
	self.Power.useAtlas = config.powerUseAtlas

	self.Power.Smooth = true
	self.Power.PostUpdate = ns.PostUpdatePower
	table.insert(self.mouseovers, self.Power)

	-- name
	self.Name = ns.CreateFontStringName(self.Health, 14, 'CENTER')
	self.Name:SetSize(110, 10)
	self.Name:SetPoint('BOTTOM', self.Health, 'TOP', 0, 6)
	self:Tag(self.Name, '[abu:name]')

	-- PvPIndicator Icon
	self.PvPIndicator = self:CreateTexture(nil, 'OVERLAY')
	self.PvPIndicator:SetSize(40, 40)
	self.PvPIndicator:SetPoint('TOPLEFT', self.Texture, -20, -20)

	--portrait Timer
	self.PortraitTimer = CreateFrame('Frame', nil, self.Health)
	self.PortraitTimer.Icon = self.PortraitTimer:CreateTexture(nil, 'BACKGROUND')
	self.PortraitTimer.Icon:SetAllPoints(self.Portrait)

	self.PortraitTimer.Remaining = ns.CreateFontStringNumber(self.PortraitTimer, self.Portrait:GetWidth()/3.5, 'CENTER', 'OUTLINE')
	self.PortraitTimer.Remaining:SetPoint('CENTER', self.PortraitTimer.Icon)
	self.PortraitTimer.Remaining:SetTextColor(1, 1, 1)

	--Auras
	if (uconfig.enableBuff) then
		self.Buffs = ns.AddBuffs(self, 'TOPLEFT', 28, 5, 6, 1)
		self.Buffs:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', 0, -7)
		self.Buffs.CustomFilter = ns.CustomAuraFilters.arena
	end

	--Castbars
	if config.castbars and uconfig.cbshow then
		ns.CreateCastbars(self)
	end

	-- oUF_Trinkets support
	self.Trinket = CreateFrame('Frame', nil, self)
	self.Trinket:SetSize(25, 25)
	self.Trinket:SetFrameLevel(self:GetFrameLevel() + 2)
	self.Trinket:SetPoint('RIGHT', self.Health, 'LEFT', 0, 15)

	self.Trinket.Border = CreateFrame("Frame", nil, self.Trinket)
	self.Trinket.Border:SetFrameLevel(self.Trinket:GetFrameLevel() + 1)
	self.Trinket.Border:SetAllPoints()
	self.Trinket.Border.Texture = self.Trinket.Border:CreateTexture(nil, "OVERLAY")
	self.Trinket.Border.Texture:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	self.Trinket.Border.Texture:SetPoint("TOPLEFT", -6, 5)
	self.Trinket.Border.Texture:SetSize(60, 60)

	ns.PaintFrames(self.Trinket.Border.Texture)

	self.PostUpdate = postUpdateArenaPreparation

	return self
end

