Scriptname _m3HealSpellRedirectorEffect extends ActiveMagicEffect  

ReferenceAlias Property LeftAlias Auto
ReferenceAlias Property RightAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int hand = AllylinkScriptExtender.WhichHandCastMe(self)
	if hand == 0
		return
	endif

	Spell realSpell = none
	Actor actorRef
	if hand == -1 &&  LeftAlias.GetActorReference()
		realSpell = AllylinkScriptExtender.GetRealSpell(akCaster.GetEquippedSpell(0))
		actorRef =  LeftAlias.GetActorReference()
	elseif hand == 1 && RightAlias.GetActorReference()
		realSpell = AllylinkScriptExtender.GetRealSpell(akCaster.GetEquippedSpell(1))
		actorRef =  RightAlias.GetActorReference()
	endif
	
	
	ConsoleUtil.PrintMessage("[Allylink] Deliver " + realSpell.GetName() + " to " + actorRef.GetActorBase().GetName())

	if actorRef && realSpell && akCaster.GetDistance(actorRef) <= 1024
		;realSpell.Cast(actorRef)
		realSpell.RemoteCast(akCaster, akCaster, actorRef)
	else
		Debug.Notification("Linked ally is not in range...")
	endif
endEvent