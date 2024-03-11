Scriptname _m3LeftSpellRedirectionEffectScript extends ActiveMagicEffect  

Faction Property CurrentFollowerFaction  Auto  
ReferenceAlias Property LeftAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if !akTarget.IsInFaction(CurrentFollowerFaction)
		Debug.Notification(akTarget.GetLeveledActorBase().GetName() + " is not your follower.")
		return
	endif
	LeftAlias.ForceRefTo(akTarget)
	Debug.Notification(LeftAlias.GetActorReference().GetLeveledActorBase().GetName() + " designated as LEFT target.")
endEvent