Scriptname _m3PlayerAliasMain extends ReferenceAlias  

Keyword Property FakeSpellKeywordFF Auto

SPELL Property LeftMarkerSpell  Auto 
SPELL Property RightMarkerSpell  Auto  
ReferenceAlias Property LeftRefAlias  Auto  
ReferenceAlias Property RightRefAlias  Auto  
Perk Property NullifierPerk  Auto  

Spell PreviousLeftFakeSpell
Spell PreviousRightFakeSpell

Event OnInit()
	self.GetActorReference().AddPerk(NullifierPerk)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	Spell theSpell = akBaseObject as Spell
	if !theSpell
		if akBaseObject == myself.GetEquippedObject(0)
			PreviousLeftFakeSpell = none
		elseif akBaseObject == myself.GetEquippedObject(1)
			PreviousRightFakeSpell = none
		endif
		return
	endif

	if akBaseObject.HasKeyword(FakeSpellKeywordFF)
		return
	endif

	Actor leftActor =  LeftRefAlias.GetActorReference()
	Actor rightActor = RightRefAlias.GetActorReference()

	if theSpell == LeftMarkerSpell && leftActor 
		Debug.Notification("[AllyLink-Left] " + leftActor.GetLeveledActorBase().GetName() + " is no longer linked.")
		LeftRefAlias.Clear()
		return
	elseif theSpell == RightMarkerSpell && rightActor 
		Debug.Notification("[AllyLink-Right] " + rightActor.GetLeveledActorBase().GetName() + " is no longer linked.")
		RightRefAlias.Clear()
		return
	endif

	Actor myself = self.GetActorReference()
	
	if leftActor != none && theSpell == myself.GetEquippedSpell(0)
		Spell fakeSpell = AllylinkScriptExtender.GetFakeSpell(theSpell, -1)
		if fakeSpell != PreviousLeftFakeSpell
			PreviousLeftFakeSpell = fakeSpell
			myself.EquipSpell(fakeSpell, 0)
		else
			PreviousLeftFakeSpell = none
		endif
	elseif rightActor != none && theSpell == myself.GetEquippedSpell(1)
		Spell fakeSpell = AllylinkScriptExtender.GetFakeSpell(theSpell, 1)
		if fakeSpell != PreviousRightFakeSpell
			PreviousRightFakeSpell = fakeSpell
			myself.EquipSpell(fakeSpell, 1)
		else
			PreviousRightFakeSpell = none
		endif
	endIf
endEvent

