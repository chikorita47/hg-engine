# pokegra handled in data/graphics/pokegra.mk

# NARC_FILES handles prereqs for move_narc

# BATTLEHUD_DIR := $(BUILD)/a007
# BATTLEHUD_NARC := $(BUILD_NARC)/a007.narc
# BATTLEHUD_TARGET := $(FILESYS)/a/0/0/7
# BATTLEHUD_DEPENDENCIES_DIR := rawdata/battle_sprite
# BATTLEHUD_DEPENDENCIES := $(BATTLEHUD_DEPENDENCIES_DIR)/*

# $(BATTLEHUD_NARC): $(BATTLEHUD_DEPENDENCIES)
# 	$(PYTHON) $(NARCHIVE) extract $(BATTLEHUD_TARGET) -o $(BATTLEHUD_DIR) -nf
# 	cp -r $(BATTLEHUD_DEPENDENCIES_DIR)/. $(BATTLEHUD_DIR)
# 	$(PYTHON) $(NARCHIVE) create $@ $(BATTLEHUD_DIR) -nf

# NARC_FILES += $(BATTLEHUD_NARC)


# MOVEDATA_DIR := $(BUILD)/a011
# MOVEDATA_NARC := $(BUILD_NARC)/a011.narc
# MOVEDATA_TARGET := $(FILESYS)/a/0/1/1
# MOVEDATA_DEPENDENCIES := armips/data/moves.s

# $(MOVEDATA_NARC): $(MOVEDATA_DEPENDENCIES)
# 	$(ARMIPS) $^
# 	$(PYTHON) $(NARCHIVE) create $@ $(MOVEDATA_DIR) -nf

# NARC_FILES += $(MOVEDATA_NARC)


# MOVEPARTICLES_DIR := $(BUILD)/a029
# MOVEPARTICLES_NARC := $(BUILD_NARC)/a029.narc
# MOVEPARTICLES_TARGET := $(FILESYS)/a/0/2/9
# MOVEPARTICLES_DEPENDENCIES_DIR := rawdata/move_spa
# MOVEPARTICLES_DEPENDENCIES := $(MOVEPARTICLES_DEPENDENCIES_DIR)/*

# $(MOVEPARTICLES_NARC): $(MOVEPARTICLES_DEPENDENCIES)
# 	$(PYTHON) $(NARCHIVE) extract $(MOVEPARTICLES_TARGET) -o $(MOVEPARTICLES_DIR) -nf
# 	cp -r $(MOVEPARTICLES_DEPENDENCIES_DIR)/. $(MOVEPARTICLES_DIR)
# 	$(PYTHON) $(NARCHIVE) create $@ $(MOVEPARTICLES_DIR) -nf

# NARC_FILES += $(MOVEPARTICLES_NARC)


