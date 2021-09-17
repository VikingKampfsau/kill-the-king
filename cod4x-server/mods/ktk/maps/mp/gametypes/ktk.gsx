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
|---------------------------------------------------------------------------|
Remember that some weapons got replace by new ones, so check the readme.txt
before you change the weapons
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
The gametype:
The guards are protectors of the king.
The assassins have to eliminate the king within the roundtime.
-----------------------------------------------------------------------------
---------------------------------------------------------------------------*/
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_misc;

main()
{
	if(getdvar("mapname") == "mp_background")
		return;
	
	if(getDvar("scr_mod_ktk_gameevent") == "")
		game["customEvent"] = "none";
	else
		game["customEvent"] = toLower(getDvar("scr_mod_ktk_gameevent"));
		
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();

	maps\mp\gametypes\_globallogic::registerTimeLimitDvar( "ktk", 5, 0, 1440 );
	maps\mp\gametypes\_globallogic::registerScoreLimitDvar( "ktk", 0, 0, 5000 );
	maps\mp\gametypes\_globallogic::registerRoundLimitDvar( "ktk", 10, 0, 20 );
	maps\mp\gametypes\_globallogic::registerNumLivesDvar( "ktk", 0, 0, 10 );
	maps\mp\gametypes\_globallogic::registerRoundSwitchDvar( "ktk", int(level.roundLimit/2), 0, 9 );

	level.timeLimit -= .1; //Else the announce loops till the match starts.
	level.oldschool = false;
	level.prematchPeriod = 0;
	level.prematchPeriodEnd = 0;
	level.overrideTeamScore = true;
	
	if(game["customEvent"] == "lastkingstanding" || game["customEvent"] == "traitors")
		level.teamBased = false;
	else
		level.teamBased = true;
	
	level.onStartGameType = ::onStartGameType;
	level.onPlayerConnect = ::onPlayerConnect;
	level.onSpawnPlayer = ::onSpawnPlayer;
	level.onTimeLimit = ::onTimeLimit;
	level.onRoundSwitch = ::onRoundSwitch;

	level.roundstarted = false;
	level.firstblood = true; //important, else it will show the message when assassin gets picked!
	level.assassin = undefined;
	level.king = undefined;
	level.dog = undefined;
	level.dogdamage = getDvarInt("scr_ktk_dog_damage");
	level.terminator = undefined;
	level.finalcamplaying = false;
	
	if(getDvarInt("scr_mod_roundstarttime") >= 1)
		level.roundstartdelay = getDvarInt("scr_mod_roundstarttime");
	else
		level.roundstartdelay = 1;
		
	if(getDvarInt("scr_mod_roundstarttime") >= 1)
		level.pickdelay = getDvarInt("scr_mod_picktime");
	else 
		level.pickdelay = 1;
	
	level.ktk_debug_mode = getDvarInt("scr_mod_debug");
	level.ktk_bugs_logfile = "logs\ktk_bugs.log";
	level.ktk_debug_logfile = "logs\ktk_debug.log";
	level.ktk_security_logfile = "logs\ktk_security.log";
	level.ktk_suggestion_logfile = "logs\ktk_suggestions.log";
	
	//moved this to the globallogic to let the game create all needed variables first
	//thread maps\mp\gametypes\_general::main();
}

onStartGameType()
{
	if(game["customEvent"] == "zombie")
		setExpFog(500, 100, .0, .0, .0, 0);

	if ( !isDefined( game["switchedsides"] ) )
		game["switchedsides"] = false;
	
	if ( game["switchedsides"] )
	{
		oldAttackers = game["attackers"];
		oldDefenders = game["defenders"];
		game["attackers"] = oldDefenders;
		game["defenders"] = oldAttackers;

		thread maps\mp\gametypes\_scoreboard::init();
	}

	setClientNameMode("auto_change");

	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );
	
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_allies_start" );
	maps\mp\gametypes\_spawnlogic::placeSpawnPoints( "mp_tdm_spawn_axis_start" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["defenders"], "mp_tdm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["attackers"], "mp_tdm_spawn" );
	//maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["defenders"], "mp_dm_spawn" );
	//maps\mp\gametypes\_spawnlogic::addSpawnPoints( game["attackers"], "mp_dm_spawn" );
	
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );
	
	allowed[0] = "war";
	
	if(game["customEvent"] != "sniperonly" && game["customEvent"] != "knifeonly" && game["customEvent"] != "hideandseek")
		allowed[1] = "bombzone";
	
	maps\mp\gametypes\_rank::registerScoreInfo( "kill", 10 );
	maps\mp\gametypes\_rank::registerScoreInfo( "headshot", 20 );
	maps\mp\gametypes\_rank::registerScoreInfo( "assist", 5 );
	maps\mp\gametypes\_rank::registerScoreInfo( "suicide", 0 );
	maps\mp\gametypes\_rank::registerScoreInfo( "teamkill", 0 );
	maps\mp\gametypes\_rank::registerScoreInfo( "hardpoint", 100 );	
	
	if ( getDvarInt( "scr_oldHardpoints" ) > 0 )
		allowed[allowed.size] = "hardpoint";
	
	level.displayRoundEndText = false;
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	// elimination style
	if ( level.roundLimit != 1 && level.numLives )
	{
		if(game["customEvent"] == "lastkingstanding")
		{
			level.overrideTeamScore = true;
			level.displayRoundEndText = true;
			level.onEndGame = ::onEndGameElimStyle;
		}
	}
	
	if(getDvar("timescale") != "1") setDvar("timescale", "1");
	
	//Check amount of Players and start the game
	thread onPlayerConnect();
	thread onPlayerConnecting();
	
	//add the round number to a dvar - so i can check when new scripts take effect (map change)
	if(!isdefined(game["roundsplayed"]))
		game["roundsplayed"] = 0;
	
	/* changed the event settings from configs to scripts
	if(isDefined(game["roundsplayed"]))
	{
		currentRound = game["roundsplayed"] + 1;
		
		if(!isDefined(level.roundLimit))
			setDvar("ktk_info_currentRound", currentRound);
		else
			setDvar("ktk_info_currentRound", currentRound + " of " + level.roundLimit);
	
		//when it's the first round load map settings and/or events
		if(currentRound == 1)
		{	
			//check if an other event was launched via rcon
			level.TempEvent = toLower(getDvar("scr_mod_ktk_gameevent"));
		
			//1. Default settings
			thread execConfig(1, getDvar("scr_mod_ktk_mainconfig"), "Loading default config");
		
			//2. map settings - like the old mam plugin
			thread execConfig(2, "config/maps/" + level.script + ".cfg", "Loading map config: " + level.script);
		
			//3. events
			thread checkForEvent(3);
		}

		//4. round events
		if(getDvarInt("scr_mod_ktk_roundevents"))
			thread execConfig(4, "config/events/roundevent_" + currentRound + ".cfg", "Loading round event: " + currentRound);
			
		thread maps\mp\gametypes\_huds::CustomEventHUD();
		
		if(game["customEvent"] == "revolt")
			thread maps\mp\gametypes\_revolt::createFlags();
	}*/
	
	if(game["customEvent"] == "revolt")
		thread maps\mp\gametypes\_revolt::createFlags();
	
	WaitForPlayers();
}

execConfig(order, fullPath, infoText)
{
	wait (order*0.1);

	if(isDefined(fullPath) && fullPath != "")
		exec("exec " + fullPath);
	
	if(isDefined(infoText) && infoText != "")
		PrintLn(infoText);
}

checkForEvent(order)
{
	wait (order*0.1);

	//if the event (via rcon) is different to the one defined in config - use the one via rcon
	if(level.TempEvent != toLower(getDvar("scr_mod_ktk_gameevent")))
		setDvar("scr_mod_ktk_gameevent", level.TempEvent);
	
	if(getDvar("scr_mod_ktk_gameevent") != "")
	{
		game["customEvent"] = toLower(getDvar("scr_mod_ktk_gameevent"));
		thread execConfig(0, "config/events/" + game["customEvent"] + ".cfg", "Loading event config: " + game["customEvent"]);
		
		if(game["customEvent"] == "lastkingstanding")
			level.teamBased = false;
	}
}

onPlayerConnecting()
{
	while(1)
	{
		level waittill("connecting", player);
		
		if( !level.splitscreen && !isdefined( player.pers["score"] ) )
			player setClientDvar("current_event", game["customEvent"]);
	}
}
		
onPlayerConnect()
{
	while(1)
	{
		level waittill("connected", player);

		player thread nameChecker();
		
		player.weaponstate = 1;
		if(player getKtkStat(2363) == 1)
			player.weaponstate = 2;
		
		player setClientDvars(	"gungame_cur", player.weaponstate,
								"gungame_max", level.GunGameWeapons.size-1);
		
		player.guardtime = 0;
		
		/*	removed because they get defined on first use - no need to waste this variables when they are maybe never called (like admin cmds)
		player.inhelicopter = false;
		player.lastattacker = undefined;
		player.lastattackerEnt = undefined;
		player.isReviving = false;
		player.godmode = false;
		player.javelinsFired = 0;
		player.escapeRopeInfo = undefined;
		player.usingEscapeRope = false;
		
		if(game["customEvent"] != "none")
		{
			if(game["customEvent"] == "hideandseek")
				player.propsModel = undefined;
			else if(game["customEvent"] == "alien")
				player.alienModel = undefined;
			else if(game["customEvent"] == "traitors")
			{
				player.isATraitor = false;
				player.isAnInnocent = false;
			}
		}
		*/
		
		player.pers["selected_hardpoints"] = [];
		player.pers["afkteam"] = player maps\mp\gametypes\_afk::checkForReconnectToAvoidRole();
		player.pers["curVision"] = "none";
		
		//sometimes a player doesn't spawn so i define his class here
		player.pers["class"] = "sniper";
		player.class = "sniper";
		
		player thread onFirstSpawn();
		player thread DefineHardpointSlots();
	}
}

