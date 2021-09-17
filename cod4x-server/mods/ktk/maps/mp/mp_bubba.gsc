main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_bubba");
		
	thread mappa_by();
	thread maps\mp\mp_bubba_mip::main();	 
		
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	setdvar( "r_specularcolorscale", "1" );
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");
}

mappa_by()
{
	for(;;)
	{
		wait 30;
		iPrintLn("^3Bubba by ^2bre ^3& ^2buba ^3& ^2duck");
	}
}
