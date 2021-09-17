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
//From what i noticed there are some bugs in Cod4X 1.8 (sub. v. 17.5)
//1. If it's a roundbased game and there are bots during the roundend the following will happen in new round:
//- The bots will stay in "zombie mode" and new bots connect -> server is full very fast
//- Real players get stuck in a strange spectate mode: They are recognized as players (real team) but they can't see themselves and the mouse is locked
//- Server crashs when a player disconnects
//=> FIX: Bots have to be kicked before the round restarts and all is fine
//2. Bots somehow start to walk weird after a few roundrestarts (or map restarts/changes)
//- It looks like they recognize their last move task
//	For a test i have removed all botMove() functions and restarted the map but the bots where still moving to the first target
//	After restarting the full server (with quit, killserver doesnt help) they don't move until i insert the botMove() functions again
//=> Haven't found a fix yet, but i think there are some possibilities
//=> 1. Maybe he is moving to the next target to early: adding a wait until he is close to the movetarget then calculate the next one
//=> 2. Maybe a stuck detection: so even when he walks the false path we can send him on a new track as soon as he is stuck
//=> FIX: The AStarSearch() returns the next target point, but the calculates the path from the bots closest waypoint, not his origin
//	 This makes the bot move against walls from time to time (always at the same spots)
//	 To fix this i have added a second check (trace["fraction"]) to make sure the path to the taget point is free
//	 If not the bot will move to the closest waypoint first and then to the target point -> this path is clear for sure

//#include maps\_waypoints;
#include maps\mp\gametypes\_misc;

init()
{
	if(getDvarInt("scr_ktk_bots_maxDistance") <= 70) setDvar("scr_ktk_bots_maxDistance", 70);
	if(getDvarInt("scr_ktk_bots_maxDistance") > 5000) setDvar("scr_ktk_bots_maxDistance", 5000);
	
	if(getDvarInt("scr_ktk_bots_amount") <= 0) setDvar("scr_ktk_bots_amount", 0);
	if(getDvarInt("scr_ktk_bots_amount") > 20) setDvar("scr_ktk_bots_amount", 20);
	
	if(getDvar("scr_ktk_bots_skillAssassins") == "") setDvar("scr_ktk_bots_skillAssassins", 0.3);
	if(getDvarFloat("scr_ktk_bots_skillAssassins") > 1.0) setDvar("scr_ktk_bots_skillAssassins", 1.0);
	
	if(getDvar("scr_ktk_bots_skillGuards") == "") setDvar("scr_ktk_bots_skillGuards", 0.3);
	if(getDvarFloat("scr_ktk_bots_skillGuards") > 1.0) setDvar("scr_ktk_bots_skillGuards", 1.0);

	if(getDvar("scr_ktk_bots_skillKing") == "") setDvar("scr_ktk_bots_skillKing", 0.3);
	if(getDvarFloat("scr_ktk_bots_skillKing") > 1.0) setDvar("scr_ktk_bots_skillKing", 1.0);

	if(getDvarInt("scr_ktk_bots_startRoundWhenEmpty") < 0) setDvar("scr_ktk_bots_startRoundWhenEmpty", 0);
	if(getDvarInt("scr_ktk_bots_startRoundWhenEmpty") > 1) setDvar("scr_ktk_bots_startRoundWhenEmpty", 1);
	
	if(getDvarInt("scr_ktk_bots_trackKing") < 0) setDvar("scr_ktk_bots_trackKing", 0);
	if(getDvarInt("scr_ktk_bots_trackKing") > 1) setDvar("scr_ktk_bots_trackKing", 1);
	
	if(getDvarInt("scr_ktk_bots_assignRole") < 0) setDvar("scr_ktk_bots_assignRole", 0);
	if(getDvarInt("scr_ktk_bots_assignRole") > 1) setDvar("scr_ktk_bots_assignRole", 1);
	
	if(getDvarInt("scr_ktk_bots_reviveAmount") <= 0) setDvar("scr_ktk_bots_reviveAmount", 0);
	
	level.bots = [];
	kickAllBots();
	
	level.ktk_bots_startRoundWhenEmpty = getDvarInt("scr_ktk_bots_startRoundWhenEmpty");
	level.ktk_bots_maxDistance = getDvarInt("scr_ktk_bots_maxDistance");
	level.ktk_bots_trackKing = getDvarInt("scr_ktk_bots_trackKing");
	level.ktk_bots_amount = getDvarInt("scr_ktk_bots_amount");
	level.ktk_bots_skillAssassins = getDvarFloat("scr_ktk_bots_skillAssassins");
	level.ktk_bots_skillGuards = getDvarFloat("scr_ktk_bots_skillGuards");
	level.ktk_bots_skillKing = getDvarFloat("scr_ktk_bots_skillKing");
	level.ktk_bots_assignRole = getDvarInt("scr_ktk_bots_assignRole");
	level.ktk_bots_reviveAmount = getDvarInt("scr_ktk_bots_reviveAmount");
	
	level.ktk_bots_kingFound = false;
	level.campSpotTolerance = 39.37; //39.37 inch = 1 meter
	level.WpSightOffset = (0,0,60);
	
	level.maxCampSpotsInFile = 500; //might have to lower this, might lead to a "exceeded maxmimum var" error
	level.bots_KingCampSpotFile = "waypoints/" + level.script + "_king_campspots.csv";
	
	if(game["customEvent"] == "traitors" || game["customEvent"] == "hideandseek")
		return;
	
	level.waypointPlugin = true;
	if(level.waypointPlugin)
		setDvar("waypoint_filepath", "/waypoints/" + level.script + "_waypoints");	
	else
	{
		//updatePezbotMapList();
		
		//when uncommenting this we also have to uncomment the #include maps\_waypoints;
		//but within this gsc we use the plugin so it's not necessary
		//loadPezBotWaypoints();
	}
	
	level.waypointAmount = loadWaypoints();
	if(!level.waypointAmount)
		return;	

	//thread pluginTest();

	buildCampSpotArray();
	thread setupBots();
	
	if(level.ktk_bots_trackKing)
		thread trackKingMovement();
	
	if(getDvarInt("developer") > 0)
	{
		thread maps\mp\gametypes\_hardpoints::setTeamRadarWrapper("allies", true);
		thread maps\mp\gametypes\_hardpoints::setTeamRadarWrapper("axis", true);
	
		while(1)
		{
			level waittill("connected", player);
			player setClientDvar("ui_uav_client", 1);
		}
	}
}

pluginTest()
{
	//this values are for mp_crash
	start = [];
	start[0] = (-905, 1308, 307);
	start[1] = (-300, -2085, 265);
	start[2] = (1765, -412, 128);
	start[3] = (-226, -874, 162);

	target = [];
	target[0] = (1549, 686, 640);
	target[1] = (65, -799, 332);
	target[2] = (629, 542, 195);
	target[3] = (-154, -1495, 121);

	logPrint("Starting path calculation!\n");

	currentWaypoint = undefined;
	targetWaypoint = undefined;

	for(i=3;i<start.size;i++)
	{
		currentWaypoint = getNearestWp(start[i]);
	
		for(j=3;j<target.size;j++)
		{
			logPrint("Start: " + currentWaypoint + "\n");
			targetWaypoint = getNearestWp(target[j]);
			logPrint("Target: " + targetWaypoint + "\n");
			
			while(targetWaypoint != currentWaypoint)
			{
				nextWaypoint = AStarSearch(currentWaypoint, targetWaypoint);
				logPrint("Next Step: " + nextWaypoint + "\n");
				
				currentWaypoint = nextWaypoint;
			}
			
			logPrint("Target reached!\n");
		}
	}
	
	logPrint("Finished path calculation!\n");
}

