
#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.4

/obj/item/gun
	name = "gun"
	desc = "It's a gun. It's pretty terrible, though."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "detective"
	item_state = "gun"
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=2000)
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	force = 5
	item_flags = NEEDS_PERMIT
	attack_verb = list("struck", "hit", "bashed")
	var/ranged_attack_speed = CLICK_CD_RANGE

	var/fire_sound = "gunshot"
	var/recoil = 0						//boom boom shake the room
	var/clumsy_check = TRUE
	var/obj/item/ammo_casing/chambered = null
	trigger_guard = TRIGGER_GUARD_NORMAL	//trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	var/sawn_desc = null				//description change if weapon is sawn-off
	var/sawn_off = FALSE

	/// can we be put into a turret
	var/can_turret = TRUE
	/// can we be put in a circuit
	var/can_circuit = TRUE
	/// can we be put in an emitter
	var/can_emitter = TRUE

	/// Weapon is burst fire if this is above 1
	var/burst_size = 1
	/// The time between shots in burst.
	var/burst_shot_delay = 3
	/// The time between firing actions, this means between bursts if this is burst weapon. The reason this is 0 is because you are still, by default, limited by clickdelay.
	var/fire_delay = 0
	/// Last world.time this was fired
	var/last_fire = 0
	/// Currently firing, whether or not it's a burst or not.
	var/firing = FALSE
	/// Used in gun-in-mouth execution/suicide and similar, while TRUE nothing should work on this like firing or modification and so on and so forth.
	var/busy_action = FALSE
	var/weapon_weight = WEAPON_LIGHT	//used for inaccuracy and wielding requirements/penalties
	var/spread = 0						//Spread induced by the gun itself.
	var/burst_spread = 0				//Spread induced by the gun itself during burst fire per iteration. Only checked if spread is 0.
	var/randomspread = 1				//Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.
	var/inaccuracy_modifier = 1

	var/obj/item/attachments/scope
	var/obj/item/attachments/recoil_decrease
	var/obj/item/attachments/burst_improvement
	var/obj/item/attachments/auto_sear
	var/obj/item/attachments/bullet_speed

	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

	var/obj/item/firing_pin/pin = /obj/item/firing_pin //standard firing pin for most guns
	var/no_pin_required = FALSE //whether the gun can be fired without a pin

	var/obj/item/flashlight/gun_light
	var/can_flashlight = FALSE
	var/gunlight_state = "flight"

	var/obj/item/kitchen/knife/bayonet
	var/mutable_appearance/knife_overlay
	var/can_bayonet = FALSE
	var/bayonet_state = "bayonet"

	var/mutable_appearance/scope_overlay
	var/can_scope = FALSE
	var/scope_state = "scope"

	var/datum/action/item_action/toggle_gunlight/alight
	var/mutable_appearance/flashlight_overlay
	var/can_attachments = FALSE
	var/can_automatic = FALSE

	var/mutable_appearance/suppressor_overlay
	var/suppressor_state = null
	var/suppressed = null					//whether or not a message is displayed when fired
	var/can_suppress = FALSE
	var/can_unsuppress = TRUE

	var/ammo_x_offset = 0 //used for positioning ammo count overlay on sprite
	var/ammo_y_offset = 0
	var/flight_x_offset = 0
	var/flight_y_offset = 0
	var/knife_x_offset = 0
	var/knife_y_offset = 0
	var/scope_x_offset = 0
	var/scope_y_offset = 0
	var/suppressor_x_offset = 0
	var/suppressor_y_offset = 0

	var/equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'
	var/isenergy = null
	var/isbow = null
	var/extra_damage = 0				//Number to add to individual bullets.
	var/extra_penetration = 0			//Number to add to armor penetration of individual bullets.
	var/extra_speed = TILES_TO_PIXELS(0) //Additional speed to the projectile.

	//Zooming
	var/zoomable = FALSE //whether the gun generates a Zoom action on creation
	var/zoomed = FALSE //Zoom toggle
	var/zoom_amt = 3 //Distance in TURFs to move the user's screen forward (the "zoom" effect)
	var/zoom_out_amt = 0
	var/datum/action/item_action/toggle_scope_zoom/azoom

	var/dualwield_spread_mult = 1		//dualwield spread multiplier

	//var/tinkered = 0
	/// Just 'slightly' snowflakey way to modify projectile damage for projectiles fired from this gun.
