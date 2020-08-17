local _, ns = ...

-- [[ Default Aura Filter ]] --
ns.defaultAuras = {
	["general"] = { },
	["boss"] = { },
	["arena"] = { },
}

do
	local l = ns.AuraList
	for _, list in pairs({l.Immunity, l.CCImmunity, l.Defensive, l.Offensive, l.Helpful, l.Misc}) do
		for i = 1, #list do
			ns.defaultAuras.arena[list[i]] = true
		end
	end
end

-- [[	Default Settings	]] --
ns.defaultConfig = {
	fontNumber = "Interface\\AddOns\\oUF_Abu\\Media\\Font\\fontSmall.ttf",
	fontNumberOutline = "NONE",
	fontNumberSize = 1, -- relative size

	fontName = "Interface\\AddOns\\oUF_Abu\\Media\\Font\\fontThick.ttf",
	fontNameOutline = "NONE",
	fontNameSize = 1, -- relative size

	fontBar = "Interface\\AddOns\\oUF_Abu\\Media\\Font\\fontThick.ttf",
	fontBarOutline = "NONE",
	fontBarSize = 1, -- relative size

	fontLevel = "Interface\\AddOns\\oUF_Abu\\Media\\Font\\fontThick.ttf",
	fontLevelOutline = "NONE",
	fontLevelSize = 1, -- relative size

	fontHealthOffset = 0,
	fontPowerOffset = 0,

	castbars = true,
	castbarSafezoneColor = {.8, 0.4, 0, 1},
	-- castbarInterruptibleColor = {1, 1, 1},
	castbarUnInterruptibleColor = {0.9, 0.9, 0.9},
	portraitTimer = true,
	combatText = false,
	ThreatIndicator = true,
	colorPlayerDebuffsOnly = true,
	largePlayerAuras = true,

	healthcolormode = "CLASS",
	healthcolor = { 0.0, 0.1, 0.0 },

	powercolormode = "TYPE",
	powerUseAtlas = true, --todo
	powerPredictionBar = true, --todoo
	builderSpender = true, --todo
	powercolor = { 0.0, 0.1, 0.0 },

	backdropColor = {0, 0, 0, 0.55},

	TextHealthColor = {1, 1, 1},
	TextHealthColorMode = "CUSTOM",
	TextPowerColor = {1, 1, 1},
	TextPowerColorMode = "CUSTOM",
	TextNameColor = {1, 1, 1},
	TextNameColorMode = "CUSTOM",

	showParty = true,
	showPartyInRaid = true,
	showSelfInParty = true,
	showArena = true,
	showBoss = true,

	borderType = "abu",
	textureBorder = "Interface\\AddOns\\oUF_Abu\\Media\\Border\\2borderNormal",
	textureBorderWhite = "Interface\\AddOns\\oUF_Abu\\Media\\Border\\2borderWhite",
	textureBorderShadow = "Interface\\AddOns\\oUF_Abu\\Media\\Border\\2borderShadow",

	statusbar = "Interface\\AddOns\\oUF_AbuRaid\\Media\\HalH",
	frameColor = {0.5, 0.5, 0.4},
	playerStyle = "normal",
	customPlayerTexture = "Interface\\AddOns\\oUF_Abu\\Media\\Frames\\CUSTOMPLAYER-FRAME",
	frameStyle = "normal",

	focMod = "shift-",
	focBut = "1",
	castbarticks = true,
	useAuraTimer = true,
	clickThrough = false,
	classPortraits = false,
	combatFade = true,

	classBar = {},

	-- class stuff
	DEATHKNIGHT = {
		showRunes = true,
		showTotems = true,
	},
	DEMONHUNTER = {
	},
	DRUID = {
		showTotems = true,
		showAdditionalPower = true,
	},
	HUNTER = {
		showTotems = true,
	},
	MAGE = {
		showArcaneStacks = true,
		showTotems = true,
	},
	MONK = {
		showStagger = true,
		showChi = true,
		showTotems = true,
		showAdditionalPower = true,
	},
	PALADIN = {
		showHolyPower = true,
		showTotems = true,
		showAdditionalPower = true,
	},
	PRIEST = {
		showInsanity = true,
		showAdditionalPower = true,
	},
	ROGUE = {
	},
	SHAMAN = {
		showTotems = true,
		showAdditionalPower = true,
	},
	WARLOCK = {
		showShards = true,
		showTotems = true,
	},
	WARRIOR = {
		showTotems = true,
	},

	showComboPoints = true,

	absorbtexture = "Interface\\AddOns\\oUF_Abu\\Media\\Texture\\absorbTexture",
	absorbspark = "Interface\\AddOns\\oUF_Abu\\Media\\Texture\\absorbSpark",

 	player = {
 		style = "fat",
		scale = 1.2,
		HealthTag = "NUMERIC",
		PowerTag = "PERCENT",
		cbshow = true, 
		cbwidth = 200,
		cbheight = 18,
		cbicon = "NONE",
		position = "CENTER/-205/-160",
		cbposition = "BOTTOM/0/150",
		cbscale = 1,
	},

	pet = {
 		style = "fat",
		scale = 1.2,
		HealthTag = "MINIMAL",
		PowerTag = "DISABLE",
		cbshow = true, 
		cbwidth = 200,
		cbheight = 18,
		cbicon = "NONE",
		position = "BOTTOM/-217/178",
		cbposition = "BOTTOM/0/180",
		cbscale = 1,
	},

	target = {
 		style = "fat",
		scale = 1.2,
		HealthTag = "BOTH",
		PowerTag = "PERCENT",
		buffPos = "LEFT",
		debuffPos = "BOTTOM",
		cbshow = true, 
		cbwidth = 200,
		cbheight = 18,
		cbicon = "NONE",
		position = "CENTER/205/-160",
		cbposition = "BOTTOM/0/350",
		cbscale = 1,
	},
	
	targettarget = {
		enable = true,
 		style = "fat",
		scale = 1.2,
		enableAura = false,
		HealthTag = "DISABLE",
   },
	
	focus = {
 		style = "fat",
		scale = 1.2,
		HealthTag = "BOTH",
		PowerTag = "PERCENT",
		buffPos = "NONE",
		debuffPos = "BOTTOM",
		position = "LEFT/300/80",
		cbshow = true, 
		cbwidth = 180,
		cbheight = 20,
		cbicon = "NONE",
		cbposition = "LEFT/300/125",
		cbscale = 1,
	},
	
	focustarget = {
		enable = true,
 		style = "fat",
		scale = 1.2,
		enableAura = false,
		HealthTag = "DISABLE",
	},
	
	party = {
 		style = "fat",
		scale = 1.1,
		HealthTag = "MINIMAL",
		PowerTag = "DISABLE",
		position = "LEFT/80/290"
	},

	boss = {
		scale = 1,
		HealthTag = "PERCENT",
		PowerTag = "PERCENT",
		cbshow = true,
		cboffset = {0, 0},
		cbwidth = 150,
		cbheight = 18,
		cbicon = "NONE",
		position = "RIGHT/-188/255"
	},

	arena = {
		style = "fat",
		scale = 1.1,
		HealthTag = "BOTH",
		PowerTag = "PERCENT",
		cboffset = {0, 0},
		cbshow = true, 
		cbwidth = 150,
		cbheight = 22,
		cbicon = "NONE",
		position = "RIGHT/-175/225"
	},
}
-----------------------------------------------------------------------
ns.defaultProfiles = {
	auraprofile = "Default",
	profile = "Default",
}