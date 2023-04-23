#include "../../include/types.h"
#include "../../include/battle.h"
#include "../../include/pokemon.h"
#include "../../include/constants/ability.h"
#include "../../include/constants/battle_message_constants.h"
#include "../../include/constants/battle_script_constants.h"
#include "../../include/constants/file.h"
#include "../../include/constants/game.h"
#include "../../include/constants/item.h"
#include "../../include/constants/moves.h"
#include "../../include/constants/species.h"

struct ILLUSION_STRUCT gIllusionStruct = {0};

BOOL BattleFormChangeCheck(void *bw, struct BattleStruct *sp, int *seq_no)
{
    int i, form_no;
    BOOL ret = FALSE;

    for (i = 0; i < BattleWorkClientSetMaxGet(bw); i++)
    {
        sp->client_work = sp->turn_order[i];

        //handle castform
        if ((sp->battlemon[sp->client_work].species == SPECIES_CASTFORM)
         && (sp->battlemon[sp->client_work].hp)
         && (GetBattlerAbility(sp,sp->client_work) == ABILITY_FORECAST))
        {
            if ((CheckSideAbility(bw, sp, CHECK_ALL_BATTLER_ALIVE, 0, ABILITY_CLOUD_NINE) == 0)
             && (CheckSideAbility(bw, sp, CHECK_ALL_BATTLER_ALIVE, 0, ABILITY_AIR_LOCK) == 0))
            {
                if (((sp->field_condition & (WEATHER_RAIN_ANY | WEATHER_SUNNY_ANY | WEATHER_HAIL_ANY)) == 0)
                 && (sp->battlemon[sp->client_work].form_no != 0))
                {
//                    sp->battlemon[sp->client_work].type1 = TYPE_NORMAL;
//                    sp->battlemon[sp->client_work].type2 = TYPE_NORMAL;
                    sp->battlemon[sp->client_work].form_no = 0;
                    BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
                else if ((sp->field_condition & WEATHER_SUNNY_ANY)
                      && (sp->battlemon[sp->client_work].form_no != 1))
                {
//                    sp->battlemon[sp->client_work].type1 = TYPE_FIRE;
//                    sp->battlemon[sp->client_work].type2 = TYPE_FIRE;
                    sp->battlemon[sp->client_work].form_no = 1;
                    BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
                else if ((sp->field_condition & WEATHER_RAIN_ANY)
                      && (sp->battlemon[sp->client_work].form_no != 2))
                {
//                    sp->battlemon[sp->client_work].type1 = TYPE_WATER;
//                    sp->battlemon[sp->client_work].type2 = TYPE_WATER;
                    sp->battlemon[sp->client_work].form_no = 2;
                    BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
                else if ((sp->field_condition & WEATHER_HAIL_ANY)
                      && (sp->battlemon[sp->client_work].form_no != 3))
                {
//                    sp->battlemon[sp->client_work].type1 = TYPE_ICE;
//                    sp->battlemon[sp->client_work].type2 = TYPE_ICE;
                    sp->battlemon[sp->client_work].form_no = 3;
                    BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
            }
            else
            {
                if ((sp->battlemon[sp->client_work].form_no != 0))
                {
//                    sp->battlemon[sp->client_work].type1 = TYPE_NORMAL;
//                    sp->battlemon[sp->client_work].type2 = TYPE_NORMAL;
                    sp->battlemon[sp->client_work].form_no = 0;
                    BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
            }
        }

        // handle cherrim
        if ((sp->battlemon[sp->client_work].species == SPECIES_CHERRIM)
         && (sp->battlemon[sp->client_work].hp))
        {
            if ((CheckSideAbility(bw, sp, CHECK_ALL_BATTLER_ALIVE, 0, ABILITY_CLOUD_NINE) == 0)
             && (CheckSideAbility(bw, sp, CHECK_ALL_BATTLER_ALIVE, 0, ABILITY_AIR_LOCK) == 0))
            {
                if (((sp->field_condition & (WEATHER_RAIN_ANY | WEATHER_SUNNY_ANY | WEATHER_HAIL_ANY)) == 0)
                 && (sp->battlemon[sp->client_work].form_no == 1))
                {
                    sp->battlemon[sp->client_work].form_no = 0;
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
                else if ((sp->field_condition & WEATHER_SUNNY_ANY)
                      && (sp->battlemon[sp->client_work].form_no == 0))
                {
                    sp->battlemon[sp->client_work].form_no = 1;
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
                else if ((sp->field_condition & WEATHER_RAIN_ANY)
                      && (sp->battlemon[sp->client_work].form_no == 1))
                {
                    sp->battlemon[sp->client_work].form_no = 0;
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
                else if ((sp->field_condition & WEATHER_HAIL_ANY)
                      && (sp->battlemon[sp->client_work].form_no == 1))
                {
                    sp->battlemon[sp->client_work].form_no = 0;
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
            }
            else
            {
                if (sp->battlemon[sp->client_work].form_no == 1)
                {
                    sp->battlemon[sp->client_work].form_no = 0;
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
            }
        }

        // handle arceus
        if ((sp->battlemon[sp->client_work].species == SPECIES_ARCEUS)
         && (sp->battlemon[sp->client_work].hp)
         && (GetBattlerAbility(sp, sp->client_work) == ABILITY_MULTITYPE))
        {
            form_no = GetArceusType(BattleItemDataGet(sp, sp->battlemon[sp->client_work].item, 1));
            if(sp->battlemon[sp->client_work].form_no != form_no)
            {
                sp->battlemon[sp->client_work].form_no = form_no;
                *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                ret = TRUE;
                break;
            }
        }

        // handle Silvally TODO check if this actually works, eventually change to use the memories instead of plates
        if ((sp->battlemon[sp->client_work].species == SPECIES_SILVALLY)
            && (sp->battlemon[sp->client_work].hp)
            && (GetBattlerAbility(sp, sp->client_work) == ABILITY_RKS_SYSTEM))
        {
            form_no = GetArceusType(BattleItemDataGet(sp, sp->battlemon[sp->client_work].item, 1));
            if(sp->battlemon[sp->client_work].form_no != form_no)
            {
                sp->battlemon[sp->client_work].form_no = form_no;
                *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                ret = TRUE;
                break;
            }
        }

        // handle giratina
        if ((sp->battlemon[sp->client_work].species == SPECIES_GIRATINA)
         && (sp->battlemon[sp->client_work].hp)
         && (sp->battlemon[sp->client_work].form_no == 1))
        {
            if ((sp->battlemon[sp->client_work].condition2 & STATUS2_FLAG_TRANSFORMED)
             || (((BattleWorkBattleStatusFlagGet(bw) & 0x80) == 0) // probably distortion world check
              && (sp->battlemon[sp->client_work].item != ITEM_GRISEOUS_ORB)))
            {
                if(sp->battlemon[sp->client_work].condition2 & STATUS2_FLAG_TRANSFORMED)
                {
                    struct PartyPokemon *pp;
                    int defence;
                    int work;

                    pp = AllocMonZeroed(5);
                    if (BattleTypeGet(bw) & BATTLE_TYPE_DOUBLE)
                    {
                        defence = sp->client_act_work[sp->client_work][1];
                    }
                    else
                    {
                        defence = BATTLER_OPPONENT(sp->client_work);
                    }
                    PokeCopyPPtoPP(BattleWorkPokemonParamGet(bw, defence, sp->sel_mons_no[defence]), pp);
                    work = 0;
                    SetMonData(pp, ID_PARA_item, &work);
                    work = 0;
                    SetMonData(pp, ID_PARA_form_no, &work);
                    PokeParaGiratinaFormChange(pp);
                    sp->battlemon[sp->client_work].attack =  GetMonData(pp,ID_PARA_pow,      0);
                    sp->battlemon[sp->client_work].defense = GetMonData(pp,ID_PARA_def,      0);
                    sp->battlemon[sp->client_work].speed =   GetMonData(pp,ID_PARA_agi,      0);
                    sp->battlemon[sp->client_work].spatk =   GetMonData(pp,ID_PARA_spepow,   0);
                    sp->battlemon[sp->client_work].spdef =   GetMonData(pp,ID_PARA_spedef,   0);
                    sp->battlemon[sp->client_work].ability = GetMonData(pp,ID_PARA_speabino, 0);
                    sp->battlemon[sp->client_work].form_no = 0;
                    sp->server_status_flag2 |= SERVER_STATUS2_FLAG_FORM_CHANGE;
                    SCIO_PSPtoPPCopy(bw, sp, sp->client_work);
                    sys_FreeMemoryEz(pp);
                    *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
                else
                {
                    *seq_no = SUB_SEQ_GIRATINA_FORM_CHANGE;
                    ret = TRUE;
                    break;
                }
            }
        }

        // handle darmanitan zen mode
        if ((sp->battlemon[sp->client_work].species == SPECIES_DARMANITAN)
         && (GetBattlerAbility(sp, sp->client_work) == ABILITY_ZEN_MODE)
         && (sp->battlemon[sp->client_work].hp)
         && (sp->battlemon[sp->client_work].hp <= (sp->battlemon[sp->client_work].maxhp / 2))
         && (sp->battlemon[sp->client_work].form_no < 2)) // forms 0 and 1
        {
            sp->battlemon[sp->client_work].form_no += 2;
            BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
            *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
            ret = TRUE;
            break;
        } else if ((sp->battlemon[sp->client_work].species == SPECIES_DARMANITAN)
         && (sp->battlemon[sp->client_work].hp)
         && (sp->battlemon[sp->client_work].hp > (sp->battlemon[sp->client_work].maxhp / 2) || (GetBattlerAbility(sp, sp->client_work) != ABILITY_ZEN_MODE))
         && (sp->battlemon[sp->client_work].form_no >= 2)) // forms 2 and 3
        {
            sp->battlemon[sp->client_work].form_no -= 2;
            BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
            *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
            ret = TRUE;
            break;
        }

        // fuck illusion
        if ((sp->battlemon[sp->client_work].species == SPECIES_ZORUA || sp->battlemon[sp->client_work].species == SPECIES_ZOROARK)
         && gIllusionStruct.isSideInIllusion[sp->client_work & 1] == 1
         && (sp->oneSelfFlag[sp->client_work].physical_damage || sp->oneSelfFlag[sp->client_work].special_damage))
        {
            SetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, sp->client_work), gIllusionStruct.illusionPos[sp->client_work & 1]), ID_PARA_nickname, gIllusionStruct.illusionNameBuf[sp->client_work & 1]);

            gIllusionStruct.isSideInIllusion[sp->client_work & 1] = 0;
            gIllusionStruct.illusionPos[sp->client_work & 1] = 0;
            for (int k = 0; k < 11; k++)
            {
                sp->battlemon[sp->client_work].nickname[k] = gIllusionStruct.illusionNameBuf[sp->client_work & 1][k];
                gIllusionStruct.illusionNameBuf[sp->client_work & 1][k] = 0;
            }
            BattleFormChange(sp->client_work, 0, bw, sp, 0);
            *seq_no = SUB_SEQ_HANDLE_ILLUSION_FADED;
            ret = TRUE;
            break;
        }

        // handle meloetta - change form to pirouette when using relic song.  changes back when switching/battle ends too
        if ((sp->battlemon[sp->client_work].species == SPECIES_MELOETTA)
         && (sp->battlemon[sp->client_work].hp)
         && !(sp->waza_status_flag & MOVE_STATUS_FLAG_FAILED)
         && (sp->waza_no_old[sp->client_work] == MOVE_RELIC_SONG)
         && (sp->battlemon[sp->client_work].form_no != 1))
        {
            sp->battlemon[sp->client_work].form_no = 1;
            BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 1);
            *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
            ret = TRUE;
            break;
        }

        // handle genesect
        if ((sp->battlemon[sp->client_work].species == SPECIES_GENESECT)
         && (sp->battlemon[sp->client_work].hp))
        {
            form_no = GetGenesectForme(sp->battlemon[sp->client_work].item);
            if(sp->battlemon[sp->client_work].form_no != form_no)
            {
                sp->battlemon[sp->client_work].form_no = form_no;
                *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
                ret = TRUE;
                break;
            }
        }



        // handle Zygarde TODO test
        if ((sp->battlemon[sp->client_work].species == SPECIES_ZYGARDE)
         && (sp->battlemon[sp->client_work].hp)
         && (sp->battlemon[sp->client_work].hp <= (sp->battlemon[sp->client_work].maxhp / 2))
         && (sp->battlemon[sp->client_work].form_no == 2 || sp->battlemon[sp->client_work].form_no == 3))
        {
            //TODO this has not yet been tested
            sp->battlemon[sp->client_work].form_no += 2;
            BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 0);
            sp->hp_calc_work = sp->battlemon[sp->attack_client].maxhp - sp->battlemon[sp->attack_client].hp;
            void *pp2 = BattleWorkPokemonParamGet(bw, sp->client_work, sp->sel_mons_no[sp->client_work]);
            sp->battlemon[sp->client_work].maxhp = GetMonData(pp2, ID_PARA_hpmax, NULL);
            *seq_no = SUB_SEQ_HANDLE_ZYGARDE_FORM_CHANGE;
            ret = TRUE;
        }

        // handle Wishiwashi TODO test (also at some point add custom transform text)
        if ((sp->battlemon[sp->client_work].species == SPECIES_WISHIWASHI)
            && (sp->battlemon[sp->client_work].hp)
            && (sp->battlemon[sp->client_work].form_no == 0)
            && (sp->battlemon[sp->client_work].hp > (sp->battlemon[sp->client_work].maxhp / 4)))
        {
            sp->battlemon[sp->client_work].form_no = 1;
            BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 0);
            *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
            ret = TRUE;
        } else if ((sp->battlemon[sp->client_work].species == SPECIES_WISHIWASHI)
         && (sp->battlemon[sp->client_work].hp)
         && (sp->battlemon[sp->client_work].form_no == 1)
         && (sp->battlemon[sp->client_work].hp <= (sp->battlemon[sp->client_work].maxhp / 4)))
        {
            sp->battlemon[sp->client_work].form_no = 0;
            BattleFormChange(sp->client_work, sp->battlemon[sp->client_work].form_no, bw, sp, 0);
            *seq_no = SUB_SEQ_HANDLE_FORM_CHANGE;
            ret = TRUE;
        }
    }

    return ret;
}

void ClientPokemonEncount(void *bw, struct CLIENT_PARAM *cp)
{
    struct POKEMON_ENCOUNT_PARAM *pep = (struct POKEMON_ENCOUNT_PARAM *)&cp->client_buffer[0];
    u8 side, newform;
    u16 newmon;
    u32 i;

    side = ((cp->client_type & 1) != 0);

    if (pep->monsno == SPECIES_ZORUA || pep->monsno == SPECIES_ZOROARK)
    {
        struct POKEPARTY *party = BattleWorkPokePartyGet(bw, side);
        u8 count = party->PokeCount;
        u16 strbuf[11];

        newmon = GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_monsno, NULL);
        newform = GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_form_no, NULL);

        if (newmon != pep->monsno || newform != pep->form_no)
        {
            u8 strlen = 0;

            pep->monsno = newmon;
            pep->form_no = newform;

            if (!gIllusionStruct.isSideInIllusion[side]) // if the illusion hasn't been broken before, then don't store the nickname again
            {
                gIllusionStruct.isSideInIllusion[side] = 1;
                GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_nickname, strbuf);
                GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), 0), ID_PARA_nickname, gIllusionStruct.illusionNameBuf[side]);
                gIllusionStruct.illusionPos[side] = 0;

                SetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), 0), ID_PARA_nickname, strbuf);
            }
        }
    }

    CT_PokemonEncountSet(bw, cp, pep);
    ClientCommandReset(cp);
}