//	var/projectile_damage_multiplier = 1

/*
	var/automatic = 0 //can gun use it, 0 is no, anything above 0 is the delay between clicks in ds
*/ //Disabled because automatic fire is buggy and a bit OP.

/obj/item/gun/Initialize()
	. = ..()
	if(no_pin_required)
		pin = null
	else if(pin)
		pin = new pin(src)
	if(gun_light)
		alight = new (src)
	build_zooming()

/obj/item/gun/Destroy()
	if(pin)
		QDEL_NULL(pin)
	if(gun_light)
		QDEL_NULL(gun_light)
	if(bayonet)
		QDEL_NULL(bayonet)
	if(chambered)
		QDEL_NULL(chambered)
	return ..()

/obj/item/gun/CheckParts(list/parts_list)
	..()
	var/obj/item/gun/G = locate(/obj/item/gun) in contents
	if(G)
		G.forceMove(loc)
		QDEL_NULL(G.pin)
		visible_message("[G] can now fit a new pin, but the old one was destroyed in the process.", null, null, 3)
		qdel(src)

/obj/item/gun/examine(mob/user)
	. = ..()
	if(no_pin_required)
		return
	if(pin)
		. += "It has \a [pin] installed."
	else
		. += "It doesn't have a firing pin installed, and won't fire."

//called after the gun has successfully fired its chambered ammo.
/obj/item/gun/proc/process_chamber(mob/living/user)
	return FALSE

//check if there's enough ammo/energy/whatever to shoot one time
//i.e if clicking would make it shoot
/obj/item/gun/proc/can_shoot()
	return TRUE

/obj/item/gun/proc/shoot_with_empty_chamber(mob/living/user as mob|obj)
	if (isenergy == TRUE)
		to_chat(user, "<span class='danger'>*power failure*</span>")
		playsound(src, 'sound/f13weapons/noammoenergy.ogg', 30, 1)
		return
	if (isbow == TRUE)
		to_chat(user, "<span class='danger'>*no arrows*</span>") //Insert cool plink plink sound here
		return
	to_chat(user, "<span class='danger'>*click*</span>")
	playsound(src, "gun_dry_fire", 30, 1)

/obj/item/gun/proc/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	if(recoil)
		shake_camera(user, recoil + 1, recoil)

	if(stam_cost) //CIT CHANGE - makes gun recoil cause staminaloss
		var/safe_cost = clamp(stam_cost, 0, STAMINA_NEAR_CRIT - user.getStaminaLoss())*(firing && burst_size >= 2 ? 1/burst_size : 1)
		user.adjustStaminaLossBuffered(safe_cost) //CIT CHANGE - ditto

	if(suppressed)
		playsound(user, fire_sound, 10, 1)
	else
		playsound(user, fire_sound, 50, 1)
		if(message)
			if(pointblank)
				user.visible_message("<span class='danger'>[user] fires [src] point blank at [pbtarget]!</span>", null, null, COMBAT_MESSAGE_RANGE)
			else
				user.visible_message("<span class='danger'>[user] fires [src]!</span>", null, null, COMBAT_MESSAGE_RANGE)

//Adds logging to the attack log whenever anyone draws a gun, adds a pause after drawing a gun before you can do anything based on it's size
/obj/item/gun/pickup(mob/living/user)
	. = ..()
	weapondraw(src, user)

/obj/item/gun/pickup(mob/living/user)
	. = ..()
	play_equip_sound(src)

/obj/item/gun/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		for(var/obj/O in contents)
			O.emp_act(severity)

/obj/item/gun/attack(mob/living/M, mob/user)
	. = ..()
	if(bayonet && user.a_intent == INTENT_HARM)
		M.attackby(bayonet, user) // handles cooldown
		return
	if(!(. & DISCARD_LAST_ACTION))
		user.DelayNextAction(attack_speed)

/obj/item/gun/attack_obj(obj/O, mob/user)
	. = ..()
	if(bayonet && user.a_intent == INTENT_HARM)
		O.attackby(bayonet, user) // handles cooldown
		return
	if(!(. & DISCARD_LAST_ACTION))
		user.DelayNextAction(attack_speed)

/obj/item/gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if(!CheckAttackCooldown(user, target, TRUE))
		return
	process_afterattack(target, user, flag, params)

