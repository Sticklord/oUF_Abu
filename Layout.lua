
local _, ns = ...
local config, playerClass
local textPath = "Interface\\AddOns\\oUF_Abu\\Media\\Frames\\"
local pathFat = textPath.."Fat\\"
local pathNormal = textPath.."Normal\\"

-- Frame data
local DataNormal = {
	targetTexture = {
		elite = pathNormal .. "Target-Elite",
		rareelite = pathNormal ..  "Target-Rare-Elite",
		rare = pathNormal ..  "Target-Rare",
		worldboss = pathNormal ..  "Target-Elite",
		normal = pathNormal ..  "Target",
	},
	vehicle = {-- w = width, h = height, x offset, y offset, t=texture, j = justify, s = size, c=Texture Coordinates, p = point
		siz = { w = 175, h = 42   }, -- size
		tex = { w = 240, h = 121, x = 0,    y = -8,  t = "Interface\\Vehicles\\UI-Vehicle-Frame", c = {0, 1, 0, 1}}, --texture
		hpb = { w = 108, h = 9,   x = 30,   y = 1,   }, --Healthbar
		hpt = {                   x = 0,    y = 1,   j = "CENTER", s = 13 }, -- Healthtext
		mpb = { w = 108, h = 9,   x = 0,    y = 0,   }, -- Mana bar
		mpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 }, -- Mana bar text
		nam = { w = 110, h = 10,  x = 0,    y = 22,  j = "CENTER", s = 14 }, -- Name text
		por = { w = 56,  h = 56,  x = -64,  y = 10,  }, -- Portrait
		glo = { w = 242, h = 92,  x = 13,   y = 0,   t = "Interface\\Vehicles\\UI-VEHICLE-FRAME-FLASH", c = {0, 1, 0, 1}}, -- Glow texture
	},
	vehicleorganic = {
		siz = { w = 175, h = 42   },
		tex = { w = 240, h = 121, x = 0,    y = -8,  t = "Interface\\Vehicles\\UI-Vehicle-Frame-Organic", c = {0, 1, 0, 1}},
		hpb = { w = 108, h = 9,   x = 30,   y = 1,   },
		hpt = {                   x = 0,    y = 1,   j = "CENTER", s = 13 },
		mpb = { w = 108, h = 9,   x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 },
		nam = { w = 110, h = 10,  x = 0,    y = 22,  j = "CENTER", s = 14 },
		por = { w = 56,  h = 56,  x = -64,  y = 10,  },
		glo = { w = 242, h = 92,  x = 13,   y = 0,   t = "Interface\\Vehicles\\UI-VEHICLE-FRAME-ORGANIC-FLASH", c = {0, 1, 0, 1}},
	},
	player = {
		siz = { w = 175, h = 42   },
		tex = { w = 232, h = 100, x = -20,  y = -7,  t = pathNormal.."Target", c = {1, 0.09375, 0, 0.78125}},
		hpb = { w = 118, h = 19,  x = 50,   y = 16,  },
		hpt = {                   x = 0,    y = 1,   j = "CENTER", s = 13 },
		mpb = { w = 118, h = 20,  x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 },
		nam = { w = 110, h = 10,  x = 0,    y = 17,  j = "CENTER", s = 14 },
		por = { w = 64,  h = 64,  x = -41,  y = 6,   },
		glo = { w = 242, h = 92,  x = 13,   y = 0,   t = pathNormal.."Target-Flash", c = {0.945, 0, 0, 0.182}},
	},
	target = { -- and focus
		siz = { w = 175, h = 42   },
		tex = { w = 230, h = 100, x = 20,   y = -7,  t = pathNormal.."Target", c = {0.09375, 1, 0, 0.78125}},
		hpb = { w = 117, h = 19,  x = -51,  y = 16,  },
		hpt = {                   x = 0,    y = 1,   j = "CENTER", s = 13 },
		mpb = { w = 117, h = 20,  x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 },
		nam = { w = 110, h = 10,  x = 0,    y = 17,  j = "CENTER", s = 14 },
		por = { w = 64,  h = 64,  x = 41,   y = 6,   },
		glo = { w = 239, h = 94,  x = -24,  y = 1,   t = pathNormal.."Target-Flash", c = {0, 0.945, 0, 0.182}},
	},
	targettarget = { -- and focus target
		siz = { w = 85,  h = 20   },
		tex = { w = 128, h = 64,  x = 16,   y = -10, t = pathNormal.."TargetOfTarget", c = {0, 1, 0, 1}},
		hpb = { w = 43,  h = 6,   x = 2,    y = 14,  },
		hpt = {                   x = -4,   y = -3,  j = "CENTER", s = 12 },
		mpb = { w = 37,  h = 7,   x = -1,   y = 0,   },
		-----------------------------------------------
		nam = { w = 65,  h = 10,  x = 11,   y = -18, j = "LEFT",   s = 13 },
		por = { w = 40,  h = 40,  x = -40,  y = 10,  },
		------------------------------------------------
	},
	pet = {
		siz = { w = 110, h = 37   },
		tex = { w = 128, h = 64,  x = 4,    y = -10, t = pathNormal.."Pet", c = {0, 1, 0, 1}},
		hpb = { w = 69,  h = 8,   x = 16,   y = 7,   },
		hpt = {                   x = 1,    y = 1,   j = "CENTER", s = 13 },
		mpb = { w = 69,  h = 8,   x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 },
		--nam = { w = 110, h = 10,  x = 20,   y = 15,  j = "LEFT",   s = 14 },
		por = { w = 37,  h = 37,  x = -41,  y = 10,  },
		glo = { w = 128, h = 64,  x = -4,   y = 12,  t = pathNormal.."Party-Flash", c = {0, 1, 1, 0}},
	},
	party = {
		siz = { w = 115, h = 35   },
		tex = { w = 128, h = 64,  x = 2,    y = -16, t = pathNormal.."Party", c = {0, 1, 0, 1}},
		hpb = { w = 69,  h = 7,   x = 17,   y = 17,  },
		hpt = {                   x = 1,    y = 1,   j = "CENTER", s = 13 },
		mpb = { w = 70,  h = 7,   x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = -2,  j = "CENTER", s = 12 },
		nam = { w = 110, h = 10,  x = 0,    y = 15,  j = "CENTER", s = 14 },
		por = { w = 37,  h = 37,  x = -39,  y = 7,   },
		glo = { w = 128, h = 63,  x = -3,   y = 4,   t = pathNormal.."Party-Flash", c = {0, 1, 0, 1}},
	},
	boss = {
		siz = { w = 132, h = 46   },
		tex = { w = 250, h = 129, x = 31,   y = -24, t = pathNormal.."Boss", c = {0, 1, 0, 1}},
		hpb = { w = 115, h = 9,   x = -38,  y = 17,  },
		hpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 },
		mpb = { w = 115, h = 8,   x = 0,    y = -3,  },
		mpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 },
		nam = { w = 110, h = 10,  x = 0,    y = 16,  j = "CENTER", s = 12 },
		------------------------------------------------
		glo = { w = 241, h = 100, x = -2,   y = 3,   t = pathNormal.."Boss-Flash", c = {0.0, 0.945, 0.0, 0.73125}},
	},
}

