#include-once
#AutoIt3Wrapper_UseX64=n

#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.8.1

	Script Function:
	Setup the settings file if it don't exist, overwise, setup de globals

#ce ----------------------------------------------------------------------------
Global $Skill1[11]
Global $Skill2[11]
Global $Skill3[11]
Global $Skill4[11]
Global $Skill5[11]
Global $Skill6[11]


Global $Skill_conf1[6]
Global $Skill_conf2[6]
Global $Skill_conf3[6]
Global $Skill_conf4[6]
Global $Skill_conf5[6]
Global $Skill_conf6[6]


Global $MonsterTri = True
Global $MonsterRefresh = True
Global $ItemRefresh = True
Global $MonsterPriority = False
Global $Unidentified = False
; recyclage
Global $Recycle = False
Global $QualityRecycle = 9
; fonction pause x games
Global $BreakTime = 360
Global $Breakafterxxgames = Round(Random(4, 8))
Global $TakeABreak = False
;Global $PauseRepas = False

Global $PartieSolo = True

Global $FilterItemGround = False
Global $profilFile = "settings/settings.ini"
Global $a_range = Round(Random(55, 60))
Global $g_range = Round(Random(100, 120))
Global $a_time = 9000
Global $g_time = 7500
Global $List_SpecialMonster = "Goblin|brickhouse_|woodwraith_"
Global $List_Monster = "Beast_B|Goatman_M|Goatman_R|WitherMoth|Beast_A|Scavenger|zombie|Corpulent|Skeleton|QuillDemon|FleshPitFlyer|Succubus|Scorpion|azmodanBodyguard|succubus|ThousandPounder|Fallen|GoatMutant|demonFlyer_B|creepMob|Triune_|TriuneVesselActivated_|TriuneVessel|Triune_Summonable_|ConductorProxyMaster|sandWasp|TriuneCultist|SandShark|Lacuni"
Global $List_BanMonster = "treasureGoblin_A_Slave|Skeleton_Archer_A_Unique_Ring_|Skeleton_A_Unique_Ring_|WD_ZombieDog|WD_wallOfZombies|DH_Companion|"
Global $grabListFile = ""
Global $Potions = "healthPotion_Console"
Global $repairafterxxgames = Round(Random(4, 8))
Global $maxgamelength = 560000
Global $d3pass = ""
Global $PreBuff1 = False
Global $delaiBuff1 = ""
Global $PreBuff2 = False
Global $delaiBuff2 = ""
Global $PreBuff3 = False
Global $delaiBuff3 = ""
Global $PreBuff4 = False
Global $delaiBuff4 = ""
Global $QualityLevel = 9
Global $LifeForPotion = 50
Global $LifeForHealth = 50
Global $takepot = True
Global $PotionStock = 100
Global $KeyCloseWindows = "{SPACE}"
Global $KeyInventory = "i"
Global $KeyPotions = "q"
Global $KeyPortal = "t"
Global $TakeShrines = False


; PauseToSurviveHC
Global $HCSecurity = False
Global $MinHCLife = 0

; BuyPotion
Global $NbPotionBuy = 0

Global $MaximumHatred = 125
Global $MaximumDiscipline = 25
Global $MaximumSpirit = 100
Global $MaximumFury = 100
Global $MaximumArcane = 100
Global $MaximumMana = 100

Global $Devmode = True
Global $UsePath = False
Global $ResActivated = False
Global $ResLife = 0
Global $Res_compt = 0
Global $nb_die_t = 0
Global $rdn_die_t = 0

Global $ftpserver=""
Global $ftpusername=""
Global $ftppass=""
Global $ftpfilename=""

Global $File_Sequence = "sequence\sequence.txt"

Global $Key1 = "&"
Global $Key2 = "�"
Global $Key3 = '"'
Global $Key4 = "'"
Global $MouseMoveClick = "middle"
Global $InventoryCheck = False

global $tab_aff[60][2]=[ _
                                                [-5,-5],[-5,5],[5,-5],[5,5], _
                                                [-10,-10],[-10,10],[10,-10],[10,10], _
                                                [-15,-10],[-15,10],[15,-10],[15,10], _
                                                [-10,-20],[-10,20],[10,-20],[10,20], _
                                                [-20,-10],[-20,10],[20,-10],[20,10], _
                                                [-10,-15],[-10,15],[10,-15],[10,15], _
                                                [-15,-15],[-15,15],[15,-15],[15,15], _
                                                [-20,-20],[-20,20],[20,-20],[20,20], _
                                                [-25,-25],[-25,25],[25,-25],[25,25], _
                                                [-30,-30],[-30,30],[30,-30],[30,30], _
                                                [-40,-40],[-40,40],[40,-40],[40,40], _
                                                [-50,-50],[-50,50],[50,-50],[50,50], _
                                                [-60,-60],[-60,60],[60,-60],[60,60], _
                                                [-70,-70],[-70,70],[70,-70],[70,70], _
                                                [-80,-80],[-80,80],[80,-80],[80,80] _
                                                ]
