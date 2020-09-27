local _, ns = ...
if ns.locale ~= "deDE" then return end
local L = ns.L


-- [[ Main Addon ]] --
L.OptionsLoadAfterCombat = "Die Einstellungen werden nach dem Kampf geladen"
L.AuraAdded = "Zauber '%s' (%d) wurde dem Aurafilter hinzugefügt."
L.AuraExists = "Zauber '%s' (%d) existiert bereits"
L.Anchors_Unlocked = "Fenster entsperrt."
L.Anchors_Locked = "Fenster fixiert."
L.Anchors_tooltipline1 = "Halte Shift, um das Fenster zu bewegen"
L.Anchors_tooltipline2 = "Alt-Klick, um die Position zurückzusetzen"
L.Anchors_InCombat = "Die Fenster können im Kampf nicht entsperrt werden."

-- [[ OPTIONS ]] --
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

L.General_Party = "Gruppenfenster aktivieren"
L.General_PartyInRaid = "Gruppenfenster im Schlachtzug anzeigen"
L.General_SelfInParty = "Eigenen Charakter im Gruppenfenster anzeigen"
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
L.General_Absorb = "Absorptionsleiste aktivieren"
L.General_AbsorbTip = "Eine Leiste, die die gesamte Absorption einer Einheit anzeigt, anzeigen."
L.General_ClassP = "Klassenportraits aktivieren"
L.General_ClassPTip = "Ein Klassensymbol anstatt eines Portraits bei Spielern anzeigen."

L.General_showComboPoints = "Combopunkte aktivieren"
L.General_showComboPointsTip = "Aktiviert die Combopunktanzeige"
L.General_showRunes = "Runen aktivieren"
L.General_showRunesTip = "Aktiviert die Todesritter-Runen"
L.General_showAdditionalPower = "Zusätzliche Ressourcenleiste aktivieren"
L.General_showAdditionalPowerTip = "Aktiviert die zusätzliche Manaleiste mancher Klassen"
L.General_showTotems = "Totems aktivieren"
L.General_showTotemsTip = "Aktiviert die Totmes für Schamanen"
L.General_showArcaneStacks = "Arkane Aufladungen aktivieren"
L.General_showArcaneStacksTip = "Aktiviert Arkane Aufladungen für Arkanmagier"
L.General_showChi = "Chipunkte aktivieren"
L.General_showChiTip = "Aktiviert Chipunkte für Windläufer-Mönche"
L.General_showStagger = "Staffeln-Leiste aktivieren"
L.General_showStaggerTip = "Aktiviert Staffeln-Leiste für Braumeister-Mönche"
L.General_showHolyPower = "Heilige Kraft"
L.General_showHolyPowerTip = "Aktiviert Heilige Kraft für Vergeltungspaladine"
L.General_showInsanity = "Wahnsinn-Überblendung anzeigen"
L.General_showInsanityTip = "Zeigt die Überblendung an der Ressoucenleiste der Priester, wenn Wahnsinn aktiv ist"
L.General_showShards = "Splitter aktivieren Shards"
L.General_showShardsTip = "Zeigt die Hexenmeister-Splitter unter dem Spielerfenster"
L.General_classAuraBar = "%s Aurabar"
L.General_classAuraBarTip = "Display an aura bar above the player frame for your specialization. \n Set the spell ID of the aura and set a color for the bar"

---- TEXTURES
L.Texture = "Texturen"
L.Texture_Statusbar = "Statusleistentextur"
L.Texture_Frames = "Fenster"
L.Texture_Path = "Benutzerdefinierter Texturpfad"
L.Texture_Border = "Randtextur"

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
L.Color_GradientTip ="Einen Farbverlauf von grün nach rot verwenden"
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
L.Font_NumberOutline = "Zahlenumrisstyp"
L.Font_Name = "Namensschriftart"
L.Font_NameSize = "Namensschriftgröße"
L.Font_NameOutline = "Namensumrisstyp"
L.Font_Bar = "Balkenschriftart"
L.Font_BarSize = "Balkenschriftgröße"
L.Font_BarOutline = "Balkenschriftumrisstyp"
L.Font_Level = "Stufenschriftart"
L.Font_LevelSize = "Stufenschriftgröße"
L.Font_LevelOutline = "Stufenschriftumrisstyp"
L.Font_HealthOffset = "Lebenspunkte Y Versatz"
L.Font_PowerOffset = "Ressourcenpunkte Y Versatz"

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
L.Tag_BothTip = "Beides – Prozent und Zahlen"
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
L.EnableBuff = "Buffs aktivieren"
L.EnableDebuff = "Debuffs aktivieren"
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
