atom/movable
	var/Weight=175
	var/ForcedMove=0
	var/Secured=0

atom/var/BaseState



mob
	icon='Mobs.dmi'
	icon_state="Male"
	var
		obj/ID
		Movement=2
		MoveDelay=0

turf/Floors/DblClick()
	if(usr.Pulling)
		if(get_dist(usr,usr.Pulling)<2)
			var/tmp/odir=usr.Pulling.dir
			step(usr.Pulling,get_dir(usr.Pulling,src))
			usr.Pulling.dir=odir
		else
			usr.Pulling.Pulled=0
			usr<<output("\[[Timestamp()]\]<font color=blue>*No Longer Pulling [usr.Pulling]*","System")
			usr.Pulling=0

	..()

mob
	var
		atom/Interacting
		atom/movable/Pulling
		OLOC
		PullType=0

atom/movable
	var
		Pulled=0


atom/movable
	MouseDrop(atom/movable/Dropped,Over,src_control="Map",over_control="Map")
		if(!Secured)
			if(Dropped==usr)
				usr.Pulling=src
				src.Pulled=1
				usr<<output("\[[Timestamp()]\]<font color=blue>*Pulling [usr.Pulling]*","System")
	//	world<<"[usr], [Dropped], [Over]"