global $tab_aff2[15][2]=[ _
                                                [5,5], [10,10], [15,10], [10,20], _
                                                [20,10], [10,15], [15,15] , [20,20], _
                                                [25,25], [30,30], [40,40],[50,50], _
                                                [60,60], [70,70], [80,80] _
                                                ]
global $gestion_affixe = False
global $gestion_affixe_loot = False
global $range_arcane=25
global $range_peste=18
global $range_profa=13
global $range_lave=13
global $range_arm=15
global $range_mine=13
global $range_explosion=18
global $range_ice=20
Global $life_arcane=100
Global $life_peste=100
Global $life_profa=100
Global $life_proj=100
Global $life_ice=100
Global $life_poison=100
Global $life_explo=100
Global $life_lave=100
Global $life_mine=100
Global $life_arm=100
Global $life_spore=100
Global $maff_timer=timerinit()
global $timer_ignore_reset=timerinit()
global $energy_mini=0
global $BanAffixList=""
dim $ignore_affix[1][2]
Global $debugBot = False

Global $Gest_affixe_ByClass = False

Func InitSettings($configFile = "settings/settings.ini", $grabListPath = "grablist/")
	loadConfigs($configFile)
	Init_grablistFile($grabListPath)
	Init_GrabListTab()
Endfunc

