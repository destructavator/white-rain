Scriptname ZarakiteGetSupportFromFamily extends ZarakiteUtility

import Game

;/
bool Property enableHealthHit auto
float Property amountHealthToReduce auto
/;

MiscObject Property Gold001 auto
int Property priceCash auto
bool Property giveStuffWithoutGold auto

; List A is for having no gold
; MiscObjects, list A
MiscObject Property ItemToAdd00 auto
int Property numItemsToAdd00 auto
MiscObject Property ItemToAdd01 auto
int Property numItemsToAdd01 auto
MiscObject Property ItemToAdd02 auto
int Property numItemsToAdd02 auto
MiscObject Property ItemToAdd03 auto
int Property numItemsToAdd03 auto
MiscObject Property ItemToAdd04 auto
int Property numItemsToAdd04 auto

MiscObject Property ItemToAdd05 auto
int Property numItemsToAdd05 auto
MiscObject Property ItemToAdd06 auto
int Property numItemsToAdd06 auto
MiscObject Property ItemToAdd07 auto
int Property numItemsToAdd07 auto
MiscObject Property ItemToAdd08 auto
int Property numItemsToAdd08 auto
MiscObject Property ItemToAdd09 auto
int Property numItemsToAdd09 auto

MiscObject Property ItemToAdd10 auto
int Property numItemsToAdd10 auto
MiscObject Property ItemToAdd11 auto
int Property numItemsToAdd11 auto
MiscObject Property ItemToAdd12 auto
int Property numItemsToAdd12 auto
MiscObject Property ItemToAdd13 auto
int Property numItemsToAdd13 auto
MiscObject Property ItemToAdd14 auto
int Property numItemsToAdd14 auto

; Ingredients, list A
Ingredient Property IngredientToAdd00 auto
int Property numIngredientsToAdd00 auto
Ingredient Property IngredientToAdd01 auto
int Property numIngredientsToAdd01 auto
Ingredient Property IngredientToAdd02 auto
int Property numIngredientsToAdd02 auto
Ingredient Property IngredientToAdd03 auto
int Property numIngredientsToAdd03 auto
Ingredient Property IngredientToAdd04 auto
int Property numIngredientsToAdd04 auto

Ingredient Property IngredientToAdd05 auto
int Property numIngredientsToAdd05 auto
Ingredient Property IngredientToAdd06 auto
int Property numIngredientsToAdd06 auto
Ingredient Property IngredientToAdd07 auto
int Property numIngredientsToAdd07 auto
Ingredient Property IngredientToAdd08 auto
int Property numIngredientsToAdd08 auto
Ingredient Property IngredientToAdd09 auto
int Property numIngredientsToAdd09 auto

Ingredient Property IngredientToAdd10 auto
int Property numIngredientsToAdd10 auto
Ingredient Property IngredientToAdd11 auto
int Property numIngredientsToAdd11 auto
Ingredient Property IngredientToAdd12 auto
int Property numIngredientsToAdd12 auto
Ingredient Property IngredientToAdd13 auto
int Property numIngredientsToAdd13 auto
Ingredient Property IngredientToAdd14 auto
int Property numIngredientsToAdd14 auto

; Potions, list A
Potion Property PotionToAdd00 auto
int Property numPotionsToAdd00 auto
Potion Property PotionToAdd01 auto
int Property numPotionsToAdd01 auto
Potion Property PotionToAdd02 auto
int Property numPotionsToAdd02 auto
Potion Property PotionToAdd03 auto
int Property numPotionsToAdd03 auto
Potion Property PotionToAdd04 auto
int Property numPotionsToAdd04 auto

Potion Property PotionToAdd05 auto
int Property numPotionsToAdd05 auto
Potion Property PotionToAdd06 auto
int Property numPotionsToAdd06 auto
Potion Property PotionToAdd07 auto
int Property numPotionsToAdd07 auto
Potion Property PotionToAdd08 auto
int Property numPotionsToAdd08 auto
Potion Property PotionToAdd09 auto
int Property numPotionsToAdd09 auto

Potion Property PotionToAdd10 auto
int Property numPotionsToAdd10 auto
Potion Property PotionToAdd11 auto
int Property numPotionsToAdd11 auto
Potion Property PotionToAdd12 auto
int Property numPotionsToAdd12 auto
Potion Property PotionToAdd13 auto
int Property numPotionsToAdd13 auto
Potion Property PotionToAdd14 auto
int Property numPotionsToAdd14 auto