/obj/item/gun/proc/process_afterattack(atom/target, mob/living/user, flag, params)
	if(!target)
		return
	if(firing)
		return
	var/stamloss = user.getStaminaLoss()
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.a_intent == INTENT_HARM) //melee attack
			return
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH && (user.a_intent != INTENT_DISARM)) //so we can't shoot ourselves (unless mouth selected or disarm intent)
			return
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			for(var/i in C.all_wounds)
				var/datum/wound/W = i
				if(W.try_treating(src, user))
					return // another coward cured!

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	if(flag)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			handle_suicide(user, target, params)
			return

	//Exclude lasertag guns from the TRAIT_CLUMSY check.
	if(clumsy_check)
		if(istype(user))
			if (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
				to_chat(user, "<span class='userdanger'>You shoot yourself in the foot with [src]!</span>")
				var/shot_leg = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
				process_fire(user, user, FALSE, params, shot_leg)
				user.dropItemToGround(src, TRUE)
				return

	if(weapon_weight == WEAPON_HEAVY && user.get_inactive_held_item())
		to_chat(user, "<span class='userdanger'>You need both hands free to fire \the [src]!</span>")
		return

	user.DelayNextAction(ranged_attack_speed)

	//DUAL (or more!) WIELDING
	var/bonus_spread = 0
	var/loop_counter = 0

	if(user)
		bonus_spread = getinaccuracy(user, bonus_spread, stamloss) //CIT CHANGE - adds bonus spread while not aiming
	if(ishuman(user) && user.a_intent == INTENT_HARM && weapon_weight <= WEAPON_LIGHT)
		var/mob/living/carbon/human/H = user
		for(var/obj/item/gun/G in H.held_items)
			if(G == src || G.weapon_weight >= WEAPON_MEDIUM)
				continue
			else if(G.can_trigger_gun(user))
				bonus_spread += 24 * G.weapon_weight * G.dualwield_spread_mult
				loop_counter++
				var/stam_cost = G.getstamcost(user)
				addtimer(CALLBACK(G, /obj/item/gun.proc/process_fire, target, user, TRUE, params, null, bonus_spread, stam_cost), loop_counter)

	var/stam_cost = getstamcost(user)
	process_fire(target, user, TRUE, params, null, bonus_spread, stam_cost)

/obj/item/gun/can_trigger_gun(mob/living/user)
	. = ..()
	if(!.)
		return
	if(!handle_pins(user))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && chambered?.harmful) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
		to_chat(user, "<span class='notice'> [src] is lethally chambered! You don't want to risk harming anyone...</span>")
		return FALSE

/obj/item/gun/CheckAttackCooldown(mob/user, atom/target)
	if((user.a_intent == INTENT_HARM) && user.Adjacent(target))		//melee
		return user.CheckActionCooldown(CLICK_CD_MELEE)
	return user.CheckActionCooldown(get_clickcd())

/obj/item/gun/proc/get_clickcd()
	return isnull(chambered?.click_cooldown_override)? CLICK_CD_RANGE : chambered.click_cooldown_override

/obj/item/gun/GetEstimatedAttackSpeed()
	return get_clickcd()

/obj/item/gun/proc/handle_pins(mob/living/user)
	if(no_pin_required)
		return TRUE
	if(pin)
		if(pin.pin_auth(user) || (pin.obj_flags & EMAGGED))
			return TRUE
		else
			pin.auth_fail(user)
			return FALSE
	else
		to_chat(user, "<span class='warning'>[src]'s trigger is locked. This weapon doesn't have a firing pin installed!</span>")
	return FALSE

/obj/item/gun/proc/recharge_newshot()
	return

/obj/item/gun/proc/on_cooldown()
	return busy_action || firing || ((last_fire + fire_delay) > world.time)

/obj/item/gun/proc/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	add_fingerprint(user)

	if(on_cooldown())
		return
	if(user.IsWeaponDrawDelayed())
		to_chat(user, "<span class='notice'>[src] is not yet ready to fire!</span>")
		return
	firing = TRUE
	. = do_fire(target, user, message, params, zone_override, bonus_spread, stam_cost)
	firing = FALSE
	last_fire = world.time

	if(user)
		user.update_inv_hands()
		SEND_SIGNAL(user, COMSIG_LIVING_GUN_PROCESS_FIRE, target, params, zone_override, bonus_spread, stam_cost)

