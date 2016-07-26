local _, ns = ...
local config

local textPath = 'Interface\\AddOns\\oUF_Abu\\Media\\Frames\\'

local function CreateBaseFrames(self)
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

	self.Health.Value = ns.CreateFontString(self.Health, 13)
	self.Health.Value:SetPoint('CENTER', self.Health)

	self.Power.Value = ns.CreateFontString(self.Health, 13)
	self.Power.Value:SetPoint('CENTER', self.Power)

	self:SetSize(167, 46)
	self:SetScale(ns.config.arena.scale)
end

local function CreateArenaLayout(self, unit)
	self.cUnit = ns.cUnit(unit)
	local uconfig = ns.config[self.cUnit]

	self:RegisterForClicks('AnyUp')
	
	if (config.focBut ~= 'NONE') then
		self:SetAttribute(config.focMod.."type"..config.focBut, 'focus')
	end
	self.mouseovers = {}
	
	self:HookScript("OnEnter", ns.UnitFrame_OnEnter)
	self:HookScript("OnLeave", ns.UnitFrame_OnLeave)

	CreateBaseFrames(self)

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

	self.Power.Smooth = true
	self.Power.PostUpdate = ns.PostUpdatePower	
	table.insert(self.mouseovers, self.Power)

	-- name
	self.Name = ns.CreateFontStringBig(self.Health, 14, 'CENTER')
	self.Name:SetSize(110, 10)
	self.Name:SetPoint('BOTTOM', self.Health, 'TOP', 0, 6)
	self:Tag(self.Name, '[name]')
	self.UNIT_NAME_UPDATE = UpdateFrame

	-- raidicons (justin case)
	self.RaidIcon = self:CreateTexture(nil, 'OVERLAY', self)
	self.RaidIcon:SetPoint('CENTER', self.Portrait, 'TOP', 0, -1)
	self.RaidIcon:SetTexture('Interface\\TargetingFrame\\UI-RaidTargetingIcons')
	self.RaidIcon:SetSize(26, 26)

	-- PvP Icon
	self.PvP = self:CreateTexture(nil, 'OVERLAY')
	self.PvP:SetSize(40, 40)
	self.PvP:SetPoint('TOPLEFT', self.Texture, -20, -20)

	--portrait Timer
	self.PortraitTimer = CreateFrame('Frame', nil, self.Health)
	self.PortraitTimer.Icon = self.PortraitTimer:CreateTexture(nil, 'BACKGROUND')
	self.PortraitTimer.Icon:SetAllPoints(self.Portrait)

	self.PortraitTimer.Remaining = ns.CreateFontString(self.PortraitTimer, self.Portrait:GetWidth()/3.5, 'CENTER')
	self.PortraitTimer.Remaining:SetPoint('CENTER', self.PortraitTimer.Icon)
	self.PortraitTimer.Remaining:SetTextColor(1, 1, 1)

	--Auras
	self.Buffs = ns.AddBuffs(self, 'TOPLEFT', 28, 5, 6, 1)
	self.Buffs:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT', 0, -7)
	self.Buffs.CustomFilter   = ns.CustomAuraFilters.arena

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

	return self
end

oUF:RegisterStyle('oUF_AbuArena', CreateArenaLayout)
oUF:Factory(function(self)
	config = ns.config
	if not(config.showArena) then return end

	oUF:SetActiveStyle('oUF_AbuArena')

	local arena = {}
	for i = 1, 5 do
		arena[i] = self:Spawn('arena'..i, 'oUF_AbuArenaFrame'..i)
		if (i == 1) then
			arena[i]:SetPoint('TOPRIGHT', UIParent)
		else
			arena[i]:SetPoint('TOPLEFT', arena[i-1], 'BOTTOMLEFT', 0, -40)
		end
	end
	
	local a = ns.CreateUnitAnchor(arena[1], arena[1], arena[5], nil, "arena1", "arena2", "arena3", "arena4", "arena5")
	--arena[1]:SetPoint('TOPRIGHT', a)

	local arenaprep = {}
	for i = 1, 5 do
		arenaprep[i] = CreateFrame('Frame', 'oUF_AbuArenaPrep '..i, UIParent)
		arenaprep[i]:SetAllPoints(arena[i])

		CreateBaseFrames(arenaprep[i])
		arenaprep[i].Power:SetStatusBarTexture('Interface\\Buttons\\WHITE8x8')

		arenaprep[i]:Hide()
	end

	local arenaprepUpdate = CreateFrame("Frame")
	arenaprepUpdate:RegisterEvent("PLAYER_ENTERING_WORLD")
	arenaprepUpdate:RegisterEvent("ARENA_OPPONENT_UPDATE")
	arenaprepUpdate:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
	arenaprepUpdate:SetScript("OnEvent", function(self, event)
		if event == "ARENA_OPPONENT_UPDATE" then
			for i = 1, 5 do
				arenaprep[i]:Hide()
			end
		else
			local numOpps = GetNumArenaOpponentSpecs()

			if numOpps > 0 then
				for i = 1, 5 do
					local f = arenaprep[i]

					if i <= numOpps then
						local specID = GetArenaOpponentSpec(i)
						local icon, spec, class = "Interface\\Icons\\Spell_Shadow_SacrificialShield", "UNKNOWN", "UNKNOWN"

						if specID and specID > 0 then
							_, spec, _, icon, _, _, class = GetSpecializationInfoByID(specID)
						end

						if class and icon then
							local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
							if color then
								f.Health:SetStatusBarColor(color.r, color.g, color.b)
							else
								f.Health:SetStatusBarColor(0,1,0)
							end
							f.Power:SetStatusBarColor(0,0,0)
							f.Power:SetAlpha(0.55)
							f.Health.Value:SetText("arena"..i)
							f.Power.Value:SetText(spec)
							SetPortraitToTexture(arenaprep[i].Portrait, icon)
							SetPortraitToTexture(arena[i].Portrait, icon)
							f:Show()
						end
					else
						f:Hide()
					end
				end
			else
				for i = 1, 5 do
					arenaprep[i]:Hide()
				end
			end
		end
	end)
end)

-- For testing /run oUFAbu.TestArena()
function oUFAbu:TestArena()
	oUF_AbuArenaFrame1:Show(); oUF_AbuArenaFrame1.Hide = function() end oUF_AbuArenaFrame1.unit = "target"
	oUF_AbuArenaFrame2:Show(); oUF_AbuArenaFrame2.Hide = function() end oUF_AbuArenaFrame2.unit = "target"
	oUF_AbuArenaFrame3:Show(); oUF_AbuArenaFrame3.Hide = function() end oUF_AbuArenaFrame3.unit = "target"
	oUF_AbuArenaFrame4:Show(); oUF_AbuArenaFrame4.Hide = function() end oUF_AbuArenaFrame4.unit = "target"
	oUF_AbuArenaFrame5:Show(); oUF_AbuArenaFrame5.Hide = function() end oUF_AbuArenaFrame5.unit = "target"
	local time = 0
	local f = CreateFrame("Frame")
	f:SetScript("OnUpdate", function(self, elapsed)
		time = time + elapsed
		if time > 5 then
			oUF_AbuArenaFrame1:UpdateAllElements("ForceUpdate")
			oUF_AbuArenaFrame2:UpdateAllElements("ForceUpdate")
			oUF_AbuArenaFrame3:UpdateAllElements("ForceUpdate")
			oUF_AbuArenaFrame4:UpdateAllElements("ForceUpdate")
			oUF_AbuArenaFrame5:UpdateAllElements("ForceUpdate")
			time = 0
		end
	end)
end
