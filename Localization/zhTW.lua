local _, ns = ...
if ns.locale ~= "ztTW" then return end
local L = ns.L

-- [[ Main Addon ]] --
L.OptionsLoadAfterCombat = '選項將在脫離戰鬥後加載!'
L.AuraAdded = 'Spell "%s" (%d) 已添加到光環過濾器.'
L.AuraExists = 'Spell "%s" (%d) 已存在'
L.Anchors_Unlocked = "框架已解鎖."
L.Anchors_Locked = "框架已鎖定."
L.Anchors_tooltipline1 = "按住 SHIFT鍵 拖動"
L.Anchors_tooltipline2 = "按住 ALT鍵單擊 重置位置"
L.Anchors_InCombat = "不能在戰鬥中解鎖框架."

-- [[ OPTIONS ]] --
L.ReloadUIWarning_Desc = "你的改動需要重載 \n 界面來完全生效,是否重載?"
L.NoEffectUntilRL = "這些設置將在重載后生效."

---- PROFILES
L.EnterProfileName = "輸入配置文件名"

---- AURA PANEL
L.AuraFilters = "光環過濾器"

L.AuraFilterGeneralDesc = "添加一個到新光環或編輯現有的."
L.AllFrames = "所有框架"

L.AuraFilterArenaDesc = "競技場框架增益白名單."
L.ArenaFrames = "競技場框架"

L.AuraFilterBossDesc = "首領框架減益白名單."
L.BossFrames = "首領框架"

L.ShowAll = "顯示所有"
L.OnlyOwn = "僅自己的"
L.HideOnFriendly = "隱藏友方的"
L.NeverShow = "從不顯示"

L.Auras_EnterSpellID = "輸入一個法術ID"
L.Auras_AlreadyAdded = "已添加!"
L.Auras_InvalidSpellID = "無效的法術ID!"

---- GENERAL PANEL
L.General = "基本"

L.General_Party = "啓用小隊框架"
L.General_PartyInRaid = "团隊中顯示小隊框架"
-- L.General_SelfInParty = "Display yourself in Party"
L.General_Arena = "啓用競技場框架"
L.General_Boss = "啓用首領框架"
L.General_Castbars = "啓用施法條"
L.General_Ticks = "顯示引導法術頻率"
L.General_PTimer = "顯示頭像計時"
L.General_Feedback = "顯示戰鬥反饋"
L.General_Threat = "啓用仇恨發光"
L.General_OnlyPlayer = "只對玩家減益着色"
L.General_AuraTimer = "顯示光環計時器"
L.General_AuraTimerTip = "禁用内置光環計時器"
L.General_Click = "點擊穿過框架"
L.General_ClickTip = "使框架可以點擊穿過."
L.General_ModKey = "焦點組合按鍵"
L.General_ModButton = "焦點鼠標按鍵"
L.General_Absorb = "啓用吸收量條"
L.General_AbsorbTip = "爲一個單位顯示一個總吸收量條."
L.General_ClassP = "啓用職業圖標頭像"
L.General_ClassPTip = "顯示一個職業圖標替代玩家頭像."

-- L.General_showComboPoints = "Enable Combo Points"
-- L.General_showComboPointsTip = "Enable the Combo Points frame"
-- L.General_showRunes = "Enable Runes"
-- L.General_showRunesTip = "Enable Death Knight runes"
-- L.General_showAdditionalPower = "Enable Additional Power Bar"
-- L.General_showAdditionalPowerTip = "Enable the extra mana bar that some classes have"
-- L.General_showTotems = "Enable Totems"
-- L.General_showTotemsTip = "Enable Totems for the class (not valid for all classes)"
-- L.General_showArcaneStacks = "Enable Arcane Charge"
-- L.General_showArcaneStacksTip = "Enable Arcane Charge for Arcane Mages"
-- L.General_showChi = "Enable Chi Points"
-- L.General_showChiTip = "Enable Chi Points for Windwalker Monks"
-- L.General_showStagger = "Enable Stagger bar"
-- L.General_showStaggerTip = "Enable Stagger bar for Brewmaster Monks"
-- L.General_showHolyPower = "Enable Holy Power"
-- L.General_showHolyPowerTip = "Enable Holy Power for Retribution Paladins"
-- L.General_showInsanity = "Enable Insanity Overlay"
-- L.General_showInsanityTip = "Show the overlay over priests power bar when Insanity is used"
-- L.General_showShards = "Enable Shards"
-- L.General_showShardsTip = "Show the Warlock Shards beneath the player frame"
-- L.General_classAuraBar = "%s Aurabar"
-- L.General_classAuraBarTip = "Display an aura bar above the player frame for your specialization. \n Set the spell ID of the aura and set a color for the bar"