void ClientPokemonEncountAppear(void *bw, struct CLIENT_PARAM *cp)
{
    struct POKEMON_APPEAR_PARAM *pap = (struct POKEMON_APPEAR_PARAM *)&cp->client_buffer[0];
    u8 side, newform;
    u16 newmon;
    u32 i;

    side = ((cp->client_type & 1) != 0);

    if (pap->monsno == SPECIES_ZORUA || pap->monsno == SPECIES_ZOROARK)
    {
        struct POKEPARTY *party = BattleWorkPokePartyGet(bw, side);
        u8 count = party->PokeCount;
        u16 strbuf[11];

        newmon = GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_monsno, NULL);
        newform = GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_form_no, NULL);

        if (newmon != pap->monsno || newform != pap->form_no)
        {
            u8 strlen = 0;

            pap->monsno = newmon;
            pap->form_no = newform;

            if (!gIllusionStruct.isSideInIllusion[side]) // if the illusion hasn't been broken before, then don't store the nickname again
            {
                gIllusionStruct.isSideInIllusion[side] = 1;
                GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_nickname, strbuf);
                GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), pap->sel_mons_no), ID_PARA_nickname, gIllusionStruct.illusionNameBuf[side]);
                gIllusionStruct.illusionPos[side] = pap->sel_mons_no;

                SetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), pap->sel_mons_no), ID_PARA_nickname, strbuf);
            }
        }
    }

    CT_PokemonEncountAppearSet(bw, cp, pap);
    ClientCommandReset(cp);
}

