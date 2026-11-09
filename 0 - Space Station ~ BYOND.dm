atom/movable/Bumped(mob/Player/B)
	if(!Secured)
		if(istype(B,/mob/Player))
			if(B.Pulling==src)
				B.Pulling.Pulled=0
				B<<output("\[[Timestamp()]\]<font color=blue>*No Longer Pulling [usr.Pulling]*","System")
				B.Pulling=0
			var/OldDir=dir
			step(src,B.dir)
			dir=OldDir
	..()

atom/movable/Bump(atom/O)
	O.Bumped(src)
	.=..()

atom/proc/Bumped(atom/Bumper)
	..()

area/layer=1

turf/layer=2

obj/Machinery/AirSystems/Pipes/layer=3

obj/Walls/layer=4

obj/Machinery/AirSystems/Vents/layer=5

obj/Furniture/Tables/layer=6

obj/layer=7

obj/Items/layer=8

mob/layer=10


proc/System(t,f)
	world<<output("\[[Timestamp()]\][f][t]","System")

world
	New()
		spawn() WorldTimer()
		spawn() .=..()
		spawn(1) HUDMaintain()
		spawn(1) LagControl()
		spawn(2) InitBaseState()
		//spawn(3) GasInit()
		spawn(4)
			TTCUpdate()
			spawn(1) Equalize()


			//spawn(5) CountAirSystems()
			//spawn(6) InitializeAirSystems()
			//spawn(7) MaintainVents()
			//spawn(8) InitializeAirMachines()

		..()
		spawn(1)world<<output("\[[Timestamp()]\]<b>Welcome to Space Staton ~ BYOND","System")

	proc/LagControl()
		var/Counter=0
		while(AutomaticLagChecks)
			if(world.cpu<CPUTarget) if(TrueLagReduction>1)
				Counter++
				if(Counter>3)
					TrueLagReduction--
					if(LagReduction>LagReductionMinimum) LagReduction--
					Counter=0

			else
				if(world.cpu>CPUTarget) if(TrueLagReduction<LagReductionCap)
					Counter--
					if(Counter<-1)
						TrueLagReduction++
						if(TrueLagReduction>LagReduction)LagReduction++
						Counter=0

			if(AllowWindAnimations)
				if(WindAnimations<5&&TrueLagReduction<=3) if(!WindToggleTimer)
					WindToggleTimer=200
					WindAnimations++
					System("Wind Animations Increased","<b><font color=red>")

				if(WindAnimations>1&&TrueLagReduction>3) if(!WindToggleTimer)
					WindToggleTimer=200
					WindAnimations--
					System("Wind Animations Decreased","<b><font color=red>")
			sleep(2)

	proc/InitBaseState()
		for(var/atom/movable/A)
			A.BaseState=A.icon_state



	proc/WorldTimer()
		while(world)
			GameDeci++
			if(GameDeci>9)
				GameDeci=0
				GameSeconds++
			if(GameSeconds>59)
				GameSeconds=0
				GameMinutes++
			if(GameMinutes>59)
				GameMinutes=0
				GameHours++
			if(WindToggleTimer>0) WindToggleTimer--
			sleep(1)



var/GameHours=0
var/GameMinutes=0
var/GameSeconds=0
var/GameDeci=0

var/AllowWindAnimations=0

var/CPUTarget=50
var/CPUDiff=5
var/LagReductionCap=25

var/WindToggleTimer=200
var/WindAnimations=0
var/LagReductionMinimum=3


var/TTC=0 //Total Turf Count
var/TrueLagReduction=25
var/LagReduction=25
var/AutomaticLagChecks=TRUE