local DataFat = {
	targetTexture = {
		elite = pathFat .. "Target-Elite",
		rareelite = pathFat ..  "Target-Rare-Elite",
		rare = pathFat ..  "Target-Rare",
		worldboss = pathFat ..  "Target-Elite",
		normal = pathFat ..  "Target",
	},
	vehicle = DataNormal.vehicle,
	vehicleorganic = DataNormal.vehicleorganic,
	player = {
		siz = { w = 175, h = 42   },
		tex = { w = 232, h = 100, x = -20,  y = -7,  t = pathFat.."Target", c = {1, 0.09375, 0, 0.78125}},
		hpb = { w = 119, h = 26,  x = 50,   y = 13,  },
		hpt = {                   x = 0,    y = -1,   j = "CENTER", s = 13 },
		mpb = { w = 119, h = 14,  x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = -1,   j = "CENTER", s = 13 },
		nam = { w = 110, h = 10,  x = 50,   y = 19,  j = "CENTER", s = 14 },
		por = { w = 64,  h = 64,  x = -42,  y = 7,   },
		glo = { w = 242, h = 92,  x = 13,   y = -1,  t = pathFat.."Target-Flash", c = {0.945, 0, 0, 0.182}},
	},
	target = {
		siz = { w = 175, h = 42   },
		tex = { w = 230, h = 100, x = 20,   y = -7,  t = pathFat.."Target", c = {0.09375, 1, 0, 0.78125}},
		hpb = { w = 117, h = 26,  x = -51,  y = 13,  },
		hpt = {                   x = 0,    y = -1,   j = "CENTER", s = 13 },
		mpb = { w = 117, h = 14,  x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = -1,   j = "CENTER", s = 13 },
		nam = { w = 110, h = 10,  x = 0,    y = 18,  j = "CENTER", s = 14 },
		por = { w = 64,  h = 64,  x = 41,   y = 6,   },
		glo = { w = 239, h = 94,  x = -24,  y = 1,   t = pathNormal.."Target-Flash", c = {0, 0.945, 0, 0.182}},
	},
	targettarget = DataNormal.targettarget, --same for now
	pet = {
		siz = { w = 110, h = 37   },
		tex = { w = 128, h = 64,  x = 4,    y = -10, t = pathFat.."Pet", c = {0, 1, 0, 1}},
		hpb = { w = 69,  h = 12,  x = 16,   y = 9,   },
		hpt = {                   x = 1,    y = 1,   j = "CENTER", s = 13 },
		mpb = { w = 69,  h = 8,   x = 0,    y = 0,   },
		mpt = {                   x = 0,    y = 0,   j = "CENTER", s = 13 },
		--nam = { w = 110, h = 10,  x = 20,   y = 15,  j = "LEFT",   s = 14 },
		por = { w = 37,  h = 37,  x = -41,  y = 10,  },
		glo = { w = 128, h = 64,  x = -4,   y = 12,  t = pathFat.."Party-Flash", c = {0, 1, 1, 0}},
	},
	party = {
        siz = { w = 115, h = 35   },
        tex = { w = 128, h = 64,  x = 2,    y = -16, t = pathFat.."Party", c = {0, 1, 0, 1}},
        hpb = { w = 69,  h = 12,  x = 17,   y = 15,  },
        hpt = {                   x = 0,    y = 1,   j = "CENTER", s = 13 },
        mpb = { w = 70,  h = 7,   x = 0,    y = 0,   },
        mpt = {                   x = 0,    y = -1,   j = "CENTER", s = 12 },
        nam = { w = 110, h = 10,  x = 0,    y = 15,  j = "CENTER", s = 14 },
        por = { w = 37,  h = 37,  x = -39,  y = 7,   },
        glo = { w = 128, h = 63,  x = -3,   y = 4,   t = pathFat.."Party-Flash", c = {0, 1, 0, 1}},
    },
    boss = DataNormal.boss,
}

local function GetDBUnit(cUnit)
	if cUnit == "focus" then
		return "target"
	elseif cUnit == "focustarget" then
		return "targettarget"
	elseif cUnit == "player" then -- can player be vehicle? no it cant
		if ns.Classic then return "player" end
		if UnitHasVehicleUI("player") then
			if (UnitVehicleSkin("player") == "Natural") then
				return "vehicleorganic"
			else
				return "vehicle"
			end
		else
			return "player"
		end
	end
	return cUnit
end

local function GetData(cUnit)
	local dbUnit = GetDBUnit(cUnit)
	if (ns.config[cUnit].style == "fat") then
		return DataFat[dbUnit]
	end
	return DataNormal[dbUnit]
end

local function GetTargetTexture(cUnit, type)
	local dbUnit = GetDBUnit(cUnit)
	if dbUnit == "vehicle" or dbUnit == "vehicleorganic" then
		return GetData(cUnit).tex.t
	end
	if dbUnit == "player" then
		if ns.config.playerStyle == "custom" then
			return ns.config.customPlayerTexture
		end
		type = ns.config.playerStyle
	end

	-- only "target", "focus" & "player" gets this far
	local data = ns.config[cUnit].style == "normal" and DataNormal.targetTexture or DataFat.targetTexture
	if data[type] then
		return data[type]
	else
		return data["normal"]
	end
end

