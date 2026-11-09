# Space Station ~ BYOND (SS_B)

An unfinished, independent Space Station 13–style game written in DM for
[BYOND](https://www.byond.com/) in 2008. This repository preserves the source
exactly as it was in a snapshot dated **2008-12-10**.

It is **not** derived from Exadv1's Space Station 13 codebase or any of its
forks (OpenSS13, Goon, /tg/, etc.). It is a from-scratch reimplementation with
its own type tree, naming and atmospherics model.

## Author

The interface skin credits the game to **AJX** (`SSSkin.dmf`, splash panel:
"Space Station" / "by AJX"). This is most likely the BYOND user
[AJX](https://www.byond.com/members/AJX) (member since 2002), who published
several games and libraries between 2005 and 2010. Their naming style matches
this project (e.g. the `A~Hologram` library, January 2009). The game was never
published on their hub, and authorship is inferred from the credit, not confirmed.

No license was included with the code. All rights remain with the original
author; this repository is for historical preservation. If you are the author
and want it changed or removed, please open an issue.

## What's in it

The code was in active development from February to December 2008.

- **Atmospherics simulation**: the core of the project (`Turfs.dm`,
  `A - New Air System.dm`). Every floor tile tracks 11 gases (N₂, O₂, Ar, CO₂,
  Ne, He, CH₄, Kr, H₂, N₂O, CO), starting at roughly Earth proportions.
  `world/Equalize()` spreads gas between neighbouring tiles. To keep the cost
  down, it only processes an *active turf list* and throttles itself against a
  CPU target (`LagControl`). Walls, full windows, closed doors and one-sided
  windows all block airflow.
- **Air machinery**: storage tanks, siphons and air-circulation units, with an
  in-game readout panel ("ASI") built in the skin.
- **Player interaction**: two hands (pick up / drop / throw / swap), equip
  slots for jumpsuits, glasses (meson and thermal change what you can see) and a
  headset, pulling objects, and facing/walking/running speeds. The intent
  buttons (help/disarm/harm/grab) are not implemented yet.
- **Objects**: directional doors and airlocks, windows that can be fastened
  with a screwdriver or broken into shards, closets, tables, floor panels that
  can be crowbarred up to expose pipes, tools (wrench, screwdriver, welder,
  crowbar, wirecutters, extinguisher, gas analyzer) and ID cards (access levels
  defined but unused).
- **`AI/`**: a standalone keyword-matching chatbot that learns from yes/no
  feedback and saves to `AI.sav`. It is unrelated to the station game.
- **`Stress Test Map.dmm`**: a single 100×100 level for testing the gas code.

Unfinished parts include an empty `Breathing()` proc, an empty `World.dm`, and
a second gas system that is mostly commented out.

## Building

Requires BYOND 4.0 or later (the project uses a `.dmf` interface skin).
It compiles as-is with BYOND 516.1688:

```
dm "Space Station ~ BYOND.dme"
```

That build reports 0 errors and 1 warning. Run the resulting
`Space Station ~ BYOND.dmb` in DreamSeeker or Dream Daemon.

## Provenance

The files come from an archive of old SS13-related material and are committed
unmodified: same bytes and line endings (`.gitattributes` disables line-ending
conversion). Only this README, `.gitattributes` and `.gitignore` were added.
Git doesn't record file modification times, so the original dates are listed
here:

| Date       | File |
|------------|------|
| 2008-02-06 | `Icons/Walls.dmi` |
| 2008-02-08 | `Icons/Doors.dmi`, `Icons/Doors ~ Airlock.dmi`, `Icons/System.dmi`, `Icons/Windows.dmi` |
| 2008-02-10 | `Icons/Closets.dmi` |
| 2008-02-11 | `Icons/Glasses.dmi`, `Icons/Tables.dmi` |
| 2008-02-12 | `Icons/Tools.dmi`, `Markers.dm` |
| 2008-02-14 | `Tables.dm` |
| 2008-02-15 | `Clothing.dm`, `Walls.dm`, `Icons/Floors.dmi`, `Icons/Jumpsuits.dmi`, `Icons/Misc.dmi`, `Icons/Mobs.dmi`, `Icons/Wind.dmi` |
| 2008-02-29 | `Items.dm`, `Radios.dm`, `SSSkin.dmf`, `Icons/Radios.dmi` |
| 2008-03-01 | `Closets.dm` |
| 2008-11-12 | `Doors.dm` |
| 2008-11-14 | `Glasses.dm`, `Icons/Air System.dmi` |
| 2008-11-16 | `A - New Air System.dm`, `Clients.dm`, `IDs.dm`, `Windows.dm`, `World.dm` |
| 2008-11-17 | `HUD.dm`, `Mobs.dm`, `Players ~ Vitals.dm`, `Tools.dm` |
| 2008-12-02 | `AI/Parse.dm` |
| 2008-12-05 | `AI/Filter.dm` |
| 2008-12-06 | `AI/Generate.dm` |
| 2008-12-08 | `AI/Saving.dm` |
| 2008-12-10 | `0 - Space Station ~ BYOND.dm`, `Players.dm`, `Turfs.dm`, `Stress Test Map.dmm`, `Space Station ~ BYOND.dme`, `AI/AI 2.0.dm` |