NewPlayerOnServer()
{
	self endon("disconnect");

	if(!self isABot())
	{
		switch(GetSubStr(self.guid, 24, 32))
		{
			case "1aac7d28":
			case "94788041":
				self setClientDvar("i_am_developer", 1);
				scr_iprintln("DEVELOPER_CONNECTED_TO_SERVER");
				break;
				
			case "4568e37f":
			case "49682261":
				scr_iprintln("PLAYER_CONNECTED_TO_SERVER", undefined, "^1[Ninja]Aura<3");
				break;
			
			default: iPrintLn(&"MP_CONNECTED", self); break;
		}
	}

	self.pers["admin"] = false;
	self setClientDvar("i_am_admin", 0);
	self.pers["adminStatus"] = 0;
	
	self.pers["objectiveTextMessage"] = "";
	
	self thread maps\mp\gametypes\_language::GetNewPlayerLanguage();
	self thread maps\mp\gametypes\_unlocker::UnlockAllChallenges();
	self thread maps\mp\gametypes\_dvars::newPlayerDvars();
	
	self waittill("spawned_player");
	
	//show a custom message to inform ppl about upcoming events
	if(getDvar("scr_mod_WelcomeMsgBold") != "")
		self iPrintLnBold(getDvar("scr_mod_WelcomeMsgBold"));
		
	//give him unused hardpoints he had on his last visit
	self thread GiveHardpointsGainedLastVisit();
}

onFirstSpawn()
{
	self endon("disconnect");

	self waittill("spawned_player");

	self thread maps\mp\gametypes\_huds::KingHUD();
	self thread maps\mp\gametypes\_huds::KingHealthHUD();
	self thread maps\mp\gametypes\_huds::TerminatorHealthHUD();
	self thread maps\mp\gametypes\_huds::MonitorHealthBars();
	
	self thread maps\mp\gametypes\_awards::checkForHardpointUpdateOnSpawn();
	
	if(self isAGuard())
		thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "Guardians", self GetLocalizedString("GUARD_DESC"), "guards_logo", game["colors"][self.pers["team"]], game["music"]["spawn_" + self.pers["team"]] );
	if(self isAnAssassin())
		thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "Assassins", self GetLocalizedString("KTK_ASS_DESC"), "assassins_logo", game["colors"][self.pers["team"]], game["music"]["spawn_" + self.pers["team"]] );
		
	if(isDefined(level.ktk_bots_amount))
	{
		if(GetPlayersInTeam("axis") + GetPlayersInTeam("allies") > level.ktk_bots_amount)
			thread maps\mp\gametypes\_bots::kickSingleBot();
	}
}

onSpawnPlayer()
{
	self.usingObj = undefined;

	if(!isDefined(self.pers["team"]))
	{
		role = "nothing special";
		
		if(self isKing()) role = "king";
		else if(self isMainAssassin()) role = "main-assassin";
		else if(self isSlave()) role = "slave";
		else if(self isDog()) role = "dog";
	
		logPrint("The team of " + self.name + " is undefined. He is " + role + "\n");
	}
	
	if(game["customEvent"] == "lastkingstanding" || game["customEvent"] == "traitors" || game["customEvent"] == "hideandseek")
	{
		spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
		spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );
	}
	else
	{
		if ( level.inGracePeriod || level.script == "lolzor")
		{
			spawnPoints = getentarray("improved_spawn_" + self.pers["team"] + "_start", "targetname");

			if ( !spawnPoints.size )
				spawnPoints = getentarray("mp_tdm_spawn_" + self.pers["team"] + "_start", "classname");
				
			if ( !spawnPoints.size )
				spawnPoints = getentarray("mp_sab_spawn_" + self.pers["team"] + "_start", "classname");
			
			if ( !spawnPoints.size )
			{
				spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
				spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
			}
			else
			{
				spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );
			}		
		}
		else
		{
			spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
			
			if(game["customEvent"] == "revolt")
				spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeamFlag( self.pers["team"] );
			else
			{
				if(self isAGuard() && isDefined(level.king))
					spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearPos( spawnPoints, level.king.origin );
				else
					spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeam( spawnPoints );
			}
		}
	}

	if(isDefined(spawnPoint))
	{
		self thread SpawnSettings();
		
		self spawn( spawnPoint.origin, spawnPoint.angles );

		self thread onPlayerDeath();
	}
}

