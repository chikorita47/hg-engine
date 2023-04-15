.nds
.thumb

// included by armips/global.s

.include "armips/asm/offset.s"

.open "base/overlay/overlay_0021.bin", 0x021d0d80


// here, we need to allocate memory space for the two new poke_lists and store them at workspace+0x878 and workspace+0x1030
// so instead of allocating more size to the pokedex workspace, the goal here is just to allocate
// enough space to two new poke_lists and place pointers to them inside the structure and change everything that references it.
// we then need to change how each is accessed/written to
// UPDATE:  apparently workspace+0x1032 is referenced outside of 0x1030.  love to see it, that add a few more
//   literally 10 more by the way.  holy shit.


.org 0x021D57B0 // ZknWt_GetCountryPokeData

.word NUM_OF_MONS


// expand the ram usable by the dex
.org 0x021d0d90 // ZKN_ProcInit
    mov r2, #0x44 // old:  mov r2, #1
    mov r0, #3
    mov r1, #0x25
    lsl r2, r2, #0xC // old:  lsl r2, r2, #0x12
    // should end up with 0x44000 (was 0x40000)


.org 0x021d321a // branch out of the init function
    // r5 = p->workspace
    bl allocate_lists

.org 0x021d333e // branch out of the delete function
    bl unallocate_lists


