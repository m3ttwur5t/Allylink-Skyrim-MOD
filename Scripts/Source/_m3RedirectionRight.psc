Scriptname _m3RedirectionRight extends ActiveMagicEffect  

ReferenceAlias Property RightAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Spell fakeSpell = AllylinkScriptExtender.WhichSpellCastMe(self)
	if !fakeSpell
		return
	endif
	
	Spell realSpell = AllylinkScriptExtender.GetRealSpell(fakeSpell)
	if !realSpell
		return
	endif
	
	Actor redirTarget = RightAlias.GetActorReference()

	if redirTarget && akTarget.GetDistance(redirTarget) <= 1024 && akTarget.HasLOS(redirTarget)
		;ConsoleUtil.PrintMessage("[Allylink] Deliver " + realSpell.GetName() + " to " + redirTarget.GetActorBase().GetName())
		realSpell.RemoteCast(akTarget, akTarget, redirTarget)
	else
		Debug.Notification(redirTarget.GetLeveledActorBase().GetName() + " is out of range/view.")
	endif
endEvent
