#include "../../include/types.h"
#include "../../include/battle.h"
#include "../../include/pokemon.h"
#include "../../include/mega.h"
#include "../../include/sprite.h"
#include "../../include/constants/ability.h"
#include "../../include/constants/item.h"
#include "../../include/constants/file.h"
#include "../../include/constants/moves.h"
#include "../../include/constants/species.h"

struct MegaStruct
{
    u16 monindex;
    u16 itemindex;
};

struct MegaStructMove
{
    u16 monindex;
    u16 moveindex;
};

#ifdef MEGA_EVOLUTIONS
const struct MegaStruct sMegaTable[] =
{
    {
        .monindex = SPECIES_VENUSAUR, 
        .itemindex = ITEM_MEGA_STONE_VENUSAUR,
    },
    {
        .monindex = SPECIES_CHARIZARD, 
        .itemindex = ITEM_MEGA_STONE_CHARIZARD_X,
    }, // x
    {
        .monindex = SPECIES_CHARIZARD, 
        .itemindex = ITEM_MEGA_STONE_CHARIZARD_Y,
    }, // y
    {
        .monindex = SPECIES_BLASTOISE, 
        .itemindex = ITEM_MEGA_STONE_BLASTOISE,
    },
    {
        .monindex = SPECIES_BEEDRILL, 
        .itemindex = ITEM_MEGA_STONE_BEEDRILL,
    },
    {
        .monindex = SPECIES_PIDGEOT, 
        .itemindex = ITEM_MEGA_STONE_PIDGEOT,
    },
    {
        .monindex = SPECIES_ALAKAZAM, 
        .itemindex = ITEM_MEGA_STONE_ALAKAZAM,
    },
    {
        .monindex = SPECIES_SLOWBRO, 
        .itemindex = ITEM_MEGA_STONE_SLOWBRO,
    },
    {
        .monindex = SPECIES_GENGAR, 
        .itemindex = ITEM_MEGA_STONE_GENGAR,
    },
    {
        .monindex = SPECIES_KANGASKHAN, 
        .itemindex = ITEM_MEGA_STONE_KANGASKHAN,
    },
    {
        .monindex = SPECIES_PINSIR, 
        .itemindex = ITEM_MEGA_STONE_PINSIR,
    },
    {
        .monindex = SPECIES_GYARADOS, 
        .itemindex = ITEM_MEGA_STONE_GYARADOS,
    },
    {
        .monindex = SPECIES_AERODACTYL, 
        .itemindex = ITEM_MEGA_STONE_AERODACTYL,
    },
    {
        .monindex = SPECIES_MEWTWO, 
        .itemindex = ITEM_MEGA_STONE_MEWTWO_X,
    }, // x
    {
        .monindex = SPECIES_MEWTWO, 
        .itemindex = ITEM_MEGA_STONE_MEWTWO_Y,
    }, // y
    {
        .monindex = SPECIES_AMPHAROS, 
        .itemindex = ITEM_MEGA_STONE_AMPHAROS,
    },
    {
        .monindex = SPECIES_STEELIX, 
        .itemindex = ITEM_MEGA_STONE_STEELIX,
    },
    {
        .monindex = SPECIES_SCIZOR, 
        .itemindex = ITEM_MEGA_STONE_SCIZOR,
    },
    {
        .monindex = SPECIES_HERACROSS, 
        .itemindex = ITEM_MEGA_STONE_HERACROSS,
    },
    {
        .monindex = SPECIES_HOUNDOOM, 
        .itemindex = ITEM_MEGA_STONE_HOUNDOOM,
    },
    {
        .monindex = SPECIES_TYRANITAR, 
        .itemindex = ITEM_MEGA_STONE_TYRANITAR,
    },
    {
        .monindex = SPECIES_SCEPTILE, 
        .itemindex = ITEM_MEGA_STONE_SCEPTILE,
    },
    {
        .monindex = SPECIES_BLAZIKEN, 
        .itemindex = ITEM_MEGA_STONE_BLAZIKEN,
    },
    {
        .monindex = SPECIES_SWAMPERT, 
        .itemindex = ITEM_MEGA_STONE_SWAMPERT,
    },
    {
        .monindex = SPECIES_GARDEVOIR, 
        .itemindex = ITEM_MEGA_STONE_GARDEVOIR,
    },
    {
        .monindex = SPECIES_SABLEYE, 
        .itemindex = ITEM_MEGA_STONE_SABLEYE,
    },
    {
        .monindex = SPECIES_MAWILE, 
        .itemindex = ITEM_MEGA_STONE_MAWILE,
    },
    {
        .monindex = SPECIES_AGGRON, 
        .itemindex = ITEM_MEGA_STONE_AGGRON,
    },
    {
        .monindex = SPECIES_MEDICHAM, 
        .itemindex = ITEM_MEGA_STONE_MEDICHAM,
    },
    {
        .monindex = SPECIES_MANECTRIC, 
        .itemindex = ITEM_MEGA_STONE_MANECTRIC,
    },
    {
        .monindex = SPECIES_SHARPEDO, 
        .itemindex = ITEM_MEGA_STONE_SHARPEDO,
    },
    {
        .monindex = SPECIES_CAMERUPT, 
        .itemindex = ITEM_MEGA_STONE_CAMERUPT,
    },
    {
        .monindex = SPECIES_ALTARIA, 
        .itemindex = ITEM_MEGA_STONE_ALTARIA,
    },
    {
        .monindex = SPECIES_BANETTE, 
        .itemindex = ITEM_MEGA_STONE_BANETTE,
    },
    {
        .monindex = SPECIES_ABSOL, 
        .itemindex = ITEM_MEGA_STONE_ABSOL,
    },
    {
        .monindex = SPECIES_GLALIE, 
        .itemindex = ITEM_MEGA_STONE_GLALIE,
    },
    {
        .monindex = SPECIES_SALAMENCE, 
        .itemindex = ITEM_MEGA_STONE_SALAMENCE,
    },
    {
        .monindex = SPECIES_METAGROSS, 
        .itemindex = ITEM_MEGA_STONE_METAGROSS,
    },
    {
        .monindex = SPECIES_LATIAS, 
        .itemindex = ITEM_MEGA_STONE_LATIAS,
    },
    {
        .monindex = SPECIES_LATIOS, 
        .itemindex = ITEM_MEGA_STONE_LATIOS,
    },
    {
        .monindex = SPECIES_LOPUNNY, 
        .itemindex = ITEM_MEGA_STONE_LOPUNNY,
    },
    {
        .monindex = SPECIES_GARCHOMP, 
        .itemindex = ITEM_MEGA_STONE_GARCHOMP,
    },
    {
        .monindex = SPECIES_LUCARIO, 
        .itemindex = ITEM_MEGA_STONE_LUCARIO,
    },
    {
        .monindex = SPECIES_ABOMASNOW, 
        .itemindex = ITEM_MEGA_STONE_ABOMASNOW,
    },
    {
        .monindex = SPECIES_GALLADE, 
        .itemindex = ITEM_MEGA_STONE_GALLADE,
    },
    {
        .monindex = SPECIES_AUDINO, 
        .itemindex = ITEM_MEGA_STONE_AUDINO,
    },
    {
        .monindex = SPECIES_DIANCIE, 
        .itemindex = ITEM_MEGA_STONE_DIANCIE,
    },
};

