
local _, ns = ...

local function FormatTime(time)
	if (time >= 86400) then
		return format("%dd", floor(time/86400 + 0.5))
	elseif (time>= 3600) then
		return format("%dh", floor(time/3600 + 0.5))
	elseif (time >= 60) then
		return format("%dm", floor(time/60 + 0.5))
	end

	return format("%d", math.fmod(time, 60))
end

oUF.Tags.Events["abu:additionalpower"] = "UNIT_POWER_UPDATE UNIT_DISPLAYPOWER UNIT_MAXPOWER"
oUF.Tags.Methods["abu:additionalpower"] = function(unit)
	local min, max = UnitPower(unit, SPELL_POWER_MANA), UnitPowerMax(unit, SPELL_POWER_MANA)
	if (min == max) then
		return ns.FormatValue(min)
	else
		return ns.FormatValue(min).."/"..ns.FormatValue(max)
	end
end

oUF.Tags.Methods["abu:pvptimer"] = function()
	local pvpTime = (GetPVPTimer() or 0)/1000
	if (not IsPVPTimerRunning()) or (pvpTime < 1) or (pvpTime > 300) then --999?
		return ""
	end

	return FormatTime(math.floor(pvpTime))
end

oUF.Tags.Events["abu:level"] = "UNIT_LEVEL PLAYER_LEVEL_UP"
oUF.Tags.Methods["abu:level"] = function(unit)
	local level = UnitLevel(unit)
	if not ns.Classic then
		if(UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit)) then
			level = UnitBattlePetLevel(unit)
		end
	end

	if (level <= 0 or UnitIsCorpse(unit)) and (unit == "player" or unit == "target" or unit == "focus") then
		return "|TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:12:12:0:0|t" -- boss skull icon
	end

	local colorL = GetQuestDifficultyColor(level)
	return format("|cff%02x%02x%02x%s|r", colorL.r*255, colorL.g*255, colorL.b*255, level)
end

oUF.Tags.Events["abu:name"] = "UNIT_NAME_UPDATE"
oUF.Tags.Methods["abu:name"] = function(unit, realUnit)
	local color
	local unitName, unitRealm = UnitName(realUnit or unit)
	local _, class = UnitClass(realUnit or unit)

	if not unitName then
		local id = unit:match"arena(%d)$"
		if(id) then
			unitName = "Arena "..id
		end
	elseif (unitRealm) and (unitRealm ~= "") then
		unitName = unitName.." (*)"
	end

	if ns.config.TextNameColorMode == "CLASS" then
		if UnitIsPlayer(unit) then
			color = oUF.colors.class[class]
		elseif UnitIsEnemy(unit, "player") then
			color = oUF.colors.reaction[1]
		else
			color = oUF.colors.reaction[UnitReaction(unit, "player") or 5]
		end
	end
	if not color then
		color = ns.config.TextNameColor
	end

	return format("|cff%02x%02x%02x%s|r", color[1]*255, color[2]*255, color[3]*255, unitName)
end