updatePezbotMapList()
{
	if(level.ktk_bots_amount <= 0)
		return;

	if(level.waypointPlugin)
		return;

	maps = [];
	
	/*if(!getDvarInt("scr_mod_mapvote") || isDefined(level.serverEmptyMapSwitch) || isDefined(level.adminMapSwitch))
		maps = strToK(getDvar("sv_mapRotation"), " ");
	else
	{
		if(!getDvarInt("scr_mod_mapvote_playerbased"))
				maps = strToK(getDvar("rotation"), ";");
		else
		{
			if(isDefined(level.usedPlayerRotation))
				maps = strTok(getDvar("rotation_" + level.usedPlayerRotation + "_players"), ";");
			else
				maps = strToK(getDvar("rotation"), ";");
		}
	}*/

	//all of them are writing the next map into the maprotation dvar
	//so why checking for different rotations? :)
	maps = strToK(getDvar("sv_mapRotation"), " ");
	
	if(maps.size > 0)
	{
		array = [];
		array[0] = "choose()";
		array[1] = "{";
		array[2] = "\tlevel.waypointCount = 0;";
		array[3] = "\tlevel.waypoints = [];";
		array[4] = "\t";
		
		for(i=0;i<maps.size;i++)
		{
			if(maps[i] == "gametype" || maps[i] == "ktk" || maps[i] == "map")
				continue;
			
			if(!fs_testFile("waypoints\\" + maps[i] + "_waypoints.gsc") && !fs_testFile("waypoints\\" + maps[i] + "_waypoints.gsx"))
				continue;
			
			/* old - looks like too many "if else" are causing an out of memory crash
			if(array.size == 5)
				array[array.size] = "\tif(level.script == \"" + maps[i] +"\")";
			else
				array[array.size] = "\telse if(level.script == \"" + maps[i] +"\")";
				
			array[array.size] = "\t\twaypoints\\" + maps[i] + "_waypoints::load_waypoints();";
			*/
			
			array[array.size] = "\tif(level.script == \"" + maps[i] +"\") { waypoints\\" + maps[i] + "_waypoints::load_waypoints(); return; }";
		}
		
		array[array.size] = "}";
		
		file = openFile("waypoints/select_map.gsx", "write");
		
		if(file > 0)
		{
			for(i=0;i<array.size;i++)
				fPrintLn(file, array[i]);

			closeFile(file);
		}
	}
}

setupBots()
{
	retry = 0;
	i = 0;

	//wait for some players - but max 10 seconds
	while((!isDefined(level.players) || !level.players.size) && i <= 200)
	{
		wait .05;
		i++;
	}
	
	//maybe some more will connect in a few seconds
	//wait 3;
	//removed - when there are already players to start the new round then the bots come to late
	//and always one of the "real" players is assassin
	
	//reload the dvars
	level.ktk_bots_startRoundWhenEmpty = getDvarInt("scr_ktk_bots_startRoundWhenEmpty");
	level.ktk_bots_maxDistance = getDvarInt("scr_ktk_bots_maxDistance");
	level.ktk_bots_trackKing = getDvarInt("scr_ktk_bots_trackKing");
	level.ktk_bots_amount = getDvarInt("scr_ktk_bots_amount");
	level.ktk_bots_skillAssassins = getDvarFloat("scr_ktk_bots_skillAssassins");
	level.ktk_bots_skillGuards = getDvarFloat("scr_ktk_bots_skillGuards");
	level.ktk_bots_skillKing = getDvarFloat("scr_ktk_bots_skillKing");
	level.ktk_bots_assignRole = getDvarInt("scr_ktk_bots_assignRole");
	
	curPlayerAmount = level.players.size;
	for(i=0;i<(level.ktk_bots_amount - curPlayerAmount);i++)
	{
		//wait .1;
	
		bot = addTestClient();
		
		if(isDefined(bot))
		{
			retry = 0;
			bot thread createBot(); // No thread, do this one by one
		}
		else
		{
			if(retry > 3)
				printLn("Could not add Bot - Skip");
			else
			{
				i--;
				retry++;
				printLn("Could not add Bot - Retry");
			}
		}
	}
}

createBot()
{
	self endon("disconnect");

	level.bots[level.bots.size] = self;

	self.pers["isBot"] = true;
	self.hasSpawned = false;
	self.spawnPoint = undefined;
	self.firstSpawnInRound = true;
	
	while(!isDefined(self.pers["team"])) // Wait till properly connected
		wait .05;
	
	//give him 3 random hardpoints
	self.pers["selected_hardpoints"][0] = GetHardpointForStat(randomIntRange(2388, 2398));
	self.pers["selected_hardpoints"][1] = GetHardpointForStat(randomIntRange(2388, 2398));
	self.pers["selected_hardpoints"][2] = GetHardpointForStat(randomIntRange(2388, 2398));

	while(self.pers["selected_hardpoints"][1] == self.pers["selected_hardpoints"][0])
		self.pers["selected_hardpoints"][1] = GetHardpointForStat(randomIntRange(2388, 2398));
	
	while(self.pers["selected_hardpoints"][2] == self.pers["selected_hardpoints"][0] || self.pers["selected_hardpoints"][2] == self.pers["selected_hardpoints"][1])
		self.pers["selected_hardpoints"][2] = GetHardpointForStat(randomIntRange(2388, 2398));
		
	if(isSubstr(level.script, "snow") || isSubstr(level.script, "winter"))
		self.ghillie = "winter";
	else if(isSubstr(level.script, "sand") || isSubstr(level.script, "desert"))
		self.ghillie = "desert";
	else
	{
		if(!randomInt(2))
			self.ghillie = "none";
		else
			self.ghillie = "woodland";
	}

	//self notify("menuresponse", game["menu_team"], "autoassign");
	self thread [[level.autoassign]]();
	self thread onBotSpawn();
}

kickAllBots()
{
	removeAllTestClients();
}

kickSingleBot()
{
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] isABot())
		{
			if(!isDefined(level.king) || level.players[i] != level.king)
			{
				exec("kick " + level.players[i] getEntityNumber() + " Real player taking slot.");
				break;
			}
		}
	}
}

onBotSpawn()
{
	self endon("disconnect");

	while(1)
	{
		self waittill("spawned_player");

		self thread botVarSetup();
		self thread botLadderMantleWeapon();
	}
}

onBotDisconnect()
{
	for ( entry = 0; entry < level.bots.size; entry++ )
	{
		if ( level.bots[entry] == self )
		{
			while ( entry < level.bots.size-1 )
			{
				level.bots[entry] = level.bots[entry+1];
				entry++;
			}
			level.bots[entry] = undefined;
			break;
		}
	}	
}

botLadderMantleWeapon()
{
	self endon("death");
	self endon("disconnect");
	
	self.botPrimaryWeapon = self getCurrentWeapon();
	while(1)
	{
		while(!self isOnLadder() && !self isMantling())
		{
			wait .05;
			self.botPrimaryWeapon = self getCurrentWeapon();
		}
		
		while(self isOnLadder() || self isMantling())
			wait .05;
		
		self setSpawnWeapon(self.botPrimaryWeapon);
	}
}

