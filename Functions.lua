local _, ns = ...
local select = select
local tonumber = tonumber
local gsub = string.gsub
local format = string.format
local colors = oUF.colors

-------------------------------------------------------------------------------

local function FormatValue(value)
	local absvalue = abs(value)

	if absvalue >= 1e9 then
		return tonumber(format("%.2f", value/1e9)).."b"
	elseif absvalue >= 1e7 then
		return tonumber(format("%.1f", value/1e6)).."m"
	elseif absvalue >= 1e6 then
		return tonumber(format("%.2f", value/1e6)).."m"
	elseif absvalue >= 1e5 then
		return tonumber(format("%.0f", value/1e3)).."k"
	elseif absvalue >= 1e3 then
		return tonumber(format("%.1f", value/1e3)).."k"
	else
		return value
	end
end

ns.FormatValue = FormatValue
function ns.cUnit(unit)
	if (unit:match("vehicle")) then
		return "player"
	elseif (unit:match("party%d")) then
		return "party"
	elseif (unit:match("arena%d")) then
		return "arena"
	elseif (unit:match("boss%d")) then
		return "boss"
	elseif (unit:match("partypet%d")) then
		return "pet"
	else
		return unit
	end
end

function ns.MultiCheck(what, ...)
	for i = 1, select("#", ...) do
		if (what == select(i, ...)) then 
			return true 
		end
	end

	return false
end

-------------------------------------------------------------------------------
local UnitIsGhost, GetSpellInfo, UnitIsConnected, UnitIsDead, UnitIsDeadOrGhost, UnitIsPlayer, UnitReaction, UnitIsEnemy, UnitSelectionColor =
	  UnitIsGhost, GetSpellInfo, UnitIsConnected, UnitIsDead, UnitIsDeadOrGhost, UnitIsPlayer, UnitReaction, UnitIsEnemy, UnitSelectionColor
local UnitPowerType, UnitPower, UnitPowerMax, UnitHasVehicleUI, UnitClass, UnitIsTapDenied, format = 
	  UnitPowerType, UnitPower, UnitPowerMax, UnitHasVehicleUI, UnitClass, UnitIsTapDenied, format

local function getClassColor(unit)
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		return colors.class[class]
	elseif UnitIsTapDenied(unit) then
		return colors.tapped
	elseif UnitIsEnemy(unit, "player") then
		return colors.reaction[1]
	else
		return colors.reaction[UnitReaction(unit, "player") or 5]
	end
	return colors.fallback
end

local function UpdatePortraitColor(self, unit, cur, max)
	if (not UnitIsConnected(unit)) then
		self.Portrait:SetVertexColor(0.5, 0.5, 0.5, 0.7)
	elseif (UnitIsDead(unit)) then
		self.Portrait:SetVertexColor(0.35, 0.35, 0.35, 0.7)
	elseif (UnitIsGhost(unit)) then
		self.Portrait:SetVertexColor(0.3, 0.3, 0.9, 0.7)
	elseif (cur/max * 100 < 25) then
		if (UnitIsPlayer(unit)) then
			if (unit ~= "player") then
				self.Portrait:SetVertexColor(1, 0, 0, 0.7)
			end
		end
	else
		self.Portrait:SetVertexColor(1, 1, 1, 1)
	end
end


local TEXT_PERCENT, TEXT_SHORT, TEXT_LONG, TEXT_MINMAX, TEXT_MAX, TEXT_DEF, TEXT_NONE = 0,1,2,3,4,5,6

