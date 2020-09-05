Scriptname ZarakiteCreateMaterials extends ZarakiteUtility

import Game

float Property amountHealthToReduceBase auto

Message Property ZarakiteMakeMaterialsMessage auto
Message Property ZarakiteMakeMaterialsMetalsMessage auto
Message Property ZarakiteMakeMaterialsMetals02Message auto
Message Property ZarakiteMakeMaterialsOresMessage auto
Message Property ZarakiteMakeMaterialsOres02Message auto
Message Property ZarakiteMakeMaterialsOtherMessage auto
Message Property ZarakiteMakeMaterialsPrefabricatedMessage auto
Message Property ZarakiteMakeMilkMessage auto

MiscObject Property IngotCorundum auto;		List 1
MiscObject Property IngotDwarven auto
MiscObject Property IngotEbony auto
MiscObject Property IngotGold auto
MiscObject Property IngotMoonstone auto
MiscObject Property IngotIron auto
MiscObject Property IngotMalachite auto;	List 2
MiscObject Property IngotOrichalcum auto
MiscObject Property IngotQuicksilver auto
MiscObject Property ingotSilver auto
MiscObject Property IngotSteel auto

MiscObject Property OreCorundum auto;		List 1
MiscObject Property OreEbony auto
MiscObject Property OreGold auto
MiscObject Property OreMoonstone auto
MiscObject Property OreIron auto
MiscObject Property OreMalachite auto;		List 2
MiscObject Property OreOrichalcum auto
MiscObject Property OreQuicksilver auto
MiscObject Property OreSilver auto

MiscObject Property BYOHMaterialClay auto
MiscObject Property BYOHMaterialStoneBlock auto
MiscObject Property BYOHMaterialGlass auto
Ingredient Property ZarakiteMineralsAndDirt auto
MiscObject Property Firewood01 auto

float Property MineralSoilHoursForOne auto

MiscObject Property BYOHMaterialHinge auto
MiscObject Property BYOHMaterialLock auto
MiscObject Property BYOHMaterialFittingsIron auto
MiscObject Property BYOHMaterialNails auto
MiscObject Property BYOHMaterialStraw auto
MiscObject Property BYOHMaterialLog auto

float Property hoursForOneUnit auto

Function CreateItemsFromGloves(Actor creatorActor, MiscObject objectToCreate)
	string health = GetHealthMagicPointValueName()
	float casterHealth = creatorActor.GetActorValue(health)

	float numCanMakeF = casterHealth / amountHealthToReduceBase
	int numCanMake = numCanMakeF as int

	Debug.Notification("You can make about " + numCanMake + " units right now.")

	int numToCreate = 0
	int iButton = ZarakiteMakeMilkMessage.Show()
	If iButton == 1
		numToCreate = 5
	ElseIf iButton == 2
		numToCreate = 10
	ElseIf iButton == 3
		numToCreate = 20
	ElseIf iButton == 4
		numToCreate = 30
	ElseIf iButton == 5
		numToCreate = 40
	ElseIf iButton == 6
		numToCreate = 50
	EndIf

	float timeAdvancement = numToCreate as float
	timeAdvancement *= hoursForOneUnit

	If numToCreate > 0
		If numToCreate > numCanMake
			Debug.Notification("You can't make that many right now.")
		Else
			float amountHealthToReduce = amountHealthToReduceBase
			amountHealthToReduce *= numToCreate as float
			creatorActor.DamageActorValue(health, amountHealthToReduce)

			creatorActor.AddItem(objectToCreate, numToCreate, false)
			
			float timeMinutesF = timeAdvancement * 60.0
			int timeMinutes = timeMinutesF as int
			Debug.Notification(timeMinutes + " minutes have passed.")

			AdvanceGameTime(timeAdvancement)
		EndIf
	EndIf
EndFunction

Function CreateItemsFromGlovesPassTime(Actor creatorActor, Ingredient objectToCreate)
	string health = GetHealthMagicPointValueName()
	float casterHealth = creatorActor.GetActorValue(health)

	float numCanMakeF = casterHealth / amountHealthToReduceBase
	int numCanMake = numCanMakeF as int

	Debug.Notification("You can make about " + numCanMake + " units right now.")

	int numToCreate = 0
	int iButton = ZarakiteMakeMilkMessage.Show()
	If iButton == 1
		numToCreate = 5
	ElseIf iButton == 2
		numToCreate = 10
	ElseIf iButton == 3
		numToCreate = 20
	ElseIf iButton == 4
		numToCreate = 30
	ElseIf iButton == 5
		numToCreate = 40
	ElseIf iButton == 6
		numToCreate = 50
	EndIf

	float timeAdvancement = numToCreate as float
	timeAdvancement *= MineralSoilHoursForOne

	If numToCreate > 0
		If numToCreate > numCanMake
			Debug.Notification("You can't make that many right now.")
		Else
			float amountHealthToReduce = amountHealthToReduceBase
			amountHealthToReduce *= numToCreate as float
			creatorActor.DamageActorValue(health, amountHealthToReduce)

			creatorActor.AddItem(objectToCreate, numToCreate, false)
			
			float timeMinutesF = timeAdvancement * 60.0
			int timeMinutes = timeMinutesF as int
			Debug.Notification(timeMinutes + " minutes have passed.")

			AdvanceGameTime(timeAdvancement)
		EndIf
	EndIf