botUnderAttack(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath)
{
	self endon("disconnect");
	self endon("death");
	
	//not a playing bot - only a stupid testbot
	if(isDefined(self.pers["isTestclient"]) && self.pers["isTestclient"])
		return;
	
	if(!isDefined(eAttacker))
		return;
		
	if(!isPlayer(eAttacker))
		return;
	
	if(!isAlive(eAttacker))
		return;
		
	if(!isDefined(eAttacker.model))
		return;
	
	if(eAttacker == self)
		return;
		
	if(level.teamBased && eAttacker isInSameTeamAs(self))
		return;
	
	if(eAttacker isInRCToy())
		return;
			
	if(eAttacker isInAC130())
		return;
			
	if(eAttacker isInMannedHelicopter())
		return;
			
	if(eAttacker isInMannedHelicopterTurret())
		return;
	
	if(iDamage <= 0)
		return;

	//wallbanged
	if(iDFlags & level.iDFLAGS_PENETRATION)
		return;

	if(sMeansOfDeath != "MOD_HEAD_SHOT" && sMeansOfDeath != "MOD_PROJECTILE" && sMeansOfDeath != "MOD_IMPACT" && sMeansOfDeath != "MOD_MELEE" && !isSubstr(sMeansOfDeath, "BULLET"))
		return;
		
	if(sMeansOfDeath == "MOD_IMPACT")
	{
		//if bot was hit by a thrown grenade but the attacker is not visible
		if(!bulletTracePassed(self getEye(), eAttacker getEye(), false, self))
			return;
	}
	
	self.myTarget = eAttacker;
	self.myMoveTarget = eAttacker;
	self.isUnderAttack = true;
	
	self botDoAim(self.myTarget, self botCalculateAimTime(self.myTarget.origin, "attack"));
}

botVarSetup()
{
	self endon("disconnect");
	self endon("death");
	
	self notify("bot_start_thinking");
	self endon("bot_start_thinking");
	
	self setClientDvar("aim_automelee_enabled", 1);
	
	self.myWaypoint = undefined;
	self.myTarget = undefined;
	self.myMoveTarget = undefined;
	self.myCommand = undefined;
	self.myCommandTarget = undefined;
	self.myCommandCaller = undefined;
	self.camperBotKing = undefined;
	self.guardBot = undefined;
	self.underway = false;
	self.isAttacking = false;
	self.isUnderAttack = false;
	self.isReviving = false;
	self.skillValue = 0;
		
	//true at spawn so the bot searches for a new target
	//is set to false when he found a target
	self.atTarget = true;

	self thread botBehavior();
}

botBehavior()
{
	self endon("disconnect");
	self endon("death");

	self botStop();
	
	//short delay to let the real players move out of the spawn
	if(isDefined(self.firstSpawnInRound) && self.firstSpawnInRound)
		wait randomFloat(4.0);

	//it starts to lag - problem of plugin or the modifications to make the script use plugin functions?
	self thread botMovement();
	self thread botCheckForMoveAction();
}
		
botMovement()
{
	self endon("disconnect");
	self endon("death");

	//while(1)
	{
		wait .1;
		
		if(self isASpectator())
			return; //break;

		if(!isAlive(self))
			return; //break;
		
		if(isDefined(level.gameEnded) && level.gameEnded)
			return; //break;
		
		if(!isDefined(level.roundstarted) || !level.roundstarted)
		{
			self thread botMovement();
			return;
		}
		
		if(self isAnAssassin())
			self.skillValue = level.ktk_bots_skillAssassins;
		else
		{
			if(self isKing())
				self.skillValue = level.ktk_bots_skillKing;
			else
				self.skillValue = level.ktk_bots_skillGuards;
		}

		if(self.skillValue > 0)
		{
			//keep your eyes open and search for enemies
			//we do this before we define a (move) target - maybe we spawn close to an enemy
			if(!self.isUnderAttack && !self.isAttacking)
				self.myTarget = self botGetBestAttackableTarget();
			
			if(isDefined(self.myTarget) && !self.isAttacking)
			{
				//self sayAll("I am attacking: " + self.myTarget.name + "!");
				self thread botAttackEnemy();
			}
		}
		
		if(self.isUnderAttack || self.isAttacking)
			self.myCommand = undefined;
		
		//don't move when you are inside a hardpoint
		if(self botShallNotMoveWhenLinked())
		{
			self thread botMovement();
			return;
		}
		
		//let the bot use his hardpoints!
		if(self hasWeapon(level.ktkWeapon["poisongas"]))
			self thread botThrowSmoke();

		if(self getCurrentWeapon() == level.ktkWeapon["marker"])
			self thread botShootOnce();
				
		if(isDefined(self.SentryCarry))
			self thread botShootOnce();
				
		if(isDefined(self.selectingLocation) && self.selectingLocation)
		{
			if(isDefined(self.myTarget))
				self notify("confirm_location", self.myTarget.origin);
			else
				self notify("confirm_location", self.origin);
		}
		
		if(!self.isAttacking)
		{
			//give the bot a random spawn as first target, else they will all use the same path (s&d = all enemies spawn in same area)
			if(isDefined(self.firstSpawnInRound) && self.firstSpawnInRound)
			{
				self.atTarget = false;
				self.firstSpawnInRound = false;
				
				spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
				self.myMoveTarget = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
			}
		
			if(isDefined(self.myCommand))
			{
				if(self.myCommand == "mp_cmd_holdposition")
					self.myMoveTarget = self.myCommandTarget;
				else if(self.myCommand == "mp_cmd_followme")
				{
					if(isDefined(self.myCommandCaller) && isPlayer(self.myCommandCaller) && isAlive(self.myCommandCaller) && level.teamBased && self isInSameTeamAs(self.myCommandCaller))
						self.myMoveTarget = self.myCommandTarget;
					else
						self.myCommand = undefined;
				}
				else if(self.myCommand == "mp_cmd_regroup")
				{
					if(!self.atTarget)
						self.myMoveTarget = self.myCommandTarget;
					else
						self.myCommand = undefined;
				}
			}
			
			if(!isDefined(self.myCommand))
			{
				if(self isAnAssassin())
				{
					//When the location of the king is known then we choose him as our new target
					if(isDefined(level.ktk_bots_kingFound) && level.ktk_bots_kingFound)
					{
						if(isDefined(level.king) && isPlayer(level.king) && isAlive(level.king))
						{
							//self sayAll("I am going for the king!");
							self.myTarget = level.king;
							self.myMoveTarget = level.king;
						}
						else
						{
							if(isDefined(self.atTarget) && self.atTarget)
								self.myMoveTarget = undefined;
						}
					}
					//Else we move around in map - No real target
					else
					{
						if(isDefined(self.atTarget) && self.atTarget)
							self.myMoveTarget = undefined;
					}
				}
				else
				{
					if(self isKing())
					{
						if(!isDefined(self.camperBotKing))
						{
							if(!randomInt(3))
								self.camperBotKing = false;
							else
							{
								self.camperBotKing = true;
								self.camperSpot = self getRandomCampSpotInMap();
							}				
						}
						
						//Campy King?
						if(self.camperBotKing && isDefined(self.camperSpot))
						{
							//self sayAll("I will camp!");
							self.myMoveTarget = self.camperSpot;
						}
						//Else we move around in map - No real target
						else
						{
							if(isDefined(self.atTarget) && self.atTarget)
								self.myMoveTarget = undefined;
						}
					}
					else
					{
						if(GetPlayersInTeam(game["defenders"]) <= 2)
							self.guardBot = true;
						else
						{
							if(!isDefined(self.guardBot))
							{
								if(!randomInt(7))
									self.guardBot = true;
								else
									self.guardBot = false;
							}
						}

						//Follow the king?
						if(self.guardBot && isDefined(level.king) && isPlayer(level.king) && isAlive(level.king))
						{
							//self sayAll("I am with the king!");
							self.myTarget = level.king;
							self.myMoveTarget = level.king;
						}
						//Else we move around in map - No real target
						else
						{
							if(isDefined(self.atTarget) && self.atTarget)
								self.myMoveTarget = undefined;
						}
					}
				}
				
				//If bot has no target we choose a random enemy
				if(!isDefined(self.myMoveTarget))
				{
					if(!isDefined(self.myTarget))
						self.myTarget = self getRandomEnemy();
					
					self.myMoveTarget = self.myTarget;
					
					//if no enemy available we choose a random waypoint
					if(!isDefined(self.myMoveTarget))
					{
						self.myMoveTarget = spawnStruct();
						self.myMoveTarget.origin = getWaypointValue(getRandomWp(), "origin");
					}
				}
			}
		}
		
		if(!isDefined(self.myMoveTarget))
			self.myMoveTarget = self.myTarget;
		
		if(isDefined(self.myMoveTarget))
			self botCalculateNextStepTowards(self.myMoveTarget);
	}
	
	self thread botMovement();
}