.org 0x021d3772 // ZKN_GLBDATA_PokeListTblNoGet_Monsno
    ldr r5, [r0, #4] // new_zkn_pokelist_tbl;  old:  add r5, r0, #0

.org 0x021d3780
    ldr r1, [r5] // old:  ldr r1, [r5, #4]


.org 0x021d37c2 // ZKN_GLBDATA_PokeMonsNoGet
    ldr r0, [r0, #4]
    ldr r0, [r0, r1]


.org 0x021d37ce // ZKN_GLBDATA_PokeMonsTypeGet
    push {lr}
    bl PokeMonsTypeGet_patch
    pop {pc}


.org 0x021d37ea // ZKN_GLBDATA_PokeListTblGet
    ldr r1, [r5, #4] // old:  add r1, [r5, #4]


.org 0x021d3a7c // ZknPokeListTblMake
    cmp r0, #0
    beq @@_type_caught
    mov r0, #2
    b @@_set_type
@@_type_caught:
    mov r0, #1
@@_set_type:
    ldr r1, =0xF6C
    ldr r1, [r5, r1]
    lsl r1, r1, #3 // r1 = shift amount inside of zkn_pokelist_tbl
    ldr r2, [r5] // r2 = address of new_zkn_pokelist_tbl
    add r2, r2, r1
    str r0, [r2, #4]
    ldrh r0, [r4, #0]
    add r6, r6, #1
    str r0, [r2]
    nop
    nop
    nop
    nop
    nop

.org 0x021d3ab4 // keep the pool in its original location

.pool


.org 0x021d3fba // ZknPokeListTblSeeGetNumCount
    ldr r4, [r0] // old:  add r4, r0, #0


.org 0x021d3824 // ZKN_GLBDATA_PokeListDrawTblNoSet
    lsl r4, r4, #2 // r4 is now offset in zkn_pokelistdraw_tbl
    ldr r1, =0xF74
    ldr r1, [r5, r1] // r1 = new_zkn_pokelistdraw_tbl
    ldr r1, [r1, r4]
    nop

.org 0x021d3840

.pool


.org 0x021d385a // ZKN_GLBDATA_PokeListDrawTblNoAdd
    // r0 = value of p_glb->poke_list.draw_tbl_no
    lsl r0, r0, #2 // r0 = offset in zkn_pokelistdraw_tbl
    ldr r1, =0xF74
    ldr r1, [r5, r1] // r1 = new_zkn_pokelistdraw_tbl
    ldr r1, [r1, r0]
    nop
    mov r0, r5

.org 0x021d3878

.pool


.org 0x021d38b2 // ZKN_GLBDATA_PokeListDrawTblDataGet
    // r1 = offset in zkn_pokelistdraw_tbl
    ldr r2, =0xF74
    ldr r0, [r0, r2]
    ldr r0, [r0, r1]

.org 0x021d38bc

.pool


.org 0x021d3ace // ZknPokeListDrawTblMake
    ldr r5, [r0] // old:  add r5, r0, #0

.org 0x021d3ae8
    // r1 = shift amount in zkn_pokelistdraw_tbl
    mov r2, #0xF7
    lsl r2, r2, #4
    ldr r2, [r0, r2] // r2 = new_zkn_pokelistdraw_tbl
    str r4, [r2, r1]

.org 0x021d3b00
    // r1 = shift amount in zkn_pokelistdraw_tbl
    // r2 = 0x1EE (value to store)
    lsl r3, r2, #3 // r3 = 0x1EE << 3 = 0xF70 (!!)
    ldr r3, [r0, r3] // r3 = new_zkn_pokelistdraw_tbl
    str r2, [r3, r1]


.org 0x021d3b3e  // ZknPokeListDrawTblCopy
    // r3 = 0xF70
    ldr r3, [r0, r3]
    add r2, r5, #0
    sub r4, r3, #4
@@_loop:
    ldr r6, [r0, r2]
    lsl r6, r6, #2
    str r1, [r3, r6]
    ldr r6,[r0,r5]
    add r1,r1,#0x1
    add r6,r6,#0x1
    str r6,[r0,r5]
    ldr r6,[r0,r4]
    cmp r1,r6
    blt @@_loop


.org 0x021d367c // ZKN_GLBDATA_PokeListTblMake_DummyListCutFlg

.word (NUM_OF_MONS) * 2 // fuck it we keep the extra space here


.org 0x021d171a // ZKN_UTIL_PokeListPokeNameTblBmpMake_Zenkoku
.area 0x021d171e-.
    bl GetNationalDexDrawNum_patch
.endarea


.org 0x021D57B4 // ZKN_RANGEDATA_GetMonsNoRange
.area 0x021d5844-.


ZKN_RANGEDATA_GetMonsNoRange: // fix a crash when accessing dex data
    push {r4, r5, lr}
    sub sp, sp, #0xC
    mov r4, r0
    cmp r2, #9
    bhi _return_021d57c8
    add r0, r2, r2
    add r0, pc
    ldrh r0, [r0, #(_jumptable - . - 2)] // old:  ldrh r0, [r0, #6] // the jumptable in 3 instructions from when pc was added to r0

    add pc, r0

_jumptable: // construct a jumptable for use above
    .halfword  e0 - _jumptable - 2, \
               e1 - _jumptable - 2, \
               e2 - _jumptable - 2, \
               e3 - _jumptable - 2, \
               e4 - _jumptable - 2, \
               e5 - _jumptable - 2, \
               e6 - _jumptable - 2, \
               e7 - _jumptable - 2, \
               e8 - _jumptable - 2, \
               e9 - _jumptable - 2

e0: // entry 0
    mov r5, #4
    b _return_021d57c8

e1: // entry 1
    ldr r5, =(4 + (NUM_OF_MONS)) // each entry sequentially add (NUM_OF_MONS + 2) in vanilla.  no reason, we just add NUM_OF_MONS
    b _return_021d57c8

e2: // entry 2
    ldr r5, =(4 + 2*(NUM_OF_MONS))
    b _return_021d57c8

e3: // entry 3
    ldr r5, =(4 + 3*(NUM_OF_MONS))
    b _return_021d57c8

e4: // entry 4
    ldr r5, =(4 + 4*(NUM_OF_MONS))
    b _return_021d57c8

e5: // entry 5
    ldr r5, =(4 + 5*(NUM_OF_MONS))
    b _return_021d57c8

e6: // entry 6
    ldr r5, =(4 + 6*(NUM_OF_MONS))
    b _return_021d57c8

e7: // entry 7
    ldr r5, =(4 + 7*(NUM_OF_MONS))
    b _return_021d57c8

e8: // entry 8
    ldr r5, =(4 + 8*(NUM_OF_MONS))
    b _return_021d57c8

e9: // entry 9
    ldr r5, =(4 + 9*(NUM_OF_MONS))
    // fall through

_return_021d57c8:
    mov r2, #0
    str r2, [sp]
    add r0, sp, #0x8
    str r0, [sp, #0x4]
    mov r0, #0xBC
    add r1, r5, r1
    bl 0x02007068 // ArcUtil_LoadEx
    str r0, [r4]
    ldr r0, [sp, #0x8]
    lsr r0, r0, #2
    str r0, [r4, #4]
    add sp, sp, #0xC
    pop {r4, r5, pc}

.pool

.endarea

.close


.open "base/arm9.bin", 0x2000000

// r0 = dex mode
// r1 = species
.org 0x0207A294 // rewrite get_dex_num

.area 0x14, 0xFF

get_dex_num: // god i wish this could be well-rewritten
    push {lr}
    bl GetDexNum_patch
    pop {pc}

.pool

.endarea

.close








// here, we need to increase the pokedex structure size to 0x700 (originally 0x324)
// trying to support up to 2048 mons = 2048 / 8 = 256 bytes per flags field that we need to support
// 0x324 gets extended through 0x400 from 0x300, i think that is the language bytes or something
// we need to repoint 0x44 within that structure to 0x400 (repoint the seen flags)
// we then need to repoint 0x84 within that structure to 0x500 (repoint the male flags)
// 0xC4 obviously then needs to be 0x600 (repoint the female flags)
// for a total size of 0x700

CAUGHT_FLAGS_OFFSET equ 0x4
SEEN_FLAGS_OFFSET equ 0x400
MALE_FLAGS_OFFSET equ 0x500
FEMALE_FLAGS_OFFSET equ 0x600
DEX_SAVE_SIZE equ 0x700

.open "base/arm9.bin", 0x02000000


// in the name of maintaining PKHeX compatibility for vanilla saves, this whole part needs to be possibly conditionally built.
.ifdef ALLOW_SAVE_CHANGES

.org 0x0202631c

GetPokedexStructSize: // used by the save data to get the struct size needed
    mov r0, #DEX_SAVE_SIZE >> 4
    lsl r0, #0x4
    bx lr


.org 0x02026324

AllocatePokedexStructSize: // rewrite for new struct size
    push {r4, lr}
    mov r1, #DEX_SAVE_SIZE >> 4
    lsl r1, #0x4
    bl 0x02018144 // AllocMemory
    mov r4, r0
    bl PokedexInit
    mov r0, r4
    pop {r4, pc}


.org 0x02026338

CopyPokedexStruct: // rewrite for new struct size
    ldr r3, =(0x020c4db0) // CpuCopy8
    mov r2, #DEX_SAVE_SIZE >> 4
    lsl r2, #0x4
    bx r3

.pool


.org 0x02026344

IsMonNotValid:
    push {r3, lr}
    cmp r0, #0
    beq @@_invalid_mon
    ldr r1, =NUM_OF_MONS
    cmp r0, r1
    bls @@_return_valid

@@_invalid_mon:
    bl 0x02022974 // HandleError
    mov r0, #1
    pop {r3, pc}

@@_return_valid:
    mov r0, #0
    pop {r3, pc}

.pool


// edits to SetGenderBit

.org 0x0202637a // replace C4 with 440
    mov r3, r0
    mov r1, #7
    and r3, r1
    mov r6, #1
    lsl r6, r3
    mov r1, #FEMALE_FLAGS_OFFSET >> 4
    lsl r1, #4
    add r2, r1
    asr r1, r0, #3

.org 0x020263a8
    mov r3, #MALE_FLAGS_OFFSET >> 4
    lsl r3, #4
    add r5, r3
    sub r3, r0, #1



// edit to SetDeoxysFormNo
// net -0x10 bytes from removing error handling and casting

.org 0x02026850 // setDEOKISISUFormNo

.area 0x0202688c-., 0xFF

SetDeoxysFormNo:
    push {r4-r6, lr}
    add r4, r2, #0
    add r5, r0, #0
    add r6, r1, #0
// old error handling, -0x10 bytes
//    cmp r4, #4
//    blo @@_02026860
//    bl 0x02022974
//@@_02026860:
//    cmp r6, #0xf
//    bls @@_02026868
//    bl 0x02022974
//@@_02026868:
    cmp r4, #2
    bhs @@_02026878
    add r0, r5, #4
    add r1, r6, #0
    add r2, r4, #0
    bl 0x02026834
    pop {r4-r6, pc}
@@_02026878:
    sub r2, r4, #2
// new:  add SEEN_FLAGS_OFFSET instead of 0x44, +6 bytes
    mov r4, #SEEN_FLAGS_OFFSET >> 4
    lsl r4, #4
    add r5, r4
// -2 bytes
//    add r5, #0x44
// -4 bytes:  get rid of cast
//    lsl r2, r2, #0x18 // get rid of byte cast
    add r0, r5, #0
    add r1, r6, #0
//    lsr r2, r2, #0x18 // get rid of byte cast
    bl 0x02026834
    pop {r4-r6, pc}

.endarea


// edits to getDEOKISISUFormNo

.org 0x020268a0
.area 0x020268b8-., 0xFF
// old:
//    add r0, #0x80
//    ldr r2, [r0, #0]
// instead of 0x80, need SEEN_FLAGS_OFFSET + (0x80 - 0x44) = 0x43C
    mov r0, #(SEEN_FLAGS_OFFSET + (0x80 - 0x44)) >> 4
    lsl r0, #4
    ldr r2, [r0, #(SEEN_FLAGS_OFFSET + (0x80 - 0x44)) & 0xF] // +2 bytes
    sub r0, r1, #2
// old:
//    lsl r0, r0, #0x18
//    lsr r0, r0, #0x16
// new: remove cast, -2 bytes
    lsl r0, #2
    add r0, #0x18
    add r1, r2, #0
    lsr r1, r0
    mov r0, #0xf
    and r0, r1
    bx lr

.endarea


// edits to GetNormalMonGender

.org 0x02026bce
    sub r2, r6, #1
    mov r1, #1
    mov r0, #7
    mov r3, r2
    and r3, r0
    mov r0, r1
    lsl r0, r3
    asr r3, r2, #3
    add r3, r5, r3
    mov r6, #MALE_FLAGS_OFFSET >> 4
    lsl r6, #4
    add r3, r6


.org 0x02026bee
    cmp r4, #1
    bne 0x02026c1e
    mov r4, r2
    asr r2, r2, #3
    add r2, r5, r2
    mov r0, #7
    mov r3, #FEMALE_FLAGS_OFFSET >> 4
    lsl r3, #4
    add r2, r3


.org 0x02026d6c

PokedexInit: // rewrite the beginning for new struct size
    push {r4, lr}
    mov r2, #DEX_SAVE_SIZE >> 4
    lsl r2, #4
    mov r1, #0


// edits to GetCaughtMonCount

.org 0x02026dd0

.area 0x3C, 0xFF

GetCaughtMonCount:
    push {r3-r7, lr}
    mov r6, r0
    mov r5, #0
    mov r4, #1

@@_loop:
    mov r0, r6
    mov r1, r4
    bl 0x02026f9c // GetCaughtFlag
    cmp r0, #1
    bne @@_increment
    add r5, #1

@@_increment:
    add r4, #1
    mov r7, #(SPECIES_ARCEUS + 1) / 2
    lsl r7, #1
    cmp r4, r7
    blt @@_loop
    add r7, #(SPECIES_VICTINI - SPECIES_ARCEUS - 1)
    cmp r4, r7
    blt @@_increment
    ldr r7, =NUM_OF_MONS
    cmp r4, r7
    ble @@_loop
    mov r0, r5
    pop {r3-r7, pc}
    
.pool
    
.endarea


// edits to GetSeenMonCount

.org 0x02026e0c

.area 0x3C, 0xFF

GetSeenMonCount:
    push {r3-r7, lr}
    mov r6, r0
    mov r5, #0
    mov r4, #1

@@_loop:
    mov r0, r6
    mov r1, r4
    bl 0x02026fe8 // GetSeenFlag
    cmp r0, #1
    bne @@_increment
    add r5, #1

@@_increment:
    add r4, #1
    mov r7, #(SPECIES_ARCEUS + 1) / 2
    lsl r7, #1
    cmp r4, r7
    blt @@_loop
    add r7, #(SPECIES_VICTINI - SPECIES_ARCEUS - 1)
    cmp r4, r7
    blt @@_increment
    ldr r7, =NUM_OF_MONS
    cmp r4, r7
    ble @@_loop
    mov r0, r5
    pop {r3-r7, pc}
    
.pool

.endarea


// edits to GetRegionalDexCaughtCount

.org 0x02026ea8

.word NUM_OF_MONS


// edits to GetRegionalDexSeenCount

.org 0x02026ef0

.word NUM_OF_MONS


// something to do with counting the mons that are not mythical

// edits to ZukanWork_GetZenkokuGetCompCount

.org 0x02026f54

.word NUM_OF_MONS


// edits to ZukanWork_GetShinouSeeCompCount

.org 0x02026f98

.word NUM_OF_MONS


// edits to GetCaughtFlag
// net -0x8 bytes from removing error handling and casting

.org 0x02026f9c

.area 0x02026fe8-., 0xFF

GetCaughtFlag: // 0x02026f9c
    push {r3-r5, lr}
    add r5, r0, #0
    add r4, r1, #0
    ldr r1, [r5]
    ldr r0, =0xBEEFCAFE
// old error handling, -8 bytes
//    cmp r1, r0
//    beq @@_02026fae
//    bl 0x02022974
//@@_02026fae:
    add r0, r4, #0
    bl 0x02026344
    cmp r0, #0
    beq @@_02026fbc
    mov r0, #0
    pop {r3-r5, pc}
@@_02026fbc:
// new replace below:  +2 bytes
    sub r2, r4, #1
// get rid of old casting, -6 bytes
//    sub r0, r4, #1
//    lsl r0, r0, #0x10
//    lsr r2, r0, #0x10
    mov r0, #1
    mov r1, #7
    and r1, r2
    add r3, r0, #0
    lsl r3, r1
    asr r1, r2, #3
    add r2, r5, r1
    ldrb r1, [r2, #CAUGHT_FLAGS_OFFSET]
    tst r1, r3
    beq @@_02026fde
// get rid of old handling, -2 bytes
//    add r2, #0x44
// new: +6 bytes
    mov r5, #SEEN_FLAGS_OFFSET >> 4
    lsl r5, #4
    add r2, r5
    ldrb r1, [r2]
    tst r1, r3
    bne @@_02026fe0
@@_02026fde:
    mov r0, #0
@@_02026fe0:
    pop {r3-r5, pc}
//    nop

.pool

.endarea


// edits to GetSeenFlag
// net -0x8 bytes from removing error handling and casting

.org 0x02026fe8

.area 0x0202702c-., 0xFF

GetSeenFlag: // 0x02026fe8
    push {r3-r5, lr}
    add r5, r0, #0
    add r4, r1, #0
    ldr r1, [r5]
    ldr r0, =0xBEEFCAFE
// remove error handling:  -8 bytes
//    cmp r1, r0
//    beq @@_02026ffa
//    bl 0x02022974
//@@_02026ffa:
    add r0, r4, #0
    bl 0x02026344
    cmp r0, #0
    beq @@_02027008
    mov r0, #0
    pop {r3, r4, r5, pc}
@@_02027008:
// new replace below:  +2 bytes
    sub r3, r4, #1
// get rid of cast: -6 bytes
//    sub r0, r4, #1
//    lsl r0, r0, #0x10
//    lsr r3, r0, #0x10
    mov r0, #1
    mov r1, #7
    and r1, r3
    add r2, r0, #0
    lsl r2, r1
    asr r1, r3, #3
    add r1, r5, r1
// get rid of old handling, -2 bytes
//    add r1, #0x44
// new: +6 bytes
    mov r3, #SEEN_FLAGS_OFFSET >> 4
    lsl r3, #4
    add r1, r3
    ldrb r1, [r1]
    tst r1, r2
    bne @@_02027026
    mov r0, #0
@@_02027026:
    pop {r3-r5, pc}

.pool

.endarea


// edits to ZukanWork_GetPokeSexFlag

.org 0x02027058

.area 0x020270ac-., 0xFF

ZukanWork_GetPokeSexFlag: // 0x02027058
    push {r4-r6, lr}
    add r5, r0, #0
    add r4, r1, #0
    ldr r1, [r5]
    ldr r0, =0xBEEFCAFE
    add r6, r2, #0
    cmp r1, r0
    beq @@_0202706c
    bl 0x02022974
@@_0202706c:
    add r0, r4, #0
    bl 0x02026344
    cmp r0, #0
    beq @@_0202707c
    mov r0, #0
    mvn r0, r0
    pop {r4-r6, pc}
@@_0202707c:
//    sub r0, r4, #1
//    lsl r0, r0, #0x10
//    lsr r2, r0, #0x10
    sub r2, r4, #1 // net -4
    add r3, r2, #0
    asr r2, r2, #3
    add r2, r5, r2
//    mov r0, #7
//    add r2, #0x44 // here
    mov r0, #SEEN_FLAGS_OFFSET >> 4
    lsl r0, #4
    add r2, r0 // net +4
    mov r0, #7
    mov r1, #1
    and r3, r0
    ldrb r2, [r2]
    lsl r1, r3
    tst r1, r2
    beq @@_020270a4
    add r0, r5, #0
    add r1, r4, #0
    add r2, r6, #0
    bl 0x02026bac
    pop {r4-r6, pc}
@@_020270a4:
    sub r0, #8
    pop {r4-r6, pc}

.pool

.endarea


// edits to SetMonSeen

.org 0x020272a4

.area 0x0202736c-., 0xFF

SetMonSeen: // 0x020272a4
    push {r3-r7, lr}
    sub sp, #8
    add r5, r0, #0
    str r1, [sp]
    add r0, r1, #0
    mov r1, #5
    mov r2, #0
    bl 0x02074470
    lsl r0, r0, #0x10
    lsr r4, r0, #0x10
    mov r1, #0
    ldr r0, [sp]
    add r2, r1, #0
    bl 0x02074470
    str r0, [sp, #4]
    ldr r0, [sp]
    bl 0x02075d6c
    add r6, r0, #0
    ldr r1, [r5]
    ldr r0, =0xBEEFCAFE
    cmp r1, r0
    beq @@_020272da
    bl 0x02022974
@@_020272da:
    add r0, r4, #0
    bl 0x02026344
    cmp r0, #0
    bne @@_0202735e
//    sub r0, r4, #1
//    lsl r0, r0, #0x10
//    lsr r7, r0, #0x10
    sub r7, r4, #1 // net -4
    mov r1, #1
    mov r0, #7
    add r2, r7, #0
    and r2, r0
    add r0, r1, #0
    asr r3, r7, #3
    lsl r0, r2
    add r2, r5, r3
//    add r2, #0x44 // here
    mov r1, #SEEN_FLAGS_OFFSET >> 4
    lsl r1, #4
    add r2, r1 // net +4
    ldrb r2, [r2]
    tst r2, r0
    bne @@_0202731e
    ldr r1, =0x00000147
    cmp r4, r1
    bne @@_0202730e
    ldr r0, [sp, #4]
    sub r1, #0x43
    str r0, [r5, r1]
@@_0202730e:
//    lsl r1, r6, #0x18
    add r0, r5, #0
//    lsr r1, r1, #0x18
    mov r1, r6 // net -2
    mov r2, #0
    add r3, r4, #0
    bl 0x020263d8
    b @@_02027340
@@_0202731e:
    add r2, r5, r3
    mov r3, #MALE_FLAGS_OFFSET >> 4
    lsl r3, #4
    add r2, r3
    ldrb r2, [r2]
    tst r0, r2
    bne @@_next
    mov r1, #0
@@_next:
    cmp r1, r6
    beq @@_02027340
//    lsl r1, r6, #0x18
    add r0, r5, #0
//    lsr r1, r1, #0x18
    mov r1, r6 // net -2
    mov r2, #1
    add r3, r4, #0
    bl 0x020263d8
@@_02027340:
    ldr r2, [sp]
    add r0, r5, #0
    add r1, r4, #0
    bl 0x02026a60
    mov r1, #7
//    add r5, #0x44 // here
    mov r0, #SEEN_FLAGS_OFFSET >> 4
    lsl r0, #4
    add r5, r0 // net +4
    asr r0, r7, #3
    ldrb r3, [r5, r0]
    mov r2, #1
    and r1, r7
    lsl r2, r1
    add r1, r3, #0
    orr r1, r2
    strb r1, [r5, r0]
@@_0202735e:
    add sp, #8
    pop {r3-r7, pc}
    nop

.pool

.endarea


// edits to SetMonCaught
// here we diverge from hg a bit, A4E4 thru A50D is different (unown dex + some other check)

.org 0x0202736c

.area 0x02027454-., 0xFF

SetMonCaught: // 0x0202736c
    push {r3-r7, lr}
    sub sp, #8
    add r7, r1, #0
    add r5, r0, #0
    add r0, r7, #0
    mov r1, #5
    mov r2, #0
    bl 0x02074470
//    lsl r0, r0, #0x10
//    lsr r4, r0, #0x10
    mov r4, r0 // net -2
    add r0, r7, #0
    mov r1, #0xc
    mov r2, #0
    bl 0x02074470
    mov r1, #0
    str r0, [sp, #4]
    add r0, r7, #0
    add r2, r1, #0
    bl 0x02074470
    str r0, [sp]
    add r0, r7, #0
    bl 0x02075d6c
    add r6, r0, #0
    ldr r1, [r5]
    ldr r0, =0xBEEFCAFE
    cmp r1, r0
    beq @@_020273ae
    bl 0x02022974
@@_020273ae:
    add r0, r4, #0
    bl 0x02026344
    cmp r0, #0
    bne @@_02027448
//    sub r0, r4, #1
//    lsl r0, r0, #0x10
//    lsr r3, r0, #0x10
    sub r3, r4, #1 // net -4
    mov r2, #1
    mov r0, #7
    and r0, r3
    add r1, r2, #0
    lsl r1, r0
    asr r0, r3, #3
    add r3, r5, r0
//    add r3, #0x44 // here
    push {r0}
    mov r0, #SEEN_FLAGS_OFFSET >> 4 ///////////////////////////////////
    lsl r0, #4
    add r3, r0 // net +4
    pop {r0}
    ldrb r3, [r3]
    tst r3, r1
    bne @@_020273f0
    ldr r1, =0x00000147
    cmp r4, r1
    bne @@_020273e0
    ldr r0, [sp]
    sub r1, #0x43
    str r0, [r5, r1]
@@_020273e0:
//    lsl r1, r6, #0x18
    add r0, r5, #0
//    lsr r1, r1, #0x18
    mov r1, r6 // net -2
    mov r2, #0
    add r3, r4, #0
    bl 0x020263d8
    b @@_02027412
@@_020273f0:
    add r0, r5, r0
    mov r3, #MALE_FLAGS_OFFSET >> 4
    lsl r3, #4
    add r0, r3
    ldrb r0, [r0]
    tst r0, r1
    bne @@_next1
    mov r2, #0
@@_next1:
    cmp r2, r6
    beq @@_02027412
//    lsl r1, r6, #0x18
    add r0, r5, #0
//    lsr r1, r1, #0x18
	mov r1, r6
    mov r2, #1
    add r3, r4, #0
    bl 0x020263d8
@@_02027412:
    add r0, r5, #0
    add r1, r4, #0
    add r2, r7, #0
    bl 0x02026a60
    ldr r2, [sp, #4]
    add r0, r5, #0
    add r1, r4, #0
    bl 0x02026b88
    sub r6, r4, #1 // A50E => 7426
    //lsl r0, r0, #0x10
    //lsr r6, r0, #0x10
    add r1, r5, #CAUGHT_FLAGS_OFFSET
    asr r0, r6, #3
    mov r2, #7
    ldrb r4, [r1, r0]
    mov r3, #1
    and r2, r6
    lsl r3, r2
    add r2, r4, #0
    orr r2, r3
//    add r5, #0x44 // here
    mov r4, #SEEN_FLAGS_OFFSET >> 4
    lsl r4, #4
    add r5, r4 // net +4
    strb r2, [r1, r0]
    ldrb r1, [r5, r0]
    orr r1, r3
    strb r1, [r5, r0]
@@_02027448:
    add sp, #8
    pop {r3-r7, pc}

.pool

.endarea


.endif // ALLOW_SAVE_CHANGES


// debug edits to national dex status

.if ALWAYS_HAVE_NATIONAL_DEX == 1

.org 0x02027486
    mov r0, #1

.endif

.close
