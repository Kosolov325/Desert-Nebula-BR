#define RESTART_COUNTER_PATH "data/round_counter.txt"

GLOBAL_VAR(restart_counter)
GLOBAL_VAR_INIT(tgs_initialized, FALSE)

GLOBAL_VAR(topic_status_lastcache)
GLOBAL_LIST(topic_status_cache)

//This happens after the Master subsystem new(s) (it's a global datum)
//So subsystems globals exist, but are not initialised

/world/New()
	var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if (debug_server)
		call(debug_server, "auxtools_init")()
		enable_debugging()
	AUXTOOLS_CHECK(AUXMOS)
#ifdef REFERENCE_TRACKING
	enable_reference_tracking()
#endif

	world.Profile(PROFILE_START)
	log_world("World loaded at [TIME_STAMP("hh:mm:ss", FALSE)]!")

	AUXTOOLS_CHECK(AUXMAPTICK)

	GLOB.config_error_log = GLOB.world_manifest_log = GLOB.world_pda_log = GLOB.world_job_debug_log = GLOB.sql_error_log = GLOB.world_href_log = GLOB.world_runtime_log = GLOB.world_attack_log = GLOB.world_game_log = "data/logs/config_error.[GUID()].log" //temporary file used to record errors with loading config, moved to log directory once logging is set bl

	make_datum_references_lists()	//initialises global lists for referencing frequently used datums (so that we only ever do it once)


	GLOB.revdata = new

	InitTgs()

	config.Load(params[OVERRIDE_CONFIG_DIRECTORY_PARAMETER])

	//SetupLogs depends on the RoundID, so lets check
	//DB schema and set RoundID if we can
	SSdbcore.CheckSchemaVersion()
	SSdbcore.SetRoundID()
	SetupLogs()

#ifndef USE_CUSTOM_ERROR_HANDLER
	world.log = file("[GLOB.log_directory]/dd.log")
#else
	if (TgsAvailable())
		world.log = file("[GLOB.log_directory]/dd.log") //not all runtimes trigger world/Error, so this is the only way to ensure we can see all of them.
#endif

	load_admins()
	load_mentors()
	LoadVerbs(/datum/verbs/menu)
	if(CONFIG_GET(flag/usewhitelist))
		load_whitelist()
	LoadBans()
	initialize_global_loadout_items()
	reload_custom_roundstart_items_list()//Cit change - loads donator items. Remind me to remove when I port over bay's loadout system

	GLOB.timezoneOffset = text2num(time2text(0,"hh")) * 36000

	if(fexists(RESTART_COUNTER_PATH))
		GLOB.restart_counter = text2num(trim(file2text(RESTART_COUNTER_PATH)))
		fdel(RESTART_COUNTER_PATH)

	if(NO_INIT_PARAMETER in params)
		return

	Master.Initialize(10, FALSE, TRUE)

	#ifdef UNIT_TESTS
	HandleTestRun()
	#endif

/world/proc/InitTgs()
	TgsNew(new /datum/tgs_event_handler/impl, TGS_SECURITY_TRUSTED)
	GLOB.revdata.load_tgs_info()
	GLOB.tgs_initialized = TRUE

/world/proc/HandleTestRun()
	//trigger things to run the whole process
	Master.sleep_offline_after_initializations = FALSE
	SSticker.start_immediately = TRUE
	CONFIG_SET(number/round_end_countdown, 0)
	var/datum/callback/cb
#ifdef UNIT_TESTS
	cb = CALLBACK(GLOBAL_PROC, /proc/RunUnitTests)
#else
	cb = VARSET_CALLBACK(SSticker, force_ending, TRUE)
#endif
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, /proc/addtimer, cb, 10 SECONDS))

