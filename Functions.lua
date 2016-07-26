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
		return tonumber(format('%.2f', value/1e9))..'b'
	elseif absvalue >= 1e7 then
		return tonumber(format('%.1f', value/1e6))..'m'
	elseif absvalue >= 1e6 then
		return tonumber(format('%.2f', value/1e6))..'m'
	elseif absvalue >= 1e5 then
		return tonumber(format('%.0f', value/1e3))..'k'
	elseif absvalue >= 1e3 then
		return tonumber(format('%.1f', value/1e3))..'k'
	else
		return value
	end
end
ns.FormatValue = FormatValue
function ns.cUnit(unit)
	if (unit:match('vehicle')) then
		return 'player'
	elseif (unit:match('party%d')) then
		return 'party'
	elseif (unit:match('arena%d')) then
		return 'arena'
	elseif (unit:match('boss%d')) then
		return 'boss'
	elseif (unit:match('partypet%d')) then
		return 'pet'
	else
		return unit
	end
end

function ns.MultiCheck(what, ...)
	for i = 1, select('#', ...) do
		if (what == select(i, ...)) then 
			return true 
		end
	end

	return false
end

-------------------------------------------------------------------------------
local UnitIsGhost, GetSpellInfo, UnitIsConnected, UnitIsDead, UnitIsDeadOrGhost, UnitIsPlayer, UnitReaction, UnitIsEnemy, UnitSelectionColor =
	  UnitIsGhost, GetSpellInfo, UnitIsConnected, UnitIsDead, UnitIsDeadOrGhost, UnitIsPlayer, UnitReaction, UnitIsEnemy, UnitSelectionColor
local UnitPowerType, UnitPower, UnitPowerMax, UnitHasVehicleUI, UnitClass, UnitIsTapped, UnitIsTappedByPlayer, format = 
	  UnitPowerType, UnitPower, UnitPowerMax, UnitHasVehicleUI, UnitClass, UnitIsTapped, UnitIsTappedByPlayer, format

local function getClassColor(unit)
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		return colors.class[class]
	elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
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
			if (unit ~= 'player') then
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
		s = format('%s', cur > 0 and FormatValue(cur) or '')
	elseif tag == TEXT_LONG then
		s = format('%s - %.1f%%', FormatValue(cur), cur / max * 100)
	elseif tag == TEXT_MINMAX then
		s = format('%s/%s', FormatValue(cur), FormatValue(max))
	elseif tag == TEXT_MAX then
		s = format('%s', FormatValue(max))
	elseif tag == TEXT_DEF then
		s = format('%s', (cur == max and '' or '-'..FormatValue(max-cur)))
	elseif tag == TEXT_PERCENT then
		s = format('%d%%', cur / max * 100)
	else
		s = ''
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
------------------------------------------------------------------
--						Extra health bars						--
------------------------------------------------------------------
function ns.UpdateIncHeals(self, event, unit)
	if (self.unit ~= unit) then return end
	local hp = self.HealPrediction
	local curHP, maxHP = UnitHealth(unit), UnitHealthMax(unit)
	local incHeal = UnitGetIncomingHeals(unit) or 0
	local healAbsorb = UnitGetTotalHealAbsorbs(unit) or 0

	if ( healAbsorb > 0) then
		hp.necroHeals:SetMinMaxValues(0, curHP)
		hp.necroHeals:SetValue(math.min(healAbsorb, curHP))
		hp.necroHeals:Show()
	else
		hp.necroHeals:Hide()
	end

	if ((incHeal - healAbsorb) <= 0) or (curHP == maxHP) then
		hp.incHeals:Hide()
	else
		hp.incHeals:SetMinMaxValues(0, maxHP - curHP)
		hp.incHeals:SetValue(incHeal - healAbsorb)
		hp.incHeals:Show()
	end

	if (hp.TotalAbsorb) then
		local absorb = UnitGetTotalAbsorbs(unit) or 0
		hp.TotalAbsorb:SetMinMaxValues(0, maxHP)
		hp.TotalAbsorb:SetValue(math.min(absorb, maxHP))
		if (absorb < (maxHP * 0.05)) then
			hp.TotalAbsorb:Hide()
		else
			hp.TotalAbsorb:Show()
			if not hp.TotalAbsorb.spark:IsShown() then
				hp.TotalAbsorb.spark:Show()
			end
		end
	end
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

	function ns.PostUpdatePower(Power, unit, cur, max)
		local self = Power:GetParent()
		local uconfig = ns.config[self.cUnit]

		if (UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit)) or (max == 0) then
			Power:SetValue(0)
			if Power.Value then
				Power.Value:SetText('')
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
	UnitFrame_OnEnter(self)

	self.isMouseOver = true
	if self.mouseovers then
		for _, text in pairs (self.mouseovers) do
			text:ForceUpdate()
		end
	end

	if (self.DruidMana and self.DruidMana.Value) then
		self.DruidMana.Value:Show()
	end
