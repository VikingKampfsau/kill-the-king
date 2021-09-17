init()
{
	setDvar("sv_hostname", "^0[Ninja]^5Kill the King ^1| ^7KTK ^12.20 (June 2018)");
	 
	setDvar("scr_mod_healthregen", "0");
	setDvar("scr_mod_news_3", "^2TANK ^5KING ^1EVENT!!!");
	setDvar("scr_motd", "^2TANK ^5KING ^1EVENT!!! ^7event by ^0[Ninja]^1!");
	setDvar("scr_mod_WelcomeMsgBold", "TANK KING EVENT! ^1THE KING HAS INSANE HP!");

	setDvar("scr_mod_ktk_roundevents", "0");

	setDvar("sv_mapRotation", "gametype ktk map mp_shipment");

	setDvar("scr_mod_mapvote_playerbased", "1");
	setDvar("rotation_few_players_amount", "10");
	setDvar("rotation_some_players_amount", "18");

	setDvar("rotation_few_players", "mp_killhouse;mp_shipment;mp_showdown;mp_bazaar;mp_construction_arena;mp_custule;mp_funland;mp_lake;mp_modern_rust;mp_new2k13;mp_ninja_hill;mp_ninja_maze;mp_ninja_seasons;mp_nuketown;mp_overlook;mp_poolparty;mp_portalhouse;mp_shipment3;mp_uber;mp_uprise;mp_wawa;mp_zomarena_final");
	setDvar("rotation_some_players", "mp_bog;mp_crash;mp_showdown;mp_anchorage;mp_battlearena;mp_bazaar;mp_c4s_minecraft;mp_castle_v1;mp_construction_arena;cube;mp_funland;mp_lake;maze1;mp_modern_rust;mp_new2k13;mp_ninja_forts;mp_ninja_hill;mp_ninja_seasons;mp_nuketown;mp_osg_hijacked;mp_poolparty;mp_qlimax_aim;mp_shipment3;mp_toujane_v2;mp_toybox4_b2;mp_uber;mp_uprise;mp_wawa;mp_zomarena_final;mp_zombie_ski");
	setDvar("rotation_many_players", "mp_backlot;mp_bog;mp_crash;mp_strike;mp_showdown;mp_battlearena;mp_bo2mir;mp_bo2raid;mp_c4s_minecraft;mp_castle_v1;cube;mp_d2c;mp_hunt;mp_legotown;maze1;mp_meanstreet2;mp_mw2_term;mp_ninja_forts;mp_ninja_hill;mp_nuketown;mp_offices_v3;mp_osg_hijacked;mp_qlimax_aim;mp_toujane_v2;mp_toybox4_b2;mp_uber;mp_zombie_glass");

	setDvar("scr_ktk_timelimit", "10");
	setDvar("scr_ktk_roundlimit", "5");
	setDvar("scr_ktk_roundswitch", "2");
	setDvar("scr_ktk_king_health", "15000");
	setDvar("scr_ktk_dog_damage", "300");
	setDvar("scr_ktk_terminator", "0");
	setDvar("scr_ktk_assassin_switch", "0");
	setDvar("scr_ktk_ah6_repeatdelay", "30");
	setDvar("scr_ktk_kinghealthbar", "0");
	setDvar("scr_king_primary", "ak47_mp");
	setDvar("scr_king_secondary", "p90_silencer_mp");
	setDvar("scr_assassin_secondary", "m40a3_mp");
	setDvar("scr_ktk_numlives", "0");

	setDvar("scr_hardpoint_guard_rccar", "0");
	setDvar("scr_hardpoint_guard_poison", "0");
	setDvar("scr_hardpoint_guard_airstrike", "0");
	setDvar("scr_hardpoint_guard_mortar", "0");
	setDvar("scr_hardpoint_guard_helicopter", "0");
	setDvar("scr_hardpoint_guard_ac130", "0");
	setDvar("scr_hardpoint_juggernaut", "0");
	setDvar("scr_hardpoint_assassin_m21", "0");
	setDvar("scr_hardpoint_dogpoop", "0");
	setDvar("scr_hardpoint_guard_juggernaut", "0");
	setDvar("scr_hardpoint_carepackage", "0");
	setDvar("scr_hardpoint_carepackage_killtype", "1");

	setDvar("scr_hardpoint_king_1", "weapon;saw_acog_mp;50");
	setDvar("scr_hardpoint_king_2", "hardpoint;ac130;100");
	setDvar("scr_hardpoint_king_3", "hardpoint;nuke;150");

	setDvar("scr_hardpoint_guard_SentryGun", "0");
	setDvar("scr_hardpoint_guard_Predator", "0");
	setDvar("scr_hardpoint_guard_Nuke", "0");



	setDvar("scr_mod_weaponbox_priceGuards", "20");
	setDvar("scr_mod_weaponbox_priceAssassins", "20");

	setDvar("scr_mod_weaponbox_assassinweapon_1", "c4_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_2", "m21_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_3", "skorpion_silencer_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_4", "knife_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_5", "remington700_acog_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_6", "remington700_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_7", "m40a3_acog_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_8", "m40a3_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_9", "tripwire");
	setDvar("scr_mod_weaponbox_assassinweapon_10", "frag_grenade_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_11", "beretta_silencer_mp");
}