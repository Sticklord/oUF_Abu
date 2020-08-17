local _, ns = ...
local colors = oUF.colors

local ignorePetSpells = {
	[115746] = true, -- Felbolt  (Green Imp)
	[3110] = true,	-- firebolt (imp)
	[31707] = true,	-- waterbolt (water elemental)
	[85692] = true,  -- Doom Bolt
}

------------------------------------------------------------------
--	Channeling ticks, based on Castbars by Xbeeps				--
------------------------------------------------------------------
local CastingBarFrameTicksSet
do
	local GetSpellInfo, GetCombatRatingBonus = GetSpellInfo, GetCombatRatingBonus
	local _, class = UnitClass("player")

	-- Negative means not modified by haste
	local BaseTickDuration = { }
	if class == "WARLOCK" then
		BaseTickDuration[689] = 1 -- Drain Life
		BaseTickDuration[1120] = 2 -- Drain Soul
		BaseTickDuration[755] = 1 -- Health Funnel
		BaseTickDuration[5740] = 2 -- Rain of Fire
		BaseTickDuration[1949] = 1 -- Hellfire
		BaseTickDuration[103103] = 1 -- Malefic Grasp
		BaseTickDuration[108371] = 1 -- Harvest Life
	elseif class == "DRUID" then
		BaseTickDuration[740] = 2 -- Tranquility
		BaseTickDuration[16914] = 1 -- Hurricane
		BaseTickDuration[106996] = 1 -- Astral STORM
		BaseTickDuration[127663] = -1 -- Astral Communion
	elseif class == "PRIEST" then
		local mind_flay_TickTime = 1
		if IsSpellKnown(157223) then --Enhanced Mind Flay
			mind_flay_TickTime = 2/3
		end
		BaseTickDuration[47540] = 1 -- Penance
		BaseTickDuration[15407] =  mind_flay_TickTime -- Mind Flay
		BaseTickDuration[129197] = mind_flay_TickTime -- Mind Flay (Insanity)
		BaseTickDuration[48045] = 1 -- Mind Sear
		BaseTickDuration[179337] = 1 -- Searing Insanity
		BaseTickDuration[64843] = 2 -- Divine Hymn
		BaseTickDuration[64901] = 2 -- Hymn of Hope
	elseif class == "MAGE" then
		BaseTickDuration[10] = 1 -- Blizzard
		BaseTickDuration[5143] = 0.5 -- Arcane Missiles
		--BaseTickDuration[12051] = 2 -- Evocation
	elseif class == "MONK" then
		BaseTickDuration[117952] = 1 -- Crackling Jade Lightning
		BaseTickDuration[113656] = 1 -- Fists of Fury
		BaseTickDuration[115294] = -1 -- Mana Tea
	end

	local function CreateATick(Castbar)
		local spark = Castbar:CreateTexture(nil, "OVERLAY", nil, 1)
		spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
		spark:SetVertexColor(1, 1, 1, 1)
		spark:SetBlendMode("ADD")
		spark:SetWidth(10)
		table.insert(Castbar.ticks, spark)
		return spark
	end

	function CastingBarFrameTicksSet(Castbar, unit, spellID)
		Castbar.ticks = Castbar.ticks or {}
		for _,tick in ipairs(Castbar.ticks) do
			tick:Hide()
		end
		if (not unit) then return end
		if (Castbar) then
			local baseTickDuration = BaseTickDuration[spellID]
			local tickDuration
			if (baseTickDuration) then
				if (baseTickDuration > 0) then
					local castTime-- = select(7, GetSpellInfo(2060))
					--if (not castTime or (castTime == 0)) then
						castTime = 2500 / (1 + (GetCombatRatingBonus(CR_HASTE_SPELL) or 0) / 100)
					--end
					tickDuration = (castTime / 2500) * baseTickDuration
				else
					tickDuration = -baseTickDuration
				end                
			end
			if (tickDuration) then
				local width = Castbar:GetWidth()
				local delta = (tickDuration * width / Castbar.max)
				local i = 1
				while (delta * i) < width do
					if i > #Castbar.ticks then CreateATick(Castbar) end
					local tick = Castbar.ticks[i]
					tick:SetHeight(Castbar:GetHeight() * 1.5)
					tick:SetPoint("CENTER", Castbar, "LEFT", delta * i, 0)
					tick:Show()
					i = i + 1
				end
			end
		end
	end
