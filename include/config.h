#ifndef CONFIG_H
#define CONFIG_H

// FAIRY_TYPE_IMPLEMENTED should be used if you want to implement the fairy type and overwrite type 9 in this project
// set FAIRY_TYPE_IMPLEMENTED to 0 if you do not want this to happen
#define FAIRY_TYPE_IMPLEMENTED 1

// START_ADDRESS should be the same as armips/include/config.h's START_ADDRESS so that hall of fame/pokéathlon overworlds work properly.
// START_ADDRESS defines the file address within the synthetic overlay where you would like to place all of the code that this project uses.  this is largely the repointed tables that the code uses.
// if START_ADDRESS is 0x10000, then the tables will be inserted at address 0x10000 of the synthetic overlay
// the current implementation (with all gen 5 mons) uses ~9222/0x2406 bytes.  make sure this points to that much free space (probably allow for a little bit more than that)
#define START_ADDRESS 0x0

// ALLOW_SAVE_CHANGES will allow save file field expansions for full feature implementation, but will break compatibility with PKHeX
// commenting out this define will disable kyurem's forme change method and keep saves compatible with pkhex
#define ALLOW_SAVE_CHANGES

// CRY_PSEUDOBANK_START defines the first pseudobank to be used as cries in the sdat.  cries are loaded differently to save on RAM space
#define CRY_PSEUDOBANK_START 778

// EXPERIENCE_FORMULA_GEN defines the experience formula you would like to use.  Gens 5, 7, and 8 consider the difference between the attacker's level and the fainted's level to scale the experience gained.
// i.e. defining this as "5", "7", or "8" would use a scaled formula, whereas "6" and others would use the default formula.  There is a multiplier of 255 / 390 to not artificially inflate the experience given as well with higher base experience.
#define EXPERIENCE_FORMULA_GEN 8

// HIDDEN_ABILITIES defines whether or not Pokémon with their hidden ability bit set will receive their hidden abilities when being generated/changing form in battle.
// commenting this line out essentially disables hidden abilities to maintain default behavior, while leaving this as-is will introduce hidden abilities and all of their handling.
// just need to set the HIDDEN_ABILITIES_FLAG from the save and then every mon should be generated with its hidden ability until the flag is cleared from another script
#define HIDDEN_ABILITIES
#define HIDDEN_ABILITIES_FLAG 2600
#define HIDDEN_ABILITIES_STARTERS_FLAG 2601

// MEGA_EVOLUTIONS defines whether or not Pokémon that are able to mega evolve will be able to do so.
// commenting this line out essentially disables mega evolutions and maintains default behavior with respect to them.  leaving this as-is will introduce mega evolutions when applied to the game.
#define MEGA_EVOLUTIONS

// PRIMAL_REVERSION defines whether or not Kyogre and Groudon, when holding their orbs, will be able to change form when sent out in battle.
// commenting this line out essentially disables primal reversion.  leaving this as-is will introduce primal reversions when applied to the game.
#define PRIMAL_REVERSION

// ITEM_POCKET_EXPANSION defines whether or not item pockets will be given extra slots in the save in order to provide space for new items that are implemented
// commenting this line out will prevent the item pockets from being expanded for the new items
#define ITEM_POCKET_EXPANSION

// IMPLEMENT_BDHCAM_ROUTINE defines whether or not the BDHCam routine (by Mikelan) will be built into the ROM.  this is necessary to get it shiftable because DSPRE writes it to a fixed location
// uncommenting this line will include it in your ROM
#define IMPLEMENT_BDHCAM_ROUTINE

// IMPLEMENT_TRANSPARENT_TEXTBOXES should be used if you want to implement transparent textboxes
// uncommenting this line out will enable transparent textboxes
//#define IMPLEMENT_TRANSPARENT_TEXTBOXES

#endif
