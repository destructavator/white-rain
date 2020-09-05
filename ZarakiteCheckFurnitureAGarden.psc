Scriptname ZarakiteCheckFurnitureAGarden extends ObjectReference

GlobalVariable Property ZarakiteHouseA_GardenChamber_planters1_made auto
GlobalVariable Property ZarakiteHouseA_GardenChamber_planters2_made auto
GlobalVariable Property ZarakiteHouseA_GardenChamber_planters3_made auto
GlobalVariable Property ZarakiteHouseA_GardenChamber_planters4_made auto
GlobalVariable Property ZarakiteHouseA_GardenChamber_planters5_made auto

GlobalVariable Property ZarakiteLocA_Garden_Apiaries1_made auto
GlobalVariable Property ZarakiteLocA_Garden_Apiaries2_made auto

FormList Property ZarakiteHouseA_GardenChamber_planters1 auto
FormList Property ZarakiteHouseA_GardenChamber_planters2 auto
FormList Property ZarakiteHouseA_GardenChamber_planters3 auto
FormList Property ZarakiteHouseA_GardenChamber_planters4 auto
FormList Property ZarakiteHouseA_GardenChamber_planters5 auto

FormList Property ZarakiteHouseA_GardenChamber_Apiaries_1 auto
FormList Property ZarakiteHouseA_GardenChamber_Apiaries_2 auto

Function CheckFurnitureList(GlobalVariable gVarCheck, FormList list)
	float t = gVarCheck.GetValue()
	int iIndex = list.GetSize()

	If t > 0.5
		While iIndex
			iIndex -= 1

			ObjectReference ref = list.GetAt(iIndex) as ObjectReference
			If ref.IsDisabled()
				ref.Enable()
			EndIf
		EndWhile
	Else
		While iIndex
			iIndex -= 1

			ObjectReference ref = list.GetAt(iIndex) as ObjectReference
			If ref.IsEnabled()
				ref.Disable()
			EndIf
		EndWhile
	EndIf
EndFunction

Event OnCellAttach()
	CheckFurnitureList(ZarakiteHouseA_GardenChamber_planters1_made, ZarakiteHouseA_GardenChamber_planters1)
	CheckFurnitureList(ZarakiteHouseA_GardenChamber_planters2_made, ZarakiteHouseA_GardenChamber_planters2)
	CheckFurnitureList(ZarakiteHouseA_GardenChamber_planters3_made, ZarakiteHouseA_GardenChamber_planters3)
	CheckFurnitureList(ZarakiteHouseA_GardenChamber_planters4_made, ZarakiteHouseA_GardenChamber_planters4)
	CheckFurnitureList(ZarakiteHouseA_GardenChamber_planters5_made, ZarakiteHouseA_GardenChamber_planters5)

	CheckFurnitureList(ZarakiteLocA_Garden_Apiaries1_made, ZarakiteHouseA_GardenChamber_Apiaries_1)
	CheckFurnitureList(ZarakiteLocA_Garden_Apiaries2_made, ZarakiteHouseA_GardenChamber_Apiaries_2)
EndEvent
