Scriptname ZarakiteAddIngredient extends ActiveMagicEffect

import Game

Ingredient Property ItemToAdd00 auto
Ingredient Property ItemToAdd01 auto
Ingredient Property ItemToAdd02 auto
Ingredient Property ItemToAdd03 auto
Ingredient Property ItemToAdd04 auto

Ingredient Property ItemToAdd05 auto
Ingredient Property ItemToAdd06 auto
Ingredient Property ItemToAdd07 auto
Ingredient Property ItemToAdd08 auto
Ingredient Property ItemToAdd09 auto

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

MiscObject Property Gold001 auto

float Property amountHealthToReduce auto
int Property priceCash auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float h = akCaster.GetActorValue("Magicka")

	If h > amountHealthToReduce
		If akCaster.GetItemCount(Gold001) >= priceCash
			akCaster.AddItem(ItemToAdd00, numItemsToAdd00, false)
			akCaster.AddItem(ItemToAdd01, numItemsToAdd01, false)
			akCaster.AddItem(ItemToAdd02, numItemsToAdd02, false)
			akCaster.AddItem(ItemToAdd03, numItemsToAdd03, false)
			akCaster.AddItem(ItemToAdd04, numItemsToAdd04, false)

			akCaster.AddItem(ItemToAdd05, numItemsToAdd05, false)
			akCaster.AddItem(ItemToAdd06, numItemsToAdd06, false)
			akCaster.AddItem(ItemToAdd07, numItemsToAdd07, false)
			akCaster.AddItem(ItemToAdd08, numItemsToAdd08, false)
			akCaster.AddItem(ItemToAdd09, numItemsToAdd09, false)

			If h > 0.0
				akCaster.DamageActorValue("Magicka", amountHealthToReduce)
			EndIf

			if priceCash > 0
				akCaster.RemoveItem(Gold001, priceCash, false)
			EndIf
		Else
			If priceCash > 0
				Debug.MessageBox("Your family showed up, but you don't have enough gold for some of the things they brought you.")
			EndIf
		EndIf
	Else
		Debug.MessageBox("Not enough health")
	EndIf
EndEvent
