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

init()
{
	if(game["customEvent"] != "revolt")
		return;

	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";

	if (game["allies"] == "marines")
		game["flagmodels"]["allies"] = "prop_flag_american";
	else
		game["flagmodels"]["allies"] = "prop_flag_brit";
	
	if (game["axis"] == "russian") 
		game["flagmodels"]["axis"] = "prop_flag_russian";
	else
		game["flagmodels"]["axis"] = "prop_flag_opfor";
	
	precacheModel(game["flagmodels"]["neutral"]);
	precacheModel(game["flagmodels"]["allies"]);
	precacheModel(game["flagmodels"]["axis"]);

	precacheString(&"MP_CAPTURING_FLAG");
	precacheString(&"MP_ENEMY_FLAG_CAPTURED_BY");
	
	//effects
	//"misc/ui_flagbase_silver";
	//"misc/ui_flagbase_red";
	//"misc/ui_flagbase_gold";
	//"misc/ui_flagbase_black";
	
	level.flagBaseFXid[game["attackers"]] = loadfx("misc/ui_flagbase_red");
	level.flagBaseFXid[game["defenders"]] = loadfx("misc/ui_flagbase_gold");
	
	level.flags = [];
}

createFlags()
{
	level.FlagSpawns[game["attackers"]] = [];
	level.FlagSpawns[game["defenders"]] = [];
	entities = getEntArray();
	
	//create the flags at the spawns
	for(i=0;i<entities.size;i++)
	{
		if(isDefined(entities[i].classname))
		{
			switch(entities[i].classname)
			{
				case "mp_tdm_spawn":
				case "mp_tdm_spawn_axis_start":
				case "mp_tdm_spawn_allies_start":
					
					similar = false;
					if(level.flags.size > 0)
					{
						for(j=0;j<level.flags.size;j++)
						{
							if(i==j)
								continue;
							
							if(Distance(entities[i].origin, level.flags[j].trigger.origin) <= 320)
							{
								similar = true;
								level.flags[j].nearbySpawns[level.flags[j].nearbySpawns.size] = entities[i] getEntityNumber();
								break;
							}
						}
					}
					
					if(!similar)
					{
						entryNo = level.flags.size;
						level.flags[entryNo] = spawnStruct();
						level.flags[entryNo].trigger = spawn("trigger_radius", entities[i].origin, 0, 80, 80);
						
						level.flags[entryNo].visuals = [];
						level.flags[entryNo].visuals[0] = spawn("script_model", entities[i].origin);
						level.flags[entryNo].visuals[0] setModel(game["flagmodels"]["neutral"]);
						
						level.flags[entryNo].nearbySpawns = [];
						level.flags[entryNo].nearbySpawns[0] = entities[i] getEntityNumber();
					}
					
					break;

				default: break;
			}
		}
	}
	
	level.flags = shuffleArray(level.flags);

	for(i=0;i<level.flags.size;i++)
	{
		level.flags[i].gameObject = createUseObject("neutral", level.flags[i].trigger, level.flags[i].visuals, undefined);
		
		if(!isDefined(level.flags[i].gameObject))
		{
			for(j=i;j<level.flags.size;j++)
			{
				level.flags[j].trigger delete();
				level.flags[j].visuals[0] delete();
				level.flags[j] = undefined;

			}

			level.flags = RemoveUndefinedEntriesFromArray(level.flags);

			break;
		}

		if(level.flags[i].nearbySpawns.size > 0)
		{
			for(j=0;j<level.flags[i].nearbySpawns.size;j++)
			{
				spawn = GetEntByNum(level.flags[i].nearbySpawns[j]);
				
				if(isSubStr(spawn.classname, game["attackers"] + "_start"))
				{
					level.FlagSpawns[game["attackers"]][level.FlagSpawns[game["attackers"]].size] = spawn;
				
					level.flags[i].gameObject.ownerTeam = game["attackers"];
					level.flags[i].gameObject.visuals[0] setModel(game["flagmodels"][game["attackers"]]);
				}
				else if(isSubStr(spawn.classname, game["defenders"] + "_start"))
				{
					level.FlagSpawns[game["defenders"]][level.FlagSpawns[game["defenders"]].size] = spawn;
				
					level.flags[i].gameObject.ownerTeam = game["defenders"];
					level.flags[i].gameObject.visuals[0] setModel(game["flagmodels"][game["defenders"]]);
				}
			}
		}
		
		logPrint(i + "\n");
		
		level.flags[i].gameObject maps\mp\gametypes\_gameobjects::allowUse("enemy");
		level.flags[i].gameObject maps\mp\gametypes\_gameobjects::setUseTime(8.0);
		level.flags[i].gameObject maps\mp\gametypes\_gameobjects::setUseText(&"MP_CAPTURING_FLAG");
		level.flags[i].gameObject maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", "compass_waypoint_defend" );
		level.flags[i].gameObject maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_defend" );
		
		if(level.flags[i].gameObject.ownerTeam == "neutral")
		{
			level.flags[i].gameObject maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_captureneutral" );
			level.flags[i].gameObject maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_captureneutral" );
		}
		else
		{
			level.flags[i].gameObject maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_capture" );
			level.flags[i].gameObject maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_capture" );
		}
		
		level.flags[i].gameObject.onUse = ::onUse;
		level.flags[i].gameObject.onBeginUse = ::onBeginUse;
		level.flags[i].gameObject.onEndUse = ::onEndUse;
		
		trace = bulletTrace(level.flags[i].visuals[0].origin + (0,0,32), level.flags[i].visuals[0].origin - (0,0,32), false, undefined);
		upangles = vectorToAngles(trace["normal"]);
		
		level.flags[i].gameObject.baseeffectforward = anglesToForward(upangles);
		level.flags[i].gameObject.baseeffectright = anglesToRight(upangles);
		level.flags[i].gameObject.baseeffectpos = trace["position"];
	}
	
	if(level.flags.size > 0)
	{
		thread FlagCountMonitor();
		thread maps\mp\gametypes\_huds::FlagCounterHUD();
	}
}

