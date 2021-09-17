init()
{
	//==============================================================================
	// Hardpoints 
	//==============================================================================

	setDvar("scr_hardpoint_helicoptertype", "1"); // 0 = Original cod4 heli, 1 = Player as gunner
	setDvar("scr_hardpoint_repeat", "1"); // repeats hardpoints after the player reached the last (0 = Disabled, 1 = Enabled)
setDvar("scr_hardpoint_persists", "1"); // players get unused hardpoints when connecting next time (0 = Disabled, 1 = Enabled and saves hardpoints on every round end, 2 = Enabled but saves hardpoints on last round end only)
setDvar("scr_hardpoint_system", "1"); // 0 = Players can earn ALL hardpoints, 1 = Players have to select up to 3 hardpoints and can only earn these (default = 0)
	setDvar("scr_hardpoint_kingsystem", "0"); //The king also uses the new hardpoint system (0 = No, define the killstreaks yourself, 1 = Yes)

	setDvar("scr_hardpoint_rc_heli_health", "100");
	setDvar("scr_hardpoint_rc_heli_alivetime", "20");
	setDvar("scr_hardpoint_rc_heli_reloadtime", "2");
	setDvar("scr_hardpoint_rc_heli_ammo", "100");

	// 0 = disabled, > 0 = needed amount of kills
	setDvar("scr_hardpoint_guard_rccar", "3");
	setDvar("scr_hardpoint_guard_rchelicopter", "3");
	setDvar("scr_hardpoint_guard_poison", "5");
	setDvar("scr_hardpoint_guard_airstrike", "7");
	setDvar("scr_hardpoint_guard_mortar", "9");
	setDvar("scr_hardpoint_guard_helicopter", "12");
	setDvar("scr_hardpoint_guard_ac130", "18");
	setDvar("scr_hardpoint_juggernaut", "8");
	setDvar("scr_hardpoint_assassin_m21", "3");
	setDvar("scr_hardpoint_dogpoop", "3");
	setDvar("scr_hardpoint_carepackage", "5");
	setDvar("scr_hardpoint_carepackage_ownerpick", "1");		//Time the owner needs to open the crate
	setDvar("scr_hardpoint_carepackage_playerpick", "3");		//Time any player needs to steal the crate
	setDvar("scr_hardpoint_carepackage_killtype", "2");		//Defines who dies when getting hit by the crate (0=nobody, 1=enemies only, 2=everybody)
	setDvar("scr_hardpoint_carepackage_stealtype", "2");		//Defines who is able to steal crates (0=nobody, 1=team only, 2=enemies only, 3=everybody)
	setDvar("scr_hardpoint_nukeTimer", "10");		//Time till the nuke explodes after the launch
	setDvar("scr_hardpoint_predator_time", "10");		//Max Flytime
	setDvar("scr_hardpoint_predator_speed", "70");		//Flyspeed
	setDvar("scr_hardpoint_sentry_rotation", "120");		//max rotation angles (divide by 2 for each side)
	setDvar("scr_hardpoint_sentry_health", "1000");	//health (melee is insta kill)
	setDvar("scr_hardpoint_sentry_aimdist", "3000");	//distance to detect enemies
	setDvar("scr_hardpoint_sentry_aimheight", "1000");	//max height it can detect enemies in
	setDvar("scr_hardpoint_sentry_firedelay", "0.05");	//delay between 2 shots
	setDvar("scr_hardpoint_sentry_maxamount", "5");		//max amount of turrets in map
	setDvar("scr_hardpoint_sentry_time", "30");		//time the turret is active until self destruction
	setDvar("scr_hardpoint_juggernaut_healthAssassins", "500");		//health of the juggernaut (default = 500)
	setDvar("scr_hardpoint_juggernaut_healthGuards", "300");		//health of the juggernaut (default = 300)

	// Hardpoints for the king (only if hardpoint system is set to 0)
	// how to use: set scr_hardpoint_king_1 "type;name;killstreak"
	// example: set scr_hardpoint_king_1 "perk;fastreload;3"
	setDvar("scr_hardpoint_king_1", "perk;fastreload;3");
	setDvar("scr_hardpoint_king_2", "hardpoint;airstrike;5");
	setDvar("scr_hardpoint_king_3", "weapon;ak47;9");
	
	setDvar("scr_hardpoint_king_4", ""); //empty all that were used by an event
	//Add as many as you want

	//only working when the hardpoint system is set to 1
	setDvar("scr_hardpoint_guard_SentryGun", "24");
	setDvar("scr_hardpoint_guard_Predator", "30");
	setDvar("scr_hardpoint_guard_Nuke", "45");

	//change the percentages of the carepackage contents for each team
	//note: the sum for each team has to be 100!
	setDvar("scr_hardpoint_carepackage_guards_ac130", "7"); 	//default = 7
	setDvar("scr_hardpoint_carepackage_guards_airstrike", "12"); 	//default = 12
	setDvar("scr_hardpoint_carepackage_guards_decoy", "11"); 	//default = 11
	setDvar("scr_hardpoint_carepackage_guards_heli", "8"); 	//default = 8
	setDvar("scr_hardpoint_carepackage_guards_juggernaut", "8"); 	//default = 8
	setDvar("scr_hardpoint_carepackage_guards_mortar", "12"); 	//default = 12
	setDvar("scr_hardpoint_carepackage_guards_nuke", "1"); 	//default = 1
	setDvar("scr_hardpoint_carepackage_guards_predator", "11"); 	//default = 11
	setDvar("scr_hardpoint_carepackage_guards_rccar", "13"); 	//default = 13
	setDvar("scr_hardpoint_carepackage_guards_sentrygun", "8"); 	//default = 8
	setDvar("scr_hardpoint_carepackage_guards_tripwire", "9"); 	//default = 9

	setDvar("scr_hardpoint_carepackage_assassins_magnum", "35"); 	//default = 35
	setDvar("scr_hardpoint_carepackage_assassins_crossbowExp", "15"); 	//default = 15
	setDvar("scr_hardpoint_carepackage_assassins_fakeguard", "15"); 	//default = 15
	setDvar("scr_hardpoint_carepackage_assassins_javelin", "15"); 	//default = 15
	setDvar("scr_hardpoint_carepackage_assassins_juggernaut", "19"); 	//default = 19
	setDvar("scr_hardpoint_carepackage_assassins_nuke", "1"); 	//default = 1
}