getRandomEnemy()
{
	self endon("disconnect");
	self endon("death");
	
	enemies = [];
	for(i=0;i<level.players.size;i++)
	{
		if(self == level.players[i])
			continue;
	
		if(level.players[i] isASpectator())
			continue;
			
		if(level.teamBased && level.players[i] isInSameTeamAs(self))
			continue;
	
		if(!isAlive(level.players[i]))
			continue;
			
		enemies[enemies.size] = level.players[i];
	}
	
	if(isDefined(enemies) && enemies.size > 0)
		return enemies[randomInt(enemies.size)];
	
	return undefined;
}

getClosestEnemy()
{
	self endon("disconnect");
	self endon("death");
	
	tempDist = 999999;
	tempEnemy = undefined;
	for(i=0;i<level.players.size;i++)
	{
		if(self == level.players[i])
			continue;
	
		if(level.players[i] isASpectator())
			continue;
			
		if(level.teamBased && level.players[i] isInSameTeamAs(self))
			continue;
	
		if(!isAlive(level.players[i]))
			continue;
			
		dist = Distance(self.origin, level.players[i].origin);
		if(dist <= tempDist)
		{
			tempDist = dist;
			tempEnemy = level.players[i];
		}
	}

	return tempEnemy;
}

botGetBestAttackableTarget()
{
	self endon("disconnect");
	self endon("death");
	
	//Can we see any enemies?
	self.possibleTargets = undefined;
	self.possibleTargets = [];
	for(i=0;i<level.players.size;i++)
	{
		if(botEnemyIsAttackable(level.players[i]))	
			self.possibleTargets[self.possibleTargets.size] = level.players[i];
	}
	
	//only 1 enemy found -> he is the target
	if(self.possibleTargets.size == 1)
	{
		if(self.possibleTargets[0] isKing())
			level.ktk_bots_kingFound = true;
	
		return self.possibleTargets[0];
	}
	//more than 1 enemy found -> get the best target
	else if(self.possibleTargets.size > 1)
	{
		for(i=0;i<self.possibleTargets.size;i++)
		{
			rate = 1;
			
			//Which one has a higher priority? Assassins = King, Guards = Main Assassins)
			if(self.possibleTargets[i] isKing() || self.possibleTargets[i] isMainAssassin())
				rate += 10;
			
			//No king/main assassin: Another player type with a higher priority? Assassins = Terminator, Guards = Dog (Slave is equal to a normal assassin))
			if(self.possibleTargets[i] isTerminator() || self.possibleTargets[i] isDog())
				rate += 5;
			
			//Any obstacles in our way?
			rate += self.possibleTargets[i] SightConeTrace(self GetEye(), self.possibleTargets[i]) * 10;

			//Is it in melee range? If so it is our new target, no matter how it was rated before (it's a save kill! (or death when not attacked))
			if(Distance(self.possibleTargets[i].origin, self.origin) <= 64)
				rate += 1000000;
			else
			{
				//rate it's distance -> more distance = less damage => bad rating
				distRate = (100 - (Distance(self.possibleTargets[i].origin, self.origin) * 0.01 / 2));
				
				if(distRate > 0)
					rate += distRate;
			}
			
			self.possibleTargets[i].rate = rate;
			
			if(self.possibleTargets[i] isKing())
				level.ktk_bots_kingFound = true;
		}
		
		//get the best rated enemy
		tempRate = 0;
		tempTarget = undefined;
		for(i=0;i<self.possibleTargets.size;i++)
		{
			if(self.possibleTargets[i].rate >= tempRate)
			{
				tempRate = self.possibleTargets[i].rate;
				tempTarget = self.possibleTargets[i];
			}
		}

		return tempTarget;
	}
	
	//no enemy found
	return undefined;
}

botDoAim(target, time)
{
	self endon("disconnect");
	self endon("death");

	if(!isDefined(target))
		return;
		
	if(!isPlayer(target))
		self botLookAt(target, time);
	else
	{
		if(!isAlive(target))
			return;
		
		if(!isDefined(target.model) || target.model == "")
			return;
	
		if(target isDogModel())
			self botLookAt(target getTagOrigin("j_spine4"), time);
		else
			self botLookAt(target getTagOrigin("pelvis"), time);
	}
}

botAttackEnemy()
{
	self endon("disconnect");
	self endon("death");
	
	self.isAttacking = true;
	self.myMoveTarget = self.myTarget;
	
	while(isDefined(self.myTarget) && isPlayer(self.myTarget) && isAlive(self.myTarget) && self botEnemyIsAttackable(self.myTarget))
	{
		weapon = self getCurrentWeapon();
		
		self botAction("-melee");
		self botAction("-fire");
		self botAction("-ads");
		
		if(isDefined(self.myTarget) && isPlayer(self.myTarget) && isAlive(self.myTarget))
		{
			time = self botCalculateAimTime(self.myTarget.origin, "attack");

			self botDoAim(self.myTarget, time);
		
			wait time;
				
			if(!isDefined(self.myTarget) || !isPlayer(self.myTarget) || !isAlive(self.myTarget))
				break;
			
			if(self isInRCToy())
			{
				if(self isInRCCar() && Distance(self.origin, self.myTarget.origin) <= 200)
					self botAction("+fire");
				
				if(self isInRCHelicopter() && Distance(self.origin, self.myTarget.origin) <= 1000)
					self botAction("+fire");
			}
			else
			{
				if(Distance(self.origin, self.myTarget.origin) <= 64)
					self botAction("+melee");
				else
				{
					if(self.skillValue > 0.6)
					{
						isKtKWeapon = isKtkWeapon(weapon);
						
						if(isKtKWeapon)
						{
							if(Distance(self.origin, self.myTarget.origin) >= botWeaponMaxAttackRanges(getKtkWeaponName(weapon), isKtKWeapon) / 3)
								self botAction("+ads");
						}
						else
						{
							if(Distance(self.origin, self.myTarget.origin) >= botWeaponMaxAttackRanges(self getCurrentWeapon(), isKtKWeapon) / 3)
								self botAction("+ads");
						}
					}
				
					self botAction("+fire");
					wait WeaponFireTime(weapon);
					self botAction("-fire");
				}
			}
		}
		
		//i think the skill does not matter here since it's already used at doAim
		switch(WeaponClass(weapon))
		{
			case "pistol":	wait (1/4); break;	//4 = shots per second
			case "spread":	wait (1/2); break;	//2 = shots per second
			case "mg":		
			case "rifle":	wait (1/randomIntRange(2,7)); break;	//random shots per second
			case "grenade":	
			default:		wait .05; break;	//instant fire
		}
	}
	
	self botAction("-melee");
	self botAction("-fire");
	self botAction("-ads");
	
	wait .05;
	
	self.myTarget = undefined;
	self.isAttacking = false;
	self.isUnderAttack = false;
}

