Scriptname _m3HealSpellRedirectorEffect extends ActiveMagicEffect  

_m3TargetHolderScript Property TargetHolderScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int hand = HealerScriptExtender.WhichHandCastMe(self)
	if hand == 0
		return
	endif

	if hand == -1
		Actor actorRef = TargetHolderScript.LeftTarget
		if !actorRef
			return
		endif
		TargetHolderScript.LeftSpell.Cast(akCaster, actorRef)
	elseif hand == 1
		Actor actorRef = TargetHolderScript.RightTarget
		if !actorRef
			return
		endif
		TargetHolderScript.RightSpell.Cast(akCaster, actorRef)
	endif
endEvent