local function SetValueText(element, tag, cur, max, color, notMana)
	if ( not max or max == 0 ) then max = 100; end -- not sure why this happens

	if (tag == TEXT_PERCENT) and (max < 200) then
		tag = TEXT_SHORT -- Shows energy etc. with real number
	end

	local s

	if tag == TEXT_SHORT then
		s = format("%s", cur > 0 and FormatValue(cur) or "")
	elseif tag == TEXT_LONG then
		s = format("%s - %.1f%%", FormatValue(cur), cur / max * 100)
	elseif tag == TEXT_MINMAX then
		s = format("%s/%s", FormatValue(cur), FormatValue(max))
	elseif tag == TEXT_MAX then
		s = format("%s", FormatValue(max))
	elseif tag == TEXT_DEF then
		s = format("%s", (cur == max and "" or "-"..FormatValue(max-cur)))
	elseif tag == TEXT_PERCENT then
		s = format("%d%%", cur / max * 100)
	else
		s = ""
	end

	element:SetFormattedText("|cff%02x%02x%02x%s|r", color[1]*255, color[2]*255, color[3]*255, s)
end

------------------------------------------------------------------
--							Health Update						--
------------------------------------------------------------------
do
	local tagtable = {
		NUMERIC = {TEXT_MINMAX, TEXT_SHORT,  	TEXT_MAX },
		BOTH	= {TEXT_MINMAX, TEXT_LONG,  	TEXT_MAX },
		PERCENT = {TEXT_SHORT, 	TEXT_PERCENT, 	TEXT_PERCENT },
		MINIMAL = {TEXT_SHORT, 	TEXT_PERCENT, 	TEXT_NONE },
		DEFICIT = {TEXT_DEF, 	TEXT_DEF, 		TEXT_NONE },
	}

	function ns.PostUpdateHealth(Health, unit, cur, max)	
		local absent = not UnitIsConnected(unit) and PLAYER_OFFLINE or UnitIsGhost(unit) and GetSpellInfo(8326) or UnitIsDead(unit) and DEAD
		local self = Health:GetParent()
		local uconfig = ns.config[self.cUnit]

		if (self.Portrait) then
			UpdatePortraitColor(self, unit, cur, max)
		end

		if (self.Name) and (self.Name.Bg) then 	-- For boss frames
			self.Name.Bg:SetVertexColor(UnitSelectionColor(unit))
		end

		
		if absent then
			Health:SetStatusBarColor(0.5, 0.5, 0.5)
			if Health.Value then
				Health.Value:SetText(absent)
			end
			return
		end

		if not cur then
			cur = UnitHealth(unit)
			max = UnitHealthMax(unit) or 1
		end

		local color, _
		if ns.config.TextHealthColorMode == "CLASS" then
			color = getClassColor(unit)
		elseif ns.config.TextHealthColorMode == "GRADIENT" then
			color = {oUF.ColorGradient(cur, max, unpack(oUF.smoothGradient or colors.smooth))}
		else
			color = ns.config.TextHealthColor
		end
		
		if uconfig.HealthTag == "DISABLE" then
			Health.Value:SetText(nil)
		elseif self.isMouseOver then
			SetValueText(Health.Value, tagtable[uconfig.HealthTag][1], cur, max, color)
		elseif cur < max then
			SetValueText(Health.Value, tagtable[uconfig.HealthTag][2], cur, max, color)
		else
			SetValueText(Health.Value, tagtable[uconfig.HealthTag][3], cur, max, color)
		end
	end
end

