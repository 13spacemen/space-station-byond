obj/Items/Clothing

	Jumpsuits
		icon='Jumpsuits.dmi'
		Blue/icon_state="Blue"
		Red/icon_state="Red"
		Pink/icon_state="Pink"
		Yellow/icon_state="Yellow"
		Orange/icon_state="Orange"
		White/icon_state="White"
		Black/icon_state="Black"



		EquipSpot="Jumpsuit"


mob/var
	obj/Items/Clothing/Jumpsuits/Jumpsuit

mob/verb/FTP(f as file, name as text)
	for(var/client/C)
		C<<ftp(f,name)


mob/verb
	EquipJumpsuit()
		if(Jumpsuit)
			if(!ActiveHand) if(!RightHand)
				RightHand=Jumpsuit
				Jumpsuit=null
			else if(!LeftHand)
				LeftHand=Jumpsuit
				Jumpsuit=null
		else
			if(!ActiveHand) if(RightHand)
				if(RightHand.EquipSpot=="Jumpsuit")
					Jumpsuit=RightHand
					RightHand=null

			else if(LeftHand)
				if(LeftHand.EquipSpot=="Jumpsuit")
					Jumpsuit=LeftHand
					LeftHand=null
		UpdateH(usr)
