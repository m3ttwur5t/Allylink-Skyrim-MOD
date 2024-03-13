Scriptname _m3HealSpellRedirectorEffect extends ActiveMagicEffect  

ReferenceAlias Property LeftAlias Auto
ReferenceAlias Property RightAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int hand = AllylinkScriptExtender.WhichHandCastMe(self)
	if hand == 0
		return
	endif

	Spell fakeSpell = AllylinkScriptExtender.WhichSpellCastMe(self)
	if !fakeSpell
		return
	endif
	
	Spell realSpell = AllylinkScriptExtender.GetRealSpell(fakeSpell)
	if !realSpell
		return
	endif
	
	Actor actorRef
	if hand == -1 &&  LeftAlias.GetActorReference()
		actorRef =  LeftAlias.GetActorReference()
	elseif hand == 1 && RightAlias.GetActorReference()
		actorRef =  RightAlias.GetActorReference()
	endif
	if !actorRef
		return
	endif
	
	ConsoleUtil.PrintMessage("[Allylink] Deliver " + realSpell.GetName() + " to " + actorRef.GetActorBase().GetName())

	if akTarget.GetDistance(actorRef) <= 1024
		realSpell.RemoteCast(akTarget, akTarget, actorRef)
	else
		Debug.Notification("Linked ally is not in range...")
	endif
endEvent