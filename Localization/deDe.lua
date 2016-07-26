
local _, ns = ...
if ns.locale ~= "deDE" then return; end
local L = ns.L


-- [[ 		Main Addon 		]]  --
	L.OptionsLoadAfterCombat = "Die Einstellungen werden nach dem Kampf geladen"
	L.AuraAdded = "Zauber '%s' (%d) wurde dem Aurafilter hinzugefügt."
	L.AuraExists = "Zauber '%s' (%d) existiert bereits"
	L.Anchors_Unlocked = "Fenster entsperrt."
	L.Anchors_Locked = "Fenster fixiert."
	L.Anchors_tooltipline1 = "Halte Shift, um das Fenster zu bewegen"
	L.Anchors_tooltipline2 = "Alt-Klick, um die Position zurückzusetzen"
	L.Anchors_InCombat = "Die Fenster können im Kampf nicht entsperrt werden."

	--[[		OPTIONS 		]] --
	L.ReloadUIWarning_Desc = "Du hast Änderungen durchgeführt, die ein Neuladen des UIs verlangen, um komplett wirksam zu werden, neu laden?"
	L.NoEffectUntilRL = "Diese Optionen werden erst nach einem Neuladen des UIs wirksam."

	---- PROFILES
	L.EnterProfileName = "Gib den Profilnamen ein"

	---- AURA PANEL
	L.AuraFilters = "Aurafilter"
	
	L.AuraFilterGeneralDesc = "Füge den neuen Auren einen Filter hinzu oder editiere bestehende."
	L.AllFrames = "Alle Fenster"
	
	L.AuraFilterArenaDesc = "Stärkungszauber, auf der weißen Liste, für die Arenafenster."
	L.ArenaFrames = "Arenafenster"
	
	L.AuraFilterBossDesc = "Schwächungszauber, auf der weißen Liste, für die Bossfenster."
	L.BossFrames = "Bossfenster"
	
	L.ShowAll = "Alle anzeigen"
	L.OnlyOwn = "Nur eigene"
	L.HideOnFriendly = "Auf freundlich Gesinnten verstecken"
	L.NeverShow = "Niemals anzeigen"
	
	L.Auras_EnterSpellID = "Gib eine Zauber-ID ein"
	L.Auras_AlreadyAdded = "Bereits hinzugefügt!"
	L.Auras_InvalidSpellID = "Ungültige Zauber-ID!"
	
	---- GENERAL PANEL
	
	L.General = "Allgemein"
	
	L.General_ClassModule = "Standard-Klassenmodule aktivieren"
	L.General_ClassModuleTip = "Blizzard-Module für deine Klasse aktivieren."
	L.General_Party = "Gruppenfenster aktivieren"
	L.General_PartyInRaid = "Gruppenfenster im Schlachtzug anzeigen"
	L.General_Arena = "Arenafenster aktivieren"
	L.General_Boss = "Bossfenster aktivieren"
	L.General_Castbars = "Zauberleisten aktivieren"
	L.General_Ticks = "Kanalisierte Ticks anzeigen"
	L.General_PTimer = "Portraittimer anzeigen"
	L.General_Feedback = "Kampffeedback anzeigen"
	L.General_Threat = "Bedrohungsleuchten aktivieren"
	L.General_OnlyPlayer = "Nur eigene Schwächungszauber färben"
	L.General_AuraTimer = "Auratimer anzeigen"
	L.General_AuraTimerTip = "Den eingebauten Auratimer deaktivieren"
	L.General_Click = "Durchklickbare Fenster"
	L.General_ClickTip = "Macht die Fenster durchklickbar."
	L.General_ModKey = "Fokus-Modifikatortaste"
	L.General_ModButton = "Fokus-Maustaste"
	L.General_Absorb = "Absorbtionsleiste aktivieren"
	L.General_AbsorbTip = "Eine Leiste, die die gesamte Absorbtion einer Einheit anzeigt, anzeigen."
	L.General_ClassP = "Klassenportraits aktivieren"
	L.General_ClassPTip = "Ein Klassensymbol anstatt eines Portraits bei Spielern anzeigen."
	L.General_Resolve = "Entschlossenheit-Leiste aktivieren"
	L.General_ResolveTip = "Eine Entschlossenheit-Leiste für Tanks über dem Spielerfenster anzeigen."
	L.General_Enrage = "Krieger-Wutanfall-Leiste aktivieren"
	L.General_EnrageTip = "Eine Wutanfall-Leiste für Furor-Krieger über dem Spielerfenster anzeigen."
	L.General_WSBar = "Geschwächte-Seele-Leiste aktivieren"
	L.General_WSBarTip = "Eine Leiste für 'Geschwächte Seele' für Priester anzeigen."
	L.General_Arcane = "Magiers 'Arkane Aufladung' aktivieren"
	L.General_ArcaneTip = "Einen Zähler für 'Arkane Aufladungen' anzeigen."
	L.General_SnD = "Zerhäckseln-Leiste aktivieren"
	L.General_SnDTip = "Eine Leiste für 'Zerhäckseln' anzeigen."
	L.General_Ant = "Erwartung-Aufladungen anzeigen"
	L.General_AntTip = "Zusätzliche Combopunkte für Aufladungen von 'Erwartung' anzeigen."
	L.General_Shrooms = "Pilzsymbole anzeigen"
	L.General_ShroomsTip = "Die Texturen um die Symbole, anstatt nur des Texts, anzeigen."

	L.General_showComboPoints = "Enable Combo Points"
	L.General_showComboPointsTip = "Enable the Combo Points frame"
	L.General_showRunes = "Enable Runes"
	L.General_showRunesTip = "Enable Death Knight runes"
	L.General_showAdditionalPower = "Enable Additional Power Bar"
	L.General_showAdditionalPowerTip = "Enable the extra mana bar that some classes have"
	L.General_showTotems = "Enable Totems"
	L.General_showTotemsTip = "Enable Totems for the class (not valid for all classes)"
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
	
	---- TEXTURES,
	L.Texture = "Texturen"
	L.Texture_Statusbar = "Statusleistentextur"
	L.Texture_Frames = "Fenster"
	L.Texture_Path = "Benutzerdefinierter Texturpfad"