; List B is for having no gold
; MiscObjects, list B
MiscObject Property ItemToAdd00B auto
int Property numItemsToAdd00B auto
MiscObject Property ItemToAdd01B auto
int Property numItemsToAdd01B auto
MiscObject Property ItemToAdd02B auto
int Property numItemsToAdd02B auto
MiscObject Property ItemToAdd03B auto
int Property numItemsToAdd03B auto
MiscObject Property ItemToAdd04B auto
int Property numItemsToAdd04B auto

; Ingredients, list B
Ingredient Property IngredientToAdd00B auto
int Property numIngredientsToAdd00B auto
Ingredient Property IngredientToAdd01B auto
int Property numIngredientsToAdd01B auto
Ingredient Property IngredientToAdd02B auto
int Property numIngredientsToAdd02B auto
Ingredient Property IngredientToAdd03B auto
int Property numIngredientsToAdd03B auto
Ingredient Property IngredientToAdd04B auto
int Property numIngredientsToAdd04B auto

; Potions, list B
Potion Property PotionToAdd00B auto
int Property numPotionsToAdd00B auto
Potion Property PotionToAdd01B auto
int Property numPotionsToAdd01B auto
Potion Property PotionToAdd02B auto
int Property numPotionsToAdd02B auto
Potion Property PotionToAdd03B auto
int Property numPotionsToAdd03B auto
Potion Property PotionToAdd04B auto
int Property numPotionsToAdd04B auto

Function casterAddMiscObject(Actor actorCaster, MiscObject itemBeingAdded, int numItemsBeingAdded)
	If numItemsBeingAdded > 0
		actorCaster.AddItem(itemBeingAdded, numItemsBeingAdded, false)
	EndIf
EndFunction

Function casterAddIngredient(Actor actorCaster, Ingredient itemBeingAdded, int numItemsBeingAdded)
	If numItemsBeingAdded > 0
		actorCaster.AddItem(itemBeingAdded, numItemsBeingAdded, false)
	EndIf
EndFunction

Function casterAddPotion(Actor actorCaster, Potion itemBeingAdded, int numItemsBeingAdded)
	If numItemsBeingAdded > 0
		actorCaster.AddItem(itemBeingAdded, numItemsBeingAdded, false)
	EndIf
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	bool okayToGetSupport = true
	bool dayIsSame = IsSameDayAsLastFamilySupport()
	If dayIsSame == true
		okayToGetSupport = false
	EndIf
	
	UpdateLastFamilySupportDay()

;/
	string health = GetHealthMagicPointValueName()

	If enableHealthHit == 1
		float h = akCaster.GetActorValue(health)

		If h > amountHealthToReduce
			akCaster.DamageActorValue(health, amountHealthToReduce)
		EndIf
	EndIf
