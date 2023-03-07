CheckSideAbility = 0x1AA64 + 0x022378C1;
CheckDefenceAbility = 0x1AF74 + 0x022378C1;
BattlePokemonParamGet = 0x17520 + 0x022378C1;
BattleWorkMonDataGet = 0x20914 + 0x022378C1;
BattleItemDataGet = 0x205B4 + 0x022378C1;
BattleTypeGet = 0x2F20 + 0x022378C1;
CheckFieldMoveEffect = 0x1B428 + 0x022378C1;
CheckNumMonsHit = 0x1A9A0 + 0x022378C1;
BattleWorkPokemonParamGet = 0x0223DFAC | 1; /*pt*/
BattleWorkPokeCountGet = 0x0223DF60 | 1; /*pt*/
BattleWorkZukanWorkGet = 0x0223E068 | 1; /*pt*/
BattleWorkClientSetMaxGet = 0x0223DF1C | 1; /*pt*/
ST_ServerAgiCalc = 0x02252EC8 | 1; /*pt*/
Sub_GaugeObjHeadGet = 0x022682B0 | 1; /*pt*/
ST_ServerSelectWazaGet = 0x02255570 | 1; /*pt*/
ST_ServerNamakeCheck = 0x02255EC0 | 1; /*pt*/
SCIO_BlankMessage = 0x02266AA0 | 1; /*pt*/
BattleWorkFightMsgGet = 0x0223E05C | 1; /*pt*/
Task_DistributeExp = 0x02245898 | 1;


ServerCriticalMessage = 0x022511FC | 1; /*pt*/
ServerWazaStatusMessage = 0x02251218 | 1; /*pt*/
ST_ServerAddStatusCheck = 0x02253710 | 1; /*pt*/
ServerIkariCheck = 0x0225126C | 1; /*pt*/
ST_ServerWazaHitTokuseiCheck_Old = 0x1C544 + 0x022378C1;
ST_ServerWaruagakiCheck = 0x02254A6C | 1; /*pt*/
ServerSenseiCheck = 0x0224EF00 | 1; /*pt*/
ServerStatusCheck = 0x0224E784 | 1; /*pt*/
ServerBadgeCheck = 0x0224E13C | 1; /*pt*/
ServerPPCheck = 0x0224E458 | 1; /*pt*/
ServerDefenceCheck = 0x0224E5F4 | 1; /*pt*/
ST_ServerDefenceClientTokuseiCheck = 0x02253C98 | 1; /*pt*/
ST_ServerTotteokiCountCalc = 0x022560B0 | 1; /*pt*/
ST_ServerMetronomeBeforeCheck = 0x02259868 | 1; /*pt*/
ST_ServerPokeAppearCheck = 0x02256414 | 1; /*pt*/
SCIO_StatusEffectSet = 0x02265FF8 | 1; /*pt*/

/*battle table*/
SoubiItemWazaTypePowUpTbl = 0x0226EC92; /*pt*/
TetsunoKobushiTable = 0x0226EC16; /*pt*/
CondChgTable = 0x0226EBE0; /*pt*/
ItemDataIndex = 0x020F0CC4; /*pt*/

gf_rand = 0x0201D2E8 |1; /*pt*/
GF_ASSERT = 0x02022974 + 1; /*pt*/
SetPokemonGet = 0x0202A434 |1;
SetPokemonSee = 0x0202A36C |1;
UpdatePokedexWithReceivedSpecies = 0x0202F180 | 1; /*pt*/
ArchiveDataLoadMalloc = 0x02006AC0 | 1; /*pt*/
ArchiveDataLoad = 0x02006AA4 | 1; /*pt*/
ArchiveDataLoadMallocOfs = 0x02006B18 | 1; /*pt*/
ArchiveDataLoadOfs = 0x02006AFC | 1; /*pt*/
sqrt = 0x0200048A | 1;

