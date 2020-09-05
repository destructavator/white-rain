Scriptname ZarakiteAddItems extends ActiveMagicEffect

import Game

MiscObject Property ItemToAdd00 auto
MiscObject Property ItemToAdd01 auto
MiscObject Property ItemToAdd02 auto
MiscObject Property ItemToAdd03 auto
MiscObject Property ItemToAdd04 auto
MiscObject Property ItemToAdd05 auto
MiscObject Property ItemToAdd06 auto
MiscObject Property ItemToAdd07 auto
MiscObject Property ItemToAdd08 auto
MiscObject Property ItemToAdd09 auto

int Property numItemsToAdd00 auto
int Property numItemsToAdd01 auto
int Property numItemsToAdd02 auto
int Property numItemsToAdd03 auto
int Property numItemsToAdd04 auto
int Property numItemsToAdd05 auto
int Property numItemsToAdd06 auto
int Property numItemsToAdd07 auto
int Property numItemsToAdd08 auto
int Property numItemsToAdd09 auto

int Property enableHealthHit auto
float Property amountHealthToReduce auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If enableHealthHit == 1
		float h = akCaster.GetActorValue("Magicka")

		If h > amountHealthToReduce
			akCaster.DamageActorValue("Magicka", amountHealthToReduce)
		EndIf
	EndIf

	If numItemsToAdd00 > 0
		akCaster.AddItem(ItemToAdd00, numItemsToAdd00, false)
	EndIf
	If numItemsToAdd01 > 0
		akCaster.AddItem(ItemToAdd01, numItemsToAdd01, false)
	EndIf
	If numItemsToAdd02 > 0
		akCaster.AddItem(ItemToAdd02, numItemsToAdd02, false)
	EndIf
	If numItemsToAdd03 > 0
		akCaster.AddItem(ItemToAdd03, numItemsToAdd03, false)
	EndIf
	If numItemsToAdd04 > 0
		akCaster.AddItem(ItemToAdd04, numItemsToAdd04, false)
	EndIf
	If numItemsToAdd05 > 0
		akCaster.AddItem(ItemToAdd05, numItemsToAdd05, false)
	EndIf
	If numItemsToAdd06 > 0
		akCaster.AddItem(ItemToAdd06, numItemsToAdd06, false)
	EndIf
	If numItemsToAdd07 > 0
		akCaster.AddItem(ItemToAdd07, numItemsToAdd07, false)
	EndIf
	If numItemsToAdd08 > 0
		akCaster.AddItem(ItemToAdd08, numItemsToAdd08, false)
	EndIf
	If numItemsToAdd09 > 0
		akCaster.AddItem(ItemToAdd09, numItemsToAdd09, false)
	EndIf
EndEvent