botCalculateAimTime(target, type)
{
	self endon("disconnect");
	self endon("death");

	time = 0;
	
	/*if(type == "movement")
	{
		//rotate fast?!
	}
	else if(type == "attack")*/
	{	
		angleDiffYaw = maps\mp\gametypes\_missions::AngleClamp180(VectorToAngles(target - self.origin)[1] - self getPlayerAngles()[1]);
		angleDiffRoll = maps\mp\gametypes\_missions::AngleClamp180(VectorToAngles(target - self.origin)[2] - self getPlayerAngles()[2]);

		//use the bigger angleDiff to calculate the aim time
		if(abs(angleDiffYaw) > abs(angleDiffRoll))
			time = (angleDiffYaw * 0.01 * (1.1 - self.skillValue));
		else
			time = (angleDiffRoll * 0.01 * (1.1 - self.skillValue));
	}

	if(time < 0)
		time *= -1;
		
	if(self isFlashbanged())
		time += 1;
		
	if(time <= 0.05)
		time = 0.05;
	
	return time;
}

botEnemyIsAttackable(player)
{
	self endon("disconnect");
	self endon("death");
	
	if(!isDefined(player))
		return false;
	
	if(!isPlayer(player))
		return false;
		
	if(!isAlive(player))
		return false;
	
	if(player == self)
		return false;
	
	if(player isASpectator())
		return false;
	
	if(!isDefined(player.model) || player.model == "")
		return false;
			
	if(level.teamBased && player isInSameTeamAs(self))
		return false;
		
	if(player SightConeTrace(self GetEye(), player) <= 0.35)
		return false;
		
	if(!self isInAC130() && !self isInMannedHelicopter() && !self isInPredator())
	{
		if(Distance(self.origin, player.origin) > level.ktk_bots_maxDistance)
			return false;
	
		//player in my back
		angleDiff = maps\mp\gametypes\_missions::AngleClamp180(VectorToAngles(player.origin - self.origin)[1] - self getPlayerAngles()[1]);
		if(abs(angleDiff) > 30)
			return false;
			
		if(!self botEnemyInAttackableRange(player))
			return false;
	}	
	return true;
}

botEnemyInAttackableRange(player)
{
	self endon("disconnect");
	self endon("death");

	weapon = self getCurrentWeapon();
	isKtKWeapon = isKtkWeapon(weapon);

	if(self isInRCToy())
	{
		if(self isInRCCar() && Distance(self.origin, player.origin) <= 200)
			return true;
			
		if(self isInRCHelicopter() && Distance(self.origin, player.origin) <= 1000)
			return true;
			
		return false;
	}
	
	if(isKtKWeapon)
	{
		if(Distance(self.origin, player.origin) <= botWeaponMaxAttackRanges(getKtkWeaponName(weapon), isKtKWeapon))
			return true;
	}
	else
	{
		if(Distance(self.origin, player.origin) <= botWeaponMaxAttackRanges(self getCurrentWeapon(), isKtKWeapon))
			return true;
	}

	return false;
}

botWeaponMaxAttackRanges(weapon, isKtKWeapon)
{
	if(isKtKWeapon)
	{
		//to keep things easier i use the minDamage value from the weapon file and multiply it by 2
		//hardpoints and special weapon can not be used to attack
		switch(weapon)
		{
			case "marker":
			case "ac130_25mm_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
			case "cobra_20mm_mp":	return 5000;
			case "dbShotgun":		return 500;
			case "katana":			return 128;
			case "knife":			return 64;	
			case "magnum":
			case "ump45":
			case "ump45Acog":
			case "ump45Silencer":
			case "ump45Reflex":		return 2000;
			case "intervention":
			case "m21Silencer":		return 10000;
			case "crossbow":
			case "crossbowExp":
			case "disruptor":
			case "mosinnagat":
			case "famas":
			case "famasAcog":
			case "famasSilencer":
			case "famasReflex":
			case "aug":
			case "augAcog":
			case "augSilencer":
			case "augReflex":
			case "mg42":
			case "minigun":			return 4000;
			case "mortars":
			case "throwingKnife":
			case "rccar":
			case "ac130":
			case "syrette":
			case "sentrygun":
			case "predator":
			case "nuke":
			case "juggernaut":		return 0;

			default: return 0;
		}
	}
	else
	{
		//to keep things easier i use the minDamage value from the weapon file and multiply it by 2
		switch(WeaponClass(weapon))
		{
			case "turret":
			case "rifle":
			case "mg": 				return 4000;
			case "sniper":			return 10000;
			case "rocketlauncher":
			case "pistol":
			case "smg":				return 2000;
			case "spread":			return 1000;
			case "flamethrower":
			case "non-player":
			case "grenade":			return 0;
			
			default: return 0;
		}
	}
}

