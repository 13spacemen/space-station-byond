mob
	verb
		UseRHand()
			UseHand(0)
		UseLHand()
			UseHand(1)

		Switch()
			var/OLH=LeftHand
			LeftHand=RightHand
			RightHand=OLH
			UpdateH(usr)



//mob/var/FilterNameList[]=0

proc/UpdateH(mob/M)
	var/OI=M.icon
	var/icon/I
	var/Filtering
	var/atom/Filtering2
	//winset(M,"RightHand","image=\"\"")
	var/list/UpdateList=list("RightHand"=M.RightHand,"LeftHand"=M.LeftHand,"Glasses"=M.Glasses,"Jumpsuit"=M.Jumpsuit)
	for(var/i in UpdateList)
		Filtering=i
		Filtering2=UpdateList[i]
		winset(M,"[Filtering]","image=\"\"")
		if(Filtering2)
			I=new(Filtering2.icon,Filtering2.icon_state)
			M.icon=I
			M<<output(M.icon,"[Filtering]")
			//winset(M,"[Filtering]","text=\"\"")
			M.icon=OI
			del I


/*
	if(M.RightHand)
		I=new(M.RightHand.icon,M.RightHand.icon_state)
		M.icon=I
		M<<output(M.icon,"RightHand")
		M.icon=OI
		del I
	if(M.LeftHand)
		I=new(M.LeftHand.icon,M.LeftHand.icon_state)
		M.icon=I
		M<<output(M.icon,"LeftHand")
		M.icon=OI
		del I
	if(M.Glasses)
		I=new(M.LeftHand.icon,M.LeftHand.icon_state)
		M.icon=I
		M<<output(M.icon,"LeftHand")
		M.icon=OI
		del I
	*/

mob/proc/UseHand(WhichHand)
	var/Hand
	if(!WhichHand)Hand=RightHand
	if(WhichHand)Hand=LeftHand
	if(istype(Hand,/obj/Items/Tools/Analyzer))
		if(Interacting==Hand) Interacting=0
		else Interacting=Hand

	if(istype(Hand,/obj/Items/Tools/Welder))
		if(Hand:On)
			Hand:On=0
			Hand:icon_state="Welder"
		else
			Hand:On=1
			Hand:icon_state="Welder On"

	UpdateH(usr)





////////////////////////
/* ***HUD CONTROLS*** */
////////////////////////




world/proc/HUDMaintain()
	var/mob/Player/M
	var/atom/In //In== Interacting
	var/obj/Machinery/AirSystems/I
	var/turf/Floors/T

	while(world)
		for(var/client/C)
			if(!C) continue
			if(!C.mob) continue
			winset(C,"CPU Display","text=[world.cpu]")
			winset(C,"LF","text=[TrueLagReduction]")
			winset(C,"Timestamp","text=\"[Timestamp()]\"")

			M=C.mob
			if(!M)continue
			if(M.Interacting)
				In=M.Interacting //In== Interacting

				if(istype(In,/obj/Machinery/AirSystems/))
					I=In
					winset(C,"Interface","left=ASI") //Air System Interface
					if(get_dist(M,I)>1)
						M.Interacting=null
						winset(C,"Interface","left=InterfaceSplash")
						goto Next
					if(M.x!=I.x&&M.y!=I.y)
						M.Interacting=null
						winset(C,"Interface","left=InterfaceSplash")
						goto Next
					if(istype(I,/obj/Machinery/AirSystems/ACSystems/)||istype(I,/obj/Machinery/AirSystems/Siphons/))
						if(I.loc!=get_step(M,I.dir))
							M.Interacting=null
							winset(C,"Interface","left=InterfaceSplash")
							goto Next
					else
						if(!istype(I,/obj/Machinery/AirSystems/StorageTank))
							if(!istype(M.RightHand,/obj/Items/Tools/Analyzer)&&!istype(M.LeftHand,/obj/Items/Tools/Analyzer))
								M.Interacting=null
								winset(C,"Interface","left=InterfaceSplash")
					winset(C,"ASI.Title","text=\"[I.name]\"")
					winset(C,"ASI.Description","text=\"[I.desc]\"")
					ASIUpdate(C,I)
					if(I.Transfer==1) winset(C,"ASI.Transfer","text=On")
					if(I.Transfer==0) winset(C,"ASI.Transfer","text=Off")
					winset(C,"ASI.TransferR","text=[I.TransferR]")
					if(I.Transfer!=-1) ShowASITransfer(C)


					if(I.Transfer==-1) HideASITransfer(C)


				if(istype(In,/obj/Items/Tools/Analyzer))
					T=locate(M.x,M.y,M.z)
					if(!istype(T,/turf/Floors)) continue
					if(In.loc!=M)
						//world<<"In [In.loc]"
						M.Interacting=0
						continue
					winset(C,"Interface","left=ASI")
					winset(C,"ASI.Title","text=\"[In.name]\"")
					winset(C,"ASI.Description","text=\"[T.name]\"")
					ASIUpdate(C,T)
					HideASITransfer(C)


			else
				winset(C,"Interface","left=InterfaceSplash")
				winset(C,"Interface2","left=Interface2Splash")
			Next
		/*if(LagReduction<10)
			sleep(1)
		else
			sleep(3)*/
		sleep(1)