void ClientPokemonAppear(void *bw, struct CLIENT_PARAM *cp)
{
    struct POKEMON_APPEAR_PARAM *pap = (struct POKEMON_APPEAR_PARAM *)&cp->client_buffer[0];
    u8 side, newform;
    u16 newmon;
    u32 i;

    side = ((cp->client_type & 1) != 0);

    if (pap->monsno == SPECIES_ZORUA || pap->monsno == SPECIES_ZOROARK)
    {
        struct POKEPARTY *party = BattleWorkPokePartyGet(bw, side);
        u8 count = party->PokeCount;
        u16 strbuf[11];

        newmon = GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_monsno, NULL);
        newform = GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_form_no, NULL);

        if (newmon != pap->monsno || newform != pap->form_no)
        {
            u8 strlen = 0;

            pap->monsno = newmon;
            pap->form_no = newform;

            if (!gIllusionStruct.isSideInIllusion[side]) // if the illusion hasn't been broken before, then don't store the nickname again.  we definitely abuse this, don't worry
            {
                gIllusionStruct.isSideInIllusion[side] = 1;
                GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), count - 1), ID_PARA_nickname, strbuf);
                GetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), pap->sel_mons_no), ID_PARA_nickname, gIllusionStruct.illusionNameBuf[side]);
                gIllusionStruct.illusionPos[side] = pap->sel_mons_no;

                SetMonData(PokeParty_GetMemberPointer(BattleWorkPokePartyGet(bw, side), pap->sel_mons_no), ID_PARA_nickname, strbuf);
            }
        }
    }

    CT_PokemonAppearSet(bw, cp, pap);
    ClientCommandReset(cp);
}