Func loadConfigs($profilFile = "settings/settings.ini", $creation = 0)

	;; windows informations
	;$winName			= IniRead($profilFile,"windows info","winName","Diablo III")
	;$gamePath			= IniRead($profilFile,"windows info","gameExecFullPath",0)

	;; Account info
	$d3pass = IniRead($profilFile, "Account info", "pass", 0)
	$ftpserver = IniRead($profilFile, "Account info", "ftpserver", $ftpserver)
	$ftpusername = IniRead($profilFile, "Account info", "ftpusername", $ftpusername)
	$ftppass = IniRead($profilFile, "Account info", "ftppass", $ftppass)
	$ftpfilename = IniRead($profilFile, "Account info", "ftpfilename", $ftpfilename)

	;; Key Info
	$KeyCloseWindows = IniRead($profilFile, "Key info", "CloseWindows", $KeyCloseWindows)
	$KeyInventory = IniRead($profilFile, "Key info", "Inventory", $KeyInventory)
	$KeyPotions = IniRead($profilFile, "Key info", "Potions", $KeyPotions)
	$KeyPortal = IniRead($profilFile, "Key info", "Portal", $KeyPortal)
	$Key1 = IniRead($profilFile, "Key info", "Key1", $Key1)
	$Key2 = IniRead($profilFile, "Key info", "Key2", $Key2)
	$Key3 = IniRead($profilFile, "Key info", "Key3", $Key3)
	$Key4 = IniRead($profilFile, "Key info", "Key4", $Key4)
	$MouseMoveClick = IniRead($profilFile, "Key info", "MouseMove", $MouseMoveClick)
	;; Run info

	;; Ajout config run
	$Choix_Act_Run = IniRead($profilFile, "Run info", "Choix_Act_Run", $Choix_Act_Run)

	Switch $Choix_Act_Run
		Case 0
			$Hero_Axe_Z = IniRead($profilFile, "Run info", "Hero_Axe_Z", $Hero_Axe_Z)
			$File_Sequence = IniRead($profilFile, "Run info", "SequenceFile", $File_Sequence)

		Case 1
			$Act1_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act1_Hero_Axe_Z", $Act1_Hero_Axe_Z)
			$SequenceFileAct1 = IniRead($profilFile, "Run info", "SequenceFileAct1", $SequenceFileAct1)

		Case 2
			$Act2_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act2_Hero_Axe_Z", $Act2_Hero_Axe_Z)
			$SequenceFileAct2 = IniRead($profilFile, "Run info", "SequenceFileAct2", $SequenceFileAct2)

		Case 3
			$Act3_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act3_Hero_Axe_Z", $Act3_Hero_Axe_Z)
			$SequenceFileAct3 = IniRead($profilFile, "Run info", "SequenceFileAct3", $SequenceFileAct3)
			$SequenceFileAct3PtSauve = IniRead($profilFile, "Run info", "SequenceFileAct3PtSauve", $SequenceFileAct3PtSauve)

		Case 333 ; Act 3 qu�te 3 sous qu�te 3 --> tuez Ghom
			$Act3_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act3_Hero_Axe_Z", $Act3_Hero_Axe_Z)
			$SequenceFileAct333 = IniRead($profilFile, "Run info", "SequenceFileAct333", $SequenceFileAct333)

		Case 362 ; Act 3 qu�te 6 sous qu�te 2 --> Tuez le briseur de si�ge
			$Act3_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act3_Hero_Axe_Z", $Act3_Hero_Axe_Z)
			$SequenceFileAct362 = IniRead($profilFile, "Run info", "SequenceFileAct362", $SequenceFileAct362)

		Case 373 ; Act 3 qu�te 7 sous qu�te 3 --> Terrasez Asmodam
			$Act3_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act3_Hero_Axe_Z", $Act3_Hero_Axe_Z)
			$SequenceFileAct373 = IniRead($profilFile, "Run info", "SequenceFileAct373", $SequenceFileAct373)

		Case -1
			$SequenceFileAct1 = IniRead($profilFile, "Run info", "SequenceFileAct1", $SequenceFileAct1)
			$SequenceFileAct2 = IniRead($profilFile, "Run info", "SequenceFileAct2", $SequenceFileAct2)
			$SequenceFileAct3 = IniRead($profilFile, "Run info", "SequenceFileAct3", $SequenceFileAct3)
			$SequenceFileAct3PtSauve = IniRead($profilFile, "Run info", "SequenceFileAct3PtSauve", $SequenceFileAct3PtSauve)
			$Act1_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act1_Hero_Axe_Z", $Act1_Hero_Axe_Z)
			$Act2_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act2_Hero_Axe_Z", $Act2_Hero_Axe_Z)
			$Act3_Hero_Axe_Z = IniRead($profilFile, "Run info", "Act3_Hero_Axe_Z", $Act3_Hero_Axe_Z)
			$Dummy = IniRead($profilFile, "Run info", "Sequence_Aleatoire", $Sequence_Aleatoire)
			$Sequence_Aleatoire = Trim(StringLower($Dummy)) == "true"
			$NbreRunChangSeqAlea = IniRead($profilFile, "Run info", "NbreRunChangSeqAlea", $NbreRunChangSeqAlea)
			$Nombre_de_Run = IniRead($profilFile, "Run info", "Nombre_de_Run", $Nombre_de_Run)
			$NombreMiniAct1 = IniRead($profilFile, "Run info", "NombreMiniAct1", $NombreMiniAct1)
			$NombreMiniAct2 = IniRead($profilFile, "Run info", "NombreMiniAct2", $NombreMiniAct2)
			$NombreMiniAct3 = IniRead($profilFile, "Run info", "NombreMiniAct3", $NombreMiniAct3)
			$NombreMaxiAct1 = IniRead($profilFile, "Run info", "NombreMaxiAct1", $NombreMaxiAct1)
			$NombreMaxiAct2 = IniRead($profilFile, "Run info", "NombreMaxiAct2", $NombreMaxiAct2)
			$NombreMaxiAct3 = IniRead($profilFile, "Run info", "NombreMaxiAct3", $NombreMaxiAct3)
	EndSwitch
	;; Fin d'ajout config run

	$List_Monster = IniRead($profilFile, "Run info", "monsterList", $List_Monster)
	$List_SpecialMonster = IniRead($profilFile, "Run info", "SpecialmonsterList", $List_SpecialMonster)

	;Selection de la difficulte et du pm des monstres
	$difficulte = IniRead($profilFile, "Run info", "difficulte", $difficulte)
	$PuisMonstre = IniRead($profilFile, "Run info", "PuisMonstre", $PuisMonstre)

	;Selection du type de graliste pour le mode arma
	$TypeDeGrabList = IniRead($profilFile, "Run info", "TypeDeGrabList", $TypeDeGrabList)

	;Selection de la GrabListe suivant la difficult�
	Switch $difficulte
		Case 1
			$grabListFile = IniRead($profilFile, "Run info", "grablistNormal", $grabListFile)
		Case 2
			$grabListFile = IniRead($profilFile, "Run info", "grablistDifficile", $grabListFile)
		Case 3
			$grabListFile = IniRead($profilFile, "Run info", "grablistExpert", $grabListFile)
		Case 4
			$grabListFile = IniRead($profilFile, "Run info", "grablistCalvaire", $grabListFile)
		Case 5
			Switch $TypeDeGrabList
				Case 1
					$grabListFile = IniRead($profilFile, "Run info", "grabListTourment", $grabListFile)
				Case 2
					$grabListFile = IniRead($profilFile, "Run info", "grabListTourmentXP", $grabListFile)
				Case 3
					$grabListFile = IniRead($profilFile, "Run info", "grabListTourmentRecycle", $grabListFile)
			EndSwitch
	EndSwitch

	$QualityLevel = IniRead($profilFile, "Run info", "QualiteItem", $QualityLevel)
	$Dummy = IniRead($profilFile, "Run info", "Unidentified", $Unidentified)
	$Unidentified = Trim(StringLower($Dummy)) == "true"

	;recyclage
	$Dummy = IniRead($profilFile, "Run info", "Recycle", $Recycle)
	$Recycle = Trim(StringLower($Dummy)) == "true"
	$QualityRecycle = IniRead($profilFile, "Run info", "QualityRecycle", $QualityRecycle)
	$Dummy = IniRead($profilFile, "Run info", "FilterItemGround", $FilterItemGround)
	$FilterItemGround = Trim(StringLower($Dummy)) == "true"
	; fonction pause x games
	$BreakTime = IniRead($profilFile, "Run info", "BreakTime", $BreakTime)
	$Breakafterxxgames = IniRead($profilFile, "Run info", "Breakafterxxgames", $Breakafterxxgames)
	$Dummy = IniRead($profilFile, "Run info", "TakeABreak", $TakeABreak)
	$TakeABreak = Trim(StringLower($Dummy)) == "true"
	;$Dummy = IniRead($profilFile, "Run info", "PauseRepas", $PauseRepas)
	;$PauseRepas = Trim(StringLower($Dummy)) == "true"

	;choix du type de bot
	$TypedeBot = IniRead($profilFile, "Run info", "TypeDeBot", $TypedeBot)
	$Dummy = IniRead($profilFile, "Run info", "PartieSolo", $PartieSolo)
	$PartieSolo = Trim(StringLower($Dummy)) == "true"
	$Dummy = IniRead($profilFile, "Run info", "debug", $debugBot)
	$debugBot = Trim(StringLower($Dummy)) == "true"
	;$Act = IniRead($profilFile,"Run info","Act", $Act)
	$Dummy = IniRead($profilFile, "Run info", "Devmode", $Devmode)
	$Devmode = Trim(StringLower($Dummy)) == "true"

	;Fonction Iniatialisation du Skill suivant le H�ros
	$Heros = IniRead($profilFile, "Run info", "Heros", $Heros)

	InitSkillHeros("settings/settingsHero" & $Heros & ".ini")

	;Chargement des tables
	LoadTableFromString($Table_Coffre, $List_Coffre)
	LoadTableFromString($Table_BanMonster, $List_BanMonster)
	LoadTableFromString($Table_Monster, $List_Monster)
	LoadTableFromString($Table_SpecialMonster, $List_SpecialMonster)
	LoadTableFromString($Table_BanItemStartName, $List_BanItemStartName)

