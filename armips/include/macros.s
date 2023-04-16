// level up learnset macros

.macro levelup,species

	.if species < 10
		.create "build/wotbl/learnset_000" + tostring(species),0
	.elseif species < 100
		.create "build/wotbl/learnset_00" + tostring(species),0
	.elseif species < 1000
		.create "build/wotbl/learnset_0" + tostring(species),0
	.else
		.create "build/wotbl/learnset_" + tostring(species),0
	.endif

.endmacro

.macro learnset,move,level
.if move <= MOVE_SHADOW_FORCE
    .word (level << 16 | move)
.endif
.endmacro

.macro terminatelearnset
    .word 0xFFFF
	
	.close
.endmacro


// mon data macros

.macro mondata,species

	.if species < 10
		.create "build/pl_personal/mondata_000" + tostring(species),0
	.elseif species < 100
		.create "build/pl_personal/mondata_00" + tostring(species),0
	.elseif species < 1000
		.create "build/pl_personal/mondata_0" + tostring(species),0
	.else
		.create "build/pl_personal/mondata_" + tostring(species),0
	.endif

.endmacro

.macro basestats,hp,atk,def,spd,spatk,spdef
	.byte hp, atk, def, spd, spatk, spdef
.endmacro

.macro types,type1,type2
	.byte type1
	.byte type2
.endmacro

.macro catchrate,num
	.byte num
.endmacro

.macro baseexp,num
	.byte num
.endmacro

.macro evyields,hp,atk,def,spd,spatk,spdef
	.halfword (hp | atk << 2 | def << 4 | spd << 6 | spatk << 8 | spdef << 10)
.endmacro

.macro items,item1,item2
	.halfword item1
	.halfword item2
.endmacro

.macro genderratio,num
	.byte num
.endmacro

.macro eggcycles,num
	.byte num
.endmacro

.macro basefriendship,num
	.byte num
.endmacro

.macro growthrate,num
	.byte num
.endmacro

.macro egggroups,group1,group2
	.byte group1
	.byte group2
.endmacro

.macro abilities,abi1,abi2
	.byte abi1
	.byte abi2
.endmacro

.macro runchance,num
	.byte num
.endmacro

.macro colorflip,color,flip
	.byte (color | flip << 7)
.endmacro

.macro tmdata,num1,num2,num3,num4 // defined specifically in separate files though
	.halfword 0 // padding
	
	.word num1
	.word num2
	.word num3
	.word num4
	
	.close
.endmacro


// evolution data macros

.macro evodata,species

	.if species < 10
		.create "build/a034/evodata_000" + tostring(species),0
	.elseif species < 100
		.create "build/a034/evodata_00" + tostring(species),0
	.elseif species < 1000
		.create "build/a034/evodata_0" + tostring(species),0
	.else
		.create "build/a034/evodata_" + tostring(species),0
	.endif
	
.endmacro

.macro evolution,method,parameter,species
	.halfword method
	.halfword parameter
	.halfword species
.endmacro

// fucking 5-bit forms
.macro evolutionwithform,method,parameter,species,form
	.halfword method
	.halfword parameter
	.halfword (species | form << 11)
.endmacro

.macro terminateevodata
	.halfword 0
	
	.close
.endmacro


// egg move macros

.macro eggmove,move
	.halfword move
.endmacro

.macro eggmoveentry,species
	.if species == 1
		.create "build/kowaza/kowaza_0",0
	.endif
	
	.halfword species+20000
.endmacro

.macro terminateeggmoves
	.halfword 0xFFFF
	
	.close
.endmacro


// baby mon macro

.macro babymon,species,baby
	.if species == 0
		.create "base/root/poketool/personal/pms.narc",0
	.endif

	.org (species * 2)
	
	.halfword baby
	
	.if species == NUM_OF_TOTAL_MONS_PLUS_FORMS
		.close
	.endif
.endmacro


// tutor move bitfield macro

.macro tutordata,species,data1,data2
	.if species == 1
		.create "base/root/fielddata/wazaoshie/waza_oshie.bin",0
	.endif

	.org ((species - 1) * 8)
	
	.word data1
	.word data2
.endmacro

