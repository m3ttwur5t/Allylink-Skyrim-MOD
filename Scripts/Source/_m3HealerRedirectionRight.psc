Scriptname _m3HealerRedirectionRight extends ActiveMagicEffect  

ReferenceAlias Property RightAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Spell fakeSpell = EmpathicLinkScriptExtender.GetSourceSpell(self)
	if !fakeSpell
		return
	endif
	
	Spell realSpell = EmpathicLinkScriptExtender.GetRealSpell(fakeSpell)
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
