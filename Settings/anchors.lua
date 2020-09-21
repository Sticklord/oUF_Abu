--[[-----------------------------------------------------------------------------

	Anchor frames for player, targer, focus, party, raid & boss

	TODO work with non UIParent paraents
--]]-----------------------------------------------------------------------------
local _, ns = ...
local L = ns.L

---------------------------------------------------------------------------------
--		Functions for showing phony unitframes

local enableDummies
do
	local function toggleUnitFrame(obj, show)
		if show then
			obj.old_unit = obj.unit
			obj.unit = "player"
			obj.old_OnUpdate = obj:GetScript("OnUpdate")

			obj:SetScript("OnUpdate", nil)
			obj:SetAlpha(1)
			UnregisterUnitWatch(obj)
			RegisterUnitWatch(obj, true)

			obj:Show()
			if obj.Castbar then
				obj.Castbar:DummyCastbar()
			end
		elseif (obj.old_unit) then
			obj.unit = obj.old_unit or obj.unit
			obj.old_unit = nil

			UnregisterUnitWatch(obj) -- Reset the object
			RegisterUnitWatch(obj)

			if obj.old_OnUpdate then
				obj:SetScript("OnUpdate", obj.old_OnUpdate)
				obj.old_OnUpdate = nil
			end

			if obj.Castbar then
				obj.Castbar.casting = nil
				obj.Castbar:Hide()
			end
			obj:UpdateAllElements("OnShow")
		end
	end

	local function showSingleUnit(self, show)
		for _, obj in pairs(oUF.objects) do
			local unit = obj:GetAttribute("unit")
			if (unit) then
				for i = 1, #self.units do
					if (unit == self.units[i]) then
						toggleUnitFrame(obj, show)
					end
				end
			end
		end
	end

	function enableDummies(anchor)
		if anchor.isHeader then
			anchor:SetScript("OnShow", function(self)
				SecureStateDriverManager:SetAttribute("setframe", self.object)
				self.oldstate_driver = SecureStateDriverManager:GetAttribute("setstate"):gsub("state%-visibility%s", "") -- i suck at string formatting
				local numMembers = math.max(GetNumSubgroupMembers(LE_PARTY_CATEGORY_HOME) or 0, GetNumSubgroupMembers(LE_PARTY_CATEGORY_INSTANCE) or 0)
				self.object:SetAttribute("startingIndex", (numMembers - (ns.config.showSelfInParty and 4 or 3)))
				RegisterAttributeDriver(self.object, "state-visibility", "show")

				for i = 1, self.object:GetNumChildren() do
					local obj = select(i, self.object:GetChildren())
					toggleUnitFrame(obj, true)
				end
			end)
			anchor:SetScript("OnHide", function(self)
				self.object:SetAttribute("showParty", true)
				RegisterAttributeDriver(self.object, "state-visibility", self.oldstate_driver)
				self.oldstate_driver = nil
				self.object:SetAttribute("startingIndex", nil)

				for i = 1, self.object:GetNumChildren() do
					local obj = select(i, self.object:GetChildren())
					toggleUnitFrame(obj, false)
				end
			end)
		else
			anchor:SetScript("OnShow", function(self)
				showSingleUnit(self, true)
			end)
			anchor:SetScript("OnHide", function(self)
				showSingleUnit(self)
			end)
		end
	end
end

-------------------------------------------------------------------------
-- 		Positions

-- set points
local POINT, PARENT = "TOP", UIParent

local function anchor_GetCurrent(anchor)
	local point, _, rpoint, x, y = anchor:GetPoint()

	-- GetPoint doesnt give from the point "TOP" so lets figure it out
	local width, height = anchor:GetSize()

	if point:find("LEFT") then
		x = x + (width / 2 )
	elseif  point:find("RIGHT") then
		x = x - (width / 2)
	end

	if point:find("BOTTOM") then
		y = y + height
	elseif (not point:find("TOP")) then
		y = y + height/2
	end

	local scale = anchor.object:GetEffectiveScale() / UIParent:GetScale()
	return POINT, PARENT, rpoint, math.floor(x/scale + .5), math.floor(y/scale + .5)
end

local function anchor_GetSaved(anchor, default)
	local data
	if (not default) then
		data = ns.config[anchor.key1][anchor.key2]
		if type(data) == "table" then
			data = nil
		end
	end
	if (not data) then
		data = ns.defaultConfig[anchor.key1][anchor.key2]
	end

	local rp, x, y = string.split("/", data)
	return POINT, PARENT, rp, tonumber(x), tonumber(y)
end