local function appendTexture(healthbar, anchorTexture, bar, amount, fromAmount, startPoint)
	if amount == 0 then
		bar:Hide()
		if bar.overlay then
			bar.overlay:Hide()
		end
		return anchorTexture, fromAmount, startPoint
	end

	local maxValue = healthbar.maxValue
	local endAmount
	local offset = (fromAmount+amount) * healthbar.sizeWidth / maxValue

	bar:ClearAllPoints()
	if amount < 0 then
		endAmount = fromAmount
		fromAmount = fromAmount + amount
		bar:SetPoint("TOPLEFT", healthbar, "TOPLEFT", offset, 0)
		bar:SetPoint("BOTTOMLEFT", healthbar, "BOTTOMLEFT", offset, 0)
		bar:SetPoint("RIGHT", anchorTexture, startPoint)
		nextPoint = "LEFT"
	else
		endAmount = fromAmount + amount
		bar:SetPoint("TOPRIGHT", healthbar, "TOPLEFT", offset, 0)
		bar:SetPoint("BOTTOMRIGHT", healthbar, "BOTTOMLEFT", offset, 0)
		bar:SetPoint("LEFT", anchorTexture, startPoint)
		nextPoint = "RIGHT"
	end
	bar:SetTexCoord(fromAmount/maxValue, endAmount/maxValue, 0, 1)
	bar:Show()

	if ( bar.overlay ) then
		bar.overlay:Show()
		bar.overlay:SetTexCoord(0, (math.abs(amount)* healthbar.sizeWidth/maxValue)/bar.overlay.tileSize, 0, healthbar.sizeHeight/bar.overlay.tileSize)
	end

	return bar, amount < 0 and fromAmount or endAmount, nextPoint
end

local function updateAbsorbBars(healthbar, unit, curHP, maxHP)
	if maxHP <= 0 then
		return
	end

	healthbar.sizeWidth, healthbar.sizeHeight = healthbar:GetSize()
	local _, maxValue = healthbar:GetMinMaxValues()
	healthbar.maxValue = maxValue

	local healAbsorb = 0
	local incHealing = 0
	local totalAbsorb_Value = 0

	if not ns.Classic then
		healAbsorb = UnitGetTotalHealAbsorbs(unit) or 0
		incHealing = UnitGetIncomingHeals(unit) or 0
		totalAbsorb_Value = UnitGetTotalAbsorbs(unit) or 0
	end

	if healAbsorb > curHP then
		healAbsorb = curHP
	end
	local texture, endAmount, nextPoint = appendTexture(healthbar, healthbar:GetStatusBarTexture(), healthbar.healAbsorbBar, -healAbsorb, curHP, "RIGHT")

	local missingHP = maxHP - curHP
	if (curHP - healAbsorb + incHealing) > maxHP then
		incHealing = missingHP + healAbsorb 
	end
	texture, endAmount, nextPoint = appendTexture(healthbar, texture, healthbar.incHealBar, incHealing, endAmount, nextPoint)

	local shownAbsorb_Value = math.min(missingHP, totalAbsorb_Value)
	local overAbsorb_Value = totalAbsorb_Value - missingHP
	appendTexture(healthbar, healthbar:GetStatusBarTexture(), healthbar.absorbBar, shownAbsorb_Value, curHP, "RIGHT")

	local overAbsorbBar = healthbar.overAbsorbBar
	if (overAbsorb_Value < (maxHP * 0.01)) then
		overAbsorbBar:Hide()
		healthbar.absorbBar.glow:Hide()
	else
		healthbar.absorbBar.glow:Show()
		overAbsorbBar:SetMinMaxValues(0, maxHP)
		overAbsorbBar:SetValue(math.min(overAbsorb_Value, maxHP))
		overAbsorbBar:Show()
		if not overAbsorbBar.spark:IsShown() then
			overAbsorbBar.spark:Show()
		end
	end
end

function ns.UpdateHealthOverride(self, event, unit)
	if not unit or self.unit ~= unit then return; end
	local cur, max = UnitHealth(unit), UnitHealthMax(unit)
	if (event == "UNIT_HEAL_PREDICTION" or event == "UNIT_ABSORB_AMOUNT_CHANGED" or event == "UNIT_HEAL_ABSORB_AMOUNT_CHANGED") then
		updateAbsorbBars(self.Health, unit, cur, max)
		return;
	end
	local disconnected = not UnitIsConnected(unit)
	self.Health:SetMinMaxValues(0, max)
	if(disconnected) then
		self.Health:SetValue(max)
	else
		self.Health:SetValue(cur)
	end
	self.Health.disconnected = disconnected
	self.Health:UpdateColor(unit, cur, max)
	updateAbsorbBars(self.Health, unit, cur, max)

	ns.PostUpdateHealth(self.Health, unit, cur, max)
