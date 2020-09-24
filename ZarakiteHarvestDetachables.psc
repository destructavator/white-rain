Scriptname ZarakiteHarvestDetachables extends ZarakiteUtility

import game

MiscObject Property ZarakiteDetachables auto

Ingredient Property ZarakiteBlood auto
Ingredient Property ZarakiteBones auto
Ingredient Property ZarakiteCloth auto
Ingredient Property ZarakiteEyeball auto
Ingredient Property ZarakiteFeathers auto
Ingredient Property ZarakiteFlesh auto
Ingredient Property ZarakiteHair auto
Ingredient Property ZarakiteHeart auto
Ingredient Property ZarakiteSkin auto
Ingredient Property ZarakiteTooth auto

int Property numBlood auto
int Property numBones auto
int Property numCloth auto
int Property numEyeball auto
int Property numFeathers auto
int Property numFlesh auto
int Property numHair auto
int Property numHeart auto
int Property numSkin auto
int Property numTooth auto

float Property numSecondsToHarvestOne auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int numDetachables = akCaster.GetItemCount(ZarakiteDetachables)
;/
	If numDetachables >= 50
		akCaster.RemoveItem(ZarakiteDetachables, 50, false)

		akCaster.AddItem(ZarakiteBlood, numBlood * 50, false)
		akCaster.AddItem(ZarakiteBones, numBones * 50, false)
		akCaster.AddItem(ZarakiteCloth, numCloth * 50, false)
		akCaster.AddItem(ZarakiteEyeball, numEyeball * 50, false)
		akCaster.AddItem(ZarakiteFeathers, numFeathers * 50, false)
		akCaster.AddItem(ZarakiteFlesh, numFlesh * 50, false)
		akCaster.AddItem(ZarakiteHair, numHair * 50, false)
		akCaster.AddItem(ZarakiteHeart, numHeart * 50, false)
		akCaster.AddItem(ZarakiteSkin, numSkin * 50, false)
		akCaster.AddItem(ZarakiteTooth, numTooth * 50, false)

	ElseIf numDetachables >= 5
		akCaster.RemoveItem(ZarakiteDetachables, 5, false)

		akCaster.AddItem(ZarakiteBlood, numBlood * 5, false)
		akCaster.AddItem(ZarakiteBones, numBones * 5, false)
		akCaster.AddItem(ZarakiteCloth, numCloth * 5, false)
		akCaster.AddItem(ZarakiteEyeball, numEyeball * 5, false)
		akCaster.AddItem(ZarakiteFeathers, numFeathers * 5, false)
		akCaster.AddItem(ZarakiteFlesh, numFlesh * 5, false)
		akCaster.AddItem(ZarakiteHair, numHair * 5, false)
		akCaster.AddItem(ZarakiteHeart, numHeart * 5, false)
		akCaster.AddItem(ZarakiteSkin, numSkin * 5, false)
		akCaster.AddItem(ZarakiteTooth, numTooth * 5, false)

	Else
/;
	If numDetachables > 0
		akCaster.RemoveItem(ZarakiteDetachables, 1, false)

		AdvanceGameTimeSecondsDisplay(numSecondsToHarvestOne)

		akCaster.AddItem(ZarakiteBlood, numBlood, false)
		akCaster.AddItem(ZarakiteBones, numBones, false)
		akCaster.AddItem(ZarakiteCloth, numCloth, false)
		akCaster.AddItem(ZarakiteEyeball, numEyeball, false)
		akCaster.AddItem(ZarakiteFeathers, numFeathers, false)
		akCaster.AddItem(ZarakiteFlesh, numFlesh, false)
		akCaster.AddItem(ZarakiteHair, numHair, false)
		akCaster.AddItem(ZarakiteHeart, numHeart, false)
		akCaster.AddItem(ZarakiteSkin, numSkin, false)
		akCaster.AddItem(ZarakiteTooth, numTooth, false)

	EndIf
EndEvent