---- TEXTURES
L.Texture = "材質"
L.Texture_Statusbar = "狀態條材質"
L.Texture_Frames = "框架"
L.Texture_Path = "自定義材質路徑"
-- L.Texture_Border = "Border Texture"

L.Texture_Player = "玩家框架樣式"
L.Texture_Normal = "正常"
L.Texture_NormalTip = "正常的玩家框架"
L.Texture_Rare = "稀有"
L.Texture_RareTip = "玩家框架使用稀有樣式"
L.Texture_Elite = "精英"
L.Texture_EliteTip = "玩家框架使用精英樣式"
L.Texture_RareElite = "稀有精英"
L.Texture_RareEliteTip = "玩家框架使用稀有精英樣式"
L.Texture_Custom = "自定義"
L.Texture_CustomTip = "自定義玩家框架"

-- COLORS:
L.Color_Class = "職業顏色"
L.Color_ClassTip = "使用職業顏色"
L.Color_Gradient = "漸變顏色"
L.Color_GradientTip ="使用從綠色到紅色的漸變"
L.Color_Custom = "自定義顏色"
L.Color_CustomTip = "使用一個自定義顏色"
L.Color_Power = "能量類型顏色"
L.Color_PowerTip = "以能量類型着色"

L.Color_Frame = "框架覆蓋顏色"
L.Color_Latency = "施法條延遲顏色"
L.Color_Backdrop = "背景顏色"

L.Color_HealthBar = "生命條顏色"
L.Color_PowerBar = "能量條顏色"
L.Color_NameText = "姓名文本顏色"
L.Color_HealthText = "生命值文本顏色"
L.Color_PowerText = "能量值文本顏色"

---- FONTS
L.Font = "字體"
L.Font_Outline = "輪廓"
L.Font_ThinOutline = "細輪廓"
L.Font_ThickOutline = "粗輪廓"
L.Font_OutlineMono = "單色"
L.Font_Number = "數字字體"
L.Font_NumberSize = "數字字體大小"
L.Font_NumberOutline = "數字輪廓類型"
L.Font_Name = "名字字體"
L.Font_NameSize = "名字字體大小"
L.Font_NameOutline = "名字輪廓類型"
-- L.Font_Bar = "Bar Font"
-- L.Font_BarSize = "Bar Font Size"
-- L.Font_BarOutline = "Bar Outline Type"
-- L.Font_Level = "Level Font"
-- L.Font_LevelSize = "Level Font Size"
-- L.Font_LevelOutline = "Level Outline Type"
-- L.Font_HealthOffset = "Health Y Offset"
-- L.Font_PowerOffset = "Power Y Offset"

---- POSITIONS
L.Positions = "位置"
L.Positions_Name = "單位框架"
L.Positions_X = "水平 [x]"
L.Positions_Y = "垂直 [y]"
L.Positions_Point = "錨點"
L.Positions_Toggle = "切換錨點"

---- UNITS
L.Tag_Numeric = "數值"
L.Tag_Both = "同時"
L.Tag_Percent = "百分比"
L.Tag_Minimal = "最小"
L.Tag_Deficit = "損失"
L.Tag_Disable = "禁用"
L.Tag_NumericTip = "顯示數值"
L.Tag_BothTip = "同時顯示百分比和數值"
L.Tag_PercentTip = "顯示百分比"
L.Tag_MinimalTip = "顯示百分比,最大時隱藏"
L.Tag_DeficitTip = "顯示一個損失數值"
L.Tag_DisableTip = "禁用這個框架的文本"

L.Icon_DontShow = "不顯示"
L.Icon_Left = "圖標在左側"
L.Icon_Right = "圖標在右側"

L.Fat = "加厚"
L.Normal = "正常"

L.TOP = "顶部"
L.BOTTOM = "底部"
L.LEFT = "左側"
L.CENTER = "居中"
L.RIGHT = "右側"

L.player = PLAYER
L.target = TARGET
L.targettarget = "目標的目標"
L.pet = PET
L.focus = "焦點"
L.focustarget = "焦點的目標"
L.party = PARTY
L.boss = BOSS
L.arena = ARENA

L.Scale = "縮放"
L.Style = "樣式"
L.EnableAuras = "啓用光環"
L.EnableAuraTip = "爲這個單位啓用光環"
L.BuffPos = "增益位置"
L.DebuffPos = "減益位置"

L.Castbar = "施法條"
L.ShowCastbar = "顯示施法條"
L.ShowCastbarTip = "爲這個單位顯示施法條"
L.Width = "寬度"
L.Height = "高度"
L.CastbarIcon = "施法條圖標"
L.HoriPos = "水平位置"
L.VertPos = "垂直位置"

L.TextHealthTag = "生命值文本"
L.TextPowerTag = "能量值文本"

L.UnitSpecific = "單位細節"