mob/var/AI/Generator/G
var/AIResponseList[0]
var/AISavedList[0]
var/AIResponseCounter=1

AI/Generator
	var
		KeyWords[0]
		Incorrect[0]
		OldKeyWords[0]
		Step=""
		Step2=""
		Filter[0]
		Results[0]
		temp=""
		Counter=0
		Counter2=0
		Verify=1
		mob/Owner

AI/Response
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

mob/verb/AISay(t as text)
	set hidden=1
	if(!G)
		G=new
		G.Owner=usr
	G.Generate(t)

mob/verb/Test()
	for(var/AI/A) usr<<"[A]"

mob/verb/Createresponse(t as text,k as text)
	var/AI/Response/X=new
	X.responsetxt=t
	X.keywords=new
	X.ID=AIResponseCounter
	for(var/O in Parse(k))
		X.keywords+=O
		X.keywords[O]=1
	usr<<"Created [X], [X.responsetxt]"
	for(var/i in X.keywords)
		usr<<"[i], <xmp>"
	usr<<""
	AIResponseList+=X
	AIResponseCounter++