local function updatePlayerStatus(element)
	local self = element.__owner
	if UnitAffectingCombat("player") then
		self.RestingIndicator:Hide()
		self.Level:Hide()
	elseif IsResting() then
		self.RestingIndicator:Show()
		self.Level:Hide()
	elseif not self.Level:IsVisible() then
		self.Level:Show()
		self.Level:UpdateTag()
	end
end

local function UpdatePlayerFrame(self)
	local data = GetData(self.cUnit)
	local uconfig = ns.config[self.cUnit]
	-- Frame Size
	if not InCombatLockdown() then
		self:SetSize(data.siz.w, data.siz.h)
		self:SetScale(uconfig.scale or 1)
		self:EnableMouse((not ns.config.clickThrough))
	end

	self.Texture:SetSize(data.tex.w, data.tex.h)
	self.Texture:SetPoint("CENTER", self, data.tex.x, data.tex.y)
	self.Texture:SetTexture(GetTargetTexture("player")) -- 1
	self.Texture:SetTexCoord(unpack(data.tex.c))

	self.Health:SetSize(data.hpb.w, data.hpb.h)
	self.Health:SetPoint("CENTER", self.Texture, data.hpb.x, data.hpb.y)
	self.Power:SetSize(data.mpb.w, data.mpb.h)
	self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", data.mpb.x, data.mpb.y)
	if self.PowerPrediction then
		if self.PowerPrediction.mainBar then
			self.PowerPrediction.mainBar:SetSize(self.Power:GetSize())
		end
		if self.PowerPrediction.altbar then
			self.PowerPrediction.altbar:SetSize(self.AdditionalPower:GetSize())
		end
	end

	self.Health.Value:SetPoint("CENTER", self.Health, data.hpt.x, config.fontHealthOffset)
	self.Power.Value:SetPoint("CENTER", self.Power, data.mpt.x, config.fontPowerOffset)

	self.Name:SetPoint("TOP", self.Health, data.nam.x, data.nam.y)
	self.Name:SetSize(data.nam.w, data.nam.h)
	self.Portrait:SetPoint("CENTER", self.Texture, data.por.x, data.por.y)
	self.Portrait:SetSize(data.por.w, data.por.h)

	if self.ThreatIndicator then
		self.ThreatIndicator:SetSize(data.glo.w, data.glo.h)
		self.ThreatIndicator:SetPoint("TOPLEFT", self.Texture, data.glo.x, data.glo.y)
		self.ThreatIndicator:SetTexture(data.glo.t)
		self.ThreatIndicator:SetTexCoord(unpack(data.glo.c))
	end

	if self.BuilderSpender then
		self.BuilderSpender.FeedbackFrame:SetFrameLevel(self.Power:GetFrameLevel())
		self.BuilderSpender.FeedbackFrame:SetAllPoints(self.Power)
		self.BuilderSpender.FeedbackFrame:SetPoint("TOPLEFT", self.Power, "TOPLEFT", 0, -1)

		local POWER = self.BuilderSpender.FullPowerFrame
		POWER:SetSize(self.Power:GetSize())
		POWER:SetPoint("BOTTOMLEFT", self.Power, "BOTTOMLEFT", 4, -2)
		for _,v in pairs({POWER.SpikeFrame.BigSpikeGlow, POWER.SpikeFrame.AlertSpikeStay, POWER.PulseFrame.YellowGlow, POWER.PulseFrame.SoftGlow}) do
			local x,y = v:GetSize()
			local scale = self.Power:GetHeight()/(PlayerFrameManaBar:GetHeight() or 12)
			v:SetSize(x*scale,y*scale)
		end
	end

	self.PvPIndicator:ClearAllPoints()

	if not ns.Classic then
		if ( config.showComboPoints ) then
			ComboPointPlayerFrame:Setup()
		else
			ComboPointPlayerFrame:UnregisterAllEvents()
			ComboPointPlayerFrame:Hide()
		end
	end

	local inVehicle
	if not ns.Classic then
		inVehicle = UnitHasVehicleUI("player")
	end

	if inVehicle then
		self.Name:Show()
		self.Level:Hide()
		self.Health.Value:SetPoint("CENTER", self.Health, data.hpt.x, 2)

		self.GroupRoleIndicator:SetAlpha(0)
		self.PvPIndicator:SetPoint("TOPLEFT", self.Texture, 4, -28)
		self.LeaderIndicator:SetPoint("TOPLEFT", self.Texture, 23, -14)
		self.RaidTargetIndicator:SetPoint("CENTER", self.Portrait, "TOP", 0, -5)
		PlayerFrameVehicleTexture:Show()

		if ( self.classPowerBar ) then
			self.classPowerBar:Hide()
		end

		TotemFrame:Hide();

		if ( playerClass == "SHAMAN" ) then
		elseif ( playerClass == "DRUID" ) then
			-- EclipseBarFrame:Hide()
		elseif ( playerClass == "DEATHKNIGHT" ) then
			RuneFrame:Hide()
		elseif ( playerClass == "PRIEST" ) then
			PriestBarFrame:Hide()
		end
	else
		self.Name:Hide()
		self.Level:Show()

		self.GroupRoleIndicator:SetAlpha(1)
		self.PvPIndicator:SetPoint("TOPLEFT", self.Texture, 23, -23)
		self.LeaderIndicator:SetPoint("TOPLEFT", self.Portrait, 3, 2)
		self.RaidTargetIndicator:SetPoint("CENTER", self.Portrait, "TOP", 0, -1)
		PlayerFrameVehicleTexture:Hide();

		if ( self.classPowerBar ) then
			self.classPowerBar:Setup();
		end

		if not ns.Classic then
			TotemFrame_Update();
		end

		if ( playerClass == "SHAMAN" ) then
		elseif ( playerClass == "DRUID" ) then
			--EclipseBar_UpdateShown(EclipseBarFrame);
		elseif ( playerClass == "DEATHKNIGHT" ) then
			RuneFrame:Show();
		elseif ( playerClass == "PRIEST" ) then
			PriestBarFrame_CheckAndShow();
		end
	end
end