SpawnSettings()
{
	self endon("disconnect");
	self endon("death");
	self waittill("spawned_player");

	teamrole = undefined;

	if(!isDefined(self.pers["team"]) || self isASpectator())
		return;
	
	if(self isAnAssassin())
		teamrole = "attackers";
	else if(self isAGuard())
		teamrole = "defenders";

	if(getDvarInt("scr_enable_nightvision"))
		self thread maps\mp\gametypes\_huds::NVGiconHUD();
		
	if(getDvarInt("scr_mod_afk") == 1)
		self thread maps\mp\gametypes\_afk::CheckForAFK();
		
	if(getDvarInt("scr_mod_spawnprotection") == 1)
		self thread maps\mp\gametypes\_spawnprotection::Spawnprotection();
		
	self thread maps\mp\gametypes\_minigun::MinigunOnPlayerSpawned();
	self thread maps\mp\gametypes\_poison::poisonOnPlayerSpawn();
	
	if(game["customEvent"] != "hideandseek")
	{
		self thread maps\mp\gametypes\_huds::KillstreakHud();
		self thread maps\mp\gametypes\_huds::KillRatioHud();
		
		if(game["customEvent"] == "lastkingstanding")
		{
			if(!self isABot())
				level.gameHadRealPlayers = true;
		}
	}
	
	if(!isDefined(self.pers["gametype_sound"]))
	{
		self PlayLocalSound("gametype_ktk");
		self.pers["gametype_sound"] = false;
	}

	if(self getKtkStat(2358) != 1)
		self.statusicon = "";
	else
	{
		if(isDefined(self.pers["admin"]) && self.pers["admin"])
		{
			if(isDefined(self.pers["adminStatus"]) && self.pers["adminStatus"] == 3)
				self.statusicon = "admin_icon";
			else
				self.statusicon = "";
		}
		else if(isDefined(self.pers["vip"]) && self.pers["vip"])
			self.statusicon = "vip_icon";
		else
			self.statusicon = "";
	}
	
	if(!isDefined(level.roundstarted) || !level.roundstarted)
		self.godmode = true;
	else
	{
		//self.godmode = false;
	
		if(isDefined(self.lowerMessage))
		{
			self.lowerMessage.label = &"";
			self.lowerMessage setText(&"");
		}
		
		if(self isMainAssassin())
		{
			if(game["customEvent"] != "traitors")
				self.statusicon = "assassins_logo";
		}
		else if(self isDog())
		{
			if(game["customEvent"] != "dogfight")
				self.statusicon = "hud_dog_melee";
		}
		else if(self isKing())
		{
			if(game["customEvent"] != "unknownking")
				self.statusicon = "guards_logo";
		}
		
		self thread maps\mp\gametypes\_vision::init();
		self thread maps\mp\gametypes\_huds::Crosshair();
		self thread maps\mp\gametypes\_bossmodels::SetBossModel();
		self thread maps\mp\gametypes\_weaponloadouts::giveweapons();
	}

	/*	removed because they get defined on first use - no need to waste this variables when they are maybe never called (like admin cmds)
	self.climbing = false;
	self.stickied = false;
	self.exploded = false;
	self.isFrozen = false;
	self.burnedout = false;
	self.inUfoMode = false;
	self.forcedBounce = false;
	self.isatoldorigin = true;
	self.triesToPlantSentry = false;
	self.IsOpeningCrate = undefined;
	self.droppedparachute = undefined;
	self.weaponCpAssassins = undefined;
	self.awaitingHardpoints = undefined;
	
	self.pers["carepackagetype"] = "carepackage";
	*/

	if(!isdefined(self.weaponstate))
		self.weaponstate = 1;
	
	if(isDefined(self.revivemark) && self.revivemark <= 15)
		Objective_Delete(self.revivemark);
	
	//why? wait .05;

	if(!isDefined(self.moneyhud))
		self thread maps\mp\gametypes\_huds::Cash();
	
	if(self isAGuard() || game["customEvent"] == "kingvsking")
	{
		if(game["customEvent"] == "hideandseek")
			self thread maps\mp\gametypes\_huds::propsControls();
	
		if(isDefined(self.pers["thirdperson"]))
		{
			if(!isDefined(self.killcamInThirdPerson) || self.killcamInThirdPerson != self.pers["thirdperson"])
				self setClientDvar("cg_thirdPerson", self.pers["thirdperson"]);
		}
	
		//only do this when he newly joins the team
		if(isDefined(self.joining_team))
		{
			/* gone with 1.8
			if(self getKtkStat(2412) == 1)
			{
				self setClientDvars("cur_team", teamrole,
									"aim_automelee_range", 128,
									"player_meleerange", 64,
									"player_MGuseRadius", 128,
									"cash", self.pers["score"],
									"gungame_cur", self.weaponstate,
									"gungame_max", level.GunGameWeapons.size-1,
									"cg_drawGun", 1);
			}
			else
			*/
			{
				self setClientDvars("cur_team", teamrole,
									"aim_automelee_range", 0,
									"player_meleerange", 64,
									"player_MGuseRadius", 128,
									"cash", self.pers["score"],
									"gungame_cur", self.weaponstate,
									"gungame_max", level.GunGameWeapons.size-1,
									"ammoCounterHide", 0,
									"cg_drawGun", 1);
			}
		}
	
		if(self HasWeapon("helicopter_mp"))
		{
			heli_path = getentarray("heli_loop_start", "targetname");

			if(!isDefined(heli_path))
				self ResetHardpointSlot(self GetSlotForHardpoint("helicopter_mp"));
		}
		
		if(!isDefined(self.gungameprogress))
			self thread maps\mp\gametypes\_huds::WeaponState();
			
		if(isDefined(self.pers["secondchance"]) && self.pers["secondchance"])
			self thread maps\mp\gametypes\_huds::ExtraLife();
	}
	else if(self isAnAssassin())
	{
		if(game["customEvent"] == "hideandseek")
			self thread maps\mp\gametypes\_props::teleportSeekerAway();
	
		if(self isDog() || game["customEvent"] == "dogfight")
		{
			self.assassintype = "dog";

			if(isDefined(self.pers["dogthirdperson"]))
			{
				if(!isDefined(self.killcamInThirdPerson) || self.killcamInThirdPerson != self.pers["dogthirdperson"])
					self setClientDvars("cg_thirdPerson", self.pers["dogthirdperson"], "cg_drawGun", 0);
			}		

			//only do this when he newly joins the team
			if(isDefined(self.joining_team))
			{
				if(isDefined(self.pers["dogthirdperson"]) && self.pers["dogthirdperson"])
				{
					self setClientDvars("cur_team", teamrole,
										"cg_thirdPerson", 1,
										"aim_automelee_range", 128,
										"player_MGuseRadius", 0,
										"cash", self.pers["score"],
										"ammoCounterHide", 1,
										"cg_drawGun", 0);
				}
				else
				{
					self setClientDvars("cur_team", teamrole,
										"cg_thirdPerson", 0,
										"aim_automelee_range", 128,
										"player_MGuseRadius", 0,
										"cash", self.pers["score"],
										"ammoCounterHide", 1,
										"cg_drawGun", 0);
				}
			}
		}
		else
		{
			if(isDefined(self.pers["thirdperson"]))
			{
				if(!isDefined(self.killcamInThirdPerson) || self.killcamInThirdPerson != self.pers["thirdperson"])
					self setClientDvar("cg_thirdPerson", self.pers["thirdperson"]);
			}
		
			if(self isMainAssassin())
				self.assassintype = "assassin";
			else
				self.assassintype = GetRandomAssassinType();
		
			//only do this when he newly joins the team
			if(isDefined(self.joining_team))
			{
				/* gone with 1.8
				if(self getKtkStat(2412) == 1)
				{
					self setClientDvars("cur_team", teamrole,
										"aim_automelee_range", 128,
										"player_meleerange", 64,
										"player_MGuseRadius", 128,
										"cash", self.pers["score"],
										"cg_drawGun", 1);
				}
				else
				*/
				{
					self setClientDvars("cur_team", teamrole,
										"aim_automelee_range", 0,
										"player_meleerange", 64,
										"player_MGuseRadius", 128,
										"cash", self.pers["score"],
										"ammoCounterHide", 0,
										"cg_drawGun", 1);
				}
			}
		
			if(!isDefined(self.prev_assassintype))
			{
				if(self.assassintype == "katana")
					self setClientDvars("aim_automelee_range", 0, "player_meleerange", 150, "ammoCounterHide", 1);
				else if(self.assassintype == "knife")
					self setClientDvar("ammoCounterHide", 1);
			}
			
			if(isDefined(self.prev_assassintype))
			{
				if(self.prev_assassintype == "katana")
				{
					if(self.assassintype != "katana")
					{
						if(self.assassintype != "knife")
							self setClientDvars("aim_automelee_range", 0, "player_meleerange", 64, "ammoCounterHide", 0);
						else
							self setClientDvars("aim_automelee_range", 0, "player_meleerange", 64, "ammoCounterHide", 1);
					}
				}
				else if(self.prev_assassintype == "knife")
				{
					if(self.assassintype != "knife")
					{
						if(self.assassintype != "katana")
							self setClientDvars("aim_automelee_range", 0, "player_meleerange", 64, "ammoCounterHide", 0);
						else
							self setClientDvars("aim_automelee_range", 0, "player_meleerange", 150, "ammoCounterHide", 1);
					}
				}
			}
		}
		
		self.prev_assassintype = self.assassintype;
		
		if(self HasWeapon(level.ktkWeapon["poisongas"]))
			self takeWeapon(level.ktkWeapon["poisongas"]);
			
		if(self HasWeapon(level.ktkWeapon["rccar"]))
			self takeWeapon(level.ktkWeapon["rccar"]);

		if(self HasWeapon("airstrike_mp"))
			self takeWeapon("airstrike_mp");

		if(self HasWeapon(level.ktkWeapon["mortars"]))
			self takeWeapon(level.ktkWeapon["mortars"]);

		if(self HasWeapon("helicopter_mp"))
			self takeWeapon("helicopter_mp");
			
		if(self HasWeapon(level.ktkWeapon["ac130"]))
			self takeWeapon(level.ktkWeapon["ac130"]);
			
		if(self HasWeapon(level.ktkWeapon["predator"]))
			self takeWeapon(level.ktkWeapon["predator"]);
		
		if(self HasWeapon(level.ktkWeapon["sentrygun"]))
			self takeWeapon(level.ktkWeapon["sentrygun"]);
		
		if(self HasWeapon(level.ktkWeapon["nuke"]))
			self takeWeapon(level.ktkWeapon["nuke"]);			
	}
}

GetRandomAssassinType()
{
	if(game["customEvent"] == "zombie" || game["customEvent"] == "knifeonly")
		return "knife";

	type[0] = "bolt";
	type[1] = "scope";
	type[2] = "strongscope";
	type[3] = "hardscope";
	
	if(game["customEvent"] != "hideandseek")
	{
		type[4] = "katana";
		type[5] = "knife";
	}
	
	level.AssassinClassChance[type[0]] = getDvarFloat("scr_class_percentage_bolt");
	level.AssassinClassChance[type[1]] = getDvarFloat("scr_class_percentage_scope");
	level.AssassinClassChance[type[2]] = getDvarFloat("scr_class_percentage_strongscope");
	level.AssassinClassChance[type[3]] = getDvarFloat("scr_class_percentage_hardscope");
	
	if(game["customEvent"] != "hideandseek")
	{
		level.AssassinClassChance[type[4]] = getDvarFloat("scr_class_percentage_katana");
		level.AssassinClassChance[type[5]] = getDvarFloat("scr_class_percentage_knife");
	}
	
	total = 0;
	for(i=0;i<type.size;i++)
	{
		if(level.AssassinClassChance[type[i]] > 1)
			level.AssassinClassChance[type[i]] = (level.AssassinClassChance[type[i]] / 10);
	
		total += level.AssassinClassChance[type[i]];
	}

	random = randomfloat(1);
	
	if(random > total)
		return type[randomint(type.size)];
	else
	{
		for(i=0;i<type.size;i++)
		{
			random -= level.AssassinClassChance[type[i]];
			if(random <= 0)
				return type[i];
		}
	}

	return type[randomint(type.size)];
}

