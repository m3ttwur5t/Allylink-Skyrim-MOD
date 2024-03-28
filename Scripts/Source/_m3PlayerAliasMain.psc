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

Function ActivateListener()
	GoToState("Running")
EndFunction

Function DeactivateListener()
EndFunction

State Running
	Function ActivateListener()
	EndFunction
	
	Function DeactivateListener()
		GoToState("")
	EndFunction
	
	Event OnBeginState()
		Myself = self.GetActorReference()
		self.GetActorReference().AddPerk(NullifierPerk)
		ConsoleUtil.PrintMessage("Allylink Listener Activated")
	EndEvent
	
	Event OnEndState()
		PreviousLeftFakeSpell = none
		PreviousRightFakeSpell = none
		LeftRefAlias.Clear()
		RightRefAlias.Clear()
		self.GetActorReference().RemovePerk(NullifierPerk)
		ConsoleUtil.PrintMessage("Allylink Listener Stopped")
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

		Actor leftActor  = LeftRefAlias.GetActorReference()
		Actor rightActor = RightRefAlias.GetActorReference()

		if !leftActor && !rightActor
			DeactivateListener()
			return
		endif

		if theSpell == LeftMarkerSpell && leftActor 
			Debug.Notification(leftActor.GetLeveledActorBase().GetName() + " lost Empathic Embrace (Left).")
			LeftRefAlias.Clear()
			return
		elseif theSpell == RightMarkerSpell && rightActor 
			Debug.Notification(rightActor.GetLeveledActorBase().GetName() + " lost Empathic Embrace (Right).")
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
EndState