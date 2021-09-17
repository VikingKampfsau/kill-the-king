//////////////////////////////////////////////////////////////
////   /// ///  //  /////  //////     //      ////////////
////   /  ////////  /////  /////////  //  //   /////////////////////
////     /////  //  /////  //////     //      ///////////////////
////     /////  //  /////  /////////  //  /  ///////////////
////   //  ///  //  /////  //////     //  //  /////////////////
////   /// ///  //     //      /////////  ///  ////////
/////////////////////////////////////////////////////////////////////
//Xfire: zak4000
//E-Mail: zak4000@gmail.com

#include maps\mp\gametypes\_misc;

main()
{
	level.tweakfile = true;
	setdvar("scr_fog_disable", "0");
	VisionSetNaked("lolzor", 0);

	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_lolzor");
	thread maps\mp\_explosive_barrels::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setdvar("r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");

	setdvar("compassmaxrange","700");
	
	//Viking - Fixed the rotation of the spectator spawn
	spectatorSpawns = getentarray("mp_global_intermission", "classname");
	
	if(spectatorSpawns.size > 0)
	{
		for(i=0;i<spectatorSpawns.size;i++)
			spectatorSpawns[i].angles = (0,0,0);
	}
	
	thread antiSpawnrape();
}

//Viking
antiSpawnrape()
{
	level.antiSpawnrape_triggers = [];
	level.antiSpawnrape_triggers[0] = spawn("trigger_radius", (  73, 461, -480), 0, 70, 120);
	level.antiSpawnrape_triggers[1] = spawn("trigger_radius", (-180, 707, -480), 0, 70, 120);
	level.antiSpawnrape_triggers[2] = spawn("trigger_radius", (-415, 460, -480), 0, 70, 120);
	
	for(i=0;i<level.antiSpawnrape_triggers.size;i++)
		level.antiSpawnrape_triggers[i] thread blockCorridors();
		
	thread trackRPGS();
	thread trackGrenades();
}

blockCorridors()
{
	while(1)
	{
		self waittill("trigger", player);
		
		if(isDefined(player.pers["team"]) && player.pers["team"] == game["defenders"])
		{
			if(!player isABot())
			{
				scr_iPrintLnBold("SPAWNPROTECTION_GUARD_IN_ASSASSINAREA", player);	
			
				if(player getStance() != "stand")
					player thread forceStandUp();

				player thread bouncePlayer((player.origin - self.origin), 100);
			}
			else
			{
				spawnPoints = getentarray("mp_tdm_spawn_" + player.pers["team"] + "_start", "classname");

				if(!spawnPoints.size)
					spawnPoints = getentarray("mp_sab_spawn_" + player.pers["team"] + "_start", "classname");
				
				if(!spawnPoints.size)
				{
					spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(player.pers["team"]);
					spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnPoints);
					spawnPoint = spawnPoint.origin;
				}
				else
				{
					spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnPoints);
					spawnPoint = spawnPoint.origin;
				}
				
				if(isDefined(spawnPoint))
					player setOrigin(spawnPoint);
				else
					player suicide();
			}
		}
	}
}

forceStandUp()
{
	self endon("disconnect");
	self endon("death");

	if(isDefined(self.isForcedToStandUp))
		return;
	
	self thread resetVarOnDeath();
	
	self.isForcedToStandUp = true;
	
	//self setStance("stand");
	self execClientCommand("+gostand; wait .5; -gostand");
	self setOrigin(self.origin + (0,0,10));
	wait .1;
	self freezeControls(true);
	wait .5;
	self freezeControls(false);
	
	self.isForcedToStandUp = undefined;
}

resetVarOnDeath()
{
	self endon("disconnect");
	self waittill("death");
	
	self.isForcedToStandUp = undefined;
}

trackRPGS()
{
	while(1)
	{
		wait .05;

		level.rpg_rockets = getentarray("rocket", "classname");
		
		if(level.rpg_rockets.size > 0)
		{
			for(i=0;i<level.rpg_rockets.size;i++)
			{
				for(j=0;j<level.antiSpawnrape_triggers.size;j++)
				{
					if(isDefined(level.rpg_rockets[i]) && level.rpg_rockets[i] isTouching(level.antiSpawnrape_triggers[j]) && !AllowedProjectile(level.rpg_rockets[i].model))
						level.rpg_rockets[i] delete();
				}
			}
		}
	}
}

trackGrenades()
{
	while(!isDefined(level.grenades))
		wait .05;

	while(1)
	{
		wait .05;

		//grenades are tracked by default and stored as level.grenades[i]
		
		if(level.grenades.size > 0)
		{
			for(i=0;i<level.grenades.size;i++)
			{
				for(j=0;j<level.antiSpawnrape_triggers.size;j++)
				{
					if(isDefined(level.grenades[i]) && level.grenades[i] isTouching(level.antiSpawnrape_triggers[j]) && !AllowedProjectile(level.grenades[i].model))
						level.grenades[i] delete();
				}
			}
		}
	}
}

AllowedProjectile(model)
{
	if(model == "projectile_bo_arrow_explosive")
		return true;
		
	if(model == "viewmodel_throwknife_mp")
		return true;
		
	return false;
}