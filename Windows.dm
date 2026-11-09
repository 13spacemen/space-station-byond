obj
	Windows
		var/HP=5
		name="Window"
		icon='Windows.dmi'
		icon_state="Window"
		Window
			Secured=1

		WindowFull
			HP=12
			density=1
			Secured=1
			icon_state="Window Full"

		Click(a,b,params)
			if(findtext(params,"right=1")) if(get_dist(src,usr)<2) if(istype(src,/obj/Windows))
				var/atom/Hand
				if(!usr.ActiveHand)Hand=usr.RightHand
				else Hand=usr.LeftHand

				if(istype(Hand,/obj/Items/Tools/Screwdriver))
					if(Secured)
						viewers()<<"<font color=green><b>[usr] has unfastened [src]!"
						Secured=0
					else
						viewers()<<"<font color=green><b>[usr] has fastened [src]!"
						Secured=1
				else

					if(istype(Hand,/obj/Items/Tools))
						viewers()<<"<font color=red><b>[usr] has hit [src] with \an [Hand]!"
						HP-=2

					if(!Hand)
						viewers()<<"<font color=red><b>[usr] has punched [src]!"
						HP-=1

				WindowDeathCheck()




			..()



		proc
			WindowDeathCheck()
				if(HP<1)
					var/Quantity=3
					if(istype(src,/obj/Windows/WindowFull)) Quantity=6
					while(Quantity>0)
						var/i=rand(1,3)
						if(i==3) if(Quantity>=3)
							var/obj/Items/Other/WindowShard/Large/L=new
							Quantity-=3
							L.loc=loc
						if(i==2) if(Quantity>=2)
							var/obj/Items/Other/WindowShard/Medium/M=new
							Quantity-=2
							M.loc=loc
						if(i==1) if(Quantity>=1)
							var/obj/Items/Other/WindowShard/Small/S=new
							Quantity-=1
							S.loc=loc

					var/turf/T=locate(x,y,z)
					if(!T.Active&&istype(T,/turf/Floors))
						ActiveTurfList+=T
						T.Active=1
					if(!istype(src,/obj/Windows/WindowFull))
						if(dir==NORTH)T=locate(x,y+1,z)
						if(dir==EAST)T=locate(x+1,y,z)
						if(dir==WEST)T=locate(x-1,y,z)
						if(dir==SOUTH)T=locate(x,y-1,z)
						if(!T.Active&&istype(T,/turf/Floors))
							ActiveTurfList+=T
							T.Active=1

					del src

obj/Items/Other
	WindowShard
		name="Shard"
		icon='Misc.dmi'
		icon_state="Window Shard"
		Large

		Medium
			icon_state="Window Shard M"

		Small
			icon_state="Window Shard S"




turf/Enter(atom/movable/E)
	if(E.density!=0||istype(E,/obj/Windows)) for(var/obj/O in src)
		if(istype(O,/obj/Doors/SideDoor))
			if(!O:Open) goto Go
		if(!istype(O,/obj/Windows/Window)) goto Next
		Go
		if(get_dir(E,src)==EAST||get_dir(E,src)==SOUTHEAST||get_dir(E,src)==NORTHEAST) if(O.dir==WEST)
			O.Bumped(E)
			return 0
		if(get_dir(E,src)==NORTH||get_dir(E,src)==NORTHEAST||get_dir(E,src)==NORTHWEST) if(O.dir==SOUTH)
			O.Bumped(E)
			return 0
		if(get_dir(E,src)==WEST||get_dir(E,src)==SOUTHWEST||get_dir(E,src)==NORTHWEST) if(O.dir==EAST)
			O.Bumped(E)
			return 0
		if(get_dir(E,src)==SOUTH||get_dir(E,src)==SOUTHEAST||get_dir(E,src)==SOUTHWEST) if(O.dir==NORTH)
			O.Bumped(E)
			return 0

		Next

	.=..()



turf/Exit(atom/movable/E)
	if(E.density!=0||istype(E,/obj/Windows)) for(var/obj/O in src)
		if(istype(O,/obj/Doors/SideDoor))
			if(!O:Open) goto Go
		if(!istype(O,/obj/Windows/Window)) goto Next
		Go
		if(E.dir==WEST||E.dir==SOUTHWEST||E.dir==NORTHWEST) if(O.dir==WEST)
			O.Bumped(E)
			return 0
		if(E.dir==SOUTH||E.dir==SOUTHEAST||E.dir==SOUTHWEST) if(O.dir==SOUTH)
			O.Bumped(E)
			return 0
		if(E.dir==EAST||E.dir==SOUTHEAST||E.dir==NORTHEAST) if(O.dir==EAST)
			O.Bumped(E)
			return 0
		if(E.dir==NORTH||E.dir==NORTHEAST||E.dir==NORTHWEST) if(O.dir==NORTH)
			O.Bumped(E)
			return 0

		Next
	.=..()



//||istype(O,/obj/Doors/SecureDoor)||istype(O,/obj/Doors/GlassDoor)||istype(O,/obj/Doors/AutoSecureDoor)
