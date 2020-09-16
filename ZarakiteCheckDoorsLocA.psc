Scriptname ZarakiteCheckDoorsLocA extends ObjectReference

GlobalVariable Property ZarakiteHouseA_Door000Enabled auto
GlobalVariable Property ZarakiteLocA_SmithingDoorEnabled auto
GlobalVariable Property ZarakiteLocA_StudyDoorEnabled auto

; Form Property ZarakiteBasementEntry000_A auto	; OLD Falkreath Garden Chamber Door

MiscObject Property ZarakiteLocationA_dummy auto
MiscObject Property ZarakiteLocationB_dummy auto
MiscObject Property ZarakiteLocationC_dummy auto

MiscObject Property ZarakiteLocA_CanMakeGardenChamber_dummy auto
MiscObject Property ZarakiteLocA_GardenChamber_Door_dummy auto

MiscObject Property ZarakiteLocA_CanMakeForgeRoom_dummy auto
MiscObject Property ZarakiteLocA_ForgeRoom_Door_dummy auto

MiscObject Property ZarakiteLocA_CanMakeStudy_dummy auto
MiscObject Property ZarakiteLocA_Study_Door_dummy auto

float locX0A = -9860.0	;	Falkreath
float locX1A = -7860.0	;	Falkreath
float locX0B = -24772.0	;	Winstad
float locX1B = -22772.0	;	Winstad
float locX0C = 31189.0	;	Heljarchen
float locX1C = 33189.0	;	Heljarchen

float locY0A = -71795.0	;	Falkreath
float locY1A = -69795.0	;	Falkreath
float locY0B = 96267.0	;	Winstad
float locY1B = 98267.0	;	Winstad
float locY0C = 37676.0	;	Heljarchen
float locY1C = 35676.0	;	Heljarchen

float locZ0A = 1234.0	;	Falkreath
float locZ1A = 3434.0	;	Falkreath
float locZ0B = -14420.0	;	Winstad
float locZ1B = -12220.0	;	Winstad
float locZ0C = -7997.0	;	Heljarchen
float locZ1C = -5797.0	;	Heljarchen

Event OnActivate(ObjectReference akActionRef)
	Actor player = Game.GetPlayer()
	float locX = player.GetPositionX()
	float locY = player.GetPositionY()
	float locZ = player.GetPositionZ()
	int locationXYZiD = 1	;	0 for unknown or unset

	player.RemoveItem(ZarakiteLocationA_dummy, 9999, true)
	player.RemoveItem(ZarakiteLocationB_dummy, 9999, true)
	player.RemoveItem(ZarakiteLocationC_dummy, 9999, true)

	If locationXYZiD == 0
		Debug.Notification("This workbench is too far away from where it would be useful.")
	ElseIf locationXYZiD == 1
		player.AddItem(ZarakiteLocationA_dummy, 1, true)

		player.RemoveItem(ZarakiteLocA_GardenChamber_Door_dummy, 9999, true)
		player.RemoveItem(ZarakiteLocA_ForgeRoom_Door_dummy, 9999, true)
		player.RemoveItem(ZarakiteLocA_Study_Door_dummy, 9999, true)

		If ZarakiteHouseA_Door000Enabled.GetValue() < 0.5
			player.AddItem(ZarakiteLocA_CanMakeGardenChamber_dummy, 1, true)
		Else
			player.RemoveItem(ZarakiteLocA_CanMakeGardenChamber_dummy, 9999, true)
		EndIf

		If ZarakiteLocA_SmithingDoorEnabled.GetValue() < 0.5
			player.AddItem(ZarakiteLocA_CanMakeForgeRoom_dummy, 1, true)
		Else
			player.RemoveItem(ZarakiteLocA_CanMakeForgeRoom_dummy, 9999, true)
		EndIf

		If ZarakiteLocA_StudyDoorEnabled.GetValue() < 0.5
			player.AddItem(ZarakiteLocA_CanMakeStudy_dummy, 1, true)
		Else
			player.RemoveItem(ZarakiteLocA_CanMakeStudy_dummy, 9999, true)
		EndIf
	EndIf
EndEvent