/*Pokemon*/
PokemonParam_AllocWork = 0x02073C74 | 1; /*pt*/
PokeParaInit = 0x02073C2C |1; /*pt*/
PokeParaSet = 0x02073D80 |1; /*pt*/
PokeParaSetChr = 0x02074044 | 1; /*pt*/
PokeParaSetSexChr = 0x02074088 | 1; /*pt*/
PokeCopyPPtoPP = 0x020775EC | 1; /*pt*/
GetMonData = 0x02074470 |1; /*pt*/
GetBoxMonData = 0x02074570 |1; /*pt*/
SetMonData = 0x02074B30 |1; /*pt*/
PokeStatusPokeParamGet = 0x0208DD48 | 1; /*pt*/
PokeParaCalc = 0x0207418C | 1; /*pt*/
PokeParaSpeabiSet = 0x0207803C |1; /*pt*/
PokeFuseiFormNoCheck = 0x020761E8 | 1; /*pt*/
PokePasoParaUnknownFormGet = 0x02076B00 | 1; /*pt*/
PokeFormNoPersonalParaGet = 0x020759CC |1; /*pt*/
GetBoxMonGender = 0x0206FF90 |1;
PokeSexGetMonsNo = 0x02075DAC | 1; /*pt*/
BoxMonSetFastModeOn = 0x02073D20 |1; /*pt*/
BoxMonSetFastModeOff = 0x02073D48 |1; /*pt*/
BoxMonDataSet = 0x02074C60 |1;
FillInBoxMonLearnset = 0x020712D8 |1;
PokePersonalParaGet = 0x020759F0 | 1; /*pt*/
BoxMonInit = 0x0206DD0C |1;
PokeLevelExpGet = 0x02075AD0 | 1; /*pt*/
SodateyaWork_GetPokePasoPointer = 0x021E622C | 1; /*pt*/
PokeParaPersonalRndChange = 0x020780C4 | 1; /*pt*/
PokeNatureGet = 0x0206FE2C |1;
PokeSetMove = 0x020712D8 |1;
PokeParaLevelExpGet = 0x02075AAC | 1; /*pt*/
PokeLevelUpCheck = 0x02076B14 | 1; /*pt*/
MonHasMove = 0x02071754 | 1;
PartyHasMon = 0x020748CC | 1;
PokeParaGetInfoSet = 0x02077E64 | 1; /*pt*/
InitBoxMonMoveset = 0x02077020 | 1; /*pt*/
GrabAndRegisterUnownForm = 0x02248444 | 1;
WildMonSetRandomHeldItem = 0x02077F0C | 1; /*pt*/
MonIsShiny = 0x0207003C | 1;
BoxMonIsShiny = 0x02070044 | 1;

GetBagSaveData = 0x5AC + 0x021F9381;
SaveData_GetRepelPtr = 0x0202DB05;
SaveData_GetEventPtr = 0x020503D0 | 1;
SaveData_GetDexPtr = 0x0202A634 |1;
SaveData_GetPlayerPartyPtr = 0x0207A268 |1; /*pt*/


GetVarAdrs = 0x020504A4 | 1;
EncDataSave_GetSaveDataPtr = 0x0202D834 | 1; /*pt*/
GetVarPointer = 0x02040374 |1;
VarSet = 0x020403C0 | 1;
VarGet = 0x020403AC | 1;
GF_CpuCopy8 = 0x0204D450;
GetEvScriptWorkMemberAdrs = 0x0203F098 | 1; /*pt*/
WORDSET_RegisterAbilityName = 0x0200C060|1;
EventSet_Script = 0x0203E880 | 1; /*pt*/

sys_AllocMemory = 0x02018144 | 1; /*pt*/
sys_FreeMemoryEz = 0x020181C4 | 1; /*pt*/

/*TextBox*/
TalkWinGraphicSet = 0x0200DD0C | 1; /*pt*/
CONFIG_GetWindowType = 0x02027B50 | 1; /*pt*/
GF_BGL_BmpWinGet_Frame = 0x0201C290 | 1; /*pt*/
FieldTalkWinClear = 0x0205D988 | 1; /*pt*/
BmpTalkWinWrite = 0x0200E060 | 1; /*pt*/
MSG_PrintInit = 0x0201D710 | 1; /*pt*/
SystemFontPaletteLoad = 0x02002E7C | 1; /*pt*/
TalkFontPaletteLoad = 0x02002E98 | 1; /*pt*/

/*Pal*/
ArcUtil_PalSet = 0x02006E84 | 1; /*pt*/

/*Window*/
FillWindowPixelBuffer = 0x0201D978 |1;
ConvertNumToString = 0x0208C87C |1;
StringPut = 0x0208C778 |1;
PutWindows = 0x0201D578 |1;

/*ItemUse*/
SetUpItemScript = 0x02068540 | 1; /*pt*/

