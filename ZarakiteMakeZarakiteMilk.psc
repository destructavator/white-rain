Scriptname ZarakiteMakeZarakiteMilk extends ActiveMagicEffect

import game

MiscObject Property ZarakiteMilk auto

int Property numMilkToAdd auto
float Property amountHealthToReduce auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float h = akCaster.GetActorValue("Magicka")
	If h > amountHealthToReduce
		akCaster.AddItem(ZarakiteMilk, numMilkToAdd, false)
		akCaster.DamageActorValue("Magicka", amountHealthToReduce)
	EndIf
EndEvent
