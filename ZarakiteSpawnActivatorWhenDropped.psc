Scriptname ZarakiteSpawnActivatorWhenDropped extends ObjectReference

Activator Property thingToSpawn auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Actor player = Game.GetPlayer()
	If akOldContainer && !akNewContainer
		ObjectReference thingSpawned = self.PlaceAtMe(thingToSpawn, 1)

;		Utility.Wait(1.0)
		
;		float x = thingSpawned.GetAngleX()
;		float y = thingSpawned.GetAngleY()
;		float z = thingSpawned.GetAngleZ()
;		thingSpawned.SetAngle(0.0, 0.0, z)

;		float x = self.GetPositionX()
;		float y = self.GetPositionY()
;		float z = self.GetPositionZ()
;		thingSpawned.SetPosition(x, y, z)

		float z2 = self.GetAngleZ()
		thingSpawned.SetAngle(0.0, 0.0, z2)

;		Utility.Wait(0.5)
;		self.Disable()
		Utility.Wait(1.0)
		self.Delete()
	EndIf
EndEvent
