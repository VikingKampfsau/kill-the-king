init()
{
	//==============================================================================
	// Maprotation
	//==============================================================================
	// if the mapvote is disabled
	//setDvar("sv_mapRotation", "gametype ktk map mp_backlot map mp_bloc map mp_bog map mp_carentan map mp_cargoship map mp_convoy map mp_countdown map mp_crash map mp_crash_snow map mp_creek map mp_farm map mp_killhouse map mp_overgrown map mp_pipeline map mp_shipment map mp_showdown map mp_strike map mp_bacalao map mp_bazaar map mp_brecourt_v2 map mp_castle_v1 map mp_compact map mp_ctan map mp_d2c map mp_fabrika map mp_invade map mp_legotown map mp_meanstreet2 map mp_naout_n map mp_waldcamp");

	// if the mapvote is activated
	setDvar("rotation", "mp_backlot;mp_bloc;mp_bog;mp_broadcast;mp_carentan;mp_cargoship;mp_citystreets;mp_convoy;mp_countdown;mp_crash;mp_crash_snow;mp_creek;mp_crossfire;mp_farm;mp_killhouse;mp_overgrown;mp_pipeline;mp_shipment;mp_showdown;mp_strike;mp_vacant;cube;lolzor;lolzor2;maze1;mp_4nuketown;mp_4t4scrap;mp_aerodrome;mp_airstrike_v1;mp_al_jabal;mp_anchorage;mp_ancient_final;mp_aosta_valley;mp_area52;mp_argel;mp_arkona;mp_asylum;mp_atp;mp_ava_crossroads;mp_bacalao;mp_backlot_2;mp_bastogne;mp_battlearena;mp_bazaar;mp_berry_village;mp_beta;mp_blackrock;mp_bo2cargom;mp_bo2carrier;mp_bo2drone;mp_bo2hydro;mp_bo2meltdown2;mp_bo2mir;mp_bo2nuketown;mp_bo2paintball;mp_bo2raid;mp_bo2standoff;mp_bo2turbine;mp_bo2yemen;mp_boxfight;mp_box_hjacked;mp_bridge;mp_bridge2011;mp_bubba;mp_burck;mp_burg;mp_burgundy_bulls;mp_c4s_minecraft;mp_caen;mp_castle_v1;mp_circulus;mp_colour;mp_compact;mp_compound_base;mp_crash3;mp_ctan;mp_damnalley;mp_disputed;mp_dome;mp_dooerte;mp_doohouse;mp_doowntown;mp_doowood;mp_drillco;mp_dust2_classic;mp_dust3;mp_dustcod4;mp_fabrika;mp_fav;mp_firingrange_v2;mp_forlorn;mp_foxhunt_ruins;mp_gob_aim_snow;mp_grinder;mp_hhk_ballroom;mp_highrise;mp_hims;mp_hisar;mp_hunt;mp_iceworld;mp_inferno;mp_inv;mp_invade;mp_karachi;mp_karrak;mp_kh1;mp_killhouse_2;mp_kk_arena;mp_lake;mp_lalus_poolday;mp_laugh;mp_lego_rgb;mp_legotown;mp_lgc_knifefight;mp_lolv2;mp_lpost;mp_luna;mp_marketcenter;mp_matroska;mp_maze;mp_meanstreet2;mp_modern_rust;mp_mw2_term;mp_naout;mp_ninja_caveslide;mp_ninja_chickencastle;mp_ninja_copter;mp_ninja_fightland;mp_ninja_forts;mp_ninja_halfpipe;mp_ninja_hill;mp_ninja_lolratz;mp_ninjalolzor;mp_ninja_madness;mp_ninja_maze;mp_ninja_poolday;mp_ninja_rooms;mp_ninja_seasons;mp_nuketown;mp_oldschool;mp_onslaught;mp_outset;mp_pillar;mp_poolday;mp_poolday_reunion;mp_poolday_v2;mp_poolparty;mp_portalhouse;mp_prison;mp_prunis;mp_psycho;mp_pussthecat_org_l;mp_qlimax_aim;mp_renan_bridge4;mp_roof;mp_rooftops;mp_roundup;mp_ruins;mp_sbase;mp_sc_hangar;mp_school;mp_shaft;mp_shaftv2;mp_shipment2;mp_shipment3;mp_shipmentx2;mp_simpsons;mp_skidrow;mp_slide;mp_southpark;mp_steamlab;mp_summit;mp_swamp;mp_teacher;mp_tetris;mp_toujane_v2;mp_toybox4;mp_treasure;mp_v2_b1;mp_vukovar;mp_waldcamp;mp_wawa;mp_wawa_3daim4;mp_wizard;mp_zaseda;mp_zom_box_fun");

	// if the playerbased mapvote is enabled 
	setDvar("scr_mod_mapvote_playerbased", "0"); 	// 0 = Disabled, 1 = Set up 3 rotationtypes depending on the amount of players on the server during the vote 
	setDvar("rotation_few_players_amount", "7");	//if the player amount is smaller than this it will use the rotation for a "few players" 
	setDvar("rotation_some_players_amount", "15"); 	//if the player amount is smaller than this but bigger than the one for a "few players" it will use the rotation for "some players", otherwise the one for "many players"

	setDvar("rotation_few_players", "mp_killhouse;mp_shipment;mp_bazaar;mp_blue_rdc;mp_boxfight;mp_checkers;mp_construction;mp_construction_arena;mp_custule;mp_damnalley;mp_dooerte;mp_frisco_2;mp_funland;mp_iceworld;mp_killhouse_2;mp_lake;lolzor;mp_minecraft_new;mp_modern_rust;mp_new2k13;mp_ninja_hill;mp_ninja_madness;mp_ninja_maze;mp_ninja_seasons;mp_nuketown;mp_overlook;mp_poolday;mp_poolparty;mp_portalhouse;mp_shipment3;mp_teacher;mp_tetris;mp_uber;mp_uprise;mp_zomarena_final");
	setDvar("rotation_some_players", "mp_bog;mp_crash;mp_killhouse;mp_showdown;mp_anchorage;mp_battlearena;mp_bazaar;mp_bo2carrier;mp_boxfight;mp_blue_rdc;mp_c4s_minecraft;mp_castle_v1;mp_checkers;mp_construction;mp_construction_arena;cube;mp_damnalley;mp_dooerte;mp_frisco_2;mp_funland;mp_killhouse_2;mp_lake;lolzor;mp_minecraft_new;maze1;mp_modern_rust;mp_new2k13;mp_ninja_forts;mp_ninja_hill;mp_ninja_madness;mp_ninja_seasons;mp_nuketown;mp_osg_hijacked;mp_pacmaze;mp_poolday;mp_poolparty;mp_shipment3;mp_teacher;mp_tetris;mp_toujane_beta;mp_toujane_v2;mp_toybox4_b2;mp_uber;mp_uprise;mp_vertigo;mp_wawa;mp_zom_anticamper;mp_zom_streets_final;mp_zomarena_final;mp_zombie_ski");
	setDvar("rotation_many_players", "mp_backlot;mp_bog;mp_crash;mp_strike;mp_showdown;mp_battlearena;mp_beta;mp_blue_rdc;mp_bo2carrier;mp_bo2mir;mp_bo2raid;mp_c4s_minecraft;mp_castle_v1;mp_checkers;cube;mp_d2c;mp_damnalley;mp_dooerte;mp_fav;mp_firingrange_v2;mp_frisco_2;mp_fubar;mp_highrise;mp_hunt;mp_killhouse_v2;mp_legotown;maze1;mp_meanstreet2;mp_minecraft_new;mp_mw2_term;mp_ninja_forts;mp_ninja_hill;mp_nuketown;mp_offices_v3;mp_osg_hijacked;mp_pacmaze;mp_poolday;mp_shipment3;mp_tacticalretreat;mp_teacher;mp_toujane_beta;mp_toujane_v2;mp_toybox4_b2;mp_vertigo;mp_vil_blops;mp_uber;mp_zom_anticamper;mp_zom_streets_final;mp_zombie_glass");

	//==============================================================================
	// Gametypesettings 
	//==============================================================================
	//Weaponpickups in the map (like poolday)
	setDvar("scr_map_weaponpickups", "0");	// 0 = Disabled, 1 = Enabled 

	//Kill the King - Classic
	setDvar("scr_ktk_timelimit", "3");	// time in minutes a round last for (default = 3)
	setDvar("scr_ktk_scorelimit", "0");	// max score to end the round (keep it 0)
	setDvar("scr_ktk_roundlimit", "4");	// maximum rounds per map (default = 10)
	setDvar("scr_ktk_roundswitch", "2");	// number of rounds to play until the players switch sides (use the half of scr_ktk_roundlimit!) (default = 5)
	setDvar("scr_ktk_numlives", "0");	// amount if lives a player has (keep it 0 unless you want players not to respawn)
	setDvar("scr_ktk_dog", "1");			// 0 = Disabled, 1 = Enabled
	setDvar("scr_ktk_king_health", "500");	//default = 300
	setDvar("scr_ktk_dog_players", "5");	//needed amount of guards to pick a dog
	setDvar("scr_ktk_dog_health", "80");	//default = 80
	setDvar("scr_ktk_dog_damage", "100");	//the damage the dog is doing
	setDvar("scr_ktk_terminator", "1");		// 0 = Disabled, 1 = Robot-Model, 2 = Juggernaut-Model
	setDvar("scr_ktk_terminator_delay", "2.5");	//delay in minutes till the terminator gets picked
	setDvar("scr_ktk_terminator_health", "400");	//default = 400
	setDvar("scr_ktk_terminator_players", "5");	//needed amount of assassins to pick a terminator
	setDvar("scr_ktk_assassin_switch", "2");	// Assassin switches team after the king killed him (0 = Never, 1 = When knifed, 2 = When shot or knifed
	setDvar("scr_ktk_allow_ah6", "0");	//calls in a ah6 when the king is last guard alive (0 = disabled, 1 = enabled)
	setDvar("scr_ktk_ah6_repeat", "1");	//how often the ah6 will appear when the king is last (0 = only once, 1 = always)
	setDvar("scr_ktk_ah6_repeatdelay", "30");	//time in seconds before a new ah6 enters the map
	setDvar("scr_ktk_kinghealthbar", "1");	//shows the health of the king under his name
	setDvar("scr_king_primary", "m1014_mp");	//check the weapons.txt withing the readme folder
	setDvar("scr_king_secondary", "beretta_silencer_mp");	//check the weapons.txt withing the readme folder
	setDvar("scr_assassin_primary", "gl_mp");	//check the weapons.txt withing the readme folder
	setDvar("scr_assassin_secondary", "m40a3_mp");	//check the weapons.txt withing the readme folder
	setDvar("scr_assassin_explosive_teamSize", "6");	//team size of the assassins until the main assassin gets only 1 explosive arrow instead of 3
	setDvar("scr_ktk_picknewkingtime", "30");	//Within this time a new king will be picked if the current king disconnects (if 0 the assassin win the round and a new one starts)
	setDvar("scr_ktk_kingGungame", "0");	// King taking part in gungame 0 = NO, 1 = YES
	setDvar("scr_ktk_GuardSwitchType", "0");	//Define when a guard becomes an assassin, 0 = on every death, 1 = only when killed by the main assassin
	setDvar("scr_ktk_AssassinSwitchType", "1");	//Define when an assassin becomes a guard, 0 = on every death, 1 = only when killed by the king
	setDvar("scr_ktk_maxZiplines", "10");	//Max amount of ziplines

	setDvar("scr_ktk_noDogMaps", "mp_fav;mp_legotown;mp_uprise");	//Disables the dog for this maps
	setDvar("scr_ktk_noTerminatorMaps", "mp_shipment;mp_c4s_minecraft;lolzor");	//Disables the terminator for this maps
	setDvar("scr_ktk_noRCCarMaps", "");	//Disables the RC-XD on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noPoisonMaps", "");	//Disables the poison grenade on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noCPMaps", "");	//Disables the carepackage on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noAirstrikeMaps", "");	//Disables the airstrike on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noMortarMaps", "");	//Disables the mortars on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noHeliMaps", "");	//Disables the helicopter on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noAc130Maps", "");	//Disables the ac130 on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noSentrygunMaps", "");	//Disables the sentry gun on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noPredatorMaps", "");	//Disables the predator on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noNukeMaps", "");	//Disables the nuke on this maps (example: "mp_test;mp_test2")
	setDvar("scr_ktk_noJuggernautMaps", "");	//Disables the juggernaut (hardpoint) on this maps (example: "mp_test;mp_test2")
}
