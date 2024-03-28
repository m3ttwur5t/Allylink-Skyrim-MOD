Scriptname _m3HealerRedirectionLeftMarker extends ActiveMagicEffect  

_m3HealerPlayerAliasMain Property PlayerListenerScript Auto
Faction Property CurrentFollowerFaction  Auto  
ReferenceAlias Property LeftAlias Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if !akTarget.IsInFaction(CurrentFollowerFaction)
		Debug.Notification(akTarget.GetLeveledActorBase().GetName() + " is not your follower.")
		return
	endif
	LeftAlias.ForceRefTo(akTarget)
	Debug.Notification("Spells cast from your left hand will be redirected to " + LeftAlias.GetActorReference().GetLeveledActorBase().GetName())
	PlayerListenerScript.ActivateListener()
endEvent