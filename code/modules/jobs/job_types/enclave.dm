/datum/job/enclave //do NOT use this for anything, it's just to store faction datums
	department_flag = ENCLAVE
	selection_color = "#aaaaf7"
	faction = "ENCALVE"

	access = list(ACCESS_ENCLAVE)
	minimal_access = list(ACCESS_ENCLAVE)
	forbids = "The US Elite Soldiers forbids: compassion."
	enforces = "The US Elite Soldiers expects: Obeying the lawful orders of superiors. Kill all creatures with radiation levels.  Create a hegemony of pure human beings without radiation."
	objectivesList = list("Stay with your comrades and create a base to operate and may god save the USA!","Praise the lord and pass the ammunation.", "Remove every single alive creature who has levels of Radiation from existence.")

/datum/outfit/job/enclave/
	name = "Enclavedatums"
	jobtype = /datum/job/enclave/
	gunsmith_one = TRUE
	gunsmith_two = TRUE
	pa_wear = TRUE
	glasses =       /obj/item/clothing/glasses/night
	ears = /obj/item/radio/headset/headset_enclave
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/f13/leather
	r_pocket = /obj/item/flashlight/flare
	l_pocket = /obj/item/attachments/scope

/datum/outfit/job/enclave/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)

/datum/outfit/job/enclave/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/*
Commander
*/
/datum/job/enclave/f13uscommander
	title = "US Commander"
	flag = F13USCOMMANDER
	department_flag = ENCLAVE
	req_admin_notify = 1
	total_positions = 1
	spawn_positions = 1
	supervisors = "the US Government"
	selection_color = "#aaaaf7"
	exp_type = EXP_TYPE_ENCLAVE
	description = "You are the acting US Commander, your goals is to find a base and make the US government and Enclave goals arise."
	display_order = JOB_DIS_PLAY_ORDER_US_COMMANDER

	outfit = /datum/outfit/job/enclave/f13uscommander

	access = list()
	minimal_access = list()

/datum/outfit/job/enclave/f13uscommander
	name = "US Commander"
	jobtype = /datum/job/enclave/f13uscommander

	id = /obj/item/card/id/gold
	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/f13/power_armor/advanced/mk2
	belt = /obj/item/storage/belt/military/assault
	head = /obj/item/clothing/head/helmet/f13/power_armor/advanced/mk2
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	gunsmith_three = TRUE
	suit_store = /obj/item/gun/ballistic/automatic/ar
	backpack_contents = list(
		/obj/item/shield/energy=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/energy/laser/aer14=1, \
		/obj/item/gun/ballistic/automatic/pistol/n99=1,\
		/obj/item/stock_parts/cell/ammo/mfc=2, \
		/obj/item/ammo_box/magazine/m10mm_adv/simple=1, \
		/obj/item/ammo_box/magazine/m556/rifle/assault=2, \
		/obj/item/binoculars=1,\
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super=2, \
		/obj/item/healthanalyzer/advanced=1
		)
/*
Medic
*/
/datum/job/enclave/f13usmedic
	title = "US Medic"
	flag = F13USMEDIC
	department_flag = ENCLAVE
	//
	total_positions = 1
	spawn_positions = 1
	supervisors = "the commander"
	selection_color = "#ccccff"
	exp_type = EXP_TYPE_ENCLAVE
	display_order = JOB_DIS_PLAY_ORDER_US_MEDIC
	outfit = /datum/outfit/job/enclave/f13usmedic

	access = list()
	minimal_access = list()

/datum/outfit/job/enclave/f13usmedic
	name = "US Medic"
	jobtype = /datum/job/enclave/f13usmedic
	id = /obj/item/card/id/gold
	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/f13/power_armor/advanced
	belt = /obj/item/storage/belt/military/assault
	head = /obj/item/clothing/head/helmet/f13/power_armor/advanced
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	suit_store = /obj/item/gun/ballistic/automatic/pistol/n99
	backpack_contents = list(
		/obj/item/shield/energy=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/energy/laser/aer14=1, \
		/obj/item/stock_parts/cell/ammo/mfc=2,\
		/obj/item/ammo_box/magazine/m10mm_adv/simple=2,\
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super=2, \
		/obj/item/reagent_containers/dropper/SR/NotVault = 1,\
		/obj/item/reagent_containers/hypospray/CMO=1,\
		/obj/item/healthanalyzer/advanced=1,\
		/obj/item/gun/medbeam=1, \
		/obj/item/storage/firstaid/regular=1
		)