/*OAM*/
OAM_LoadResourceCharArcH = 0x0200D504 | 1;
OAM_LoadResourcePlttWorkArcH = 0x0200D68C |1;
OAM_LoadResourceCellArcH = 0x0200D6EC | 1;
OAM_LoadResourceCellAnmArcH = 0x0200D71C |1;

OAM_LoadResourcePlttWorkArc = 0x0200D644 |1;
OAM_LoadResourceCellArc = 0x0200D6D4 | 1;
OAM_LoadResourceCellAnmArc = 0x0200D704 |1;
OAM_LoadResourceCharArc = 0x0200D4A4 |1;

OAM_ObjectAdd_S = 0x0200D734 |1;
OAM_ObjectUpdate = 0x0200DC0C |1;
OAM_FreeResourceChar = 0x0200D958 |1;
OAM_FreeResourceCell = 0x0200D978 |1;
OAM_FreeResourceCellAnm = 0x0200D988 |1;
OAM_FreeResourcePltt = 0x0200D968 |1;
CATS_ActorPointerDelete_S = 0x0200D0F4 | 1; /*pt*/

BG_LoadScreenTilemapData = 0x0201C0A8 | 1;
ScheduleBgTilemapBufferTransfer = 0x0201EFBC | 1;
ArcUtil_ScrnDataGet = 0x02006F6C | 1; /*pt*/

/*BATTLE_OAM*/
BGCallback_FightOnly = 0x022698BC | 1; /*pt*/
BG_SlideSetInit = 0x02269550 | 1; /*pt*/
BattleWorkCATS_SYS_PTRGet = 0x0223E010 | 1; /*pt*/
BattleWorkCATS_RES_PTRGet = 0x0223E018 | 1; /*pt*/
BGCallback_CommandSelect = 0x2F6C4 + 0x022378C1;
BattleWorkPfdGet = 0x0223E064 | 1; /*pt*/
PokeIconPalArcIndexGet = 0x02079FD0 | 1; /*pt*/
PokeIconAnmCellArcIndexGet = 0x02079FD8 | 1; /*pt*/
PokeIconAnmCellAnmArcIndexGet = 0x02079FE4 | 1; /*pt*/

EffectTCB_Delete = 0x315F8 + 0x022378C1;
Sub_TouchEndDelete = 0x314C8 + 0x022378C1;
Sub_ScrnOffsetRewrite = 0x31624 + 0x022378C1;
EffectTCB_Add = 0x315C4 + 0x022378C1;
BattleWorkGF_BGL_INIGet = 0x0223DF00 | 1; /*pt*/

Snd_SePlay = 0x02005748 | 1; /*pt*/





/* new battle engine */
GetBattlerAbility = 0x022527CC | 1;
BattleDamageDivide = 0x02253178 | 1;
BattleWorkWeatherGet = 0x0223F21C | 1; /*pt*/
BattleWorkEnemyClientGet = 0x32F8 + 0x022378C1;
TraceClientGet = 0x022585B8 | 1;
IsClientEnemy = 0x0223AB1C | 1;
TypeCalc = 0x02251D28 | 1;
AnticipateMoveEffectListCheck = 0x0225865C | 1;
BattleRand = 0x0223BD98 | 1;
ChooseRandomTarget = 0x02253DA0 | 1;
CountBattlerMoves = 0x02252EA8 | 1;
AbilityStatusRecoverCheck = 0x022543A0 | 1;
HeldItemHealCheck = 0x02254E7C | 1;
LoadBattleSubSeqScript = 0x172DC + 0x022378C1;
HeldItemHoldEffectGet = 0x02255830 | 1;
HeldItemAtkGet = 0x02255844 | 1;
IsMovingAfterClient = 0x0225561C | 1;
CheckSubstitute = 0x02256838 | 1;
GetArceusType = 0x02071C28 | 1;
BattleWorkBattleStatusFlagGet = 0x0223EBEC | 1; /*pt*/
PokeParaGiratinaFormChange = 0x02071CA0 | 1;
SCIO_PSPtoPPCopy = 0x022662FC | 1; /*pt*/
SCIO_IncRecord = 0x022666BC | 1; /*pt*/
ST_ServerTokuseiStatusRecoverReshuffleCheck = 0x022577A4 | 1; /*pt*/
ST_ServerPressurePPDecCheck = 0x0225B408 | 1; /*pt*/
ST_ServerWazaPosGet = 0x02254EE0 | 1; /*pt*/
BattleWorkConfigWazaEffectOnOffCheck = 0x0223EDAC | 1; /*pt*/
SCIO_WazaEffectSet = 0x02265BBC | 1; /*pt*/
SCIO_WazaEffect2Set = 0x02265BEC | 1; /*pt*/
SkillSequenceGosub = 0x02248B08 | 1; /*pt*/
ServerKizetsuCheck = 0x02250EF4 | 1; /*pt*/
Snd_BgmPlay = 0x0200549C | 1; /*pt*/
BattleWorkPinchSEFlagSet = 0x0223F460 | 1; /*pt*/
ST_ServerPokeOneSelfCheckActPP = 0x02259B38 | 1; /*pt*/
PokeExpCalc = 0x022499C0 | 1; /*pt*/
BattleWorkConfigMsgSpeedGet = 0x0223EDF0 | 1; /*pt*/
BattleMSG_Print = 0x0223FB24 | 1; /*pt*/
GF_MSG_PrintEndCheck = 0x0201D724 | 1; /*pt*/
SCIO_EXPGaugeCalcSet = 0x02265D14 | 1; /*pt*/
ST_ServerQueCheck = 0x02251FC8 | 1; /*pt*/
SCIO_StatusEffectSet = 0x02265FF8 | 1; /*pt*/
SCIO_LevelUpEffectSet = 0x0226614C | 1; /*pt*/
BattleWorkPlaceIDGet = 0x0223E24C | 1; /*pt*/