botCalculateNextStepTowards(target)
{
	self endon("disconnect");
	self endon("death");
	
	//only one instance allowed
	self notify("botCalculateNextStep");
	self endon("botCalculateNextStep");
	
	if(!isDefined(self.myWaypoint))
		self.myWaypoint = getNearestWp(self.origin);
	
	if(!isDefined(target) || !isDefined(target.origin))
		return;
	
	moveDirect = false; //was self.moveDirect before, but it's used in this function only so no need to share it (var limit!)
	targetWp = getNearestWp(target.origin);
	
	if(!isDefined(targetWp))
		return;
	
	self.atTarget = false;
	self.lookAt = undefined;
	
	if(self.underway)
	{
		if(targetWp == self.myWaypoint)
		{
			moveDirect = true;
			self.underway = false;
			self.atTarget = true;
			self.myWaypoint = undefined;
			self.myMoveTarget = undefined;
		}
		else
		{
			if(!isDefined(self.nextWp) || self.nextWp < 0)
				return;
			
			if(targetWp == self.nextWp)
			{
				if(distanceSquared(target.origin, self.origin) <= distanceSquared(getWaypointValue(self.nextWp, "origin"), self.origin))
				{
					moveDirect = true;
					self.underway = false;
					self.myWaypoint = undefined;
				}
			}
		}
	}
	else
	{
		if(targetWp == self.myWaypoint)
		{
			moveDirect = true;
			self.underway = false;
			self.atTarget = true;
			self.myWaypoint = undefined;
			self.myMoveTarget = undefined;
		}
		else
		{
			self.nextWp = AStarSearch(self.myWaypoint, targetWp);
			//self.nextWp = ValidateNextWP(self.nextWp);
			
			if(!isDefined(self.nextWp))
				return;
			
			self.underway = true;
		}
	}
	
	if(moveDirect)
	{
		//correct here? Bot already close to king, no need to 'touch' him
		if(isDefined(self.guardBot) && self.guardBot)
			return;
			
		if(isDefined(self.myCommand) && isDefined(self.myCommandCaller))
		{
			if(self.myCommand == "mp_cmd_followme" || self.myCommand == "mp_cmd_regroup")
			{
				if(Distance(self.origin, self.myCommandCaller.origin) <= 120)
					return;
			}
		}
	
		self botMoveTo(target.origin);
		//self botMoveActions(); //moved to new thread "botCheckForMoveAction"
		
		if(!isDefined(self.isAttacking) || !self.isAttacking)
		{
			if(isDefined(target))
			{
				time = self botCalculateAimTime(target.origin, "movement");
				self.lookAt = target.origin + level.WpSightOffset;
				self botDoAim(self.lookAt, time);
			}
		}
	}
	else
	{
		if(isDefined(self.nextWp) && self.nextWp >= 0)
		{
			self botMoveTo(getWaypointValue(self.nextWp, "origin"));
			//self botMoveActions(); //moved to new thread "botCheckForMoveAction"
			
			if(isDefined(target))
			{
				if(!isDefined(self.isAttacking) || !self.isAttacking)
				{
					if(!self isOnLadder())
					{
						self.lookAt = getWaypointValue(self.nextWp, "origin") + level.WpSightOffset;
						time = self botCalculateAimTime(getWaypointValue(self.nextWp, "origin"), "movement");
					}
					else
					{
						//climbing up
						if(self.origin[2] < getWaypointValue(self.nextWp, "origin")[2])
							self.lookAt = getWaypointValue(self.nextWp, "origin") + (0,0,1000);
						//climbing down
						else
							self.lookAt = getWaypointValue(self.nextWp, "origin") - (0,0,1000);
					}

					self botDoAim(self.lookAt, 0.05);
				}
			}
			
			if(distance(getWaypointValue(self.nextWp, "origin"), self.origin) <=  19.68)
			{
				self.underway = false;
				self.myWaypoint = self.nextWp;
			}
		}	
	}
}

//i have no idea if this solution can fix the var overflow
//crash -> count: 5364, var usage: 5364, endon usage: 16092
//called from:
//(file 'maps/mp/gametypes/_bots.gsx', line 1375)
//  self botJump();
//
botCheckForMoveAction()
{
	self endon("disconnect");
	self endon("death");

	while(1)
	{
		wait .3; //tweak this value (.3 looks fine)
		self botMoveActions();
	}
}

botMoveActions()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isOnLadder() || self isMantling())
		return;
	
	if(isDefined(self.isAttacking) && self.isAttacking)
		return;
	
	if(isDefined(self.isUnderAttack) && self.isUnderAttack)
		return;
	
	self botAction("-ads");
	self botAction("-sprint");
	
	//adjust the movement type to reach the next waypoint
	//->
	//check if the bot has to mantle
	hasToMantle = false;
	
	//the bot has to jump-mantle?
	if(isDefined(self.nextWp) && self.nextWp >= 0)
	{
		if(getWaypointValue(self.nextWp, "origin")[2] > self.origin[2])
		{
			if(CalcDif(getWaypointValue(self.nextWp, "origin")[2], self.origin[2]) >= 60)
			{
				if(Distance2d(getWaypointValue(self.nextWp, "origin"), self.origin) <= 20)
				{
					//iPrintLnBold("jump mantle");
					hasToMantle = true;
				}
			}
		}
	}

	if(!hasToMantle)
	{
		//ignore steps (he can pass e.g. of a stair)
		//we can run up to 16 units without jumping
		//default jump height is 39
		heightOffset = (0,0,17);
	
		if(!BulletTracePassed(self.origin + heightOffset, self.origin + heightOffset + AnglesToForward((0, self getPlayerAngles()[1], 0))*20, false, self))
		{
			hasToMantle = true;
			//iPrintLnBold("mantle");
		}
		else
		{
			heightOffset = (0,0,20);
			
			if(!BulletTracePassed(self.origin + heightOffset, self.origin + heightOffset + AnglesToForward((0, self getPlayerAngles()[1], 0))*20, false, self)) //canProne
			{
				hasToMantle = true;
				//iPrintLnBold("mantle 2");
			}
			else
			{
				heightOffset = (0,0,40);	
				
				if(!BulletTracePassed(self.origin + heightOffset, self.origin + heightOffset + AnglesToForward((0, self getPlayerAngles()[1], 0))*20, false, self)) //canCrouch
				{
					//self setStance("prone"); 
					//setStance requires cod4x new_arch
					self botAction("+goprone");
					//iPrintLnBold("prone");
				}
				else
				{
					heightOffset = (0,0,75);

					if(!BulletTracePassed(self.origin + heightOffset, self.origin + heightOffset + AnglesToForward((0, self getPlayerAngles()[1], 0))*20, false, self)) //canStand
					{
						//self setStance("crouch");
						//setStance requires cod4x new_arch
						self botAction("+gocrouch");
						//iPrintLnBold("crouch");
					}
					else
					{
						//iPrintLnBold("move normal");
						
						if(self GetStance() != "stand")
						{
							//self setStance("stand"); 
							//setStance requires cod4x new_arch
							self botAction("+gostand");
							wait .05;
							self botAction("-goprone");
							self botAction("-gocrouch");
							self botAction("-gostand");
						}
						
						return;
					}
				}
			}
		}
	}
	
	if(hasToMantle)
	{
		//only try to mantle when the target is infront else it's kinda strange
		//->
		if(!isDefined(self.nextWp) || self.nextWp <= 0)
			return;
		
		if(abs(maps\mp\gametypes\_missions::AngleClamp180(VectorToAngles(getWaypointValue(self.nextWp, "origin") - self.origin)[1] - self getPlayerAngles()[1])) > 30)
			return;
		//<-
		
		latestPos = self.origin;
		
		self botJump();
			
		//is he mantling?
		if(self isMantling())
		{
			//iPrintLnBold("i am mantling");			
			return;
		}
		
		while(!self isOnGround())
			wait .05;
					
		//nope, he landed at the same spot he jumped off
		if(Distance(latestPos, self.origin) <= 15)
		{
			//slowly teleport him - else he will not reach this spot
			if(isDefined(self.nextWp) && self.nextWp >= 0)
			{
				//next waypoint is infront of me
				if(abs(maps\mp\gametypes\_missions::AngleClamp180(VectorToAngles(getWaypointValue(self.nextWp, "origin") - self.origin)[1] - self getPlayerAngles()[1])) <= 30)
				{
					//iPrintLnBold("teleporting");
					self setOrigin(PlayerPhysicsTrace(getWaypointValue(self.nextWp, "origin") + (0,0,10), self.origin + (0,0,10)));
				}
			}
		}
		
		return;
	}
	//<-
	
	//sprint to the next waypoint
	//exception: bot is close to the king (assassins only when king was found yet)
	//->
	if(isDefined(level.king) && isPlayer(level.king) && isAlive(level.king) && Distance(level.king.origin, self.origin) < 200)
	{
		if(self isAGuard())
			return;
		else
		{
			if(isDefined(level.ktk_bots_kingFound) && level.ktk_bots_kingFound)
				return;
		}
	}
	
	self botAction("-ads");
	self botAction("+sprint");
	//<-
	
}

