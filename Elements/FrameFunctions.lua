local _, ns = ...
-- Border
local sections = { "TOPLEFT", "TOPRIGHT", "TOP", "BOTTOMLEFT", "BOTTOMRIGHT", "BOTTOM", "LEFT", "RIGHT" }

local function SetBorderColor(self, r, g, b, a)
	local t = self.borderTextures
	if t then
		if not r or not g and not b then
			r, g, b = 1, 1, 1
		end
		for _, tex in pairs (t) do
			tex:SetVertexColor(r, g, b, a or 1)
		end
	end
end

local function SetBorderShadowColor(self, r, g, b, a)
	local t = self.borderShadow
	if t then
		if not r or not g and not b then
			r, g, b = 1, 1, 1
		end

		for _, tex in pairs (t) do
			tex:SetVertexColor(r, g, b, a or 1)
		end
	end
end

local function SetBorderTexture(self, texture)
	local b = self.borderTextures
	if b then
		if texture == "white" then
			texture = ns.config.textureBorderWhite
		elseif texture == "default" then
			texture = ns.config.textureBorder
		end
		for _, tex in pairs(b) do
			tex:SetTexture(texture)
		end
	end
end
-----------------
local function SetBorderSize(self, size)
	local b = self.borderTextures
	local s = self.borderShadow
	if b then
		for _, tex in pairs(b) do
			tex:SetSize(size, size)
		end
	end
	if s then
		for _, tex in pairs(s) do
			tex:SetSize(size, size)
		end
	end
end

local function GetBorderSize(self)
	if self.borderTextures then
		local size = self.borderTextures.TOPRIGHT:GetSize()
		return size
	end
end
------------------
local function SetBorderPadding(self, T, B, L, R)
	local b = self.borderTextures
	local s = self.borderShadow
	if b and T then
		if not R and not B and not B and not L then
			R, B, L = T, T, T
		end

		b.TOPLEFT:SetPoint("TOPLEFT", self, -L, T)
		b.TOPRIGHT:SetPoint("TOPRIGHT", self, R, T)
		b.TOP:SetPoint("TOPLEFT", b.TOPLEFT, "TOPRIGHT")
		b.TOP:SetPoint("TOPRIGHT", b.TOPRIGHT, "TOPLEFT")
		b.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, -L, -B)
		b.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, R, -B)
		b.BOTTOM:SetPoint("BOTTOMLEFT", b.BOTTOMLEFT, "BOTTOMRIGHT")
		b.BOTTOM:SetPoint("BOTTOMRIGHT", b.BOTTOMRIGHT, "BOTTOMLEFT")
		b.LEFT:SetPoint("TOPLEFT", b.TOPLEFT, "BOTTOMLEFT")
		b.LEFT:SetPoint("BOTTOMLEFT", b.BOTTOMLEFT, "TOPLEFT")
		b.RIGHT:SetPoint("TOPRIGHT", b.TOPRIGHT, "BOTTOMRIGHT")
		b.RIGHT:SetPoint("BOTTOMRIGHT", b.BOTTOMRIGHT, "TOPRIGHT")

		local space = (self:GetBorderSize()) / 3.5

		s.TOPLEFT:SetPoint("TOPLEFT", self, -(L+space), (T+space))
		s.TOPRIGHT:SetPoint("TOPRIGHT", self, (R+space), (T+space))
		s.TOP:SetPoint("TOPLEFT", s.TOPLEFT, "TOPRIGHT")
		s.TOP:SetPoint("TOPRIGHT", s.TOPRIGHT, "TOPLEFT")
		s.BOTTOMLEFT:SetPoint("BOTTOMLEFT", self, -(L+space), -(B+space))
		s.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", self, (R+space), -(B+space))
		s.BOTTOM:SetPoint("BOTTOMLEFT", s.BOTTOMLEFT, "BOTTOMRIGHT")
		s.BOTTOM:SetPoint("BOTTOMRIGHT", s.BOTTOMRIGHT, "BOTTOMLEFT")
		s.LEFT:SetPoint("TOPLEFT", s.TOPLEFT, "BOTTOMLEFT")
		s.LEFT:SetPoint("BOTTOMLEFT", s.BOTTOMLEFT, "TOPLEFT")
		s.RIGHT:SetPoint("TOPRIGHT", s.TOPRIGHT, "BOTTOMRIGHT")
		s.RIGHT:SetPoint("BOTTOMRIGHT", s.BOTTOMRIGHT, "TOPRIGHT")
	end