/*Battle Script Functions*/
IncrementBattleScriptPtr = 0x02245508 | 1;
read_battle_script_param = 0x022454E8 | 1;
TagNickParaMake = 0x022522E0 | 1;
JumpToMoveEffectScript = 0x02245518 | 1;
BGCallback_Waza = 0x022699AC | 1; /*pt*/

/* Trainer data expansion */
gf_get_seed = 0x0201D2D0 | 1; /*pt*/
PokeParty_Init = 0x0207A014 | 1; /*pt*/
TT_TrainerPokeDataGet = 0x0207939C | 1; /*pt*/
TT_TrainerTypeSexGet = 0x020793AC | 1; /*pt*/
TrainerCBSet = 0x02078AEC | 1; /*pt*/
try_force_gender_maybe = 0x02073A98 | 1;
TrainerMonHandleFrustration = 0x02073AE4 | 1;
SetPartyPokemonMoveAtPos = 0x020714E8 | 1;
gf_srand = 0x0201D2DC | 1; /*pt*/
PokeParty_Add = 0x0207A048 | 1; /*pt*/

/* Illusion */
CT_PokemonEncountSet = 0x0225CBDC | 1; /*pt*/
CT_PokemonEncountAppearSet = 0x0225CE1C | 1; /*pt*/
CT_PokemonAppearSet = 0x0225CF70 | 1; /*pt*/
ClientCommandReset = 0x0225CBB0 | 1; /*pt*/
BattleWorkPokePartyGet = 0x0223DF20 | 1; /*pt*/
PokeParty_GetPokeCount = 0x0207A0F8 | 1; /*pt*/
PokeParty_GetMemberPointer = 0x0207A0FC | 1; /*pt*/
SideClientNoGet = 0x0224A984 | 1; /*pt*/
BattleWorkClientNoGet = 0x0223E1C4 | 1; /*pt*/
BattleWorkPartnerClientNoGet = 0x0223E258 | 1; /*pt*/
BattleWorkCommIDGet = 0x0223F6E4 | 1; /*pt*/
BattleWorkCommStandNoGet = 0x0223F6F0 | 1; /*pt*/


/*Overworld Code*/
AddPokemonParam = 0x02242514 | 1; /*pt*/
GetEncountChar = 0x02241AE4 | 1; /*pt*/
/*get_mon_ow_tag = 0x02069D70 | 1;*/
get_ow_data_file_num = 0x0206A304 | 1;
does_species_have_dimorphism = 0x0206A338 | 1;

/*first E0 battle script commands*/
BattleScriptCmdTable = 0x0226C6C8;

/* i can't believe i haven't used this one yet */
GetItemData = 0x02077D88 | 1;
GiratinaBoxPokemonFormChange = 0x02071CBC | 1;
GrashideaFeasibleCheck = 0x02077B14 | 1; /*pt*/
PokeList_FormDemoOverlayLoad = 0x020819B4 | 1; /*pt*/