end

------------------------------------------------------------------
--							Power Update						--
------------------------------------------------------------------
do
	local tagtable = {
		NUMERIC	=	{TEXT_MINMAX, 	TEXT_SHORT,  	TEXT_MAX },
		PERCENT	=	{TEXT_SHORT, 	TEXT_PERCENT, 	TEXT_PERCENT },
		MINIMAL	=	{TEXT_SHORT, 	TEXT_PERCENT, 	TEXT_NONE },
	}

	function ns.PostUpdatePower(Power, unit, cur, min, max)
		local self = Power:GetParent()
		local uconfig = ns.config[self.cUnit]

		if (UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit)) or (max == 0) then
			Power:SetValue(0)
			if Power.Value then
				Power.Value:SetText("")
			end
			return
		end

		if not Power.Value then return end

		if (not cur) then
			max = UnitPower(unit) or 1
			cur = UnitPowerMax(unit)
		end

		local _, powerToken = UnitPowerType(unit)
		local color 
		
		if ns.config.TextPowerColorMode == "CLASS" then
			color = getClassColor(unit)
		elseif ns.config.TextPowerColorMode == "TYPE" then
			color = colors.power[powerToken] or colors.power.FUEL
		else
			color = ns.config.TextPowerColor
		end

		if uconfig.PowerTag == "DISABLE" then
			Power.Value:SetText(nil)
		elseif self.isMouseOver then
			SetValueText(Power.Value, tagtable[uconfig.PowerTag][1], cur, max, color)
		elseif cur < max then
			SetValueText(Power.Value, tagtable[uconfig.PowerTag][2], cur, max, color)
		else
			SetValueText(Power.Value, tagtable[uconfig.PowerTag][3], cur, max, color)
		end
	end
end

------------------------------------------------------------------
--							Mouseover							--
------------------------------------------------------------------
function ns.UnitFrame_OnEnter(self)
	if self.__owner then
		self = self.__owner
	end
	if not self:IsEnabled() then return end --arena prep

	UnitFrame_OnEnter(self)

	self.isMouseOver = true
	if self.mouseovers then
		for _, text in pairs (self.mouseovers) do
			text:ForceUpdate()
		end
	end

	if (self.AdditionalPower and self.AdditionalPower.Value) then
		self.AdditionalPower.Value:Show()
	end
end

function ns.UnitFrame_OnLeave(self)
	if self.__owner then
		self = self.__owner
	end
	if not self:IsEnabled() then return end --arena prep
	UnitFrame_OnLeave(self)

	self.isMouseOver = nil
	if self.mouseovers then
		for _, text in pairs (self.mouseovers) do
			text:ForceUpdate()
		end
	end

	if (self.AdditionalPower and self.AdditionalPower.Value) then
		self.AdditionalPower.Value:Hide()
	end
end

------------------------------------------------------------------
--					Painting frames 							--
------------------------------------------------------------------

