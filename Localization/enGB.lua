local _, ns = ...
local L = ns.L

-- Global stuff
L.Enable = _G.ENABLE

-- [[ Main Addon ]] --
L.OptionsLoadAfterCombat = "Options will be loaded after combat!"
L.AuraAdded = "Spell '%s' (%d) was added to the aura filter."
L.AuraExists = "Spell '%s' (%d) already exists"
L.Anchors_Unlocked = "Frames unlocked."
L.Anchors_Locked = "Frames locked."
L.Anchors_tooltipline1 = "Hold SHIFT to drag"
L.Anchors_tooltipline2 = "ALT-click to reset position"
L.Anchors_InCombat = "Can't unlock frames in combat."

-- [[OPTIONS ]] --
L.ReloadUIWarning_Desc = "You've made changes that requires a reload \n of the UI to take full effect, reload?"
L.NoEffectUntilRL = "These options will not take effect until you reload the UI."

---- PROFILES
L.EnterProfileName = "Enter Profile Name"

---- AURA PANEL
L.AuraFilters = "Aura Filters"

L.AuraFilterGeneralDesc = "Add filters to new auras or edit existing ones."
L.AllFrames = "All Frames"

L.AuraFilterArenaDesc = "Whitelist buffs for the Arena Frames."
L.ArenaFrames = "Arena Frames"

L.AuraFilterBossDesc = "Whitelist debuffs for the Boss Frames."
L.BossFrames = "Boss Frames"

L.ShowAll = "Show All"
L.OnlyOwn = "Only Own"
L.HideOnFriendly = "Hide on Friendly"
L.NeverShow = "Never Show"

L.Auras_EnterSpellID = "Enter a Spell ID"
L.Auras_AlreadyAdded = "Already added!"
L.Auras_InvalidSpellID = "Invalid Spell ID!"

---- GENERAL PANEL
L.General = "Basic"

L.General_Party = "Enable Party Frames"
L.General_PartyInRaid = "Display Party Frames in Raid"
L.General_SelfInParty = "Display yourself in Party"
L.General_Arena = "Enable Arena Frames"
L.General_Boss = "Enable Boss Frames"
L.General_Castbars = "Enable Castbars"
L.General_Ticks = "Display Channeling Ticks"
L.General_PTimer = "Show Portrait Timers"
L.General_Feedback = "Show Combat Feedback"
L.General_Threat = "Enable Threat Glow"
L.General_OnlyPlayer = "Only Color Player Debuffs"
L.General_AuraTimer = "Show Aura Timer"
L.General_AuraTimerTip = "Disable the inbuilt Aura Timer"
L.General_Click = "Clickthrough frames"
L.General_ClickTip = "Make the frames click through."
L.General_ModKey = "Focus Modifier Key"
L.General_ModButton = "Focus Mouse Button"
L.General_Absorb = "Enable Absorb Bar"
L.General_AbsorbTip = "Display a bar showing total absorb on a unit."
L.General_ClassP = "Enable Class Portraits"
L.General_ClassPTip = "Display a class icon instead of portrait on players."
L.General_FadeFramesInCombat = "Fade out frames when not in combat"
L.General_FadeFramesInCombatTip = "Hide the unitframes when not in combat, casting or targetting something."

L.General_showComboPoints = "Enable Combo Points"
L.General_showComboPointsTip = "Enable the Combo Points frame"
L.General_showRunes = "Enable Runes"
L.General_showRunesTip = "Enable Death Knight runes"
L.General_showAdditionalPower = "Enable Additional Power Bar"
L.General_showAdditionalPowerTip = "Enable the extra mana bar that some classes have"
L.General_showTotems = "Enable Totems"
L.General_showTotemsTip = "Show the Totems Bar for the class (not valid for all classes)"
L.General_showArcaneStacks = "Enable Arcane Charge"
L.General_showArcaneStacksTip = "Enable Arcane Charge for Arcane Mages"
L.General_showChi = "Enable Chi Points"
L.General_showChiTip = "Enable Chi Points for Windwalker Monks"
L.General_showStagger = "Enable Stagger bar"
L.General_showStaggerTip = "Enable Stagger bar for Brewmaster Monks"
L.General_showHolyPower = "Enable Holy Power"
L.General_showHolyPowerTip = "Enable Holy Power for Retribution Paladins"
L.General_showInsanity = "Enable Insanity Overlay"
L.General_showInsanityTip = "Show the overlay over priests power bar when Insanity is used"
L.General_showShards = "Enable Shards"
L.General_showShardsTip = "Show the Warlock Shards beneath the player frame"
L.General_classAuraBar = "%s Aurabar"
L.General_classAuraBarTip = "Display an aura bar above the player frame for your specialization. \n Set the spell ID of the aura and set a color for the bar"
L.General_powerPredictionBar = "Enable Predicted Cost Bar"
L.General_powerPredictionBarTip = "Display an overlay on the manabar with the predicted cost of a spell"
L.General_builderSpender = "Enable Builder Spender"
L.General_builderSpenderTip = "Overlay the powerbar with feedback displaying gains/losses"
L.General_useAtlas = "Use the special powerbar texture"