WaitForPlayers()
{
	thread maps\mp\gametypes\_rotatemap::init();

	level.ktkPlayers = 0;
	level.ktkPlayerWaiter = true;

	minplayers = getDvarint("scr_mod_minplayers");
	maxWaitTimeBeforeEventReset = getDvarint("scr_mod_minplayers_event_resettime");
	
	if(game["customEvent"] != "none")
	{
		if(game["customEvent"] == "traitors" && minplayers < 3)
			minplayers = 3;
	}
	
	curWaitTime = 0;
	while(level.ktkPlayers < minplayers)
	{
		wait 1;
	
		//don't count the players in the teams if there are no players at all
		if(!level.players.size)
		{
			curWaitTime = 0;
			continue;
		}
		
		level.ktkPlayers = GetPlayersInTeam("axis") + GetPlayersInTeam("allies");
		
		if(!isDefined(level.ktk_bots_startRoundWhenEmpty) || !level.ktk_bots_startRoundWhenEmpty)
		{
			if(level.bots.size > 0)
				level.ktkPlayers -= level.bots.size;
		}
		
		for(i=0;i<level.players.size;i++)
		{
			if(!isDefined(level.players[i].minplayerhud))
				level.players[i] thread maps\mp\gametypes\_huds::minplayerHUD(minplayers);
		}
		
		curWaitTime++;
		
		if(maxWaitTimeBeforeEventReset > 0 && curWaitTime >= maxWaitTimeBeforeEventReset)
		{
			if(game["customEvent"] == "none")
			{
				level.KtKVoting = true;
			
				if(((curWaitTime-maxWaitTimeBeforeEventReset)/15) == int((curWaitTime-maxWaitTimeBeforeEventReset)/15))
				{
					if(!isDefined(level.KtKVoteInProgress))
					{
						exec("say ^7Don't want to wait? Start a vote to switch map/event");
						exec("say ^7type: ^1$vote map ^7or ^1$vote event ^7in chat!");
					}
					else
					{
						if(level.KtKVoteInProgress == "mapvote")
							exec("say ^7type: ^1$vote mapname ^7in chat!");
						else if(level.KtKVoteInProgress == "event")
							exec("say ^7type: ^1$vote eventname ^7in chat!");
					}
				}
			}
			else
			{
				exec("say ^7Not enough players to start event - falling back to normal ktk!");
				setDvar("admin_changeEvent", "none");
				wait 2;
				exec("map_restart"); //map_restart(false); default CoD4 function is just a fast_restart -> Risk to result in a Server CMD overflow
			}
		}
	}
	
	level.KtKVoting = false;
	level.ktkPlayerWaiter = false;
	
	if(game["customEvent"] == "lastkingstanding")
	{
		level.gameHadRealPlayers = false;
	
		if(level.ktkPlayers > level.bots.size)
			level.gameHadRealPlayers = true;
	}
	
	if(game["roundsplayed"] == 0 )
	{
		GameStartText = createServerFontString( "objective", 1.5 );
		GameStartText setPoint( "CENTER", "CENTER", 0, -20 );
		GameStartText.sort = 1001;
		GameStartText.label = &"MP_MATCH_STARTING_IN"; //GameStartText.label = &"The Game starts in: ";
		GameStartText.foreground = true;
		GameStartText.hidewheninmenu = true;
		
		GameStartTimer = createServerTimer( "objective", 1.4 );
		GameStartTimer setPoint( "CENTER", "CENTER", 0, 0 );
		GameStartTimer setTimer( level.roundstartdelay );
		GameStartTimer.sort = 1001;
		GameStartTimer.foreground = true;
		GameStartTimer.hideWhenInMenu = true;
		
		wait level.roundstartdelay;
		
		GameStartText destroyElem();
		GameStartTimer destroyElem();
	}
	
	if(game["customEvent"] == "lastkingstanding" || game["customEvent"] == "traitors" || game["customEvent"] == "hideandseek")
	{
		for(i=0;i<level.players.size;i++)
		{
			level.players[i].godmode = false;
			
			//Do i really need this? The mod does not use UAV
			//level.players[i] setclientdvar("g_compassshowenemies", "0");
			
			if(!level.players[i] isASpectator())
			{
				if(level.players[i] isAnAssassin())
				{
					if(game["customEvent"] == "hideandseek")
						level.players[i] [[level.switchTeam]](game["defenders"], false, true);
				}
			
				if(isAlive(level.players[i]))
				{
					if(level.numLives)
						level.players[i].pers["lives"]++;
				
					level.players[i] suicide();
								
					if(isDefined(level.players[i].pers["deaths"]) && level.players[i].pers["deaths"] > 0)
						level.players[i].pers["deaths"]--;
				}
						
				level.players[i] [[level.spawnClient]]();
			}
		}
	}
	else
	{
		for(i=0;i<level.players.size;i++)
		{
			level.players[i].godmode = false;
			
			//Do i really need this? The mod does not use UAV
			//level.players[i] setclientdvar("g_compassshowenemies", "0");

			if(!level.players[i] isASpectator())
			{
				if(level.players[i] isAnAssassin())
				{
					if(game["customEvent"] != "reversektk")
						level.players[i] [[level.switchTeam]](game["defenders"], false, true);
					else
					{
						if(isAlive(level.players[i]))
						{
							level.players[i] suicide();
								
							if(isDefined(level.players[i].pers["deaths"]) && level.players[i].pers["deaths"] > 0)
								level.players[i].pers["deaths"]--;
						}
						
						level.players[i] [[level.spawnClient]]();
					}
				}
				else
				{
					if(game["customEvent"] == "reversektk")
						level.players[i] [[level.switchTeam]](game["attackers"], false, true);
					else
					{
						if(isAlive(level.players[i]))
						{
							level.players[i] suicide();
								
							if(isDefined(level.players[i].pers["deaths"]) && level.players[i].pers["deaths"] > 0)
								level.players[i].pers["deaths"]--;
						}
						
						level.players[i] [[level.spawnClient]]();
					}
				}
			}
		}
	}

	thread StartRound();
	thread FreezePlayersUntilRoundStart();
}

FreezePlayersUntilRoundStart()
{	
	while(!level.roundstarted)
	{
		thread FreezePlayers(true, true);
		wait .1;
	}
	
	thread FreezePlayers(false, true);
}

FreezePlayers(status, affectBots)
{
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] isABot() && !affectBots)
			continue;
	
		if(game["customEvent"] == "hideandseek")
		{
			if(status && !level.roundstarted && level.players[i].pers["team"] == game["defenders"])
				continue;
		}
	
		level.players[i] freezeControls(status);
	}
}

StartRound()
{
	level endon("game_ended");

	visionSetNaked( "mpIntro", 0 );

	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] isASpectator() || level.players[i].sessionstate != "playing")
		{
			level.players[i] closeMenu();
			level.players[i] closeInGameMenu();
			level.players[i] openMenu(game["menu_team"]);
		}
	}

	if(game["customEvent"] != "lastkingstanding")
		PickImportantPlayers();
	
	if(game["customEvent"] == "kingvsking" || game["customEvent"] == "revolt")
		BalanceKtkTeams();
	
	matchStartText = createServerFontString( "objective", 1.5 );
	matchStartText setPoint( "CENTER", "CENTER", 0, -20 );
	matchStartText.sort = 1001;
	matchStartText setText( game["strings"]["match_starting_in"] );
	matchStartText.foreground = true;
	matchStartText.hidewheninmenu = true;
	
	matchStartTimer = createServerFontString( "objective", 1.4 );
	matchStartTimer setPoint( "CENTER", "CENTER", 0, 0 );
	
	if(game["customEvent"] == "hideandseek")
		matchStartTimer setTimer( 30 );
	else
		matchStartTimer setTimer( 3 );
	
	matchStartTimer.sort = 1001;
	matchStartTimer.foreground = true;
	matchStartTimer.hideWhenInMenu = true;
	
	if(game["customEvent"] == "hideandseek")
	{
		thread FreezePlayers(false, true);
		level.assassin thread maps\mp\gametypes\_props::teleportSeekerAway();
	}
	
	if(game["customEvent"] == "hideandseek")
		wait 30;
	else
		wait 3;
	
	visionSetNaked( getDvar( "mapname" ), 2.0 );
	
	matchStartText destroyElem();
	matchStartTimer destroyElem();

	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] getKtkStat(2363) == 1)
			level.players[i].weaponstate = 2;
		else
			level.players[i].weaponstate = 1;
		
		if(level.players[i] getKtkStat(2364) == 1)
			level.players[i].cur_kill_streak = 1;
		else
			level.players[i].cur_kill_streak = 0;
		
		if(level.players[i] isMainAssassin())
		{
			if(game["customEvent"] != "traitors")
				level.players[i].statusicon = "assassins_logo";
		}
		else if(level.players[i] isDog())
		{
			if(game["customEvent"] != "traitors")
				level.players[i].statusicon = "hud_dog_melee";
		}
		else if(level.players[i] isKing())
		{
			if(game["customEvent"] != "unknownking" && game["customEvent"] != "traitors")
				level.players[i].statusicon = "guards_logo";
		}
		
		level.players[i] thread maps\mp\gametypes\_weaponloadouts::giveweapons();
		level.players[i] thread maps\mp\gametypes\_huds::KingHealthHUD();
		level.players[i] thread maps\mp\gametypes\_vision::init();
		
		/*not needed - value changes when king picked and on every respawn
		if(level.players[i] isKing())
			level.players[i] setClientDvar("gungame_max", 1);
		else
			level.players[i] setClientDvar("gungame_max", level.GunGameWeapons.size-1);*/
			
		if(game["customEvent"] == "traitors")
		{
			if(!isDefined(level.players[i].isATraitor))
				level.players[i].isATraitor = false;
		
			if(!level.players[i].isATraitor && !level.players[i] isKing())
				level.players[i].isAnInnocent = true;
		}
		else if(game["customEvent"] == "lastkingstanding")
		{
			level.players[i].pers["kingtime"] = 0;
		}
		
		level.players[i] DeleteUnusedHardpointsFile();
	}

	level.roundstarted = true;
	level.firstblood = false;
	
	if(isDefined(level.king))
		level.king thread spawnCircle(200, 50, 12);
	
	thread monitorRealPlayerCount();
	thread AliveDefenders();
	thread PickTerminator();
	
	if(game["customEvent"] == "traitors")
		maps\mp\gametypes\_traitors::monitorTraitorEventEnd();
}

