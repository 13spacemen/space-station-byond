world/mob=/mob/Player

mob/Player
	icon_state="Male"
	Login()
		sleep(0)
		for(var/obj/System/Markers/Login/X)
			loc=X.loc
		..()
		System("[usr.key] has logged in!","<b><u>")

	Logout()
		System("[usr.key] has logged out!","<b><u>")
		..()

	verb
		Say(t as text)
			world<<"[usr]: [t]"





/*	Stat()
		statpanel("Info")
		stat("[usr]")
//		stat("[world.cpu]")
		var/turf/T=locate(x,y,z)
		if(T)
			stat("[T]: ","")
			stat("[x],[y].[z]")
			stat("Nitrogen",T.N2)
			stat("Oxygen",T.O2)
			stat("Argon",T.Ar)
			stat("Carbon Dioxide",T.CO2)
			stat("Neon",T.Ne)
			stat("Helium",T.He)
			stat("Methane",T.CH4)
			stat("Krypton",T.Kr)
			stat("Hydrogen",T.H2)
			stat("Nitrous Oxide",T.N2O)
			stat("Carbon Monoxide",T.CO)*/



/*
						//Gas				%Earth Atmos		Notes
		N2=78084		//Nitrogen			78.084%				Colorless, odorless, tasteless, inert
		O2=20946		//Oxygen			20.946% 			Colorless, odorless, tasteless
		Ar=9340			//Argon				0.9340%				Colorless, odorless, tasteless, nontoxic, inert, stops fire
		CO2=383			//Carbon dioxide	0.0383%				Colorless, odorless
		//Large amounts taste sour cause stinging in nose and throat, over 15x normal unhealthy over 150x normal dangerous
		Ne=18			//Neon				0.001818%
		He=5			//Helium			0
		CH4=1			//Methane			0
		Kr=1			//Krypton			0
		H2=1			//Hydrogen			0
		N2O=0			//Nitrous Oxide		0
		CO=0			//Carbon Monoxide	0
*/

	verb

		RandomGases()
			for(var/turf/Floors/T)
				T.O2+=rand(0,1000)
				T.CO2+=rand(0,1000)
				T.N2+=rand(0,1000)
				T.Ar+=rand(000,1000)
				T.Ne+=rand(000,1000)
				T.He+=rand(000,1000)
				T.CH4+=rand(000,1000)
				T.Kr+=rand(000,1000)
				T.H2+=rand(000,1000)
				T.N2O+=rand(000,1000)
				T.CO+=rand(000,1000)

		TogglePullType()
			PullType=!PullType

		IntentGrab()

		IntentDisarm()

		IntentHelp()

		IntentHarm()

		ToggleXfer()
			set hidden=1
			if(Interacting)
				if(istype(Interacting,/obj/Machinery/AirSystems/))
					if(Interacting:Transfer!=-1) Interacting:Transfer=!Interacting:Transfer

		XferUp()
			set hidden=1
			if(Interacting)
				if(istype(Interacting,/obj/Machinery/AirSystems/))

					if(Interacting:Transfer!=-1)
						Interacting:TransferR++
						if(Interacting:TransferR>10) Interacting:TransferR=10

		XferDown()
			set hidden=1
			if(Interacting)
				if(istype(Interacting,/obj/Machinery/AirSystems/))

					if(Interacting:Transfer!=-1)
						Interacting:TransferR--
						if(Interacting:TransferR<1) Interacting:TransferR=1