EndFunc   ;==>LoadConfigs

Func InitSkillHeros($skillHeros)
	;$grabListFile = IniRead($profilFile, "Run info", "grabListFile", $grabListFile)

	; pre-buff
	$Dummy = IniRead($skillHeros, "Run info", "SpellPreBuff1", $PreBuff1)
	$PreBuff1 = Trim(StringLower($Dummy)) == "true"
	$delaiBuff1 = IniRead($skillHeros, "Run info", "SpellPreBuffDelay1", $delaiBuff1)

	$Dummy = IniRead($skillHeros, "Run info", "SpellPreBuff2", $PreBuff2)
	$PreBuff2 = Trim(StringLower($Dummy)) == "true"
	$delaiBuff2 = IniRead($skillHeros, "Run info", "SpellPreBuffDelay2", $delaiBuff2)

	$Dummy = IniRead($skillHeros, "Run info", "SpellPreBuff3", $PreBuff3)
	$PreBuff3 = Trim(StringLower($Dummy)) == "true"
	$delaiBuff3 = IniRead($skillHeros, "Run info", "SpellPreBuffDelay3", $delaiBuff3)

	$Dummy = IniRead($skillHeros, "Run info", "SpellPreBuff4", $PreBuff4)
	$PreBuff4 = Trim(StringLower($Dummy)) == "true"
	$delaiBuff4 = IniRead($skillHeros, "Run info", "SpellPreBuffDelay4", $delaiBuff4)


	;; Spells
	$Skill_conf1[0] = IniRead($skillHeros, "Run info", "SpellOnLeft", $Skill_conf1[0])
	$Skill_conf1[1] = IniRead($skillHeros, "Run info", "SpellDelayLeft", $Skill_conf1[1])
	$Skill_conf1[2] = IniRead($skillHeros, "Run info", "SpellTypeLeft", $Skill_conf1[2])
	$Skill_conf1[3] = IniRead($skillHeros, "Run info", "SpellEnergyNeedsLeft", $Skill_conf1[3])
	$Skill_conf1[4] = IniRead($skillHeros, "Run info", "SpellLifeLeft", $Skill_conf1[4])
	$Skill_conf1[5] = IniRead($skillHeros, "Run info", "SpellDistanceLeft", $Skill_conf1[5])


	$Skill_conf2[0] = IniRead($skillHeros, "Run info", "SpellOnRight", $Skill_conf2[0])
	$Skill_conf2[1] = IniRead($skillHeros, "Run info", "SpellDelayRight", $Skill_conf2[1])
	$Skill_conf2[2] = IniRead($skillHeros, "Run info", "SpellTypeRight", $Skill_conf2[2])
	$Skill_conf2[3] = IniRead($skillHeros, "Run info", "SpellEnergyNeedsRight", $Skill_conf2[3])
	$Skill_conf2[4] = IniRead($skillHeros, "Run info", "SpellLifeRight", $Skill_conf2[4])
	$Skill_conf2[5] = IniRead($skillHeros, "Run info", "SpellDistanceRight", $Skill_conf2[5])


	$Skill_conf3[0] = IniRead($skillHeros, "Run info", "SpellOn1", $Skill_conf3[0])
	$Skill_conf3[1] = IniRead($skillHeros, "Run info", "SpellDelay1", $Skill_conf3[1])
	$Skill_conf3[2] = IniRead($skillHeros, "Run info", "SpellType1", $Skill_conf3[2])
	$Skill_conf3[3] = IniRead($skillHeros, "Run info", "SpellEnergyNeeds1", $Skill_conf3[3])
	$Skill_conf3[4] = IniRead($skillHeros, "Run info", "SpellLife1", $Skill_conf3[4])
	$Skill_conf3[5] = IniRead($skillHeros, "Run info", "SpellDistance1", $Skill_conf3[5])


	$Skill_conf4[0] = IniRead($skillHeros, "Run info", "SpellOn2", $Skill_conf4[0])
	$Skill_conf4[1] = IniRead($skillHeros, "Run info", "SpellDelay2", $Skill_conf4[1])
	$Skill_conf4[2] = IniRead($skillHeros, "Run info", "SpellType2", $Skill_conf4[2])
	$Skill_conf4[3] = IniRead($skillHeros, "Run info", "SpellEnergyNeeds2", $Skill_conf4[3])
	$Skill_conf4[4] = IniRead($skillHeros, "Run info", "SpellLife2", $Skill_conf4[4])
	$Skill_conf4[5] = IniRead($skillHeros, "Run info", "SpellDistance2", $Skill_conf4[5])


	$Skill_conf5[0] = IniRead($skillHeros, "Run info", "SpellOn3", $Skill_conf5[0])
	$Skill_conf5[1] = IniRead($skillHeros, "Run info", "SpellDelay3", $Skill_conf5[1])
	$Skill_conf5[2] = IniRead($skillHeros, "Run info", "SpellType3", $Skill_conf5[2])
	$Skill_conf5[3] = IniRead($skillHeros, "Run info", "SpellEnergyNeeds3", $Skill_conf5[3])
	$Skill_conf5[4] = IniRead($skillHeros, "Run info", "SpellLife3", $Skill_conf5[4])
	$Skill_conf5[5] = IniRead($skillHeros, "Run info", "SpellDistance3", $Skill_conf5[5])


	$Skill_conf6[0] = IniRead($skillHeros, "Run info", "SpellOn4", $Skill_conf6[0])
	$Skill_conf6[1] = IniRead($skillHeros, "Run info", "SpellDelay4", $Skill_conf6[1])
	$Skill_conf6[2] = IniRead($skillHeros, "Run info", "SpellType4", $Skill_conf6[2])
	$Skill_conf6[3] = IniRead($skillHeros, "Run info", "SpellEnergyNeeds4", $Skill_conf6[3])
	$Skill_conf6[4] = IniRead($skillHeros, "Run info", "SpellLife4", $Skill_conf6[4])
	$Skill_conf6[5] = IniRead($skillHeros, "Run info", "SpellDistance4", $Skill_conf6[5])


	; Routines
	$LifeForPotion = IniRead($skillHeros, "Run info", "LifeForPotion", $LifeForPotion)
	$PotionStock = IniRead($skillHeros, "Run info", "PotionStock", $PotionStock)
	$LifeForHealth = IniRead($skillHeros, "Run info", "LifeForHealth", $LifeForHealth)

	; BuyPotion
	$NbPotionBuy = IniRead($skillHeros, "Run info", "NbPotionBuy", $NbPotionBuy)

	$TakeShrines = IniRead($skillHeros, "Run info", "TakeShrines", $TakeShrines)

	$repairafterxxgames = IniRead($skillHeros, "Run info", "repairafterxxgames", $repairafterxxgames)

	$maxgamelength = IniRead($skillHeros, "Run info", "maxgamelength", $maxgamelength)
	$a_range = IniRead($skillHeros, "Run info", "attackRange", $a_range)
	$g_range = IniRead($skillHeros, "Run info", "grabRange", $g_range)

	$Dummy = IniRead($skillHeros, "Run info", "MonsterTri", $MonsterTri)
	$MonsterTri = Trim(StringLower($Dummy)) == "true"
	$Dummy = IniRead($skillHeros, "Run info", "MonsterRefresh", $MonsterRefresh)
	$MonsterRefresh = Trim(StringLower($Dummy)) == "true"
	$Dummy = IniRead($skillHeros, "Run info", "ItemRefresh", $ItemRefresh)
	$ItemRefresh = Trim(StringLower($Dummy)) == "true"
	$Dummy = IniRead($skillHeros, "Run info", "MonsterPriority", $MonsterPriority)
	$MonsterPriority = Trim(StringLower($Dummy)) == "true"
	$Dummy = IniRead($skillHeros, "Run info", "InventoryCheck", $InventoryCheck)
	$InventoryCheck = Trim(StringLower($Dummy)) == "true"

	$a_time = IniRead($skillHeros, "Run info", "attacktimeout", $a_time)
	$g_time = IniRead($skillHeros, "Run info", "grabtimeout", $g_time)

	$Dummy = IniRead($skillHeros, "Run info", "gestion_affixe", $gestion_affixe)
	$gestion_affixe = Trim(StringLower($Dummy)) == "true"
	$Dummy = IniRead($skillHeros, "Run info", "gestion_affixe_loot", $gestion_affixe_loot)
	$gestion_affixe_loot = Trim(StringLower($Dummy)) == "true"
	$BanAffixList = IniRead($skillHeros, "Run info", "BanAffixList", $BanAffixList)
	$Dummy = IniRead($skillHeros, "Run info", "Gest_affixe_ByClass", $Gest_affixe_ByClass)		
	$Gest_affixe_ByClass = Trim(StringLower($Dummy)) == "true"
	
	$life_arcane = IniRead($skillHeros, "Run info", "Life_Arcane", $life_arcane)
	$life_peste = IniRead($skillHeros, "Run info", "Life_Peste", $life_peste)
	$life_profa = IniRead($skillHeros, "Run info", "Life_Profa", $life_profa)
	$life_proj = IniRead($skillHeros, "Run info", "Life_Proj", $life_proj)
	$life_ice = IniRead($skillHeros, "Run info", "Life_Ice", $life_ice)
	$life_poison = IniRead($skillHeros, "Run info", "Life_Poison", $life_poison)
	$life_explo = IniRead($skillHeros, "Run info", "Life_Explo", $life_explo)
	$life_lave = IniRead($skillHeros, "Run info", "Life_Lave", $life_lave)
	$life_mine = IniRead($skillHeros, "Run info", "Life_Mine", $life_mine)
	$life_arm = IniRead($skillHeros, "Run info", "Life_Arm", $life_arm)
	$life_spore = IniRead($skillHeros, "Run info", "Life_Spore", $life_spore)