.macro heightentry,species,fback,mback,ffront,mfront
	.if ((species) * 4) < 10
		.create "build/height/height_000" + tostring((species) * 4),0
	.elseif ((species) * 4) < 100
		.create "build/height/height_00" + tostring((species) * 4),0
	.elseif ((species) * 4) < 1000
		.create "build/height/height_0" + tostring((species) * 4),0
	.else
		.create "build/height/height_" + tostring((species) * 4),0
	.endif
	
	.if fback != "null"
		.byte fback
	.endif
	
	.close

	.if ((species) * 4 + 1) < 10
		.create "build/height/height_000" + tostring((species) * 4 + 1),0
	.elseif ((species) * 4 + 1) < 100
		.create "build/height/height_00" + tostring((species) * 4 + 1),0
	.elseif ((species) * 4 + 1) < 1000
		.create "build/height/height_0" + tostring((species) * 4 + 1),0
	.else
		.create "build/height/height_" + tostring((species) * 4 + 1),0
	.endif
	
	.if mback != "null"
		.byte mback
	.endif
	
	.close

	.if ((species) * 4 + 2) < 10
		.create "build/height/height_000" + tostring((species) * 4 + 2),0
	.elseif ((species) * 4 + 2) < 100
		.create "build/height/height_00" + tostring((species) * 4 + 2),0
	.elseif ((species) * 4 + 2) < 1000
		.create "build/height/height_0" + tostring((species) * 4 + 2),0
	.else
		.create "build/height/height_" + tostring((species) * 4 + 2),0
	.endif
	
	.if ffront != "null"
		.byte ffront
	.endif
	
	.close

	.if ((species) * 4 + 3) < 10
		.create "build/height/height_000" + tostring((species) * 4 + 3),0
	.elseif ((species) * 4 + 3) < 100
		.create "build/height/height_00" + tostring((species) * 4 + 3),0
	.elseif ((species) * 4 + 3) < 1000
		.create "build/height/height_0" + tostring((species) * 4 + 3),0
	.else
		.create "build/height/height_" + tostring((species) * 4 + 3),0
	.endif
	
	.if mfront != "null"
		.byte mfront
	.endif
	
	.close
.endmacro

.macro dataentry,species,monfrontanim,monbackanim,monoffy,shadowoffx,shadowsize
	.if (species) > SPECIES_ARCEUS // fill in generic frame data for new mons (it is bulbasaur)
		.orga ((species) * 0x59)
		.byte 0x00, 0x02, 0x00, 0x00, 0x04, 0x00, 0x00, 0x01, 0x0A, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x09, 0x05, 0x0B, 0x00, 0x0B, 0x00, 0x00, 0x01, 0x0F, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00
	.endif 
	
	.orga ((species) * 0x59) + 1
	.byte monfrontanim
	
	.orga ((species) * 0x59) + 0x2C
	.byte monbackanim
	
	.orga ((species) * 0x59) + 0x56
	.byte monoffy
	.byte shadowoffx
	.byte shadowsize
.endmacro


// mon overworld narc a141 macro

.macro overworlddata,ownum,canenter,bouncespeed
	.if ownum < 10
		.create "build/a141/a141_000" + tostring(ownum),0
	.elseif ownum < 100
		.create "build/a141/a141_00" + tostring(ownum),0
	.elseif ownum < 1000
		.create "build/a141/a141_0" + tostring(ownum),0
	.else
		.create "build/a141/a141_" + tostring(ownum),0
	.endif
	
	.byte 0
	.byte canenter
	.byte bouncespeed
	.byte 0
	
	.close
.endmacro


// mon dex area macros

.macro specialareas,monnum,timeofday
	.if (timeofday == 0) // morning time
		.if (4 + monnum) < 10
			.create "build/zukan_enc_platinum/zukan_enc_platinum_000" + tostring(4 + monnum),0
		.elseif (4 + monnum) < 100
			.create "build/zukan_enc_platinum/zukan_enc_platinum_00" + tostring(4 + monnum),0
		.elseif (4 + monnum) < 1000
			.create "build/zukan_enc_platinum/zukan_enc_platinum_0" + tostring(4 + monnum),0
		.else
			.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum),0
		.endif
	.elseif (timeofday == 1) // day time
		.if (4 + monnum + NUM_OF_MONS) < 10
			.create "build/zukan_enc_platinum/zukan_enc_platinum_000" + tostring(4 + monnum + NUM_OF_MONS),0
		.elseif (4 + monnum + NUM_OF_MONS) < 100
			.create "build/zukan_enc_platinum/zukan_enc_platinum_00" + tostring(4 + monnum + NUM_OF_MONS),0
		.elseif (4 + monnum + NUM_OF_MONS) < 1000
			.create "build/zukan_enc_platinum/zukan_enc_platinum_0" + tostring(4 + monnum + NUM_OF_MONS),0
		.else
			.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + NUM_OF_MONS),0
		.endif
	.elseif (timeofday == 2) // night time
		.if (4 + monnum + (2*NUM_OF_MONS)) < 10
			.create "build/zukan_enc_platinum/zukan_enc_platinum_000" + tostring(4 + monnum + (2*NUM_OF_MONS)),0
		.elseif (4 + monnum + (2*NUM_OF_MONS)) < 100
			.create "build/zukan_enc_platinum/zukan_enc_platinum_00" + tostring(4 + monnum + (2*NUM_OF_MONS)),0
		.elseif (4 + monnum + (2*NUM_OF_MONS)) < 1000
			.create "build/zukan_enc_platinum/zukan_enc_platinum_0" + tostring(4 + monnum + (2*NUM_OF_MONS)),0
		.else
			.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (2*NUM_OF_MONS)),0
		.endif
	.elseif (timeofday == 3) // special
		.if (4 + monnum + (3*NUM_OF_MONS)) < 10
			.create "build/zukan_enc_platinum/zukan_enc_platinum_000" + tostring(4 + monnum + (3*NUM_OF_MONS)),0
		.elseif (4 + monnum + (3*NUM_OF_MONS)) < 100
			.create "build/zukan_enc_platinum/zukan_enc_platinum_00" + tostring(4 + monnum + (3*NUM_OF_MONS)),0
		.elseif (4 + monnum + (3*NUM_OF_MONS)) < 1000
			.create "build/zukan_enc_platinum/zukan_enc_platinum_0" + tostring(4 + monnum + (3*NUM_OF_MONS)),0
		.else
			.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (3*NUM_OF_MONS)),0
		.endif
	.else // timeofday == 4
		.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (4*NUM_OF_MONS)),0
	.endif
