Scriptname ZarakiteDetachable extends ZarakiteUtility

import game

MiscObject Property ZarakiteDetachables auto

int Property numDetachablesToAdd auto

float Property amountHealthToReduce auto

float Property timeToPassSeconds auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
;	Actor caster = akCaster.GetReference() As Actor
	float h = akCaster.GetActorValue(GetHealthMagicPointValueName())
	If h > amountHealthToReduce
		akCaster.AddItem(ZarakiteDetachables, numDetachablesToAdd, false)
;		If akCaster == Game.GetPlayer()
			akCaster.DamageActorValue("Magicka", amountHealthToReduce)

			AdvanceGameTimeSecondsDisplay(timeToPassSeconds)
;		EndIf
	EndIf
EndEvent