createUseObject( ownerTeam, trigger, visuals, offset)
{
	useObject = spawnStruct();
	useObject.type = "useObject";
	useObject.curOrigin = trigger.origin;
	useObject.ownerTeam = ownerTeam;
	useObject.entNum = trigger getEntityNumber();
	useObject.keyObject = undefined;
	
	useObject.triggerType = "proximity";
		
	// associated trigger
	useObject.trigger = trigger;
	
	// associated visual object
	for ( index = 0; index < visuals.size; index++ )
	{
		visuals[index].baseOrigin = visuals[index].origin;
		visuals[index].baseAngles = visuals[index].angles;
	}
	useObject.visuals = visuals;
	
	if ( !isDefined( offset ) )
		offset = (0,0,0);

	useObject.offset3d = offset;

	// compass objectives
	useObject.compassIcons = [];
	useObject.objIDAllies = maps\mp\gametypes\_gameobjects::getNextObjID();
	useObject.objIDAxis = maps\mp\gametypes\_gameobjects::getNextObjID();

	//Sadly the game does not allow more than 15 elements on the minimap
	//flags are created before everything else - lets keep it to max 10
	//otherwise the weaponboxes (and maybe other things) aren't visible
	if(!isDefined(useObject.objIDAllies) || useObject.objIDAllies > 10)
	{
		useObject = undefined;
		return undefined;
	}
	
	if(!isDefined(useObject.objIDAxis) || useObject.objIDAxis > 10)
	{
		useObject = undefined;
		return undefined;
	}

	objective_add( useObject.objIDAllies, "invisible", useObject.curOrigin );
	objective_add( useObject.objIDAxis, "invisible", useObject.curOrigin );
	objective_team( useObject.objIDAllies, "allies" );
	objective_team( useObject.objIDAxis, "axis" );

	useObject.objPoints["allies"] = maps\mp\gametypes\_objpoints::createTeamObjpoint( "objpoint_allies_" + useObject.entNum, useObject.curOrigin + offset, "allies", undefined );
	useObject.objPoints["axis"] = maps\mp\gametypes\_objpoints::createTeamObjpoint( "objpoint_axis_" + useObject.entNum, useObject.curOrigin + offset, "axis", undefined );
		
	useObject.objPoints["allies"].alpha = 0;
	useObject.objPoints["axis"].alpha = 0;
	
	// misc
	useObject.interactTeam = "enemy"; // "none", "any", "friendly", "enemy";
	
	// 3d world icons
	useObject.worldIcons = [];
	useObject.visibleTeam = "none"; // "none", "any", "friendly", "enemy";

	// calbacks
	useObject.onUse = undefined;
	useObject.onCantUse = undefined;

	useObject.useText = "default";
	useObject.useTime = 10000;
	useObject.curProgress = 0;

	if ( useObject.triggerType == "proximity" )
	{
		useObject.numTouching["neutral"] = 0;
		useObject.numTouching["axis"] = 0;
		useObject.numTouching["allies"] = 0;
		useObject.numTouching["none"] = 0;
		useObject.touchList["neutral"] = [];
		useObject.touchList["axis"] = [];
		useObject.touchList["allies"] = [];
		useObject.touchList["none"] = [];
		useObject.useRate = 0;
		useObject.claimTeam = "none";
		useObject.claimPlayer = undefined;
		useObject.lastClaimTeam = "none";
		useObject.lastClaimTime = 0;
		
		useObject thread maps\mp\gametypes\_gameobjects::useObjectProxThink();
	}
	
	return useObject;
}

