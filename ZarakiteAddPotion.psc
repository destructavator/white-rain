Scriptname ZarakiteAddPotion extends ActiveMagicEffect

import game

Potion Property ItemToAdd auto
Potion Property ItemToAdd1 auto
Potion Property ItemToAdd2 auto
Potion Property ItemToAdd3 auto
Potion Property ItemToAdd4 auto

int Property numItemsToAdd auto
int Property numItemsToAdd1 auto
int Property numItemsToAdd2 auto
int Property numItemsToAdd3 auto
int Property numItemsToAdd4 auto

float Property amountHealthToReduce auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float h = akCaster.GetActorValue("Magicka")
	If h > amountHealthToReduce
		akCaster.AddItem(ItemToAdd, numItemsToAdd, false)
		If numItemsToAdd1 > 0
			akCaster.AddItem(ItemToAdd1, numItemsToAdd1, false)
		EndIf
		If numItemsToAdd2 > 0
			akCaster.AddItem(ItemToAdd2, numItemsToAdd2, false)
		EndIf
		If numItemsToAdd3 > 0
			akCaster.AddItem(ItemToAdd3, numItemsToAdd3, false)
		EndIf
		If numItemsToAdd4 > 0
			akCaster.AddItem(ItemToAdd4, numItemsToAdd4, false)
		EndIf

		akCaster.DamageActorValue("Magicka", amountHealthToReduce)
	EndIf
EndEvent
