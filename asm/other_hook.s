.text
.align 2
.thumb

.include "offset_def.s"

/*不同形态的图片读取*/
.global PokePicLoad
PokePicLoad:
ldr r6, [sp, #0x18]
ldr r1, [sp, #0x1C]
mov r0, #0x0
strh r0, [r5, #0x6]
strb r0, [r5, #0x8]
str r0, [r5, #0xC]
push {r0-r3}
sub sp, #0x4
str r1, [sp, #0x0]
mov r0, r5
mov r1, r4
mov r2, r3
mov r3, r6
bl GetOtherFormPic
add sp, #0x4
cmp r0, #0x0
bne HaveNewPic
pop {r0-r3}
ldr r0, =0x020701F8 + 1
bx r0

HaveNewPic:
pop {r0-r3}
pop {r3-r7,pc}

//形态变化恢复
.global TryRevertFormChange_hook
TryRevertFormChange_hook:
lsl r0, r0, #0x2
add r2, r5, r0
lsl r1, r4, #0x2
ldr r0, [r2, r1]
push {r0-r2}
mov r2, r4
mov r1, r6
mov r0, r5
bl TryRevertFormChange
pop {r0-r2}
ldr r3, =0x69B4 + Overlay_12_Start
bx r3

//战斗结束
.global Battle_End
Battle_End:
ldr r1, [r4, r3]
mov r7, r0
lsl r2, r2, #0x2
str r1, [r7, r2]
push {r0-r3}
mov r0, r4
bl BattleEndRevertFormChange
pop {r0-r3}
ldr r1, =0xB98 + Overlay_12_Start
bx r1

//小图标色板
.global IconPalGet
IconPalGet:
push {r3}
bl PokeIconPalNumGet
pop {r3}
ldr r1, =0x020743F8 + 1
bx r1

//mega
//hook 0802F89C
.global LoadMegaOam
LoadMegaOam:
mov r3, #0x4
ldr r1, [sp, #0x38]
str r0, [sp, #0x0]
ldrb r0, [r6, #0x3]
push {r0-r3}
mov r0, r5
bl LoadMegaIcon
pop {r0-r3}
ldr r2, =0x2F8A4 + Overlay_12_Start
bx r2

//0802FBFC
.global load_mega_button
load_mega_button:
mov r1, #0x4D
str r0, [sp, #0x0]
push {r1-r3}
mov r0, r5
bl LoadMegaButton
pop {r1-r3}
mov r0, #0x3
str r0, [sp, #0x4]
ldr r0, =0x2FC04 + Overlay_12_Start
bx r0

//08030644
.global MegaButtonCheck
MegaButtonCheck:
mov r2, r5
add r2, r2, #0x1C
push {r0-r3}
mov r0, r5
mov r1, r4
bl CheckMegaButton
cmp r0, #0x0
bne end
pop {r0-r3}
cmp r4, #0x1
blt sub_803065Ah
ldr r3, =0x3064C + Overlay_12_Start
bx r3

sub_803065Ah:
ldr r0, =0x3065A + Overlay_12_Start
bx r0

end:
pop {r0-r3}
mov r0, #0x0
mvn r0, r0
pop {r3-r7,pc}

//02234868
//08018A48
.global hook_7_spriteOffsetSpecies
hook_7_spriteOffsetSpecies:
// sp+18 is form--apparently not.
push {r0-r5, r7}
mov r0, r6
ldr r1, =word_to_store_form_at
ldr r1, [r1]
bl GetSpeciesBasedOnForm // (species, form)
mov r6, r0
pop {r0-r5, r7}
str r0, [sp]
lsl r0, r6, #0x10
lsl r1, r1, #0x18
lsr r0, #0x10
ldr r3, =0x02234870 | 1
bx r3


//02259A14
//08022154
.global hook_12_spriteOffsetSpecies
hook_12_spriteOffsetSpecies:
// pretty sure this one is right.
push {r0-r7}
ldr r1, =word_to_store_form_at
ldr r1, [r1]
ldrh r0, [r5, #2]
bl GetSpeciesBasedOnForm // (species, form)
strh r0, [r5, #2]
pop {r0-r7}
ldr r0, [r5, #4]
str r0, [sp]
ldrb r3, [r5, #1]
ldrh r0, [r5, #2]
ldr r2, =0x02259A1C | 1
bx r2

.align 2
.global word_to_store_form_at
word_to_store_form_at:
.word 0

//08009A74
.global CheckCanTakeItem
CheckCanTakeItem:
add r0, r5, r1
ldrh r0, [r0,r3]
push {r1-r5}
bl CheckItemByThief
pop {r1-r5}
cmp r0, #0x0
beq backToThief_1
ldr r0, =0x9A7C + Overlay_12_Start
bx r0

backToThief_1:
ldr r0, =0x9A86 + Overlay_12_Start
bx r0

.pool



// 02241bac
// edits to the beginning of EncountParamSetRare to extract species + form
// r0 is species | (form << 11)
// treating r4-r7 as free since this function is only called at the end of other ones
.global get_form_out_of_encounter_species_rare
get_form_out_of_encounter_species_rare:
// ldr r4, =0xF800
mov r4, #0xF8
lsl r4, #8
and r4, r0
lsr r4, #11
ldr r5, =space_for_setmondata
strb r4, [r5]

// ldr r4, =0x07FF
mov r4, #7
lsl r4, #8
add r4, #0xFF
and r0, r4 // make r0 solely the species


// reset the function up:
push {r3-r7, lr}
sub sp, #0x28
str r0, [sp, #0x10]
ldr r6, [sp, #0x40]
ldr r4, =0x02241bb4 | 1
bx r4



// 02241ca4 - end of above function
// sp1C is param
// need to set form
.global modify_species_encounter_data_rare
modify_species_encounter_data_rare:
push {r0-r3}

ldr r0, [sp, #(0x1c+0x10)] // pp
mov r1, #112 // ID_PARA_form_no
ldr r2, =space_for_setmondata // &form
bl call_setmondata

ldr r0, [sp, #(0x1c+0x10)] // pp
bl UpdateFormIfDeerling

// hopefully with form set, this grabs everything correctly (it should please please please)
ldr r0, [sp, #(0x1c+0x10)] // pp
ldr r3, =0x0207418C | 1 //PokeParaCalc(pp);
bl call_via_r3
ldr r0, [sp, #(0x1c+0x10)] // pp
ldr r3, =0x0207803C | 1 //PokeParaSpeabiSet(pp);
bl call_via_r3
ldr r0, [sp, #(0x1c+0x10)] // pp
ldr r3, =0x02077020 | 1 //InitBoxMonMoveset(ppp);
bl call_via_r3

pop {r0-r3}
add r1, r6, #0
bl 0x02242514 // should not need longcall
ldr r0, [sp, #0x1c]
ldr r5, =0x02241cb4 | 1
bx r5

.pool



// 02241cc0
// edits to the beginning of EncountParamSet to extract species + form
// r0 is species | (form << 11)
// treating r4-r7 as free since this function is only called at the end of other ones
.global get_form_out_of_encounter_species
get_form_out_of_encounter_species:
// ldr r4, =0xF800
mov r4, #0xF8
lsl r4, #8
and r4, r0
lsr r4, #11
ldr r5, =space_for_setmondata
str r4, [r5]

// ldr r4, =0x07FF
mov r4, #7
lsl r4, #8
add r4, #0xFF
and r0, r4 // make r0 solely the species

// re-setup the function
push {r4-r7, lr}
sub sp, #0x14

mov r7, r0
mov r0, #0xb
ldr r4, =0x02241cc8 | 1
bx r4


// 02241d9c - end of above function
// r4 is param
// need to set form
.global modify_species_encounter_data
modify_species_encounter_data:
bl call_setmondata // set the id number
mov r0, r4 // pp
mov r1, #112 // ID_PARA_form_no
ldr r2, =space_for_setmondata // &form
bl call_setmondata

mov r0, r4
bl UpdateFormIfDeerling

// hopefully with form set, this grabs everything correctly
mov r0, r4
ldr r3, =0x0207418C | 1 //PokeParaCalc(pp);
bl call_via_r3
mov r0, r4
ldr r3, =0x0207803C | 1 //PokeParaSpeabiSet(pp);
bl call_via_r3
mov r0, r4 // me when the boxmon is at offset 0 of the PartyPokemon structure so i should be able to just pass it like this and have it work :)
ldr r3, =0x02077020 | 1 //InitBoxMonMoveset(ppp);
bl call_via_r3

ldr r0, [sp, #0x10]
ldr r3, [sp, #0x2c]
mov r1, r5
ldr r5, =0x02241da6 | 1
bx r5

call_setmondata:
ldr r3, =0x02074B30 | 1
call_via_r3:
bx r3

.pool

.global space_for_setmondata
space_for_setmondata:
.word 0


// need to expand the table that remaps "move effects" to subscripts
// r4 is effect to grab, r0 and r1 are free, needs to pop {r4, pc} at the end
.global remap_move_effect_to_subscript_table
remap_move_effect_to_subscript_table:
ldr r0, =move_effect_to_subscripts
lsl r1, r4, #2
ldr r0, [r0, r1]
pop {r4, pc}


.global fix_money_calc
fix_money_calc:
ldr r5, =gLastPokemonLevelForMoneyCalc
ldrh r5, [r5]
ldr r0, =0x0223FBBE | 1
bx r0

.pool

.global gLastPokemonLevelForMoneyCalc
gLastPokemonLevelForMoneyCalc:
.word 0


.global UseItemFormeChange_hook
UseItemFormeChange_hook:
push {r1-r7}

mov r0, r5
mov r1, r4 // so that the memory can be freed
bl UseItemFormeChangeCheck

pop {r1-r7}
cmp r0, #1
bne return_to_0207C2D2
mov r0, #31
ldr r1, =0x0207C2D0 | 1 // else return 31
bx r1

return_to_0207C2D2:
ldr r0, =0x0207C2D2 | 1
bx r0

.pool


.global Sav2_Misc_init_new_fields_hook
Sav2_Misc_init_new_fields_hook:
mov r0, r4
bl Sav2_Misc_init_new_fields // new init function
mov r0, r4
bl 0x0202ADEC // ApricornTrees_Init, should not need longcall honestly
mov r0, #2
ldr r1, =(0x0202A8D4 | 1)
bx r1

.pool


.global set_proper_mega_status
set_proper_mega_status:
cmp r4, #7
blt jump_to_2266130
push {r0-r7}

mov r0, r6 // bip
bl SwapOutBottomScreen

pop {r0-r7}
//mov r4, #0
//str r0, [r6, r1]
//ldr r7, =0x0226E298 // already loaded this above
//ldr r0, =0x02266130 | 1
//bx r0
ldr r0, [sp, #0xC]
bl 0x0226ADC4
ldr r1, =0x0226618E | 1
bx r1


jump_to_2266130:
ldr r0, =0x02266130 | 1
bx r0

.pool


.global shift_cancel_over
shift_cancel_over:
push {r1-r7}

mov r0, r5 // bip
bl GrabCancelXValue

pop {r1-r7}
str r0, [sp, #0xC]
mov r0, #175 // y value
str r0, [sp, #0x10]

ldr r0, =0x02267634 | 1
bx r0

.pool


// need to grab species, pid, form
.global grab_sex_for_GetBoxMonData
grab_sex_for_GetBoxMonData:
ldr r1, [sp]
ldrh r0, [r5]
ldr r1, [r1]
ldrb r2, [r6, #0x18]
bl GrabSexFromSpeciesAndForm
ldr r1, =0x0206EA24|1
bx r1



// dex expansion



// still need to call 0x02018144 (AllocMemory) with a heapid (r0) of r6, and size (r1) of mons_no*8
// then call 0x020D5124 (memset) with r0 = p->poke_list, r1 = 0, r2 = size (mons_no*8)
// call 0x020181C4 (sys_FreeMemoryEz) with the pointer in r0 to free up the memory upon destroying dex

// r5 = p_glb
// r6 = heap
.global allocate_lists
allocate_lists:
    push {r0-r7, lr}

    // allocate for zkn_pokelist_tbl - extra (19) entries are to ensure no garbage data gets displayed at the end

    mov r0, r6 // heap
    ldr r1, =((NUM_OF_MONS + 19) * 8)
    bl 0x02018144 // allocate the memory

    str r0, [r5, #4] // workspace+4 (p_glb->poke_list->zkn_pokelist_tbl) = sys_AllocMemory(heap, NUM_OF_MONS * 8)

    mov r1, #0
    ldr r2, =((NUM_OF_MONS + 19) * 8)
    blx 0x020D5124 // memset(new_zkn_pokelist_tbl, 0, NUM_OF_MONS * 8)

    // allocate for zkn_pokelistdraw_tbl - extra entries are to ensure no garbage data at the end

    mov r0, r6 // heap
    ldr r1, =((NUM_OF_MONS + 19) * 4)
    bl 0x02018144 // allocate the memory

    ldr r1, =0xF74
    str r0, [r5, r1] // workspace+0xF74 (p_glb->poke_list->zkn_pokelistdraw_tbl) = sys_AllocMemory(heap, NUM_OF_MONS * 4)

    mov r1, #0
    ldr r2, =((NUM_OF_MONS + 19) * 4)
    blx 0x020D5124 // memset(new_zkn_pokelistdraw_tbl, 0, NUM_OF_MONS * 4)

    // should be all good; restore values and branch back

    pop {r0-r7}
    ldr r0, [r4]
    str r0, [r5]
    pop {pc}

.pool

// r4 = p_glb
.global unallocate_lists
unallocate_lists:
    push {r0-r7, lr}

    // now need to unallocate the space

    ldr r0, [r4, #4]
    bl 0x020181C4 // sys_FreeMemoryEz(new_zkn_pokelist_tbl)

    ldr r0, =0xF74
    ldr r0, [r4, r0]
    bl 0x020181C4 // sys_FreeMemoryEz(new_zkn_pokelistdraw_tbl)

    // clean up and branch back

    pop {r0-r7}
    mov r1, #0
    str r1, [r4, r0]
    pop {pc}

.pool

.global PokeMonsTypeGet_patch
PokeMonsTypeGet_patch:
    ldr r0, [r0, #4]
    add r0, [r0, r1]
    ldr r0, [r0, #4]
    bx lr
