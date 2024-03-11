Scriptname _m3RightSpellRedirectionEffectScript extends ActiveMagicEffect  

Faction Property CurrentFollowerFaction  Auto  
ReferenceAlias Property RightAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if !akTarget.IsInFaction(CurrentFollowerFaction)
		Debug.Notification(akTarget.GetLeveledActorBase().GetName() + " is not your follower.")
		return
	endif
	RightAlias.ForceRefTo(akTarget)
	Debug.Notification(RightAlias.GetActorReference().GetLeveledActorBase().GetName() + " designated as RIGHT target.")
endEvent