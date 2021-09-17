init()
{
	setDvar("sv_hostname", "^0[Ninja]^5Kill the King ^1| ^7KTK ^12.20 (June 2018)");
	setDvar("scr_mod_xpmulti", "3");

	setDvar("scr_mod_news_3", "^1S^2U^3N^4D^5A^6Y ^1F^2U^3N^4D^5A^6Y^1! ^13X XP!! ^2LETS GO!!");
	setDvar("scr_mod_news_4", "^1EVENT ^2BY ^0[Ninja]^3!!");
	setDvar("scr_motd", "^1S^2U^3N^4D^5A^6Y ^1F^2U^3N^4D^5A^6Y^1! ^73X XP!");

	setDvar("scr_ktk_numlives", "0");
	setDvar("scr_mod_ktk_roundevents", "1");

	setDvar("sv_mapRotation", "gametype ktk map lolzor");


	setDvar("rotation", "mp_backlot;mp_bog;mp_crash;mp_killhouse;mp_strike;mp_showdown;mp_anchorage;mp_aosta_valley;mp_battlearena;mp_bazaar;mp_beta;mp_bo2mir;mp_bo2raid;mp_c4s_minecraft;mp_castle_v1;mp_construction;mp_construction_arena;cube;mp_d2c;mp_fav;mp_firingrange_v2;mp_fubar;mp_funland;mp_highrise;mp_hunt;mp_iceworld;mp_lake;mp_legotown;lolzor;maze1;mp_meanstreet2;mp_mw2_term;mp_modern_rust;mp_new2k13;mp_ninja_forts;mp_ninja_hill;mp_ninja_seasons;mp_nuketown;mp_offices_v3;mp_osg_hijacked;mp_pandemic_aim2;mp_poolday;mp_poolparty;mp_qlimax_aim;mp_shipment3;mp_tetris;mp_toujane_beta;mp_toujane_v2;mp_toybox4_b2;mp_uber;mp_uprise;mp_vil_blops;mp_wawa;mp_zom_anticamper;mp_zom_streets_final;mp_zomarena_final;mp_zombie_glass;mp_zombie_ski");

	setDvar("scr_mod_mapvote_playerbased", "1");
	setDvar("rotation_few_players_amount", "7");
	setDvar("rotation_some_players_amount", "15");

	setDvar("rotation_few_players", "mp_killhouse;mp_shipment;mp_bazaar;mp_construction;mp_custule;mp_iceworld;mp_lake;lolzor;mp_modern_rust;mp_ninja_hill;mp_ninja_maze;mp_nuketown;mp_poolday;mp_portalhouse;mp_shipment3;mp_uprise;mp_wawa");
	setDvar("rotation_some_players", "mp_killhouse;mp_shipment;mp_bazaar;mp_construction;mp_custule;mp_iceworld;mp_lake;lolzor;mp_modern_rust;mp_ninja_hill;mp_ninja_maze;mp_nuketown;mp_poolday;mp_portalhouse;mp_shipment3;mp_uprise;mp_wawa;mp_crash");
	setDvar("rotation_many_players", "mp_killhouse;mp_shipment;mp_bazaar;mp_construction;mp_custule;mp_iceworld;mp_lake;lolzor;mp_modern_rust;mp_ninja_hill;mp_ninja_maze;mp_nuketown;mp_poolday;mp_portalhouse;mp_shipment3;mp_uprise;mp_wawa;mp_toybox4_b2;mp_toybox4_b2;mp_crash");
}