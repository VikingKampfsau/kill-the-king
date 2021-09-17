/*---------------------------------------------------------------------------
|///////////////////////////////////////////////////////////////////////////|
|///\  \/////////  ///|  |//|  |///  ///|  |//|   \////|  |//|          |///|
|////\  \///////  ////|  |//|  |//  ////|  |//|    \///|  |//|  ________|///|
|/////\  \/////  /////|  |//|  |/  /////|  |//|  \  \//|  |//|  |///////////|
|//////\  \///  //////|  |//|     //////|  |//|  |\  \/|  |//|  |//|    |///|
|///////\  \/  ///////|  |//|     \/////|  |//|  |/\  \|  |//|  |//|_   |///|
|////////\    ////////|  |//|  |\  \////|  |//|  |//\  \  |//|  |////|  |///|
|/////////\  /////////|  |//|  |/\  \///|  |//|  |///\    |//|          |///|
|//////////\//////////|__|//|__|//\__\//|__|//|__|////\___|//|__________|///|
|///////////////////////////////////////////////////////////////////////////|
|---------------------------------------------------------------------------|
|				   Do not copy or modify without permission				    |
|--------------------------------------------------------------------------*/
#include maps\mp\gametypes\_misc;

setDvars()
{
	//Cod4 Stock
	if(getDvar("scr_player_maxhealth") != "1000") setDvar("scr_player_maxhealth", "1000");
	if(getDvar("scr_team_fftype") != "0" ) setDvar("scr_team_fftype", "0");
	if(getDvar("ui_friendlyfire") != "0" ) setDvar("ui_friendlyfire", "0");
	if(getDvar("scr_enable_hiticon") != "0" ) setDvar("scr_enable_hiticon", "0");
	if(getDvar("scr_hardcore") != "0" ) setDvar("scr_hardcore", "0");
	if(getDvar("scr_oldschool_mw") != "0" ) setDvar("scr_oldschool_mw", "0");
	if(getDvar("scr_player_sprinttime") != "4" ) setDvar("scr_player_sprinttime", "4");
	if(getDvar("scr_teambalance") != "0" ) setDvar("scr_teambalance", "0");
	if(getDvar("scr_showperksonspawn" ) != "0" ) setDvar("scr_showperksonspawn", "0");
	if(getDvar("scr_game_matchstarttime" ) != "0" ) setDvar("scr_game_matchstarttime", "0");
	if(getDvar("scr_game_playerwaittime" ) != "0" ) setDvar("scr_game_playerwaittime", "0");
	if(getDvar("sv_kickbantime" ) != "0" ) setDvar("sv_kickbantime", 0);
	if(getDvar("r_FilmTweakEnable" ) != "1" ) setDvar("r_FilmTweakEnable", 1);
	if(getDvar("r_FilmUseTweaks" ) != "1" ) setDvar("r_FilmUseTweaks", 1);
	if(getDvar("scr_intermission_time") == "" || getDvarFloat("scr_intermission_time") > 30) setDvar("scr_intermission_time", 30);
	if(getDvarInt("sv_maxclients" ) > 32) setDvar("sv_maxclients", 32);
	if(getDvarInt("ui_maxclients" ) > 32) setDvar("ui_maxclients", 32);
	
	//Mod & Gametype
	if(getDvar("scr_mod_picktime") == "" || getDvarInt("scr_mod_picktime") == 0) setDvar("scr_mod_picktime", 1);
	if(getDvar("scr_mod_roundstarttime") == "" || getDvarInt("scr_mod_roundstarttime") == 0) setDvar("scr_mod_roundstarttime", 1);
	if(getDvar("scr_mod_minplayers") == "" || getDvarInt("scr_mod_minplayers") < 2) setDvar("scr_mod_minplayers", 2);
	if(getDvar("scr_mod_revive") == "" ) setDvar("scr_mod_revive", "1" );
	if(getDvar("scr_mod_mapvote") == "" ) setDvar("scr_mod_mapvote", "0" );
	if(getDvar("scr_mod_finalkillcam") == "" ) setDvar("scr_mod_finalkillcam", 1 );
	if(getDvar("scr_mod_finalkillcam_suicide") == "" ) setDvar("scr_mod_finalkillcam_suicide", 1 );
	if(getDvar("scr_mod_blood") == "" ) setDvar("scr_mod_blood", "1" );
	if(getDvar("scr_mod_painsound") == "" ) setDvar("scr_mod_painsound", "1" );
	if(getDvar("scr_mod_revivetime") == "" ) setDvar("scr_mod_revivetime", "1" );
	if(getDvar("scr_ktk_king_health") == "") setDvar("scr_ktk_king_health", 300);
	if(getDvar("scr_ktk_terminator") == "" ) setDvar("scr_ktk_terminator", "1" );
	if(getDvar("scr_ktk_terminator_delay") == "" ) setDvar("scr_ktk_terminator_delay", 2.5 );
	if(getDvar("scr_ktk_terminator_health") == "") setDvar("scr_ktk_terminator_health", 600);
	if(getDvar("scr_ktk_terminator_players") == "") setDvar("scr_ktk_terminator_players", 6);
	if(getDvar("scr_ktk_kingmodel") == "") setDvar("scr_ktk_kingmodel", "0");
	if(getDvar("scr_ktk_dog") == "") setDvar("scr_ktk_dog", 1);
	if(getDvar("scr_ktk_dog_players") == "") setDvar("scr_ktk_dog_players", 6);
	if(getDvar("scr_ktk_dog_damage") == "") setDvar("scr_ktk_dog_damage", 100);
	if(getDvar("scr_ktk_dog_health") == "") setDvar("scr_ktk_dog_health", 80);
	if(getDvar("scr_ktk_assassin_switch") == "") setDvar("scr_ktk_assassin_switch", 2);
	if(getDvar("finalcamplaying") == "") setDvar("finalcamplaying", 0);
	if(getDvar("last_assassin") == "") setDvar("last_assassin", 999);
	if(getDvar("last_king") == "") setDvar("last_king", 999);
	if(getDvar("last_dog") == "") setDvar("last_dog", 999);
	if(getDvar("scr_mod_expbolt_damage") == "") setDvar("scr_mod_expbolt_damage", 300);
	if(getDvar("scr_mod_wallbangmodifier") == "") setDvar("scr_mod_wallbangmodifier", 1.0);
	if(getDvar("scr_mod_minigun_overheat") == "") setDvar("scr_mod_minigun_overheat", 1);
	if(getDvar("scr_mod_minigun_minheat") == "") setDvar("scr_mod_minigun_minheat", 60);
	if(getDvar("scr_mod_minigun_maxheat") == "") setDvar("scr_mod_minigun_maxheat", 110);
	if(getDvar("scr_mod_minigun_overheatrate") == "") setDvar("scr_mod_minigun_overheatrate", 1.5);
	if(getDvar("scr_mod_minigun_cooldownrate") == "") setDvar("scr_mod_minigun_cooldownrate", 0.95);
	if(getDvar("scr_mod_katana_damage") == "") setDvar("scr_mod_katana_damage", 200);
	if(getDvar("scr_mod_turrets") == "") setDvar("scr_mod_turrets", 0);
	if(getDvar("scr_mod_explosive_barrels") == "") setDvar("scr_mod_explosive_barrels", 1);
	if(getDvar("scr_mod_explosive_cars") == "") setDvar("scr_mod_explosive_cars", 1);
	if(getDvar("scr_map_weaponpickups") == "") setDvar("scr_map_weaponpickups", 0);
	if(getDvar("scr_mod_quickmessages") == "") setDvar("scr_mod_quickmessages", 3);
	if(getDvar("scr_mod_targetmarkers") == "") setDvar("scr_mod_targetmarkers", 1);
	if(getDvar("scr_mod_glowXpText") == "") setDvar("scr_mod_glowXpText", 1);
	if(getDvar("scr_mod_glowXpText_suicide") == "") setDvar("scr_mod_glowXpText_suicide", "1 0 0");
	if(getDvar("scr_mod_glowXpText_assist") == "") setDvar("scr_mod_glowXpText_assist", "1 0.502 0.251");
	if(getDvar("scr_mod_glowXpText_kill") == "") setDvar("scr_mod_glowXpText_kill", "0 0.6 1");
	if(getDvar("scr_class_percentage_knife") == "") setDvar("scr_class_percentage_knife", 0.15);
	if(getDvar("scr_class_percentage_bolt") == "") setDvar("scr_class_percentage_bolt", 0.25);
	if(getDvar("scr_class_percentage_scope") == "") setDvar("scr_class_percentage_scope", 0.25);
	if(getDvar("scr_class_percentage_strongscope") == "") setDvar("scr_class_percentage_strongscope", 0.20);
	if(getDvar("scr_class_percentage_hardscope") == "") setDvar("scr_class_percentage_hardscope", 0.1);
	if(getDvar("scr_class_percentage_katana") == "") setDvar("scr_class_percentage_katana", 0.05);
	if(getDvar("scr_mod_heli_health") == "") setDvar("scr_mod_heli_health", 1500);
	if(getDvarInt("scr_mod_heli_health") < 1) setDvar("scr_mod_heli_health", 1);
	if(getDvar("scr_mod_heli_healthaddition") == "") setDvar("scr_mod_heli_healthaddition", 100);
	if(getDvarInt("scr_mod_heli_healthaddition") < 1) setDvar("scr_mod_heli_healthaddition", 1);
	
	if(getDvar("g_gametype") == "ctc")
		setDvar("scr_player_respawndelay", 10);
	else
		setDvar("scr_player_respawndelay", 0);
}

