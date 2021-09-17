main()
{
	if(getDvar("scr_devtool") == "") setDvar("scr_devtool", 0);

	if( getDvar( "mapname" ) == "mp_background" )
		return; // this isn't required...

	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;
	level.callbackPlayerLastStand = ::Callback_PlayerLastStand;
	
	level.script = "";
	level.trigger = undefined;
	level.specMode = false;
	level.triggers = [];
	level.noClip = false;
	
	precacheMenu("clientcmd");
	precacheModel("body_complete_mp_kennedy");
}

Callback_StartGameType()
{
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	
	level.teamSpawnPoints["axis"] = [];
	level.teamSpawnPoints["allies"] = [];
	
	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );
	
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_allies_start" );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_axis_start" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["defenders"], "mp_tdm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["attackers"], "mp_tdm_spawn" );
	
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
		
	allowed[0] = "war";
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	thread maps\mp\gametypes\_devtools::init();
	if(getDvarInt("scr_devtool"))
	{
		thread maps\mp\gametypes\_ac130::init();
		thread maps\mp\gametypes\_antiglitch::init();
		thread maps\mp\gametypes\_language::init();
		thread maps\mp\gametypes\_helipath::init();
		thread maps\mp\gametypes\_ladders::init();
		thread maps\mp\_helicopter::init();
	}
}


Callback_PlayerConnect()
{
	self.statusicon = "";
	self waittill("begin");

	if(getDvarInt("scr_devtool"))
		initEditor();
}


Callback_PlayerDisconnect()
{
	return;
}


Callback_PlayerLastStand( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	return;
}


Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	return;
}


Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
	return;
}

initEditor()
{
	self setClientDvars( "cg_drawSpectatorMessages", 1,
						 "ui_hud_hardcore", 0,
						 "player_sprintTime", 3,
						 "ui_uav_client", 0,
						 "g_scriptMainMenu", "team_marinesopfor",
						 "developer", 1,
						 "developer_script", 1);
	
	self.sessionteam = "allies";
	self setmodel("body_complete_mp_kennedy");

	wait .5;

	spawns = getentarray("mp_tdm_spawn", "classname");
	spawn = spawns[randomint(spawns.size)];
	
	self.sessionstate = "playing";
	self.maxhealth = 100;
	self.health = 100;
	
	self spawn( spawn.origin, spawn.angles );
	self giveWeapon("colt45_mp");
	self setSpawnWeapon("colt45_mp");
	
	if(getDvar("scr_devtool_edit") == "ladders")
		self thread maps\mp\gametypes\_devtools::LadderPlaceTool();
	else if(getDvar("scr_devtool_edit") == "blockers")
		self thread maps\mp\gametypes\_devtools::BlockerPlaceTool();
	else if(getDvar("scr_devtool_edit") == "triggers")
		self thread maps\mp\gametypes\_devtools::BlockerPlaceTool();
	else if(getDvar("scr_devtool_edit") == "lasers")
		self thread maps\mp\gametypes\_devtools::LaserPlaceTool();
	else if(getDvar("scr_devtool_edit") == "waypoints")
		self thread maps\mp\gametypes\_devtools::WaypointTool();
}