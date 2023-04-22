.nds
.thumb

.include "armips/asm/offset.s"

.open "base/arm9.bin", 0x02000000

// update the limiters

.org 0x02079e40

.word NUM_OF_MONS+1


.org 0x02079edc
// .area 0x02079f84-., 0xFF

push {r3,lr}
bl PokeIconPalNumGet
ldr r1, =gIconPalTable
ldrb r0, [r1,r0]
pop {r3,pc}
.pool

// .endarea

.org 0x02079f7c

.word NUM_OF_MONS+1
.word gIconPalTable

.close
