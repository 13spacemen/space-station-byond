obj/Doors
	icon='Doors.dmi'
	density=1
	Secured=1
	New()
		.=..()
		BaseIconState=icon_state
	var
		Required=0
		AutoOpen=TRUE
		BaseIconState
		Open=0
		IsDense=1
		Inverted=0
		Interacting=0


	Bumped(mob/Player/M)
		if(!istype(M,/mob/Player))return
		if(!AutoOpen) return
		if(Interacting) return
		if(!Required)
			Open()
			spawn(40) Close()
		..()

	New()
		if(Inverted)
			Inverted()
		..()

	proc
		Open()
			if(Interacting)return
			Open=1
			var/turf/T=locate(x,y,z)
			if(!T.Active&&istype(T,/turf/Floors))
				T.Active=1
				T.Inactive=0
				ActiveTurfList+=T
			if(dir==NORTH)T=locate(x,y+1,z)
			if(dir==EAST)T=locate(x+1,y,z)
			if(dir==WEST)T=locate(x-1,y,z)
			if(dir==SOUTH)T=locate(x,y-1,z)
			if(!T.Active&&istype(T,/turf/Floors))
				T.Inactive=0
				T.Active=1
				ActiveTurfList+=T
			if(dir==NORTH)T=locate(x,y-1,z)
			if(dir==EAST)T=locate(x-1,y,z)
			if(dir==WEST)T=locate(x+1,y,z)
			if(dir==SOUTH)T=locate(x,y+1,z)
			if(!T.Active&&istype(T,/turf/Floors))
				T.Inactive=0
				T.Active=1
				ActiveTurfList+=T
			Interacting=1
			flick("[BaseIconState] Opening",src)
			sleep(4)
			if(IsDense)density=0
			icon_state="[BaseIconState] Open"
			Interacting=0


		Close()
			if(Interacting)return
			Open=0
			Interacting=1
			flick("[BaseIconState] Closing",src)
			sleep(4)
			if(IsDense)density=1
			icon_state="[BaseIconState]"
			Interacting=0

	DblClick()
		if(Interacting) return
		if(get_dist(usr,src)>1) return
		if(Open) Close()
		else Open()

		..()

	proc/Inverted()
		var/icon/I=new(icon)
		if(dir==NORTH||dir==SOUTH)I.Flip(EAST)
		if(dir==EAST||dir==WEST)I.Flip(NORTH)
		icon=I




	Airlock
		icon='Doors ~ Airlock.dmi'
		icon_state="Airlock"

	EngineDoor
		icon_state="Engine Door"

	FakeWall
		icon_state="Wall Door"

	SideDoor

		GlassDoor

			name="Glass Door"
			icon_state="Glass Door"
			density=0
			IsDense=0
			Two/Inverted=1


		SecureDoor

			name="Secure Door"
			icon_state="Secure Door"
			density=0
			IsDense=0
			Two/Inverted=1

		AutoSecureDoor

			name="Secure Door"
			icon_state="Secure Door"
			density=0
			IsDense=0
			Two/Inverted=1