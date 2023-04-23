.nds
.thumb

// big thanks to mikelan98 and nomura for this.  really cool stuff

.open "base/arm9.bin", 0x02000000

.org 0x02000CB4 // branch from Main(), run once
 
    bl load_arm9_expansion


.org 0x0207804c

.area 0x020780c4-.
 
load_arm9_expansion: // load the narc subfile with arm9 expansion data
    push {r2, lr}
//    mov r0, #5
//    bl rom_self_check //perform self check 1
//    mov r0, #13
//    bl rom_self_check //perform self check 2

// load overlay 121 as arm9 expansion
    mov r0, #121
    mov r1, #2
    bl HandleLoadOverlay121 // HandleLoadOverlay(121, 2) // noinit load

// get entirely rid of synthetic overlay
//// load synthetic narc to the same destination to complete the arm9 expansion and keep compatibility
//    ldr r0, =0x023C8000 // destination ram offset
//    mov r1, #0x41 // weather_sys - archive 65
//    mov r2, #9 // 9th file of archive 65
//    bl 0x2006AA4 // ArchiveDataLoad(&(0x02FC8000), 65, 9);
    
    mov r0, #0
    mov r1, #3
    pop {r2, pc}

HandleLoadOverlay121:
	push {r3-r7, lr}
	mov r4, r1
	mov r1, #0
	mvn r1, r1
	ldr r2, =0x02006598|1 // Overlay_Load+8, need normal loading for the first one
	bx r2

.pool

.endarea


; .org 0x0211025C

; rom_self_check: // scan self for corrupted data
;     push {r3, lr}
;     mov r2, r0
;     ldr r0, =0x023C8000 // destination ram offset
;     ldr r1, =#262 // a262
;     bl 0x2007508 // load_from_narc(&(0x023C8000), 262, 5) first run, load_from_narc(&(0x023C8000), 262, 13) second run
;     ldr r0, =0xFFFF
;     ldr r1, =0x023C8000
;     ldr r2, =0xC2A
;     swi 0x0e //crc-16
;     ldr r1, =0xD65B
;     cmp r0, r1
;     bne rom_invalid
;     mov r0, #0
;     mov r1, #3
;     pop {r3, pc}

; rom_invalid:
;     swi 0x00

; .pool
 
.close