do
	local function toRgb(h, s, l)
		if (s <= 0) then 
			return l, l, l 
		end
		h, s, l = h * 6, s, l
		local c = (1 - math.abs(2 * l - 1)) * s
		local x = (1 - math.abs(h % 2 - 1 )) * c
		local m, r, g, b = (l - .5 * c), 0,0,0
		if h < 1 	 then
			r, g, b = c, x, 0
		elseif h < 2 then
			r, g, b = x, c, 0
		elseif h < 3 then
			r, g, b = 0, c, x
		elseif h < 4 then
			r, g, b = 0, x, c
		elseif h < 5 then
			r, g, b = x, 0, c
		else
			r, g, b = c, 0, x
		end return (r+m), (g+m), (b+m)
	end

	local function toHsl(r, g, b)
		local min, max = math.min(r, g, b), math.max(r, g, b)
		local h, s, l = 0, 0, (max + min) / 2
		if max ~= min then
			local d = max - min
			s = l > 0.5 and d / (2 - max - min) or d / (max + min)
			if max == r then
				local mod = 6
				if g > b then mod = 0 end
				h = (g - b) / d + mod
			elseif max == g then
				h = (b - r) / d + 2
			else
				h = (r - g) / d + 4
			end
		end
		h = h / 6
		return h, s, l
	end

	local function LightenItUp(r, g, b, factor)
		local h, s, l = toHsl(r, g, b)
		l = l + (factor or 0.1)
		if l > 1 then
			l = 1
		elseif l < 0 then
			l = 0
		end
		return toRgb(h, s, l)
	end

	function ns.PaintFrames(texture, factor)
		if texture:GetObjectType() == "Texture" then
			local r, g, b = unpack(ns.config.frameColor)
			if factor then
				r, g, b = LightenItUp(r, g, b, factor)
				texture.colorfactor = factor
			end
			texture:SetVertexColor(r, g, b)
			table.insert(ns.paintframes, texture)
		end
	end

	function ns.GetPaintColor(factor)
		local r, g, b = unpack(ns.config.frameColor)
		if factor then
			r, g, b = LightenItUp(r, g, b, factor)
		end
		return r, g, b
	end
end

function oUFAbu:SetAllFrameColors()
	for i = 1, #ns.paintframes do
		local r, g, b = unpack(ns.config.frameColor)
		local t = ns.paintframes[i]
		if t.colorfactor then
			r,g,b = ns.GetPaintColor(t.colorfactor)
		end
		ns.paintframes[i]:SetVertexColor(r, g, b)
	end
end
----------------------------------------------------------------------
-- [[ Statusbar Functions ]] --
function ns.CreateStatusBar(parent, layer, name, AddBackdrop)
	if type(layer) ~= "string" then layer = "BORDER" end
	local bar = CreateFrame("StatusBar", name, parent, BackdropTemplateMixin and "BackdropTemplate")
	bar:SetStatusBarTexture(ns.config.statusbar, layer)
	bar.texture = ns.config.statusbar
	
	if AddBackdrop then
		bar:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"})
		local r,g,b,a = unpack(ns.config.backdropColor)
		bar:SetBackdropColor(r,g,b,a)
	end

	table.insert(ns.statusbars, bar)
	return bar
end

function ns.CreateStatusBarTexture(parent, layer, name, sublevel)
	if name then
		name = (parent:GetName() or parent:GetDebugName()) .. name
	end
	local texture = parent:CreateTexture(name, layer or "OVERLAY", nil, sublevel)
	texture:SetTexture(ns.config.statusbar)
	texture.texture = ns.config.statusbar
	table.insert(ns.statusbars, texture)
	return texture
end

function oUFAbu:SetAllStatusBars()
	local file = ns.config.statusbar
	local texture

	for _, bar in ipairs(ns.statusbars) do
		bar.texture = file
		texture = bar.GetStatusBarTexture and bar:GetStatusBarTexture() or bar
		if ( not texture:GetAtlas() ) then
			texture:SetTexture(file)
		end
	end
	for i = 1, 3 do
		local bar = _G["MirrorTimer" .. i .. "StatusBar"]
		bar:SetStatusBarTexture(file)
	end
end

function oUFAbu:SetAllBackdrops()
	local r,g,b,a = unpack(ns.config.backdropColor)

	for _, bar in pairs(ns.statusbars) do
		if bar.GetBackdrop then
			bar:SetBackdropColor(r,g,b,a)
		end
	end
end

-- [[ Font Functions ]] --
function ns.CreateFontStringNumber(parent, size, justify, outline)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(ns.config.fontNumber, (size * ns.config.fontNumberSize), outline or ns.config.fontNumberOutline)
	fs:SetJustifyH(justify or "CENTER")
	fs:SetShadowOffset(1, -1)
	fs.basesize = size 
	if outline and type(outline) == "string" then
		fs.ignoreOutline = true
	end

	tinsert(ns.fontstrings, fs)
	return fs