/obj/item/gun/proc/do_fire(atom/target, mob/living/user, message = TRUE, params, zone_override = "", bonus_spread = 0, stam_cost = 0)
	var/sprd = 0
	var/randomized_gun_spread = 0
	var/rand_spr = rand()
	if(spread)
		randomized_gun_spread = rand(0, spread)
	else if(burst_size > 1 && burst_spread)
		randomized_gun_spread = rand(0, burst_spread)
	var/randomized_bonus_spread = rand(0, bonus_spread)

	if(burst_size > 1)
		do_burst_shot(user, target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, 1)
		for(var/i in 2 to burst_size)
			sleep(burst_shot_delay)
			if(QDELETED(src))
				break
			do_burst_shot(user, target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, i, stam_cost)
	else
		if(chambered)
			sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread))
			before_firing(target,user)
			if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, extra_damage, extra_penetration, src, extra_speed))
				shoot_with_empty_chamber(user)
				return
			else
				if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
					shoot_live_shot(user, 1, target, message, stam_cost)
				else
					shoot_live_shot(user, 0, target, message, stam_cost)
		else
			shoot_with_empty_chamber(user)
			return
		process_chamber(user)
		update_icon()

	SSblackbox.record_feedback("tally", "gun_fired", 1, type)
	return TRUE

/obj/item/gun/proc/do_burst_shot(mob/living/user, atom/target, message = TRUE, params=null, zone_override = "", sprd = 0, randomized_gun_spread = 0, randomized_bonus_spread = 0, rand_spr = 0, iteration = 0, stam_cost = 0)
	if(!user || !firing)
		firing = FALSE
		return FALSE
	if(!issilicon(user))
		if(iteration > 1 && !(user.is_holding(src))) //for burst firing
			firing = FALSE
			return FALSE
	if(chambered && chambered.BB)
		if(HAS_TRAIT(user, TRAIT_PACIFISM)) // If the user has the pacifist trait, then they won't be able to fire [src] if the round chambered inside of [src] is lethal.
			if(chambered.harmful) // Is the bullet chambered harmful?
				to_chat(user, "<span class='notice'> [src] is lethally chambered! You don't want to risk harming anyone...</span>")
				return
		if(randomspread)
			sprd = round((rand() - 0.5) * DUALWIELD_PENALTY_EXTRA_MULTIPLIER * (randomized_gun_spread + randomized_bonus_spread), 1)
		else //Smart spread
			sprd = round((((rand_spr/burst_size) * iteration) - (0.5 + (rand_spr * 0.25))) * (randomized_gun_spread + randomized_bonus_spread), 1)
		before_firing(target,user)
		if(!chambered.fire_casing(target, user, params, , suppressed, zone_override, sprd, extra_damage, extra_penetration, src, extra_speed))
			shoot_with_empty_chamber(user)
			firing = FALSE
			return FALSE
		else
			if(get_dist(user, target) <= 1) //Making sure whether the target is in vicinity for the pointblank shot
				shoot_live_shot(user, 1, target, message, stam_cost)
			else
				shoot_live_shot(user, 0, target, message, stam_cost)
			if (iteration >= burst_size)
				firing = FALSE
	else
		shoot_with_empty_chamber(user)
		firing = FALSE
		return FALSE
	process_chamber(user)
	update_icon()
	return TRUE

