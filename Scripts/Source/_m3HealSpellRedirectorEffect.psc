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
	
	Actor redirTarget
	if hand == -1
		redirTarget = LeftAlias.GetActorReference()
	elseif hand == 1
		redirTarget = RightAlias.GetActorReference()
	endif

	if redirTarget && akTarget.GetDistance(redirTarget) <= 1024 && akTarget.HasLOS(redirTarget)
		ConsoleUtil.PrintMessage("[Allylink] Deliver " + realSpell.GetName() + " to " + redirTarget.GetActorBase().GetName())
		realSpell.RemoteCast(akTarget, akTarget, redirTarget)
	else
		realSpell.RemoteCast(akTarget, akTarget, akTarget)
		Debug.Notification("Linked ally is not in range...")
	endif
endEvent