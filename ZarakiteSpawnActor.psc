Scriptname ZarakiteSpawnActor extends ActiveMagicEffect

import Game

ActorBase Property ItemToAdd auto

int Property numItemsToAdd auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Game.GetPlayer().PlaceAtMe(ItemToAdd, numItemsToAdd)
EndEvent