botJump()
{
	self endon("disconnect");
	self endon("death");

	//iPrintLnBold("go stand");
	
	while(self GetStance() != "stand")
	{
		//self setStance("stand"); 
		//setStance requires cod4x new_arch
		self botAction("+gostand");
		wait .05;
		//with setStance -gostand could be removed
		self botAction("-gostand");
	}
	
	//iPrintLnBold("jump");
	
	self botAction("+gostand");
	wait .05;
	self botAction("-gostand");
}

botThrowSmoke()
{
	self endon("disconnect");

	self botAction("+smoke");
	wait .05;
	self botAction("-smoke");
}

botShootOnce()
{
	self endon("disconnect");

	self botAction("+fire");
	wait .05;
	self botAction("-fire");
}

reactToOrder(command)
{
	self endon("disconnect");
	self endon("death");

	if(!isDefined(self) || !isPlayer(self) || !isAlive(self))
		return;
		
	if(!isDefined(command))
		return;
		
	inArea = true;		
	if(command == "mp_cmd_regroup")
		inArea = false;
	
	listeningBots = [];
	for(i=0;i<level.players.size;i++)
	{
		//not a playing bot - only a stupid testbot
		if(isDefined(level.players[i].pers["isTestclient"]) && level.players[i].pers["isTestclient"])
			continue;
	
		if(!level.players[i] isABot())
			continue;
			
		if(level.players[i] == self)
			continue;
			
		if(level.players[i].pers["team"] != self.pers["team"])
			continue;
		
		if(!isAlive(level.players[i]))
			continue;
			
		if(inArea && Distance(self.origin, level.players[i].origin) > 1000)
			continue;
			
		listeningBots[listeningBots.size] = level.players[i];
	}
	
	if(!isDefined(listeningBots) || listeningBots.size <= 0)
		return;
		
	for(i=0;i<listeningBots.size;i++)
	{
		//ignore command while in combat
		if(isDefined(listeningBots[i].isAttacking) && listeningBots[i].isAttacking)
			continue;
			
		//ignore command while under attack
		if(isDefined(listeningBots[i].isUnderAttack) && listeningBots[i].isUnderAttack)
			continue;
	
		//bot might ignore the command
		if(randomInt(100) <= 25)
		{
			//listeningBots[i] sayTeam("Ignoring Command!");
			continue;
		}
		
		//override current task
		if(isDefined(listeningBots[i].guardBot) && listeningBots[i].guardBot)
			listeningBots[i].guardBot = false;
			
		if(isDefined(listeningBots[i].camperBotKing) && listeningBots[i].camperBotKing)
			listeningBots[i].camperBotKing = false;

		//listeningBots[i] sayTeam("Command accepted!");
		listeningBots[i].myCommand = command;
	
		switch(command)		
		{
			case "mp_cmd_followme":
				//use the caller as new target and don't change it until he dies (or an enemy is spotted)
				listeningBots[i].myMoveTarget = self;
				listeningBots[i].myCommandCaller = listeningBots[i].myMoveTarget;
				listeningBots[i].myCommandTarget = listeningBots[i].myMoveTarget;
				break;

			case "mp_cmd_movein":
				//get the closest enemy in area and use him as new target
				listeningBots[i].myTarget = listeningBots[i] getClosestEnemy();
				listeningBots[i].myMoveTarget = listeningBots[i].myTarget;
				break;

			case "mp_cmd_fallback":
				//fall back to the closest (enemy free) spawn
				spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(listeningBots[i].pers["team"]);
				listeningBots[i].myMoveTarget = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam(spawnPoints);
				break;

			case "mp_cmd_holdposition":
				//camp here
				listeningBots[i].myMoveTarget = listeningBots[i] getRandomCampSpotInArea();
				listeningBots[i].myCommandCaller = listeningBots[i].myMoveTarget;
				listeningBots[i].myCommandTarget = listeningBots[i].myMoveTarget;
				break;

			case "mp_cmd_regroup":
				//go to the position of the caller then act like you want - it doesn't mean we follow him after his command
				listeningBots[i].myMoveTarget = self;
				break;
			
			default: break;
		}
	}
}

botShallNotMoveWhenLinked()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isInPredator())
		return true;

	if(self isInAC130())
		return true;

	if(self isInMannedHelicopter())
		return true;

	if(self isInMannedHelicopterTurret())
		return true;

	/*if(self isInParachute())
		return true;*/

	if(self isBuyingWeapon())
		return true;

	if(self isReviving())
		return true;

	if(self isInLastStand())
		return true;

	if(self isInteractingWithTripwire())
		return true;

	if(self isUsingEscapeRope())
		return true;
	
	return false;
}

callBotsForReviveHelp()
{
	origin = self.origin;
	while(isDefined(self) && isAlive(self))
	{
		for(i=0;i<level.bots.size;i++)
		{
			if(!isDefined(self) || !isAlive(self))
				break;
		
			if(!level.teamBased || !level.bots[i] isInSameTeamAs(self))
				continue;

			if(level.bots[i] botShallNotMoveWhenLinked())
				continue;
				
			if(level.bots[i].isAttacking || level.bots[i].isUnderAttack)
				continue;
				
			if(Distance(level.bots[i].origin, self.origin) > 1500)
				continue;
				
			origin = self.origin;
			level.bots[i].myCommand = undefined;
			level.bots[i].myMoveTarget = self;
		}
		
		wait .5;
	}
	
	thread cancelBotReviveMovement(origin);
}

cancelBotReviveMovement(origin)
{
	for(i=0;i<level.bots.size;i++)
	{
		if(isDefined(level.bots[i].myMoveTarget) && level.bots[i].myMoveTarget.origin == origin)
			level.bots[i].myMoveTarget = undefined;
	}
}

//*******************************************************************************
//*****	Functions to track the king and create campspot files for bot kings	*****
//*******************************************************************************
buildCampSpotArray()
{
	//if our tracking worked in previous round we have an array with camp spots
	if(isDefined(game["bots_KingCampSpot"]))
		return;
	
	//if it's not defined yet then this might be the first round of map
	//or the king was a bot in the previous rounds
	getExistingCampSpotsFromFile();

	//if it's defined we already have content in the txt
	if(isDefined(game["bots_KingCampSpot"]))
		return;
	
	//else we try to get the best spots from the waypoints
	if(level.waypointAmount > 0)
	{
		for(i=0;i<level.waypointAmount;i++)
		{
			if(getWaypointValue(i, "childCount") == 0 || !isDefined(getWaypointValue(i, "type")))
				continue;

			if(getWaypointValue(i, "childCount") == 1 && getWaypointValue(i, "type") == "crouch")
			{
				entryNo = game["bots_KingCampSpot"].size;
				game["bots_KingCampSpot"][entryNo] = spawnStruct();
				game["bots_KingCampSpot"][entryNo] = getWaypointValue(i, "origin");
				game["bots_KingCampSpot"][entryNo] = getWaypointValue(i, "childCount");
				game["bots_KingCampSpot"][entryNo] = getWaypointValue(i, "children");
				game["bots_KingCampSpot"][entryNo] = getWaypointValue(i, "type");	
			}
		}
	}
}

