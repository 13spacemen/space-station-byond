obj/Machinery/AirSystems
	icon='Air System.dmi'
	Secured=1
	density=1
	DblClick()
		if(istype(src,/obj/Machinery/AirSystems))
			if(src.Interface&&get_dist(usr,src<=1)) if(usr.x==src.x||usr.y==src.y)
				if(src.InterfaceDir) if(usr.loc!=get_step(usr,src.Direction)) goto False
				goto True
		goto False
		True
		usr.Interacting=src
		False

		..()
/*
		if(istype(src,/obj/Machinery/AirSystems))
			if(!usr.ActiveHand&&istype(usr.RightHand,/obj/Items/Tools/Analyzer)||usr.ActiveHand&&istype(usr.LeftHand,/obj/Items/Tools/Analyzer)) goto True
			if(istype(src,/obj/Machinery/AirSystems/StorageTank/)||istype(src,/obj/Machinery/AirSystems/Siphons)||istype(src,/obj/Machinery/AirSystems/ACSystems)) goto True
			goto False
			True
			if(get_dist(usr,src)<=1) if(usr.x==src.x||usr.y==src.y)
				if(istype(src,/obj/Machinery/AirSystems/Siphons)||istype(src,/obj/Machinery/AirSystems/ACSystems))
					if(src.loc!=get_step(usr,src.dir)) goto False
				usr.Interacting=src
			False*/

	StorageTank
		name="Storage Tank"
		icon_state="Storage Tank"
		Capacity=10000000
		Full
			N2=780840
			O2=209460
			Ar=93400
			CO2=3830
			Ne=180
			He=50
			CH4=10
			Kr=10
			H2=10

	Siphons
		icon_state="Siphon"
		Siphon
		TransferR=1
		Transfer=1
		Capacity=2000000

		Portable
			Secured=0
			icon_state="Portable Siphon"

	ACSystems     //Air Circulation System
		desc="Air-Circulation System"
		ACSystem
		Capacity=2000000
		icon_state="AC"
		TransferR=1
		Transfer=1

		Portable
			Secured=0
			icon_state="Portable AC"

	var
		Interface=0     //Toggles if the machine can be 'interacted' with
		InterfaceDir=0	//Toggles if user must be in front of device to interact
		Direction=NORTH	//Direction to interface facing (NORTH means user must be below object, EAST means user must be left of object)
		Capacity=10 //contents capacity
		Pressure=0
		TransferR=0 //siphon/vent transfer rates
		Transfer=-1
		XfR[] //filter transfer rates

		N2=0		//Nitrogen			78.084%				Colorless, odorless, tasteless, inert
		O2=0		//Oxygen			20.946% 			Colorless, odorless, tasteless
		Ar=0			//Argon				0.9340%				Colorless, odorless, tasteless, nontoxic, inert, stops fire
		CO2=0			//Carbon dioxide	0.0383%				Colorless, odorless
		//Large amounts sour cause stinging in nose and throat, over 15x normal unhealthy over 150x normal dangerous
		Ne=0			//Neon				0.001818%
		He=0			//Helium			0
		CH4=0			//Methane			0				Highly flammable, may form explosive mixtures with air
		Kr=0			//Krypton			0
		H2=0			//Hydrogen			0
//		H2O=10			//Water Vapor		0
		N2O=0			//Nitrous Oxide		0
		CO=0			//Carbon Monoxide	0


/*

		N2=78084		//Nitrogen			78.084%				Colorless, odorless, tasteless, inert
		O2=20946		//Oxygen			20.946% 			Colorless, odorless, tasteless
		Ar=9340			//Argon				0.9340%				Colorless, odorless, tasteless, nontoxic, inert, stops fire
		CO2=383			//Carbon dioxide	0.0383%				Colorless, odorless
		//Large amounts sour cause stinging in nose and throat, over 15x normal unhealthy over 150x normal dangerous
		Ne=18			//Neon				0.001818%
		He=5			//Helium			0
		CH4=1			//Methane			0
		Kr=1			//Krypton			0
		H2=1			//Hydrogen			0
//		H2O=10			//Water Vapor		0
		N2O=0			//Nitrous Oxide		0
		CO=0			//Carbon Monoxide	0
*/
var
		BaseN2=78084		//Nitrogen			78.084%				Colorless, odorless, tasteless, inert
		BaseO2=20946		//Oxygen			20.946% 			Colorless, odorless, tasteless
		BaseAr=9340			//Argon				0.9340%				Colorless, odorless, tasteless, nontoxic, inert, stops fire
		BaseCO2=383			//Carbon dioxide	0.0383%				Colorless, odorless
		//Large amounts sour cause stinging in nose and throat, over 15x normal unhealthy over 150x normal dangerous
		BaseNe=18			//Neon				0.001818%
		BaseHe=5			//Helium			0
		BaseCH4=1			//Methane			0
		BaseKr=1			//Krypton			0
		BaseH2=1			//Hydrogen			0
//		H2O=10			//Water Vapor		0
		BaseN2O=0			//Nitrous Oxide		0
		BaseCO=0			//Carbon Monoxide	0

proc/TurfPressure(turf/Floors/F)
	F.Pressure= TotalGas(F)/108779 //108779

proc/TotalGas(atom/TS)
	var/Tt=0 //Total
/*	TS:N2=round(TS:N2,0.01)
	TS:O2=round(TS:O2,0.01)
	TS:Ar=round(TS:Ar,0.01)
	TS:CO2=round(TS:CO2,0.01)
	TS:Ne=round(TS:Ne,0.01)
	TS:He=round(TS:He,0.01)
	TS:CH4=round(TS:CH4,0.01)
	TS:Kr=round(TS:Kr,0.01)
	TS:H2=round(TS:H2,0.01)
	TS:N2O=round(TS:N2O,0.01)
	TS:CO=round(TS:CO,0.01)*/
	Tt+=TS:N2
	Tt+=TS:O2
	Tt+=TS:Ar
	Tt+=TS:CO2
	Tt+=TS:Ne
	Tt+=TS:He
	Tt+=TS:CH4
	Tt+=TS:Kr
	Tt+=TS:H2
	Tt+=TS:N2O
	Tt+=TS:CO
	return Tt






