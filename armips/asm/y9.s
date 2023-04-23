.nds

COMPRESSED equ 0x01000000
UNCOMPRESSED equ 0x00000000

.open "base/overarm9.bin", 0
                  //       id, memaddress,                                   memsize,    bsssize,  initstart,    initend, fid, filesize | compressed
// TODO: put platinum data

.org 121 * 0x20 // new overlays

// arm9 expansion overlay
.word 121, 0x023C8000, filesize("base/overlay/overlay_0129.bin"), 0x00000000, 0x023C8000, 0x023C8000, 121, UNCOMPRESSED // arm9 expansion
.word 122, 0x023D0000, filesize("base/overlay/overlay_0130.bin"), 0x00000000, 0x023D0000, 0x023D0000, 122, UNCOMPRESSED // battle overlay
.word 123, 0x023D0000, filesize("base/overlay/overlay_0131.bin"), 0x00000000, 0x023D0000, 0x023D0000, 123, UNCOMPRESSED // field overlay

.close