getExistingCampSpotsFromFile()
{
	if(fs_testFile(level.bots_KingCampSpotFile))
	{
		file = openFile(level.bots_KingCampSpotFile, "read");
		
		if(file > 0)
		{
			game["bots_KingCampSpot"] = [];
			while(1)
			{
				value = fReadLn(file);
				
				if(!isDefined(value) || value == "" || value == " ")
					break;
				
				value = strToK(value, ";");
				
				newEntry = game["bots_KingCampSpot"].size;
				game["bots_KingCampSpot"][newEntry] = spawnStruct();
				game["bots_KingCampSpot"][newEntry].rate = int(value[1]);
				game["bots_KingCampSpot"][newEntry].origin = strToVec(value[0]);
			}
		
			closeFile(file);
			
			if(isDefined(game["bots_KingCampSpot"]) && game["bots_KingCampSpot"].size <= 0)
				game["bots_KingCampSpot"] = undefined;
		}
	}
}

getRandomCampSpotInMap()
{
	if(!isDefined(game["bots_KingCampSpot"]) || game["bots_KingCampSpot"].size <= 0)
		return undefined;

	return game["bots_KingCampSpot"][randomInt(game["bots_KingCampSpot"].size)];
}

getRandomCampSpotInArea()
{
	self endon("disconnect");
	self endon("death");
	
	if(!isDefined(game["bots_KingCampSpot"]))
		return undefined;

	closestCampSpot = get_array_of_closest(self.origin, game["bots_KingCampSpot"], undefined, /*maxAmount*/ undefined, 250);

	if(isDefined(closestCampSpot) && closestCampSpot.size > 0)
		return closestCampSpot[randomInt(closestCampSpot.size)];

	return undefined;
}

trackKingMovement()
{
	while(!isDefined(level.roundstarted) || !level.roundstarted)
		wait .05;

	thread evaluateKingTracks();
		
	if(isDefined(level.king) && !level.king isABot())
	{
		level.kingMovementTracker = [];
		level.lastKingMovementOrigin = undefined;
		while(isDefined(level.king) && isPlayer(level.king) && isAlive(level.king))
		{
			wait 3;
			
			if(!isDefined(level.king))
				break;
			
			if(!level.king isOnGround())
				continue;
			
			saveCurrentTrackInTrackingList(level.king.origin);
		}
	}
}

saveCurrentTrackInTrackingList(origin)
{
	if(isDefined(level.lastKingMovementOrigin) && Distance(level.lastKingMovementOrigin, origin) <= 5)
		return;

	level.lastKingMovementOrigin = origin;

	if(!isDefined(level.kingMovementTracker))
		level.kingMovementTracker = [];

	if(level.kingMovementTracker.size <= 0)
	{
		level.kingMovementTracker[0] = spawnStruct();
		
		level.kingMovementTracker[0].rate = 0;
		level.kingMovementTracker[0].origin = origin;
	}
	else
	{
		similar = false;
		for(i=0;i<level.kingMovementTracker.size;i++)
		{
			if(Distance(origin, level.kingMovementTracker[i].origin) <= level.campSpotTolerance)
			{
				similar = true;
				level.kingMovementTracker[i].rate++;
			}
		}
		
		if(!similar)
		{
			newEntry = level.kingMovementTracker.size;
			level.kingMovementTracker[newEntry] = spawnStruct();
			level.kingMovementTracker[newEntry].origin = origin;
			level.kingMovementTracker[newEntry].rate = 0;
		}
	}
}

//as soon as the king dies we can evaluate the collected path and compare it with the previously saved spots in the txt file
evaluateKingTracks()
{
	level notify("evaluating_king_tracks");
	level endon("evaluating_king_tracks");

	while(isDefined(level.roundstarted) && level.roundstarted)
		wait .05;
	
	if(!isDefined(level.kingMovementTracker) || level.kingMovementTracker.size <= 0)
		return;
	
	//check if the origin was visited multiple times (might be a camp spot)
	level.kingCampTracker = [];
	for(x=0;x<level.kingMovementTracker.size;x++)
	{
		if(level.kingMovementTracker[x].rate > 0)
		{
			newEntry = level.kingCampTracker.size;
			level.kingCampTracker[newEntry] = spawnStruct();
			level.kingCampTracker[newEntry].origin = level.kingMovementTracker[x].origin;
			level.kingCampTracker[newEntry].rate = level.kingMovementTracker[x].rate;
			
			level.kingMovementTracker[x] = undefined;
		}
	}

	level.kingMovementTracker = undefined;
	
	//if none of the passed origins were visited multiple times: stop here
	if(!isDefined(level.kingCampTracker) || level.kingCampTracker.size <= 0)
		return;
	
	//collect the camp spot informations from previous rounds
	if(fs_testFile(level.bots_KingCampSpotFile))
	{
		file = openFile(level.bots_KingCampSpotFile, "read");
		
		if(file > 0)
		{
			level.currentCampTracks = [];
			while(1)
			{
				ResetTimeout();
			
				value = fReadLn(file);
				
				if(!isDefined(value) || value == "" || value == " ")
					break;
				
				value = strToK(value, ";");
			
				newEntry = level.currentCampTracks.size;
				level.currentCampTracks[newEntry] = spawnStruct();
				level.currentCampTracks[newEntry].rate = int(value[1]);
				level.currentCampTracks[newEntry].origin = strToVec(value[0]);
			}
		
			closeFile(file);
		}
	}
	
	if(!isDefined(level.currentCampTracks))
		level.currentCampTracks = level.kingCampTracker;
	else
	{
		//check if there is already a similar spot in file
		for(i=0;i<level.kingCampTracker.size;i++)
		{
			for(j=0;j<level.currentCampTracks.size;j++)
			{
				//yes: increase it's rate
				if(Distance(level.kingCampTracker[i].origin, level.currentCampTracks[j].origin) <= level.campSpotTolerance)
					level.currentCampTracks[j].rate++;
				//no: create a new one
				else
					level.currentCampTracks[level.currentCampTracks.size] = level.kingCampTracker[i];
			}
			
			//free it's space
			level.kingCampTracker[i] = undefined;
		}
	}

	level.kingCampTracker = undefined;
	
	//save the updated list into a file - overwrite if the file exists
	file = openFile(level.bots_KingCampSpotFile, "write");
		
	if(file > 0)
	{
		for(i=0;i<level.currentCampTracks.size;i++)
		{
			if(i >= level.maxCampSpotsInFile)
				break;
		
			equal = false;
				
			for(j=0;j<level.currentCampTracks.size;j++)
			{
				if(i==j)
					continue;
			
				if(level.currentCampTracks[i].rate == level.currentCampTracks[j].rate || level.currentCampTracks[i].origin == level.currentCampTracks[j].origin)
				{
					equal = true;
					break;	
				}
			}
		
			if(!equal)
				fPrintLn(file, level.currentCampTracks[i].origin + ";" + level.currentCampTracks[i].rate);
		}

		closeFile(file);
	}

	game["bots_KingCampSpot"] = level.currentCampTracks;
	level.currentCampTracks = undefined;
}
