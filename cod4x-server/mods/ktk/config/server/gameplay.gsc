init()
{
	//==============================================================================
	// Gameplaysettings 
	//==============================================================================

	setDvar("scr_disable_destructible", "0");	//Disable destructible cars in map

	setDvar("scr_game_allowkillcam", "1");
	setDvar("scr_game_onlyheadshots", "0");
	setDvar("scr_game_spectatetype", "0");	// (0-2) Disabled, Team/Players Only, Free
	setDvar("scr_game_matchstarttime", "0");
	setDvar("scr_game_playerwaittime", "0");
	setDvar("scr_intermission_time", "15");
	setDvar("scr_testclients", "0");

	setDvar("scr_killcam_time", "10"); // length from killcam start to killcam end
	setDvar("scr_killcam_posttime", "2"); // time after player death that killcam continues for

	setDvar("scr_mod_finalkillcam", "1");	// A cam which shows the roundwinning kill in the gametype KtK(0 = Disabled, 1 = Enabled)
	setDvar("scr_mod_finalkillcam_suicide", "1");	// Play the killcam when the king through a suicide
	setDvar("scr_mod_revive", "1");
	setDvar("scr_mod_revivetime", "1.2");	// time in seconds it needs to revived a downed
	setDvar("scr_mod_empty_time", "15");	// time in minutes the server has to be empty before the map changes
	setDvar("scr_mod_heli_health", "3000");	// min = 1 (default = 3000)
	setDvar("scr_mod_heli_healthaddition", "100");	//additional health for the helicopter (will be multiplicated with the amount of players on the server and added to the helicopter health)
	setDvar("scr_mod_heli_loops", "1");	// amount of times the heli circles the map ( min = 1, max = 3 (default = 2))
	setDvar("scr_mod_heli_drop", "1");	// the way the player will leave the heli (1 = parachute, 2 = spawning at the place he caled the heli from, 3 = spawning on a random tdm spawn)
	setDvar("scr_mod_mapvote", "1");	// 0 = Disabled, 1 = HUD based (map and event vote), 2 = menu based (map only - no event vote)
	setDvar("scr_mod_mapvote_blocktime", "5");	// amount of votes the currently playing map does not appear for
	setDvar("scr_mod_votetime", "30");	// time in seconds players can vote
	setDvar("scr_mod_minplayers", "2");	// Needed amount of players to start a round
	setDvar("scr_mod_timeannouncer", "1");	// 0 = Disabled, 1 = Enabled
	setDvar("scr_mod_rccar_health", "100");	// min = 1 (default = 100)
	setDvar("scr_mod_rccar_alivetime", "30");	// time in seconds until the car will detonate automaticaly (default = 30)
	setDvar("scr_mod_ac130_alivetime", "30");
	setDvar("scr_mod_tripwire_planttime", "1");
	setDvar("scr_mod_tripwire_defusetime", "5");
	setDvar("scr_mod_tripwire_defuse", "0");	// Defines who is able to defuse (0 = nobody, 1 = everybody, 2 = planter only)
	setDvar("scr_mod_tripwire_radius", "300"); // the radius the tripwire can deal damage in
	setDvar("scr_mod_tripwire_damage", "100"); // the amount of damage the tripwire does in center point
	setDvar("scr_mod_healthregen", "5");	// time in seconds until the health got totally refreshed (Default = 10)
	setDvar("scr_mod_blood", "1");	// 0 = Disabled, 1 = Enabled
	setDvar("scr_mod_painsound", "1");
	setDvar("scr_mod_throwknife_damage", "200"); // the damage the throwable knife is doing
	setDvar("scr_mod_throwknife_alivetime", "15");	// time a throwing knife can be picked up (0 = always, > 0 = time in seconds)
	setDvar("scr_mod_roundstarttime", "3");	// time in seconds till the game starts after a mapchange (default = 10)
	setDvar("scr_mod_picktime", "2"); 	// time in seconds the king, assassin and dog will be chosen (default = 2)
	setDvar("scr_mod_antiglitch", "1");	// 0 = disabled, 1 = invisible walls (blockers), 2 = respawn glitchers, 3 kill glitcher
	setDvar("scr_mod_afk", "0");	// 0 = disabled, 1 switch afk to spectators
	setDvar("scr_mod_afkdelay", "10");	// time after roundstart till an afk gets switched
	setDvar("scr_mod_spawnprotection", "1");	// 0 = Disabled, 1 = Enabled
	setDvar("scr_mod_spawnprotectionradius", "30");	// Max distance a player can travel until spawprotection ends
	setDvar("scr_mod_spawnprotectiontime", "5");	// Max time the spawprotection lasts for
	setDvar("scr_mod_grenadelauncher", "1");	// 0 = Disabled, 1 = Enabled
	setDvar("scr_mod_wallbangmodifier", "1");	// Percent of the damage a wallbang is really doing (0 = No damage, 1 = Full Damage (100%))
	setDvar("scr_mod_expbolt_damage", "300");	// Max Damage the explosive bolt is doing in center of its explosion radius
	setDvar("scr_mod_parachutespawn", "1");	// 0 = Disabled, 1 = Enabled
	setDvar("scr_mod_deathtire", "0");	// Bouncing tire at the position the player died
	setDvar("scr_mod_gore", "1");	// Gore when a player gets killed with a direct impact of an explosive crossbow
	setDvar("scr_mod_daynight", "0");		// 0= Disable, 1= Enable the day-night-cycle
	setDvar("scr_mod_current_time", "00:00");	// current time (WARNING! Changeable when server is offline only!)
	setDvar("scr_mod_xpmulti", "1");	// A multiplicator for xp for kills/challenges and so on.
	setDvar("scr_mod_xpmulti_vip", "1.5");	// A multiplicator for xp for kills/challenges and so on (vip only - not on top of "scr_mod_xpmulti").
	setDvar("scr_mod_minigun_overheat", "1");	// 0 = Disabled, 1 = Enabled
	setDvar("scr_mod_minigun_minheat", "60");	// The heat the player can start to shoot again (default = 60)
	setDvar("scr_mod_minigun_maxheat", "110");	// The heat the minigun gets locked and needs a cooldown (default = 110)
	setDvar("scr_mod_minigun_overheatrate", "1.5");	// Multiplikator of the overheat (default = 1.5)
	setDvar("scr_mod_minigun_cooldownrate", "0.95");	// Multiplikator of the cooldown (default = 0.95)
	setDvar("scr_mod_katana_damage", "200"); // the damage the katana is doing
	setDvar("scr_mod_assassins", "knife;bolt;scope;strongscope;hardscope;katana");	// the different classes for assassins (allowed: knife, bolt, scope, strongscope, hardscope and katana)
	setDvar("scr_mod_explosive_barrels", "1");	// 0 = Disabled, 1 = Enabled (Disabled replaces the barrels with non explosive barrels)
	setDvar("scr_mod_explosive_cars", "1");	// 0 = Disabled, 1 = Enabled (Disabled replaces the barrels with non explosive cars)
	setDvar("scr_mod_turrets", "0");	// 0 = Disabled, 1 = Enabled (Disabled removes all turrets from the map)
	setDvar("scr_mod_quickmessages", "0");	// 0 = Disabled, 1 = Callout only, 2 = Chat only, 3 = Callout + Chat (default = 3)
	setDvar("scr_mod_targetmarkers", "1");	// 0 = Disabled, 1 = Enabled (Mark enemies on the map with a red arrow when in an ac130, helicopter or predator)
	setDvar("scr_mod_glowXpText", "1");	// 0 = Disabled, 1 = Enabled (Glowing +10 etc. messages)
	setDvar("scr_mod_glowXpText_suicide", "1 0 0");	//RGB from 0-1 (default = "1 0 0")
	setDvar("scr_mod_glowXpText_assist", "1 0.502 0.251");	//RGB from 0-1 (default = "1 0.502 0.251")
	setDvar("scr_mod_glowXpText_kill", "0 0.6 1");	 //RGB from 0-1 (default = "0 0.6 1")
	setDvar("scr_mod_javelin_ammo", "3"); //The times a javelin can be fired
	setDvar("scr_mod_javelin_locktime", "0.6"); // the time between the lock stages (there are 3 stages; in 3 stage we can fire the javelin)
	setDvar("scr_mod_WelcomeMsgBold", "EVERY SUNDAY WE START A CUSTOM EVENT - BE THERE ;)"); //a short welcome message that will appear on the players screen
	setDvar("scr_mod_maprecords", "1");	//show the best players after the map
	setDvar("scr_mod_blockChallengeReset", "1"); //0 = players can reset and redo finished challenges, 1 = No reset
	setDvar("scr_mod_fastfireprotect", "1"); //0 = Disable, 1 = Enable the check for fast fire/weaponchange scripts
}