BalanceKtkTeams()
{
	assassinsArray = [];
	
	for(i=0;i<level.players.size;i++)
	{
		if(!isAlive(level.players[i]))
			continue;
			
		if(level.players[i] isKing())
			continue;
			
		if(level.players[i] isMainAssassin())
			continue;
			
		if(level.players[i] isSlave())
			continue;
			
		if(level.players[i] isDog())
			continue;
			
		assassinsArray[assassinsArray.size] = level.players[i];
	}
	
	while(GetPlayersInTeam(game["attackers"]) < GetPlayersInTeam(game["defenders"]) && assassinsArray.size > 0)
	{
		wait .05;
		
		assassinsArray = RemoveUndefinedEntriesFromArray(assassinsArray);
		random = randomInt(assassinsArray.size);
		
		if(isDefined(level.players[i]) && isPlayer(level.players[i]) && isAlive(level.players[i]))
			level.players[i] [[level.switchTeam]](game["attackers"], false, true);
			
		for(i=random;i<assassinsArray.size;i++)
		{
			assassinsArray[i] = undefined;
			
			if(isDefined(assassinsArray[i+1]))
				assassinsArray[i] = assassinsArray[i+1];
		}
	}
}

PickImportantPlayers()
{
	level endon("game_ended");

	UpdateSelectionHud("waiting", "", level.pickdelay);

	//in first round they are all undefined
	if(!isDefined(game["last_assassin"]))
	{
		game["last_traitor"] = 999;
		game["last_assassin"] = 999;
		game["last_helper"] = 999;
		game["last_king"] = 999;
	}
	
	game["traitor"] = undefined;
	game["assassin"] = undefined;
	game["helper"] = undefined;
	game["king"] = undefined;
	dogPickable = false;

	if(getDvarInt("scr_ktk_dog") == 1 && GetPlayersInTeam(game["defenders"]) >= getDvarInt("scr_ktk_dog_players"))
	{
		if(game["customEvent"] != "kingvsking" && game["customEvent"] != "traitors" && game["customEvent"] != "hideandseek")
			dogPickable = true;
	}
	
	character = "assassin";
	selecting = "PICK_ASSASSIN";
	selected = "PICKED_ASSASSIN_IS";

	for(k=0;k<3;k++)
	{
		if(k == 0)
		{
			if(game["customEvent"] == "traitors")
				continue;
		}	
		else if(k == 1)
		{
			if(level.ktkPlayers + level.bots.size <= 2)
				continue;
		
			if(game["customEvent"] == "traitors" || game["customEvent"] == "hideandseek")
				continue;
		
			/*if(dogPickable)
			{
				character = "helper";
				selecting = "PICK_DOG";
				selected = "PICKED_DOG_IS";
			}
			else*/
			{
				character = "helper";
				selecting = "PICK_SLAVE";
				selected = "PICKED_SLAVE_IS";
			}
		}
		else if(k == 2)
		{
			character = "king";
			selecting = "PICK_KING";
			selected = "PICKED_KING_IS";
		}
	
		UpdateSelectionHud(selecting, "", level.pickdelay);
		
		wait level.pickdelay;
		
		SelectPlayerForRole(character);
		
		if(isDefined(game[character]) && isPlayer(game[character]))
		{
			if(character == "assassin" || (isDefined(game[character]) && character == "helper"))
			{
				if(isDefined(game[character]) && character == "assassin")
					level.assassin = game[character];
			
				if(game["customEvent"] == "reversektk")
				{
					if((character == "assassin" && !game[character] isAnAssassin()) || (character == "helper" && !game[character] isAGuard()))
						game[character] [[level.switchTeam]](game["attackers"], false, true);
				}
				else
				{
					if(!game[character] isAnAssassin())
						game[character] [[level.switchTeam]](game["attackers"], false, true);
				}

				if(isDefined(game[character]) && character == "helper")
				{
					if(game[character] getKtkStat(2415) == 1)
						dogPickable = false;
				
					if(!dogPickable)
						level.slave = game[character];
					else
					{
						level.dog = game[character];
						selected = "PICKED_DOG_IS";
						game[character] thread maps\mp\gametypes\_vision::init();
						game[character] thread CheckClimbing(game[character]);
					}
				}
			}
			else if(character == "king")
			{
				level.king = game[character];
			
				if(!game[character] isAGuard())
					game[character] [[level.switchTeam]](game["defenders"], false, true);

				if(game["customEvent"] != "unknownking" && game["customEvent"] != "traitors")
				{
					game[character].headiconteam = game["defenders"];
					game[character].headicon = "king_marker";
					game[character].statusicon = "guards_logo";
					
					level.kingmarker = undefined;
					
					if(game[character] getKtkStat(2365) == 0)
					{
						level.kingmarker = maps\mp\gametypes\_gameobjects::getNextObjID();
					
						//Sadly the game does not allow more than 15 elements on the minimap
						if(isDefined(level.kingmarker) && level.kingmarker <= 15)
						{
							Objective_Add(level.kingmarker, "active", game[character].origin);
							Objective_OnEntity( level.kingmarker, game[character] );
							Objective_Team(level.kingmarker, game["defenders"]);
						}
					}
				}
				
				game[character] thread EndOnKingTeamswitch();
			}
			
			game[character] thread maps\mp\gametypes\_bossmodels::SetBossModel();
			
			if(game["customEvent"] != "unknownking" && game["customEvent"] != "traitors")
				UpdateSelectionHud(selected, game[character].name, 0);
			else
			{
				if(character != "king")
					UpdateSelectionHud(selected, game[character].name, 0);
				else
				{
					UpdateSelectionHud(selected, "********", 0);

					scr_iPrintlnBold("EVENT_UNKNOWN_KING_HINT", game[character]);
				}
			}
			
			DebugMessage(1, "The " + character + " is: " + game[character].name);
		}
	wait 1;
	}

	if(!isDefined(game["king"]) || !isPlayer(game["king"]))
	{
		game["last_king"] = 999;
		game["last_king_guid"] = undefined;
	}
	else
	{
		game["last_king"] = game["king"] GetEntityNumber();
		game["last_king_guid"] = game["king"].guid; //game["king"] GetUniquePlayerID();
	}
	
	if(!isDefined(game["assassin"]) || !isPlayer(game["assassin"]))
	{
		game["last_assassin"] = 999;
		game["last_assassin_guid"] = undefined;
	}
	else
	{
		game["last_assassin"] = game["assassin"] GetEntityNumber();
		game["last_assassin_guid"] = game["assassin"].guid; //game["assassin"] GetUniquePlayerID();
	}
	
	if(!isDefined(game["helper"]) || !isPlayer(game["helper"]))
	{
		game["last_helper"] = 999;
		game["last_helper_guid"] = undefined;
	}
	else
	{
		game["last_helper"] = game["helper"] GetEntityNumber();
		game["last_helper_guid"] = game["helper"].guid; //game["helper"] GetUniquePlayerID();();
	}
	
	DeleteSelectionHud();
	
	if(game["customEvent"] == "traitors")
	{
		traitorCount = int(level.ktkPlayers * 0.25);
		
		if(traitorCount <= 0)
			traitorCount = 1;
	
		for(i=1;i<=traitorCount;i++)
		{
			SelectPlayerForRole("traitor");
			
			if(isDefined(game["traitor"]) && isPlayer(game["traitor"]))
			{
				game["traitor"].isATraitor = true;
				game["traitor"] SetHardpointToSlot("weapon", level.ktkWeapon["marker"], false);
				
				scr_iPrintlnBold("EVENT_TRAITOR_HINT", game["traitor"]);
			}
		}
	}
}

EnoughPlayersForSelection()
{
	if(level.players.size < getDvarInt("scr_mod_minplayers"))
		return false;
	
	if(level.teamBased)
		level.ktkPlayers = GetTeamPlayersAlive(game["attackers"]) + GetTeamPlayersAlive(game["defenders"]);
	else
		level.ktkPlayers = level.players.size;
		
	if(level.bots.size > 0)
		level.ktkPlayers -= level.bots.size;
		
	if((level.ktkPlayers + level.bots.size) < getDvarInt("scr_mod_minplayers"))
		return false;
		
	return true;
}

SelectPlayerForRole(type)
{
	if(!EnoughPlayersForSelection())
		onEndGame("none", "SELECTION_IMPOSSIBLE");

	playersForRole = SetPlayerArrayForRole(type);
	
	if(!isDefined(playersForRole) || !playersForRole.size)
		onEndGame("none", "SELECTION_IMPOSSIBLE");

	//No selection possible when 3 players and following happens:
	//Old helper is new assassin -> Old assassin is new helper -> Old king would be new king
	//So here the fix:
	//Old helper is new assassin -> Check which of the 2 players was old king and make him new helper -> Old assassin is now new king
	if(type != "helper")
	{
		playersForRole = reorganizeSelectionArray(type, playersForRole);
		game[type] = playersForRole[randomInt(playersForRole.size)];
	}
	else
	{
		if(playersForRole.size != 2)
		{
			playersForRole = reorganizeSelectionArray(type, playersForRole);
			game[type] = playersForRole[randomInt(playersForRole.size)];
		}
		else
		{
			if(playersForRole[0] GetEntityNumber() == game["last_king"])
				game[type] = playersForRole[0];
			else if(playersForRole[1] GetEntityNumber() == game["last_king"])
				game[type] = playersForRole[1];
			else
				game[type] = playersForRole[randomInt(playersForRole.size)];
		}
	}
	
	if(!isDefined(game[type]))
		onEndGame("none", "SELECTION_IMPOSSIBLE");
}