;~ 	$MaximumHatred = IniRead($profilFile, "Run info", "MaximumHatred", $MaximumHatred)
;~ 	$MaximumDiscipline = IniRead($profilFile, "Run info", "MaximumDiscipline", $MaximumDiscipline)
;~ 	$MaximumSpirit = IniRead($profilFile, "Run info", "MaximumSpirit", $MaximumSpirit)
;~ 	$MaximumFury = IniRead($profilFile, "Run info", "MaximumFury", $MaximumFury)
;~ 	$MaximumArcane = IniRead($profilFile, "Run info", "MaximumArcane", $MaximumArcane)
;~ 	$MaximumMana = IniRead($profilFile, "Run info", "MaximumMana", $MaximumMana)

	$Dummy = StringLower(IniRead($skillHeros, "Run info", "UsePath", $UsePath))
	$UsePath = Trim(StringLower($Dummy)) == "true"
	$Dummy = StringLower(IniRead($skillHeros, "Run info", "ResActivated", $ResActivated))
	$ResActivated = Trim(StringLower($Dummy)) == "true"
	$ResLife = IniRead($skillHeros, "Run info", "ResLife", $ResLife)

	;PauseToSurviveHC
	$Dummy = IniRead($skillHeros, "Run info", "HCSecurity", $HCSecurity)
	$HCSecurity = Trim(StringLower($Dummy)) == "true"
	$MinHCLife = IniRead($skillHeros, "Run info", "MinHCLife", $MinHCLife)

	#cs
	If $RightClickSpellEnergy <> "" And $RightClickSpellEnergy <> "discipline" And $RightClickSpellEnergy <> "hatred" And $RightClickSpellEnergy <> "spirit" And $RightClickSpellEnergy <> "arcane" And $RightClickSpellEnergy <> "mana" And $RightClickSpellEnergy <> "fury" Then
		MsgBox(0, "Erreur non de variable", "La variable '$RightClickSpellEnergy' initialis� dans le setting.ini est mal �crite")
		Terminate()
	EndIf
	If $EnergySpell1 <> "" And $EnergySpell1 <> "discipline" And $EnergySpell1 <> "hatred" And $EnergySpell1 <> "spirit" And $EnergySpell1 <> "arcane" And $EnergySpell1 <> "mana" And $EnergySpell1 <> "fury" Then
		MsgBox(0, "Erreur non de variable", "La variable '$EnergySpell1' initialis� dans le setting.ini est mal �crite")
		Terminate()
	EndIf
	If $EnergySpell2 <> "" And $EnergySpell2 <> "discipline" And $EnergySpell2 <> "hatred" And $EnergySpell2 <> "spirit" And $EnergySpell2 <> "arcane" And $EnergySpell2 <> "mana" And $EnergySpell2 <> "fury" Then
		MsgBox(0, "Erreur non de variable", "La variable '$EnergySpell2' initialis� dans le setting.ini est mal �crite")
		Terminate()
	EndIf
	If $EnergySpell3 <> "" And $EnergySpell3 <> "discipline" And $EnergySpell3 <> "hatred" And $EnergySpell3 <> "spirit" And $EnergySpell3 <> "arcane" And $EnergySpell3 <> "mana" And $EnergySpell3 <> "fury" Then
		MsgBox(0, "Erreur non de variable", "La variable '$EnergySpell3' initialis� dans le setting.ini est mal �crite")
		Terminate()
	EndIf
	If $EnergySpell4 <> "" And $EnergySpell4 <> "discipline" And $EnergySpell4 <> "hatred" And $EnergySpell4 <> "spirit" And $EnergySpell4 <> "arcane" And $EnergySpell4 <> "mana" And $EnergySpell4 <> "fury" Then
		MsgBox(0, "Erreur non de variable", "La variable '$EnergySpell4' initialis� dans le setting.ini est mal �crite")
		Terminate()
	EndIf
	#ce
