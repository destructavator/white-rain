Scriptname ZarakiteAddItem extends ActiveMagicEffect

import game

MiscObject Property ItemToAdd auto

int Property numItemsToAdd auto

float Property amountHealthToReduce auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float h = akCaster.GetActorValue("Magicka")
	If h > amountHealthToReduce
		akCaster.AddItem(ItemToAdd, numItemsToAdd, false)
		akCaster.DamageActorValue("Magicka", amountHealthToReduce)
	EndIf
EndEvent
