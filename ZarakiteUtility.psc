Scriptname ZarakiteUtility extends ActiveMagicEffect

GlobalVariable Property GameHour auto
GlobalVariable Property GameDaysPassed auto
GlobalVariable Property GameDay auto
GlobalVariable Property GameMonth auto
GlobalVariable Property GameYear auto

GlobalVariable Property ZarakiteMilkDaysPassed auto
GlobalVariable Property ZarakiteLastFamilyDay auto

float numTimesCanEjaculateMilkDaily = 100.0

Function AdvanceGameTime(float hoursToPass)
;	float t = GameHour.GetValue()
;	GameHour.SetValue(t + hoursToPass)
	GameHour.Mod(hoursToPass)
EndFunction

Function AdvanceGameTimeDisplay(float hoursToPass)
	float timeMinutesF = hoursToPass * 60.0
	int timeMinutes = timeMinutesF as int
	If timeMinutes > 0
		Debug.Notification(timeMinutes + " minutes have passed.")
	EndIf

	GameHour.Mod(hoursToPass)
EndFunction

Function AdvanceGameTimeMinutesDisplay(float minutesToPass)
	int timeMinutes = minutesToPass as int
	If timeMinutes > 0
		Debug.Notification(timeMinutes + " minutes have passed.")
	EndIf

	GameHour.Mod(minutesToPass / 60.0)
EndFunction

Function AdvanceGameTimeSecondsDisplay(float secondsToPass)
	float timeMinutesF = secondsToPass / 60.0
	int timeMinutes = timeMinutesF as int
	If timeMinutes > 0
		Debug.Notification(timeMinutes + " minutes have passed.")
	EndIf

	GameHour.Mod(secondsToPass / 3600.0)
EndFunction

string Function GetHealthMagicPointValueName()
	string t = "Magicka"

	Return t
EndFunction

int Function GetMaxMilking()
	float d = GameDaysPassed.GetValue()
	float m = ZarakiteMilkDaysPassed.GetValue()
	float rF = d - m

	If rF > 1.0
		float t = rF - 1.0
		ZarakiteMilkDaysPassed.Mod(t)

		rF = 1.0
	EndIf

	rF *= numTimesCanEjaculateMilkDaily
	int r = rF as int

	If r < 0
		r = 0
	EndIf

	return r
EndFunction

Function UpdateMilkingCount(int c)
	float f = c as float
	f /= numTimesCanEjaculateMilkDaily
	ZarakiteMilkDaysPassed.Mod(f)
EndFunction

bool Function IsSameDayAsLastFamilySupport()
	bool r = false

	int d = GameDaysPassed.GetValue() as int
	int s = ZarakiteLastFamilyDay.GetValue() as int

	If d == s
		r = true
	EndIf

	return r
EndFunction

Function UpdateLastFamilySupportDay()
	int d = GameDaysPassed.GetValue() as int
	int s = ZarakiteLastFamilyDay.GetValue() as int

	int diff = d - s
	float diffF = diff as float

	If diff != 0
		ZarakiteLastFamilyDay.Mod(diffF)
	EndIf
EndFunction
