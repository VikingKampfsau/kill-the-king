choose()
{
	level.waypointCount = 0;
	level.waypoints = [];
	
	if(level.script == "mp_backlot")
		waypoints\mp_backlot_waypoints::load_waypoints();
 	else if(level.script == "mp_bog")
		waypoints\mp_bog_waypoints::load_waypoints();
 	else if(level.script == "mp_crash")
		waypoints\mp_crash_waypoints::load_waypoints();
 	else if(level.script == "mp_killhouse")
		waypoints\mp_killhouse_waypoints::load_waypoints();
 	else if(level.script == "mp_strike")
		waypoints\mp_strike_waypoints::load_waypoints();
 	else if(level.script == "mp_showdown")
		waypoints\mp_showdown_waypoints::load_waypoints();
 	else if(level.script == "mp_anchorage")
		waypoints\mp_anchorage_waypoints::load_waypoints();
 	else if(level.script == "mp_bo2mir")
		waypoints\mp_bo2mir_waypoints::load_waypoints();
 	else if(level.script == "mp_bo2raid")
		waypoints\mp_bo2raid_waypoints::load_waypoints();
 	else if(level.script == "mp_c4s_minecraft")
		waypoints\mp_c4s_minecraft_waypoints::load_waypoints();
 	else if(level.script == "mp_castle_v1")
		waypoints\mp_castle_v1_waypoints::load_waypoints();
 	else if(level.script == "cube")
		waypoints\cube_waypoints::load_waypoints();
 	else if(level.script == "mp_d2c")
		waypoints\mp_d2c_waypoints::load_waypoints();
 	else if(level.script == "mp_fav")
		waypoints\mp_fav_waypoints::load_waypoints();
 	else if(level.script == "mp_firingrange_v2")
		waypoints\mp_firingrange_v2_waypoints::load_waypoints();
 	else if(level.script == "mp_highrise")
		waypoints\mp_highrise_waypoints::load_waypoints();
 	else if(level.script == "mp_iceworld")
		waypoints\mp_iceworld_waypoints::load_waypoints();
 	else if(level.script == "mp_lake")
		waypoints\mp_lake_waypoints::load_waypoints();
 	else if(level.script == "mp_lego_rgb")
		waypoints\mp_lego_rgb_waypoints::load_waypoints();
 	else if(level.script == "lolzor")
		waypoints\lolzor_waypoints::load_waypoints();
 	else if(level.script == "maze1")
		waypoints\maze1_waypoints::load_waypoints();
 	else if(level.script == "mp_mw2_term")
		waypoints\mp_mw2_term_waypoints::load_waypoints();
 	else if(level.script == "mp_modern_rust")
		waypoints\mp_modern_rust_waypoints::load_waypoints();
 	else if(level.script == "mp_ninja_hill")
		waypoints\mp_ninja_hill_waypoints::load_waypoints();
 	else if(level.script == "mp_nuketown")
		waypoints\mp_nuketown_waypoints::load_waypoints();
 	else if(level.script == "mp_poolday")
		waypoints\mp_poolday_waypoints::load_waypoints();
 	else if(level.script == "mp_poolparty")
		waypoints\mp_poolparty_waypoints::load_waypoints();
 	else if(level.script == "mp_tetris")
		waypoints\mp_tetris_waypoints::load_waypoints();
 	else if(level.script == "mp_toujane_beta")
		waypoints\mp_toujane_beta_waypoints::load_waypoints();
 	else if(level.script == "mp_toujane_v2")
		waypoints\mp_toujane_v2_waypoints::load_waypoints();
 	else if(level.script == "mp_wawa")
		waypoints\mp_wawa_waypoints::load_waypoints();
}