EndFunc   ;==>InitSkillHeros
 
 Func Init_GrabListTab()

	Dim $tab_temp = StringSplit($grablist, "|", 2)

	Local $rules_ilvl = '(?i)\[ilvl:([0-9]{1,2})\]'
	Local $rules_quality = '(?i)\[q:([0-9]{1,2})\]'
	Local $rules_filtre = '(?i)\(([[:ascii:]+]+)\)' ;enleve les "(" de premier niveau

	Local $i = 0, $detect = 0
	Global $GrabListTab[UBound($tab_temp)][5]
	For $y = 0 To UBound($tab_temp) - 1
		$tab_buff = StringLower(trim($tab_temp[$y]))

		If StringRegExp($tab_buff, $rules_ilvl) = 1 Then ;patern declaration ilvl
			$tab_RegExp = StringRegExp($tab_buff, $rules_ilvl, 2)
			$tab_buff = StringReplace($tab_buff, $tab_RegExp[0], "", 0, 2)

			$curr_ilvl = $tab_RegExp[1]
		Else
			$curr_ilvl = 0
		EndIf


		If StringRegExp($tab_buff, $rules_quality) = 1 Then ;patern declaration quality
			$tab_RegExp = StringRegExp($tab_buff, $rules_quality, 2)
			$tab_buff = StringReplace($tab_buff, $tab_RegExp[0], "", 0, 2)
			$curr_quality = $tab_RegExp[1]
		Else
			$curr_quality = 0
		EndIf


		If StringRegExp($tab_buff, $rules_filtre) = 1 Then ;patern declaration filtre
			$tab_RegExp = StringRegExp($tab_buff, $rules_filtre, 2)
			$tab_buff = StringReplace($tab_buff, $tab_RegExp[0], "", 0, 2)
			$tab_RegExp[1] = StringReplace($tab_RegExp[1], "and", " and ", 0, 2)
			$tab_RegExp[1] = StringReplace($tab_RegExp[1], "or", " or ", 0, 2)

			For $x = 0 To UBound($tab_grablist) - 1
				If StringInStr($tab_RegExp[1], $tab_grablist[$x][0], 0) Then
					$tab_RegExp[1] = StringReplace($tab_RegExp[1], $tab_grablist[$x][0], $tab_grablist[$x][1], 0, 2)
				EndIf
			Next

			$curr_filtre = $tab_RegExp[1]
			$curr_filtre_str = give_str_from_filter($tab_RegExp[1])
		Else
			$curr_filtre = 0
			$curr_filtre_str = ""
		EndIf

		For $x = 0 To UBound($tab_grablist) - 1
			If StringInStr($tab_buff, $tab_grablist[$x][0], 0) Then
				$tab = StringSplit($tab_grablist[$x][1], "|", 2)
				For $Z = 0 To UBound($tab) - 1

					If $Z > 0 Then
						ReDim $GrabListTab[UBound($GrabListTab) + 1][5]
					EndIf

					$GrabListTab[$i][0] = $tab[$Z]
					$GrabListTab[$i][1] = $curr_ilvl
					$GrabListTab[$i][2] = $curr_quality
					$GrabListTab[$i][3] = $curr_filtre
					$GrabListTab[$i][4] = $curr_filtre_str

					$i += 1
				Next
				$detect = 1
			EndIf
		Next

		If $detect = 0 Then
			$GrabListTab[$i][0] = $tab_buff
			$GrabListTab[$i][1] = $curr_ilvl
			$GrabListTab[$i][2] = $curr_quality
			$GrabListTab[$i][3] = $curr_filtre
			$GrabListTab[$i][4] = $curr_filtre_str
			$i += 1
		EndIf

		$detect = 0
	Next
