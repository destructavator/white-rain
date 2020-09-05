Scriptname ZarakiteConstructorPlacement extends ObjectReference

GlobalVariable Property GameHour auto

Form Property requiredThing1 auto
Form Property requiredThing2 auto
Form Property requiredThing3 auto
Form Property requiredThing4 auto
Form Property requiredThing5 auto
Form Property requiredThing6 auto
Form Property requiredThing7 auto
Form Property requiredThing8 auto

int Property requiredCount1 auto
int Property requiredCount2 auto
int Property requiredCount3 auto
int Property requiredCount4 auto
int Property requiredCount5 auto
int Property requiredCount6 auto
int Property requiredCount7 auto
int Property requiredCount8 auto

float Property hoursToInstall1 auto
float Property hoursToInstall2 auto
float Property hoursToInstall3 auto
float Property hoursToInstall4 auto
float Property hoursToInstall5 auto
float Property hoursToInstall6 auto
float Property hoursToInstall7 auto
float Property hoursToInstall8 auto

FormList Property list1 auto
FormList Property list2 auto
FormList Property list3 auto
FormList Property list4 auto
FormList Property list5 auto
FormList Property list6 auto
FormList Property list7 auto
FormList Property list8 auto

Message Property MessageToDisplay auto
int Property NumChoices auto

Event OnActivate(ObjectReference akActionRef)
	Actor player = Game.GetPlayer()

	int iButton = ZarakiteMakeMilkMessage.Show()
	
	If iButton == 1
		int items = player.GetNumberItems()		
	EndIf
EndEvent