MSGDATA_DIR := $(BUILD)/text
MSGDATA_NARC := $(BUILD_NARC)/pl_msg.narc
MSGDATA_TARGET := $(FILESYS)/msgdata/pl_msg.narc
MSGDATA_DEPENDENCIES_DIR := data/text
MSGDATA_DEPENDENCIES := $(MSGDATA_DEPENDENCIES_DIR)/*
CHARMAP := charmap.txt

$(MSGDATA_NARC): $(MSGDATA_DEPENDENCIES)
	$(PYTHON) $(NARCHIVE) extract $(MSGDATA_TARGET) -o $(MSGDATA_DIR) -nf
	for file in $^; do $(MSGENC) -e -c $(CHARMAP) $$file $(MSGDATA_DIR)/pl_msg_$$(basename $$file .txt); done
	$(PYTHON) $(NARCHIVE) create $@ $(MSGDATA_DIR) -nf

NARC_FILES += $(MSGDATA_NARC)


# OPENDEMO_DIR := $(BUILD)/a262
# OPENDEMO_NARC := $(BUILD_NARC)/a262.narc
# OPENDEMO_TARGET := $(FILESYS)/a/2/6/2
# OPENDEMO_DEPENDENCIES_DIR := rawdata/op_demo
# OPENDEMO_DEPENDENCIES := $(OPENDEMO_DEPENDENCIES_DIR)/*

# $(OPENDEMO_NARC): $(OPENDEMO_DEPENDENCIES)
# 	$(PYTHON) $(NARCHIVE) extract $(OPENDEMO_TARGET) -o $(OPENDEMO_DIR) -nf
# 	cp -r $(OPENDEMO_DEPENDENCIES_DIR)/. $(OPENDEMO_DIR)
# 	$(PYTHON) $(NARCHIVE) create $@ $(OPENDEMO_DIR) -nf

# NARC_FILES += $(OPENDEMO_NARC)


MONDATA_DIR := $(BUILD)/pl_personal
MONDATA_NARC := $(BUILD_NARC)/pl_personal.narc
MONDATA_TARGET := $(FILESYS)/poketool/personal/pl_personal.narc
MONDATA_DEPENDENCIES := armips/data/mondata.s

$(MONDATA_NARC): $(MONDATA_DEPENDENCIES)
	mkdir -p $(MONDATA_DIR)
	$(ARMIPS) $^
	$(PYTHON) $(NARCHIVE) create $@ $(MONDATA_DIR) -nf

NARC_FILES += $(MONDATA_NARC)


SPRITEOFFSETS_DIR := $(BUILD)/pl_poke_data
SPRITEOFFSETS_NARC := $(BUILD_NARC)/pl_poke_data.narc
SPRITEOFFSETS_TARGET := $(FILESYS)/poketool/poke_edit/pl_poke_data.narc
SPRITEOFFSETS_DEPENDENCIES := armips/data/spriteoffsets.s

$(SPRITEOFFSETS_NARC): $(SPRITEOFFSETS_DEPENDENCIES)
	$(PYTHON) $(NARCHIVE) extract $(SPRITEOFFSETS_TARGET) -o $(SPRITEOFFSETS_DIR) -nf
	$(ARMIPS) $^
	$(PYTHON) $(NARCHIVE) create $@ $(SPRITEOFFSETS_DIR) -nf

NARC_FILES += $(SPRITEOFFSETS_NARC)


HEIGHT_DIR := $(BUILD)/height
HEIGHT_NARC := $(BUILD_NARC)/height.narc
HEIGHT_TARGET := $(FILESYS)/poketool/pokegra/height.narc
HEIGHT_DEPENDENCIES := armips/data/heighttable.s

$(HEIGHT_NARC): $(HEIGHT_DEPENDENCIES)
	mkdir -p $(HEIGHT_DIR)
	$(ARMIPS) $^
	$(PYTHON) $(NARCHIVE) create $@ $(HEIGHT_DIR) -nf

NARC_FILES += $(HEIGHT_NARC)


DEXAREA_DIR := $(BUILD)/zukan_enc_platinum
DEXAREA_NARC := $(BUILD_NARC)/zukan_enc_platinum.narc
DEXAREA_TARGET := $(FILESYS)/application/zukanlist/zkn_data/zukan_enc_platinum.narc
DEXAREA_RAWDATA_DIR := rawdata/files_from_zukan_enc_platinum
DEXAREA_DEPENDENCIES := armips/data/pokedex/areadata.s

$(DEXAREA_NARC): $(DEXAREA_DEPENDENCIES)
#    $(PYTHON) $(NARCHIVE) extract $(DEXAREA_TARGET) -o $(DEXAREA_DIR) -nf
	mkdir -p $(DEXAREA_DIR)
	$(ARMIPS) $^
	cp -r $(DEXAREA_RAWDATA_DIR)/. $(DEXAREA_DIR)
	$(PYTHON) $(NARCHIVE) create $@ $(DEXAREA_DIR) -nf

NARC_FILES += $(DEXAREA_NARC)


DEXSORT_DIR := a214
DEXSORT_NARC := $(BUILD_NARC)/zukan_data.narc
DEXSORT_TARGET := $(FILESYS)/application/zukanlist/zkn_data/zukan_data.narc
DEXSORT_DEPENDENCIES := armips/data/pokedex/pokedexdata.s

$(DEXSORT_NARC): $(DEXSORT_DEPENDENCIES)
	mkdir -p $(DEXSORT_DIR)
	$(ARMIPS) $^
	$(PYTHON) $(NARCHIVE) create $@ $(DEXSORT_DIR) -nf
	rm -r $(DEXSORT_DIR)

NARC_FILES += $(DEXSORT_NARC)


# EGGMOVES_DIR := $(BUILD)/kowaza
# EGGMOVES_NARC := $(BUILD_NARC)/kowaza.narc
# EGGMOVES_TARGET := $(FILESYS)/a/2/2/9
# EGGMOVES_TARGET_2 := $(FILESYS)/kowaza.narc
# EGGMOVES_DEPENDENCIES := armips/data/eggmoves.s

# $(EGGMOVES_NARC): $(EGGMOVES_DEPENDENCIES)
# 	mkdir -p $(EGGMOVES_DIR)
# 	$(ARMIPS) $^
# 	$(PYTHON) $(NARCHIVE) create $@ $(EGGMOVES_DIR) -nf

# NARC_FILES += $(EGGMOVES_NARC)


# EVOS_DIR := $(BUILD)/a034
# EVOS_NARC := $(BUILD_NARC)/a034.narc
# EVOS_TARGET := $(FILESYS)/a/0/3/4
# EVOS_DEPENDENCIES := armips/data/evodata.s

# $(EVOS_NARC): $(EVOS_DEPENDENCIES)
# 	mkdir -p $(EVOS_DIR)
# 	$(ARMIPS) $^
# 	$(PYTHON) $(NARCHIVE) create $@ $(EVOS_DIR) -nf

# NARC_FILES += $(EVOS_NARC)


LEARNSET_DIR := $(BUILD)/wotbl
LEARNSET_NARC := $(BUILD_NARC)/wotbl.narc
LEARNSET_TARGET := $(FILESYS)/poketool/personal/wotbl.narc
LEARNSET_DEPENDENCIES := armips/data/levelupdata.s

$(LEARNSET_NARC): $(LEARNSET_DEPENDENCIES)
	mkdir -p $(LEARNSET_DIR)
	$(ARMIPS) $^
	$(PYTHON) $(NARCHIVE) create $@ $(LEARNSET_DIR) -nf

NARC_FILES += $(LEARNSET_NARC)


# REGIONALDEX_DIR := $(BUILD)/a138
# REGIONALDEX_NARC := $(BUILD_NARC)/a138.narc
# REGIONALDEX_TARGET := $(FILESYS)/a/1/3/8
# REGIONALDEX_DEPENDENCIES := armips/data/regionaldex.s

# $(REGIONALDEX_NARC): $(REGIONALDEX_DEPENDENCIES)
# 	mkdir -p $(REGIONALDEX_DIR)
# 	$(ARMIPS) $^
# 	$(PYTHON) $(NARCHIVE) create $@ $(REGIONALDEX_DIR) -nf

# NARC_FILES += $(REGIONALDEX_NARC)


# TRAINERDATA_DIR := $(BUILD)/a055
# TRAINERDATA_DIR_2 := $(BUILD)/a056
# TRAINERDATA_NARC := $(BUILD_NARC)/a055.narc
# TRAINERDATA_NARC_2 := $(BUILD_NARC)/a056.narc
# TRAINERDATA_TARGET := $(FILESYS)/a/0/5/5
# TRAINERDATA_TARGET_2 := $(FILESYS)/a/0/5/6
# TRAINERDATA_DEPENDENCIES := armips/data/trainers/trainers.s

# $(TRAINERDATA_NARC): $(TRAINERDATA_DEPENDENCIES)
# 	mkdir -p $(TRAINERDATA_DIR) $(TRAINERDATA_DIR_2)
# 	$(ARMIPS) $^
# 	$(PYTHON) $(NARCHIVE) create $@ $(TRAINERDATA_DIR) -nf
# 	$(PYTHON) $(NARCHIVE) create $(TRAINERDATA_NARC_2) $(TRAINERDATA_DIR_2) -nf

# NARC_FILES += $(TRAINERDATA_NARC)


#FOOTPRINTS_DIR := $(BUILD)/pokefoot
FOOTPRINTS_NARC := $(BUILD_NARC)/pokefoot.narc
FOOTPRINTS_TARGET := $(FILESYS)/poketool/pokefoot/pokefoot.narc
FOOTPRINTS_DEPENDENCIES_DIR := rawdata/footprints
FOOTPRINTS_DEPENDENCIES := $(FOOTPRINTS_DEPENDENCIES_DIR)/*

$(FOOTPRINTS_NARC): $(FOOTPRINTS_DEPENDENCIES)
	$(PYTHON) $(NARCHIVE) create $@ $(FOOTPRINTS_DEPENDENCIES_DIR) -nf

NARC_FILES += $(FOOTPRINTS_NARC)


# MOVEANIM_DIR := $(BUILD)/move/move_anim
# MOVEANIM_NARC := $(BUILD_NARC)/a010.narc
# MOVEANIM_TARGET := $(FILESYS)/a/0/1/0
# MOVEANIM_DEPENDENCIES_DIR := armips/move/move_anim
# MOVEANIM_DEPENDENCIES := $(MOVEANIM_DEPENDENCIES_DIR)/*

# MOVEANIM_SRCS := $(wildcard $(MOVEANIM_DEPENDENCIES_DIR)/*.s)
# MOVEANIM_OBJS := $(patsubst $(MOVEANIM_DEPENDENCIES_DIR)/%.s,$(MOVEANIM_DIR)/0_%,$(MOVEANIM_SRCS))

# $(MOVEANIM_DIR)/0_%:$(MOVEANIM_DEPENDENCIES_DIR)/%.s
# 	$(ARMIPS) $<

# $(MOVEANIM_NARC): $(MOVEANIM_OBJS)
# #	for file in $(MOVEANIM_DEPENDENCIES); do $(ARMIPS) $$file; done
# 	$(PYTHON) $(NARCHIVE) create $@ $(MOVEANIM_DIR) -nf

# NARC_FILES += $(MOVEANIM_NARC)


# MOVESUBANIM_DIR := $(BUILD)/move/move_sub_anim
# MOVESUBANIM_NARC := $(BUILD_NARC)/a061.narc
# MOVESUBANIM_TARGET := $(FILESYS)/a/0/6/1
# MOVESUBANIM_DEPENDENCIES_DIR := armips/move/move_sub_anim
# MOVESUBANIM_DEPENDENCIES := $(MOVESUBANIM_DEPENDENCIES_DIR)/*

# MOVESUBANIM_SRCS := $(wildcard $(MOVESUBANIM_DEPENDENCIES_DIR)/*.s)
# MOVESUBANIM_OBJS := $(patsubst $(MOVESUBANIM_DEPENDENCIES_DIR)/%.s,$(MOVESUBANIM_DIR)/1_%,$(MOVESUBANIM_SRCS))

# $(MOVESUBANIM_DIR)/1_%:$(MOVESUBANIM_DEPENDENCIES_DIR)/%.s
# 	$(ARMIPS) $<

# $(MOVESUBANIM_NARC): $(MOVESUBANIM_OBJS)
# #	for file in $(MOVESUBANIM_DEPENDENCIES); do $(ARMIPS) $$file; done
# 	$(PYTHON) $(NARCHIVE) create $@ $(MOVESUBANIM_DIR) -nf

# NARC_FILES += $(MOVESUBANIM_NARC)


# MOVE_SEQ_DIR := $(BUILD)/move/battle_move_seq
# MOVE_SEQ_NARC := $(BUILD_NARC)/a000.narc
# MOVE_SEQ_TARGET := $(FILESYS)/a/0/0/0
# MOVE_SEQ_DEPENDENCIES_DIR := armips/move/battle_move_seq
# MOVE_SEQ_DEPENDENCIES := $(MOVE_SEQ_DEPENDENCIES_DIR)/*

# MOVE_SEQ_SRCS := $(wildcard $(MOVE_SEQ_DEPENDENCIES_DIR)/*.s)
# MOVE_SEQ_OBJS := $(patsubst $(MOVE_SEQ_DEPENDENCIES_DIR)/%.s,$(MOVE_SEQ_DIR)/0_%,$(MOVE_SEQ_SRCS))

# $(MOVE_SEQ_DIR)/0_%:$(MOVE_SEQ_DEPENDENCIES_DIR)/%.s
# 	$(ARMIPS) $<

# $(MOVE_SEQ_NARC): $(MOVE_SEQ_OBJS)
# #	for file in $(MOVE_SEQ_DEPENDENCIES); do $(ARMIPS) $$file; done
# 	$(PYTHON) $(NARCHIVE) create $@ $(MOVE_SEQ_DIR) -nf

# NARC_FILES += $(MOVE_SEQ_NARC)


# BATTLE_EFF_DIR := $(BUILD)/move/battle_eff_seq
# BATTLE_EFF_NARC := $(BUILD_NARC)/a030.narc
# BATTLE_EFF_TARGET := $(FILESYS)/a/0/3/0
# BATTLE_EFF_DEPENDENCIES_DIR := armips/move/battle_eff_seq
# BATTLE_EFF_DEPENDENCIES := $(BATTLE_EFF_DEPENDENCIES_DIR)/*

# BATTLE_EFF_SRCS := $(wildcard $(BATTLE_EFF_DEPENDENCIES_DIR)/*.s)
# BATTLE_EFF_OBJS := $(patsubst $(BATTLE_EFF_DEPENDENCIES_DIR)/%.s,$(BATTLE_EFF_DIR)/0_%,$(BATTLE_EFF_SRCS))

# $(BATTLE_EFF_DIR)/0_%:$(BATTLE_EFF_DEPENDENCIES_DIR)/%.s
# 	$(ARMIPS) $<

# $(BATTLE_EFF_NARC): $(BATTLE_EFF_OBJS)
# #	for file in $(BATTLE_EFF_DEPENDENCIES); do $(ARMIPS) $$file; done
# 	$(PYTHON) $(NARCHIVE) create $@ $(BATTLE_EFF_DIR) -nf

# NARC_FILES += $(BATTLE_EFF_NARC)


# BATTLE_SUB_DIR := $(BUILD)/move/battle_sub_seq
# BATTLE_SUB_NARC := $(BUILD_NARC)/a001.narc
# BATTLE_SUB_TARGET := $(FILESYS)/a/0/0/1
# BATTLE_SUB_DEPENDENCIES_DIR := armips/move/battle_sub_seq
# BATTLE_SUB_DEPENDENCIES := $(BATTLE_SUB_DEPENDENCIES_DIR)/*

# BATTLE_SUB_SRCS := $(wildcard $(BATTLE_SUB_DEPENDENCIES_DIR)/*.s)
# BATTLE_SUB_OBJS := $(patsubst $(BATTLE_SUB_DEPENDENCIES_DIR)/%.s,$(BATTLE_SUB_DIR)/1_%,$(BATTLE_SUB_SRCS))

# $(BATTLE_SUB_DIR)/1_%:$(BATTLE_SUB_DEPENDENCIES_DIR)/%.s
# 	$(ARMIPS) $<

# $(BATTLE_SUB_NARC): $(BATTLE_SUB_OBJS)
# #	for file in $(BATTLE_SUB_DEPENDENCIES); do $(ARMIPS) $$file; done
# 	$(PYTHON) $(NARCHIVE) create $@ $(BATTLE_SUB_DIR) -nf

# NARC_FILES += $(BATTLE_SUB_NARC)


# ITEMGFX_DIR := $(BUILD)/a018
# ITEMGFX_NARC := $(BUILD_NARC)/a018.narc
# ITEMGFX_TARGET := $(FILESYS)/a/0/1/8
# ITEMGFX_DEPENDENCIES_DIR := data/graphics/item
# ITEMGFX_DEPENDENCIES := $(ITEMGFX_DEPENDENCIES_DIR)/*

# ITEMGFX_SRCS := $(wildcard $(ITEMGFX_DEPENDENCIES_DIR)/*.png)
# ITEMGFX_OBJS := $(patsubst $(ITEMGFX_DEPENDENCIES_DIR)/%.png,$(ITEMGFX_DIR)/9_%-00.NCGR,$(ITEMGFX_SRCS))
# ITEMGFX_PALS := $(patsubst $(ITEMGFX_DEPENDENCIES_DIR)/%.png,$(ITEMGFX_DIR)/9_%-01.NCLR,$(ITEMGFX_SRCS))

# $(ITEMGFX_DIR)/9_%-00.NCGR:$(ITEMGFX_DEPENDENCIES_DIR)/%.png
# 	$(GFX) $< $@ -clobbersize -version101

# $(ITEMGFX_DIR)/9_%-01.NCLR:$(ITEMGFX_DEPENDENCIES_DIR)/%.png
# 	$(GFX) $< $@ -ir -bitdepth 4

# # go overkill on the removal + support 4-digit removal, so that's fine
# $(ITEMGFX_NARC): $(ITEMGFX_OBJS) $(ITEMGFX_PALS)
# 	$(PYTHON) $(NARCHIVE) extract $(ITEMGFX_TARGET) -o $(ITEMGFX_DIR) -nf
# 	for n in $$(seq 797 $$(expr $$(ls $(ITEMGFX_DIR) | wc -l) - 1)); do rm -f $(ITEMGFX_DIR)/8_$$n; done
# 	for n in $$(seq 797 $$(expr $$(ls $(ITEMGFX_DIR) | wc -l) - 1)); do rm -f $(ITEMGFX_DIR)/8_$$(printf "%04d" $$n); done
# 	$(PYTHON) $(NARCHIVE) create $@ $(ITEMGFX_DIR) -nf

# NARC_FILES += $(ITEMGFX_NARC)


# ICONGFX_DIR := $(BUILD)/pokemonicon
# ICONGFX_NARC := $(BUILD_NARC)/pokemonicon.narc
# ICONGFX_TARGET := $(FILESYS)/a/0/2/0
# ICONGFX_DEPENDENCIES_DIR := data/graphics/icongfx
# ICONGFX_RAWDATA_DIR := rawdata/files_from_a020
# ICONGFX_DEPENDENCIES := $(ICONGFX_DEPENDENCIES_DIR)/*

# ICONGFX_SRCS := $(wildcard $(ICONGFX_DEPENDENCIES_DIR)/*.png)
# ICONGFX_OBJS := $(patsubst $(ICONGFX_DEPENDENCIES_DIR)/%.png,$(ICONGFX_DIR)/1_%.NCGR,$(ICONGFX_SRCS))

# $(ICONGFX_DIR)/1_%.NCGR:$(ICONGFX_DEPENDENCIES_DIR)/%.png
# 	$(GFX) $< $@ -clobbersize -version101

# $(ICONGFX_NARC): $(ICONGFX_OBJS)
# 	cp -r $(ICONGFX_RAWDATA_DIR)/. $(ICONGFX_DIR)
# 	$(PYTHON) $(NARCHIVE) create $@ $(ICONGFX_DIR) -nf

# NARC_FILES += $(ICONGFX_NARC)


# OVERWORLDS_DIR := $(BUILD)/pokemonow
# OVERWORLDS_NARC := $(BUILD_NARC)/pokemonow.narc
# OVERWORLDS_TARGET := $(FILESYS)/a/0/8/1
# OVERWORLDS_DEPENDENCIES_DIR := data/graphics/overworlds
# OVERWORLDS_DEPENDENCIES := $(OVERWORLDS_DEPENDENCIES_DIR)/*

# OVERWORLDS_SRCS := $(wildcard $(OVERWORLDS_DEPENDENCIES_DIR)/*.png)
# OVERWORLDS_SRCS := $(filter-out $(wildcard $(OVERWORLDS_DEPENDENCIES_DIR)/*_shiny.png),$(OVERWORLDS_SRCS))
# OVERWORLDS_OBJS := $(patsubst $(OVERWORLDS_DEPENDENCIES_DIR)/%.png,$(OVERWORLDS_DIR)/2_%,$(OVERWORLDS_SRCS))
# OVERWORLDS_OBJ_FILTERS := $(patsubst $(OVERWORLDS_DEPENDENCIES_DIR)/%.png,$(OVERWORLDS_DIR)/3_%,$(OVERWORLDS_SRCS))

# $(OVERWORLDS_DIR)/2_%_shiny:$(OVERWORLDS_DEPENDENCIES_DIR)/%_shiny.png
# 	@:

# $(OVERWORLDS_DIR)/2_%:$(OVERWORLDS_DEPENDENCIES_DIR)/%.png
# 	$(BTX) $< $@

# overworld_extract:
# 	$(PYTHON) $(NARCHIVE) extract $(OVERWORLDS_TARGET) -o $(OVERWORLDS_DIR) -nf
# 	@rm -rf $(patsubst $(OVERWORLDS_DIR)/3_0%,$(OVERWORLDS_DIR)/1_%,$(OVERWORLDS_OBJ_FILTERS))
# 	@rm -rf $(patsubst $(OVERWORLDS_DIR)/3_%,$(OVERWORLDS_DIR)/1_%,$(OVERWORLDS_OBJ_FILTERS))

# $(OVERWORLDS_NARC): | overworld_extract $(OVERWORLDS_OBJS)
# 	$(PYTHON) $(NARCHIVE) create $@ $(OVERWORLDS_DIR) -nf

# NARC_FILES += $(OVERWORLDS_NARC)


# DEXGFX_DIR := $(BUILD)/dexgfx
# DEXGFX_NARC := $(BUILD_NARC)/dexgfx.narc
# DEXGFX_TARGET := $(FILESYS)/a/0/6/8
# DEXGFX_DEPENDENCIES_DIR := rawdata/dex_gfx
# DEXGFX_DEPENDENCIES := $(DEXGFX_DEPENDENCIES_DIR)/*

# $(DEXGFX_NARC): $(DEXGFX_DEPENDENCIES)
# 	$(PYTHON) $(NARCHIVE) extract $(DEXGFX_TARGET) -o $(DEXGFX_DIR) -nf
# 	cp -r $(DEXGFX_DEPENDENCIES_DIR)/. $(DEXGFX_DIR)
# 	$(PYTHON) $(NARCHIVE) create $@ $(DEXGFX_DIR) -nf

# NARC_FILES += $(DEXGFX_NARC)


# BATTLEGFX_DIR := $(BUILD)/battlegfx
# BATTLEGFX_NARC := $(BUILD_NARC)/battlegfx.narc
# BATTLEGFX_TARGET := $(FILESYS)/a/0/0/8
# BATTLEGFX_DEPENDENCIES_DIR := rawdata/battle_gfx
# BATTLEGFX_DEPENDENCIES := $(BATTLEGFX_DEPENDENCIES_DIR)/*

# $(BATTLEGFX_NARC): $(BATTLEGFX_DEPENDENCIES)
# 	$(PYTHON) $(NARCHIVE) extract $(BATTLEGFX_TARGET) -o $(BATTLEGFX_DIR) -nf
# 	cp -r $(BATTLEGFX_DEPENDENCIES_DIR)/. $(BATTLEGFX_DIR)
# 	$(PYTHON) $(NARCHIVE) create $@ $(BATTLEGFX_DIR) -nf

# NARC_FILES += $(BATTLEGFX_NARC)


# OTHERPOKE_DIR := $(BUILD)/otherpoke
# OTHERPOKE_NARC := $(BUILD_NARC)/otherpoke.narc
# OTHERPOKE_TARGET := $(FILESYS)/a/1/1/4
# OTHERPOKE_DEPENDENCIES_DIR := rawdata/otherpoke
# OTHERPOKE_DEPENDENCIES := $(OTHERPOKE_DEPENDENCIES_DIR)/*

# $(OTHERPOKE_NARC): $(OTHERPOKE_DEPENDENCIES)
# 	$(PYTHON) $(NARCHIVE) extract $(OTHERPOKE_TARGET) -o $(OTHERPOKE_DIR) -nf
# 	@rm -f $(OTHERPOKE_DIR)/4_212 $(OTHERPOKE_DIR)/4_213
# 	$(GFX) $(OTHERPOKE_DEPENDENCIES_DIR)/arceus-fairy-normal.pal $(OTHERPOKE_DIR)/4_212.NCLR -bitdepth 8 -nopad -comp 10
# 	$(GFX) $(OTHERPOKE_DEPENDENCIES_DIR)/arceus-fairy-shiny.pal $(OTHERPOKE_DIR)/4_213.NCLR -bitdepth 8 -nopad -comp 10
# 	$(PYTHON) $(NARCHIVE) create $@ $(OTHERPOKE_DIR) -nf

# NARC_FILES += $(OTHERPOKE_NARC)


ENCOUNTER_DIR := $(BUILD)/pl_enc_data
ENCOUNTER_NARC := $(BUILD_NARC)/pl_enc_data.narc
ENCOUNTER_TARGET := $(FILESYS)/fielddata/encountdata/pl_enc_data.narc
ENCOUNTER_DEPENDENCIES := armips/data/encounters.s

$(ENCOUNTER_NARC): $(ENCOUNTER_DEPENDENCIES)
	mkdir -p $(ENCOUNTER_DIR)
	$(ARMIPS) $^
	$(PYTHON) $(NARCHIVE) create $@ $(ENCOUNTER_DIR) -nf

NARC_FILES += $(ENCOUNTER_NARC)