/obj/item/gun/attackby(obj/item/I, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()
	else if(istype(I, /obj/item/flashlight/seclite))
		if(!can_flashlight)
			return ..()
		var/obj/item/flashlight/seclite/S = I
		if(!gun_light)
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, "<span class='notice'>You click \the [S] into place on \the [src].</span>")
			if(S.on)
				set_light(0)
			gun_light = S
			update_gunlight(user)
			alight = new /datum/action/item_action/toggle_gunlight(src)
			if(loc == user)
				alight.Grant(user)
	else if(istype(I, /obj/item/kitchen/knife))
		var/obj/item/kitchen/knife/K = I
		if(!can_bayonet || !K.bayonet || bayonet) //ensure the gun has an attachment point available, and that the knife is compatible with it.
			return ..()
		if(!user.transferItemToLoc(I, src))
			return
		to_chat(user, "<span class='notice'>You attach \the [K] to the front of \the [src].</span>")
		bayonet = K
		update_icon()
		update_overlays()
	else if(istype(I, /obj/item/attachments/scope))
		if(!can_scope)
			return ..()
		var/obj/item/attachments/scope/C = I
		if(!scope)
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, "<span class='notice'>You attach \the [C] to the top of \the [src].</span>")
			scope = C
			src.zoomable = TRUE
			src.zoom_amt = 10
			src.zoom_out_amt = 13
			src.build_zooming()
			update_overlays()
			update_icon()
	else if(istype(I, /obj/item/attachments/recoil_decrease))
		var/obj/item/attachments/recoil_decrease/R = I
		if(!recoil_decrease && can_attachments)
			if(!user.transferItemToLoc(I, src))
				return
			recoil_decrease = R
			src.desc += " It has a recoil compensator installed."
			if (src.spread > 8)
				src.spread -= 8
			else
				src.spread = 0
			to_chat(user, "<span class='notice'>You attach \the [R] to \the [src].</span>")
	else if(istype(I, /obj/item/attachments/bullet_speed))
		var/obj/item/attachments/bullet_speed/B = I
		if(!bullet_speed && can_attachments)
			if(!user.transferItemToLoc(I, src))
				return
			bullet_speed = B
			src.desc += " It has an improved barrel installed."
			src.extra_speed += TILES_TO_PIXELS(15)
			to_chat(user, "<span class='notice'>You attach \the [B] to \the [src].</span>")
	else if(istype(I, /obj/item/attachments/burst_improvement))
		var/obj/item/attachments/burst_improvement/T = I
		if(!burst_improvement && burst_size > 1 && can_attachments)
			if(!user.transferItemToLoc(I, src))
				return
			burst_improvement = T
			src.desc += " It has a modified burst cam installed."
			src.burst_size += 1
			to_chat(user, "<span class='notice'>You attach \the [T] to \the [src].</span>")
			update_icon()
	else if(istype(I, /obj/item/screwdriver))
		if(gun_light)
			var/obj/item/flashlight/seclite/S = gun_light
			to_chat(user, "<span class='notice'>You unscrew the seclite from \the [src].</span>")
			gun_light = null
			S.forceMove(get_turf(user))
			update_gunlight(user)
			S.update_brightness(user)
			QDEL_NULL(alight)
		if(bayonet)
			to_chat(user, "<span class='notice'>You unscrew the bayonet from \the [src].</span>")
			var/obj/item/kitchen/knife/K = bayonet
			K.forceMove(get_turf(user))
			bayonet = null
			update_icon()
		if(scope)
			to_chat(user, "<span class='notice'>You unscrew the scope from \the [src].</span>")
			var/obj/item/attachments/scope/C = scope
			C.forceMove(get_turf(user))
			src.zoomable = FALSE
			azoom.Remove(user)
			scope = null
			update_icon()
	else
		return ..()

/obj/item/gun/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_scope_zoom))
		zoom(user)
	else if(istype(action, alight))
		toggle_gunlight()

/obj/item/gun/proc/toggle_gunlight()
	if(!gun_light)
		return

	var/mob/living/carbon/human/user = usr
	gun_light.on = !gun_light.on
	to_chat(user, "<span class='notice'>You toggle the gunlight [gun_light.on ? "on":"off"].</span>")

	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_gunlight(user)
	return

/obj/item/gun/proc/update_gunlight(mob/user = null)
	if(gun_light)
		if(gun_light.on)
			set_light(gun_light.brightness_on, gun_light.flashlight_power, gun_light.light_color)
		else
			set_light(0)
	else
		set_light(0)
	update_icon()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/gun/pickup(mob/user)
	..()
	if(azoom)
		azoom.Grant(user)
	if(alight)
		alight.Grant(user)

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(user.get_active_held_item() != src) //we can only stay zoomed in if it's in our hands	//yeah and we only unzoom if we're actually zoomed using the gun!!
		zoom(user, FALSE)
		if(zoomable == TRUE)
			azoom.Remove(user)

/obj/item/gun/dropped(mob/user)
	. = ..()
	if(zoomed)
		zoom(user,FALSE)
	if(azoom)
		azoom.Remove(user)
	if(alight)
		alight.Remove(user)