SetPlayerArrayForRole(type)
{
	playersForRole = [];

	for(i=0;i<level.players.size;i++)
	{
		if(!isAlive(level.players[i]) || level.players[i] isASpectator())
			continue;
		
		if(level.players[i] GetEntityNumber() == game["last_" + type])
			continue;
		
		//don't pick a bot when enough players online
		if(level.players[i] isABot() && level.ktkPlayers >= 3)
		{
			if(isDefined(level.ktk_bots_assignRole) && !level.ktk_bots_assignRole) 
				continue;
		}
		
		if(type == "traitor" && isDefined(game["king"]) && level.players[i] == game["king"])
			continue;
			
		if(type == "helper" && isDefined(game["assassin"]) && level.players[i] == game["assassin"])
			continue;
		
		if(type == "king" && isDefined(game["assassin"]) && level.players[i] == game["assassin"])
			continue;
		
		if(type == "king" && isDefined(game["helper"]) && level.players[i] == game["helper"])
			continue;
		
		playersForRole[playersForRole.size] = level.players[i];
	}
	
	return playersForRole;
}

reorganizeSelectionArray(type, playersForRole)
{
	//right now its: game[type] = playersForRole[randomInt(playersForRole.size)];
	//where game[type] is assassin/slave/dog/king
	//and playersForRole is the array with the available players for the above roles
	
	newArray = [];
	playerRolePreference = undefined;
	for(i=0;i<playersForRole.size;i++)
	{
		newArray[newArray.size] = playersForRole[i];

		if(type == "assassin")
			playerRolePreference = playersForRole[i] getKtkStat(2367);
		else if(type == "helper")
			playerRolePreference = playersForRole[i] getKtkStat(2369);
		else if(type == "king")
			playerRolePreference = playersForRole[i] getKtkStat(2368);

		if(isDefined(playerRolePreference) && playerRolePreference < 2)
		{
			for(j=0;j<=playerRolePreference;j++)
			{
				newArray[newArray.size] = playersForRole[i];
				newArray[newArray.size] = playersForRole[i];
			}
		}
	}
	
	newArray = shuffleArray(newArray);	
	return newArray;
}

UpdateSelectionHud(text, subtext, delay)
{
	for(i=0;i<level.players.size;i++)
	{
		if(!isDefined(level.players[i].SelectionText))
		{
			level.players[i].SelectionText = level.players[i] createFontString( "objective", 1.5 );
			level.players[i].SelectionText setPoint( "CENTER", "CENTER", 0, -20 );
			level.players[i].SelectionText.sort = 1001;
			level.players[i].SelectionText.foreground = true;
			level.players[i].SelectionText.hidewheninmenu = true;
		}

		if(!isDefined(level.players[i].SelectionTimer) && delay > 0)
		{
			level.players[i].SelectionTimer = level.players[i] createFontString( "objective", 1.4 );
			level.players[i].SelectionTimer setPoint( "CENTER", "CENTER", 0, 0 );
			level.players[i].SelectionTimer.sort = 1001;
			level.players[i].SelectionTimer.foreground = true;
			level.players[i].SelectionTimer.hideWhenInMenu = true;
		}
		
		if(text == "waiting")
		{
			level.players[i].SelectionTimer.alpha = 0;
			level.players[i].SelectionTimer setTimer(delay);
			level.players[i].SelectionText.label = &"MP_WAITING_MATCH";
		}
		else
		{
			if(delay > 0)
			{
				if(isDefined(level.players[i].SelectionTimer))
				{
					level.players[i].SelectionTimer.alpha = 1;
					level.players[i].SelectionTimer setTimer(delay);
				}
			}
			else
			{
				if(isDefined(level.players[i].SelectionTimer))
					level.players[i].SelectionTimer destroyElem();
			}

			if(text == "PICK_SLAVE")
				level.players[i].SelectionText.label = level.players[i] GetLocalizedString("PICKING_ASS_SLAVE_DOG"); //&"Picking the Assassin's Dog or Slave";
			else
				level.players[i].SelectionText.label = level.players[i] GetLocalizedString(text);
			
			if(!isDefined(subtext) || subtext == "")
				level.players[i].SelectionText setText("");
			else
				level.players[i].SelectionText setText(subtext);
		}
	}
}

DeleteSelectionHud()
{
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].SelectionText))
			level.players[i].SelectionText destroyElem();

		if(isDefined(level.players[i].SelectionTimer))
			level.players[i].SelectionTimer destroyElem();
	}
}

EndOnKingTeamswitch()
{
	self endon("disconnect");

	while(1)
	{
		self waittill("joined_team");
		
		self.headiconteam = game["defenders"];
		self.headicon = "king_marker";
		
		if(!self isAGuard())
		{
			if(!level.roundstarted || game["customEvent"] == "kingvsking" || game["customEvent"] == "traitors")
				self [[level.switchTeam]](game["defenders"], false, true);
			else
			{	
				wait .1; //needed, else the server crashes
				
				if(game["customEvent"] == "traitors")
					thread onEndGame("traitors", "KING_DIED", "died");
				else
					thread onEndGame(game["attackers"], "KING_DIED", "died");
			
				break;
			}
		}
	}
}

PickTerminator()
{
	level.terminator = undefined;
	
	if(game["customEvent"] == "kingvsking" || game["customEvent"] == "revolt" || game["customEvent"] == "traitors" || game["customEvent"] == "hideandseek")
		return;
	
	if(getdvarint("scr_ktk_terminator") > 0)
	{
		while(!isDefined(level.king))
			wait .1;
			
		wait (getDvarFloat("scr_ktk_terminator_delay")*60);
		
		while(1)
		{
			if(GetPlayersInTeam(game["defenders"]) >= 2 && GetPlayersInTeam(game["attackers"]) >= getDvarInt("scr_ktk_terminator_players"))
			{
				level.terminator = level.players[randomint(level.players.size)];
	
				while(1) 
				{
				wait .1;
					if(!level.roundstarted)
						break;
				
					if(!isAlive(level.terminator) || !level.terminator isAGuard() || level.king isTerminator() || level.terminator isInRCToy() || level.terminator isInMannedHelicopter() || level.terminator isInAC130() || level.terminator isInLastStand())
						level.terminator = level.players[randomint(level.players.size)];
					else 
					{
						scr_iPrintLnBold("TERMINATOR_IS", undefined, level.terminator.name);
						
						level.terminator GetInventory();
						level.terminator.maxhealth = getDvarInt("scr_ktk_terminator_health");
						level.terminator.health = level.terminator.maxhealth;
						level.terminator takeAllGuns();
						level.terminator thread maps\mp\gametypes\_bossmodels::SetBossModel();
						level.terminator thread maps\mp\gametypes\_huds::TerminatorHUD();
						level.terminator thread maps\mp\gametypes\_vision::init();
						level.terminator SetMoveSpeedScale(0.85);
						level.terminator giveWeapon(level.ktkWeapon["minigun"] );
						level.terminator GiveMaxAmmo( level.ktkWeapon["minigun"]  );
						wait .1;
						
						if(level.terminator isABot())
							level.terminator SetSpawnWeapon(level.ktkWeapon["minigun"]);
						else
							level.terminator SwitchToWeapon(level.ktkWeapon["minigun"]);
						
						if(level.terminator HasPerk("specialty_pistoldeath"))
							level.terminator UnSetPerk( "specialty_pistoldeath" );
							
						if(level.terminator HasPerk("specialty_armorvest"))
							level.terminator UnSetPerk( "specialty_armorvest" );
							
						break;
					}
				}
				break;
			}
		wait .1;
		}
		
		while(1)
		{
		wait .1;
		
			if(!isDefined(level.terminator))
				break;

			if(level.terminator getWeaponAmmoClip(level.ktkWeapon["minigun"] ) <= 0)
			{
				if(isDefined(level.terminator.juggernaut))
					level.terminator.juggernaut destroy();
				
				level.terminator thread maps\mp\gametypes\_vision::init();
				level.terminator GiveInventory();
				level.terminator SwitchToPreviousWeapon();
				level.terminator = undefined;
				break;
			}
		}
	}
}

