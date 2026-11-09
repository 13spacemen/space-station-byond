AI/Generator
	proc/Generate(Text)
		KeyWords=Parse(Text)

		if(Step=="Verify") goto Verify
		if(Step=="Verify2") goto Verify2
		if(Step=="Verify3") goto Verify3
		if(Step=="Verify4") goto Verify4

		Results.len=0
		for(var/O in KeyWords)
			for(var/AI/Response/R)
				if(R.keywords.Find(O))
					if(!R.points)Results+=R
					R.points+=R.keywords[O]
		FilterTop(Results)
		Retry
		Counter2=0
		for(var/AI/Response/Result in Results)
			Owner<<"[Result.responsetxt]"
			if(Result.responseaction) Step=Result.responseaction
			Counter2++

		if(Verify)
			OldKeyWords=KeyWords.Copy()
			if(Counter2)
				Owner<<"Was this the correct result?"
				if(Step)Step2=Step
				OldKeyWords=KeyWords.Copy()
				Step="Verify"

			else
				if(!Counter)Owner<<"I'm sorry, there is no recorded response for your keywords."
				else Owner<<"I'm sorry, there are no more recorded responses for your keywords."
				Owner<<"Would you like to add an appropriate response?"
				Step="Verify3"

		goto End
		Verify
		for(var/O in KeyWords)
			if(O=="yes")
				Owner<<"Confirmed"
				Incorrect.len=0
				Counter=0
				for(var/AI/Response/R in Results)
					R.right++
					for(var/OL in OldKeyWords)
						if(R.keywords[OL]) R.keywords[OL]=R.keywords[OL]+1
						else R.keywords[OL]=1
				Step=""
				break
			if(O=="no")
				for(var/AI/Response/R in Results)
					R.wrong++
					Incorrect+=R
					for(var/OL in OldKeyWords)
						if(R.keywords[OL]>1) R.keywords[OL]=R.keywords[OL]-1
						else R.keywords[OL]=1
				if(Counter<3)
					Owner<<"Would you like me to try again?"
					Step="Verify2"
				else
					Owner<<"Would you like to add an appropriate response?"
					Step="Verify3"
					Counter=0
				break
		goto End

		Verify2
		for(var/O in KeyWords)
			if(O=="no")
				Owner<<"Would you like to add an appropriate response?"
				Step="Verify3"
				Counter=0
				break
			if(O=="yes")
				goto Verify2Step2
		goto End
		Verify2Step2
		Counter+=1
		Results.len=0
		KeyWords=OldKeyWords.Copy()
		for(var/O in KeyWords)
			for(var/AI/Response/R)
				if(R.keywords.Find(O))
					if(!R.points)Results+=R
					R.points+=R.keywords[O]
		FilterTop(Results)
		goto Retry

		Verify3
		for(var/O in KeyWords)
			if(O=="no")
				Owner<<"Understood. No action is being taken."
				Step=""
				Incorrect.len=0
				break
			if(O=="yes")
				Owner<<"Please say an appropriate resposne."
				Step="Verify4"
				break
		goto End
		Verify4
		temp=""
		for(var/O in KeyWords) temp="[temp][O]"
		temp=ckey(temp)
		for(var/AI/Response/R)
			if(ckey(R.responsetxt)==temp)
				Owner<<"Duplicate found"
				for(var/O in KeyWords)
					if(R.keywords[O])R.keywords[O]=R.keywords[O]+1
					else R.keywords[O]=1
				break
		if(Step!="")
			var/AI/Response/X=new
			X.responsetxt=Text
			X.owner=Owner
			X.created=world.realtime
			for(var/O in OldKeyWords)
				X.keywords[O]=1
			AIResponseList+=X
			X.ID=AIResponseCounter
			AIResponseCounter++
			Owner<<"New Response Created By [Owner]"
			Owner<<"Response: [X.responsetxt]"
			Owner<<"Keywords: [list2params(X.keywords)]"
		Incorrect.len=0
		Step=""
		End