Scriptname _m3PlayerAliasScript extends ReferenceAlias  

_m3TargetHolderScript Property TargetHolderScript Auto
Keyword Property FakeSpellKeyword Auto
SPELL Property LeftMarkerSpell  Auto 
SPELL Property RightMarkerSpell  Auto  

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if akBaseObject.HasKeyword(FakeSpellKeyword)
		return
	endif

	Utility.Wait(0.1)
	Spell theSpell = akBaseObject as Spell
	if !theSpell
		return
	endif

	if theSpell == LeftMarkerSpell && TargetHolderScript.LeftTarget
		Debug.Notification("[Healer] " + TargetHolderScript.LeftTarget.GetLeveledActorBase().GetName() + " is no longer marked.")
		TargetHolderScript.LeftSpell = none
		TargetHolderScript.LeftTarget = none
		return
	elseif theSpell == RightMarkerSpell
		Debug.Notification("[Healer] " + TargetHolderScript.RightTarget.GetLeveledActorBase().GetName() + " is no longer marked.")
		TargetHolderScript.RightSpell = none
		TargetHolderScript.RightTarget = none
		return
	endif

	Actor myself = self.GetReference() as Actor

	if myself.GetEquippedSpell(0) == theSpell && TargetHolderScript.LeftTarget != none
 		TargetHolderScript.LeftSpell = theSpell
		Spell fakeSpell = HealerScriptExtender.GetFakeSpell(theSpell)
		if fakeSpell
			myself.EquipSpell(fakeSpell, 0)
		endif

	elseif myself.GetEquippedSpell(1) == theSpell && TargetHolderScript.RightTarget != none
 		TargetHolderScript.RightSpell = theSpell
		Spell fakeSpell = HealerScriptExtender.GetFakeSpell(theSpell)
		if fakeSpell
			myself.EquipSpell(fakeSpell, 1)
		endif
	endIf
endEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if !akBaseObject.HasKeyword(FakeSpellKeyword)
		return
	endif

	Spell theSpell = akBaseObject as Spell
	if !theSpell
		return
	endif

	Actor myself = self.GetReference() as Actor

	if myself.GetEquippedSpell(0) != theSpell
 		TargetHolderScript.LeftSpell = none
	elseif myself.GetEquippedSpell(1) != theSpell
 		TargetHolderScript.RightSpell = none
	endIf
endEvent