EndFunction


Event OnEffectStart(Actor akTarget, Actor akCaster)
;	int numItems = 0
;	float healthHit = amountHealthToReduceBase
;	string health = GetHealthMagicPointValueName()
;	float casterHealth = akCaster.GetActorValue(health)
	
	int iButtonA = 0
	;	0 = cancel
	;	1 = metals list 1
	;	2 = metals list 2
	;	3 = ores list 1
	;	4 = ores list 2
	;	5 = other
	int iButtonB = 0
	;	0 = cancel
	;	>0 = [varies]

	iButtonA = ZarakiteMakeMaterialsMessage.Show()

	If iButtonA == 1
		iButtonB = ZarakiteMakeMaterialsMetalsMessage.Show()

		If iButtonB == 1
			CreateItemsFromGloves(akCaster, IngotCorundum)
		ElseIf iButtonB == 2
			CreateItemsFromGloves(akCaster, IngotDwarven)
		ElseIf iButtonB == 3
			CreateItemsFromGloves(akCaster, IngotEbony)
		ElseIf iButtonB == 4
			CreateItemsFromGloves(akCaster, IngotGold)
		ElseIf iButtonB == 5
			CreateItemsFromGloves(akCaster, IngotMoonstone)
		ElseIf iButtonB == 6
			CreateItemsFromGloves(akCaster, IngotIron)
		EndIf
	ElseIf iButtonA == 2
		iButtonB = ZarakiteMakeMaterialsMetals02Message.Show()

		If iButtonB == 1
			CreateItemsFromGloves(akCaster, IngotMalachite)
		ElseIf iButtonB == 2
			CreateItemsFromGloves(akCaster, IngotOrichalcum)
		ElseIf iButtonB == 3
			CreateItemsFromGloves(akCaster, IngotQuicksilver)
		ElseIf iButtonB == 4
			CreateItemsFromGloves(akCaster, ingotSilver)
		ElseIf iButtonB == 5
			CreateItemsFromGloves(akCaster, IngotSteel)
		EndIf
	ElseIf iButtonA == 3
		iButtonB = ZarakiteMakeMaterialsOresMessage.Show()

		If iButtonB == 1
			CreateItemsFromGloves(akCaster, OreCorundum)
		ElseIf iButtonB == 2
			CreateItemsFromGloves(akCaster, OreEbony)
		ElseIf iButtonB == 3
			CreateItemsFromGloves(akCaster, OreGold)
		ElseIf iButtonB == 4
			CreateItemsFromGloves(akCaster, OreMoonstone)
		ElseIf iButtonB == 5
			CreateItemsFromGloves(akCaster, OreIron)
		EndIf
	ElseIf iButtonA == 4
		iButtonB = ZarakiteMakeMaterialsOres02Message.Show()

		If iButtonB == 1
			CreateItemsFromGloves(akCaster, OreMalachite)
		ElseIf iButtonB == 2
			CreateItemsFromGloves(akCaster, OreOrichalcum)
		ElseIf iButtonB == 3
			CreateItemsFromGloves(akCaster, OreQuicksilver)
		ElseIf iButtonB == 4
			CreateItemsFromGloves(akCaster, OreSilver)
		EndIf
	ElseIf iButtonA == 5
		iButtonB = ZarakiteMakeMaterialsOtherMessage.Show()

		If iButtonB == 1
			CreateItemsFromGloves(akCaster, BYOHMaterialClay)
		ElseIf iButtonB == 2
			CreateItemsFromGloves(akCaster, BYOHMaterialStoneBlock)
		ElseIf iButtonB == 3
			CreateItemsFromGloves(akCaster, BYOHMaterialGlass)
		ElseIf iButtonB == 4
			CreateItemsFromGlovesPassTime(akCaster, ZarakiteMineralsAndDirt)
		ElseIf iButtonB == 5
			CreateItemsFromGloves(akCaster, Firewood01)
		EndIf
	ElseIf iButtonA == 6
		iButtonB = ZarakiteMakeMaterialsPrefabricatedMessage.Show()

		If iButtonB == 1
			CreateItemsFromGloves(akCaster, BYOHMaterialHinge)
		ElseIf iButtonB == 2
			CreateItemsFromGloves(akCaster, BYOHMaterialLock)
		ElseIf iButtonB == 3
			CreateItemsFromGloves(akCaster, BYOHMaterialFittingsIron)
		ElseIf iButtonB == 4
			CreateItemsFromGloves(akCaster, BYOHMaterialNails)
		ElseIf iButtonB == 5
			CreateItemsFromGloves(akCaster, BYOHMaterialStraw)
		ElseIf iButtonB == 6
			CreateItemsFromGloves(akCaster, BYOHMaterialLog)
		EndIf
	EndIf
EndEvent