/;

	bool hasEnoughGold = false
	If akCaster.GetItemCount(Gold001) >= priceCash
		hasEnoughGold = true
	EndIf

	If okayToGetSupport == true
		If hasEnoughGold == true
		;	Sufficient Money
			akCaster.RemoveItem(Gold001, priceCash, false)

			casterAddMiscObject(akCaster, ItemToAdd00, numItemsToAdd00)
			casterAddMiscObject(akCaster, ItemToAdd01, numItemsToAdd01)
			casterAddMiscObject(akCaster, ItemToAdd02, numItemsToAdd02)
			casterAddMiscObject(akCaster, ItemToAdd03, numItemsToAdd03)
			casterAddMiscObject(akCaster, ItemToAdd04, numItemsToAdd04)
			casterAddMiscObject(akCaster, ItemToAdd05, numItemsToAdd05)
			casterAddMiscObject(akCaster, ItemToAdd06, numItemsToAdd06)
			casterAddMiscObject(akCaster, ItemToAdd07, numItemsToAdd07)
			casterAddMiscObject(akCaster, ItemToAdd08, numItemsToAdd08)
			casterAddMiscObject(akCaster, ItemToAdd09, numItemsToAdd09)
			casterAddMiscObject(akCaster, ItemToAdd10, numItemsToAdd10)
			casterAddMiscObject(akCaster, ItemToAdd11, numItemsToAdd11)
			casterAddMiscObject(akCaster, ItemToAdd12, numItemsToAdd12)
			casterAddMiscObject(akCaster, ItemToAdd13, numItemsToAdd13)
			casterAddMiscObject(akCaster, ItemToAdd14, numItemsToAdd14)

			casterAddIngredient(akCaster, IngredientToAdd00, numIngredientsToAdd00)
			casterAddIngredient(akCaster, IngredientToAdd01, numIngredientsToAdd01)
			casterAddIngredient(akCaster, IngredientToAdd02, numIngredientsToAdd02)
			casterAddIngredient(akCaster, IngredientToAdd03, numIngredientsToAdd03)
			casterAddIngredient(akCaster, IngredientToAdd04, numIngredientsToAdd04)
			casterAddIngredient(akCaster, IngredientToAdd05, numIngredientsToAdd05)
			casterAddIngredient(akCaster, IngredientToAdd06, numIngredientsToAdd06)
			casterAddIngredient(akCaster, IngredientToAdd07, numIngredientsToAdd07)
			casterAddIngredient(akCaster, IngredientToAdd08, numIngredientsToAdd08)
			casterAddIngredient(akCaster, IngredientToAdd09, numIngredientsToAdd09)
			casterAddIngredient(akCaster, IngredientToAdd10, numIngredientsToAdd10)
			casterAddIngredient(akCaster, IngredientToAdd11, numIngredientsToAdd11)
			casterAddIngredient(akCaster, IngredientToAdd12, numIngredientsToAdd12)
			casterAddIngredient(akCaster, IngredientToAdd13, numIngredientsToAdd13)
			casterAddIngredient(akCaster, IngredientToAdd14, numIngredientsToAdd14)

			casterAddPotion(akCaster, PotionToAdd00, numPotionsToAdd00)
			casterAddPotion(akCaster, PotionToAdd01, numPotionsToAdd01)
			casterAddPotion(akCaster, PotionToAdd02, numPotionsToAdd02)
			casterAddPotion(akCaster, PotionToAdd03, numPotionsToAdd03)
			casterAddPotion(akCaster, PotionToAdd04, numPotionsToAdd04)
			casterAddPotion(akCaster, PotionToAdd05, numPotionsToAdd05)
			casterAddPotion(akCaster, PotionToAdd06, numPotionsToAdd06)
			casterAddPotion(akCaster, PotionToAdd07, numPotionsToAdd07)
			casterAddPotion(akCaster, PotionToAdd08, numPotionsToAdd08)
			casterAddPotion(akCaster, PotionToAdd09, numPotionsToAdd09)
			casterAddPotion(akCaster, PotionToAdd10, numPotionsToAdd10)
			casterAddPotion(akCaster, PotionToAdd11, numPotionsToAdd11)
			casterAddPotion(akCaster, PotionToAdd12, numPotionsToAdd12)
			casterAddPotion(akCaster, PotionToAdd13, numPotionsToAdd13)
			casterAddPotion(akCaster, PotionToAdd14, numPotionsToAdd14)
		Else
		;	Insufficient Money
			casterAddMiscObject(akCaster, ItemToAdd00B, numItemsToAdd00B)
			casterAddMiscObject(akCaster, ItemToAdd01B, numItemsToAdd01B)
			casterAddMiscObject(akCaster, ItemToAdd02B, numItemsToAdd02B)
			casterAddMiscObject(akCaster, ItemToAdd03B, numItemsToAdd03B)
			casterAddMiscObject(akCaster, ItemToAdd04B, numItemsToAdd04B)

			casterAddIngredient(akCaster, IngredientToAdd00B, numIngredientsToAdd00B)
			casterAddIngredient(akCaster, IngredientToAdd01B, numIngredientsToAdd01B)
			casterAddIngredient(akCaster, IngredientToAdd02B, numIngredientsToAdd02B)
			casterAddIngredient(akCaster, IngredientToAdd03B, numIngredientsToAdd03B)
			casterAddIngredient(akCaster, IngredientToAdd04B, numIngredientsToAdd04B)

			casterAddPotion(akCaster, PotionToAdd00B, numPotionsToAdd00B)
			casterAddPotion(akCaster, PotionToAdd01B, numPotionsToAdd01B)
			casterAddPotion(akCaster, PotionToAdd02B, numPotionsToAdd02B)
			casterAddPotion(akCaster, PotionToAdd03B, numPotionsToAdd03B)
			casterAddPotion(akCaster, PotionToAdd04B, numPotionsToAdd04B)
		EndIf
	Else
		Debug.Notification("You'll have to wait until tomorrow before getting more support.")
	EndIf

;/
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
/;
EndEvent
