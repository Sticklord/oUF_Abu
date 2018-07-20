--[[
	self.Aurabar.spellID  		- The spell to track (required)
	self.Aurabar.filter 		- Default is "HELPFUL"

	self.Aurabar.PreUpdate(Aurabar, unit)
	self.Aurabar.PostUpdate(Aurabar, unit, timeleft, duration)

	self.Aurabar.Override(self, event, unit)
		- Completely override the update function
	self.Aurabar.Visibility(self, event, unit)
		- Already takes vehicles into account	
		- return true or false if it should show
	self.Aurabar.OverrideVisibility(self, event, unit)
		- Completely, need to show and register events to the element
]]

local _, ns = ...
local oUF = ns.oUF or oUF

local function UpdateBar(self, e)
	self.timeleft = self.timeleft - e

	if self.timeleft <= 0 then
		self:SetScript("OnUpdate", nil)
		self:Hide()
		return
	end

	self:SetValue(self.timeleft / self.dur * 100)
end

local function Update(self, event, unit)
	local bar = self.Aurabar
	if not bar.active then return end
	if bar.PreUpdate then
		bar:PreUpdate(unit)
	end
	local timeleft
	for i=1,40 do
		local name, _, _, count, _, duration, expires = UnitAura(unit, i, bar.filter)
		if name==bar.spellName then
			break
		end
	end
	if duration then
		timeleft = expires - GetTime()
		if bar.timeleft and (bar.timeleft >= timeleft) then
			bar.dur = bar.dur
		else
			bar.dur = duration
		end
		bar.timeleft = timeleft	
		bar:Show()
		bar:SetScript("OnUpdate", UpdateBar)
	elseif bar:IsShown() then
		bar:Hide()
		bar:SetScript("OnUpdate", nil)
	end

	if bar.PostUpdate then 
		bar:PostUpdate(unit, timeleft, duration)
	end
end

local function Path(self, ...)
	return (self.Aurabar.Override or Update)(self, ...)
end

local Visibility = function(self, event, unit)
	local bar = self.Aurabar
	local shouldshow = true
	if bar.Visibility then
		shouldshow = bar.Visibility(self, event, unit)
	end

	if not bar.filter then bar.filter = "HELPFUL" end
	if bar.spellID then
		bar.spellName, bar.rank = GetSpellInfo(bar.spellID)
	else
		shouldshow = false
	end
	if not bar.rank then bar.rank = ""; end

	if UnitHasVehicleUI("player")
		or ((HasVehicleActionBar() and UnitVehicleSkin("player") and UnitVehicleSkin("player") ~= "")
		or (HasOverrideActionBar() and GetOverrideBarSkin() and GetOverrideBarSkin() ~= ""))
	then
		if bar:IsShown() then
			bar:Hide()
			self:UnregisterEvent("UNIT_AURA", Path)
		end
	elseif (shouldshow) then
		if (not bar.active) then
			bar.active = true
			self:RegisterEvent("UNIT_AURA", Path)
			bar:ForceUpdate()
		end
	elseif (bar.active) then
		bar.active = false
		bar:Hide()
		self:UnregisterEvent("UNIT_AURA", Path)
	end
end

local function VisibilityPath(self, ...)
	return (self.Aurabar.OverrideVisibility or Visibility)(self, ...)
end

local function ForceUpdate(bar)
	VisibilityPath(bar.__owner, "ForceUpdate", bar.__owner.unit)
	return Path(bar.__owner, "ForceUpdate", bar.__owner.unit)
end

local function Enable(self, unit)
	local bar = self.Aurabar
	if bar then
		bar.__owner = self
		bar.ForceUpdate = ForceUpdate
		
		if(not bar:GetStatusBarTexture()) then
			bar:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
		end
		bar:Hide()

		self:RegisterEvent('PLAYER_TALENT_UPDATE', VisibilityPath)
		self:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR", VisibilityPath, true)
		self:RegisterEvent("UNIT_ENTERED_VEHICLE", VisibilityPath)
		self:RegisterEvent("UNIT_EXITED_VEHICLE", VisibilityPath)
		VisibilityPath(self)

		bar:SetMinMaxValues(0, 100)
		return true
	end
end

local function Disable(self)
	local bar = self.Aurabar
	if bar then
		self:UnregisterEvent('UNIT_AURA', Path)

		self:UnregisterEvent('PLAYER_TALENT_UPDATE', VisibilityPath)
		self:UnregisterEvent("UPDATE_OVERRIDE_ACTIONBAR", VisibilityPath, true)
		self:UnregisterEvent("UNIT_ENTERED_VEHICLE", VisibilityPath)
		self:UnregisterEvent("UNIT_EXITED_VEHICLE", VisibilityPath)
		bar:Hide()
	end
end

oUF:AddElement('Aurabar', Path, Enable, Disable)