// need to highjack the message creator somewhere in order to buffer the last mon's name in the circumstance that we shouldn't be showing the current mon's nickname

// might not need to setmondata if this one works out
int MessageParam_GetNickname(void *bw, struct BattleStruct *sp, int para)
{
    int ret;
    int client;
    u32 side;

    client = SideClientNoGet(bw, sp, para);
    side = (client & 1) != 0;

    ret = client;

    if ((sp->battlemon[client].species == SPECIES_ZORUA || sp->battlemon[client].species == SPECIES_ZOROARK)
     //&& gIllusionStruct.isSideInIllusion[client & 1]
       )
    {
        struct POKEPARTY *party;
        u32 count;

        party = BattleWorkPokePartyGet(bw, side);
        count = party->PokeCount - 1;

        ret |= count << 8;
    }
    else if (para == 0x16) // switch after the attack?
    {
        ret |= sp->reshuffle_sel_mons_no[client] << 8;
    }
    else
    {
        ret |= sp->sel_mons_no[client] << 8;
    }

    return ret;
}

void CT_SwitchInMessageParamMake(void *bw, struct CLIENT_PARAM *cp, struct SWITCH_MESSAGE_PARAM *smp, MESSAGE_PARAM *mp)
{
    if (cp->client_type & 1)
    {
        struct POKEPARTY *party;
        u32 count = 0;
        u32 species = 0;

        party = BattleWorkPokePartyGet(bw, 1);

        species = GetMonData(PokeParty_GetMemberPointer(party, smp->sel_mons_no), ID_PARA_monsno, NULL);
        if (species == SPECIES_ZORUA || species == SPECIES_ZOROARK)
        {
            smp->sel_mons_no = party->PokeCount - 1;
        }

        if ((BattleTypeGet(bw) & BATTLE_TYPE_WIRELESS) == 0)
        {
            mp->msg_id = BATTLE_MSG_SWITCH_IN_ENEMY_MSG;
            mp->msg_tag = TAG_TRTYPE_TRNAME_NICK;
            mp->msg_para[0] = cp->client_no;
            mp->msg_para[1] = cp->client_no;
            mp->msg_para[2] = cp->client_no | (smp->sel_mons_no << 8);
        }
        else
        {
            mp->msg_id = BATTLE_MSG_SWITCH_IN_TITLELESS;
            mp->msg_tag = TAG_TRNAME_NICK;
            mp->msg_para[0] = cp->client_no;
            mp->msg_para[1] = cp->client_no | (smp->sel_mons_no << 8);
        }
    }
    else
    {
        struct POKEPARTY *party;
        u32 count = 0;
        u32 species = 0;

        party = BattleWorkPokePartyGet(bw, 0);

        species = GetMonData(PokeParty_GetMemberPointer(party, smp->sel_mons_no), ID_PARA_monsno, NULL);
        if (species == SPECIES_ZORUA || species == SPECIES_ZOROARK)
        {
            smp->sel_mons_no = party->PokeCount - 1;
        }

        if (((BattleTypeGet(bw) & BATTLE_TYPE_DOUBLE) == 0)
         && ((BattleTypeGet(bw) & BATTLE_TYPE_WIRELESS) == 0))
        {
            if (smp->rate < 100)
            {
                mp->msg_id = BATTLE_MSG_SEND_IN_MON_3;
            }
            else if (smp->rate < 325)
            {
                mp->msg_id = BATTLE_MSG_SEND_IN_MON_4;
            }
            else if (smp->rate < 550)
            {
                mp->msg_id = BATTLE_MSG_SEND_IN_MON_2;
            }
            else if (smp->rate < 775)
            {
                mp->msg_id = BATTLE_MSG_SEND_IN_MON_1;
            }
            else
            {
                mp->msg_id = BATTLE_MSG_SEND_IN_MON_0;
            }
        }
        else
        {
            mp->msg_id = BATTLE_MSG_SEND_IN_MON_0;
        }
        mp->msg_tag = TAG_NICK;
        mp->msg_para[0] = cp->client_no | (smp->sel_mons_no << 8);
    }
}