//players gain xp by staying close to the king
spawnCircle(radius, points, delay)
{
	level endon("game_ended");
	
	self endon("disconnect");
	self endon("death");

	while(!isDefined(level.roundstarted) || !level.roundstarted)
		wait .05;
	
	if(game["customEvent"] == "reversektk")
	{
		while(1)
		{
			wait delay;
		
			if(isDefined(level.gameEnded) && level.gameEnded)
				break;
		
			if(!isDefined(level.roundstarted) || !level.roundstarted)
				break;
				
			if(!isDefined(level.assassin))
				break;
		
			for(i=0;i<level.players.size;i++)
			{
				if(level.players[i] isAnAssassin() && !level.players[i] isMainAssassin() && !level.players[i] isABot())
				{
					if(isDefined(level.assassin) && Distance(level.assassin.origin, level.players[i].origin) < radius)
					{
						level.players[i] maps\mp\gametypes\_rank::giveRankXP( "kill", points );
						level.players[i] notify ( "update_playerscore_hud" );
						level.players[i].guardtime++;
					}
				}
			}
		}
	}
	else
	{
		while(1)
		{
			wait delay;
		
			if(isDefined(level.gameEnded) && level.gameEnded)
				break;
		
			if(!isDefined(level.roundstarted) || !level.roundstarted)
				break;
				
			if(!isDefined(level.king))
				break;
		
			for(i=0;i<level.players.size;i++)
			{
				if(level.players[i] isAGuard() && !level.players[i] isKing() && !level.players[i] isABot())
				{
					if(isDefined(level.king) && Distance(level.king.origin, level.players[i].origin) < radius)
					{
						level.players[i] maps\mp\gametypes\_rank::giveRankXP( "kill", points );
						level.players[i] notify ( "update_playerscore_hud" );
						level.players[i].guardtime++;
					}
				}
			}
		}
	}
}

AliveDefenders()
{
	if(game["customEvent"] != "none")
		return;

	challenge = false;

	while(1)
	{
	wait .1;
		if(!level.roundstarted)
			break;
	
		if(GetTeamPlayersAlive(game["defenders"]) == 2 && !challenge)
		{
			for(i=0;i<level.players.size;i++)
			{
				if(level.players[i] isAGuard() && !level.players[i] isKing())
				{
					level.players[i] maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "last_alive" );
					level.players[i] maps\mp\gametypes\_missions::lastManSD();
					break;
				}
			}
			challenge = true;
		}
	}
}

monitorRealPlayerCount()
{
	level endon("game_ended");

	level.ktkPlayers = GetPlayersInTeam("axis") + GetPlayersInTeam("allies");
		
	if(level.bots.size > 0)
		level.ktkPlayers -= level.bots.size;
}

onPlayerDeath()
{
	self endon("disconnect");
	self waittill("death");
	
	self.godmode = false;
	
	//reset vision - like when in thermal
	self.thermal = false;
	self thread maps\mp\gametypes\_vision::init();
	
	if(game["customEvent"] == "lastkingstanding")
	{
		self.pers["kingtime"] = int(maps\mp\gametypes\_globallogic::getTimePassed()/1000);
		return;
	}
		
	if(!level.roundstarted)
		return;
	
	if(game["customEvent"] == "sniperonly")
	{
		if(self getKtkStat(2363) == 1)
			self.weaponstate = 2;
		else
			self.weaponstate = 1;
	}
	
	if(game["customEvent"] == "hideandseek")
	{
		if(isDefined(self.propsModel))
			self.propsModel delete();
	}
	
	if(self.cur_death_streak >= 50)
		self maps\mp\gametypes\_missions::processChallenge( "ch_ktk_badday"); 
		
	if(self isAGuard())
	{
		if(self isKing())
		{
			//don't end the round when he was switched to spec
			if(isDefined(self.pers["afkteam"]))
				return;
		
			if(game["customEvent"] != "kingvsking" && game["customEvent"] != "reversektk")
			{
				if(game["customEvent"] == "traitors")
					thread onEndGame("traitors", "KING_DIED", "died");
				else
					thread onEndGame(game["attackers"], "KING_DIED", "died");
			}
		}
		else
		{
			if(self.guardtime >= 30)
				self maps\mp\gametypes\_missions::processChallenge("ch_ktk_duty"); 
			
			if(self isTerminator())
				level.terminator = undefined;
			
			//why did i put this here? i cant remember
			//self waittill("spawned_player");
			
			//if(!isDefined(self.switchedByKing) || !self.switchedByKing)
			{
				if(game["customEvent"] != "traitors")
					self thread maps\mp\gametypes\_killevents::MakeGuardAnAssassin();
			}
			
			//self.switchedByKing = false;
		}
	}
	else if(self isAnAssassin())
	{
		if(game["customEvent"] == "reversektk")
		{
			if(self isMainAssassin())
				thread onEndGame(game["defenders"], "KING_DIED", "died");
			else if(self isDog())
				level.dog = undefined;
			else
			{
				self thread maps\mp\gametypes\_killevents::MakeAssassinAGuard();
			}
		}
	}
	
	if(game["customEvent"] == "traitors")
	{
		if(self isKing())
			return;
		
		if(isDefined(self.isATraitor) && self.isATraitor)
			scr_iPrintlnBold("EVENT_TRAITOR_KILLED");
		else if(isDefined(self.isAnInnocent) && self.isAnInnocent)
			scr_iPrintlnBold("EVENT_INNOCENT_KILLED");
	}
}

