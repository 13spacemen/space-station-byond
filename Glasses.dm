obj/Items/Eyewear
	icon='Glasses.dmi'
	New()
		.=..()
		pixel_x=rand(-3,3)*rand(1,2)
		pixel_y=rand(-3,3)*rand(1,2)
	Perscription
		icon_state="Perscription"

	Sunglasses
		icon_state="Sunglasses"

	Messon
		icon_state="Messon"

	Thermal
		icon_state="Thermal"

	Blindfold
		icon_state="Blindfold"


	EquipSpot="Eyes"

mob/var/obj/Items/Eyewear/Glasses

mob/verb
	EquipGlasses()
		if(Glasses)
			if(!ActiveHand) if(!RightHand)
				RightHand=Glasses
				Glasses=null

			else if(!LeftHand)
				LeftHand=Glasses
				Glasses=null

		else
			if(!ActiveHand) if(RightHand)
				if(RightHand.EquipSpot=="Eyes")
					Glasses=RightHand
					RightHand=null

			else if(LeftHand)
				if(LeftHand.EquipSpot=="Eyes")
					Glasses=LeftHand
					LeftHand=null

		UpdateH(usr)

		usr.see_invisible=0
		usr.sight &= SEE_OBJS
		usr.sight &= BLIND
		usr.sight &= SEE_MOBS

		if(istype(Glasses,/obj/Items/Eyewear/Messon))
			usr.see_invisible=1
			usr.sight|=SEE_OBJS

		if(istype(Glasses,/obj/Items/Eyewear/Thermal))
			usr.sight |= SEE_MOBS

		if(istype(Glasses,/obj/Items/Eyewear/Blindfold))
			usr.sight|= BLIND