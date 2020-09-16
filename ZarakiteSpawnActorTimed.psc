Scriptname ZarakiteSpawnActorTimed extends ObjectReference

; import Game

ActorBase Property ActorToAdd auto

int Property numActorsToAdd auto

float Property preDelayHours auto
float Property lifeSpanHours auto

Event OnActivate(ObjectReference akActionRef)
	Utility.WaitGameTime(preDelayHours)
	
	ObjectReference spawnedActor = Game.GetPlayer().PlaceAtMe(ActorToAdd, numActorsToAdd)

	Utility.WaitGameTime(lifeSpanHours)

	spawnedActor.Disable()
	Utility.Wait(5.0)
	spawnedActor.Delete()
EndEvent
