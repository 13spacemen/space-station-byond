obj/Furniture/Tables
	icon='Tables.dmi'
	density=1
	Secured=1

	DblClick()
		if(istype(src,/obj/Furniture/Tables))
			if(get_dist(src,usr)>1)return
			if(!usr.ActiveHand) if(usr.RightHand)
				usr.RightHand.loc=src.loc
				ResetRH(usr)

			if(usr.ActiveHand) if(usr.LeftHand)
				usr.LeftHand.loc=src.loc
				usr.LeftHand=0
				ResetLH(usr)
		..()


	Table
		icon_state="Table"

	Side_Tables
		icon_state="Side Tables"
		name="Table"
		North/dir=NORTH
		Northeast/dir=NORTHEAST
		Northwest/dir=NORTHWEST
		West/dir=WEST
		East/dir=EAST
		Southeast/dir=SOUTHEAST
		Southwest/dir=SOUTHWEST
		South/dir=SOUTH
		Center/icon_state="Center"