.nds
.thumb

.include "armips/include/animscriptcmd.s"
.include "armips/include/abilities.s"
.include "armips/include/itemnums.s"
.include "armips/include/monnums.s"
.include "armips/include/movenums.s"

.create "build/move/move_anim/0_476", 0

a010_476:
    loadparticlefromspa 0, 490
    waitparticle

    addparticle 0, 0, 4
    addparticle 0, 3, 4
    addparticle 0, 1, 4
    wait 48
    repeatse 2119, 0, 2, 9
    callfunction 36, 5, 3, 0, 1, 10, 264, "NaN", "NaN", "NaN", "NaN", "NaN"
    wait 72

    unloadparticle 0
    waitstate
    end
    

.close
