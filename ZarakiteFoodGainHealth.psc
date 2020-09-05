Scriptname ZarakiteFoodGainHealth extends ActiveMagicEffect

import Game

float Property healthMultiplier auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float gainMag = Self.GetMagnitude()
;	float gainMag = GetMagnitude()
;	float gainMag = Spell.GetNthEffectMagicEffect(0).GetMagnitude()
	gainMag = gainMag * healthMultiplier * -1.0

	akCaster.DamageActorValue("Health", gainMag)
EndEvent
