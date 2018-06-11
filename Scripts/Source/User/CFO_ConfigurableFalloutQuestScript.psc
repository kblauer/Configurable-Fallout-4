Scriptname CFO_ConfigurableFalloutQuestScript extends Quest

Actor Property PlayerRef auto

ActorValue Property Health auto
ActorValue Property CarryWeight auto
ActorValue Property ActionPoints auto
ActorValue Property SpeedMult auto

GlobalVariable Property CA_CoolDownDays_Short auto
GlobalVariable Property CA_CoolDownDays_Medium auto
GlobalVariable Property CA_CoolDownDays_Long auto
GlobalVariable Property CA_DialogueBump_Dislike auto
GlobalVariable Property CA_DialogueBump_Hate auto
GlobalVariable Property CA_Event_Dislikes auto
GlobalVariable Property CA_Event_Hates auto

GlobalVariable Property CFO_BasePlayerSpeed auto
GlobalVariable Property CFO_AffinityCooldownMult auto
GlobalVariable Property CFO_BaseActionPoints auto
GlobalVariable Property CFO_BaseCarryWeight auto
GlobalVariable Property CFO_BasePlayerHealth auto
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
GlobalVariable Property CFO_XPBaseBump auto
GlobalVariable Property CFO_XPBaseToLevel auto
GlobalVariable Property CFO_XPDiffMultE auto
GlobalVariable Property CFO_XPDiffMultH auto
GlobalVariable Property CFO_XPDiffMultN auto
GlobalVariable Property CFO_XPDiffMultTSV auto
GlobalVariable Property CFO_XPDiffMultVE auto
GlobalVariable Property CFO_XPDiffMultVH auto
GlobalVariable Property CFO_XPRewardKillOpponent auto
GlobalVariable Property CFO_XPRewardMapMarker auto
GlobalVariable Property CFO_XPRewardPickAverage auto
GlobalVariable Property CFO_XPRewardPickEasy auto
GlobalVariable Property CFO_XPRewardPickHard auto
GlobalVariable Property CFO_XPRewardPickVeryHard auto
GlobalVariable Property CFO_XPRewardTerminal auto
GlobalVariable Property CFO_XPDeathRewardThreshold auto

; Previous value properties 
float Property prev_CFO_BasePlayerHealth = 0.0 auto
float Property prev_CFO_BaseCarryWeight = 0.0 auto
float Property prev_CFO_BaseActionPoints = 0.0 auto

; Value changed boolean properties
bool Property wireMaxChanged = False auto
bool Property affinityCoolChanged = False auto
bool Property affinityNegEventChanged = False auto
bool Property fallDamageChanged = False auto
bool Property hackingMinChanged = False auto
bool Property hackingMaxChanged = False auto
bool Property hackingTermSpeedChanged = False auto
bool Property pickSweetChanged = False auto
bool Property pickSweetMultChanged = False auto
bool Property playerIncDmgChanged = False auto
bool Property playerOutDmgChanged = False auto

Event OnInit()
	debug.trace("[CFO_ConfigurableFalloutQuestScript] OnInit event called")
	RegisterForExternalEvent("OnMCMSettingChange|ConfigurableFallout", "OnMCMSettingChange")
EndEvent