end

function ns.CreateFontStringName(parent, size, justify, outline)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(ns.config.fontName, (size * ns.config.fontNameSize), outline or ns.config.fontNameOutline)
	fs:SetJustifyH(justify or "CENTER")
	fs:SetShadowOffset(1, -1)
	fs.basesize = size 
	if outline and type(outline) == "string" then
		fs.ignoreOutline = true
	end

	tinsert(ns.fontstringsB, fs)
	return fs
end

function ns.CreateFontStringBar(parent, size, justify, outline)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(ns.config.fontBar, (size * ns.config.fontBarSize), outline or ns.config.fontBarOutline)
	fs:SetJustifyH(justify or "CENTER")
	fs:SetShadowOffset(1, -1)
	fs.basesize = size 
	if outline and type(outline) == "string" then
		fs.ignoreOutline = true
	end

	tinsert(ns.fontstringsC, fs)
	return fs
end

function ns.CreateFontStringLevel(parent, size, justify, outline)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(ns.config.fontLevel, (size * ns.config.fontLevelSize), outline or ns.config.fontLevelOutline)
	fs:SetJustifyH(justify or "CENTER")
	fs:SetShadowOffset(1, -1)
	fs.basesize = size 
	if outline and type(outline) == "string" then
		fs.ignoreOutline = true
	end

	tinsert(ns.fontstringsD, fs)
	return fs
end

function oUFAbu:SetAllFonts()
	do
		local file = ns.config.fontNumber
		local mult = ns.config.fontNumberSize

		for _, fs in ipairs(ns.fontstrings) do
			local flag
			local _, size, oflag = fs:GetFont()
			if fs.ignoreOutline then
				flag = oflag
			else
				flag = ns.config.fontNumberOutline
			end

			if (fs.basesize) then
				if fs.origHeight then -- combatfeedbacktext
					fs.origHeight = fs.basesize * mult
				end
				fs:SetFont(file, fs.basesize * mult, flag)
			else
				fs:SetFont(file, size or 13, flag)
			end
		end
	end

	do
		local file = ns.config.fontName
		local mult = ns.config.fontNameSize

		for _, fs in ipairs(ns.fontstringsB) do
			local flag = ns.config.fontNameOutline
			local _, size, oflag = fs:GetFont()
			if fs.ignoreOutline then
				flag = oflag
			end
			if (fs.basesize) then
				fs:SetFont(file, fs.basesize * mult, flag)
			else
				fs:SetFont(file, size or 14, flag)
			end
		end
	end

	do
		local file = ns.config.fontBar
		local mult = ns.config.fontBarSize

		for _, fs in ipairs(ns.fontstringsC) do
			local flag = ns.config.fontBarOutline
			local _, size, oflag = fs:GetFont()
			if fs.ignoreOutline then
				flag = oflag
			end
			if (fs.basesize) then
				fs:SetFont(file, fs.basesize * mult, flag)
			else
				fs:SetFont(file, size or 14, flag)
			end
		end
		for i = 1, 3 do
			local bar = _G["MirrorTimer" .. i]
			local _, size = bar.text:GetFont()
			bar.text:SetFont(file, size, ns.config.fontBarOutline)
		end
	end

	do
		local file = ns.config.fontLevel
		local mult = ns.config.fontLevelSize

		for _, fs in ipairs(ns.fontstringsD) do
			local flag = ns.config.fontLevelOutline
			local _, size, oflag = fs:GetFont()
			if fs.ignoreOutline then
				flag = oflag
			end
			if (fs.basesize) then
				fs:SetFont(file, fs.basesize * mult, flag)
			else
				fs:SetFont(file, size or 14, flag)
			end
		end
	end
end
------------------------------------------------------------------------
