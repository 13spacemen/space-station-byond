obj/Items/Tools
	icon='Tools.dmi'
	New()
		.=..()
		pixel_x=rand(-3,3)*rand(1,2)
		pixel_y=rand(-3,3)*rand(1,2)

	Wrench
		icon_state="Wrench"

	Screwdriver
		icon_state="Screwdriver"

	Welder
		icon_state="Welder"
		var/On=0

	Crowbar
		icon_state="Crowbar"

	Wirecutters
		icon_state="Wirecutters"

	Fireextinguisher
		icon_state="Fire Extinguisher"

	Analyzer
		icon_state="Analyzer"




obj/Items/Misc
	icon='Misc.dmi'
	FloorPanel
		icon_state="Floor Tile"
		name="Floor Panel"
		New()
			.=..()
			pixel_x=rand(-3,3)*rand(1,2)
			pixel_y=rand(-3,3)*rand(1,2)

turf/Floors/Floor/DblClick()
	if(get_dist(src,usr)<2)
		if(istype(src,/turf/Floors/Floor))
			if(!usr.ActiveHand&&istype(usr.RightHand,/obj/Items/Tools/Crowbar)||usr.ActiveHand&&istype(usr.LeftHand,/obj/Items/Tools/Crowbar))
				if(!Open)
					icon_state="Floor Open"
					for(var/obj/Machinery/AirSystems/Pipes/P in src)
						P.invisibility=0
						P.icon_state=P.BaseState
						P.layer=1
					var/obj/Items/Misc/FloorPanel/F=new
					F.loc=locate(x,y,z)
					world<<"[F], [F.x],[F.y]"
					Open=1
			if(!usr.ActiveHand&&istype(usr.RightHand,/obj/Items/Misc/FloorPanel)||usr.ActiveHand&&istype(usr.LeftHand,/obj/Items/Misc/FloorPanel))
				if(Open)
					icon_state="Floor"
					for(var/obj/Machinery/AirSystems/Pipes/P in src)
						P.invisibility=1
						P.icon_state=P.BaseState
						P.layer=6
					Open=0
					if(!usr.ActiveHand) del usr.RightHand
					if(usr.ActiveHand) del usr.LeftHand
					UpdateH(usr)

	..()