Scriptname ZarakiteRespawningConsumable extends ObjectReference

Potion Property foodObject auto
float Property hoursToRespawn = 24.0 auto

Event OnActivate(ObjectReference akActionRef)
	Actor player = Game.GetPlayer()
	player.AddItem(foodObject, 1)

	self.Disable()

	Utility.WaitGameTime(hoursToRespawn)

	self.Enable()
EndEvent