/obj/item/gun/update_overlays()
	. = ..()
	if(gun_light)
		var/state = "[gunlight_state][gun_light.on? "_on":""]"	//Generic state.
		if(gun_light.icon_state in icon_states('icons/obj/guns/flashlights.dmi'))	//Snowflake state?
			state = gun_light.icon_state
		flashlight_overlay = mutable_appearance('icons/obj/guns/flashlights.dmi', state)
		flashlight_overlay.pixel_x = flight_x_offset
		flashlight_overlay.pixel_y = flight_y_offset
		. += flashlight_overlay
	else
		flashlight_overlay = null

	if(bayonet)
		if(bayonet.icon_state in icon_states('icons/obj/guns/bayonets.dmi'))		//Snowflake state?
			knife_overlay = bayonet.icon_state
		var/icon/bayonet_icons = 'icons/obj/guns/bayonets.dmi'
		knife_overlay = mutable_appearance(bayonet_icons, bayonet_state)
		knife_overlay.pixel_x = knife_x_offset
		knife_overlay.pixel_y = knife_y_offset
		. += knife_overlay
	else
		knife_overlay = null

	if(scope)
		if(scope.icon_state in icon_states('icons/obj/guns/scopes.dmi'))
			scope_overlay = scope.icon_state
		var/icon/scope_icons = 'icons/obj/guns/scopes.dmi'
		scope_overlay = mutable_appearance(scope_icons, scope_state)
		scope_overlay.pixel_x = scope_x_offset
		scope_overlay.pixel_y = scope_y_offset
		. += scope_overlay
	else
		scope_overlay = null

	if(suppressed)
		var/icon/suppressor_icons = 'icons/obj/guns/suppressors.dmi'
		suppressor_overlay = mutable_appearance(suppressor_icons, suppressor_state)
		suppressor_overlay.pixel_x = suppressor_x_offset
		suppressor_overlay.pixel_y = suppressor_y_offset
		. += suppressor_overlay
	else
		suppressor_overlay = null

/obj/item/gun/item_action_slot_check(slot, mob/user, datum/action/A)
	if(istype(A, /datum/action/item_action/toggle_scope_zoom) && slot != SLOT_HANDS)
		return FALSE
	return ..()