end
-----------------
function ns.CreateBorder(self, size, padding, layer)
	if type(self) ~= "table" or self.borderTextures then return end

	if not (self.borderTextures) then
		local b = {}
		local s = {}

		for i = 1, 8 do
			local t = self:CreateTexture(nil, layer or "OVERLAY")
			t:SetParent(self)
			t:SetTexture(ns.config.textureBorder)
			t:SetVertexColor(1, 1, 1, 1)
			b[sections[i]] = t
		end

		for i = 1, 8 do
			local t = self:CreateTexture(nil, layer or "BORDER")
			t:SetParent(self)
			t:SetTexture(ns.config.textureBorderShadow)
			t:SetVertexColor(0, 0, 0, 1)
			s[sections[i]] = t
		end

		b.TOPLEFT:SetTexCoord(0, 1/3, 0, 1/3)
		b.TOPRIGHT:SetTexCoord(2/3, 1, 0, 1/3)
		b.TOP:SetTexCoord(1/3, 2/3, 0, 1/3)
		b.BOTTOMLEFT:SetTexCoord(0, 1/3, 2/3, 1)
		b.BOTTOMRIGHT:SetTexCoord(2/3, 1, 2/3, 1)
		b.BOTTOM:SetTexCoord(1/3, 2/3, 2/3, 1)
		b.LEFT:SetTexCoord(0, 1/3, 1/3, 2/3)
		b.RIGHT:SetTexCoord(2/3, 1, 1/3, 2/3)

		s.TOPLEFT:SetTexCoord(0, 1/3, 0, 1/3)
		s.TOPRIGHT:SetTexCoord(2/3, 1, 0, 1/3)
		s.TOP:SetTexCoord(1/3, 2/3, 0, 1/3)
		s.BOTTOMLEFT:SetTexCoord(0, 1/3, 2/3, 1)
		s.BOTTOMRIGHT:SetTexCoord(2/3, 1, 2/3, 1)
		s.BOTTOM:SetTexCoord(1/3, 2/3, 2/3, 1)
		s.LEFT:SetTexCoord(0, 1/3, 1/3, 2/3)
		s.RIGHT:SetTexCoord(2/3, 1, 1/3, 2/3)

		self.borderTextures = b
		self.borderShadow = s

		self.SetBorderColor = SetBorderColor
		self.SetBorderShadowColor = SetBorderShadowColor
		self.SetBorderTexture = SetBorderTexture
		self.SetBorderSize = SetBorderSize
		self.GetBorderSize = GetBorderSize
		self.SetBorderPadding = SetBorderPadding

		self:SetBorderSize(size or 11)
		self:SetBorderPadding(padding or 3)
	end
end

-- Small bar ontop/below of frames
function ns.CreateOutsideBar(parent, onTop, r, g, b)
	local textPath = "Interface\\AddOns\\oUF_Abu\\Media\\Frames\\"
	local bar = ns.CreateStatusBar(parent, "BORDER", nil, true)
	bar:SetSize(98, 9)
	bar:SetStatusBarColor(r or 1, g or 0, b or 0)
	--bar:SetFrameLevel(10)

	local point, anchor, point2, x, y
	if onTop then
		point, anchor, point2, x, y = "BOTTOM", parent.Health, "TOP", 0, 3
	else
		point, anchor, point2, x, y = "TOP", parent.Power, "BOTTOM", 0, -2
	end
	bar:SetPoint(point, anchor, point2, x, y)

	local tex = bar:CreateTexture(nil, "ARTWORK")
	tex:SetSize(104, 28)
	if onTop then
		tex:SetTexture(textPath.. "FrameBarTop")
		tex:SetPoint("TOP", 0, 12)
	else
		tex:SetTexture(textPath.. "FrameBarBot")
		tex:SetPoint("BOTTOM", 0, -10)
	end
	--[=[
	-- [[ ANIMATION IN ]]
	local animation_in = bar:CreateAnimationGroup()
	animation_in:SetScript("OnPlay", function(self)
		bar:SetPoint(point, anchor, point2, x, y - step)
	end)
	animation_in:SetScript("OnFinished", function()
		bar:SetPoint(point, anchor, point2, x, y)
		bar:SetAlpha(1)
	end)
	local in_alpha = animation_in:CreateAnimation("Alpha")
	in_alpha:SetDuration(0.2)
	in_alpha:SetFromAlpha(0)
	in_alpha:SetToAlpha(1)
	local in_translation = animation_in:CreateAnimation("Translation")
	in_translation:SetDuration(0.2)
	in_translation:SetOffset(0, step)

	--  [[ ANIMATION OUT]]
	local animation_out = bar:CreateAnimationGroup()
	animation_out:SetScript("OnFinished", function()
		bar:SetAlpha(0)
	end)
	local out_alpha = animation_out:CreateAnimation("Alpha")
	out_alpha:SetDuration(0.2)
	out_alpha:SetFromAlpha(1)
	out_alpha:SetToAlpha(0)
	local out_translation = animation_out:CreateAnimation("Translation")
	out_translation:SetDuration(0.2)
	out_translation:SetOffset(0, -step)

	bar:SetAlpha(0)
	bar:Show()
	bar._Show = bar.Show
	bar._Hide = bar.Hide
	bar._IsShown = bar.IsShown
	bar.IsShown = function(self) return self.is_shown end

	bar.Show = function(self)
		if (not self.is_shown) and (not animation_in:IsPlaying()) then
			animation_in:Play()
			self.is_shown = true
		end
	end

	bar.Hide = function(self)
		if (self.is_shown) and (not animation_out:IsPlaying()) then
			animation_out:Play()
			self.is_shown = false
		end
	end]=]

	ns.PaintFrames(tex)
	bar.Texture = tex
	return bar
end