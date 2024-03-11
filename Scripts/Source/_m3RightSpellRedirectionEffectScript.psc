Scriptname _m3RightSpellRedirectionEffectScript extends ActiveMagicEffect  

_m3TargetHolderScript Property TargetHolderScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	TargetHolderScript.RightTarget = akTarget
	Debug.Notification(akTarget.GetLeveledActorBase().GetName() + " designated as RIGHT target.")
endEvent