local function UpdateUnitFrameLayout(frame)
	local cUnit = frame.cUnit
	local data = GetData(cUnit)
	local uconfig = ns.config[cUnit]

	if (frame.cUnit == "pet" or frame.IsMainFrame or frame.IsTargetFrame ) then
		frame.CombatFade = ns.config.combatFade
	end

	-- Combat Fade
	if frame.CombatFade and not frame:IsElementEnabled("oUF_CombatFade") then
		frame:EnableElement("oUF_CombatFade")
	elseif not frame.CombatFade and frame:IsElementEnabled("oUF_CombatFade") then
		frame:DisableElement("oUF_CombatFade")
	end

	-- Player frame, its special
	if cUnit == "player" then
		return UpdatePlayerFrame(frame)
	elseif (not data) then
		return
	end

	-- Frame Size
	frame:SetSize(data.siz.w, data.siz.h)
	frame:SetScale(uconfig.scale or 1)
	frame:EnableMouse((not ns.config.clickThrough) or (frame.IsPartyFrame))
	-- Texture
	frame.Texture:SetTexture(data.tex.t)
	frame.Texture:SetSize(data.tex.w, data.tex.h)
	frame.Texture:SetPoint("CENTER", frame, data.tex.x, data.tex.y)
	frame.Texture:SetTexCoord(unpack(data.tex.c))
	-- HealthBar
	frame.Health:SetSize(data.hpb.w, data.hpb.h)
	frame.Health:SetPoint("CENTER", frame.Texture, data.hpb.x, data.hpb.y)
	-- ManaBar
	frame.Power:SetSize(data.mpb.w, data.mpb.h)
	frame.Power:SetPoint("TOPLEFT", frame.Health, "BOTTOMLEFT", data.mpb.x, data.mpb.y)

	-- HealthText
	if frame.IsMainFrame or frame.IsTargetFrame then
		frame.Health.Value:SetPoint("CENTER", frame.Health, data.hpt.x, config.fontHealthOffset)
	else
		frame.Health.Value:SetPoint("CENTER", frame.Health, data.hpt.x, data.hpt.y)
	end

	-- ManaText - not for tots
	if frame.Power.Value then
		frame.Power.Value:SetPoint("CENTER", frame.Power, data.mpt.x, config.fontPowerOffset)
	end
	-- NameText
	if frame.Name then
		frame.Name:SetSize(data.nam.w, data.nam.h)
		frame.Name:SetPoint("TOP", frame.Health, data.nam.x, data.nam.y)
	end
	-- Portrait
	if frame.Portrait then
		frame.Portrait:SetSize(data.por.w, data.por.h)
		frame.Portrait:SetPoint("CENTER", frame.Texture, data.por.x, data.por.y)
	end
	if not ns.Classic then
		-- Threat Glow -- if enabled
		if frame.ThreatIndicator then
			frame.ThreatIndicator:SetSize(data.glo.w, data.glo.h)
			frame.ThreatIndicator:SetPoint("TOPLEFT", frame.Texture, data.glo.x, data.glo.y)
			frame.ThreatIndicator:SetTexture(data.glo.t)
			frame.ThreatIndicator:SetTexCoord(unpack(data.glo.c))
		end
	end
end

function oUFAbu:UpdateBaseFrames(optUnit)
	if InCombatLockdown() then return; end
	config = ns.config
	if optUnit and optUnit:find("%d") then
		optUnit = optUnit:match("^.%a+")
	end

	for _, obj in pairs(oUF.objects) do
		local unit = obj.cUnit
		if obj.style == "oUF_Abu" and unit and (not optUnit or optUnit == unit:match("^.%a+")) then
			UpdateUnitFrameLayout(obj)
		end
	end
end

