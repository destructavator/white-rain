Scriptname ZarakiteApiary extends ObjectReference

float oldGameDays
GlobalVariable Property GameDaysPassed auto

Potion Property FoodHoney auto

int messageCount

Event OnActivate(ObjectReference akActionRef)
	float t = GameDaysPassed.GetValue()
	float d = t - oldGameDays

	If d >= 1.0
		oldGameDays = t

		Game.GetPlayer().AddItem(FoodHoney, 1, false)

		messageCount = 0
	Else
		If messageCount == 0
			Debug.Notification("You'll have to wait before you can get more honey from this apiary.")
			messageCount += 1
		ElseIf messageCount == 1
			Debug.Notification("You'll have to wait before you can get more honey from this apiary.")
			messageCount += 1
		ElseIf messageCount == 2
			Debug.Notification("You'll have to wait before you can get more honey from this apiary.")
			messageCount += 1
		ElseIf messageCount == 3
			Debug.Notification("LIKE I SAID, you'll have to wait before you can get more honey from this apiary.")
			messageCount += 1
		ElseIf messageCount >= 4
			Debug.Notification("HEY!  Chill out.  WAIT.  It takes a whole 24 hours each time.")
		EndIf
	EndIf
EndEvent