const struct MegaStructMove sMegaMoveTable[] =
{
    {
        .monindex = SPECIES_RAYQUAZA, 
        .moveindex = MOVE_DRAGON_ASCENT,
    },
};
#endif // MEGA_EVOLUTIONS

static BOOL CheckMegaData(u16 mon, u16 item);

BOOL CheckCanMega(struct BattleStruct *battle, int client)
{
    u16 mon = battle->battlemon[client].species;
    u16 item = battle->battlemon[client].item;

    if(battle->battlemon[client].canMega)
        return FALSE;

    if(newBS.SideMega[client&1])
        return FALSE;

    if(battle->battlemon[client].form_no)
        return FALSE;

    if(battle->client_act_work[client][3] != SELECT_FIGHT_COMMAND)
        return FALSE;

    return CheckMegaData(mon,item);
}

BOOL IsMegaSpecies(u16 mon)
{
#ifdef MEGA_EVOLUTIONS
    u8 i;
    for (i = 0; i < NELEMS(sMegaTable); i++)
    {
        if (sMegaTable[i].monindex == mon)
        {
            return TRUE;
        }
    }
#endif // MEGA_EVOLUTIONS    
    return FALSE;
}

BOOL CheckIsMega(struct BI_PARAM *bip)
{
    void *pp;
    u16 form_no;
    u16 mon;

    pp = BattleWorkPokemonParamGet(bip->bw, bip->client_no, bip->sel_mons_no);
    mon = GetMonData(pp, ID_PARA_monsno, 0);
    form_no = GetMonData(pp, ID_PARA_form_no, 0);
    if (!form_no)
        return FALSE;

    return IsMegaSpecies(mon) || IsMegaSpeciesByMove(mon);
}