local function CreateUnitLayout(self, unit)
	self.cUnit = ns.cUnit(unit)
	self.IsMainFrame = ns.MultiCheck(self.cUnit, "player", "target", "focus")
	self.IsTargetFrame = ns.MultiCheck(self.cUnit, "targettarget", "focustarget")
	self.IsPartyFrame = self.cUnit:match("party")

	if (self.IsTargetFrame) then
		self:SetFrameLevel(4)
	end

	--[[	 Mouse Interraction		]]
	self:RegisterForClicks("AnyUp")

	self:HookScript("OnEnter", ns.UnitFrame_OnEnter)
	self:HookScript("OnLeave", ns.UnitFrame_OnLeave)
	self.mouseovers = {}

	if (config.focBut ~= "NONE") then
		if (self.cUnit == "focus") then
			self:SetAttribute(config.focMod.."type"..config.focBut, "macro")
			self:SetAttribute("macrotext", "/clearfocus")
		else
			self:SetAttribute(config.focMod.."type"..config.focBut, "focus")
		end
	end

	local uconfig = ns.config[self.cUnit]
	local data = GetData(self.cUnit)

	if self.cUnit == "arena" then
		return ns.createArenaLayout(self, unit)
	end

	--[[	 Load Castbars 		]]
	if config.castbars and uconfig and uconfig.cbshow then
		ns.CreateCastbars(self, self.cUnit)
	end

	--[[	 Textures 			]]
	self.Texture = self:CreateTexture(nil, "BORDER")
	ns.PaintFrames(self.Texture)
	self.Texture:SetDrawLayer("BORDER", 3)

	--[[	 Healthbar 			]]
	self.Health = ns.CreateStatusBar(self, nil, nil, true)
	self.Health:SetFrameLevel(self:GetFrameLevel()-1)
	table.insert(self.mouseovers, self.Health)
	self.Health.PostUpdate = ns.PostUpdateHealth
	self.Health.Smooth = true
	self.Health.frequentUpdates = self.cUnit == "boss"

	if config.healthcolormode == "CUSTOM" then self.Health:SetStatusBarColor(unpack(config.healthcolor)) end
	self.Health.colorTapping = config.healthcolormode ~= "CUSTOM"
	self.Health.colorClass = config.healthcolormode == "CLASS"
	self.Health.colorReaction = config.healthcolormode == "CLASS"
	self.Health.colorSmooth = config.healthcolormode == "NORMAL"

	--[[	Health text 		]]
	self.Health.Value = ns.CreateFontStringNumber(self, data.hpt.s, data.hpt.j)

	--[[	Power bar 			]]
	self.Power = ns.CreateStatusBar(self, nil, nil, true)
	self.Power:SetFrameLevel(self:GetFrameLevel()-1)
	table.insert(self.mouseovers, self.Power)
	self.Power.frequentUpdates = self.cUnit == "player" or self.cUnit == "boss"
	self.Power.PostUpdate = ns.PostUpdatePower
	self.Power.Smooth = true

	if config.powercolormode == "CUSTOM" then self.Power:SetStatusBarColor(unpack(config.powercolor)) end
	self.Power.colorClass = config.powercolormode == "CLASS"
	self.Power.colorPower = config.powercolormode == "TYPE"
	self.Power.useAtlas = config.powerUseAtlas

	--[[	Power Text 		]]
	if (data.mpt) then
		self.Power.Value = ns.CreateFontStringNumber(self, data.mpt.s, data.mpt.j)
	end

	--[[ 	Name Text		]]
	if data.nam then
		self.Name = ns.CreateFontStringName(self, data.nam.s, data.nam.j)
		self:Tag(self.Name, "[abu:name]")
	end

	--[[ 	Portrait		]]
	if data.por then
		self.Portrait = self.Health:CreateTexture(nil, "BACKGROUND")
		self.Portrait.Override = function(self, event, unit)
			if (not unit or not UnitIsUnit(self.unit, unit)) then return; end
			local portrait = self.Portrait
			local _, class = UnitClass(self.unit)
			if config.classPortraits and UnitIsPlayer(unit) and class then
				portrait:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
				portrait:SetTexture[[Interface\TargetingFrame\UI-Classes-Circles]]
			else
				portrait:SetTexCoord(0, 1, 0, 1)
				SetPortraitTexture(portrait, unit)
			end
		end
	end

	if not ns.Classic then
		--[[ 	Threat glow		]]
		if (config.ThreatIndicator) and (data.glo) then
			self.ThreatIndicator = self.Health:CreateTexture(nil, "BACKGROUND", nil,-1)
			self.ThreatIndicator.feedbackUnit = "player"
		end
	end

	if (self.IsMainFrame) then
		--[[ 	Level text		]]
		self.Level = ns.CreateFontStringNumber(self, 13, "CENTER")
		self.Level:SetPoint("CENTER", self.Texture, (self.cUnit == "player" and -63) or 63, -17)
		self:Tag(self.Level, "[abu:level]")

		--[[ PvPIndicator Icon  ]] --
		self.PvPIndicator = self:CreateTexture(nil, "OVERLAY")
		self.PvPIndicator:SetSize(30, 30)
		self.PvPIndicator:SetPoint("TOPRIGHT", self.Texture, -23, -23)
		self.PvPIndicator.Prestige = self:CreateTexture(nil, "ARTWORK")
		self.PvPIndicator.Prestige:SetSize(50, 52)
		self.PvPIndicator.Prestige:SetPoint("CENTER", self.PvPIndicator, "CENTER")

		--[[	Special Bars 		]]
		-- Incoming Heals
		local incHealBar = ns.CreateStatusBarTexture(self.Health, "OVERLAY", "IncomingHeals", 2)
		incHealBar:SetVertexColor(0, 1, 0, 0.4)
		incHealBar:ClearAllPoints()
		self.Health.incHealBar = incHealBar

		-- Absorbing Heals
		local healAbsorbBar = self.Health:CreateTexture(nil, "OVERLAY", nil, 1)
		healAbsorbBar:SetTexture("Interface\\RaidFrame\\Absorb-Fill", true, true)
		healAbsorbBar:SetVertexColor(.9, 0, 0, .9)
		self.Health.healAbsorbBar = healAbsorbBar

		--if (config.absorbBar) then
		local absorbBar = ns.CreateStatusBarTexture(self.Health, "OVERLAY", "Absorb")
		absorbBar:SetVertexColor(1,1,1,1)

		absorbBar.overlay = self.Health:CreateTexture(nil, "OVERLAY", nil, 1)
		absorbBar.overlay:SetTexture("Interface\\RaidFrame\\Shield-Overlay", true, true)
		absorbBar.overlay:SetAllPoints(absorbBar)
		absorbBar.overlay.tileSize = 32

		absorbBar.glow = self.Health:CreateTexture(nil, "OVERLAY", "OverAbsorbGlowTemplate")
		absorbBar.glow:ClearAllPoints()
		absorbBar.glow:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", -6, 0);
		absorbBar.glow:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMRIGHT", -6, 0);
		absorbBar.glow:SetWidth(13)
		absorbBar.glow:Show()
		self.Health.absorbBar = absorbBar

		-- Over absorb bar
		local overAbsorbBar = CreateFrame("StatusBar", nil, self.Health)
		overAbsorbBar:SetStatusBarTexture(config.absorbtexture, "OVERLAY")
		overAbsorbBar:SetFrameLevel(self:GetFrameLevel() - 1)
		overAbsorbBar:SetStatusBarColor(1,1,1,1)
		overAbsorbBar:GetStatusBarTexture():SetBlendMode("ADD")
		overAbsorbBar:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT")
		overAbsorbBar:SetPoint("TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, 5)
		self.Health.overAbsorbBar = overAbsorbBar

		local spark = overAbsorbBar:CreateTexture(nil, "ARTWORK")
		spark:SetTexture(config.absorbspark)
		spark:SetBlendMode("ADD")
		spark:SetPoint("BOTTOMLEFT", overAbsorbBar:GetStatusBarTexture(),"BOTTOMRIGHT")
		spark:SetSize(5,5)
		overAbsorbBar.spark = spark

		if not ns.Classic then
			self:RegisterEvent("UNIT_HEAL_PREDICTION", ns.UpdateHealthOverride)
			self:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED", ns.UpdateHealthOverride)
			self:RegisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED", ns.UpdateHealthOverride)
		end
		self.Health.Override = ns.UpdateHealthOverride

		-- Combat CombatFeedbackText
		if (config.combatText) then
			self.CombatFeedbackText = ns.CreateFontStringNumber(self, 18, "CENTER", "OUTLINE")
			self.CombatFeedbackText:SetPoint("CENTER", self.Portrait)
		end
	end

	--[[ 	Portrait Timer		]]
	if (config.portraitTimer and self.Portrait) then
		self.PortraitTimer = CreateFrame("Frame", nil, self.Health)

		self.PortraitTimer.Icon = self.PortraitTimer:CreateTexture(nil, "BACKGROUND")
		self.PortraitTimer.Icon:SetAllPoints(self.Portrait)

		self.PortraitTimer.Remaining = ns.CreateFontStringNumber(self.PortraitTimer, data.por.w/3.5, "CENTER", "OUTLINE")
		self.PortraitTimer.Remaining:SetPoint("CENTER", self.PortraitTimer.Icon, "CENTER", 0, -2)
		self.PortraitTimer.Remaining:SetTextColor(1, 1, 1)
	end

	self.RaidTargetIndicator = self:CreateTexture(nil, "OVERLAY", self)
	self.RaidTargetIndicator:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")

	if self.cUnit == "boss" then
		self.RaidTargetIndicator:SetPoint("CENTER", self, "TOPRIGHT", -9, -10)
		self.RaidTargetIndicator:SetSize(26, 26)

		self.Name.Bg = self.Health:CreateTexture(nil, "BACKGROUND")
		self.Name.Bg:SetHeight(18)
		self.Name.Bg:SetTexCoord(0.2, 0.8, 0.3, 0.85)
		self.Name.Bg:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT")
		self.Name.Bg:SetPoint("BOTTOMLEFT", self.Health, "TOPLEFT")
		self.Name.Bg:SetTexture(textPath.. "nameBackground")

		if not ns.Classic then
			-- alt power bar
			local altbar = _G["Boss"..unit:match("%d").."TargetFramePowerBarAlt"]
			UnitPowerBarAlt_Initialize(altbar, unit, (uconfig.scale or 1) * 0.5, "INSTANCE_ENCOUNTER_ENGAGE_UNIT")
			altbar:SetParent(self)
			altbar:ClearAllPoints()
			altbar:SetPoint("TOPRIGHT", self, "TOPLEFT", 0, 5)
		end

	else
		--[[ 	Icons		]]
		self.RaidTargetIndicator:SetPoint("CENTER", self.Portrait, "TOP", 0, -1)
		self.RaidTargetIndicator:SetSize(data.por.w/2.5, data.por.w/2.5)

		self.LeaderIndicator = self:CreateTexture(nil, "OVERLAY", self)
		self.LeaderIndicator:SetSize(16, 16)
		if (self.cUnit == "target" or self.cUnit == "focus") then
			self.LeaderIndicator:SetPoint("TOPRIGHT", self.Portrait, -3, 2)
		elseif (self.IsTargetFrame) then
			self.LeaderIndicator:SetPoint("TOPLEFT", self.Portrait, -3, 4)
		elseif (self.IsPartyFrame) then
			self.LeaderIndicator:SetSize(14, 14)
			self.LeaderIndicator:SetPoint("CENTER", self.Portrait, "TOPLEFT", 1, -1)
		end

		if not ns.Classic then
			if (not self.IsTargetFrame) then
				self.PhaseIndicator = self:CreateTexture(nil, "OVERLAY")
				self.PhaseIndicator:SetPoint("CENTER", self.Portrait, "BOTTOM")
				if (self.IsMainFrame) then
					self.PhaseIndicator:SetSize(26, 26)
				else
					self.PhaseIndicator:SetSize(18, 18)
				end
			end
		end

		self.OfflineIcon = self:CreateTexture(nil, "OVERLAY")
		self.OfflineIcon:SetPoint("TOPRIGHT", self.Portrait, 7, 7)
		self.OfflineIcon:SetPoint("BOTTOMLEFT", self.Portrait, -7, -7)

		if (self.cUnit == "player" or self.IsPartyFrame) then
			self.ReadyCheckIndicator = self:CreateTexture(nil, "OVERLAY")
			self.ReadyCheckIndicator:SetPoint("TOPRIGHT", self.Portrait, -7, -7)
			self.ReadyCheckIndicator:SetPoint("BOTTOMLEFT", self.Portrait, 7, 7)
			self.ReadyCheckIndicator.delayTime = 2
			self.ReadyCheckIndicator.fadeTime = 0.7
		end

		if (self.IsPartyFrame or self.cUnit == "player" or self.cUnit == "target") then
			self.GroupRoleIndicator = self:CreateTexture(nil, "OVERLAY")
			self.GroupRoleIndicator:SetSize(20, 20)

			if (self.cUnit == "player") then
				self.GroupRoleIndicator:SetPoint("BOTTOMRIGHT", self.Portrait, -2, -3)
			elseif (unit == "target") then
				self.GroupRoleIndicator:SetPoint("TOPLEFT", self.Portrait, -10, -2)
			else
				self.GroupRoleIndicator:SetPoint("BOTTOMLEFT", self.Portrait, -5, -5)
			end

			local SummonIndicator = self:CreateTexture(nil, "OVERLAY")
			SummonIndicator:SetSize(26, 26)
			SummonIndicator:SetPoint("CENTER", self.Portrait)
			self.SummonIndicator = SummonIndicator
		end
	end

	--[[ 	Player Frame		]] --
	if (self.cUnit == "player") then

		if not ns.Classic then
			-- Combo Points
			ComboPointPlayerFrame:ClearAllPoints()
			ComboPointPlayerFrame:SetParent(self)
			ComboPointPlayerFrame:SetPoint("TOP", self, "BOTTOM", 28, 1)
			ComboPointPlayerFrame.SetPoint = function() end
			ComboPointPlayerFrame:SetFrameLevel(1)
			ns.PaintFrames(ComboPointPlayerFrame.Background, 0.1)
		end

		-- Totems
		if ( config[playerClass].showTotems ) then
			ns.classModule.Totems(self, config, uconfig)
		end

		-- Alternate Mana Bar
		if ( config[playerClass].showAdditionalPower ) then
			ns.classModule.additionalPowerBar(self, config, uconfig)
		end

		-- Load Class Modules
		if ( ns.classModule[playerClass] ) then
			self.classPowerBar = ns.classModule[playerClass](self, config, uconfig)
		end

		--Aurabar for a specific buff
		self.Aurabar = ns.classModule.addAuraBar(self, config, uconfig)

		--builderspender (white overlay when gaining/losing power)
		if ( config.builderSpender ) then
			local FeedbackFrame = CreateFrame("Frame", nil, self.Power, "BuilderSpenderFrame")
			FeedbackFrame.BarTexture:SetTexture()

			local POWER = CreateFrame("Frame", nil, self.Power, "FullResourcePulseFrame")
			self.BuilderSpender = {
				FeedbackFrame = FeedbackFrame,
				FullPowerFrame = POWER,
			}
			self.Power.Smooth = false
		end

		-- Power Prediction Bar (Display estimated cost of spells when casting)
		if ( config.powerPredictionBar ) then
			local mainBar, altBar
			mainBar = CreateFrame("StatusBar",  self.Power:GetDebugName().."PowerPrediction", self.Power)
			mainBar:SetFrameLevel(self.Power:GetFrameLevel())
			mainBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar-Glow]], "BORDER")
			mainBar:GetStatusBarTexture():SetBlendMode"ADD"
			mainBar:SetReverseFill(true)
			mainBar:SetPoint("RIGHT", self.Power:GetStatusBarTexture(), "RIGHT")
			mainBar:SetStatusBarColor(1,1,1,.3)

			if ( self.AdditionalPower ) then
				altBar = CreateFrame("StatusBar", nil, self.AdditionalPower)
				altBar:SetFrameLevel(self.AdditionalPower:GetFrameLevel())
				altBar:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar-Glow]], "BORDER")
				altBar:GetStatusBarTexture():SetBlendMode"ADD"
				altBar:SetReverseFill(true)
				altBar:SetPoint("RIGHT", self.AdditionalPower:GetStatusBarTexture(), "RIGHT")
				altBar:SetStatusBarColor(1,1,1,.3)
			end

			self.PowerPrediction = {
				mainBar = mainBar,
				altBar = altBar
			}
		end

		-- PvPIndicator Timer
		self.PvPIndicatorTimer = ns.CreateFontStringNumber(self, 13, "CENTER")
		self.PvPIndicatorTimer:SetPoint("BOTTOM", self.PvPIndicator, "TOP", 2, -24  )
		self.PvPIndicatorTimer.frequentUpdates = 0.5
		self:Tag(self.PvPIndicatorTimer, "[abu:pvptimer]")

		-- Combat icon
		self.CombatIndicator = self:CreateTexture(nil, "OVERLAY")
		self.CombatIndicator:SetPoint("CENTER", self.Level, 1, 0)
		self.CombatIndicator:SetSize(31, 33)
		self.CombatIndicator.PostUpdate = updatePlayerStatus

		-- RestingIndicator icon
		self.RestingIndicator = self:CreateTexture(nil, "OVERLAY")
		self.RestingIndicator:SetPoint("CENTER", self.Level, -0.5, 0)
		self.RestingIndicator:SetSize(31, 34)
		self.RestingIndicator.PostUpdate = updatePlayerStatus

		if not ns.Classic then
			-- player frame vehicle/normal update
			self:RegisterEvent("UNIT_ENTERED_VEHICLE", UpdatePlayerFrame)
			self:RegisterEvent("UNIT_ENTERING_VEHICLE", UpdatePlayerFrame)
			self:RegisterEvent("UNIT_EXITING_VEHICLE", UpdatePlayerFrame)
			self:RegisterEvent("UNIT_EXITED_VEHICLE", UpdatePlayerFrame)
		end
	end

	--[[ 	Focus & Target Frame		]]
	if (self.cUnit == "target" or self.cUnit == "focus") then
		-- Questmob Icon
		self.QuestIndicator = self:CreateTexture(nil, "OVERLAY")
		self.QuestIndicator:SetSize(32, 32)
		self.QuestIndicator:SetPoint("CENTER", self.Health, "TOPRIGHT", 1, 10)

		table.insert(self.__elements, function(self, _, unit)
			self.Texture:SetTexture(GetTargetTexture(self.cUnit, UnitClassification(unit)))
		end)
	end

	--[[ 	Auras		]]
	if (self.cUnit == "focus") or (self.cUnit == "target") then
		local isFocus = self.cUnit == "focus"

		local function GetAuraData(mode)
			local size, gap, columns, rows, initialAnchor, relAnchor, offX, offY
			if (mode == "TOP") then
				if isFocus then
					columns, rows = 3, 3
				else
					columns, rows = 6, 3
				end
				initialAnchor, relAnchor, offX, offY = "BOTTOMLEFT", "TOPLEFT", -2, 22
			elseif (mode == "BOTTOM") then
				if isFocus then
					columns, rows = 3, 3
				else
					columns, rows = 4, 3
				end
				initialAnchor, relAnchor, offX, offY = "TOPLEFT", "BOTTOMLEFT", -2, -8
			elseif (mode == "LEFT") then
				if isFocus then
					columns, rows = 5, 3
				else
					columns, rows = 8, 3
				end
				initialAnchor, relAnchor, offX, offY = "TOPRIGHT", "TOPLEFT", -8, -1.5
			end
			size = isFocus and 26 or 20
			gap = 4.5
			return size, gap, columns, rows, initialAnchor, relAnchor, offX, offY
		end

		if (uconfig.buffPos == uconfig.debuffPos) and (uconfig.debuffPos ~= "NONE") then
			local size, gap, columns, rows, initialAnchor, relAnchor, offX, offY = GetAuraData(uconfig.debuffPos)
			self.Auras = ns.AddAuras(self, initialAnchor, size, gap, columns, rows)
			self.Auras:SetPoint(initialAnchor, self, relAnchor, offX, offY)
			self.Auras.CustomFilter = ns.CustomAuraFilters.target
		else
			if (uconfig.buffPos ~= "NONE") then
				local size, gap, columns, rows, initialAnchor, relAnchor, offX, offY = GetAuraData(uconfig.buffPos)
				self.Buffs = ns.AddBuffs(self, initialAnchor, size, gap, columns, rows)
				self.Buffs:SetPoint(initialAnchor, self, relAnchor, offX, offY)
				self.Buffs.CustomFilter = ns.CustomAuraFilters.target
			end
			if (uconfig.debuffPos ~= "NONE") then
				local size, gap, columns, rows, initialAnchor, relAnchor, offX, offY = GetAuraData(uconfig.debuffPos)
				self.Debuffs = ns.AddDebuffs(self, initialAnchor, size, gap, columns, rows)
				self.Debuffs:SetPoint(initialAnchor, self, relAnchor, offX, offY)
				self.Debuffs.CustomFilter = ns.CustomAuraFilters.target
			end
		end

	elseif (self.IsTargetFrame and uconfig.enableAura) then
		self.Debuffs = ns.AddDebuffs(self, "TOPLEFT", 20, 4, 3, 2)
		self.Debuffs.CustomFilter   = ns.CustomAuraFilters.target
		self.Debuffs:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", 7, 10)

	elseif (self.cUnit == "pet") then
		self.Debuffs = ns.AddDebuffs(self, "TOPLEFT", 20, 4, 6, 1)
		self.Debuffs:SetPoint("TOPLEFT", self.Power, "BOTTOMLEFT", 1, -3)
		self.Debuffs.CustomFilter   = ns.CustomAuraFilters.pet

	elseif (self.IsPartyFrame) then
		self.Debuffs = ns.AddDebuffs(self, "TOPLEFT", 20, 4, 4, 1)
		self.Debuffs:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", 5, 1)
		self.Debuffs.CustomFilter   = ns.CustomAuraFilters.party

		self.Buffs = ns.AddBuffs(self, "TOPLEFT", 20, 4, 4, 1)
		self.Buffs:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 2, -11)
		self.Buffs.CustomFilter   = ns.CustomAuraFilters.party

	elseif (self.cUnit == "boss") then
		self.Buffs = ns.AddBuffs(self, "TOPLEFT", 30, 4.5, 5, 1)
		self.Buffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 3, -6)

		self.Debuffs = ns.AddDebuffs(self, "TOPRIGHT", 30, 4.5, 7, 1)
		self.Debuffs:SetPoint("TOPRIGHT", self, "BOTTOMLEFT", -34, 18)
		self.Debuffs.CustomFilter   = ns.CustomAuraFilters.boss
	end

	--[[ 	Range Fader 	]]
	if (self.IsPartyFrame) then
		self.Range = {
			insideAlpha = 1,
			outsideAlpha = 0.8,
		}
	end

	return self