/*
Private
*/
/datum/job/enclave/f13usprivate
	title = "US Private"
	flag = F13USPRIVATE
	department_flag = ENCLAVE
	//
	total_positions = 1
	spawn_positions = 1
	supervisors = "the commander"
	selection_color = "#ccccff"
	exp_type = EXP_TYPE_ENCLAVE
	display_order = JOB_DIS_PLAY_ORDER_US_PRIVATE
	outfit = /datum/outfit/job/enclave/f13usprivate
	access = list()
	minimal_access = list()

/datum/outfit/job/enclave/f13usprivate
	name = "US Private"
	jobtype = /datum/job/enclave/f13usprivate

	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/f13/power_armor/advanced
	belt = /obj/item/storage/belt/military/assault
	head = /obj/item/clothing/head/helmet/f13/power_armor/advanced
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	suit_store = /obj/item/gun/ballistic/automatic/ar
	backpack_contents = list(
		/obj/item/shield/energy=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/energy/laser/aer14=1, \
		/obj/item/stock_parts/cell/ammo/mfc=2, \
		/obj/item/gun/energy/laser/plasma/glock=1, \
		/obj/item/stock_parts/cell/ammo/ec=2, \
		/obj/item/ammo_box/magazine/m556/rifle/assault=2, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super=2, \
		/obj/item/binoculars=1, \
		/obj/item/healthanalyzer/advanced=1
		)

/*
Scientist
*/
/datum/job/enclave/f13usscientist
	title = "US Scientist"
	flag = F13USSCIENTIST
	department_flag = ENCLAVE
	//
	total_positions = 1
	spawn_positions = 1
	supervisors = "the commander"
	selection_color = "#ccccff"
	exp_type = EXP_TYPE_ENCLAVE
	display_order = JOB_DIS_PLAY_ORDER_US_SCIENTIST
	outfit = /datum/outfit/job/enclave/f13usscientist

	access = list()
	minimal_access = list()

/datum/outfit/job/enclave/f13usscientist
	name = "US Scientist"
	jobtype = /datum/job/enclave/f13usscientist
	gunsmith_three = TRUE
	gunsmith_four = TRUE
	id = /obj/item/card/id/gold
	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/f13/power_armor/advanced
	belt = /obj/item/storage/belt/military/assault
	head = /obj/item/clothing/head/helmet/f13/power_armor/advanced
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/sunglasses/big
	chemwhiz = TRUE
	suit_store = /obj/item/gun/energy/ionrifle/carbine
	backpack_contents = list(
		/obj/item/shield/energy=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/energy/laser/aer14=1, \
		/obj/item/gun/ballistic/automatic/pistol/n99=1, \
		/obj/item/stock_parts/cell/ammo/mfc=2, \
		/obj/item/ammo_box/magazine/m10mm_adv/simple=2, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super=2, \
		/obj/item/stock_parts/cell/ammo/ec=2, \
		/obj/item/healthanalyzer/advanced=1
		)


/*
Engineer
*/
/datum/job/enclave/f13usengineer
	title = "US Engineer"
	flag = F13USENGINEER
	department_flag = ENCLAVE
	//
	total_positions = 1
	spawn_positions = 1
	supervisors = "the commander"
	selection_color = "#ccccff"
	exp_type = EXP_TYPE_ENCLAVE
	display_order = JOB_DIS_PLAY_ORDER_US_ENGINEER
	outfit = /datum/outfit/job/enclave/f13usengineer

	access = list()
	minimal_access = list()

/datum/outfit/job/enclave/f13usengineer
	name = "US Engineer"
	jobtype = /datum/job/enclave/f13usengineer

	id = /obj/item/card/id/gold
	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/f13/power_armor/advanced
	belt = /obj/item/storage/belt/military/assault
	head = /obj/item/clothing/head/helmet/f13/power_armor/advanced
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/welding
	gloves = /obj/item/clothing/gloves/color/yellow
	chemwhiz = TRUE
	suit_store = /obj/item/gun/ballistic/shotgun/riot
	backpack_contents = list(
		/obj/item/shield/energy=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/energy/laser/aer14=1, \
		/obj/item/gun/ballistic/automatic/pistol/n99=1, \
		/obj/item/stock_parts/cell/ammo/mfc=2, \
		/obj/item/ammo_box/magazine/m10mm_adv/simple=2, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super=2, \
		/obj/item/stack/sheet/metal/fifty=1, \
		/obj/item/stack/sheet/glass/fifty=1, \
		/obj/item/storage/fancy/ammobox/lethalshot=3, \
		/obj/item/healthanalyzer/advanced=1
		)
