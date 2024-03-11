Scriptname _m3LeftSpellRedirectionEffectScript extends ActiveMagicEffect  

_m3TargetHolderScript Property TargetHolderScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	TargetHolderScript.LeftTarget = akTarget
	Debug.Notification(akTarget.GetLeveledActorBase().GetName() + " designated as LEFT target.")
endEvent