newPlayerDvars()
{
	self endon("disconnect");
	
	if(self isABot())
		return;
	
	if(getDvarInt("scr_hardpoint_system") >= 1)
	{
		self setClientDvars("hardpoint_kills_rccar", getDvarInt("scr_hardpoint_guard_rccar"),
							"hardpoint_kills_rchelicopter", getDvarInt("scr_hardpoint_guard_rchelicopter"),
							"hardpoint_kills_poison", getDvarInt("scr_hardpoint_guard_poison"),
							"hardpoint_kills_carepackage", getDvarInt("scr_hardpoint_carepackage"),
							"hardpoint_kills_airstrike", getDvarInt("scr_hardpoint_guard_airstrike"),
							"hardpoint_kills_mortar", getDvarInt("scr_hardpoint_guard_mortar"),
							"hardpoint_kills_helicopter", getDvarInt("scr_hardpoint_guard_helicopter"),
							"hardpoint_kills_ac130", getDvarInt("scr_hardpoint_guard_ac130"),
							"hardpoint_kills_SentryGun", getDvarInt("scr_hardpoint_guard_SentryGun"),
							"hardpoint_kills_Predator", getDvarInt("scr_hardpoint_guard_Predator"),
							"hardpoint_kills_Nuke", getDvarInt("scr_hardpoint_guard_Nuke"),
							"hardpoint_kills_Juggernaut", getDvarInt("scr_hardpoint_guard_juggernaut"));
	}
	
	self setClientDvars(
				//Error & Kick
				"server_email", getDvar("_Email"),
				"server_website", getDvar("_Website"),
				//Hardpoints
				"hardpoints_custom_order", getDvarInt("scr_hardpoint_system"),
				//Motd
				"ui_motd", DefineMOTD(),
				//Rules
						"rule_1", getDvar("rule_1"),
						"rule_2", getDvar("rule_2"),
						"rule_3", getDvar("rule_3"),
						"rule_4", getDvar("rule_4"),
						"rule_5", getDvar("rule_5"),
				//Add to favorit button
						"ui_favoriteName", getDvar("sv_hostname"),
						"ui_favoriteAddress", getDvar("net_ip") + ":" + getDvar("net_port"),
						"connectlastserver", "connect " + getDvar("net_ip") + ":" + getDvar("net_port"),
				//Award Messages
						"ktk_award_size", 0,
				//Filmtweaks for Visions
						"sm_enable", 0,
						"r_dlightLimit", 0,
						"r_lodscalerigid", 1,
						"r_lodscaleskinned", 1,
						"r_zfeather", 0,
						"r_smc_enable", 0,
						"r_distortion", 0,
						"r_desaturation", 0,
						"r_specularcolorscale", 0,
						"fx_drawclouds", 0,
						"r_fog", 0,
				//Lobby fix when round end but no mapvote in progress
						"ktk_mapvote_lobby_available", 0,
				//Cash
						"cash", 0);
		
	if(!isDefined(level.GameNuked) || !level.GameNuked)
	{
		if(self getKtkStat(2405))
		{
			self setClientDvars(
				"r_FilmTweakEnable", 1,
				"r_FilmUseTweaks", 1);
		}
		else
		{
			self setClientDvars(
				"r_FilmTweakEnable", 0,
				"r_FilmUseTweaks", 0);
		}
	}

	if(getDvarInt("scr_ktk_kinghealthbar") == 1)
		self setClientDvar("cg_hudChatPosition", "5 230");
		
	while(!isDefined(self.pers["rank"]))
		wait .05;
		
	//auto set some stuff for new players
	if(self.pers["rank"] <= 0 && self.pers["prestige"] <= 0 && self.pers["rankxp"] <= 0)
	{
		self setKtkStat(2405, 0); //no vision
		self setKtkStat(2408, 0); //no xp message
		self setKtkStat(2413, 1); //no killcam
		self setKtkStat(2414, 1); //dog in thirdperson
		self setKtkStat(2415, 1); //slave instead of dog
	}
	
	wait 1; //required to finish the 'setu' stuff in menu 'team_marinesopfor'
	
	if(self getKtkStat(2406) == 0)
		self setKtkStat(2406, int(self GetUserinfo("cg_fov")));
		
	if(self getKtkStat(2407) == 0 && int(self GetUserinfo("cg_fovScale")) > 0)
		self setKtkStat(2407, int(self GetUserinfo("cg_fovScale")));
	
	self setClientDvars("r_fullbright", self getKtkStat(2401),
						"cg_drawAmmoNum", self getKtkStat(2402),
						"r_ktk_badge", self getKtkStat(2358),
						"cg_laserforceon", self getKtkStat(2404),
						"r_ktk_vision", self getKtkStat(2405),
						"cg_fov", self getKtkStat(2406),
						"ui_xpText", self getKtkStat(2408),
						"ui_3dwaypointtext", self getKtkStat(2409),
						"ui_deathicontext", self getKtkStat(2410),
						"r_ktk_bloodsplatter", self getKtkStat(2411),
						"aim_automelee_enabled", self getKtkStat(2412),
						"r_ktk_disablekillcam", self getKtkStat(2413),
						"cg_fovScale", 1 + (self getKtkStat(2407)*0.001),
						"r_ktk_slaveordog", self getKtkStat(2415),
						"r_ktk_prestiging", self getKtkStat(2416),
						"r_ktk_crosshaird_3rd", self getKtkStat(2417),
						"cg_thirdperson", self getKtkStat(2403),
						"r_ktk_dogthirdperson", self getKtkStat(2414),
						"r_ktk_rctoytype", self getKtkStat(2399),
						"r_ktk_healthbar_type", self getKtkStat(2418),
						"r_ktk_preference_king", self getKtkStat(2368),
						"r_ktk_preference_assassin", self getKtkStat(2367),
						"r_ktk_preference_slave", self getKtkStat(2369));
						
	if(game["customEvent"] == "hideandseek")
		self maps\mp\gametypes\_props::sendPropslistToPlayer();
}

DefineMOTD()
{
	disabledHardpoints = "";
	
	if(!getDvarInt("scr_rccar_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1RC-XD,";
	if(!getDvarInt("scr_poison_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1poison,";
	if(!getDvarInt("scr_cp_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1carepackage,";
	if(!getDvarInt("scr_airstrike_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1airstrike,";
	if(!getDvarInt("scr_mortar_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1mortars,";
	if(!getDvarInt("scr_heli_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1helicopter,";
	if(!getDvarInt("scr_ac130_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1ac130,";
	if(!getDvarInt("scr_sentrygun_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1sentry gun,";
	if(!getDvarInt("scr_predator_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1predator,";
	if(!getDvarInt("scr_nuke_enabled"))
		disabledHardpoints = disabledHardpoints + " ^1nuke,";
	
	if(disabledHardpoints != "")
	{
		if(getSubStr(disabledHardpoints, disabledHardpoints.size -1, disabledHardpoints.size) == ",")
			disabledHardpoints = getSubStr(disabledHardpoints, 0, disabledHardpoints.size -1);
	
		disabledHardpoints = "\n^1Disabled Hardpoints (this map):" + disabledHardpoints;
	}
	
	return getDvar("scr_motd") + disabledHardpoints;
}