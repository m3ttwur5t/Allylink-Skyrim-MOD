Scriptname _m3PlayerAliasScript extends ReferenceAlias  

Keyword Property FakeSpellKeywordFF Auto

SPELL Property LeftMarkerSpell  Auto 
SPELL Property RightMarkerSpell  Auto  
ReferenceAlias Property LeftRefAlias  Auto  
ReferenceAlias Property RightRefAlias  Auto  
Perk Property NullifierPerk  Auto  

Event OnInit()
	self.GetActorReference().AddPerk(NullifierPerk)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	Spell theSpell = akBaseObject as Spell
	if !theSpell
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

	Actor myself = self.GetReference() as Actor
	
	if myself.GetEquippedSpell(0) == theSpell && leftActor != none
		Spell fakeSpell = AllylinkScriptExtender.GetFakeSpell(theSpell)
		if fakeSpell
			myself.EquipSpell(fakeSpell, 0)
		endif
	elseif myself.GetEquippedSpell(1) == theSpell && rightActor != none
		Spell fakeSpell = AllylinkScriptExtender.GetFakeSpell(theSpell)
		if fakeSpell
			myself.EquipSpell(fakeSpell, 1)
		endif
	endIf
endEvent

