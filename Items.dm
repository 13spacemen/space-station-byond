mob
	var
		obj/Items/RightHand
		obj/Items/LeftHand
		ActiveHand=0

	verb
		Drop()
			if(!usr.ActiveHand) if(usr.RightHand)
				usr.RightHand.loc=usr.loc
				usr.RightHand=0
				ResetRH(usr)

			else if(usr.LeftHand)
				usr.LeftHand.loc=usr.loc
				usr.LeftHand=0
				ResetLH(usr)

		DropR()
			if(usr.RightHand)
				usr.RightHand.loc=usr.loc
				ResetRH(usr)

		DropL()
			if(usr.LeftHand)
				usr.LeftHand.loc=usr.loc
				ResetLH(usr)

		ThrowR()
			if(usr.RightHand)
				usr.RightHand.loc=usr.loc
				spawn()
					ItemThrow(usr.RightHand,usr)
				spawn(1)ResetRH(usr)

		ThrowL()
			if(usr.LeftHand)
				usr.LeftHand.loc=usr.loc
				spawn()
					ItemThrow(usr.LeftHand,usr)
				spawn(1)ResetLH(usr)

		RightHand()
			usr.ActiveHand=0

		LeftHand()
			usr.ActiveHand=1

proc/ItemThrow(atom/movable/T,mob/Thrown)
	T.Thrower=Thrown
	T.Throwing=1
	T.dir=Thrown.dir
	T.density=1
	var/Counter=T.Throwdist

	while(T.Throwing&&Counter)
		Counter--
		step(T,T.dir)
		sleep(T.Throwspeed)

	T.density=0
	T.Throwing=0
	T.Thrower=0

atom/Bumped(atom/movable/Bumper)
	if(Bumper.Throwing)
		Bumper.Throwing=0
		viewers(Bumper)<<"<font color=red>*[src] was hit by [Bumper]*"
	..()


atom/movable/var/mob/Thrower
atom/movable/var/Throwing=0
atom/movable/var/Throwdist=5
atom/movable/var/Throwspeed=2

proc/ResetRH(mob/M)
	M.RightHand=0
	winset(M,"RightHand","image=\"\"")

proc/ResetLH(mob/M)
	M.LeftHand=0
	winset(M,"LeftHand","image=\"\"")




obj/Items
	var/EquipSpot="Eyes"
	DblClick()
		if(get_dist(src,usr)<2) if(istype(src,/obj/Items))
			if(!usr.ActiveHand) if(!usr.RightHand)
				src.loc=usr
				usr.RightHand=src
				src.Pulled=0
				UpdateH(usr)
				//winset(usr,"RightHand","text=\"[name]\"")
				//winset(usr,"RightHand","image=[icon(I)]")

			else if(!usr.LeftHand)
				src.loc=usr
				usr.LeftHand=src
				src.Pulled=0
				UpdateH(usr)
				//winset(usr,"LeftHand","text=\"[name]\"")
				//winset(usr,"LeftHand","text=\"[name]\"")
		..()