--L.Texture_Border = "Border Texture"

	L.Texture_Player = "Spielerfensterstil"
	L.Texture_Normal = "Normal"
	L.Texture_NormalTip = "Normales Spielerfenster"
	L.Texture_Rare = "Rar"
	L.Texture_RareTip = "Rar-Spielerfenster"
	L.Texture_Elite = "Elite"
	L.Texture_EliteTip = "Elite-Spielerfenster"
	L.Texture_RareElite = "Rar-Elite"
	L.Texture_RareEliteTip = "Rar-Elite-Spielerfenster"
	L.Texture_Custom = "Benutzerdefiniert"
	L.Texture_CustomTip = "Benutzerdefiniertes Spielerfenster"

	-- COLORS:
	L.Color_Class = "Klassenfarbe"
	L.Color_ClassTip = "Klassenfarben benutzen"
	L.Color_Gradient = "Farbverlauf"
	L.Color_GradientTip ="Einen Farbverlauf von rot nach grün verwenden"
	L.Color_Custom = "Benutzerdefinierte Farbe"
	L.Color_CustomTip = "Eine benutzerdefinierte Farbe verwenden"
	L.Color_Power = "Ressourcenfarbe"
	L.Color_PowerTip = "Ressourcentypfarben verwenden"
	
	L.Color_Frame = "Fensterbedeckungsfarbe"
	L.Color_Latency = "Zauberleistenlatenzfarbe"
	L.Color_Backdrop = "Leistenhintergrundfarbe"
	
	L.Color_HealthBar = "Gesundheitsleistenfarbe"
	L.Color_PowerBar = "Ressourcenleistenfarbe"
	L.Color_NameText = "Namenstextfarbe"
	L.Color_HealthText = "Gesundheitstextfarbe"
	L.Color_PowerText = "Ressourcentextfarbe"
	
	---- FONTS
	L.Font = "Schriftart"
	L.Font_Outline = "Umriss"
	L.Font_ThinOutline = "Dünner Umriss"
	L.Font_ThickOutline = "Dicker Umriss"
	L.Font_OutlineMono = "Einfarbiger Umriss"
	L.Font_Number = "Zahlenschriftart"
	L.Font_NumberSize = "Zahlenschriftgröße"
	L.Font_NumberOutline = "Zahlennumrisstyp"
	L.Font_Name = "Namensschriftart"
	L.Font_NameSize = "Namensschriftgröße"
	L.Font_NameOutline = "Namensumrisstyp"
	
	---- POSITIONS
	L.Positions = "Positionen"
	L.Positions_Name = "Einheitenfenster"
	L.Positions_X = "Horizontal [x]"
	L.Positions_Y = "Vertikal [y]"
	L.Positions_Point = "Punkt"
	L.Positions_Toggle = "Anker umschalten"

	---- UNITS
	L.Tag_Numeric = "Numerisch"
	L.Tag_Both = "Beides"
	L.Tag_Percent = "Prozent"
	L.Tag_Minimal = "Minimal"
	L.Tag_Deficit = "Defizit"
	L.Tag_Disable = "Deaktivieren"
	L.Tag_NumericTip = "Werte als Zahlen anzeigen"
	L.Tag_BothTip = "Beides - Prozent und Zahlen"
	L.Tag_PercentTip = "Prozente anzeigen"
	L.Tag_MinimalTip = "Prozente anzeigen, aber verstecken, wenn maximal"
	L.Tag_DeficitTip = "Defizitwert anzeigen"
	L.Tag_DisableTip = "Text dieses Fensters deaktivieren"
	
	L.Icon_DontShow = "Nicht anzeigen"
	L.Icon_Left = "Symbol auf der linken Seite"
	L.Icon_Right = "Symbol auf der rechten Seite"

	L.Fat = "Fett"
	L.Normal = "Normal"
	
	L.TOP = "Oben"
	L.BOTTOM = "Unten"
	L.LEFT = "Links"
	L.CENTER = "Mitte"
	L.RIGHT = "Rechts"
	
	L.player = PLAYER
	L.target = TARGET
	L.targettarget = "Ziel des Ziels"
	L.pet = PET
	L.focus = "Fokusziel"
	L.focustarget = "Ziel des Fokusziels"
	L.party = PARTY
	L.boss = BOSS
	L.arena = ARENA
	
	L.Scale = "Skalierung"
	L.Style = "Stil"
	L.EnableAuras = "Auren aktivieren"
	L.EnableAuraTip = "Auren für diese Einheit aktivieren"
	L.BuffPos = "Stärkungszauberpostion"
	L.DebuffPos = "Schwächungszauberpostion"
	
	L.Castbar = "Zauberleiste"
	L.ShowCastbar = "Zauberleiste anzeigen"
	L.ShowCastbarTip = "Zauberleiste für diese Einheit anzeigen"
	L.Width = "Breite"
	L.Height = "Höhe"
	L.CastbarIcon = "Zauberleistensymbol"
	L.HoriPos = "Horizontale Verschiebung"
	L.VertPos = "Vertikale Verschiebung"
	
	L.TextHealthTag = "Gesundheitstext"
	L.TextPowerTag = "Ressourcentext"
	
	L.UnitSpecific = "Einheitenspezifisch"
