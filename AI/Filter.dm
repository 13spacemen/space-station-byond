AI/Generator/proc/FilterTop(list/L)
	Filter=Results.Copy()
	Results.len=0
	for(var/AI/Response/R in Filter)
		if(Incorrect.Find(R))
			Filter-=R
			R.points=0
			continue
		for(var/AI/Response/O in Filter)
			if(R==O)continue
			if(Incorrect.Find(O))
				Filter-=O
				O.points=0
				continue
			if(R.points>O.points)
				Filter-=O
				O.points=0
				continue
			if(O.points>R.points)
				Filter-=R
				R.points=0
				continue
	for(var/AI/Response/Result in Filter)
		Results+=Result
		break
	for(var/AI/Response/Result in Filter)
		Result.points=0
	Filter.len=0
