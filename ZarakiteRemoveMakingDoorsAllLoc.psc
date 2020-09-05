Scriptname ZarakiteRemoveMakingDoorsAllLoc extends ObjectReference

MiscObject Property ZarakiteLocationA_dummy auto
MiscObject Property ZarakiteLocationB_dummy auto
MiscObject Property ZarakiteLocationC_dummy auto

Event OnActivate(ObjectReference akActionRef)
	Actor player = Game.GetPlayer()

	player.RemoveItem(ZarakiteLocationA_dummy, 9999, true)
	player.RemoveItem(ZarakiteLocationB_dummy, 9999, true)
	player.RemoveItem(ZarakiteLocationC_dummy, 9999, true)
EndEvent