Scriptname ZarakiteMakeAListEnabled extends ObjectReference

GlobalVariable Property GameHour auto
float Property timeToBuild auto

FormList Property list auto

GlobalVariable Property globalBoolVar auto
int Property globalValueToSet auto

Function EnableStuffOnList()
	int iIndex = list.GetSize()
	While iIndex
		iIndex -= 1

		ObjectReference ref = list.GetAt(iIndex) as ObjectReference
		If ref.IsDisabled()
			ref.Enable()
		EndIf
	EndWhile

	float tdf = timeToBuild * 60.0
	int td = tdf as int
	If td > 0
		Debug.Notification(td + " minutes have passed.")
	EndIf

	GameHour.Mod(timeToBuild)
EndFunction

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	EnableStuffOnList()

	globalBoolVar.SetValueInt(globalValueToSet)
EndEvent