onBeginUse(player)
{
}

onEndUse(team, player, success)
{
}

onUse(player)
{
	ownerTeam = self maps\mp\gametypes\_gameobjects::getOwnerTeam();
	
	self.ownerTeam = player.pers["team"];
	self.visuals[0] setModel(game["flagmodels"][player.pers["team"]]);
	
	thread updateSpawnLists();
	
	self maps\mp\gametypes\_gameobjects::updateTrigger();	
	self resetFlagBaseEffect();
	
	if(self.ownerTeam == "neutral")
	{
		self maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_captureneutral" );
		self maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_captureneutral" );
	}
	else
	{
		self maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_capture" );
		self maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_capture" );
	}
	
	self thread giveFlagCaptureXP(self.touchList[player.pers["team"]]);
	level notify("spawn_flag_captured");
}

updateSpawnLists()
{
	level notify("update_flag_spawn_lists");
	level endon("update_flag_spawn_lists");

	level.FlagSpawns[game["attackers"]] = undefined;
	level.FlagSpawns[game["defenders"]] = undefined;
	
	level.FlagSpawns[game["attackers"]] = [];
	level.FlagSpawns[game["defenders"]] = [];
	for(i=0;i<level.flags.size;i++)
	{
		ownerTeam = level.flags[i].gameObject maps\mp\gametypes\_gameobjects::getOwnerTeam();
	
		if(level.flags[i].nearbySpawns.size > 0)
		{
			for(j=0;j<level.flags[i].nearbySpawns.size;j++)
			{
				spawn = GetEntByNum(level.flags[i].nearbySpawns[j]);
				
				if(ownerTeam == game["attackers"])
					level.FlagSpawns[game["attackers"]][level.FlagSpawns[game["attackers"]].size] = spawn;
				else if(ownerTeam == game["defenders"])
					level.FlagSpawns[game["defenders"]][level.FlagSpawns[game["defenders"]].size] = spawn;
			}
		}
	}
}

resetFlagBaseEffect()
{
	if(isdefined(self.baseeffect))
		self.baseeffect delete();
	
	team = self maps\mp\gametypes\_gameobjects::getOwnerTeam();
	
	if(team != "axis" && team != "allies")
		return;
	
	self.baseeffect = spawnFx(level.flagBaseFXid[team], self.baseeffectpos, self.baseeffectforward, self.baseeffectright);
	triggerFx(self.baseeffect);
}

giveFlagCaptureXP(touchList)
{
	wait .05;
	maps\mp\gametypes\_globallogic::WaitTillSlowProcessAllowed();
	
	players = getArrayKeys(touchList);
	for(i=0;i<players.size;i++)
	{
		touchList[players[i]].player maps\mp\gametypes\_rank::giveRankXP("capture", 20);
		touchList[players[i]].player notify("update_playerscore_hud");
	}
}

getTeamFlagCount(team)
{
	score = 0;
	for(i=0;i<level.flags.size;i++) 
	{
		if(level.flags[i].gameObject maps\mp\gametypes\_gameobjects::getOwnerTeam() == team)
			score++;
	}

	return score;
}

FlagCountMonitor()
{
	level endon("game_ended");

	while(1)
	{
		level waittill("spawn_flag_captured");
		
		if(getTeamFlagCount(game["attackers"]) <= 0)
			thread ChangeLiveAmount(game["attackers"], 0);
		else if(getTeamFlagCount(game["defenders"]) <= 0)
			thread ChangeLiveAmount(game["defenders"], 0);
		else
			thread ChangeLiveAmount("both", level.numLives);
	}
}

ChangeLiveAmount(team, numLives)
{
	level endon("game_ended");
	
	level notify("changing_numlives_afer_spawnflag_capture");
	level endon("changing_numlives_afer_spawnflag_capture");

	for(i=0;i<level.players.size;i++)
	{
		if(team != "both" && level.players[i].pers["team"] != team)
			continue;
	
		level.players[i].pers["lives"] = numLives;
	
		if(team != "both")
		{
			//level.players[i] iPrintLnBold("^1No flags left ^3- ^1no respawn until you capture a flag!");
			scr_iPrintLnBold("REVOLT_NO_RESPAWNFLAGS", level.players[i]);
		}
		else
		{
			//respawn all dead players
			if(!isAlive(level.players[i]))
			{
				if(!isDefined(level.players[i].killcam) || !level.players[i].killcam)
					level.players[i] thread [[level.spawnClient]]();
			}
		}
	}
}