end

------------------------------------------------------------------
--						Setup Castbars 							--
------------------------------------------------------------------
local BasePos = {
	boss =		{"TOPRIGHT", "TOPLEFT", -10, 0},
	arena = 	{"TOPRIGHT", "TOPLEFT", -30, -10},
}
local function UnrealCastbar(castbar)
	castbar.duration = 0
	castbar.max = 300
	castbar:SetMinMaxValues(0, castbar.max)
	castbar:SetValue(castbar.duration)

	castbar.casting = 1
	castbar.delay = 0
	castbar.holdTime = 0
	castbar.fadeOut = nil
	castbar.channeling = nil

	if(castbar.Text) then castbar.Text:SetText"Fake Cast" end
	if(castbar.Icon) then castbar.Icon:SetTexture[[Interface\Icons\INV_Misc_Rune_01]] end
	if(castbar.Time) then castbar.Time:SetText() end
	if(castbar.Spark)then castbar.Spark:Show() end
	castbar:SetAlpha(1.0)
	castbar:Show()
	if(castbar.PostCastStart) then
		castbar:PostCastStart("player", "Fake Cast", 0)
	end
end
function ns.CreateCastbars(self)
	local uconfig = ns.config[self.cUnit]
	if not uconfig.cbshow then return end

	local Castbar = ns.CreateStatusBar(self, "BORDER", self:GetName().."Castbar")
	Castbar.__owner = self
	Castbar:SetSize(uconfig.cbwidth, uconfig.cbheight)
	Castbar:SetScale(uconfig.cbscale or 1)
	Castbar:SetFrameStrata("HIGH")
	ns.CreateBorder(Castbar, 12, 3)
	Castbar:SetBorderPadding(3, 2, 3, 3)

	if (BasePos[self.cUnit]) then
		local point, rpoint, x, y = unpack(BasePos[self.cUnit])
		Castbar:SetPoint(point, self, rpoint, x + uconfig.cboffset[1], y + uconfig.cboffset[2])
	else
		ns.CreateCastbarAnchor(Castbar)
	end

	Castbar.Background = Castbar:CreateTexture(nil, "BACKGROUND")
	Castbar.Background:SetTexture("Interface\\Buttons\\WHITE8x8")
	Castbar.Background:SetAllPoints(Castbar)

	if (self.cUnit == "player") then
		local SafeZone = Castbar:CreateTexture(nil, "BORDER") 
		SafeZone:SetTexture(ns.config.statusbar)
		SafeZone:SetVertexColor(unpack(ns.config.castbarSafezoneColor))
		table.insert(ns.statusbars, SafeZone)
		Castbar.SafeZone = SafeZone
		Castbar.Ticks = ns.config.castbarticks
	end
	
	local Spark = Castbar:CreateTexture(nil, "ARTWORK", nil, 1)
	Spark:SetSize(15, (uconfig.cbheight * 2))
	Spark:SetBlendMode("ADD")
	Castbar.Spark = Spark

	if (uconfig.cbicon ~= "NONE") then
		local Icon = Castbar:CreateTexture(nil, "ARTWORK")
		Icon:SetSize(uconfig.cbheight + 2, uconfig.cbheight + 2)
		Icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		if (uconfig.cbicon == "RIGHT") then
			Icon:SetPoint("LEFT", Castbar, "RIGHT", 0, 0)
			Castbar:SetBorderPadding(3, 2, 3, 4 + uconfig.cbheight)
		elseif (uconfig.cbicon == "LEFT") then
			Icon:SetPoint("RIGHT", Castbar, "LEFT", 0, 0)
			Castbar:SetBorderPadding(3, 2, 4 + uconfig.cbheight, 3)
		end
		Castbar.Icon = Icon
	end

	Castbar.Time = ns.CreateFontStringBar(Castbar, 13, "RIGHT")
	Castbar.Time:SetPoint("RIGHT", Castbar, -5, 0)
	Castbar.Time:SetFont(ns.config.fontBar, 12, ns.config.fontBarOutline)

	Castbar.Text = ns.CreateFontStringBar(Castbar, 13, "LEFT")
	Castbar.Text:SetPoint("LEFT", Castbar, 4, 0)
	Castbar.Text:SetPoint("RIGHT", Castbar, "RIGHT", -40, 0)
	Castbar.Text:SetFont(ns.config.fontBar, 12, ns.config.fontBarOutline)
	Castbar.Text:SetWordWrap(false)

	Castbar.PostCastStart = ns.PostCastStart
	Castbar.PostCastFailed = ns.PostCastFailed
	Castbar.PostCastInterrupted = ns.PostCastInterrupted
	Castbar.PostCastInterruptible = ns.UpdateCastbarColor
	Castbar.PostCastNotInterruptible = ns.UpdateCastbarColor
	Castbar.PostCastStop = ns.PostStop
	Castbar.PostChannelStop = ns.PostStop
	Castbar.PostChannelStart = ns.PostChannelStart
	Castbar.PostChannelUpdate = ns.PostChannelStart

	Castbar.DummyCastbar = UnrealCastbar

	self.Castbar = Castbar
