/*PARENT ITEMS FOR REFERENCE PURPOSES. DO NOT UNCOMMENT

/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	dynamic_hair_suffix = "+generic"
	var/datum/beepsky_fashion/beepsky_fashion //the associated datum for applying this to a secbot
	var/list/speechspan = null

/obj/item/clothing/head/Initialize()
	. = ..()
	if(ishuman(loc) && dynamic_hair_suffix)
		var/mob/living/carbon/human/H = loc
		H.update_hair()

/obj/item/clothing/head/get_head_speechspans(mob/living/carbon/user)
	if(speechspan)
		return speechspan
	else
		return

/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	item_state = "helmet"
	armor = list("tier" = 4, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	flags_inv = HIDEEARS
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = NONE
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

	dog_fashion = /datum/dog_fashion/head/helmet

/obj/item/clothing/head/helmet/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(SLOT_HEAD))*/

//Combat Armor FACTION SPECIFIC COMBAT ARMOR IN f13factionhead.dm

/obj/item/clothing/head/helmet/f13/combat
	name = "combat helmet"
	desc = "(V) An old military grade pre-war combat helmet."
	icon_state = "combat_helmet"
	item_state = "combat_helmet"
	armor = list("tier" = 5, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	strip_delay = 50
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/combat/dark
	color = "#302E2E" // Dark Grey

/obj/item/clothing/head/helmet/f13/combat/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/head/helmet/f13/combat/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/head/helmet/f13/combat/mk2
	name = "reinforced combat helmet"
	desc = "(VI) An advanced pre-war titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms."
	icon_state = "combat_helmet_mk2"
	item_state = "combat_helmet_mk2"
	armor = list("tier" = 6, "energy" = 45, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/head/helmet/f13/combat/mk2/dark
	name = "reinforced combat helmet"
	color = "#302E2E" // Dark Grey

/obj/item/clothing/head/helmet/f13/combat/mk2/raider
	name = "customized raider combat helmet"
	desc = "(VI) A reinforced combat helmet painted black with the laser designator removed."
	icon_state = "combat_helmet_raider"
	item_state = "combat_helmet_raider"

/obj/item/clothing/head/helmet/f13/combat/marine
	name = "marine combat helmet"
	desc = "(VIII) An excellent helmet of pre-war U.S.M.C. armor found in rare and limited quantities in the wasteland. Surpassed only by newer suits of power armor."
	icon_state = "marinehelmet"
	item_state = "marinehelmet"
	armor = list("tier" = 8, "energy" = 45, "bomb" = 55, "bio" = 60, "rad" = 60, "fire" = 60, "acid" = 50)

/obj/item/clothing/head/helmet/f13/rangerbroken
	name = "broken riot helmet"
	icon_state = "ranger_broken"
	desc = "(VII) An old riot police helmet, out of use around the time of the war."
	armor = list("tier" = 7, "energy" = 50, "bomb" = 39, "bio" = 20, "rad" = 20, "fire" = 30, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	flash_protect = 1

/obj/item/clothing/head/helmet/f13/rangerbroken/fox
	name = "broken reclaimed ranger-hunter helmet"
	desc = "(VII) A riot helmet once cared and loved by it's owner, now an old combat relic. A large entry and exit hole is on the top of the helmet, 'DE OPPRESSO LIBER' is also stenciled on the top of the helmet, along with what seems to be faded whiskers painted on the front."
	icon_state = "foxranger_broken"
	item_state = "foxranger_broken"

/obj/item/clothing/head/helmet/f13/combat/swat
	name = "SWAT combat helmet"
	desc = "A prewar combat helmet issued to S.W.A.T. personnel."
	icon_state = "swatsyndie"
	item_state = "swatsyndie"

/obj/item/clothing/head/helmet/f13/combat/environmental
	name = "environmental armor helmet"
	desc = "(V) A full head helmet and gas mask, developed for use in heavily contaminated environments."
	icon_state = "env_helmet"
	item_state = "env_helmet"
	armor = list("tier" = 5,"energy" = 45, "bomb" = 55, "bio" = 70, "rad" = 100, "fire" = 60, "acid" = 50)
	strip_delay = 60
	equip_delay_other = 60
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/helmet/f13/combat/environmental/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/rad_insulation, RAD_NO_INSULATION, TRUE, FALSE)

/obj/item/clothing/head/helmet/f13/ahp_helmet
	name = "highway patrol helmet"
	desc = "(V) An old police motorcycle helmet with the logo of the 'Arizona Department of Public Safety' emblazoned on the front."
	icon_state = "ahp_helmet"
	item_state = "ahp_helmet"
	armor = list("tier" = 4, "energy" = 25, "bomb" = 30, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 0)
	strip_delay = 40

/obj/item/clothing/head/helmet/f13/ahp_helmet/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Sulphite Helm

/obj/item/clothing/head/helmet/f13/sulphitehelm
	name = "Sulphite Helmet"
	desc = "(VI) A sulphite raider helmet, affixed with thick anti-ballistic glass over the eyes."
	icon_state = "sulphite_helm"
	item_state = "sulphite_helm"
	armor = list("tier" = 6, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

//Metal

/obj/item/clothing/head/helmet/knight/f13/metal
	name = "metal helmet"
	desc = "(III) An iron helmet forged by tribal warriors, with a unique design to protect the face from arrows and axes."
	icon_state = "metalhelmet"
	item_state = "metalhelmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	armor = list("tier" = 3, "energy" = 20, "bomb" = 16, "bio" = 0, "rad" = 0)

/obj/item/clothing/head/helmet/knight/f13/metal/reinforced
	name = "reinforced metal helmet"
	desc = "(IV) An iron helmet forged by tribal warriors, with a unique design to protect the face from arrows and axes."
	icon_state = "metalhelmet_r"
	item_state = "metalhelmet_r"
	armor = list("tier" = 4, "energy" = 25, "bomb" = 16, "bio" = 0, "rad" = 0)

/obj/item/clothing/head/helmet/knight/f13/rider
	name = "rider helmet" //Not raider. Rider.
	desc = "(III) It's a fancy dark metal helmet with orange spray painted flames."
	icon_state = "rider"
	item_state = "rider"

/obj/item/clothing/head/helmet/f13/metalmask
	name = "metal mask"
	desc = "(IV) A crudely formed metal hockey mask."
	icon_state = "metal_mask"
	item_state = "metal_mask"
	toggle_message = "You lower"
	alt_toggle_message = "You raise"
	can_toggle = 1
	armor = list("tier" = 4, "energy" = 40, "bomb" = 40, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEYES|HIDEFACE
	strip_delay = 80
	actions_types = list(/datum/action/item_action/toggle)
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE

/obj/item/clothing/head/helmet/f13/metalmask/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/head/helmet/f13/metalmask/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/head/helmet/f13/metalmask/mk2
	name = "reinforced metal mask"
	desc = "(V) A reinforced metal hockey mask."
	icon_state = "metal_mask2"
	item_state = "metal_mask2"
	armor = list("tier" = 5, "energy" = 50, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/helmet/f13/tesla
	name = "tesla helmet"
	desc = "(V) A prewar armor design by Nikola Tesla before being confiscated by the U.S. government. Provides high energy weapons resistance."
	icon_state = "tesla_helmet"
	item_state = "tesla_helmet"
	armor = list("tier" = 5, "energy" = 60, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	strip_delay = 10
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	var/hit_reflect_chance = 20
	var/list/protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/obj/item/clothing/head/helmet/f13/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

//Power Armor

/obj/item/clothing/head/helmet/f13/power_armor/
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	ispowerarmor = 1 //TRUE
	strip_delay = 200
	equip_delay_self = 20
	slowdown = 0.1
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEMASK|HIDEJUMPSUIT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	clothing_flags = THICKMATERIAL
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	item_flags = SLOWS_WHILE_IN_HAND
	flash_protect = 2
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	speechspan = SPAN_ROBOT //makes you sound like a robot
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
//	darkness_view = 128
//	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	var/on = FALSE
	var/brightness_on = 5
	var/power_on = 1
	var/emped = 0
	var/requires_training = TRUE
	var/armor_block_chance = 0
	var/list/protected_zones = list(BODY_ZONE_HEAD)
	var/deflection_chance = 0

/obj/item/clothing/head/helmet/f13/power_armor/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/f13/power_armor/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/helmet/f13/power_armor/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_icon()

/obj/item/clothing/head/helmet/f13/power_armor/proc/turn_on(mob/user)
	set_light(brightness_on, power_on)

/obj/item/clothing/head/helmet/f13/power_armor/proc/turn_off(mob/user)
	set_light(0)


/obj/item/clothing/head/helmet/f13/power_armor/mob_can_equip(mob/user, mob/equipper, slot, disable_warning = 1)
	var/mob/living/carbon/human/H = user
	if(src == H.head) //Suit is already equipped
		return ..()
	if (!HAS_TRAIT(H, TRAIT_PA_WEAR) && slot == SLOT_HEAD && requires_training)
		to_chat(user, "<span class='warning'>You don't have the proper training to operate the power armor!</span>")
		return 0
	if(slot == SLOT_HEAD)
		return ..()
	return

/obj/item/clothing/head/helmet/f13/power_armor/emp_act(mob/living/carbon/human/owner, severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(emped == 0)
		if(ismob(loc))
			to_chat(loc, "<span class='warning'>Warning: electromagnetic surge detected in helmet. Rerouting power to emergency systems.</span>")
			tint += 2
			if(istype(loc, /mob/living/carbon))
				var/mob/living/carbon/M = loc
				M.update_tint()
			armor = armor.modifyRating(linemelee = -50, linebullet = -50, linelaser = -50)
			emped = 1
			spawn(50) //5 seconds of being blind and weak
				to_chat(loc, "<span class='warning'>Helmet power reroute successful. All systems operational.</span>")
				tint -= 2
				if(istype(loc, /mob/living/carbon))
					var/mob/living/carbon/M = loc
					M.update_tint()
				armor = armor.modifyRating(linemelee = 50, linebullet = 50, linelaser = 50)
				emped = 0

/obj/item/clothing/head/helmet/f13/power_armor/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(check_armor_penetration(object) <= 0.15 && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(armor_block_chance))
			var/ratio = rand(0,100)
			if(ratio <= deflection_chance)
				block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
				return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
			if(ismob(loc))
				to_chat(loc, "<span class='warning'>Your power armor absorbs the projectile's impact!</span>")
			block_return[BLOCK_RETURN_SET_DAMAGE_TO] = 0
			return BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/head/helmet/f13/power_armor/t45b
	name = "salvaged T-45b helmet"
	desc = "(VIII) It's a salvaged T-45b power armor helmet."
	icon_state = "t45bhelmet"
	item_state = "t45bhelmet"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
//	darkness_view = 0
	armor_block_chance = 25
	deflection_chance = 10 //10% chance to block damage from blockable bullets and redirect the bullet at a random angle. Not nearly as effective as true power armor
	requires_training = FALSE

/obj/item/clothing/head/helmet/f13/power_armor/t45b/restored
	name = "restored T-45b helmet"
	desc = "(VIII) It's a restored T-45b power armor helmet."
	armor_block_chance = 80
	deflection_chance = 20 //20% chance to block damage from blockable bullets and redirect the bullet at a random angle
	requires_training = TRUE

/obj/item/clothing/head/helmet/f13/power_armor/raiderpa_helm
	name = "raider T-45b power helmet"
	desc = "(VIII) This power armor helmet is so decrepit and battle-worn that it have lost most of its capability to protect the wearer from harm. This helmet seems to be heavily modified, heavy metal banding fused to the helmet"
	icon_state = "raiderpa_helm"
	item_state = "raiderpa_helm"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	requires_training = FALSE
	armor_block_chance = 20
	deflection_chance = 5

/obj/item/clothing/head/helmet/f13/power_armor/hotrod
	name = "hotrod T-45b power helmet"
	desc = "(VIII) This power armor helmet is so decrepit and battle-worn that it have lost most of its capability to protect the wearer from harm."
	icon_state = "t45hotrod_helm"
	item_state = "t45hotrod_helm"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	requires_training = FALSE
	armor_block_chance = 20
	deflection_chance = 5 //5% chance to block damage from blockable bullets and redirect the bullet at a random angle. Stripped down version of an already stripped down version

/obj/item/clothing/head/helmet/f13/power_armor/vaulttec
	name = "Vault-Tec power helmet"
	desc = "(VIII) A refined suit of power armour, purpose-built by the residents of Vault-115 in order to better keep the peace in their new settlement."
	icon_state = "vaultpahelm"
	item_state = "vaultpahelm"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	armor_block_chance = 40
	deflection_chance = 10 //10% chance to block damage from blockable bullets and redirect the bullet at a random angle. Not a heavy combat model

/obj/item/clothing/head/helmet/f13/power_armor/vaulttecta
	name = "Vault-Tec power helmet"
	desc = "(VIII) A refined suit of power armour, purpose-built by the residents of Vault-115 in order to better keep the peace in their new settlement."
	icon_state = "vaulttahelm"
	item_state = "vaulttahelm"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	slowdown = 0.1

/obj/item/clothing/head/helmet/f13/power_armor/t45d
	name = "T-45d power helmet"
	desc = "(VIII) It's an old pre-War power armor helmet. It's pretty hot inside of it."
	icon_state = "t45dhelmet0"
	item_state = "t45dhelmet0"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor = list("tier" = 8, "energy" = 60, "bomb" = 62, "bio" = 100, "rad" = 90, "fire" = 90, "acid" = 0, "wound" = 60)
	armor_block_chance = 80
	deflection_chance = 20 //20% chance to block damage from blockable bullets and redirect the bullet at a random angle

/obj/item/clothing/head/helmet/f13/power_armor/t45d/update_icon_state()
	icon_state = "t45dhelmet[on]"
	item_state = "t45dhelmet[on]"

/obj/item/clothing/head/helmet/f13/power_armor/t45d/gunslinger
	name = "Gunslinger T-51b Helm"
	desc = "(IX) With most of the external plating stripped to allow for internal thermal and night vision scanners, as well as aided targeting assist via onboard systems, this helm provides much more utility then protection. To support these systems, secondary power cells were installed into the helm, and covered with a stylish hat."
	icon_state = "t51bgs"
	item_state = "t51bgs"
	slowdown = 0
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	actions_types = list()

/obj/item/clothing/head/helmet/f13/power_armor/t45d/sierra
	name = "sierra power helmet"
	desc = "(IX) A pre-war power armor helmet, issued to special NCR officers.."
	icon_state = "sierra"
	item_state = "sierra"
	actions_types = list()

/obj/item/clothing/head/helmet/f13/power_armor/midwest
	name = "midwestern power helmet"
	desc = "(IX) This helmet once belonged to the Midwestern branch of the Brotherhood of Steel, and now resides here."
	icon_state = "midwestgrey_helm"
	item_state = "midwestgrey_helm"
	armor = list("tier" = 9, "energy" = 60, "bomb" = 62, "bio" = 100, "rad" = 90, "fire" = 90, "acid" = 0, "wound" = 60)
	armor_block_chance = 80
	deflection_chance = 20 //20% chance to block damage from blockable bullets and redirect the bullet at a random angle

/obj/item/clothing/head/helmet/f13/power_armor/t51b
	name = "T-51b power helmet"
	desc = "(IX) It's a T-51b power helmet, typically used by the Brotherhood. It looks somewhat charming."
	icon_state = "t51bhelmet0"
	item_state = "t51bhelmet0"
	armor = list("tier" = 9, "energy" = 65, "bomb" = 62, "bio" = 100, "rad" = 99, "fire" = 90, "acid" = 0, "wound" = 70)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor_block_chance = 85
	deflection_chance = 35 //35% chance to block damage from blockable bullets and redirect the bullet at a random angle. Less overall armor compared to T-60, but higher deflection.

/obj/item/clothing/head/helmet/f13/power_armor/t51b/update_icon_state()
	icon_state = "t51bhelmet[on]"
	item_state = "t51bhelmet[on]"

/obj/item/clothing/head/helmet/f13/power_armor/t51b/wbos
	name = "Washington power helmet"
	desc = "(X) It's a Washington Brotherhood power helmet. It looks somewhat terrifying."
	icon_state = "t51wboshelmet"
	item_state = "t51wboshelmet"
	actions_types = list()

/obj/item/clothing/head/helmet/f13/power_armor/t51b/reforgedwbos
	name = "reforged Washington power helmet"
	desc = "(X) It's a reforged Washington Brotherhood power helmet, designed to induce fear in a target."
	icon_state = "t51matthelmet"
	item_state = "t51matthelmet"
	actions_types = list()

/obj/item/clothing/head/helmet/f13/power_armor/t51b/ultra
	name = "Ultracite power helmet"
	desc = "(X) It's a T-51b power helmet, typically used by the Brotherhood. It looks somewhat charming. Now enhanced with ultracite."
	icon_state = "ultracitepa_helm"
	item_state = "ultracitepa_helm"
	slowdown = 0
	actions_types = list()

/obj/item/clothing/head/helmet/f13/power_armor/t60
	name = "T-60a power helmet"
	desc = "(X) The T-60 powered helmet, equipped with targetting software suite, Friend-or-Foe identifiers, dynamic HuD, and an internal music player."
	icon_state = "t60helmet0"
	item_state = "t60helmet0"
	armor = list("tier" = 10, "energy" = 70, "bomb" = 82, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 0, "wound" = 80)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor_block_chance = 90
	deflection_chance = 20 //20% chance to block damage from blockable bullets and redirect the bullet at a random angle. Same deflection as T-45 due to it having the same general shape.

/obj/item/clothing/head/helmet/f13/power_armor/t60/update_icon_state()
	icon_state = "t60helmet[on]"
	item_state = "t60helmet[on]"

/obj/item/clothing/head/helmet/f13/power_armor/excavator
	name = "excavator power helmet"
	desc = "(VIII) The helmet of the excavator power armor suit."
	icon_state = "excavator"
	item_state = "excavator"
	armor = list("tier" = 8, "energy" = 60, "bomb" = 62, "bio" = 100, "rad" = 90, "fire" = 90, "acid" = 0)
	armor_block_chance = 40
	deflection_chance = 10 //10% chance to block damage from blockable bullets and redirect the bullet at a random angle. Not a heavy combat model

/obj/item/clothing/head/helmet/f13/power_armor/advanced
	name = "advanced power helmet"
	desc = "It's an advanced power armor Mk I helmet, typically used by the Enclave. It looks somewhat threatening."
	icon_state = "advhelmet1"
	item_state = "advhelmet1"
	armor = list("linemelee" = 300, "linebullet" = 300, "linelaser" = 300, "energy" = 75, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 90)
	armor_block_chance = 100 //Enclave. 'nuff said
	deflection_chance = 40 //40% chance to block damage from blockable bullets and redirect the bullet at a random angle. Your ride's over mutie, time to die.

/obj/item/clothing/head/helmet/f13/power_armor/advanced/mk2
	name = "advanced power helmet MK2"
	desc = "It's an improved model of advanced power armor used exclusively by the Enclave military forces, developed after the Great War.<br>Like its older brother, the standard advanced power armor, it's matte black with a menacing appearance, but with a few significant differences - it appears to be composed entirely of lightweight ceramic composites rather than the usual combination of metal and ceramic plates.<br>Additionally, like the T-51b power armor, it includes a recycling system that can convert human waste into drinkable water, and an air conditioning system for its user's comfort."
	icon_state = "advhelmet2"
	item_state = "advhelmet2"
	armor = list("linemelee" = 400, "linebullet" = 400, "linelaser" = 400, "energy" = 90, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 100)

/obj/item/clothing/head/helmet/f13/power_armor/advanced/mk2/wbos
	name = "advanced Washington power helmet"
	desc = "It's an improved model of the power armor helmet used exclusively by the Washington Brotherhood, designed to induce fear in a target."
	icon_state = "t51wboshelmet"
	item_state = "t51wboshelmet"

/obj/item/clothing/head/helmet/f13/power_armor/tesla
	name = "tesla power helmet"
	desc = "A helmet typically used by Enclave special forces.<br>There are three orange energy capacitors on the side."
	icon_state = "tesla"
	item_state = "tesla"
	armor = list("linemelee" = 200, "linebullet" = 200, "linelaser" = 300, "energy" = 95, "bomb" = 62, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 80)
	var/hit_reflect_chance = 35

/obj/item/clothing/head/helmet/f13/power_armor/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

//Generic Tribal - For Wayfarer specific, see f13factionhead.dm

/obj/item/clothing/head/helmet/f13/tribal
	name = "tribal power helmet"
	desc = "(IV) This power armor helmet was salvaged by savages from the battlefield.<br>They believe that these helmets capture the spirits of their fallen wearers, so they painted some runes on to give it a more sacred meaning."
	icon_state = "tribal"
	item_state = "tribal"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("tier" = 4, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 10, "fire" = 0, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	strip_delay = 30
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/f13
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/rastacap
	name = "rastacap"
	desc = "(I) <font color='#157206'>Him haffi drop him fork and run,</font><br><font color='green'>Him can't stand up to Jah Jah son,</font><br><font color='#fd680e'>Him haffi lef' ya with him gun,</font><br><font color='red'>Dig off with him bomb.</font>"
	icon_state = "rastacap"
	item_state = "fedora"
	cold_protection = HEAD //This tam brings the warm reggae and Jamaican sun with it.
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/f13/hairband
	name = "hairband"
	desc = "Pretty yellow hairband"
	icon_state = "50shairband"
	item_state = "50shairband"

/obj/item/clothing/head/f13/nursehat
	name = "nursehat"
	desc = "White cloth headdress for nurses"
	icon_state = "nursehat"
	item_state = "nursehat"

/obj/item/clothing/head/f13/beaver
	name = "beaverkin"
	desc = "(I) A hat made from felted beaver fur which makes the wearer feel both comfortable and elegant."
	icon_state = "beaver"
	item_state = "that"

/obj/item/clothing/head/f13/purple
	name = "purple top hat"
	desc = "(I) You may not own the best jail in the observed Universe, or the best chocolate factory in the entire world, but at least you can try to have that purple top hat."
	icon_state = "ptophat"
	item_state = "that"

/obj/item/clothing/head/f13/trilby
	name = "feather trilby"
	desc = "(I) A sharp, stylish blue hat with a feather."
	icon_state = "trilby"
	item_state = "fedora"

/obj/item/clothing/head/f13/chinese_soldier
	name = "chinese side cap"
	desc = "(I) A foldable military cap with straight sides, with insignia of People's Liberation Army, that was supposedly worn by regular troops."
	icon_state = "chinese_s"
	item_state = "secsoft"

/obj/item/clothing/head/f13/chinese_officer
	name = "chinese officer cap"
	desc = "(I) A foldable military cap with straight sides, with insignia of People's Liberation Army, that was supposedly worn by low rank officers."
	icon_state = "chinese_o"
	item_state = "secsoft"

/obj/item/clothing/head/f13/chinese_commander
	name = "chinese peaked cap"
	desc = "(I) A peaked cap of dark green in color with a red star on the frontside.<br>It obviously belonged to a high rank officer of People's Liberation Army."
	icon_state = "chinese_c"
	item_state = "fedora"

/obj/item/clothing/head/f13/stormchaser
	name = "stormchaser hat"
	desc = "(I) Home, home on the wastes,<br>Where the mole rat and the fire gecko play.<br>Where seldom is heard a discouraging word,<br>And my skin is not glowing all day."
	icon_state = "stormchaser"
	item_state = "fedora"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/f13/headscarf
	name = "headscarf"
	desc = "(I) A piece of cloth worn on head for a variety of purposes, such as protection of the head or hair from rain, wind, dirt, cold, warmth, for sanitation, for fashion, recognition or social distinction - with religious significance, to hide baldness, out of modesty, or other forms of social convention."
	icon_state = "headscarf"
	item_state = "dethat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/f13/headscarf/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/pot
	name = "metal cooking pot"
	desc = "(III) Step one: Start with the sauce.<br>Step two: Add the noodles.<br>Step three: Stir the pasta.<br>Step four: Turn up the heat.<br>Step five: Burn the house."
	icon_state = "pot"
	item_state = "fedora"
	force = 20
	hitsound = 'sound/items/trayhit1.ogg'
	flags_inv = HIDEHAIR
	armor = list("tier" = 3)

/obj/item/clothing/head/f13/cowboy
	name = "cowboy hat"
	desc = "(II) A high-crowned, wide-brimmed hat best known as the defining piece of attire for the North American cowboy."
	icon_state = "cowboy"
	item_state = "dethat"
	flags_inv = HIDEHAIR
	armor = list("tier" = 2)

/obj/item/clothing/head/f13/bandit
	name = "bandit hat"
	desc = "(I) A black cowboy hat with a large brim that's curved to the sides.<br>A silver eagle pin is attached to the front."
	icon_state = "bandit"
	item_state = "fedora"
	flags_inv = HIDEHAIR
	armor = list("tier" = 2)

/obj/item/clothing/head/f13/gambler
	name = "gambler hat"
	desc = "(I) A perfect hat for a ramblin' gamblin' man." //But I got to ramble (ramblin' man) //Oh I got to gamble (gamblin' man) //Got to got to ramble (ramblin' man) //I was born a ramblin' gamblin' man
	icon_state = "gambler"
	item_state = "dethat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/helmet/f13/motorcycle
	name = "motorcycle helmet"
	desc = "(II) A type of helmet used by motorcycle riders.<br>The primary goal of a motorcycle helmet is motorcycle safety - to protect the rider's head during impact, thus preventing or reducing head injury and saving the rider's life."
	icon_state = "motorcycle"
	item_state = "motorcycle"
	flags_cover = HEADCOVERSEYES
	armor = list("tier" = 2, "linemelee" = 30, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEHAIR
	strip_delay = 10

/obj/item/clothing/head/helmet/f13/firefighter
	name = "firefighter helmet"
	desc = "(III) A firefighter's helmet worn on top of a fire-retardant covering and broken gas mask.<br>It smells heavily of sweat."
	icon_state = "firefighter"
	item_state = "firefighter"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("tier" = 3, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 30
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/f13/vaquerohat
	name = "vaquero hat"
	desc = "(III) An old sombrero worn by Vaqueros to keep off the harsh sun."
	icon_state = "vaquerohat"
	item_state = "vaquerohat"
	armor = list("tier" = 3, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/hoodedmask
	name = "hooded mask"
	desc = "(III) A gask mask with the addition of a hood."
	icon_state = "Hooded_Gas_Mask"
	item_state = "Hooded_Gas_Mask"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 70, "bio" = 70, "rad" = 70, "fire" = 65, "acid" = 30)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/brahmincowboyhat
	name = "brahmin leather cowboy hat"
	desc = "(II) A cowboy hat made from brahmin hides."
	icon_state = "brahmin_leather_cowboy_hat"
	item_state = "brahmin_leather_cowboy_hat"
	armor = list("tier" = 2, "energy" = 15, "bomb" = 70, "bio" = 70, "rad" = 70, "fire" = 70, "acid" = 15)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/rustedcowboyhat
	name = "Rusted Cowboy Hat"
	desc = "(II) A cowboy hat made from tanned leather hides."
	icon_state = "rusted_cowboy"
	item_state = "rusted_cowboy"
	armor = list("tier" = 2, "energy" = 15, "bomb" = 70, "bio" = 70, "rad" = 70, "fire" = 70, "acid" = 15)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/f13/police
	name = "pre-War police hat"
	desc = "(I) It's the police hat of dark blue in color with a silver colored badge on the frontside.<br>The badge is inscripted with the words SPECIAL and POLICE."
	icon_state = "retropolice"
	item_state = "fedora"
	armor = list("tier" = 1, "energy" = 0, "bomb" = 25, "bio" = 0, "rad" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/simplekitty
	name = "Kitty Headband"
	desc = "A headband with a pair of cute kitty ears"
	icon_state = "kittyb"
	color = "#999999"
	armor = list("tier" = 0)

//Soft caps
/obj/item/clothing/head/soft/f13
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/soft/f13/baseball
	name = "baseball cap"
	desc = "(I) A type of soft cap with a rounded crown and a stiff peak projecting out the front."
	icon_state = "baseball"
	item_color = "baseball"

/obj/item/clothing/head/soft/f13/utility
	name = "grey utility cover"
	desc = "(I) An eight-pointed hat, with a visor similar to a baseball cap, known as utility cover, also called the utility cap or eight-pointed cover."
	icon_state = "utility_g"
	item_color = "utility_g"

/obj/item/clothing/head/soft/f13/utility/navy
	name = "navy utility cover"
	icon_state = "utility_n"
	item_color = "utility_n"

/obj/item/clothing/head/soft/f13/utility/olive
	name = "olive utility cover"
	icon_state = "utility_o"
	item_color = "utility_o"

/obj/item/clothing/head/soft/f13/utility/tan
	name = "tan utility cover"
	icon_state = "utility_t"
	item_color = "utility_t"


//DONOR, PATREON AND CUSTOM

/obj/item/clothing/head/donor/macarthur
	name = "Peaked Cap"
	desc = "(II) A resistant, tan peaked cap, typically worn by pre-War Generals."
	icon_state = "macarthur"
	item_state = "macarthur"
	armor = list("tier" = 2, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 20)

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/rigscustom
	name = "11th armored calvary helmet"
	desc = "An advanced combat helmet used by the 11th Armored Calvary Regiment before the war. There is a worn and faded 11th Armored Calvary Regiment's insignia just above the visor. The helmet itself has some scratches and dents sustained from battle."
	icon_state = "rigscustom_helmet"
	item_state = "rigscustom_helmet"
	icon = 'icons/fallout/clothing/hats.dmi'

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/pricecustom
	name = "spider riot helmet"
	desc = "A customised riot helmet reminiscient of the more advanced riot helmets found in the Divide, sporting purple lenses over the traditional red or green and a pair of red fangs painted over the respirator. The back of the helmet has a the face of an albino spider painted over it."
	icon_state = "price_ranger"
	item_state = "price_ranger"

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/foxcustom
	name = "reclaimed ranger-hunter combat helmet"
	desc = "A reclaimed Ranger-Hunter centurion helmet, carefully and lovingly restored to working condition with a sniper's veil wrapped around the neck. 'DE OPPRESSO LIBER' is also stenciled on the top of the helmet, along with what seems to be faded whiskers painted on the front."
	icon_state = "foxranger"
	item_state = "foxranger"
	actions_types = list(/datum/action/item_action/toggle)
	toggle_message = "You take the sniper's veil off."
	alt_toggle_message = "You put the sniper's veil on."
	can_toggle = 1
	toggle_cooldown = 0

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/mosshelmet
	name = "veteran patrol stetson"
	desc = "A weathered campaign hat tightly fitted over the viscera of a ranger combat helmet. The old stetson is faded with age and heavy use, having seen the green shores of California to the white peaks of the rockies."
	icon_state = "mosshelmet"
	item_state = "mosshelmet"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/helmet/f13/power_armor/midwest/hardened
	name = "hardened midwestern power helmet"
	desc = "This helmet once belonged to the Midwestern branch of the Brotherhood of Steel, and now resides here. This particular one has gone through a chemical hardening process, increasing its armor capabilities."
	icon_state = "midwestpa_helm"
	item_state = "midwestpa_helm"

/obj/item/clothing/head/helmet/f13/jasonmask
	name = "jasons mask"
	desc = "(II) A metal mask made specifically for jason."
	icon_state = "jasonmask"
	item_state = "jasonmask"
	armor = list("tier" = 2, "energy" = 20, "bomb" = 70, "bio" = 70, "rad" = 70, "fire" = 65, "acid" = 30)

/obj/item/clothing/head/welding/f13/fire
	name = "cremator welding helmet"
	desc = "(III) A welding helmet with flames painted on it.<br>It sure is creepy but also badass."
	icon_state = "welding_fire"
	item_state = "welding"
	tint = 1
	armor = list("tier" = 3, "energy" = 5, "bomb" = 5, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)

/obj/item/clothing/head/helmet/f13/atombeliever
	name = "believer headdress"
	desc = "(II) The headwear of the true faith."
	icon_state = "atombeliever"
	item_state = "atombeliever"
	armor = list("tier" = 2, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 100, "fire" = 60, "acid" = 20)
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/f13/flatranger
	name = "NCR gambler ranger hat"
	desc = "(IV) A rustic, homely style gambler hat adorning an NCR Ranger patch. Yeehaw!"
	icon_state = "gamblerrang"
	item_state = "gamblerrang"
	armor = list("tier" = 4, "energy" = 30, "bomb" = 25, "bio" = 40, "rad" = 40, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/venator/diohelmet
	name = "galerum lacertarex"
	desc = "(VI) The hide of a deadly green gecko affixed over a reinforced legion helmet. Its ghastly appearance serves as an intimidating gesture to those who do not yet fear the Lizard King."
	icon_state = "diohelmet"
	item_state = "diohelmet"
	armor = list("tier" = 6, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/herbertranger
	name = "weathered desert ranger helmet"
	icon_state = "modified_usmc_riot"
	item_state = "modified_usmc_riot"
	desc = "(IV) An ancient USMC riot helmet. This paticular piece retains the classic colouration of the legendary Desert Rangers, and looks as if it has been worn for decades; its night vision no longer seems to be functional. Scratched into the helmet is the sentence: 'Death to the Devils that simulate our freedom.'"
	armor = list("tier" = 4, "energy" = 25, "bomb" = 30, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/marlowhat
	name = "boss of the plains hat"
	desc = "(IV) A thick undyed felt cowboy hat, bleached from excessive sun exposure and creased from heavy usage."
	icon_state = "marlowhat"
	item_state = "marlowhat"
	armor = list("tier" = 4, "energy" = 25, "bomb" = 30, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/marlowhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/bride_veil
	name = "bridal veil"
	desc = "(I) A thin, white bridal veil. It seems to have been hand-made using remarkably well preserved and delicate pre-war fabric."
	icon_state = "bride_veil"
	item_state = "bride_veil"
	armor = list("tier" = 1, "energy" = 0, "bomb" = 25, "bio" = 0, "rad" = 0)
	alt_toggle_message = "You push the veil down "
	can_toggle = 1
	flags_inv = HIDEEARS
	actions_types = list(/datum/action/item_action/toggle)
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES
	visor_flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/helmet/f13/bride_veil/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "[up ? alt_toggle_message : toggle_message] \the [src]")

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(15)