---- TEXTURES
L.Texture = "Textures"
L.Texture_Statusbar = "Statusbar Texture"
L.Texture_Frames = "Frames"
L.Texture_Path = "Custom Texture Path"
L.Texture_Border = "Border Texture"

L.Texture_Player = "Player Frame Style"
L.Texture_Normal = "Normal"
L.Texture_NormalTip = "Normal Player Frame"
L.Texture_Rare = "Rare"
L.Texture_RareTip = "Rare Player Frame"
L.Texture_Elite = "Elite"
L.Texture_EliteTip = "Elite Player Frame"
L.Texture_RareElite = "Rare-Elite"
L.Texture_RareEliteTip = "Rare-Elite Player Frame"
L.Texture_Custom = "Custom"
L.Texture_CustomTip = "Custom Player Frame"

-- COLORS:
L.Color_Class = "Class Color"
L.Color_ClassTip = "Use class colors"
L.Color_Gradient = "Gradient color"
L.Color_GradientTip ="Use a gradient from green to red"
L.Color_Custom = "Custom Color"
L.Color_CustomTip = "Use a custom color"
L.Color_Power = "Power Color"
L.Color_PowerTip = "Use power type colors"

L.Color_Frame = "Frame Overlay Color"
L.Color_Latency = "Castbar Latency Color"
L.Color_Backdrop = "Bar Backdrop Color"

L.Color_HealthBar = "Health Bar Color"
L.Color_PowerBar = "Power Bar Color"
L.Color_NameText = "Name Text Color"
L.Color_HealthText = "Health Text Color"
L.Color_PowerText = "Power Text Color"
L.Color_Interruptible = "Interruptible Castbar Color"
L.Color_UnInterruptible = "Uninterruptible Castbar Color"

---- FONTS
L.Font = "Font"
L.Font_Outline = "Outline"
L.Font_ThinOutline = "Thin Outline"
L.Font_ThickOutline = "Thick Outline"
L.Font_OutlineMono = "Outline Monochrome"
L.Font_Number = "Number Font"
L.Font_NumberSize = "Numbar Font Size"
L.Font_NumberOutline = "Number Outline Type"
L.Font_Name = "Name Font"
L.Font_NameSize = "Name Font Size"
L.Font_NameOutline = "Name Outline Type"
L.Font_Bar = "Bar Font"
L.Font_BarSize = "Bar Font Size"
L.Font_BarOutline = "Bar Outline Type"
L.Font_Level = "Level Font"
L.Font_LevelSize = "Level Font Size"
L.Font_LevelOutline = "Level Outline Type"
L.Font_HealthOffset = "Health Y Offset"
L.Font_PowerOffset = "Power Y Offset"

---- POSITIONS
L.Positions = "Positions"
L.Positions_Name = "Unit Frame"
L.Positions_X = "Horizontal [x]"
L.Positions_Y = "Vertical [y]"
L.Positions_Point = "Point"
L.Positions_Toggle = "Toggle Anchors"

---- UNITS
L.Tag_Numeric = "Numeric"
L.Tag_Both = "Both"
L.Tag_Percent = "Percent"
L.Tag_Minimal = "Minimal"
L.Tag_Deficit = "Deficit"
L.Tag_Disable = "Disable"
L.Tag_NumericTip = "Display values as numbers"
L.Tag_BothTip = "Both percentage and numbers"
L.Tag_PercentTip = "Display precentages"
L.Tag_MinimalTip = "Display percentages but hide when max"
L.Tag_DeficitTip = "Display a deficit value"
L.Tag_DisableTip = "Disable text on this frame"

L.Icon_DontShow = "Don't Show"
L.Icon_Left = "Icon on the left"
L.Icon_Right = "Icon on the right"

L.Fat = "Fat"
L.Normal = "Normal"

L.TOP = "Top"
L.BOTTOM = "Bottom"
L.LEFT = "Left"
L.CENTER = "Center"
L.RIGHT = "Right"

L.player = PLAYER
L.target = TARGET
L.targettarget = "Target Target"
L.pet = PET
L.focus = FOCUS
L.focustarget = "Focus Target"
L.party = PARTY
L.boss = BOSS
L.arena = ARENA

L.Scale = "Scale"
L.Style = "Style"
L.EnableAuras = "Enable Auras"
L.EnableAuraTip = "Enable auras for this unit"
L.BuffPos = "Buff Postion"
L.DebuffPos = "Debuff Postion"

L.Castbar = "Castbar"
L.ShowCastbar = "Show Castbar"
L.ShowCastbarTip = "Show Castbar for this unit"
L.Width = "Width"
L.Height = "Height"
L.CastbarIcon = "Castbar Icon"
L.HoriPos = "Horizontal Offset"
L.VertPos = "Vertical Offset"

L.TextHealthTag = "Health Text"
L.TextPowerTag = "Power Text"

L.UnitSpecific = "Unit Specific"