end

function ns.UnitFrame_OnLeave(self)
	if self.__owner then
		self = self.__owner
	end
	UnitFrame_OnLeave(self)

	self.isMouseOver = nil
	if self.mouseovers then
		for _, text in pairs (self.mouseovers) do
			text:ForceUpdate()
		end
	end

	if (self.DruidMana and self.DruidMana.Value) then
		self.DruidMana.Value:Hide()
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
	if type(layer) ~= 'string' then layer = 'BORDER' end
	local bar = CreateFrame('StatusBar', name, parent)
	bar:SetStatusBarTexture(ns.config.statusbar, layer)
	bar.statusbar = ns.config.statusbar
	
	if AddBackdrop then
		bar:SetBackdrop({bgFile = 'Interface\\Buttons\\WHITE8x8'})
		local r,g,b,a = unpack(ns.config.backdropColor)
		bar:SetBackdropColor(r,g,b,a)
	end

	table.insert(ns.statusbars, bar)
	return bar
end

function oUFAbu:SetAllStatusBars()
	local file = ns.config.statusbar

	for _, bar in ipairs(ns.statusbars) do
		if bar.SetStatusBarTexture then
			bar:SetStatusBarTexture(file)
		else
			bar:SetTexture(file)
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
function ns.CreateFontString(parent, size, justify, outline)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(ns.config.fontNormal, (size * ns.config.fontNormalSize), outline or ns.config.fontNormalOutline)
	fs:SetJustifyH(justify or "CENTER")
	fs:SetShadowOffset(1, -1)
	fs.basesize = size 
	if outline and type(outline) == 'string' then
		fs.ignoreOutline = true
	end

	tinsert(ns.fontstrings, fs)
	return fs
end

function ns.CreateFontStringBig(parent, size, justify, outline)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(ns.config.fontBig, (size * ns.config.fontBigSize), outline or ns.config.fontBigOutline)
	fs:SetJustifyH(justify or "CENTER")
	fs:SetShadowOffset(1, -1)
	fs.basesize = size 
	if outline and type(outline) == 'string' then
		fs.ignoreOutline = true
	end

	tinsert(ns.fontstringsB, fs)
	return fs
end

function oUFAbu:SetAllFonts()
	do
		local file = ns.config.fontNormal
		local mult = ns.config.fontNormalSize

		for _, fs in ipairs(ns.fontstrings) do
			local flag
			local _, size, oflag = fs:GetFont()
			if fs.ignoreOutline then
				flag = oflag
			else
				flag = ns.config.fontNormalOutline
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
		for i = 1, 3 do
			local bar = _G["MirrorTimer" .. i]
			local _, size = bar.text:GetFont()
			bar.text:SetFont(file, size, ns.config.fontNormalOutline)
		end
	end

	do
		local file = ns.config.fontBig
		local mult = ns.config.fontBigSize

		for _, fs in ipairs(ns.fontstringsB) do
			local flag = ns.config.fontBigOutline
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
