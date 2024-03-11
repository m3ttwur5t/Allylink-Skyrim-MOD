Scriptname _m3PlayerAliasScript extends ReferenceAlias  

Keyword Property FakeSpellKeyword Auto
SPELL Property LeftMarkerSpell  Auto 
SPELL Property RightMarkerSpell  Auto  
ReferenceAlias Property LeftRefAlias  Auto  
ReferenceAlias Property RightRefAlias  Auto  

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if akBaseObject.HasKeyword(FakeSpellKeyword)
		return
	endif

	Utility.Wait(0.1)
	Spell theSpell = akBaseObject as Spell
	if !theSpell
		return
	endif

	Actor leftActor =  LeftRefAlias.GetActorReference()
	Actor rightActor = RightRefAlias.GetActorReference()

	if theSpell == LeftMarkerSpell && leftActor 
		Debug.Notification("[Healer] " + leftActor.GetLeveledActorBase().GetName() + " is no longer marked.")
		LeftRefAlias.Clear()
		return
	elseif theSpell == RightMarkerSpell && rightActor 
		Debug.Notification("[Healer] " + rightActor.GetLeveledActorBase().GetName() + " is no longer marked.")
		RightRefAlias.Clear()
		return
	endif

	Actor myself = self.GetReference() as Actor

	if myself.GetEquippedSpell(0) == theSpell && leftActor != none
		Spell fakeSpell = HealerScriptExtender.GetFakeSpell(theSpell)
		if fakeSpell
			myself.EquipSpell(fakeSpell, 0)
		endif
	elseif myself.GetEquippedSpell(1) == theSpell && rightActor != none
		Spell fakeSpell = HealerScriptExtender.GetFakeSpell(theSpell)
		if fakeSpell
			myself.EquipSpell(fakeSpell, 1)
		endif
	endIf
endEvent