proc/Timestamp()
	var/Output=""
	if(GameHours<10) Output="0[GameHours]:"
	else Output="[GameHours]:"
	if(GameMinutes<10)Output="[Output]0[GameMinutes]:"
	else Output="[Output][GameMinutes]:"
	if(GameSeconds<10)Output="[Output]0[GameSeconds]:"
	else Output="[Output][GameSeconds]:"
	Output="[Output][GameDeci]"
	return Output

proc/ASIUpdate(client/C,atom/T)
	winset(C,"ASI.N2","text=[round(T:N2,0.01)]")
	winset(C,"ASI.O2","text=[round(T:O2,0.01)]")
	winset(C,"ASI.Ar","text=[round(T:Ar,0.01)]")
	winset(C,"ASI.CO2","text=[round(T:CO2,0.01)]")
	winset(C,"ASI.Ne","text=[round(T:Ne,0.01)]")
	winset(C,"ASI.He","text=[round(T:He,0.01)]")
	winset(C,"ASI.CH4","text=[round(T:CH4,0.01)]")
	winset(C,"ASI.Kr","text=[round(T:Kr,0.01)]")
	winset(C,"ASI.H2","text=[round(T:H2,0.01)]")
	winset(C,"ASI.N2O","text=[round(T:N2O,0.01)]")
	winset(C,"ASI.CO","text=[round(T:CO,0.01)]")

proc/HideASITransfer(client/C)
	winset(C,"ASI.Transfer","text=N/A")
	winset(C,"ASI.TransferR","text=N/A")
	winset(C,"ASI.Transfer","text=N/A")
	winset(C,"ASI.TransferR","text=N/A")
	winset(C,"ASI.Transfer","is-visible=false")
	winset(C,"ASI.TransferR","is-visible=false")
	winset(C,"ASI.Transfer Label","is-visible=false")
	winset(C,"ASI.TransferR Label","is-visible=false")
	winset(C,"ASI.TransferToggle","is-visible=false")
	winset(C,"ASI.TransferUp","is-visible=false")
	winset(C,"ASI.TransferDown","is-visible=false")

proc/ShowASITransfer(client/C)
	winset(C,"ASI.Transfer","is-visible=true")
	winset(C,"ASI.TransferR","is-visible=true")
	winset(C,"ASI.Transfer Label","is-visible=true")
	winset(C,"ASI.TransferR Label","is-visible=true")
	winset(C,"ASI.TransferToggle","is-visible=true")
	winset(C,"ASI.TransferUp","is-visible=true")
	winset(C,"ASI.TransferDown","is-visible=true")

mob/verb
	MoveFacing()
		set hidden=1
		Movement=0

	MoveWalking()
		set hidden=1
		Movement=1

	MoveRunning()
		set hidden=1
		Movement=2