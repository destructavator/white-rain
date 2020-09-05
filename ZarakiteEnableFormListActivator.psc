Scriptname ZarakiteEnableFormListActivator extends ObjectReference

GlobalVariable Property GameHour auto
float Property timeToBuild auto
float Property timeToDestroy auto

FormList Property list auto

GlobalVariable Property globalBoolVar auto

bool Property destroyInstead auto

Activator Property dummyObjectEnable auto
Activator Property dummyObjectDisable auto

Function EnableStuffOnList()
	int iIndex = list.GetSize()
	While iIndex
		iIndex -= 1

		ObjectReference ref = list.GetAt(iIndex) as ObjectReference
		If ref.IsDisabled()
			ref.Enable()
		EndIf
	EndWhile

	Actor player = Game.GetPlayer()
;	If akNewContainer == player
		globalBoolVar.SetValueInt(1)

		player.RemoveItem(dummyObjectDisable, 9999, true)

		self.Disable()
		Utility.Wait(1.5)
		self.Delete()
;	EndIf

	float tdf = timeToBuild * 60.0
	int td = tdf as int
	Debug.Notification(td + " minutes have passed.")
	GameHour.Mod(timeToBuild)
EndFunction

Function DisableStuffOnList()
	int iIndex = list.GetSize()
	While iIndex
		iIndex -= 1

		ObjectReference ref = list.GetAt(iIndex) as ObjectReference
		If ref.IsEnabled()
			ref.Disable()
		EndIf
	EndWhile

	Actor player = Game.GetPlayer()
;	If akNewContainer == player
		globalBoolVar.SetValueInt(0)

		player.RemoveItem(dummyObjectEnable, 9999, true)

		self.Disable()
		Utility.Wait(1.5)
		self.Delete()
;	EndIf

	float tdf = timeToDestroy * 60.0
	int td = tdf as int
	Debug.Notification(td + " minutes have passed.")
	GameHour.Mod(timeToDestroy)
EndFunction

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If destroyInstead == false
		EnableStuffOnList()
	Else
		DisableStuffOnList()
	EndIf
EndEvent