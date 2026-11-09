mob/var/obj/Items/Radios/Headset
obj/Items/Radios
	icon='Radios.dmi'
	var/Freq=1
	Headsets
		EquipSpot="Headset"
		Headset
			icon_state="Headset"



mob/verb
	EquipHeadset()
		if(Headset)
			if(!ActiveHand) if(!RightHand)
				RightHand=Headset
				Headset=null

			else if(!LeftHand)
				LeftHand=Headset
				Headset=null

		else
			if(!ActiveHand) if(RightHand)
				if(RightHand.EquipSpot=="Headset")
					Headset=RightHand
					RightHand=null

			else if(LeftHand)
				if(LeftHand.EquipSpot=="Headset")
					Headset=LeftHand
					LeftHand=null

		UpdateH(usr)