/obj/item/gun/proc/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return

	if(on_cooldown())
		return

	if(user == target)
		target.visible_message("<span class='warning'>[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger...</span>", \
			"<span class='userdanger'>You stick [src] in your mouth, ready to pull the trigger...</span>")
	else
		target.visible_message("<span class='warning'>[user] points [src] at [target]'s head, ready to pull the trigger...</span>", \
			"<span class='userdanger'>[user] points [src] at your head, ready to pull the trigger...</span>")

	busy_action = TRUE

	if(!bypass_timer && (!do_mob(user, target, 120) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message("<span class='notice'>[user] decided not to shoot.</span>")
			else if(target && target.Adjacent(user))
				target.visible_message("<span class='notice'>[user] has decided to spare [target]</span>", "<span class='notice'>[user] has decided to spare your life!</span>")
		busy_action = FALSE
		return

	busy_action = FALSE

	target.visible_message("<span class='warning'>[user] pulls the trigger!</span>", "<span class='userdanger'>[user] pulls the trigger!</span>")

	playsound('sound/weapons/dink.ogg', 30, 1)

	if(chambered && chambered.BB)
		chambered.BB.damage *= 5

	process_fire(target, user, TRUE, params, stam_cost = getstamcost(user))

/obj/item/gun/proc/unlock() //used in summon guns and as a convience for admins
	if(pin)
		qdel(pin)
	pin = new /obj/item/firing_pin

//Happens before the actual projectile creation
/obj/item/gun/proc/before_firing(atom/target,mob/user)
	return

/////////////
// ZOOMING //
/////////////

/datum/action/item_action/toggle_scope_zoom
	name = "Toggle Scope"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_RESTRAINED|AB_CHECK_STUN|AB_CHECK_LYING
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"

/datum/action/item_action/toggle_scope_zoom/Trigger()
	var/obj/item/gun/gun = target
	if(do_after(owner,10))
		gun.zoom(owner)

/datum/action/item_action/toggle_scope_zoom/IsAvailable(silent = FALSE)
	. = ..()
	if(!. && target)
		var/obj/item/gun/gun = target
		gun.zoom(owner, FALSE)

/datum/action/item_action/toggle_scope_zoom/Remove(mob/living/L)
	var/obj/item/gun/gun = target
	gun.zoom(L, FALSE)
	..()

/obj/item/gun/proc/zoom(mob/living/user, forced_zoom)
	if(!(user?.client))
		return

	if(!isnull(forced_zoom))
		if(zoomed == forced_zoom)
			return
		zoomed = forced_zoom
	else
		zoomed = !zoomed

	if(zoomed)//if we need to be zoomed in
		user.add_movespeed_modifier(/datum/movespeed_modifier/scoped_in)
		var/_x = 0
		var/_y = 0
		switch(user.dir)
			if(NORTH)
				_y = zoom_amt
			if(EAST)
				_x = zoom_amt
			if(SOUTH)
				_y = -zoom_amt
			if(WEST)
				_x = -zoom_amt

		user.client.change_view(zoom_out_amt)
		user.client.pixel_x = world.icon_size*_x
		user.client.pixel_y = world.icon_size*_y
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/on_walk)
		RegisterSignal(user, COMSIG_ATOM_DIR_CHANGE, .proc/rotate)
		user.visible_message("<span class='notice'>[user] looks down the scope of [src].</span>", "<span class='notice'>You look down the scope of [src].</span>")
	else
		user.remove_movespeed_modifier(/datum/movespeed_modifier/scoped_in)
		user.client.change_view(CONFIG_GET(string/default_view))
		user.client.pixel_x = 0
		user.client.pixel_y = 0
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(user, COMSIG_ATOM_DIR_CHANGE)
		user.visible_message("<span class='notice'>[user] looks up from the scope of [src].</span>", "<span class='notice'>You look up from the scope of [src].</span>")

/obj/item/gun/proc/on_walk(mob/living/L)
//	zoom(L, FALSE)

/obj/item/gun/proc/rotate(mob/living/user, old_dir, direction = FALSE)
	var/_x = 0
	var/_y = 0
	switch(direction)
		if(NORTH)
			_y = zoom_amt
		if(EAST)
			_x = zoom_amt
		if(SOUTH)
			_y = -zoom_amt
		if(WEST)
			_x = -zoom_amt
	user.client.change_view(zoom_out_amt)
	user.client.pixel_x = world.icon_size*_x
	user.client.pixel_y = world.icon_size*_y

//Proc, so that gun accessories/scopes/etc. can easily add zooming.
/obj/item/gun/proc/build_zooming()
	if(azoom)
		return

	if(zoomable)
		azoom = new(src)

/obj/item/gun/handle_atom_del(atom/A)
	if(A == chambered)
		chambered = null
		update_icon()

/obj/item/gun/proc/getinaccuracy(mob/living/user, bonus_spread, stamloss)
	if(inaccuracy_modifier == 0)
		return bonus_spread
	var/base_inaccuracy = weapon_weight * 25 * inaccuracy_modifier
	var/aiming_delay = 0 //Otherwise aiming would be meaningless for slower guns such as sniper rifles and launchers.
	if(fire_delay)
		var/penalty = (last_fire + GUN_AIMING_TIME + fire_delay) - world.time
		if(penalty > 0) //Yet we only penalize users firing it multiple times in a haste. fire_delay isn't necessarily cumbersomeness.
			aiming_delay = penalty
	if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE) || HAS_TRAIT(user, TRAIT_INSANE_AIM)) //To be removed in favor of something less tactless later.
		base_inaccuracy /= 1.5
	if(stamloss > STAMINA_NEAR_SOFTCRIT) //This can null out the above bonus.
		base_inaccuracy *= 1 + (stamloss - STAMINA_NEAR_SOFTCRIT)/(STAMINA_NEAR_CRIT - STAMINA_NEAR_SOFTCRIT)*0.5
	if(HAS_TRAIT(user, TRAIT_POOR_AIM)) //nice shootin' tex
		if(!HAS_TRAIT(user, TRAIT_INSANE_AIM))
			bonus_spread += 60
		else
			//you have both poor aim and insane aim, why?
			bonus_spread += rand(0,50)
	var/mult = max((GUN_AIMING_TIME + aiming_delay + user.last_click_move - world.time)/GUN_AIMING_TIME, -0.5) //Yes, there is a bonus for taking time aiming.
	if(mult < 0) //accurate weapons should provide a proper bonus with negative inaccuracy. the opposite is true too.
		mult *= 1/inaccuracy_modifier
	return max(bonus_spread + (base_inaccuracy * mult), 0) //no negative spread.

/obj/item/gun/proc/getstamcost(mob/living/carbon/user)
	. = recoil
	if(user && !user.has_gravity())
		. = recoil*5