/world/proc/SetupLogs()
	var/override_dir = params[OVERRIDE_LOG_DIRECTORY_PARAMETER]
	if(!override_dir)
		var/realtime = world.realtime
		var/texttime = time2text(realtime, "YYYY/MM/DD")
		GLOB.log_directory = "data/logs/[texttime]/round-"
		GLOB.picture_logging_prefix = "L_[time2text(realtime, "YYYYMMDD")]_"
		GLOB.picture_log_directory = "data/picture_logs/[texttime]/round-"
		if(GLOB.round_id)
			GLOB.log_directory += "[GLOB.round_id]"
			GLOB.picture_logging_prefix += "R_[GLOB.round_id]_"
			GLOB.picture_log_directory += "[GLOB.round_id]"
		else
			var/timestamp = replacetext(TIME_STAMP("hh:mm:ss", FALSE), ":", ".")
			GLOB.log_directory += "[timestamp]"
			GLOB.picture_log_directory += "[timestamp]"
			GLOB.picture_logging_prefix += "T_[timestamp]_"
	else
		GLOB.log_directory = "data/logs/[override_dir]"
		GLOB.picture_logging_prefix = "O_[override_dir]_"
		GLOB.picture_log_directory = "data/picture_logs/[override_dir]"

	GLOB.world_game_log = "[GLOB.log_directory]/game.log"
	GLOB.world_virus_log = "[GLOB.log_directory]/virus.log"
	GLOB.world_asset_log = "[GLOB.log_directory]/asset.log"
	GLOB.world_attack_log = "[GLOB.log_directory]/attack.log"
	GLOB.world_pda_log = "[GLOB.log_directory]/pda.log"
	GLOB.world_telecomms_log = "[GLOB.log_directory]/telecomms.log"
	GLOB.world_manifest_log = "[GLOB.log_directory]/manifest.log"
	GLOB.world_href_log = "[GLOB.log_directory]/hrefs.log"
	GLOB.sql_error_log = "[GLOB.log_directory]/sql.log"
	GLOB.world_qdel_log = "[GLOB.log_directory]/qdel.log"
	GLOB.world_map_error_log = "[GLOB.log_directory]/map_errors.log"
	GLOB.world_runtime_log = "[GLOB.log_directory]/runtime.log"
	GLOB.query_debug_log = "[GLOB.log_directory]/query_debug.log"
	GLOB.world_job_debug_log = "[GLOB.log_directory]/job_debug.log"
	GLOB.world_paper_log = "[GLOB.log_directory]/paper.log"
	GLOB.tgui_log = "[GLOB.log_directory]/tgui.log"
	GLOB.subsystem_log = "[GLOB.log_directory]/subsystem.log"
	GLOB.reagent_log = "[GLOB.log_directory]/reagents.log"
	GLOB.world_crafting_log = "[GLOB.log_directory]/crafting.log"
	GLOB.click_log = "[GLOB.log_directory]/click.log"
	GLOB.world_asset_log = "[GLOB.log_directory]/asset.log"


#ifdef UNIT_TESTS
	GLOB.test_log = file("[GLOB.log_directory]/tests.log")
	start_log(GLOB.test_log)
#endif
	start_log(GLOB.world_game_log)
	start_log(GLOB.world_attack_log)
	start_log(GLOB.world_pda_log)
	start_log(GLOB.world_telecomms_log)
	start_log(GLOB.world_manifest_log)
	start_log(GLOB.world_href_log)
	start_log(GLOB.world_qdel_log)
	start_log(GLOB.world_runtime_log)
	start_log(GLOB.world_job_debug_log)
	start_log(GLOB.tgui_log)
	start_log(GLOB.subsystem_log)
	start_log(GLOB.reagent_log)
	start_log(GLOB.world_crafting_log)
	start_log(GLOB.click_log)

	GLOB.changelog_hash = md5('html/changelog.html') //for telling if the changelog has changed recently
	if(fexists(GLOB.config_error_log))
		fcopy(GLOB.config_error_log, "[GLOB.log_directory]/config_error.log")
		fdel(GLOB.config_error_log)

	if(GLOB.round_id)
		log_game("Round ID: [GLOB.round_id]")

	// This was printed early in startup to the world log and config_error.log,
	// but those are both private, so let's put the commit info in the runtime
	// log which is ultimately public.
	log_runtime(GLOB.revdata.get_log_message())

/world/Topic(T, addr, master, key)
	TGS_TOPIC	//redirect to server tools if necessary

	if(!SSfail2topic)
		return "Server not initialized."
	else if(SSfail2topic.IsRateLimited(addr))
		return "Rate limited."

	if(length(T) > CONFIG_GET(number/topic_max_size))
		return "Payload too large!"

	var/static/list/topic_handlers = TopicHandlers()

	var/list/input = params2list(T)
	var/datum/world_topic/handler
	for(var/I in topic_handlers)
		if(I in input)
			handler = topic_handlers[I]
			break

	if((!handler || initial(handler.log)) && config && CONFIG_GET(flag/log_world_topic))
		log_topic("\"[T]\", from:[addr], master:[master], key:[key]")

	if(!handler)
		return

	handler = new handler()
	return handler.TryRun(input, addr)

/world/proc/AnnouncePR(announcement, list/payload)
	var/static/list/PRcounts = list()	//PR id -> number of times announced this round
	var/id = "[payload["pull_request"]["id"]]"
	if(!PRcounts[id])
		PRcounts[id] = 1
	else
		++PRcounts[id]
		if(PRcounts[id] > PR_ANNOUNCEMENTS_PER_ROUND)
			return

	var/final_composed = "<span class='announce'>PR: [announcement]</span>"
	for(var/client/C in GLOB.clients)
		C.AnnouncePR(final_composed)

/world/proc/FinishTestRun()
	set waitfor = FALSE
	var/list/fail_reasons
	if(GLOB)
		if(GLOB.total_runtimes != 0)
			fail_reasons = list("Total runtimes: [GLOB.total_runtimes]")
#ifdef UNIT_TESTS
		if(GLOB.failed_any_test)
			LAZYADD(fail_reasons, "Unit Tests failed!")
