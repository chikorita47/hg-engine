.nds
.thumb

.include "armips/include/battlescriptcmd.s"
.include "armips/include/abilities.s"
.include "armips/include/itemnums.s"
.include "armips/include/monnums.s"
.include "armips/include/movenums.s"

.create "build/move/battle_eff_seq/0_292", 0

HeavySlamEffectScript:
    heavyslamdamagecalc
    critcalc
    damagecalc
    endscript

.close