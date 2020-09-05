Scriptname ZarakiteDetachable extends ActiveMagicEffect

import game

MiscObject Property ZarakiteDetachables auto

int Property numDetachablesToAdd auto

float Property amountHealthToReduce auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
;	Actor caster = akCaster.GetReference() As Actor
	float h = akCaster.GetActorValue("Magicka")
	If h > amountHealthToReduce
		akCaster.AddItem(ZarakiteDetachables, numDetachablesToAdd, false)
;		If akCaster == Game.GetPlayer()
			akCaster.DamageActorValue("Magicka", amountHealthToReduce)
;		EndIf
	EndIf
EndEvent