Function OnMCMSettingChange(string modName, string id)
	debug.trace("[CFO_ConfigurableFalloutQuestScript] OnMCMSettingChange event called for id - " + id)
	; Change the corresponding game setting based on the user selection
	
	; Workshop Wire Max Length
	if (id == "fCFOWorkWireLengthEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Workshop wire length changed to - " + CFO_WorkshopWireMaxLength.GetValue())
		Game.SetGameSettingFloat("fWorkshopWireMaxLength", CFO_WorkshopWireMaxLength.GetValue())
		wireMaxChanged = true
	; Follower Affinity Cooldown Length
	elseif (id == "fCFOAffinityCooldownEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Affinity cooldown changed to - " + CFO_AffinityCooldownMult.GetValue())
		float newCooldownMult = CFO_AffinityCooldownMult.GetValue()
		; Use hardcoded default values to avoid saving the previously selected or original value
		float ca_cooldown_short = 0.05 * newCooldownMult
		float ca_cooldown_med = 2.00 * newCooldownMult
		float ca_cooldown_long = 5.00 * newCooldownMult
		CA_CoolDownDays_Short.SetValue(ca_cooldown_short)
		CA_CoolDownDays_Medium.SetValue(ca_cooldown_med)
		CA_CoolDownDays_Long.SetValue(ca_cooldown_long)
		affinityCoolChanged = true
	; Follower Negative Affinity Event Strength
	elseif (id == "fCFONegativeAffinityEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Negative affinity changed to - " + CFO_NegativeAffinityMult.GetValue())
		float newAffinityMult = CFO_NegativeAffinityMult.GetValue()
		float ca_dbump_dislike = -1.00 * newAffinityMult
		float ca_dbump_hate = -2.00 * newAffinityMult
		float ca_ev_dislike = -15.00 * newAffinityMult
		float ca_ev_hate = -35.00 * newAffinityMult
		CA_DialogueBump_Dislike.SetValue(ca_dbump_dislike)
		CA_DialogueBump_Hate.SetValue(ca_dbump_hate)
		CA_Event_Dislikes.SetValue(ca_ev_dislike)
		CA_Event_Hates.SetValue(ca_ev_hate)
		affinityNegEventChanged = true
	; Fall Damage Multiplier
	elseif (id == "fCFOFallDamageEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Fall damage mult changed to - " + CFO_FallDamageMult.GetValue())
		float newFallDmgMult = CFO_FallDamageMult.GetValue()
		float fallHeightExponent = 1.45 * newFallDmgMult
		float fallLegDmgMult = 0.5 * newFallDmgMult
		Game.SetGameSettingFloat("fJumpFallHeightExponent", fallHeightExponent)
		Game.SetGameSettingFloat("fFallLegDamageMult", fallLegDmgMult)
		fallDamageChanged = true
	; Minimum Words Shown While Hacking
	elseif (id == "fCFOHackingMinEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Hacking min words changed to - " + CFO_HackingMinWords.GetValue())
		int newHackingMinWords = CFO_HackingMinWords.GetValue() as int
		Game.SetGameSettingInt("iHackingMinWords", newHackingMinWords)
		hackingMinChanged = true
	; Maximum Words Shown While Hacking
	elseif (id == "fCFOHackingMaxEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Hacking max words changed to - " + CFO_HackingMaxWords.GetValue())
		int newHackingMaxWords = CFO_HackingMaxWords.GetValue() as int
		Game.SetGameSettingInt("iHackingMaxWords", newHackingMaxWords)
		hackingMaxChanged = true
	; Terminal Display Speed	
	elseif (id == "fCFOTerminalSpeedEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Terminal speed changed to - " + CFO_HackingTerminalSpeed.GetValue())
		int newTerminalSpeed = CFO_HackingTerminalSpeed.GetValue() as int
		Game.SetGameSettingInt("iTerminalDisplayRate", newTerminalSpeed)
		hackingTermSpeedChanged = true
	; Lockpicking Base Sweeet Spot Size
	elseif (id == "fCFOLockpickBaseSweetEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Lockpicking base sweet changed to - " + CFO_LockpickSweetBase.GetValue())
		float newLockpickSweetBase = CFO_LockpickSweetBase.GetValue()
		Game.SetGameSettingFloat("fLockpickSkillSweetSpotBase", newLockpickSweetBase)
		pickSweetChanged = true
	; Lockpicking Sweeet Mult Spot Size
	elseif (id == "fCFOLockpickSweetMultEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Lockpicking sweet mult changed to - " + CFO_LockpickSweetMult.GetValue())
		float newLockpickSweetMult = CFO_LockpickSweetMult.GetValue()
		Game.SetGameSettingFloat("fLockpickSkillSweetSpotMult", newLockpickSweetMult)
		pickSweetMultChanged = true
	; Change Player Health
	elseif (id == "fCFOPlayerHealthEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player health changed to - " + CFO_BasePlayerHealth.GetValue())
		float newBaseHealth = PlayerRef.GetValue(Health) / PlayerRef.GetValuePercentage(Health)
		; First remove old value, then add new
		newBaseHealth = (newBaseHealth - prev_CFO_BasePlayerHealth) + CFO_BasePlayerHealth.GetValue()
		PlayerRef.SetValue(Health, newBaseHealth)
		prev_CFO_BasePlayerHealth = CFO_BasePlayerHealth.GetValue()
	; Change Player Carry Weight
	elseif (id == "fCFOCarryWeightEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player carry weight changed to - " + CFO_BaseCarryWeight.GetValue())
		float newBaseCW = PlayerRef.GetValue(CarryWeight)
		; First remove old value, then add new
		newBaseCW = (newBaseCW - prev_CFO_BaseCarryWeight) + CFO_BaseCarryWeight.GetValue()
		PlayerRef.SetValue(CarryWeight, newBaseCW)
		prev_CFO_BaseCarryWeight = CFO_BaseCarryWeight.GetValue()
	; Change Player Action Points
	elseif (id == "fCFOActionPointsEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player action points changed to - " + CFO_BaseActionPoints.GetValue())
		float newBaseAP = PlayerRef.GetValue(ActionPoints) / PlayerRef.GetValuePercentage(ActionPoints)
		; First remove old value, then add new
		newBaseAP = (newBaseAP - prev_CFO_BaseActionPoints) + CFO_BaseActionPoints.GetValue()
		PlayerRef.SetValue(CarryWeight, newBaseAP)
		prev_CFO_BaseCarryWeight = CFO_BaseActionPoints.GetValue()
	; Outgoing Player Damage Multiplier
	elseif (id == "fCFOPlayerDamageMultEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player outgoing damage changed to - " + CFO_OutgoingDamageMult.GetValue())
		float newDamageMult = CFO_OutgoingDamageMult.GetValue()
		Game.SetGameSettingFloat("fDiffMultHPByPCVE", 2.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCE", 1.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCN", 1.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCH", 0.75 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCVH", 0.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPByPCTSV", 0.5 * newDamageMult)
		playerOutDmgChanged = true
	; Incoming Player Damage Multiplier
	elseif (id == "fCFOIncDamageMultEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player incoming damage changed to - " + CFO_IncomingDamageMult.GetValue())
		float newDamageMult = CFO_IncomingDamageMult.GetValue()
		Game.SetGameSettingFloat("fDiffMultHPToPCVE", 0.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCE", 0.75 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCN", 1.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCH", 1.5 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCVH", 2.0 * newDamageMult)
		Game.SetGameSettingFloat("fDiffMultHPToPCTSV", 2.0 * newDamageMult)
		playerIncDmgChanged = true
	; Change Player Speed
	elseif (id == "fCFOPlayerSpeedEvent:Events")
		debug.trace("[CFO_ConfigurableFalloutQuestScript] Player speed changed to - " + CFO_BasePlayerSpeed.GetValue())
		PlayerRef.SetValue(SpeedMult, CFO_BasePlayerSpeed.GetValue())
	endif
EndFunction
