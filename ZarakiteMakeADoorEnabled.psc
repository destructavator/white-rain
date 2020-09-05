Scriptname ZarakiteMakeADoorEnabled extends ObjectReference

GlobalVariable Property globalCounterVar auto	; ZarakiteHouseA_Door000Enabled as example
MiscObject Property canMakeDummyItem auto ; dummy inventory object used to show door can be enabled or created, ZarakiteLocA_CanMakeGardenChamber_dummy is an example
ObjectReference Property theDoorInTheLocationMap auto ; the actual door, an object reference and single instance and not a base, from a map

GlobalVariable Property gameHour auto	; used to advance game time
float Property timeToConstruct auto	; How long in hours it takes to build an area and have the door made as well when finished

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Actor player = Game.GetPlayer()
	If akNewContainer == player
		If theDoorInTheLocationMap.IsDisabled()
			theDoorInTheLocationMap.Enable()		
		EndIf

		globalCounterVar.Mod(2)

		float tF = timeToConstruct * 60.0	;	Get minutes from hours
		int t = tF as int	;	So the value doesn't have digits after any decimal point
		Debug.Notification(t + " minutes have passed.")	;	Display message on-screen in the corner
		gameHour.Mod(timeToConstruct)	;	Actually pass time, game time that affects plots and quests and other fun stuff.....

		self.Disable()
		Utility.Wait(1.0)
		self.Delete()
	EndIf

	player.RemoveItem(canMakeDummyItem, 9999, true)
EndEvent
