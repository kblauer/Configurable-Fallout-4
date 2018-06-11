Scriptname CFO_ConfigurableFalloutQuestAlias extends ReferenceAlias

Actor Property PlayerRef auto

GlobalVariable Property CA_CoolDownDays_Short auto
GlobalVariable Property CA_CoolDownDays_Medium auto
GlobalVariable Property CA_CoolDownDays_Long auto
GlobalVariable Property CA_DialogueBump_Dislike auto
GlobalVariable Property CA_DialogueBump_Hate auto
GlobalVariable Property CA_Event_Dislikes auto
GlobalVariable Property CA_Event_Hates auto

GlobalVariable Property CFO_AffinityCooldownMult auto
GlobalVariable Property CFO_FallDamageMult auto
GlobalVariable Property CFO_HackingMaxWords auto
GlobalVariable Property CFO_HackingMinWords auto
GlobalVariable Property CFO_HackingTerminalSpeed auto
GlobalVariable Property CFO_IncomingDamageMult auto
GlobalVariable Property CFO_LockpickSweetBase auto
GlobalVariable Property CFO_LockpickSweetMult auto
GlobalVariable Property CFO_NegativeAffinityMult auto
GlobalVariable Property CFO_OutgoingDamageMult auto
GlobalVariable Property CFO_WorkshopWireMaxLength auto

Event OnPlayerLoadGame()
	debug.trace("[CFO_ConfigurableFalloutQuestAlias] OnPlayerLoadGame event called - loading configurable fallout values")
	; First get bools from quest script to see if options have been changed
	CFO_ConfigurableFalloutQuestScript cfoQuest
	cfoQuest = GetOwningQuest() as CFO_ConfigurableFalloutQuestScript
	
	if (cfoQuest.wireMaxChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestAlias] Workshop wire length changed to - " + CFO_WorkshopWireMaxLength.GetValue())
		Game.SetGameSettingFloat("fWorkshopWireMaxLength", CFO_WorkshopWireMaxLength.GetValue())
	endif
	
	;if (cfoQuest.affinityCoolChanged)
		;debug.trace("[CFO_ConfigurableFalloutQuestAlias] Affinity cooldown changed to - " + CFO_AffinityCooldownMult.GetValue())
		;float newCooldownMult = CFO_AffinityCooldownMult.GetValue()
		; Use hardcoded default values to avoid saving the previously selected or original value
		;float ca_cooldown_short = 0.05 * newCooldownMult
		;float ca_cooldown_med = 2.00 * newCooldownMult
		;float ca_cooldown_long = 5.00 * newCooldownMult
		;CA_CoolDownDays_Short.SetValue(ca_cooldown_short)
		;CA_CoolDownDays_Medium.SetValue(ca_cooldown_med)
		;CA_CoolDownDays_Long.SetValue(ca_cooldown_long)
	;endif
	
	;if (cfoQuest.affinityNegEventChanged)
		;debug.trace("[CFO_ConfigurableFalloutQuestAlias] Negative affinity changed to - " + CFO_NegativeAffinityMult.GetValue())
		;float newAffinityMult = CFO_NegativeAffinityMult.GetValue()
		;float ca_dbump_dislike = -1.00 * newAffinityMult
		;float ca_dbump_hate = -2.00 * newAffinityMult
		;float ca_ev_dislike = -15.00 * newAffinityMult
		;float ca_ev_hate = -35.00 * newAffinityMult
		;CA_DialogueBump_Dislike.SetValue(ca_dbump_dislike)
		;CA_DialogueBump_Hate.SetValue(ca_dbump_hate)
		;CA_Event_Dislikes.SetValue(ca_ev_dislike)
		;CA_Event_Hates.SetValue(ca_ev_hate)
	;endif
	
	if (cfoQuest.fallDamageChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestAlias] Fall damage mult changed to - " + CFO_FallDamageMult.GetValue())
		float newFallDmgMult = CFO_FallDamageMult.GetValue()
		float fallHeightExponent = 1.45 * newFallDmgMult
		float fallLegDmgMult = 0.5 * newFallDmgMult
		Game.SetGameSettingFloat("fJumpFallHeightExponent", fallHeightExponent)
		Game.SetGameSettingFloat("fFallLegDamageMult", fallLegDmgMult)
	endif
	
	if (cfoQuest.hackingMinChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Hacking min words changed to - " + CFO_HackingMinWords.GetValue())
		int newHackingMinWords = CFO_HackingMinWords.GetValue() as int
		Game.SetGameSettingInt("iHackingMinWords", newHackingMinWords)
	endif
	
	if (cfoQuest.hackingMaxChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Hacking max words changed to - " + CFO_HackingMaxWords.GetValue())
		int newHackingMaxWords = CFO_HackingMaxWords.GetValue() as int
		Game.SetGameSettingInt("iHackingMaxWords", newHackingMaxWords)
	endif
	
	if (cfoQuest.hackingTermSpeedChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Terminal speed changed to - " + CFO_HackingTerminalSpeed.GetValue())
		int newTerminalSpeed = CFO_HackingTerminalSpeed.GetValue() as int
		Game.SetGameSettingInt("iTerminalDisplayRate", newTerminalSpeed)
	endif
	
	if (cfoQuest.pickSweetChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Lockpicking base sweet changed to - " + CFO_LockpickSweetBase.GetValue())
		float newLockpickSweetBase = CFO_LockpickSweetBase.GetValue()
		Game.SetGameSettingFloat("fLockpickSkillSweetSpotBase", newLockpickSweetBase)
	endif
	
	if (cfoQuest.pickSweetMultChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Lockpicking sweet mult changed to - " + CFO_LockpickSweetMult.GetValue())
		float newLockpickSweetMult = CFO_LockpickSweetMult.GetValue()
		Game.SetGameSettingFloat("fLockpickSkillSweetSpotMult", newLockpickSweetMult)
	endif
	
	if (cfoQuest.playerOutDmgChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player outgoing damage changed to - " + CFO_OutgoingDamageMult.GetValue())
		float newDamageMult = CFO_OutgoingDamageMult.GetValue()
		Game.SetGameSettingFloat("fDiffMultHPByPCVE", 2.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCE", 1.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCN", 1.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCH", 0.75 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCVH", 0.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCTSV", 0.5 * newDamageMult)
	endif
	
	if (cfoQuest.playerIncDmgChanged)
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player incoming damage changed to - " + CFO_IncomingDamageMult.GetValue())
		float newDamageMult = CFO_IncomingDamageMult.GetValue()
		Game.SetGameSettingFloat("fDiffMultHPToPCVE", 0.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCE", 0.75 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCN", 1.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCH", 1.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCVH", 2.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCTSV", 2.0 * newDamageMult)
	endif
EndEvent