end

function ns.PostCastStart(Castbar, unit, castID, spellID)
	if (unit == "pet") then
		Castbar:SetAlpha(1)
		if ignorePetSpells[spellID] then
			Castbar:SetAlpha(0)
		end
	end
	ns.UpdateCastbarColor(Castbar, unit)
	if (Castbar.SafeZone) then
		Castbar.SafeZone:SetDrawLayer("BORDER", -1)
	end
end

function ns.PostCastFailed(Castbar, unit, castID, spellID)
	if (Castbar.Text) then
		Castbar.Text:SetText(FAILED) 
	end
	Castbar:SetStatusBarColor(1, 0, 0) -- Red
	if (Castbar.max) then 
		Castbar:SetValue(Castbar.max)
	end
end

function ns.PostCastInterrupted(Castbar, unit, castID, spellID)
	if (Castbar.Text) then
		Castbar.Text:SetText(INTERRUPTED) 
	end
	Castbar:SetStatusBarColor(1, 0, 0)
	if (Castbar.max) then -- Some spells got trough without castbar
		Castbar:SetValue(Castbar.max)
	end
end

function ns.PostStop(Castbar, unit, castID, spellID)
	--Castbar:SetValue(Castbar.max)
	if (Castbar.Ticks) then
		CastingBarFrameTicksSet(Castbar)
	end
end

function ns.PostChannelStart(Castbar, unit, castID, spellID)
	if (unit == "pet" and Castbar:GetAlpha() == 0) then
		Castbar:SetAlpha(1)
	end

	ns.UpdateCastbarColor(Castbar, unit)
	if Castbar.SafeZone then
		Castbar.SafeZone:SetDrawLayer("BORDER", 1)
	end
	if (Castbar.Ticks) then
		CastingBarFrameTicksSet(Castbar, unit, spellID)
	end
end

function ns.UpdateCastbarColor(Castbar, unit)
	local color
	local bR, bG, bB = ns.GetPaintColor(0.2)
	local text = "default"

	if UnitIsUnit(unit, "player") then
		color = colors.class[select(2,UnitClass("player"))]
	elseif Castbar.notInterruptible then
		color = ns.config.castbarUnInterruptibleColor
		text = "white"
		bR, bG, bB = color[1] * 0.8, color[2] * 0.8, color[3] * 0.8
	elseif UnitIsFriend(unit, "player") then
		color = colors.reaction[5]
	else
		color = colors.reaction[1]
	end

	Castbar:SetBorderTexture(text)
	Castbar:SetBorderColor(bR, bG, bB)

	local r, g, b = color[1], color[2], color[3]
	Castbar:SetStatusBarColor(r * 0.8, g * 0.8, b * 0.8)
	Castbar.Background:SetVertexColor(r * 0.2, g * 0.2, b * 0.2)
end