end

function _G.PlayerFrame_ToVehicleArt() end --disable blizzard frame swap
function _G.PlayerFrame_ToPlayerArt() end

oUF:Factory(function(self)
	playerClass = select(2, UnitClass("player"))
	config = ns.config

	self:RegisterStyle("oUF_Abu", CreateUnitLayout)
	self:SetActiveStyle("oUF_Abu")
	self:RegisterInitCallback(function(self)
		if self.style == "oUF_Abu" then
			UpdateUnitFrameLayout(self)
		end
	end)

	local player = self:Spawn("player", "oUF_AbuPlayer")
	ns.CreateUnitAnchor(player, player, player, nil, "player")

	local pet = self:Spawn("pet", "oUF_AbuPet")
	ns.CreateUnitAnchor(pet, pet, pet, nil, "pet")

	local target = self:Spawn("target", "oUF_AbuTarget")
	ns.CreateUnitAnchor(target, target, target, nil, "target")

	if (config.targettarget.enable) then
		local targettarget = self:Spawn("targettarget", "oUF_AbuTargetTarget")
		targettarget:SetPoint("TOPLEFT", target, "BOTTOMRIGHT", -78, -15)
	end

	local focus = self:Spawn("focus", "oUF_AbuFocus")
	ns.CreateUnitAnchor(focus, focus, focus, nil, "focus")

	if (config.focustarget.enable) then
		local focustarget = self:Spawn("focustarget", "oUF_AbuFocusTarget")
		focustarget:SetPoint("TOPLEFT", focus, "BOTTOMRIGHT", -78, -15)
	end

	if (config.showParty) then
		local party = oUF:SpawnHeader("oUF_AbuParty", nil, (config.showPartyInRaid and "custom [@raid4,exists] hide; show")
															or "custom [group:party,nogroup:raid] show; hide",
			"oUF-initialConfigFunction", [[
				self:SetWidth(105)
				self:SetHeight(30)
			]],
			"showParty", true,
			"showRaid", false,
			"showPlayer", config.showSelfInParty,
			"yOffset", -30
		)
		ns.CreateUnitAnchor(party, "oUF_AbuPartyUnitButton1", config.showSelfInParty and "oUF_AbuPartyUnitButton5" or "oUF_AbuPartyUnitButton4", nil, "party")
	end

	if (config.showBoss) then
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES do
			boss[i] = self:Spawn("boss"..i, "oUF_AbuBossFrame"..i)
			if (i == 1) then
				boss[i]:SetPoint("TOPRIGHT", UIParent)
			else
				boss[i]:SetPoint("TOPLEFT", boss[(i - 1)], "BOTTOMLEFT", 0, -45)
			end
		end

		ns.CreateUnitAnchor(boss[1], boss[1], boss[5], "DIALOG", "boss1", "boss2", "boss3", "boss4", "boss5")
	end

	if (config.showArena) then
		local arena = {}
		for i = 1, 5 do --MAX_ARENA_ENEMIES isnt loaded yet
			arena[i] = self:Spawn("arena"..i, "oUF_AbuArenaFrame"..i)
			if (i == 1) then
				arena[i]:SetPoint("TOPRIGHT", UIParent)
			else
				arena[i]:SetPoint("TOPLEFT", arena[i-1], "BOTTOMLEFT", 0, -40)
			end
		end
		ns.CreateUnitAnchor(arena[1], arena[1], arena[5], nil, "arena1", "arena2", "arena3", "arena4", "arena5")
	end

	--[[ MirrorTimers ]]--
	for i = 1, MIRRORTIMER_NUMTIMERS do
		local bar = _G["MirrorTimer" .. i]
		bar:SetParent(UIParent)
		bar:SetSize(220, 20)

		ns.CreateBorder(bar, 11, 3)

		if (i > 1) then
			local p1, p2, p3, p4, p5 = bar:GetPoint()
			bar:SetPoint(p1, p2, p3, p4, p5 - 10)
		end

		local statusbar = _G["MirrorTimer" .. i .. "StatusBar"]
		statusbar:SetStatusBarTexture(config.statusbar)
		statusbar:SetAllPoints(bar)

		local backdrop = select(1, bar:GetRegions())
		backdrop:SetTexture("Interface\\Buttons\\WHITE8x8")
		backdrop:SetVertexColor(0, 0, 0, 0.5)
		backdrop:SetAllPoints(bar)

		local border = _G["MirrorTimer" .. i .. "Border"]
		border:Hide()

		local text = _G["MirrorTimer" .. i .. "Text"]
		text:SetFont(config.fontBar, 13, config.fontBarOutline)
		table.insert(ns.fontstrings, text)
		text:ClearAllPoints()
		text:SetPoint("CENTER", bar)
		bar.text = text
	end
end)