ReselectImportantPlayer()
{
	if(self isAGuard()) 
	{
		if(!self isKing())
		{
			//normal guard left - do nothing
			return;
		}
		else
		{
			wait .1; //needed, else the server crashes
			
			if(isDefined(level.kingmarker) && level.kingmarker <= 15)
			{
				Objective_Delete(level.kingmarker);
				level.kingmarker = undefined;
			}
			
			if(GetPlayersInTeam(game["defenders"]) == 0)
			{
				if(game["customEvent"] == "traitors")
					thread onEndGame("traitors", "KING_LEFT", "left");
				else
					thread onEndGame(game["attackers"], "KING_LEFT", "left");
			}
			else
			{
				if((maps\mp\gametypes\_globallogic::getTimePassed() / 1000) > getDvarInt("scr_ktk_picknewkingtime"))
				{
					if(game["customEvent"] == "traitors")
						thread onEndGame("traitors", "KING_LEFT", "left");
					else
						thread onEndGame(game["attackers"], "KING_LEFT", "left");
					
					return;
				}				
			
				possibleKing = [];
				randomKing = false;
				for(i=0;i<level.players.size;i++)
				{
					if(level.players[i] isAGuard())
					{
						if(GetPlayersInTeam(game["defenders"]) <= 1)
						{
							if(game["customEvent"] == "traitors")
								thread onEndGame("traitors", "KING_LEFT", "left");
							else
								thread onEndGame(game["attackers"], "KING_LEFT", "left");
							
							return;
						}
						else
						{
							randomKing = true;
						
							if(!isAlive(level.players[i]) || 
							level.players[i] isInRCToy() ||
							level.players[i] isInParachute() ||
							level.players[i] isCarryingExpBolt() ||
							level.players[i] isInLastStand() ||
							!level.players[i] isAtOldOrigin() ||
							level.players[i] isTerminator() ||
							level.players[i] isInAC130() ||
							level.players[i] isInMannedHelicopterTurret() )
							{
								continue;
							}

							possibleKing[possibleKing.size] = level.players[i];
						}
					}
				}		
			
				if(randomKing)
				{
					if(possibleKing.size > 0)
					{
						kingBots = [];
						kingPlayers = [];
						for(i=0;i<possibleKing.size;i++)
						{
							if(possibleKing[i] isABot())
								kingBots[kingBots.size] = possibleKing[i];
							else
								kingPlayers[kingPlayers.size] = possibleKing[i];
						}
						
						level.king = possibleKing[randomInt(possibleKing.size)];
						
						//don't pick a bot when enough players online				
						if(kingPlayers.size >= 2) //was 3
						{
							if(isDefined(level.ktk_bots_assignRole) && !level.ktk_bots_assignRole)
								level.king = kingPlayers[randomInt(kingPlayers.size)];
						}
					}
					else
					{
						if(game["customEvent"] == "traitors")
							thread onEndGame("traitors", "KING_LEFT", "left");
						else
							thread onEndGame(game["attackers"], "KING_LEFT", "left");
							
						return;
					}
				}
		
				if(!isDefined(level.king))
				{
					if(game["customEvent"] == "traitors")
						thread onEndGame("traitors", "KING_LEFT", "left");
					else
						thread onEndGame(game["attackers"], "KING_LEFT", "left");
					
					return;
				}

				level.king thread maps\mp\gametypes\_bossmodels::SetBossModel();
				level.king thread maps\mp\gametypes\_weaponloadouts::giveweapons();
				level.king thread maps\mp\gametypes\_vision::init();

				scr_iPrintlnBold("KING_LEFT");

				level.king thread spawnCircle(200, 50, 12);

				//For the unknownKing event - All guards look like the king
				if(game["customEvent"] == "unknownking" || game["customEvent"] == "traitors")
					scr_iPrintlnBold("NEW_KING_IS", undefined, "********");
				else
				{
					scr_iPrintlnBold("NEW_KING_IS", undefined, level.king.name + "^7!");
				
					level.king setClientDvar("gungame_max", 1);
					
					level.king.statusicon = "guards_logo";
				
					if(!isDefined(level.kingmarker))
					{
						if(level.king getKtkStat(2365) == 0)
						{
							level.kingmarker = maps\mp\gametypes\_gameobjects::getNextObjID();

							//Sadly the game does not allow more than 15 elements on the minimap
							if(isDefined(level.kingmarker) && level.kingmarker <= 15)
							{
								Objective_Add(level.kingmarker, "active", level.king.origin);
								Objective_OnEntity(level.kingmarker, level.king);
								Objective_Team(level.kingmarker, game["defenders"]);
							}
						}
					}
				}
				
				for(i=0;i<level.players.size;i++)
				{
					if(isDefined(level.players[i].kinghud_text))
						level.players[i].kinghud_text setText(level.king.name);
						
					level.players[i] thread maps\mp\gametypes\_huds::KingHealthHUD();
				}
			}
		}
	}
	else 
	{
		if(self isMainAssassin())
		{
			if(!self isABot())
				scr_iPrintlnBold("ASSASSIN_LEFT");
			
			newSelectionOf = "assassin";
		}
		else if(self isSlave() || self isDog())
		{
			if(!self isABot())
				scr_iPrintlnBold("HELPER_LEFT");
				
			newSelectionOf = "helper";
		}
		else
		{
			//normal assassin left - do nothing
			return;
		}
		
		wait .1; //needed, else the server crashes

		newAssignedPlayer = undefined;
		availableNewPlayers = [];

		while(!isDefined(level.roundstarted) || !level.roundstarted)
			wait .1;

		//try to make an existing assassin the new slave/dog/assassin
		if(GetPlayersInTeam(game["attackers"]) > 1)
		{
			for(i=0;i<level.players.size;i++)
			{
				if(level.players[i] isAnAssassin() && !level.players[i] isMainAssassin())
					availableNewPlayers[availableNewPlayers.size] = level.players[i];
			}
		}
		//only the main assassin in attackers team - try to use a guard
		else
		{
			//only the king available - pick no new slave/dog/assassin
			if(GetPlayersInTeam(game["defenders"]) == 1)
				return;

			for(i=0;i<level.players.size;i++)
			{
				if(level.players[i] isAGuard())
				{
					if(!isAlive(level.players[i]) || 
					level.players[i] isInRCToy() ||
					level.players[i] isInParachute() ||
					level.players[i] isKing() ||
					level.players[i] isDog() || level.players[i] isSlave() ||
					level.players[i] isCarryingExpBolt() ||
					level.players[i] isInLastStand() ||
					!level.players[i] isAtOldOrigin() ||
					level.players[i] isInAC130() ||
					level.players[i] isInMannedHelicopterTurret() )
					{
						
						if(GetPlayersInTeam(game["defenders"]) == 2 && !level.players[i] isKing())
							break;

						continue;
					}
					
					availableNewPlayers[availableNewPlayers.size] = level.players[i];
				}
			}
		}

		if(availableNewPlayers.size <= 0)
			scr_iPrintlnBold("NO_NEW_SELECTION_POSSIBLE");
		else
		{
			assassinBots = [];
			assassinPlayers = [];
			for(i=0;i<availableNewPlayers.size;i++)
			{
				if(availableNewPlayers[i] isABot())
					assassinBots[assassinPlayers.size] = assassinBots[i];
				else
					assassinPlayers[assassinPlayers.size] = availableNewPlayers[i];
			}
			
			newAssignedPlayer = availableNewPlayers[randomint(availableNewPlayers.size)];
					
			//don't pick a bot when enough players online				
			if(assassinPlayers.size >= 2) //was 3
			{
				if(isDefined(level.ktk_bots_assignRole) && !level.ktk_bots_assignRole)
					newAssignedPlayer = assassinPlayers[randomInt(assassinPlayers.size)];
			}
		}

		if(isDefined(newAssignedPlayer))
		{
			if(newSelectionOf == "assassin")
			{
				scr_iPrintlnBold("NEW_ASSASSIN_IS", undefined, newAssignedPlayer.name + "^7!");
				newAssignedPlayer thread maps\mp\gametypes\_bossmodels::SetBossModel();
				newAssignedPlayer.statusicon = "assassins_logo";
				level.assassin = newAssignedPlayer;
				
				level.assassin thread spawnCircle(200, 50, 12);
			}			
			else
			{
				if(newAssignedPlayer getKtkStat(2415) == 1)
				{
					scr_iPrintlnBold("NEW_SLAVE_IS", undefined, newAssignedPlayer.name + "^7!");
					level.slave = newAssignedPlayer;
				}
				else
				{
					scr_iPrintlnBold("NEW_DOG_IS", undefined, newAssignedPlayer.name + "^7!");
					newAssignedPlayer thread maps\mp\gametypes\_vision::init();
					newAssignedPlayer thread CheckClimbing(newAssignedPlayer);
					newAssignedPlayer thread maps\mp\gametypes\_bossmodels::SetBossModel();
					newAssignedPlayer.statusicon = "hud_dog_melee";
					level.dog = newAssignedPlayer;
				}
			}

			newAssignedPlayer thread switchWhenPossible();
		}
	}
}

switchWhenPossible()
{
	self endon("disconnect");
	
	while(
		!isAlive(self) || 
		self isInRCToy() ||
		self isInParachute() ||
		self isKing() ||
		self isCarryingExpBolt() ||
		self isInLastStand() ||
		!self isAtOldOrigin() ||
		self isInAC130() ||
		self isInMannedHelicopterTurret() )
	{
		wait .1;
	}
	
	if(!self isAnAssassin())
		self [[level.switchTeam]](game["attackers"], false, true);
}

onTimeLimit()
{
	if(game["customEvent"] == "kingvsking")
	{
		if(GetPlayersInTeam(game["attackers"]) >= GetPlayersInTeam(game["defenders"]))
			onEndGame(game["attackers"], "WIN_ATTACKERS", undefined);
		else
			onEndGame(game["defenders"], "WIN_DEFENDERS", undefined);
	}
	else
	{
		//iPrintLnBold("timeLimit");
		
		if(level.teamBased)
			onEndGame(game["defenders"], "KING_SURVIVED", "survived");
		else
		{
			winner = maps\mp\gametypes\_globallogic::getHighestScoringPlayer();
			onEndGame(winner, "KING_SURVIVED", "survived");
		}
	}
}

onRoundSwitch()
{
	if ( !isdefined( game["switchedsides"] ) )
		game["switchedsides"] = false;
	
	level.halftimeType = "halftime";
	game["switchedsides"] = !game["switchedsides"];
	
	//normal s&d or sab side switches do also switch the score
	//attackers score 2 -> round switch -> defenders score 2
	//defenders score 0 -> round switch -> attackers score 0
	//but we want to keep the score
	score_guards = [[level._getTeamScore]]( game["defenders"] );
	score_assassins = [[level._getTeamScore]]( game["attackers"] ); 
	[[level._setTeamScore]]( game["defenders"], score_assassins );
	[[level._setTeamScore]]( game["attackers"], score_guards );
}


onEndGame(winningTeam, endReasonText, event)
{
	//return if the game already ended
	//this avoids to call this cod3 twice when 2 onEndGame calls happens
	//like king was a bot (that is kicked during round end screen)
	if(isDefined(level.gameEnded) && level.gameEnded)
		return;

	DebugMessage(1, "Round end: " + endReasonText);

	level.roundstarted = false;
	
	thread DeleteSelectionHud();
	
	if(isDefined(game["last_assassin_guid"]))
		game["last_assassin_guid"] = undefined;
	
	if(isDefined(game["last_helper_guid"]))
		game["last_helper_guid"] = undefined;
	
	if(isDefined(game["last_king_guid"]))
		game["last_king_guid"] = undefined;

	if(isDefined(level.kingmarker) && level.kingmarker <= 15)
		Objective_Delete(level.kingmarker);
		
	if(level.teamBased)
	{	
		if(isDefined(level.king))
		{
			level.king.pers["kingtime"] = int(maps\mp\gametypes\_globallogic::getTimePassed()/1000);
			
			if(winningTeam == game["defenders"])
			{
				level.king maps\mp\gametypes\_rank::giveRankXP( "kill", 200 );
				level.king notify ( "update_playerscore_hud" );
			}
		}
		
		if ( isdefined( winningTeam ) && (winningTeam == game["defenders"] || winningTeam == game["attackers"]) )
			[[level._setTeamScore]]( winningTeam, [[level._getTeamScore]]( winningTeam ) + 1 );
	}
	else
	{
	
	}
	
	thread maps\mp\gametypes\_globallogic::endGame( winningTeam, endReasonText );
	thread maps\mp\gametypes\_announcer::roundannouncer(event);
	
	if(getDvarInt("scr_mod_finalkillcam") == 1)
		level waittill("end_killcam");
}

onEndGameElimStyle(winningPlayer)
{
	if(isDefined(winningPlayer) && isPlayer(winningPlayer))
	{
		curValue = winningPlayer getKtkStat(2420);
		
		if(!isDefined(curValue))
			curValue = 0;
		
		curValue++;
		
		winningPlayer setKtkStat(2420, curValue);
		scr_iprintln("EVENT_PLAYER_WON", undefined, winningPlayer.name, curValue);
	
		[[level._setPlayerScore]](winningPlayer, [[level._getPlayerScore]](winningPlayer) + 1);
	}
}