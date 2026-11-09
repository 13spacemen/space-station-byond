proc/AISave()
	var/savefile/S = new("AI.sav")
	S["AIResponseCounter"]<<AIResponseCounter
	for(var/AI/Response/A)
		S.cd=A.ID
		S["Name"]<<A.name
		S["Created"]<<A.created
		S["Right"]<<A.right
		S["Wrong"]<<A.wrong
		S["Points"]<<A.points
		S["Owner"]<<A.owner
		S["Keywords"]<<A.keywords
		S["Variables"]<<A.variables
		S["ResponseTXT"]<<A.responsetxt
		S["ResponseAction"]<<A.responseaction

proc/AIDeleteSave()
	fdel("AI.sav")

proc/AIClearAll()
	AIDeleteLibrary()
	AIDeleteSave()

proc/AIDeleteLibrary()
	for(var/AI/A) del A

proc/AIRenewSave()
	AISave()
	AIDeleteLibrary()
	AILoad()
	AIDeleteSave()
	AISave()

proc/AILoad()
	var/savefile/S = new("AI.sav")
	S["AIResponseCounter"]>>AIResponseCounter
	for(var/i=1,i<AIResponseCounter,i++)
		var/AI/Response/A=new
		S.cd=i
		S["Name"]>>A.name
		S["Created"]>>A.created
		S["Right"]>>A.right
		S["Wrong"]>>A.wrong
		S["Points"]>>A.points
		S["Owner"]>>A.owner
		S["Keywords"]>>A.keywords
		S["Variables"]>>A.variables
		S["ResponseTXT"]>>A.responsetxt
		S["ResponseAction"]>>A.responseaction
		AIResponseList+=A
/*
	var/name="Response"
	var/created=0
	var/right=0
	var/wrong=0
	var/points=0
	var/owner=""
	var/keywords[0]
	var/variables[0]
	var/responsetxt=""
	var/responseaction
	var/ID=1
*/

mob/verb/RenewSave()
	AIRenewSave()

mob/verb/Save()
	AISave()

mob/verb/Load()
	AILoad()

