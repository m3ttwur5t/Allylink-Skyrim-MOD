Scriptname _m3RedirectionRightMarker extends ActiveMagicEffect  

_m3PlayerAliasMain Property PlayerListenerScript Auto
Faction Property CurrentFollowerFaction  Auto  
ReferenceAlias Property RightAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if !akTarget.IsInFaction(CurrentFollowerFaction)
		Debug.Notification(akTarget.GetLeveledActorBase().GetName() + " is not your follower.")
		return
	endif
	RightAlias.ForceRefTo(akTarget)
	Debug.Notification("Spells cast from your right hand will be redirected to " + RightAlias.GetActorReference().GetLeveledActorBase().GetName())
	PlayerListenerScript.ActivateListener()
endEvent