// seriously FUCK illusion
void CT_EncountSendOutMessageParamMake(void *bw, struct CLIENT_PARAM *cp, struct ENCOUNT_SEND_OUT_MESSAGE_PARAM *esomp, MESSAGE_PARAM *mp)
{
    u32 fight_type;
    int client1;
    int client2;

    fight_type = BattleTypeGet(bw);

    if (cp->client_type & 1)
    {
        if (fight_type & BATTLE_TYPE_DOUBLE)
        {
            client1 = cp->client_no;
            client2 = BattleWorkPartnerClientNoGet(bw, cp->client_no);
        }
        else
        {
            client1 = cp->client_no;
            client2 = client1;
        }

        { // fuck fuck fuck fuck
            struct POKEPARTY *party;
            u32 count = 0;
            u32 species = 0;

            party = BattleWorkPokePartyGet(bw, client1);

            species = GetMonData(PokeParty_GetMemberPointer(party, esomp->sel_mons_no[client1]), ID_PARA_monsno, NULL); // WHY HAS GOD ABANDONED US
            if (species == SPECIES_ZORUA || species == SPECIES_ZOROARK) // this check is fuckin failing.  i don't know what to do
            {
                esomp->sel_mons_no[client1] = party->PokeCount - 1;
            }
        }

        if (client1 != client2)
        { // why has god abandoned us
            struct POKEPARTY *party;
            u32 count = 0;
            u32 species = 0;

            party = BattleWorkPokePartyGet(bw, client2);

            species = GetMonData(PokeParty_GetMemberPointer(party, esomp->sel_mons_no[client2]), ID_PARA_monsno, NULL);
            if (species == SPECIES_ZORUA || species == SPECIES_ZOROARK)
            {
                esomp->sel_mons_no[client2] = party->PokeCount - 1;
            }
        }


        if (fight_type & BATTLE_TYPE_WIRELESS)
        {
            if (fight_type & BATTLE_TYPE_BATTLE_TOWER)
            {
                mp->msg_id = BATTLE_MSG_DOUBLE_TOWER_BATTLE_SEND_OUT;
                mp->msg_tag = TAG_TRTYPE_TRNAME_NICK_TRTYPE_TRNAME_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1;
                mp->msg_para[2] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[3] = client2;
                mp->msg_para[4] = client2;
                mp->msg_para[5] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else if (fight_type & BATTLE_TYPE_MULTI)
            {
                mp->msg_id = BATTLE_MSG_MULTI_BATTLE_SEND_OUT_MESSAGE;
                mp->msg_tag = TAG_TRNAME_NICK_TRNAME_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[2] = client2;
                mp->msg_para[3] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else if (fight_type & BATTLE_TYPE_DOUBLE)
            {
                mp->msg_id = BATTLE_MSG_DOUBLE_BATTLE_SEND_OUT_WIRELESS;
                mp->msg_tag = TAG_TRNAME_NICK_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[2] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else
            {
                mp->msg_id = BATTLE_MSG_SWITCH_IN_TITLELESS;
                mp->msg_tag = TAG_TRNAME_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1 | (esomp->sel_mons_no[client1] << 8);
            }
        }
        else
        {
            if ((fight_type & BATTLE_TYPE_TAG)
             || (fight_type & BATTLE_TYPE_MULTI))
            {
                mp->msg_id = BATTLE_MSG_DOUBLE_TOWER_BATTLE_SEND_OUT;
                mp->msg_tag = TAG_TRTYPE_TRNAME_NICK_TRTYPE_TRNAME_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1;
                mp->msg_para[2] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[3] = client2;
                mp->msg_para[4] = client2;
                mp->msg_para[5] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else if (fight_type & BATTLE_TYPE_DOUBLE)
            {
                mp->msg_id = BATTLE_MSG_ENEMY_SEND_OUT_DOUBLES;
                mp->msg_tag = TAG_TRTYPE_TRNAME_NICK_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1;
                mp->msg_para[2] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[3] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else
            {
                mp->msg_id = BATTLE_MSG_SWITCH_IN_ENEMY_MSG;
                mp->msg_tag = TAG_TRTYPE_TRNAME_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1;
                mp->msg_para[2] = client1 | (esomp->sel_mons_no[client1] << 8);
            }
        }
    }
    else
    {
        if (fight_type & BATTLE_TYPE_WIRELESS) // fuck wireless battles
        {
            u8 sio_id = BattleWorkCommIDGet(bw);

            if (fight_type & BATTLE_TYPE_MULTI)
            {
                switch (BattleWorkCommStandNoGet(bw,sio_id))
                {
                case 0:
                case 3:
                    client1 = BattleWorkClientNoGet(bw, 4);
                    client2 = BattleWorkClientNoGet(bw, 2);
                    break;
                case 1:
                case 2:
                    client1 = BattleWorkClientNoGet(bw, 2);
                    client2 = BattleWorkClientNoGet(bw, 4);
                    break;
                }
            }
            else if (fight_type & BATTLE_TYPE_DOUBLE)
            {
                client1 = BattleWorkClientNoGet(bw, 2);
                client2 = BattleWorkClientNoGet(bw, 4);
            }
            else
            {
                client1 = BattleWorkClientNoGet(bw, 0);
                client2 = client1;
            }
        }
        else if (fight_type & BATTLE_TYPE_MULTI)
        {
            client1 = BattleWorkPartnerClientNoGet(bw, cp->client_no);
            client2 = cp->client_no;
        }
        else if (fight_type & BATTLE_TYPE_DOUBLE)
        {
            client1 = BattleWorkClientNoGet(bw, 2);
            client2 = BattleWorkClientNoGet(bw, 4);
        }
        else
        {
            client1 = cp->client_no;
            client2 = client1;
        }

        { // FUCK FUCK FUCK FUCK
            struct POKEPARTY *party;
            u32 count = 0;
            u32 species = 0;

            party = BattleWorkPokePartyGet(bw, client1);

            species = GetMonData(PokeParty_GetMemberPointer(party, esomp->sel_mons_no[client1]), ID_PARA_monsno, NULL);
            if (species == SPECIES_ZORUA || species == SPECIES_ZOROARK)
            {
                esomp->sel_mons_no[client1] = party->PokeCount - 1;
            }
        }

        if (client1 != client2)
        {
            struct POKEPARTY *party;
            u32 count = 0;
            u32 species = 0;

            party = BattleWorkPokePartyGet(bw, client2);

            species = GetMonData(PokeParty_GetMemberPointer(party, esomp->sel_mons_no[client2]), ID_PARA_monsno, NULL);
            if (species == SPECIES_ZORUA || species == SPECIES_ZOROARK)
            {
                esomp->sel_mons_no[client2] = party->PokeCount - 1;
            }
        }

        if (fight_type & BATTLE_TYPE_WIRELESS)
        {
            if (fight_type & BATTLE_TYPE_MULTI)
            {
                mp->msg_id = BATTLE_MSG_MULTI_BATTLE_PLAYER_SEND_OUT_MESSAGE;
                mp->msg_tag = TAG_TRNAME_NICK_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[2] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else if (fight_type & BATTLE_TYPE_DOUBLE)
            {
                mp->msg_id = BATTLE_MSG_SEND_OUT_DOUBLES;
                mp->msg_tag = TAG_NICK_NICK;
                mp->msg_para[0] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[1] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else
            {
                mp->msg_id = BATTLE_MSG_SEND_IN_MON_0;
                mp->msg_tag = TAG_NICK;
                mp->msg_para[0] = client1 | (esomp->sel_mons_no[client1] << 8);
            }
        }
        else
        {
            if (fight_type & BATTLE_TYPE_MULTI)
            {
                mp->msg_id = BATTLE_MSG_MULTI_BATTLE_PLAYER_SIDE_SEND_OUT;
                mp->msg_tag = TAG_TRTYPE_TRNAME_NICK_NICK;
                mp->msg_para[0] = client1;
                mp->msg_para[1] = client1;
                mp->msg_para[2] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[3] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else if (fight_type & BATTLE_TYPE_DOUBLE)
            {
                mp->msg_id = BATTLE_MSG_SEND_OUT_DOUBLES;
                mp->msg_tag = TAG_NICK_NICK;
                mp->msg_para[0] = client1 | (esomp->sel_mons_no[client1] << 8);
                mp->msg_para[1] = client2 | (esomp->sel_mons_no[client2] << 8);
            }
            else
            {
                mp->msg_id = BATTLE_MSG_SEND_IN_MON_0;
                mp->msg_tag = TAG_NICK;
                mp->msg_para[0] = client1 | (esomp->sel_mons_no[client1] << 8);
            }
        }
    }
}

void BattleFormChange(int client, int form_no, void* bw, struct BattleStruct *sp, bool8 SwitchAbility)
{
    void *pp2;

    pp2 = BattleWorkPokemonParamGet(bw, client, sp->sel_mons_no[client]);
    SetMonData(pp2, ID_PARA_form_no, &form_no);

    RecalcPartyPokemonStats(pp2);
    if (SwitchAbility)
    {
        ResetPartyPokemonAbility(pp2);
        sp->battlemon[client].ability = GetMonData(pp2, ID_PARA_speabino, NULL);
    }


    sp->battlemon[client].attack = GetMonData(pp2, ID_PARA_pow, NULL);
    sp->battlemon[client].defense = GetMonData(pp2, ID_PARA_def, NULL);
    sp->battlemon[client].speed = GetMonData(pp2, ID_PARA_agi, NULL);
    sp->battlemon[client].spatk = GetMonData(pp2, ID_PARA_spepow, NULL);
    sp->battlemon[client].spdef = GetMonData(pp2, ID_PARA_spedef, NULL);

    sp->battlemon[client].type1 = GetMonData(pp2, ID_PARA_type1, NULL);
    sp->battlemon[client].type2 = GetMonData(pp2, ID_PARA_type2, NULL);

    //sp->battlemon[client].species = PokeOtherFormMonsNoGet(sp->battlemon[client].species, form_no);
}

void TryRevertFormChange(struct BattleStruct *sp, void* bw, int client_no)
{
    u16 species = sp->battlemon[client_no].species;
    u8 form_no = sp->battlemon[client_no].form_no;

    void *pp = BattleWorkPokemonParamGet(bw, client_no, sp->sel_mons_no[client_no]);

    if (RevertFormChange(pp,species,form_no))
    {
        RecalcPartyPokemonStats(pp);
        ResetPartyPokemonAbility(pp);
    }
}

void BattleEndRevertFormChange(void *bw)
{
    int i, j;
    void *pp;
    u16 monsno;
    u16 form;

    newBS.SideMega[0] = 0;
    newBS.SideMega[1] = 0;
    newBS.playerWantMega = 0;
    newBS.PlayerMegaed = 0;

    newBS.CanMega = 0;
    newBS.ChangeBgFlag = 0;
    newBS.MegaIconLight = 0;

    for (i = 0; i < 2; i++)
    {
        // revert illusion
        if (gIllusionStruct.isSideInIllusion[i])
        {
            pp = BattleWorkPokemonParamGet(bw, 0, gIllusionStruct.illusionPos[i]);
            SetMonData(pp, ID_PARA_nickname, gIllusionStruct.illusionNameBuf[i]);
        }

        // clear the illusion structure
        gIllusionStruct.isSideInIllusion[i] = 0;
        gIllusionStruct.illusionPos[i] = 0;
        for (j = 0; j < 11; j++)
            gIllusionStruct.illusionNameBuf[i][j] = 0;
    }

    for (i = 0; i < BattleWorkPokeCountGet(bw, 0); i++)
    {
        pp = BattleWorkPokemonParamGet(bw, 0, i);
        monsno = GetMonData(pp, 174, 0);
        form = GetMonData(pp, 112, 0);

        if (RevertFormChange(pp,monsno,form))
        {
            RecalcPartyPokemonStats(pp);
            ResetPartyPokemonAbility(pp);
        }
    }
}


void ClearBattleMonFlags(struct BattleStruct *sp, int client)
{
    sp->battlemon[client].unnerve_flag = 0;
    sp->battlemon[client].dark_aura_flag = 0;
    sp->battlemon[client].fairy_aura_flag = 0;
    sp->battlemon[client].aura_break_flag = 0;
    sp->battlemon[client].sheer_force_flag = 0;
    sp->battlemon[client].imposter_flag = 0;
    sp->battlemon[client].critical_hits = 0;
}
