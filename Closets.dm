atom/movable/var/Closetable=1
obj/Closets
	icon='Closets.dmi'
	density=1
	name="Closet"
	Secured=0


	DblClick()
		if(istype(src,/obj/Closets))
			if(get_dist(usr,src)>1) return
			if(!Open)
				Open()
			else
				Close()

	New()
		.=..()
		spawn(1)ClosedState=icon_state

	proc
		Open()
			icon_state=OpenState
			for(var/atom/movable/A in src)
				A.loc=loc
			Open=1
			density=0

		Close()
			icon_state=ClosedState
			for(var/atom/movable/A in locate(x,y,z))
				if(A==src)continue
				if(A.Secured)continue
				if(!A.Closetable)continue
				A.loc=src
			Open=0
			density=1
	var
		ClosedState=""
		OpenState="Closet Open"
		Open=0

	Closetable=0

	Closet
		icon_state="Closet"
	RedCloset
		icon_state="Red Closet"

	Wardrobes
		name="Wardrobe"
		icon_state="Red Closet"

		Blue
			icon_state="Wardrobe Blue"

		Yellow
			icon_state="Wardrobe Yellow"

		Orange
			icon_state="Wardrobe Orange"

		Red
			icon_state="Wardrobe Red"

		Green
			icon_state="Wardrobe Green"

		Pink
			icon_state="Wardrobe Pink"



		Black
			icon_state="Wardrobe Black"
