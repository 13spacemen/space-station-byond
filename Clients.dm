client
	view=8
	perspective=EDGE_PERSPECTIVE


	Northeast() return

	Northwest() return

	Southeast() return

	Southwest() return

	Move(locc,dirr)
		if(mob.MoveDelay) return
		if(!mob.Movement) return
		mob.MoveDelay++
		spawn(5/mob.Movement) mob.MoveDelay--
		mob.OLOC=mob.loc
		.=..()
		if(mob.Pulling&&.)
			if(mob.Pulling.Secured)
				mob.Pulling.Pulled=0
				usr<<output("\[[Timestamp()]\]<font color=blue>*No Longer Pulling [mob.Pulling]*","System")
				mob.Pulling=0
				return
			if(!mob.Pulling.Pulled)
				mob.Pulling.Pulled=0
				usr<<output("\[[Timestamp()]\]<font color=blue>*No Longer Pulling [mob.Pulling]*","System")
				mob.Pulling=0
				return
			if(!istype(mob.Pulling.loc,/turf))
				mob.Pulling.Pulled=0
				usr<<output("\[[Timestamp()]\]<font color=blue>*No Longer Pulling [mob.Pulling]*","System")
				mob.Pulling=0
				return
			if(get_dist(mob.Pulling,mob.OLOC)<2)
				var/OldDir=mob.Pulling.dir
				if(!mob.PullType)spawn()step(mob.Pulling,get_dir(mob.Pulling,mob.OLOC))
				else step(mob.Pulling,get_dir(mob.Pulling,mob.loc))
				mob.Pulling.dir=OldDir
			else
				mob.Pulling.Pulled=0
				usr<<output("\[[Timestamp()]\]<font color=blue>*No Longer Pulling [mob.Pulling]*","System")
				mob.Pulling=0