local function anchor_Save(anchor, reset)
	local _, rp, x, y
	if reset then
		_, _, rp, x, y = anchor_GetSaved(anchor, true)
	else
		_, _, rp, x, y = anchor_GetCurrent(anchor)
	end
	ns.config[anchor.key1][anchor.key2] = string.format("%s/%d/%d", rp, x, y)
end

-------------------------------------------------------------------------
-- 		Creating anchors

local AnchorFrames = {}
local function CreateAnchor(frame, name, key1, key2, tlP, brP, strata)
	local anchor = CreateFrame("Button", name.."Anchor", UIParent)
	anchor:EnableMouse(true)
	anchor:SetFrameStrata(strata or "HIGH")
	anchor:SetMovable(true)
	anchor:RegisterForDrag("LeftButton")
	anchor:RegisterForClicks("AnyUp")
	anchor:SetClampedToScreen(true)

	anchor.topleftPoint = type(tlP) == "string" and tlP or tlP:GetName()
	anchor.botrightPoint = type(brP) == "string" and brP or brP:GetName()
	anchor.object = frame
	anchor.key1 = key1
	anchor.key2 = key2

	anchor:SetScript("OnMouseUp", function(self, button)
		if (IsAltKeyDown()) and (button == "LeftButton") then
			anchor_Save(self, true)
		end
		self:Update()
	end)

	anchor:SetScript("OnDragStart", function(self)
		if IsShiftKeyDown() then
			self.isMoving = true
			self:StartMoving()
			self:Release()
		end
	end)

	anchor:SetScript("OnDragStop", function(self)
		if self.isMoving then
			self:StopMovingOrSizing()
			anchor_Save(self)
			self:Update()
		end
		self.isMoving = nil
	end)

	anchor.Update = function(self)
		local obj = self.object
		obj:ClearAllPoints()
		obj:SetPoint(anchor_GetSaved(self))
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", self.topleftPoint)
		self:SetPoint("BOTTOMRIGHT", self.botrightPoint)
	end

	anchor.Release = function(self)
		local obj = self.object
		obj:ClearAllPoints()
		obj:SetPoint(POINT, self)
	end

	-- Tooltips
	anchor:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:AddLine(self.objectname)
		GameTooltip:AddLine(L.Anchors_tooltipline1,1,1,1)
		GameTooltip:AddLine(L.Anchors_tooltipline2,1,1,1)
		GameTooltip:Show()
	end)
	anchor:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	AnchorFrames[#AnchorFrames + 1] = anchor
	return anchor
end

function ns.CreateUnitAnchor(frame, tlP, brP, strata, ...) -- ... = unit(s)
	local key1 = frame.cUnit or ...
	local anchor = CreateAnchor(frame, frame:GetName():gsub("%d", ""), key1, "position", tlP, brP, strata)

	anchor.units = {...}
	anchor.isHeader = frame:GetAttribute("oUF-headerType") and true or false
	anchor.objectname = L[key1]

	enableDummies(anchor)
	-- Forces the creation of header children, so we get the full size
	if anchor.isHeader then
		anchor:GetScript("OnShow")(anchor)
	end

	anchor:Update()
	anchor:Hide()

	return anchor
end

function ns.CreateCastbarAnchor(frame)
	local name = frame:GetName()
	local key1 = frame.__owner.cUnit

	local a = CreateAnchor(frame, name, key1, "cbposition", name, name)
	a.objectname = L[key1].." "..L.Castbar

	a:Update()
	a:Hide()

	return a
end

function oUFAbu:PLAYER_REGEN_DISABLED()
	self:Print(L.Anchors_Locked)
	self:ToggleAllAnchors(true)
end

local LOCKED = true
function oUFAbu:ToggleAllAnchors(force_Lock)
	if LOCKED and (not force_Lock) then
		if InCombatLockdown() then return self:Print(L.Anchor_InCombat); end
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:Print(L.Anchors_Unlocked)
		for i = 1, #AnchorFrames do
			AnchorFrames[i]:Show()
		end
	elseif (not LOCKED) then
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:Print(L.Anchors_Locked)
		for i = 1, #AnchorFrames do
			AnchorFrames[i]:Hide()
		end
	end

	LOCKED = (not LOCKED)
	return LOCKED
end

function oUFAbu:UpdateAnchorPositions()
	if InCombatLockdown() then
		self:Print(L.Anchor_InCombat)
		return
	end
	for i = 1, #AnchorFrames do
		AnchorFrames[i]:Update()
	end
end

function oUFAbu:GetAnchorFrames()
	return AnchorFrames
end