EndFunc   ;==>Init_GrabListTab
 
Func Init_grablistFile($grabListPath = "grablist/")
	Dim $txttoarray[1]
	;local $load_file = ""
	Local $compt_line = 0

	Local $file = FileOpen($grabListPath &  $grabListFile, 0)
	If $file = -1 Then
		MsgBox(0, "Error", "Unable to open file : " & $grabListFile)
		Exit
	EndIf

	While 1 ;Boucle de traitement de lecture du fichier txt
		$line = FileReadLine($file)
		If @error = -1 Then ExitLoop

		If $line <> "" Then
			$line = StringLower($line)
			ReDim $txttoarray[$compt_line + 1]
			$txttoarray[$compt_line] = $line
			$compt_line += 1
		EndIf
	WEnd

	FileClose($file)

	Global $tab_grablist[1][2]
	Global $grablist = ""
	Local $compt = 0

	For $i = 0 To UBound($txttoarray) - 1
		If StringInStr($txttoarray[$i], "=", 0) Then
			$var_temp = StringSplit($txttoarray[$i], "=", 2)

			$var_temp[0] = trim($var_temp[0])

			ReDim $tab_grablist[$compt + 1][2]

			$tab_grablist[$compt][0] = $var_temp[0]
			$tab_grablist[$compt][1] = $var_temp[1]

			Assign($var_temp[0], $var_temp[1], 2)
			$compt += 1
		Else

			If $grablist = "" Then
				$grablist = $txttoarray[$i]
			Else
				$grablist = $grablist & "|" & $txttoarray[$i]
			EndIf

		EndIf
	Next

EndFunc   ;==>Init_grablistFile
