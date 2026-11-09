proc/Parse(t as text)
	var/temp
	var/i=0
	var/Results[0]
	t=lowertext(t)
//	world<<t
	for(i=1,i<=lentext(t),i++)
		temp=copytext(t,i,i+1)
		if(cmptext(temp," ")||i==lentext(t))
			temp=copytext(t,1,i+1)
			t=copytext(t,i)
			Results+=ckey(temp)
			i=1
	return Results

