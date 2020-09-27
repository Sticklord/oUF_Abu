local _, ns = ...
if ns.locale  ~= "zhCN" then return end
local L = ns.L

-- [[ Main Addon ]] --
L.OptionsLoadAfterCombat = '选项将在脱离战斗后加载!'
L.AuraAdded = 'Spell "%s" (%d) 已添加到光环过滤器.'
L.AuraExists = 'Spell "%s" (%d) 已存在'
L.Anchors_Unlocked = "框体已解锁."
L.Anchors_Locked = "框体已锁定."
L.Anchors_tooltipline1 = "按住 SHIFT键 拖动"
L.Anchors_tooltipline2 = "按住 ALT键单击 重置位置"
L.Anchors_InCombat = "不能在战斗中解锁框体."

-- [[ OPTIONS ]] --
L.ReloadUIWarning_Desc = "你的改动需要重载 \n 界面来完全生效,重载?"
L.NoEffectUntilRL = "这些设置将在重载后生效."

---- PROFILES
L.EnterProfileName = "输入配置文件名"

---- AURA PANEL
L.AuraFilters = "光环过滤器"

L.AuraFilterGeneralDesc = "添加一个新光环过滤或编辑现有的."
L.AllFrames = "所有框体"

L.AuraFilterArenaDesc = "竞技场框体增益白名单."
L.ArenaFrames = "竞技场框体"

L.AuraFilterBossDesc = "首领框体减益白名单."
L.BossFrames = "首领框体"

L.ShowAll = "显示所有"
L.OnlyOwn = "仅自己的"
L.HideOnFriendly = "隐藏友方的"
L.NeverShow = "从不显示"

L.Auras_EnterSpellID = "输入一个法术ID"
L.Auras_AlreadyAdded = "已添加!"
L.Auras_InvalidSpellID = "无效的法术ID!"

---- GENERAL PANEL
L.General = "基本"

L.General_Party = "启用小队框体"
L.General_PartyInRaid = "团队中显示小队框体"
-- L.General_SelfInParty = "Display yourself in Party"
L.General_Arena = "启用竞技场框体"
L.General_Boss = "启用首领框体"
L.General_Castbars = "启用施法条"
L.General_Ticks = "显示引导法术频率"
L.General_PTimer = "显示头像计时"
L.General_Feedback = "显示战斗反馈"
L.General_Threat = "启用仇恨发光"
L.General_OnlyPlayer = "只对玩家减益着色"
L.General_AuraTimer = "显示光环计时器"
L.General_AuraTimerTip = "禁用内置光环计时器"
L.General_Click = "点击穿过框体"
L.General_ClickTip = "使框体可以点击穿过."
L.General_ModKey = "焦点组合按键"
L.General_ModButton = "焦点鼠标按键"
L.General_Absorb = "启用吸收量条"
L.General_AbsorbTip = "为一个单位显示一个总吸收量条."
L.General_ClassP = "启用职业图标头像"
L.General_ClassPTip = "显示一个职业图标替代玩家头像."

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
L.Texture = "材质"
L.Texture_Statusbar = "状态条材质"
L.Texture_Frames = "框体"
L.Texture_Path = "自定义材质路径"
-- L.Texture_Border = "Border Texture"

L.Texture_Player = "玩家框体样式"
L.Texture_Normal = "正常"
L.Texture_NormalTip = "正常的玩家框体"
L.Texture_Rare = "稀有"
L.Texture_RareTip = "玩家框体使用稀有样式"
L.Texture_Elite = "精英"
L.Texture_EliteTip = "玩家框体使用精英样式"
L.Texture_RareElite = "稀有精英"
L.Texture_RareEliteTip = "玩家框体使用稀有精英样式"
L.Texture_Custom = "自定义"
L.Texture_CustomTip = "自定义玩家框体"

-- COLORS:
L.Color_Class = "职业颜色"
L.Color_ClassTip = "使用职业颜色"
L.Color_Gradient = "渐变颜色"
L.Color_GradientTip ="使用从绿色到红色的渐变"
L.Color_Custom = "自定义颜色"
L.Color_CustomTip = "使用一个自定义颜色"
L.Color_Power = "能量类型颜色"
L.Color_PowerTip = "以能量类型着色"

L.Color_Frame = "框体覆盖颜色"
L.Color_Latency = "施法条延迟颜色"
L.Color_Backdrop = "背景颜色"

L.Color_HealthBar = "生命条颜色"
L.Color_PowerBar = "能量条颜色"
L.Color_NameText = "姓名文字颜色"
L.Color_HealthText = "生命值文字颜色"
L.Color_PowerText = "能量值文字颜色"

---- FONTS
L.Font = "字体"
L.Font_Outline = "轮廓"
L.Font_ThinOutline = "细轮廓"
L.Font_ThickOutline = "粗轮廓"
L.Font_OutlineMono = "单色"
L.Font_Number = "数值字体"
L.Font_NumberSize = "数值字体大小"
L.Font_NumberOutline = "轮廓类型"
L.Font_Name = "姓名字体"
L.Font_NameSize = "姓名字体大小"
L.Font_NameOutline = "轮廓类型"
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
L.Positions_Name = "单位框体"
L.Positions_X = "水平 [x]"
L.Positions_Y = "垂直 [y]"
L.Positions_Point = "锚点"
L.Positions_Toggle = "切换锚点"

---- UNITS
L.Tag_Numeric = "数值"
L.Tag_Both = "同时"
L.Tag_Percent = "百分比"
L.Tag_Minimal = "最小"
L.Tag_Deficit = "损失"
L.Tag_Disable = "禁用"
L.Tag_NumericTip = "显示数值"
L.Tag_BothTip = "同时显示百分比和数值"
L.Tag_PercentTip = "显示百分比"
L.Tag_MinimalTip = "显示百分比,最大时隐藏"
L.Tag_DeficitTip = "显示一个损失数值"
L.Tag_DisableTip = "禁用这个框体的文本"

L.Icon_DontShow = "不显示"
L.Icon_Left = "图标在左侧"
L.Icon_Right = "图标在右侧"

L.Fat = "加厚"
L.Normal = "正常"

L.TOP = "顶部"
L.BOTTOM = "底部"
L.LEFT = "左侧"
L.CENTER = "中间"
L.RIGHT = "右侧"

L.player = PLAYER
L.target = TARGET
L.targettarget = "目标的目标"
L.pet = PET
L.focus = "焦点"
L.focustarget = "焦点的目标"
L.party = PARTY
L.boss = BOSS
L.arena = ARENA

L.Scale = "缩放"
L.Style = "样式"
L.EnableAuras = "启用光环"
L.EnableAuraTip = "为这个单位启用光环"
L.BuffPos = "增益位置"
L.DebuffPos = "减益位置"

L.Castbar = "施法条"
L.ShowCastbar = "显示施法条"
L.ShowCastbarTip = "为这个单位显示施法条"
L.Width = "宽度"
L.Height = "高度"
L.CastbarIcon = "施法条图标"
L.HoriPos = "水平位置"
L.VertPos = "垂直位置"

L.TextHealthTag = "生命值文本"
L.TextPowerTag = "能量值文本"

L.UnitSpecific = "单位细节"