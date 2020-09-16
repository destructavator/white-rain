Scriptname ZarakiteMakeAListDisabled extends ObjectReference

FormList Property list auto

Function EnableStuffOnList()
	int iIndex = list.GetSize()
	While iIndex
		iIndex -= 1

		ObjectReference ref = list.GetAt(iIndex) as ObjectReference
		If ref.IsEnabled()
			ref.Disable()
		EndIf
	EndWhile
EndFunction

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	EnableStuffOnList()
EndEvent