#endif
		if(!GLOB.log_directory)
			LAZYADD(fail_reasons, "Missing GLOB.log_directory!")
	else
		fail_reasons = list("Missing GLOB!")
	if(!fail_reasons)
		text2file("Success!", "[GLOB.log_directory]/clean_run.lk")
	else
		log_world("Test run failed!\n[fail_reasons.Join("\n")]")
	sleep(0)	//yes, 0, this'll let Reboot finish and prevent byond memes
	qdel(src)	//shut it down

/world/Reboot(reason = 0, fast_track = FALSE)
	if (reason || fast_track) //special reboot, do none of the normal stuff
		if (usr)
			log_admin("[key_name(usr)] Has requested an immediate world restart via client side debugging tools")
			message_admins("[key_name_admin(usr)] Has requested an immediate world restart via client side debugging tools")
		to_chat(world, "<span class='boldannounce'>Rebooting World immediately due to host request.</span>")
	else
		to_chat(world, "<span class='boldannounce'>Rebooting world...</span>")
		Master.Shutdown()	//run SS shutdowns

	TgsReboot()

	#ifdef UNIT_TESTS
	FinishTestRun()
	return
	#endif

	if(TgsAvailable())
		var/do_hard_reboot
		// check the hard reboot counter
		var/ruhr = CONFIG_GET(number/rounds_until_hard_restart)
		switch(ruhr)
			if(-1)
				do_hard_reboot = FALSE
			if(0)
				do_hard_reboot = TRUE
			else
				if(GLOB.restart_counter >= ruhr)
					do_hard_reboot = TRUE
				else
					text2file("[++GLOB.restart_counter]", RESTART_COUNTER_PATH)
					do_hard_reboot = FALSE

		if(do_hard_reboot)
			log_world("World hard rebooted at [TIME_STAMP("hh:mm:ss", FALSE)]")
			shutdown_logging() // See comment below.
			TgsEndProcess()

	log_world("World rebooted at [TIME_STAMP("hh:mm:ss", FALSE)]")
	shutdown_logging() // Past this point, no logging procs can be used, at risk of data loss.
	..()

/world/Del()
	shutdown_logging() // makes sure the thread is closed before end, else we terminate
	AUXTOOLS_SHUTDOWN(AUXMOS)
	AUXTOOLS_SHUTDOWN(AUXMAPTICK)
	var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if (debug_server)
		call(debug_server, "auxtools_shutdown")()
	..()

/world/proc/update_status()

	var/list/features = list()

	/*if(GLOB.master_mode) CIT CHANGE - hides the gamemode from the hub entry, removes some useless info from the hub entry
		features += GLOB.master_mode

	if (!GLOB.enter_allowed)
		features += "closed"*/

	var/s = ""
	var/hostedby
	if(config)
		var/server_name = CONFIG_GET(string/servername)
		if (server_name)
			s += "<b>[server_name]</b> &#8212; "
		/*features += "[CONFIG_GET(flag/norespawn) ? "no " : ""]respawn" CIT CHANGE - removes some useless info from the hub entry
		if(CONFIG_GET(flag/allow_vote_mode))
			features += "vote"
		if(CONFIG_GET(flag/allow_ai))
			features += "AI allowed"*/
		hostedby = CONFIG_GET(string/hostedby)

	s += "<b>[station_name()]</b>";
	s += " ("
	s += "<a href=\"https://discord.gg/3Q8hRaDf7B\">" //Change this to wherever you want the hub to link to. CIT CHANGE - links to cit's website on the hub
	s += "Desert Nebula BR"  //Replace this with something else. Or ever better, delete it and uncomment the game version. CIT CHANGE - modifies the hub entry link
	s += "</a>"
	s += ")\]" //CIT CHANGE - encloses the server title in brackets to make the hub entry fancier
	s += "<br>[CONFIG_GET(string/servertagline)]<br>" //CIT CHANGE - adds a tagline!

	var/n = 0
	for (var/mob/M in GLOB.player_list)
		if (M.client)
			n++

	if(SSmapping.config) // this just stops the runtime, honk.
		features += "[SSmapping.config.map_name]"	//CIT CHANGE - makes the hub entry display the current map

	if (n > 1)
		features += "~[n] players"
	else if (n > 0)
		features += "~[n] player"

	if (!host && hostedby)
		features += "hosted by <b>[hostedby]</b>"

	if (features)
		s += "\[[jointext(features, ", ")]" //CIT CHANGE - replaces the colon here with a left bracket

	status = s

/world/proc/update_hub_visibility(new_visibility)
	if(new_visibility == GLOB.hub_visibility)
		return
	GLOB.hub_visibility = new_visibility
	if(GLOB.hub_visibility)
		hub_password = "kMZy3U5jJHSiBQjr"
	else
		hub_password = "SORRYNOPASSWORD"

/world/proc/incrementMaxZ()
	maxz++
	SSmobs.MaxZChanged()
	SSidlenpcpool.MaxZChanged()
	world.refresh_atmos_grid()

/world/proc/refresh_atmos_grid()
