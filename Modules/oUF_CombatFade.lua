local _, ns = ...
local oUF = ns.oUF or oUF

if not oUF then return; end


-- Frame fading -- Stolen from blizzard UIPARRENT.lua

local UIFrameFadeIn, UIFrameFadeOut
do
	local frameFadeManager = CreateFrame("FRAME")
	local FADEFRAMES = {}
	local function UIFrameFade_OnUpdate(self, elapsed)
		local index = 1
		local frame, fadeInfo
		while FADEFRAMES[index] do
			frame = FADEFRAMES[index]
			fadeInfo = FADEFRAMES[index].fadeInfo;
			-- Reset the timer if there isn't one, this is just an internal counter
			if ( not fadeInfo.fadeTimer ) then
				fadeInfo.fadeTimer = 0
			end
			fadeInfo.fadeTimer = fadeInfo.fadeTimer + elapsed;

			-- If the fadeTimer is less then the desired fade time then set the alpha otherwise hold the fade state,
			-- call the finished function, or just finish the fade
			if ( fadeInfo.fadeTimer < fadeInfo.timeToFade ) then
				if ( fadeInfo.mode == "IN" ) then
					frame:SetAlpha((fadeInfo.fadeTimer / fadeInfo.timeToFade) * (fadeInfo.endAlpha - fadeInfo.startAlpha) + fadeInfo.startAlpha)
				elseif ( fadeInfo.mode == "OUT" ) then
					frame:SetAlpha(((fadeInfo.timeToFade - fadeInfo.fadeTimer) / fadeInfo.timeToFade) * (fadeInfo.startAlpha - fadeInfo.endAlpha)  + fadeInfo.endAlpha)
				end
			else
				frame:SetAlpha(fadeInfo.endAlpha)
				-- If there is a fadeHoldTime then wait until its passed to continue on
				if ( fadeInfo.fadeHoldTime and fadeInfo.fadeHoldTime > 0  ) then
					fadeInfo.fadeHoldTime = fadeInfo.fadeHoldTime - elapsed
				else
					-- Complete the fade and call the finished function if there is one
					tDeleteItem(FADEFRAMES, frame)
					if ( fadeInfo.finishedFunc ) then
						fadeInfo.finishedFunc(fadeInfo.finishedArg1, fadeInfo.finishedArg2, fadeInfo.finishedArg3, fadeInfo.finishedArg4)
						fadeInfo.finishedFunc = nil
					end
				end
			end

			index = index + 1
		end

		if ( #FADEFRAMES == 0 ) then
			self:SetScript("OnUpdate", nil)
		end
	end

	-- Generic fade function
	local function UIFrameFade(frame, fadeInfo)
		local alpha = frame:GetAlpha()
		if alpha ~= fadeInfo.startAlpha then
			fadeInfo.timeToFade = math.abs(fadeInfo.endAlpha-alpha)/math.abs(fadeInfo.endAlpha-fadeInfo.startAlpha) * fadeInfo.timeToFade
			fadeInfo.startAlpha = alpha
		end

		fadeInfo.fadeTimer = 0;
		frame.fadeInfo = fadeInfo

		local index = 1
		while FADEFRAMES[index] do
			-- If frame is already set to fade then return
			if ( FADEFRAMES[index] == frame ) then
				return
			end
			index = index + 1
		end

		tinsert(FADEFRAMES, frame);
		frameFadeManager:SetScript("OnUpdate", UIFrameFade_OnUpdate)
	end

	-- Convenience function to do a simple fade in
	function UIFrameFadeIn(frame, timeToFade, startAlpha, endAlpha)
		local fadeInfo = {};
		fadeInfo.mode = "IN"
		fadeInfo.timeToFade = timeToFade or 0.2
		fadeInfo.startAlpha = startAlpha or 0
		fadeInfo.endAlpha = endAlpha or 1
		UIFrameFade(frame, fadeInfo)
	end

	-- Convenience function to do a simple fade out
	function UIFrameFadeOut(frame, timeToFade, startAlpha, endAlpha)
		local fadeInfo = {};
		fadeInfo.mode = "OUT"
		fadeInfo.timeToFade = timeToFade or 0.2
		fadeInfo.startAlpha = startAlpha or 1
		fadeInfo.endAlpha = endAlpha or 0
		UIFrameFade(frame, fadeInfo)
	end
end

local enabledFrames = {}
local mouseOver = false
local is_showing

local function Update(self, event)
	local show
	local force = event == "OnShow"

	if event == "OnUpdate" then -- not needed, usually used for targettarget frames
		return
	elseif (UnitCastingInfo("player") or UnitChannelInfo("player")) or --casting
		(UnitHealth("player") ~= UnitHealthMax("player")) or 		--not full health
		(UnitExists("target") or UnitExists("focus")) or 			--have target or focus
		UnitAffectingCombat("player") or							--combat
		mouseOver or
		(UnitPowerType("player") == Enum.PowerType.Mana and UnitPower("player") ~= UnitPowerMax("player"))
	then

		if not is_showing or force then
			show = true
		end
	elseif is_showing or force then
		show = false
	end

	if type(show) == "boolean" then
		for frame in pairs(enabledFrames) do
			if UnitExists(frame.unit) then
				if show then
					if frame.fadeInfo.mode == "OUT" then
						UIFrameFadeIn(frame)
					end
				elseif frame.fadeInfo.mode == "IN" then
					UIFrameFadeOut(frame)
				end
			end
		end
		is_showing = show
	end
end

local eventFrame = CreateFrame("FRAME")
eventFrame:SetScript("OnEvent", Update)

local function Enable(self)
	if (not self.CombatFade) or enabledFrames[self] then return end
	enabledFrames[self] = true
	self.fadeInfo = {mode = "IN"}
	Update(self, "FORCEUPDATE")
	is_showing = true

	if not eventFrame:IsEventRegistered("PLAYER_ENTERING_WORLD") then
		eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		eventFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
		eventFrame:RegisterUnitEvent("UNIT_HEALTH", "player")
		eventFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
		eventFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
		eventFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
		eventFrame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
		eventFrame:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE", "player")
		eventFrame:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
		eventFrame:RegisterUnitEvent("UNIT_POWER_UPDATE", "player")
		eventFrame:RegisterUnitEvent("UNIT_MAXPOWER", "player")
	end

	if not self.CombatFadehooked then
		self:HookScript("OnEnter", function(self) if not enabledFrames[self] then return; end mouseOver = true; Update(self, "MOUSEOVER") end)
		self:HookScript("OnLeave", function(self) if not enabledFrames[self] then return; end mouseOver = false; Update(self, "MOUSEOVER") end)
		self:HookScript("OnHide", function(self)  if not enabledFrames[self] then return; end self.fadeInfo.mode = "OUT"; self:SetAlpha(0) end)
		self.CombatFadehooked = true
	end

	return true
end


local function Disable(self)
	if not enabledFrames[self] then return; end
	enabledFrames[self] = nil
	UIFrameFadeIn(self)

	local numframes = 0
	for _ in pairs(enabledFrames) do
		numframes = numframes + 1
	end

	if numframes == 0 then
		eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
		eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
		eventFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
		eventFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
		eventFrame:UnregisterEvent("PLAYER_FOCUS_CHANGED")
		eventFrame:UnregisterEvent("UNIT_HEALTH")
		eventFrame:UnregisterEvent("UNIT_SPELLCAST_START")
		eventFrame:UnregisterEvent("UNIT_SPELLCAST_STOP")
		eventFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
		eventFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
		eventFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
		eventFrame:UnregisterEvent("UNIT_MODEL_CHANGED")
		eventFrame:UnregisterEvent("UNIT_MODEL_CHANGED")
		eventFrame:UnregisterEvent("UNIT_POWER_UPDATE")
		eventFrame:UnregisterEvent("UNIT_MAXPOWER")
	end
end

oUF:AddElement("oUF_CombatFade", Update, Enable, Disable)