BOOL CheckIsPrimalGroudon(struct BI_PARAM *bip)
{
#ifdef PRIMAL_REVERSION
    void *pp;
    u16 form_no;
    u16 mon;

    pp = BattleWorkPokemonParamGet(bip->bw, bip->client_no, bip->sel_mons_no);
    mon = GetMonData(pp, ID_PARA_monsno, 0);
    form_no = GetMonData(pp, ID_PARA_form_no, 0);
    if (!form_no)
        return FALSE;

    return (mon == SPECIES_GROUDON);
#else
    return FALSE;
#endif // PRIMAL_REVERSION
}

BOOL CheckIsPrimalKyogre(struct BI_PARAM *bip)
{
#ifdef PRIMAL_REVERSION
    void *pp;
    u16 form_no;
    u16 mon;

    pp = BattleWorkPokemonParamGet(bip->bw, bip->client_no, bip->sel_mons_no);
    mon = GetMonData(pp, ID_PARA_monsno, 0);
    form_no = GetMonData(pp, ID_PARA_form_no, 0);
    if (!form_no)
        return FALSE;

    return (mon == SPECIES_KYOGRE);
#else
    return FALSE;
#endif // PRIMAL_REVERSION
}

static BOOL CheckMegaData(u16 mon, u16 item)
{
#ifdef MEGA_EVOLUTIONS
    u8 i;
    for (i = 0; i < NELEMS(sMegaTable);i++)
    {
        if (sMegaTable[i].monindex == mon && sMegaTable[i].itemindex == item)
        {
            return TRUE;
        }
    }
#endif // MEGA_EVOLUTIONS
    return FALSE;
}

BOOL CheckCanDrawMegaButton(struct BI_PARAM *bip)
{
    void *pp;
    u16 item;
    u16 mon;

    pp = BattleWorkPokemonParamGet(bip->bw, bip->client_no, bip->sel_mons_no);
    item = GetMonData(pp, ID_PARA_item, 0);
    mon = GetMonData(pp, ID_PARA_monsno, 0);

    return CheckMegaData(mon, item);
}

BOOL CheckCanMoveMegaEvolve(struct BattleStruct *sp, u32 client)
{
#ifdef MEGA_EVOLUTIONS
    int i = 0, form = 0;
    u16 species, move;

    species = sp->battlemon[client].species;
    form = sp->battlemon[client].form_no;
    move = ST_ServerSelectWazaGet(sp, client);

    if (form != 0 || newBS.PlayerMegaed) return FALSE;

    for (i = 0; i < NELEMS(sMegaMoveTable); i++)
    {
        if (species == sMegaMoveTable[i].monindex && move == sMegaMoveTable[i].moveindex)
        {
            return TRUE;
        }
    }
#endif // MEGA_EVOLUTIONS
    
    return FALSE;
}

BOOL CheckCanSpeciesMegaEvolveByMove(struct BattleStruct *sp, u32 client)
{
#ifdef MEGA_EVOLUTIONS
    int i, species, move;
    
    species = sp->battlemon[client].species;
    move = ST_ServerSelectWazaGet(sp, client);
    
    for (i = 0; i < NELEMS(sMegaMoveTable); i++)
    {
        if (species == sMegaMoveTable[i].monindex && move == sMegaMoveTable[i].moveindex)
        {
            return TRUE;
        }
    }
#endif // MEGA_EVOLUTIONS
    
    return FALSE;
}

BOOL IsMegaSpeciesByMove(u16 species)
{
#ifdef MEGA_EVOLUTIONS
    int i;
    
    for (i = 0; i < NELEMS(sMegaMoveTable); i++)
    {
        if (species == sMegaMoveTable[i].monindex)
        {
            return TRUE;
        }
    }
#endif // MEGA_EVOLUTIONS
    
    return FALSE;
}