.endmacro

.macro routesandcities,monnum,timeofday
	.if (timeofday == 0) // morning time
		.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (5*NUM_OF_MONS)),0
	.elseif (timeofday == 1) // day time
		.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (6*NUM_OF_MONS)),0
	.elseif (timeofday == 2) // night time
		.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (7*NUM_OF_MONS)),0
	.elseif (timeofday == 3) // special
		.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (8*NUM_OF_MONS)),0
	.else // timeofday == 4
		.create "build/zukan_enc_platinum/zukan_enc_platinum_" + tostring(4 + monnum + (9*NUM_OF_MONS)),0
	.endif
.endmacro

.macro dexendareadata
	.word 0
	
	.close
.endmacro


// trainer data macros

.macro trainerdata,num
	.if num < 10
		.create "build/a055/5_00" + tostring(num),0
	.elseif num < 100
		.create "build/a055/5_0" + tostring(num),0
	.else
		.create "build/a055/5_" + tostring(num),0
	.endif
.endmacro

.macro trainermontype,num
	.byte num
.endmacro

.macro trainerclass,num
	.byte num
.endmacro

.macro battletype,num
	.byte num
.endmacro

.macro nummons,num
	.byte num
.endmacro

// 4 items

.macro aiflags,num
	.word num
.endmacro

.macro battletype2,num
	.byte num
.endmacro

.macro endentry
	.byte 0, 0, 0
	
	.close
.endmacro


// trainer mon data macros

.macro party,num
	.if num < 10
		.create "build/a056/6_00" + tostring(num),0
	.elseif num < 100
		.create "build/a056/6_0" + tostring(num),0
	.else
		.create "build/a056/6_" + tostring(num),0
	.endif
.endmacro

.macro ivs,num
	.byte num
.endmacro

.macro abilityslot,num
	.byte num
.endmacro

.macro level,num
	.halfword num
.endmacro

.macro monwithform,species,formid
	.halfword (species | (formid<<11))
.endmacro

.macro pokemon,num
	monwithform num, 0
.endmacro

.macro ballseal,num
	.halfword num
.endmacro

.macro move,num
	.halfword num
.endmacro

.macro item,num
	.halfword num
.endmacro

.macro ability,num
	.halfword num
.endmacro

.macro ball,num
	.halfword num
.endmacro

.macro setivs,hp,atk,def,spd,spatk,spdef
	.byte hp, atk, def, spd, spatk, spdef
.endmacro

.macro setevs,hp,atk,def,spd,spatk,spdef
	.byte hp, atk, def, spd, spatk, spdef
.endmacro

.macro nature,num
	.byte num
.endmacro

.macro shinylock,num
	.byte num
.endmacro

.macro additionalflags,num
    .word num
.endmacro

.macro status,num
	.word num
.endmacro

.macro stathp,num
	.halfword num
.endmacro

.macro statatk,num
	.halfword num
.endmacro

.macro statdef,num
	.halfword num
.endmacro

.macro statspeed,num
	.halfword num
.endmacro

.macro statspatk,num
	.halfword num
.endmacro

.macro statspdef,num
	.halfword num
.endmacro

// types already exists

.macro ppcounts,num1,num2,num3,num4
	.byte num1, num2, num3, num4
.endmacro

.macro nickname,nick
	.stringn nick
.endmacro

.macro endparty
	.close
.endmacro

// encounter data macros

.macro encounterdata,num
	.if num < 10
		.create "build/pl_enc_data/pl_enc_data_00" + tostring(num),0
	.elseif num < 100
		.create "build/pl_enc_data/pl_enc_data_0" + tostring(num),0
	.else
		.create "build/pl_enc_data/pl_enc_data_" + tostring(num),0
	.endif
.endmacro

.macro walkrate,num
	.word num
.endmacro

.macro surfrate,num
	.word num
.endmacro

.macro oldrodrate,num
	.word num
.endmacro

.macro goodrodrate,num
	.word num
.endmacro

.macro superrodrate,num
	.word num
.endmacro

.macro encounterwithform,species,form
	.word (species | (form << 11))
.endmacro

.macro encounter,species
	encounterwithform species, 0
.endmacro

.macro encounterwithlevelandform,species,form,level
	.word level, (species | (form << 11))
.endmacro

.macro encounterwithlevel,species,level
	encounterwithlevelandform species, 0, level
.endmacro

.macro encounterwithlevelsandform,species,form,minlevel,maxlevel
	.byte maxlevel, minlevel
	.halfword 0
	.word (species | (form << 11))
.endmacro

.macro encounterwithlevels,species,minlevel,maxlevel
	encounterwithlevelsandform species, 0, minlevel, maxlevel
.endmacro
