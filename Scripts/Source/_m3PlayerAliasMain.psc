Scriptname _m3PlayerAliasMain extends ReferenceAlias  

Keyword Property FakeSpellKeywordFF Auto

SPELL Property LeftMarkerSpell  Auto 
SPELL Property RightMarkerSpell  Auto  
ReferenceAlias Property LeftRefAlias  Auto  
ReferenceAlias Property RightRefAlias  Auto  
Perk Property NullifierPerk  Auto  

Spell PreviousLeftFakeSpell
Spell PreviousRightFakeSpell
Actor Myself

Event OnInit()
	Myself = self.GetActorReference()
	self.GetActorReference().AddPerk(NullifierPerk)
EndEvent
Event OnPlayerLoadGame()
	Myself = self.GetActorReference()
EndEvent

Event OnUpdate()
	if Myself.GetEquippedSpell(0) == none
		PreviousLeftFakeSpell = none
	endif
	if Myself.GetEquippedSpell(1) == none
		PreviousRightFakeSpell = none
	endif
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	RegisterForSingleUpdate(0.1)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	Spell theSpell = akBaseObject as Spell
	if !theSpell
		RegisterForSingleUpdate(0.1)
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

	if leftActor != none && theSpell == Myself.GetEquippedSpell(0)
		Spell fakeSpell = AllylinkScriptExtender.GetFakeSpell(theSpell, -1)
		if fakeSpell != PreviousLeftFakeSpell
			PreviousLeftFakeSpell = fakeSpell
			Myself.EquipSpell(fakeSpell, 0)
		else
			PreviousLeftFakeSpell = none
		endif
	elseif rightActor != none && theSpell == Myself.GetEquippedSpell(1)
		Spell fakeSpell = AllylinkScriptExtender.GetFakeSpell(theSpell, 1)
		if fakeSpell != PreviousRightFakeSpell
			PreviousRightFakeSpell = fakeSpell
			Myself.EquipSpell(fakeSpell, 1)
		else
			PreviousRightFakeSpell = none
		endif
	endIf
endEvent

