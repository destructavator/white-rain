Scriptname ZarakiteMakePotionNoGloves extends ZarakiteUtility; ActiveMagicEffect

Import ZarakiteUtility

Potion Property potionToAdd auto

Message Property ZarakiteMakeMilkMessage auto

int Property numPotionsBase auto

float Property amountHealthToReduceBase auto

float Property hoursToMakeBase auto

;/
GlobalVariable Property GameHour auto
Function AdvanceGameTime(float hoursToPass)
	float t = GameHour.GetValue()
	GameHour.SetValue(t + hoursToPass)
EndFunction
/;

Event OnEffectStart(Actor akTarget, Actor akCaster)
	float amountHealthToReduce = 0.0
	float hoursToMake = 0.0
	int numPotions = 0

	int m = GetMaxMilking()
	Debug.Notification("You can make up to " + m + " units right now.")

	int iButton = ZarakiteMakeMilkMessage.Show()

	If iButton == 1
		amountHealthToReduce = amountHealthToReduceBase * 5.0
		hoursToMake = hoursToMakeBase * 0.22
		numPotions = numPotionsBase * 5
	ElseIf iButton == 2
		amountHealthToReduce = amountHealthToReduceBase * 10.0
		hoursToMake = hoursToMakeBase * 0.37
		numPotions = numPotionsBase * 10
	ElseIf iButton == 3
		amountHealthToReduce = amountHealthToReduceBase * 20.0
		hoursToMake = hoursToMakeBase * 0.67
		numPotions = numPotionsBase * 20
	ElseIf iButton == 4
		amountHealthToReduce = amountHealthToReduceBase * 30.0
		hoursToMake = hoursToMakeBase * 0.97
		numPotions = numPotionsBase * 30
	ElseIf iButton == 5
		amountHealthToReduce = amountHealthToReduceBase * 40.0
		hoursToMake = hoursToMakeBase * 1.27
		numPotions = numPotionsBase * 40
	ElseIf iButton == 6
		amountHealthToReduce = amountHealthToReduceBase * 50.0
		hoursToMake = hoursToMakeBase * 1.57
		numPotions = numPotionsBase * 50
	EndIf

	float h = akCaster.GetActorValue(GetHealthMagicPointValueName())

	If numPotions <= m
		If h > amountHealthToReduce
			AdvanceGameTime(hoursToMake)
			akCaster.DamageActorValue(GetHealthMagicPointValueName(), amountHealthToReduce)
			akCaster.AddItem(potionToAdd, numPotions, false)

			UpdateMilkingCount(numPotions)

		;	int minutesPassed = (hoursToMake * 60.0) as int
			If numPotions > 0
				Debug.Notification("Time has passed.")
			EndIf
		Else
			Debug.MessageBox("You don't have enough health right now.")
		EndIf
	Else
		Debug.MessageBox("You have to wait to make that much again.")
	EndIf
EndEvent