/* save stuff */
SaveBlock2_get = 0x020245A4 | 1; /*pt*/
Sav2_Misc_get = 0x0202A954 | 1;
SavArray_Flags_get = 0x020507E4 | 1; /*pt*/
PokeParty_Delete = 0x0207A080 | 1; /*pt*/
Overlay_UnloadID = 0x02006514 | 1; /*pt*/
Overlay_Load = 0x02006590 | 1; /*pt*/
WIPE_SYS_EndCheck = 0x0200F2AC | 1; /*pt*/
PokeListProc_End = 0x0207E7E0 | 1; /*pt*/
PROC_GetWork = 0x0200682C | 1; /*pt*/
ScriptJump = 0x0203FE0C | 1;
SetScriptVar = 0x02066A7C | 1;
GetScriptVar = 0x02066AAC | 1;
SetScriptFlag = 0x0206A8DC | 1; /*pt*/
ClearScriptFlag = 0x0206A8E4 | 1; /*pt*/
CheckScriptFlag = 0x0206A8EC | 1; /*pt*/
Sav2_PlayerData_GetProfileAddr = 0x02025E38 | 1; /*pt*/

/* rtc functions */
Party_ResetAllShayminToLandForme = 0x02071E2C | 1;
GF_RTC_CopyDateTime = 0x02014708 | 1;
GF_RTC_CopyTime = 0x0201474C | 1;
GF_RTC_CopyDate = 0x02014780 | 1;
IsNighttime = 0x02014804 | 1;
GF_RTC_GetTimeOfDay = 0x0201481C | 1;
GF_RTC_GetTimeOfDayWildParam = 0x02014844 | 1;
GF_RTC_GetTimeOfDayWildParamByHour = 0x0201485C | 1;

/* map object funcs */
GetMapObjectByID = 0x0205EE60 | 1;
MapObject_GetMovement = 0x0205F264 | 1;
MapObject_GetGfxID = 0x0205F25C | 1;
MapObject_SetGfxID = 0x0205F258 | 1;
sub_0205F6AC = 0x0205F6AC | 1;
MapObject_SetBits = 0x0205F20C | 1;
MapObject_ClearBits = 0x0205F214 | 1;
MapObject_SetID = 0x0205F248 | 1;
MapObject_SetType = 0x0205F268 | 1;
MapObject_GetType = 0x0205F26C | 1;
MapObject_SetFlagID = 0x0205F270 | 1;
MapObject_SetScript = 0x0205F278 | 1;
MapObject_SetParam = 0x0205F2D0 | 1;
MapObject_GetParam = 0x0205F2F4 | 1;
MapObject_SetXRange = 0x0205F318 | 1;
MapObject_SetYRange = 0x0205F320 | 1;
FieldSysGetAttrAddr = 0x020402F0 | 1;
MapObject_GfxDraw = 0x0205f484 | 1;

/* 0x16C54 in overlay1 */
PlayerAlternate_MapObject_GfxDraw = 0x021FC554 | 1;

CreateFollowingSpriteFieldObject = 0x0206A128 | 1;
FollowingPokemon_GetSpriteID = 0x02069D70 | 1;
FollowPokeFsysParamSet = 0x02069F3C | 1;
FollowPokeMapObjectSetParams = 0x02069EE8 | 1;
FsysFollowMonClear = 0x0206A06C | 1;

CreateSpecialFieldObject = 0x0205E294 | 1;
DeleteMapObject = 0x0205E400 | 1;
MapObject_GetCurrentX = 0x0205F914 | 1;
MapObject_SetCurrentX = 0x0205F918 | 1;
MapObject_GetCurrentY = 0x0205F934 | 1;
MapObject_SetCurrentY = 0x0205F938 | 1;
MapObject_SetFlag29 = 0x0205F89C | 1;
sub_02069DC8 = 0x02069DC8 | 1;
ov01_021F9048 = 0x021F9048 | 1;

MapObjectMan_PauseAllMovement = 0x0205F574 | 1;
MapObjectMan_UnpauseAllMovement = 0x0205F5A4 | 1;

BagView_New = 0x02077878 | 1;
BagView_SetItem = 0x020778BC | 1;
Sav2_Bag_get = 0x0207879C | 1;
