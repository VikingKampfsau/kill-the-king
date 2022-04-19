#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_misc;

init()
{
	// hack to allow maps with no scripts to run correctly
	if ( !isDefined( level.tweakablesInitialized ) )
		maps\mp\gametypes\_tweakables::init();
	
	if ( getDvar( "scr_player_sprinttime" ) == "" )
		setDvar( "scr_player_sprinttime", getDvar( "player_sprintTime" ) );

	level.splitscreen = isSplitScreen();
	level.xenon = (getdvar("xenonGame") == "true");
	level.ps3 = (getdvar("ps3Game") == "true");
	level.console = (level.xenon || level.ps3); 
	
	//KILL THE KING
	//level.onlineGame = true;
	level.onlineGame = (getdvar("dedicated") == "1" || getdvar("dedicated") == "2" || getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server");
	
	//KILL THE KING
	//level.rankedMatch = true;
	level.rankedMatch = ( level.onlineGame ); //&& getDvarInt( "sv_pure" ) );
	/#
	if ( getdvarint( "scr_forcerankedmatch" ) == 1 )
		level.rankedMatch = true;
	#/

	level.script = toLower( getDvar( "mapname" ) );
	level.gametype = toLower( getDvar( "g_gametype" ) );

	level.otherTeam["allies"] = "axis";
	level.otherTeam["axis"] = "allies";

	level.teamBased = false;
	
	level.overrideTeamScore = false;
	level.overridePlayerScore = false;
	level.displayHalftimeText = false;
	level.displayRoundEndText = true;
	
	level.endGameOnScoreLimit = true;
	level.endGameOnTimeLimit = true;

	precacheString( &"MP_HALFTIME" );
	precacheString( &"MP_OVERTIME" );
	precacheString( &"MP_ROUNDEND" );
	precacheString( &"MP_INTERMISSION" );
	precacheString( &"MP_SWITCHING_SIDES" );
	precacheString( &"MP_FRIENDLY_FIRE_WILL_NOT" );

	if ( level.splitScreen )
		precacheString( &"MP_ENDED_GAME" );
	else
		precacheString( &"MP_HOST_ENDED_GAME" );
	
	level.halftimeType = "halftime";
	level.halftimeSubCaption = &"MP_SWITCHING_SIDES";
	
	level.lastStatusTime = 0;
	level.wasWinning = "none";
	
	level.lastSlowProcessFrame = 0;
	
	level.placement["allies"] = [];
	level.placement["axis"] = [];
	level.placement["all"] = [];
	
	level.postRoundTime = 8.0;
	
	level.inOvertime = false;

	level.dropTeam = getdvarint( "sv_maxclients" );
	
	registerDvars();
	maps\mp\gametypes\_class::initPerkDvars();

	//KILL THE KING
	//level.oldschool = ( getDvarInt( "scr_oldschool" ) == 1 );
	level.oldschool = false;
	
	if ( level.oldschool )
	{
		logString( "game mode: oldschool" );
	
		setDvar( "jump_height", 64 );
		setDvar( "jump_slowdownEnable", 0 );
		setDvar( "bg_fallDamageMinHeight", 256 );
		setDvar( "bg_fallDamageMaxHeight", 512 );
	}

	precacheModel( "vehicle_mig29_desert" );
	precacheModel( "projectile_cbu97_clusterbomb" );
	precacheModel( "tag_origin" );	

	precacheShader( "faction_128_usmc" );
	precacheShader( "faction_128_arab" );
	precacheShader( "faction_128_ussr" );
	precacheShader( "faction_128_sas" );
	
	level.nade_fx["nade"]["explode"] = loadfx ("explosions/grenadeexp_default"); 
    level.playerExpSound = "grenade_explode_default";
	
	level.fx_airstrike_afterburner = loadfx ("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx ("smoke/jet_contrail");

	
	if ( !isDefined( game["tiebreaker"] ) )
		game["tiebreaker"] = false;
		
	//KILL THE KING
	//load the event scripts which include the settings
	maps\mp\gametypes\_serversetup::init();
		
	thread CheckGametype();
}

registerDvars()
{
	if ( getdvar( "scr_oldschool" ) == "" )
		setdvar( "scr_oldschool", "0" );
		
	makeDvarServerInfo( "scr_oldschool" );

	setDvar( "ui_bomb_timer", 0 );
	makeDvarServerInfo( "ui_bomb_timer" );
	
	
	if ( getDvar( "scr_show_unlock_wait" ) == "" )
		setDvar( "scr_show_unlock_wait", 0.1 );
		
	if ( getDvar( "scr_intermission_time" ) == "" )
		setDvar( "scr_intermission_time", 30.0 );
}

SetupCallbacks()
{
	level.spawnPlayer = ::spawnPlayer;
	level.spawnClient = ::spawnClient;
	level.spawnSpectator = ::spawnSpectator;
	level.spawnIntermission = ::spawnIntermission;
	level.onPlayerScore = ::default_onPlayerScore;
	level.onTeamScore = ::default_onTeamScore;
	
	level.onXPEvent = ::onXPEvent;
	level.waveSpawnTimer = ::waveSpawnTimer;
	
	level.onSpawnPlayer = ::blank;
	level.onSpawnSpectator = ::default_onSpawnSpectator;
	level.onSpawnIntermission = ::default_onSpawnIntermission;
	level.onRespawnDelay = ::blank;

	level.onForfeit = ::default_onForfeit;
	level.onTimeLimit = ::default_onTimeLimit;
	level.onScoreLimit = ::default_onScoreLimit;
	level.onDeadEvent = ::default_onDeadEvent;
	level.onOneLeftEvent = ::default_onOneLeftEvent;
	level.giveTeamScore = ::giveTeamScore;
	level.givePlayerScore = ::givePlayerScore;

	level._setTeamScore = ::_setTeamScore;
	level._setPlayerScore = ::_setPlayerScore;

	level._getTeamScore = ::_getTeamScore;
	level._getPlayerScore = ::_getPlayerScore;
	
	level.onPrecacheGametype = ::blank;
	level.onStartGameType = ::blank;
	level.onPlayerConnect = ::blank;
	level.onPlayerDisconnect = ::blank;
	level.onPlayerDamage = ::blank;
	level.onPlayerKilled = ::blank;

	level.onEndGame = ::blank;

	level.autoassign = ::menuAutoAssign;
	level.spectator = ::menuSpectator;
	level.class = ::menuClass;
	level.allies = ::menuAllies;
	level.axis = ::menuAxis;
	level.switchTeam = ::switchTeam;

	//KILL THE KING - CoD4X
	level.onScriptCommand = ::blank;
}


// to be used with things that are slow.
// unfortunately, it can only be used with things that aren't time critical.
WaitTillSlowProcessAllowed()
{
	// wait only a few frames if necessary
	// if we wait too long, we might get too many threads at once and run out of variables
	// i'm trying to avoid using a loop because i don't want any extra variables
	if ( level.lastSlowProcessFrame == gettime() )
	{
		wait .05;
		if ( level.lastSlowProcessFrame == gettime() )
		{
		wait .05;
			if ( level.lastSlowProcessFrame == gettime() )
			{
				wait .05;
				if ( level.lastSlowProcessFrame == gettime() )
				{
					wait .05;
				}
			}
		}
	}
	
	level.lastSlowProcessFrame = gettime();
}


blank( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 )
{
}

// when a team leaves completely, that team forfeited, team left wins round, ends game
default_onForfeit( team )
{
	//KILL THE KING - just end the round
	if(level.roundstarted)
		setDvar("scr_ktk_timelimit", "0.1");
	
	/*
	level notify ( "forfeit in progress" ); //ends all other forfeit threads attempting to run
	level endon( "forfeit in progress" );	//end if another forfeit thread is running
	level endon( "abort forfeit" );			//end if the team is no longer in forfeit status
	
	// in 1v1 DM, give players time to change teams
	if ( !level.teambased && level.players.size > 1 )
		wait 10;
	
	forfeit_delay = 20.0;						//forfeit wait, for switching teams and such
	
	announcement( game["strings"]["opponent_forfeiting_in"], forfeit_delay );
	wait (10.0);
	announcement( game["strings"]["opponent_forfeiting_in"], 10.0 );
	wait (10.0);
	
	endReason = &"";
	if ( !isDefined( team ) )
	{
		setDvar( "ui_text_endreason", game["strings"]["players_forfeited"] );
		endReason = game["strings"]["players_forfeited"];
		winner = level.players[0];
	}
	else if ( team == "allies" )
	{
		setDvar( "ui_text_endreason", game["strings"]["allies_forfeited"] );
		endReason = game["strings"]["allies_forfeited"];
		winner = "axis";
	}
	else if ( team == "axis" )
	{
		setDvar( "ui_text_endreason", game["strings"]["axis_forfeited"] );
		endReason = game["strings"]["axis_forfeited"];
		winner = "allies";
	}
	else
	{
		//shouldn't get here
		assertEx( isdefined( team ), "Forfeited team is not defined" );
		assertEx( 0, "Forfeited team " + team + " is not allies or axis" );
		winner = "tie";
	}
	//exit game, last round, no matter if round limit reached or not
	level.forcedEnd = true;
	
	if ( isPlayer( winner ) )
		logString( "forfeit, win: " + winner getXuid() + "(" + winner.name + ")" );
	else
		logString( "forfeit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
	thread endGame( winner, endReason );
	*/
}


default_onDeadEvent( team )
{
	/*KILL THE KING
	if ( team == "allies" )
	{
		iPrintLn( game["strings"]["allies_eliminated"] );
		makeDvarServerInfo( "ui_text_endreason", game["strings"]["allies_eliminated"] );
		setDvar( "ui_text_endreason", game["strings"]["allies_eliminated"] );

		logString( "team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
		
		thread endGame( "axis", game["strings"]["allies_eliminated"] );
	}
	else if ( team == "axis" )
	{
		iPrintLn( game["strings"]["axis_eliminated"] );
		makeDvarServerInfo( "ui_text_endreason", game["strings"]["axis_eliminated"] );
		setDvar( "ui_text_endreason", game["strings"]["axis_eliminated"] );

		logString( "team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );

		thread endGame( "allies", game["strings"]["axis_eliminated"] );
	}
	else
	{
		makeDvarServerInfo( "ui_text_endreason", game["strings"]["tie"] );
		setDvar( "ui_text_endreason", game["strings"]["tie"] );

		logString( "tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );

		if ( level.teamBased )
			thread endGame( "tie", game["strings"]["tie"] );
		else
			thread endGame( undefined, game["strings"]["tie"] );
	}*/
	
	if(team == game["attackers"])
		thread maps\mp\gametypes\ktk::onEndGame(game["attackers"], "MP_ENEMIES_ELIMINATED", undefined);
	else
		thread maps\mp\gametypes\ktk::onEndGame(game["defenders"], "MP_ENEMIES_ELIMINATED", undefined);
}


default_onOneLeftEvent( team )
{
	if ( !level.teamBased )
	{
		if(game["customEvent"] == "traitors")
			return;
	
		winner = getHighestScoringPlayer();

		if ( isDefined( winner ) )
			logString( "last one alive, win: " + winner.name );
		else
			logString( "last one alive, win: unknown" );

		thread endGame( winner, "MP_ENEMIES_ELIMINATED" );
	}
	else
	{
		for ( index = 0; index < level.players.size; index++ )
		{
			player = level.players[index];
			
			if ( !isAlive( player ) )
				continue;
				
			if ( !isDefined( player.pers["team"] ) || player.pers["team"] != team )
				continue;
				
			player maps\mp\gametypes\_globallogic::leaderDialogOnPlayer( "last_alive" );
		}
	}
}


default_onTimeLimit()
{
	winner = undefined;
	
	if ( level.teamBased )
	{
		if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
			winner = "tie";
		else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
			winner = "axis";
		else
			winner = "allies";

		logString( "time limit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
	}
	else
	{
		winner = getHighestScoringPlayer();

		if ( isDefined( winner ) )
			logString( "time limit, win: " + winner.name );
		else
			logString( "time limit, tie" );
	}
	
	// i think these two lines are obsolete
	makeDvarServerInfo( "ui_text_endreason", game["strings"]["time_limit_reached"] );
	setDvar( "ui_text_endreason", game["strings"]["time_limit_reached"] );
	
	thread endGame( winner, game["strings"]["time_limit_reached"] );
}


forceEnd()
{
	if ( level.hostForcedEnd || level.forcedEnd )
		return;

	winner = undefined;
	
	if ( level.teamBased )
	{
		if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
			winner = "tie";
		else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
			winner = "axis";
		else
			winner = "allies";
		logString( "host ended game, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
	}
	else
	{
		if(game["customEvent"] == "traitors")
		{
			thread endGame(game["defenders"], "KING_SURVIVED");
			return;
		}
	
		winner = getHighestScoringPlayer();
		if ( isDefined( winner ) )
			logString( "host ended game, win: " + winner.name );
		else
			logString( "host ended game, tie" );
	}
	
	level.forcedEnd = true;
	level.hostForcedEnd = true;
	
	if ( level.splitscreen )
		endString = &"MP_ENDED_GAME";
	else
		endString = &"MP_HOST_ENDED_GAME";
	
	makeDvarServerInfo( "ui_text_endreason", endString );
	setDvar( "ui_text_endreason", endString );
	thread endGame( winner, endString );
}


default_onScoreLimit()
{
	if ( !level.endGameOnScoreLimit )
		return;

	winner = undefined;
	
	if ( level.teamBased )
	{
		if ( game["teamScores"]["allies"] == game["teamScores"]["axis"] )
			winner = "tie";
		else if ( game["teamScores"]["axis"] > game["teamScores"]["allies"] )
			winner = "axis";
		else
			winner = "allies";
		logString( "scorelimit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"] );
	}
	else
	{
		winner = getHighestScoringPlayer();
		if ( isDefined( winner ) )
			logString( "scorelimit, win: " + winner.name );
		else
			logString( "scorelimit, tie" );
	}
	
	makeDvarServerInfo( "ui_text_endreason", game["strings"]["score_limit_reached"] );
	setDvar( "ui_text_endreason", game["strings"]["score_limit_reached"] );
	
	level.forcedEnd = true; // no more rounds if scorelimit is hit
	thread endGame( winner, game["strings"]["score_limit_reached"] );
}


updateGameEvents()
{
	if ( level.rankedMatch && !level.inGracePeriod )
	{
		if ( level.teamBased )
		{
			// if allies disconnected, and axis still connected, axis wins round and game ends to lobby
			if ( (level.everExisted["allies"] || level.console) && level.playerCount["allies"] < 1 && level.playerCount["axis"] > 0 && game["state"] == "playing" )
			{
				//allies forfeited
				thread [[level.onForfeit]]( "allies" );
				return;
			}
			
			// if axis disconnected, and allies still connected, allies wins round and game ends to lobby
			if ( (level.everExisted["axis"] || level.console) && level.playerCount["axis"] < 1 && level.playerCount["allies"] > 0 && game["state"] == "playing" )
			{
				//axis forfeited
				thread [[level.onForfeit]]( "axis" );
				return;
			}
	
			if ( level.playerCount["axis"] > 0 && level.playerCount["allies"] > 0 )
				level notify( "abort forfeit" );
		}
		else
		{
			if ( level.playerCount["allies"] + level.playerCount["axis"] == 1 && level.maxPlayerCount > 1 )
			{
				thread [[level.onForfeit]]();
				return;
			}

			if ( level.playerCount["axis"] + level.playerCount["allies"] > 1 )
				level notify( "abort forfeit" );
		}
	}
	
	if ( !level.numLives && !level.inOverTime )
		return;
		
	if ( level.inGracePeriod )
		return;

	if ( level.teamBased )
	{
		// if both allies and axis were alive and now they are both dead in the same instance
		if ( level.everExisted["allies"] && !level.aliveCount["allies"] && level.everExisted["axis"] && !level.aliveCount["axis"] && !level.playerLives["allies"] && !level.playerLives["axis"] )
		{
			[[level.onDeadEvent]]( "all" );
			return;
		}

		// if allies were alive and now they are not
		if ( level.everExisted["allies"] && !level.aliveCount["allies"] && !level.playerLives["allies"] )
		{
			[[level.onDeadEvent]]( "allies" );
			return;
		}

		// if axis were alive and now they are not
		if ( level.everExisted["axis"] && !level.aliveCount["axis"] && !level.playerLives["axis"] )
		{
			[[level.onDeadEvent]]( "axis" );
			return;
		}

		// one ally left
		if ( level.lastAliveCount["allies"] > 1 && level.aliveCount["allies"] == 1 && level.playerLives["allies"] == 1 )
		{
			[[level.onOneLeftEvent]]( "allies" );
			return;
		}

		// one axis left
		if ( level.lastAliveCount["axis"] > 1 && level.aliveCount["axis"] == 1 && level.playerLives["axis"] == 1 )
		{
			[[level.onOneLeftEvent]]( "axis" );
			return;
		}
	}
	else
	{
		if(game["customEvent"] == "lastkingstanding")
		{
			//only bots left
			if(level.gameHadRealPlayers && GetPlayersLivesLeft() <= 0)
			{
				[[level.onDeadEvent]]( "all" );
				return;
			}
		}		
		
		// everyone is dead
		if ( (!level.aliveCount["allies"] && !level.aliveCount["axis"]) && (!level.playerLives["allies"] && !level.playerLives["axis"]) && level.maxPlayerCount > 1 )
		{
			[[level.onDeadEvent]]( "all" );
			return;
		}
		
		// last man standing
		if ( (level.aliveCount["allies"] + level.aliveCount["axis"] == 1) && (level.playerLives["allies"] + level.playerLives["axis"] == 1) && level.maxPlayerCount > 1 )
		{
			[[level.onOneLeftEvent]]( "all" );
			return;
		}
	}
}


matchStartTimer()
{	
	visionSetNaked( "mpIntro", 0 );
	
	matchStartText = createServerFontString( "objective", 1.5 );
	matchStartText setPoint( "CENTER", "CENTER", 0, -20 );
	matchStartText.sort = 1001;
	matchStartText setText( game["strings"]["waiting_for_teams"] );
	matchStartText.foreground = false;
	matchStartText.hidewheninmenu = true;
	
	matchStartTimer = createServerTimer( "objective", 1.4 );
	matchStartTimer setPoint( "CENTER", "CENTER", 0, 0 );
	matchStartTimer setTimer( level.prematchPeriod );
	matchStartTimer.sort = 1001;
	matchStartTimer.foreground = false;
	matchStartTimer.hideWhenInMenu = true;
	
	waitForPlayers( level.prematchPeriod );
	
	if ( level.prematchPeriodEnd > 0 )
	{
		matchStartText setText( game["strings"]["match_starting_in"] );
		matchStartTimer setTimer( level.prematchPeriodEnd );
		
		wait level.prematchPeriodEnd;
	}
	
	visionSetNaked( getDvar( "mapname" ), 2.0 );
	
	matchStartText destroyElem();
	matchStartTimer destroyElem();
}

matchStartTimerSkip()
{
	visionSetNaked( getDvar( "mapname" ), 0 );
}

spawnPlayer()
{
	prof_begin( "spawnPlayer_preUTS" );

	self endon("disconnect");
	self endon("joined_spectators");
	self notify("spawned");
	self notify("end_respawn");
	
	self setSpawnVariables();

	if ( level.teamBased )
		self.sessionteam = self.team;
	else
		self.sessionteam = "none";

	hadSpawned = self.hasSpawned;

	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	
	if ( level.hardcoreMode )
		self.maxhealth = 30;
	else if ( level.oldschool )
		self.maxhealth = 200;
	else
		self.maxhealth = 100;
	self.health = self.maxhealth;
	
	self.friendlydamage = undefined;
	self.hasSpawned = true;
	self.spawnTime = getTime();
	self.afk = false;
	self.lastStand = undefined;
	
	if(self.pers["lives"])
	{
		if(game["customEvent"] != "revolt")
			self.pers["lives"]--;
		else
		{
			if(maps\mp\gametypes\_revolt::getTeamFlagCount(self.pers["team"]) <= 0)
				self.pers["lives"]--;
		}
	}

	if ( !self.wasAliveAtMatchStart )
	{
		acceptablePassedTime = 20;
		if ( level.timeLimit > 0 && acceptablePassedTime < level.timeLimit * 60 / 4 )
			acceptablePassedTime = level.timeLimit * 60 / 4;
		
		if ( level.inGracePeriod || getTimePassed() < acceptablePassedTime * 1000 )
			self.wasAliveAtMatchStart = true;
	}
	
	//self clearPerks();

	//self setClientDvar( "cg_thirdPerson", "0" );
	//self setDepthOfField( 0, 0, 512, 512, 4, 0 );
	//self setClientDvar( "cg_fov", "65" );
	
	[[level.onSpawnPlayer]]();
	
	self maps\mp\gametypes\_missions::playerSpawned();
	
	prof_end( "spawnPlayer_preUTS" );

	level thread updateTeamStatus();
	
	prof_begin( "spawnPlayer_postUTS" );
	
	if ( level.oldschool )
	{
		assert( !isDefined( self.class ) );
		self maps\mp\gametypes\_oldschool::giveLoadout();
		self maps\mp\gametypes\_class::setClass( level.defaultClass );
	}
	else
	{
		assert( isValidClass( self.class ) );
		
		self maps\mp\gametypes\_class::setClass( self.class );
		self maps\mp\gametypes\_class::giveLoadout( self.team, self.class );
	}
	
	if ( level.inPrematchPeriod )
	{
		if(level.players.size >= getDvarint("scr_mod_minplayers"))
			self freezeControls( true );
		//self disableWeapons();
		
		//self setClientDvar( "scr_objectiveText", getObjectiveHintText( self.pers["team"] ) );			

		team = self.pers["team"];
		
		music = game["music"]["spawn_" + team];
		if ( level.splitscreen )
		{
			if ( isDefined( level.playedStartingMusic ) )
				music = undefined;
			else
				level.playedStartingMusic = true;
		}
		
		if ( isDefined( game["dialog"]["gametype"] ) && (!level.splitscreen || self == level.players[0]) )
			self leaderDialogOnPlayer( "gametype" );

		thread maps\mp\gametypes\_hud::showClientScoreBar( 5.0 );
	}
	else
	{
		self freezeControls( false );
		self enableWeapons();
		if ( !hadSpawned && game["state"] == "playing" )
		{
			team = self.team;
			
			music = game["music"]["spawn_" + team];
			if ( level.splitscreen )
			{
				if ( isDefined( level.playedStartingMusic ) )
					music = undefined;
				else
					level.playedStartingMusic = true;
			}
			
			if ( isDefined( game["dialog"]["gametype"] ) && (!level.splitscreen || self == level.players[0]) )
			{
				self leaderDialogOnPlayer( "gametype" );
				if ( team == game["attackers"] )
					self leaderDialogOnPlayer( "offense_obj", "introboost" );
				else
					self leaderDialogOnPlayer( "defense_obj", "introboost" );
			}

			//self setClientDvar( "scr_objectiveText", getObjectiveHintText( self.pers["team"] ) );			
			thread maps\mp\gametypes\_hud::showClientScoreBar( 5.0 );
		}
	}

	//KILL THE KING
	//do not show the perks on spawn - there might be so many unlocks that the hud limit is hit
	//would look shit anyways to have 10 perk images at every spawn
	/*if ( !level.splitscreen && getdvarint( "scr_showperksonspawn" ) == 1 && game["state"] != "postgame" )
	{
		perks = getPerks( self );
		self showPerk( 0, perks[0], -50 );
		self showPerk( 1, perks[1], -50 );
		self showPerk( 2, perks[2], -50 );
		self thread hidePerksAfterTime( 3.0 );
		self thread hidePerksOnDeath();
	}*/
	
	prof_end( "spawnPlayer_postUTS" );
	
	waittillframeend;
	self notify( "spawned_player" );

	self logstring( "S " + self.origin[0] + " " + self.origin[1] + " " + self.origin[2] );

	self thread maps\mp\gametypes\_hardpoints::hardpointItemWaiter();
	
	//self thread testHPs();
	//self thread testShock();
	//self thread testMenu();
	
	if ( game["state"] == "postgame" )
	{
		assert( !level.intermission );
		// We're in the victory screen, but before intermission
		self freezePlayerForRoundEnd();
	}
}

hidePerksAfterTime( delay )
{
	self endon("disconnect");
	self endon("perks_hidden");
	
	wait delay;
	
	self thread hidePerk( 0, 2.0 );
	self thread hidePerk( 1, 2.0 );
	self thread hidePerk( 2, 2.0 );
	self notify("perks_hidden");
}

hidePerksOnDeath()
{
	self endon("disconnect");
	self endon("perks_hidden");

	self waittill("death");
	
	self hidePerk( 0 );
	self hidePerk( 1 );
	self hidePerk( 2 );
	self notify("perks_hidden");
}

hidePerksOnKill()
{
	self endon("disconnect");
	self endon("death");
	self endon("perks_hidden");

	self waittill( "killed_player" );
	
	self hidePerk( 0 );
	self hidePerk( 1 );
	self hidePerk( 2 );
	self notify("perks_hidden");
}


testMenu()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	
	for ( ;; )
	{
		wait ( 10.0 );
		
		notifyData = spawnStruct();
		notifyData.titleText = &"MP_CHALLENGE_COMPLETED";
		notifyData.notifyText = "wheee";
		notifyData.sound = "mp_challenge_complete";
	
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
	}
}

testShock()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	
	for ( ;; )
	{
		wait ( 3.0 );

		numShots = randomInt( 6 );
		
		for ( i = 0; i < numShots; i++ )
		{
			iPrintLnBold( numShots );
			self shellShock( "frag_grenade_mp", 0.2 );
			wait ( 0.1 );
		}
	}
}

testHPs()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	
	hps = [];
	hps[hps.size] = level.ktkWeapon["rccar"];
	hps[hps.size] = "airstrike_mp";
	hps[hps.size] = "helicopter_mp";

	for ( ;; )
	{
//		hp = hps[randomInt(hps.size)];
		hp = level.ktkWeapon["rccar"];
		if ( self thread maps\mp\gametypes\_hardpoints::giveHardpointItem( hp ) )
		{
			self playLocalSound( level.hardpointInforms[hp] );
		}

//		self thread maps\mp\gametypes\_hardpoints::upgradeHardpointItem();
		
		wait ( 20.0 );
	}
}


spawnSpectator( origin, angles )
{
	self notify("spawned");
	self notify("end_respawn");
	in_spawnSpectator( origin, angles );
}

// spawnSpectator clone without notifies for spawning between respawn delays
respawn_asSpectator( origin, angles )
{
	in_spawnSpectator( origin, angles );
}

// spawnSpectator helper
in_spawnSpectator( origin, angles )
{
	self setSpawnVariables();
	
	// don't clear lower message if not actually a spectator,
	// because it probably has important information like when we'll spawn
	if ( self.pers["team"] == "spectator" )
		self clearLowerMessage();
	
	self.sessionstate = "spectator";
	
	//Kill the King
	if(!isDefined(self.pers["adminspec"]))
		self.spectatorclient = -1;
	else
		self.spectatorclient = self.pers["adminspec"];

	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";
	else
		self.statusicon = "hud_status_dead";

	maps\mp\gametypes\_spectating::setSpectatePermissions();

	[[level.onSpawnSpectator]]( origin, angles );
	
	if ( level.teamBased && !level.splitscreen )
		self thread spectatorThirdPersonness();
	
	level thread updateTeamStatus();
}

//KILL THE KING
spectatorThirdPersonness()
{
	self endon("disconnect");
	self endon("spawned");
	
	self notify("spectator_thirdperson_thread");
	self endon("spectator_thirdperson_thread");
	
	if(!isDefined(self.pers["admin"]) || !self.pers["admin"])
		return;
	
	if(!isDefined(self.pers["adminspec"]) || self.pers["adminspec"] < 0)
		return;
	
	player = getPlayerFromClientNum(self.pers["adminspec"]);
	prevClientNum = self.pers["adminspec"];
	self.spectatingThirdPerson = false;
	
	self setThirdPerson( self.spectatingThirdPerson );
	
	while(1)
	{
		if(self.pers["adminspec"] != prevClientNum)
		{
			player = getPlayerFromClientNum(self.pers["adminspec"]);
			prevClientNum = self.pers["adminspec"];
		}
		
		if(!isDefined(player))
			self setThirdPerson( false );
		else
		{
			if(!player isInRCToy())
				self setThirdPerson(false);
			else
			{
				self setThirdPerson(true);
			
				while(isDefined(player) && player isInRCToy())
				{
					if(self.pers["adminspec"] != prevClientNum)
						break;
						
					wait .05;
				}
				
				self setThirdPerson(false);
			}
		}

	wait .05;
	}
}

getPlayerFromClientNum( clientNum )
{
	if ( clientNum < 0 )
		return undefined;
	
	for ( i = 0; i < level.players.size; i++ )
	{
		if ( level.players[i] getEntityNumber() == clientNum )
			return level.players[i];
	}
	return undefined;
}

setThirdPerson( value )
{
	if ( value != self.spectatingThirdPerson )
	{
		self.spectatingThirdPerson = value;
		if ( value )
		{
			self.pers["thirdperson"] = true;
			self setClientDvar( "cg_thirdPerson", "1" );
			//self setDepthOfField( 0, 128, 512, 4000, 6, 1.8 );
			//self setClientDvar( "cg_fov", "40" );
		}
		else
		{
			self.pers["thirdperson"] = false;
			self setClientDvar( "cg_thirdPerson", "0" );
			
			//self setDepthOfField( 0, 0, 512, 4000, 4, 0 );
			//self setClientDvar( "cg_fov", "65" );
		}
		
		self thread maps\mp\gametypes\_huds::Crosshair();
	}
}

waveSpawnTimer()
{
	level endon( "game_ended" );

	while ( game["state"] == "playing" )
	{
		time = getTime();
		
		if ( time - level.lastWave["allies"] > (level.waveDelay["allies"] * 1000) )
		{
			level notify ( "wave_respawn_allies" );
			level.lastWave["allies"] = time;
			level.wavePlayerSpawnIndex["allies"] = 0;
		}

		if ( time - level.lastWave["axis"] > (level.waveDelay["axis"] * 1000) )
		{
			level notify ( "wave_respawn_axis" );
			level.lastWave["axis"] = time;
			level.wavePlayerSpawnIndex["axis"] = 0;
		}
		
		wait ( 0.05 );
	}
}


default_onSpawnSpectator( origin, angles)
{
	if( isDefined( origin ) && isDefined( angles ) )
	{
		self spawn(origin, angles);
		return;
	}
	
	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	
	
	//KILL THE KING - A short fix for maps without a spectator spawn
	if(spawnpoints.size <= 0)
		spawnpoints = getentarray("mp_tdm_spawn", "classname");
	
	assert( spawnpoints.size );
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	self spawn(spawnpoint.origin, spawnpoint.angles);
}

spawnIntermission(changeSessionstate)
{
	self notify("spawned");
	self notify("end_respawn");
	
	self setSpawnVariables();
	
	self clearLowerMessage();
	
	self freezeControls( false );
	
	//self setClientDvar( "cg_everyoneHearsEveryone", 1 );
	
	if(!isDefined(changeSessionstate))
		self.sessionstate = "intermission";
	
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.friendlydamage = undefined;
	
	[[level.onSpawnIntermission]]();
	self setDepthOfField( 0, 128, 512, 4000, 6, 1.8 );
}


default_onSpawnIntermission()
{
	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
//	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);
	spawnpoint = spawnPoints[0];
	
	if( isDefined( spawnpoint ) )
		self spawn( spawnpoint.origin, spawnpoint.angles );
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
}

// returns the best guess of the exact time until the scoreboard will be displayed and player control will be lost.
// returns undefined if time is not known
timeUntilRoundEnd()
{
	if ( level.gameEnded )
	{
		timePassed = (getTime() - level.gameEndTime) / 1000;
		timeRemaining = level.postRoundTime - timePassed;
		
		if ( timeRemaining < 0 )
			return 0;
		
		return timeRemaining;
	}
	
	if ( level.inOvertime )
		return undefined;
	
	if ( level.timeLimit <= 0 )
		return undefined;
	
	if ( !isDefined( level.startTime ) )
		return undefined;
	
	timePassed = (getTime() - level.startTime)/1000;
	timeRemaining = (level.timeLimit * 60) - timePassed;
	
	return timeRemaining + level.postRoundTime;
}

freezePlayerForRoundEnd()
{
	self clearLowerMessage();
	
	self closeMenu();
	self closeInGameMenu();
	
	self freezeControls( true );
//	self disableWeapons();
}


logXPGains()
{
	if ( !isDefined( self.xpGains ) )
		return;

	xpTypes = getArrayKeys( self.xpGains );
	for ( index = 0; index < xpTypes.size; index++ )
	{
		gain = self.xpGains[xpTypes[index]];
		if ( !gain )
			continue;
			
		self logString( "xp " + xpTypes[index] + ": " + gain );
	}
}

freeGameplayHudElems()
{
    // free up some hud elems so we have enough for other things.
    
    //KILL THE KING
    self thread maps\mp\gametypes\_huds::RemoveCustomHuds("roundend");
	
	// perk icons
	if ( isdefined( self.perkicon ) )
	{
		if ( isdefined( self.perkicon[0] ) )
		{
			self.perkicon[0] destroyElem();
			self.perkname[0] destroyElem();
		}
		if ( isdefined( self.perkicon[1] ) )
		{
			self.perkicon[1] destroyElem();
			self.perkname[1] destroyElem();
		}
		if ( isdefined( self.perkicon[2] ) )
		{
			self.perkicon[2] destroyElem();
			self.perkname[2] destroyElem();
		}
	}
	self notify("perks_hidden"); // stop any threads that are waiting to hide the perk icons
	
	// lower message
	self.lowerMessage destroyElem();
	self.lowerTimer destroyElem();
	
	// progress bar
	if ( isDefined( self.proxBar ) )
		self.proxBar destroyElem();
	if ( isDefined( self.proxBarText ) )
		self.proxBarText destroyElem();
}


getHostPlayer()
{
	players = getEntArray( "player", "classname" );
	
	for ( index = 0; index < players.size; index++ )
	{
		if ( players[index] getEntityNumber() == 0 )
			return players[index];
	}
}


hostIdledOut()
{
	hostPlayer = getHostPlayer();
	
	// host never spawned
	if ( isDefined( hostPlayer ) && !hostPlayer.hasSpawned && !isDefined( hostPlayer.selectedClass ) )
		return true;

	return false;
}


endGame( winner, endReasonText )
{
	// return if already ending via host quit or victory
	if ( game["state"] == "postgame" || level.gameEnded )
		return;

	if ( isDefined( level.onEndGame ) )
		[[level.onEndGame]]( winner );

	//visionSetNaked( "mpOutro", 2.0 );
	
	game["state"] = "postgame";
	level.gameEndTime = getTime();
	level.gameEnded = true;
	level.inGracePeriod = false;
	level notify ( "game_ended" );
	
	setGameEndTime( 0 ); // stop/hide the timers
	
	if ( level.rankedMatch )
	{
		setXenonRanks();
		
		if ( hostIdledOut() )
		{
			level.hostForcedEnd = true;
			logString( "host idled out" );
			endLobby();
		}
	}
	
	updatePlacement();
	updateMatchBonusScores( winner );
	updateWinLossStats( winner );
	
	setdvar( "g_deadChat", 1 );
	
	if(isDefined(level.customEvent_text)) level.customEvent_text destroy();
	if(isDefined(level.customEvent_revoltFlags)) level.customEvent_revoltFlags destroy();
	
	// freeze players
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		
		player freezePlayerForRoundEnd();
		player thread roundEndDoF( 4.0 );
		
		player freeGameplayHudElems();
		
		//KTK - Added to the setClientDvars below
		//player setClientDvars( "cg_everyoneHearsEveryone", 1 );

		if( level.rankedMatch )
		{
			/*if ( isDefined( player.setPromotion ) )
				player setClientDvars( "ui_lobbypopup", "promotion", "cg_everyoneHearsEveryone", 1 );
			else
				player setClientDvars( "ui_lobbypopup", "summary", "cg_everyoneHearsEveryone", 1 );*/
		}
		
		if(getDvarInt("scr_hardpoint_persists") > 0)
		{
			if(getDvarInt("scr_hardpoint_persists") > 1 || (getDvarInt("scr_hardpoint_persists") == 1 && game["roundsplayed"] == (level.roundLimit - 1)))
				player SaveUnusedHardpointsForNextVisit();
		}
	}
	
    // end round
    if ( (level.roundLimit > 1 || (!level.roundLimit && level.scoreLimit != 1)) && !level.forcedEnd )
    {
		if ( level.displayRoundEndText )
		{
			players = level.players;
			for ( index = 0; index < players.size; index++ )
			{
				player = players[index];
				
				if ( level.teamBased )
					player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( winner, true, player GetLocalizedString(endReasonText) );
				else
					player thread maps\mp\gametypes\_hud_message::outcomeNotify( winner, player GetLocalizedString(endReasonText) );
		
				player setClientDvars( "ui_hud_hardcore", 1,
									   "cg_drawSpectatorMessages", 0,
									   "g_compassShowEnemies", 0 );
			}

			if ( level.teamBased && !(hitRoundLimit() || hitScoreLimit()) )
				thread announceRoundWinner( winner, level.roundEndDelay / 4 );
			
			if ( hitRoundLimit() || hitScoreLimit() )
				roundEndWait( level.roundEndDelay / 2, false );
			else
				roundEndWait( level.roundEndDelay, true );
		}
		
		if(game["customEvent"] == "traitors")
		{
			for ( index = 0; index < level.players.size; index++ )
				level.players[index] thread maps\mp\gametypes\_traitors::endRoundText(winner, level.players[index] GetLocalizedString(endReasonText));
			
			roundEndWait( level.halftimeRoundEndDelay, !(hitRoundLimit() || hitScoreLimit()) );
		}

		if(endReasonText != "SELECTION_IMPOSSIBLE")
			game["roundsplayed"]++;
		
		roundSwitching = false;
		if ( !hitRoundLimit() && !hitScoreLimit() )
			roundSwitching = checkRoundSwitch();

		if ( roundSwitching && level.teamBased )
		{
			players = level.players;
			for ( index = 0; index < players.size; index++ )
			{
				player = players[index];
				
				if ( !isDefined( player.pers["team"] ) || player.pers["team"] == "spectator" )
				{
					player [[level.spawnIntermission]](false);
					player closeMenu();
					player closeInGameMenu();
					continue;
				}
				
				switchType = level.halftimeType;
				if ( switchType == "halftime" )
				{
					if ( level.roundLimit )
					{
						if ( (game["roundsplayed"] * 2) == level.roundLimit )
							switchType = "halftime";
						else
							switchType = "intermission";
					}
					else if ( level.scoreLimit )
					{
						if ( game["roundsplayed"] == (level.scoreLimit - 1) )
							switchType = "halftime";
						else
							switchType = "intermission";
					}
					else
					{
						switchType = "intermission";
					}
				}
				switch( switchType )
				{
					case "halftime":
						player leaderDialogOnPlayer( "halftime" );
						break;
					case "overtime":
						player leaderDialogOnPlayer( "overtime" );
						break;
					default:
						player leaderDialogOnPlayer( "side_switch" );
						break;
				}
				player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( switchType, true, level.halftimeSubCaption );
				player setClientDvar( "ui_hud_hardcore", 1 );
			}
			roundEndWait( level.halftimeRoundEndDelay, false );
		}
		else if ( !hitRoundLimit() && !hitScoreLimit() && !level.displayRoundEndText && level.teamBased )
		{
			players = level.players;
			for ( index = 0; index < players.size; index++ )
			{
				player = players[index];

				if ( !isDefined( player.pers["team"] ) || player.pers["team"] == "spectator" )
				{
					player [[level.spawnIntermission]](false);
					player closeMenu();
					player closeInGameMenu();
					continue;
				}
				
				switchType = level.halftimeType;
				if ( switchType == "halftime" )
				{
					if ( level.roundLimit )
					{
						if ( (game["roundsplayed"] * 2) == level.roundLimit )
							switchType = "halftime";
						else
							switchType = "roundend";
					}
					else if ( level.scoreLimit )
					{
						if ( game["roundsplayed"] == (level.scoreLimit - 1) )
							switchType = "halftime";
						else
							switchTime = "roundend";
					}
				}
				switch( switchType )
				{
					case "halftime":
						player leaderDialogOnPlayer( "halftime" );
						break;
					case "overtime":
						player leaderDialogOnPlayer( "overtime" );
						break;
				}
				player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( switchType, true, player GetLocalizedString(endReasonText) );
				player setClientDvar( "ui_hud_hardcore", 1 );
			}			
			
			roundEndWait( level.halftimeRoundEndDelay, !(hitRoundLimit() || hitScoreLimit()) );
			
			maps\mp\gametypes\_bots::kickAllBots();
		}
		
        if ( !hitRoundLimit() && !hitScoreLimit() )
		{
        	level notify ( "restarting" );
            game["state"] = "playing";
            
			if(isDefined(level.adminChangedEvent) && level.adminChangedEvent)
				exec("map_restart"); //map_restart(false); default CoD4 function is just a fast_restart -> Risk to result in a Server CMD overflow
			else
			{
				//KILL THE KING
				//Give the client some time to process some left commands before restarting the round and sending new commands
				//this might reduce the amount of overflows - not sure tbh
				wait 2;
				
				map_restart(true);
			}
            
			return;
        }
		
		/*
		if ( hitRoundLimit() )
			endReasonText = game["strings"]["round_limit_reached"];
		else if ( hitScoreLimit() )
			endReasonText = game["strings"]["score_limit_reached"];
		else
			endReasonText = game["strings"]["time_limit_reached"];
		*/
	}
	
	thread maps\mp\gametypes\_missions::roundEnd( winner );
	
	// catching gametype, since DM forceEnd sends winner as player entity, instead of string
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];

		if ( !isDefined( player.pers["team"] ) || player.pers["team"] == "spectator" )
		{
			player [[level.spawnIntermission]]();
			player closeMenu();
			player closeInGameMenu();
			continue;
		}
		
		if ( level.teamBased )
		{
			player thread maps\mp\gametypes\_hud_message::teamOutcomeNotify( winner, false, player GetLocalizedString(endReasonText) );
		}
		else
		{
			if(game["customEvent"] == "traitors")
				player playLocalSound( game["music"]["defeat"] );
			else
			{
				player thread maps\mp\gametypes\_hud_message::outcomeNotify( winner, endReasonText );
				
				if ( isDefined( winner ) && player == winner )
					player playLocalSound( game["music"]["victory_" + player.pers["team"] ] );
				else if ( !level.splitScreen )
					player playLocalSound( game["music"]["defeat"] );
			}
		}
		
		player setClientDvars( "ui_hud_hardcore", 1,
							   "cg_drawSpectatorMessages", 0,
							   "g_compassShowEnemies", 0 );
	}

	//KILL THE KING
	roundEndWait( level.roundEndDelay, true );

	maps\mp\gametypes\_bots::kickAllBots();
	
	if ( level.teamBased )
	{
		thread announceGameWinner( winner, level.postRoundTime / 2 );
		
		if ( level.splitscreen )
		{
			if ( winner == "allies" )
				playSoundOnPlayers( game["music"]["victory_allies"], "allies" );
			else if ( winner == "axis" )
				playSoundOnPlayers( game["music"]["victory_axis"], "axis" );
			else
				playSoundOnPlayers( game["music"]["defeat"] );
		}
		else
		{
			if ( winner == "allies" )
			{
				playSoundOnPlayers( game["music"]["victory_allies"], "allies" );
				playSoundOnPlayers( game["music"]["defeat"], "axis" );
			}
			else if ( winner == "axis" )
			{
				playSoundOnPlayers( game["music"]["victory_axis"], "axis" );
				playSoundOnPlayers( game["music"]["defeat"], "allies" );
			}
			else
			{
				playSoundOnPlayers( game["music"]["defeat"] );
			}
		}
	}
	
	level.intermission = true;
	
	if(level.gametype == "ctc" && winner == game["attackers"])
	{
		//thread maps\mp\gametypes\_nuke::nuke_launch();
		//wait 12;
	}
	
	//KILL THE KING - MAP RECORDS
	maps\mp\gametypes\_maprecords::showMapRecords();
	
	//KILL THE KING - MAPVOTE (type one = old)
	if(getDvarInt("scr_mod_mapvote") == 1)
		maps\mp\gametypes\_mapvote::startMapvote();
	
	//regain players array since some might've disconnected during the wait above
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		
		player closeMenu();
		player closeInGameMenu();
		player notify ( "reset_outcome" );
		
		//Viking - The player does not react on scriptmenuresponses (needed for the mapvote type 2)
		if(getDvarInt("scr_mod_mapvote") != 2)
		{
			player setClientDvar( "ui_hud_hardcore", 0 );
			player thread spawnIntermission();
		}
		
		//Viking - Open the lobby
		if(getDvarInt("scr_mod_mapvote") == 2)
		{
			player setclientdvars(	"g_scriptMainMenu", game["menu_eog_main"],
									"ui_hud_hardcore", 0,
									"ktk_mapvote_lobby_available", 1);

			player openMenu( game["menu_eog_main"] );
		}
	}
	
	wait getDvarFloat( "scr_show_unlock_wait" );
	
	if( level.console )
	{
		exitLevel( false );
		return;
	}

	thread timeLimitClock_Intermission( getDvarFloat( "scr_intermission_time" ) );
		
	//Kill the King
	//->
	wait getDvarFloat( "scr_intermission_time" ) - 1;
		
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		player closeMenu();
		player closeInGameMenu();
		
		player thread TakeScreenshot();
	}
	
	maps\mp\gametypes\_bots::updatePezbotMapList();
	
	wait 1;
	//<-

	exitLevel( false );
}

TakeScreenshot()
{
	self endon("disconnect");
	
	if(getDvarInt("scr_mod_mapvote") == 2)
	{
		self ExecClientCommand("+scores");
		wait .5;
	}
	
	self iPrintLn(&"MENU_SCREENSHOT");
	self ExecClientCommand("screenshotjpeg");
}

getWinningTeam()
{
	if ( getGameScore( "allies" ) == getGameScore( "axis" ) )
		winner = "tie";
	else if ( getGameScore( "allies" ) > getGameScore( "axis" ) )
		winner = "allies";
	else
		winner = "axis";
}

//KILL THE KING
roundEndWait( defaultDelay, matchBonus )
{
	if(defaultDelay <= 0)
		defaultDelay = 5;

	notifiesDone = false;
	while ( !notifiesDone )
	{
		players = level.players;
		notifiesDone = true;
		for ( index = 0; index < players.size; index++ )
		{
			if ( !isDefined( players[index].doingNotify ) || !players[index].doingNotify )
				continue;
				
			notifiesDone = false;
		}
		wait ( 0.5 );
	}
	
    wait (int((defaultDelay/2)*100)/100);
	
	if(matchBonus)
		level notify("give_match_bonus");
		
	wait (int((defaultDelay/2)*100)/100);
	cleanScreen();
	
	wait (int((defaultDelay/4)*100)/100);
	
	if(level.finalcamplaying)
		wait getdvarfloat("scr_finalkillcam_time");
}

//KILL THE KING
cleanScreen()
{
	for(i=0;i<level.players.size;i++)
		level.players[i] notify("reset_outcome");
	
	wait .1;
	
	if(getDvarInt("scr_mod_finalkillcam") == 1)
		level notify("play_finalcam");
}

roundEndDOF( time )
{
	self setDepthOfField( 0, 128, 512, 4000, 6, 1.8 );
}

updateMatchBonusScores( winner )
{
	if ( !game["timepassed"] )
		return;

	if ( !level.rankedMatch )
		return;

	if ( !level.timeLimit || level.forcedEnd )
	{
		gameLength = getTimePassed() / 1000;		
		// cap it at 20 minutes to avoid exploiting
		gameLength = min( gameLength, 1200 );
	}
	else
	{
		gameLength = level.timeLimit * 60;
	}
		
	if ( level.teamBased )
	{
		if ( winner == "allies" )
		{
			winningTeam = "allies";
			losingTeam = "axis";
		}
		else if ( winner == "axis" )
		{
			winningTeam = "axis";
			losingTeam = "allies";
		}
		else
		{
			winningTeam = "tie";
			losingTeam = "tie";
		}

		if ( winningTeam != "tie" )
		{
			winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue( "win" );
			loserScale = maps\mp\gametypes\_rank::getScoreInfoValue( "loss" );
		}
		else
		{
			winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue( "tie" );
			loserScale = maps\mp\gametypes\_rank::getScoreInfoValue( "tie" );
		}
		
		players = level.players;
		for( i = 0; i < players.size; i++ )
		{
			player = players[i];
			
			if ( player.timePlayed["total"] < 1 || player.pers["participation"] < 1 )
			{
				player thread maps\mp\gametypes\_rank::endGameUpdate();
				continue;
			}
	
			// no bonus for hosts who force ends
			if ( level.hostForcedEnd && player getEntityNumber() == 0 )
				continue;

			spm = player maps\mp\gametypes\_rank::getSPM();				
			if ( winningTeam == "tie" )
			{
				playerScore = int( (winnerScale * ((gameLength/60) * spm)) * (player.timePlayed["total"] / gameLength) );
				player thread giveMatchBonus( "tie", playerScore );
				player.matchBonus = playerScore;
			}
			else if ( isDefined( player.pers["team"] ) && player.pers["team"] == winningTeam )
			{
				playerScore = int( (winnerScale * ((gameLength/60) * spm)) * (player.timePlayed["total"] / gameLength) );
				player thread giveMatchBonus( "win", playerScore );
				player.matchBonus = playerScore;
			}
			else if ( isDefined(player.pers["team"] ) && player.pers["team"] == losingTeam )
			{
				playerScore = int( (loserScale * ((gameLength/60) * spm)) * (player.timePlayed["total"] / gameLength) );
				player thread giveMatchBonus( "loss", playerScore );
				player.matchBonus = playerScore;
			}
		}
	}
	else
	{
		if ( isDefined( winner ) )
		{
			winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue( "win" );
			loserScale = maps\mp\gametypes\_rank::getScoreInfoValue( "loss" );
		}
		else
		{
			winnerScale = maps\mp\gametypes\_rank::getScoreInfoValue( "tie" );
			loserScale = maps\mp\gametypes\_rank::getScoreInfoValue( "tie" );
		}
		
		players = level.players;
		for( i = 0; i < players.size; i++ )
		{
			player = players[i];
			
			if ( player.timePlayed["total"] < 1 || player.pers["participation"] < 1 )
			{
				player thread maps\mp\gametypes\_rank::endGameUpdate();
				continue;
			}
			
			spm = player maps\mp\gametypes\_rank::getSPM();

			isWinner = false;
			for ( pIdx = 0; pIdx < min( level.placement["all"][0].size, 3 ); pIdx++ )
			{
				if ( level.placement["all"][pIdx] != player )
					continue;
				isWinner = true;				
			}
			
			if ( isWinner )
			{
				playerScore = int( (winnerScale * ((gameLength/60) * spm)) * (player.timePlayed["total"] / gameLength) );
				player thread giveMatchBonus( "win", playerScore );
				player.matchBonus = playerScore;
			}
			else
			{
				playerScore = int( (loserScale * ((gameLength/60) * spm)) * (player.timePlayed["total"] / gameLength) );
				player thread giveMatchBonus( "loss", playerScore );
				player.matchBonus = playerScore;
			}
		}
	}
}


giveMatchBonus( scoreType, score )
{
	self endon ( "disconnect" );

	level waittill ( "give_match_bonus" );
	
	self maps\mp\gametypes\_rank::giveRankXP( scoreType, score );
	logXPGains();
	
	self maps\mp\gametypes\_rank::endGameUpdate();
}


setXenonRanks( winner )
{
	players = level.players;

	for ( i = 0; i < players.size; i++ )
	{
		player = players[i];

		if( !isdefined(player.score) || !isdefined(player.pers["team"]) )
			continue;

	}

	for ( i = 0; i < players.size; i++ )
	{
		player = players[i];

		if( !isdefined(player.score) || !isdefined(player.pers["team"]) )
			continue;		
		
		setPlayerTeamRank( player, i, player.score - 5 * player.deaths );
		player logString( "team: score " + player.pers["team"] + ":" + player.score );
	}
	sendranks();
}


getHighestScoringPlayer()
{
	players = level.players;
	winner = undefined;
	tie = false;
	
	//Kill the king
	if(game["customEvent"] == "lastkingstanding")
	{
		for(i=0;i<players.size;i++)
		{
			if(isAlive(players[i]))
				players[i].pers["kingtime"] = int(maps\mp\gametypes\_globallogic::getTimePassed()/1000) +1;
		
			if(!isDefined(players[i].pers["kingtime"]))
				players[i].pers["kingtime"] = 0;
				
			if(players[i].pers["kingtime"] < 1)
				continue;
			
			//iPrintLnBold(players[i].name + " kingtime :" + players[i].pers["kingtime"]);
			
			if(!isDefined(winner) || players[i].pers["kingtime"] > winner.pers["kingtime"])
			{
				winner = players[i];
				tie = false;
			}
			else if(players[i].pers["kingtime"] == winner.pers["kingtime"])
			{
				tie = true;
			}
		}
	}
	else
	{	
		for( i = 0; i < players.size; i++ )
		{
			if ( !isDefined( players[i].score ) )
				continue;
				
			if ( players[i].score < 1 )
				continue;
				
			if ( !isDefined( winner ) || players[i].score > winner.score )
			{
				winner = players[i];
				tie = false;
			}
			else if ( players[i].score == winner.score )
			{
				tie = true;
			}
		}
	}
	
	if ( tie || !isDefined( winner ) )
		return undefined;
	else
		return winner;
}


checkTimeLimit()
{
	if ( isDefined( level.timeLimitOverride ) && level.timeLimitOverride )
		return;
	
	if ( game["state"] != "playing" )
	{
		setGameEndTime( 0 );
		return;
	}
		
	if ( level.timeLimit <= 0 )
	{
		setGameEndTime( 0 );
		return;
	}
		
	if ( level.inPrematchPeriod )
	{
		setGameEndTime( 0 );
		return;
	}
	
	if ( !isdefined( level.startTime ) )
		return;
	
	timeLeft = getTimeRemaining();
	
	// want this accurate to the millisecond
	setGameEndTime( getTime() + int(timeLeft) );
	
	if ( timeLeft > 0 )
		return;
	
	[[level.onTimeLimit]]();
}

getTimeRemaining()
{
	return level.timeLimit * 60 * 1000 - getTimePassed();
}

checkScoreLimit()
{
	if ( game["state"] != "playing" )
		return;

	if ( level.scoreLimit <= 0 )
		return;

	if ( level.teamBased )
	{
		if( game["teamScores"]["allies"] < level.scoreLimit && game["teamScores"]["axis"] < level.scoreLimit )
			return;
	}
	else
	{
		if ( !isPlayer( self ) )
			return;

		if ( self.score < level.scoreLimit )
			return;
	}

	[[level.onScoreLimit]]();
}


hitRoundLimit()
{
	if( level.roundLimit <= 0 )
		return false;

	return ( game["roundsplayed"] >= level.roundLimit );
}

hitScoreLimit()
{
	if( level.scoreLimit <= 0 )
		return false;

	if ( level.teamBased )
	{
		if( game["teamScores"]["allies"] >= level.scoreLimit || game["teamScores"]["axis"] >= level.scoreLimit )
			return true;
	}
	else
	{
		for ( i = 0; i < level.players.size; i++ )
		{
			player = level.players[i];
			if ( isDefined( player.score ) && player.score >= level.scorelimit )
				return true;
		}
	}
	return false;
}

registerRoundSwitchDvar( dvarString, defaultValue, minValue, maxValue )
{
	dvarString = ("scr_" + dvarString + "_roundswitch");
	if ( getDvar( dvarString ) == "" )
		setDvar( dvarString, defaultValue );
		
	if ( getDvarInt( dvarString ) > maxValue )
		setDvar( dvarString, maxValue );
	else if ( getDvarInt( dvarString ) < minValue )
		setDvar( dvarString, minValue );
		
	
	level.roundswitchDvar = dvarString;
	level.roundswitchMin = minValue;
	level.roundswitchMax = maxValue;
	level.roundswitch = getDvarInt( level.roundswitchDvar );
}

registerRoundLimitDvar( dvarString, defaultValue, minValue, maxValue )
{
	dvarString = ("scr_" + dvarString + "_roundlimit");
	if ( getDvar( dvarString ) == "" )
		setDvar( dvarString, defaultValue );
		
	if ( getDvarInt( dvarString ) > maxValue )
		setDvar( dvarString, maxValue );
	else if ( getDvarInt( dvarString ) < minValue )
		setDvar( dvarString, minValue );
		
	
	level.roundLimitDvar = dvarString;
	level.roundlimitMin = minValue;
	level.roundlimitMax = maxValue;
	level.roundLimit = getDvarInt( level.roundLimitDvar );
}


registerScoreLimitDvar( dvarString, defaultValue, minValue, maxValue )
{
	dvarString = ("scr_" + dvarString + "_scorelimit");
	if ( getDvar( dvarString ) == "" )
		setDvar( dvarString, defaultValue );
		
	if ( getDvarInt( dvarString ) > maxValue )
		setDvar( dvarString, maxValue );
	else if ( getDvarInt( dvarString ) < minValue )
		setDvar( dvarString, minValue );
		
	level.scoreLimitDvar = dvarString;	
	level.scorelimitMin = minValue;
	level.scorelimitMax = maxValue;
	level.scoreLimit = getDvarInt( level.scoreLimitDvar );
	
	setDvar( "ui_scorelimit", level.scoreLimit );
}


registerTimeLimitDvar( dvarString, defaultValue, minValue, maxValue )
{
	dvarString = ("scr_" + dvarString + "_timelimit");
	if ( getDvar( dvarString ) == "" )
		setDvar( dvarString, defaultValue );
		
	if ( getDvarFloat( dvarString ) > maxValue )
		setDvar( dvarString, maxValue );
	else if ( getDvarFloat( dvarString ) < minValue )
		setDvar( dvarString, minValue );
		
	level.timeLimitDvar = dvarString;	
	level.timelimitMin = minValue;
	level.timelimitMax = maxValue;
	level.timelimit = getDvarFloat( level.timeLimitDvar );
	
	setDvar( "ui_timelimit", level.timelimit );
}


registerNumLivesDvar( dvarString, defaultValue, minValue, maxValue )
{
	dvarString = ("scr_" + dvarString + "_numlives");
	if ( getDvar( dvarString ) == "" )
		setDvar( dvarString, defaultValue );
		
	if ( getDvarInt( dvarString ) > maxValue )
		setDvar( dvarString, maxValue );
	else if ( getDvarInt( dvarString ) < minValue )
		setDvar( dvarString, minValue );
		
	level.numLivesDvar = dvarString;	
	level.numLivesMin = minValue;
	level.numLivesMax = maxValue;
	level.numLives = getDvarInt( level.numLivesDvar );
}


getValueInRange( value, minValue, maxValue )
{
	if ( value > maxValue )
		return maxValue;
	else if ( value < minValue )
		return minValue;
	else
		return value;
}

updateGameTypeDvars()
{
	level endon ( "game_ended" );
	
	while ( game["state"] == "playing" )
	{
		roundlimit = getValueInRange( getDvarInt( level.roundLimitDvar ), level.roundLimitMin, level.roundLimitMax );
		if ( roundlimit != level.roundlimit )
		{
			level.roundlimit = roundlimit;
			level notify ( "update_roundlimit" );
		}

		timeLimit = getValueInRange( getDvarFloat( level.timeLimitDvar ), level.timeLimitMin, level.timeLimitMax );
		if ( timeLimit != level.timeLimit )
		{
			level.timeLimit = timeLimit;
			setDvar( "ui_timelimit", level.timeLimit );
			level notify ( "update_timelimit" );
		}
		thread checkTimeLimit();

		scoreLimit = getValueInRange( getDvarInt( level.scoreLimitDvar ), level.scoreLimitMin, level.scoreLimitMax );
		if ( scoreLimit != level.scoreLimit )
		{
			level.scoreLimit = scoreLimit;
			setDvar( "ui_scorelimit", level.scoreLimit );
			level notify ( "update_scorelimit" );
		}
		thread checkScoreLimit();
		
		// make sure we check time limit right when game ends
		if ( isdefined( level.startTime ) )
		{
			if ( getTimeRemaining() < 3000 )
			{
				wait .1;
				continue;
			}
		}
		wait 1;
	}
}

menuAutoAssign()
{
	teams[0] = "allies";
	teams[1] = "axis";

	assignment = teams[randomInt(2)];
	
	self closeMenus();

	if ( level.teamBased )
	{
		if ( getDvarInt( "party_autoteams" ) == 1 )
		{
			teamNum = getAssignedTeam( self );
			switch ( teamNum )
			{			
				case 1:
					assignment = teams[1];
					break;
					
				case 2:
					assignment = teams[0];
					break;
					
				default:
					assignment = "";
			}
		}
		
		//KILL THE KING - AFK COMES BACK
		//->
		if(isDefined(self.pers["afkteam"]) && (self.pers["afkteam"] == game["defenders"] || self.pers["afkteam"] == game["attackers"]))
		{
			if(self.pers["afkteam"] == game["attackers"])
				assignment = game["attackers"];
			else
				assignment = "";
		}
		//<-
		
		if ( assignment == "" || getDvarInt( "party_autoteams" ) == 0 )
		{	
			playerCounts = self maps\mp\gametypes\_teams::CountPlayers();
					
			// if teams are equal return the team with the lowest score
			if ( playerCounts["allies"] == playerCounts["axis"] )
			{
				if( getTeamScore( "allies" ) == getTeamScore( "axis" ) )
					assignment = teams[randomInt(2)];
				else if ( getTeamScore( "allies" ) < getTeamScore( "axis" ) )
					assignment = "allies";
				else
					assignment = "axis";
			}
			else if( playerCounts["allies"] < playerCounts["axis"] )
			{
				assignment = "allies";
			}
			else
			{
				assignment = "axis";
			}
		}
		
		if ( assignment == self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead") )
		{
			self beginClassChoice();
			return;
		}
	}

	if ( assignment != self.pers["team"] && (self.sessionstate == "playing" || self.sessionstate == "dead") )
	{
		self.switching_teams = true;
		self.joining_team = assignment;
		self.leaving_team = self.pers["team"];
		self suicide();
	}

	self.pers["team"] = assignment;
	self.team = assignment;
	self.pers["class"] = undefined;
	self.class = undefined;
	self.pers["weapon"] = undefined;
	self.pers["savedmodel"] = undefined;

	self updateObjectiveText();

	if ( level.teamBased )
		self.sessionteam = assignment;
	else
	{
		self.sessionteam = "none";
	}
	
	if ( !isAlive( self ) )
		self.statusicon = "hud_status_dead";
	
	self notify("joined_team");
	self notify("end_respawn");
	
	self beginClassChoice();
	
	self setclientdvar( "g_scriptMainMenu", game[ "menu_class_" + self.pers["team"] ] );
}

updateObjectiveText()
{
	if(isDefined(self.pers["objectiveTextMessage"]))
		curObjectiveTextMessage = self.pers["objectiveTextMessage"];
	else
	{
		curObjectiveTextMessage = "";
		self.pers["objectiveTextMessage"] = curObjectiveTextMessage;
		self setclientdvar( "cg_objectiveText", curObjectiveTextMessage);
	}

	if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator")
		self.pers["objectiveTextMessage"] = "";
	else
		self.pers["objectiveTextMessage"] = self getObjectiveScoreText();

	if(self.pers["objectiveTextMessage"] != curObjectiveTextMessage)
		self setclientdvar("cg_objectiveText", self.pers["objectiveTextMessage"]);
}

closeMenus()
{
	self closeMenu();
	self closeInGameMenu();
}

beginClassChoice( forceNewChoice )
{
	assert( self.pers["team"] == "axis" || self.pers["team"] == "allies" );
	
	team = self.pers["team"];
	
	if ( !level.oldschool && level.gametype == "ktk")
	{
		// skip class choice and just spawn.
		
		self.pers["class"] = "sniper";
		self.class = "sniper";

		// open a menu that just sets the ui_team localvar
		self openMenu( game[ "menu_initteam_" + team ] );
		
		if ( self.sessionstate != "playing" && game["state"] == "playing" )
			self thread [[level.spawnClient]]();
		level thread updateTeamStatus();
		self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
		
		return;
	}

	// menu_changeclass_team is the one where you choose one of the n classes to play as.
	// menu_class_team is where you can choose to change your team, class, controls, or leave game.
	self openMenu( game[ "menu_changeclass_" + team ] );
	
	//if ( level.rankedMatch )
	//	self openMenu( game[ "menu_changeclass_" + team ] );
	//else
	//	self openMenu( game[ "menu_class_" + team ] );
}

showMainMenuForTeam()
{
	assert( self.pers["team"] == "axis" || self.pers["team"] == "allies" );
	
	team = self.pers["team"];
	
	// menu_changeclass_team is the one where you choose one of the n classes to play as.
	// menu_class_team is where you can choose to change your team, class, controls, or leave game.
	
	self openMenu( game[ "menu_class_" + team ] );
}

menuAllies()
{
	self closeMenus();
	
	if(self.pers["team"] != "allies")
	{
		if( level.teamBased && !maps\mp\gametypes\_teams::getJoinTeamPermissions( "allies" ) )
		{
			self openMenu(game["menu_team"]);
			return;
		}
		
		// allow respawn when switching teams during grace period.
		if ( level.inGracePeriod && (!isdefined(self.hasDoneCombat) || !self.hasDoneCombat) )
			self.hasSpawned = false;
			
		if(self.sessionstate == "playing")
		{
			self.switching_teams = true;
			self.joining_team = "allies";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		self.pers["team"] = "allies";
		self.team = "allies";
		self.pers["class"] = undefined;
		self.class = undefined;
		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;

		self updateObjectiveText();

		if ( level.teamBased )
			self.sessionteam = "allies";
		else
			self.sessionteam = "none";

		self setclientdvar("g_scriptMainMenu", game["menu_class_allies"]);

		self notify("joined_team");
		self notify("end_respawn");
	}
	
	self beginClassChoice();
}


menuAxis()
{
	self closeMenus();
	
	if(self.pers["team"] != "axis")
	{
		if( level.teamBased && !maps\mp\gametypes\_teams::getJoinTeamPermissions( "axis" ) )
		{
			self openMenu(game["menu_team"]);
			return;
		}

		// allow respawn when switching teams during grace period.
		if ( level.inGracePeriod && (!isdefined(self.hasDoneCombat) || !self.hasDoneCombat) )
			self.hasSpawned = false;

		if(self.sessionstate == "playing")
		{
			self.switching_teams = true;
			self.joining_team = "axis";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		self.pers["team"] = "axis";
		self.team = "axis";
		self.pers["class"] = undefined;
		self.class = undefined;
		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;

		self updateObjectiveText();

		if ( level.teamBased )
			self.sessionteam = "axis";
		else
			self.sessionteam = "none";

		self setclientdvar("g_scriptMainMenu", game["menu_class_axis"]);

		self notify("joined_team");
		self notify("end_respawn");
	}
	
	self beginClassChoice();
}

switchTeam( team, classchoice, spawn )
{
	self closeMenus();
	
	if(self.pers["team"] != team)
	{
		// allow respawn when switching teams during grace period.
		//if ( level.inGracePeriod && (!isdefined(self.hasDoneCombat) || !self.hasDoneCombat) )
			self.hasSpawned = false;

		self.switching_teams = true;
		self.joining_team = team;
		self.leaving_team = self.pers["team"];
	
		if(self.sessionstate == "playing") //if(self.sessionstate != "dead")
		{
			// Suicide the player so they can't hit escape and fail the team balance
			self suicide();
		}

		//Viking - Make sure he can gain all killstreaks when he was switched
		self.cur_kill_streak = 0;
		self.pers["team"] = team;
		self.team = team;
		/*self.pers["class"] = undefined;
		self.class = undefined;
		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;*/
		
		self updateObjectiveText();
		
		if ( level.teamBased )
			self.sessionteam = team;
		else
			self.sessionteam = "none";

		if ( self.pers["team"] == "allies" )
		{
			self setclientdvar("g_scriptMainMenu", game["menu_class_allies"]);
			//self openMenu( game[ "menu_changeclass_allies" ] );
		}
		else
		{
			self setclientdvar("g_scriptMainMenu", game["menu_class_axis"]);
			//self openMenu( game[ "menu_changeclass_axis" ] );
		}

		//a copy from changeTeam of _teams.gsc
		//->
		self.pers["teamTime"] = undefined;
		
		// update spectator permissions immediately on change of team
		self maps\mp\gametypes\_spectating::setSpectatePermissions();
		//<-
		
		self notify("joined_team");
		self notify("end_respawn");
	}
	
	if( isDefined( classchoice ) && classchoice )	
		self beginClassChoice();
	
	if(!isdefined(self.pers["class"]) || !isdefined(self.class))
	{
		self.pers["class"] = "assault";
		self.class = "assault";
	}
		
	if(isDefined( spawn ) && spawn)
	{
		//is that player still on the server? - He could have left during the selection
		if(isDefined(self) && isPlayer(self))
		{
			//is the round still in progress? - It could have already ended
			if(self.sessionstate != "playing" && game["state"] == "playing")
				self [[level.spawnClient]]();
			
			if(self isAGuard())
				self thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "Guardians", self GetLocalizedString("GUARD_DESC"), "guards_logo", game["colors"][team], game["music"]["spawn_" + team] );
			else if(self isAnAssassin())
				self thread maps\mp\gametypes\_hud_message::oldNotifyMessage( "Assassins", self GetLocalizedString("ASS_DESC"), "assassins_logo", game["colors"][team], game["music"]["spawn_" + team] );
		}
	}
}

menuSpectator()
{
	self closeMenus();
	
	if(self.pers["team"] != "spectator" || (isDefined(self.pers["admin"]) && self.pers["admin"] && self.pers["team"] == "spectator"))
	{
		if(isAlive(self))
		{
			self.switching_teams = true;
			self.joining_team = "spectator";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		self.pers["team"] = "spectator";
		self.team = "spectator";
		self.pers["class"] = undefined;
		self.class = undefined;
		self.pers["weapon"] = undefined;
		self.pers["savedmodel"] = undefined;

		self updateObjectiveText();

		self.sessionteam = "spectator";
		[[level.spawnSpectator]]();

		self setclientdvar("g_scriptMainMenu", game["menu_team"]);

		self notify("joined_spectators");
	}
}


menuClass( response )
{
	self closeMenus();
	
	// clears new status of unlocked classes
	if ( response == "demolitions_mp,0" && self getstat( int( tablelookup( "mp/statstable.csv", 4, "feature_demolitions", 1 ) ) ) != 1 )
	{
		demolitions_stat = int( tablelookup( "mp/statstable.csv", 4, "feature_demolitions", 1 ) );
		self setstat( demolitions_stat, 1 );
		//println( "Demolitions class [new status cleared]: stat(" + demolitions_stat + ") = " + self getstat( demolitions_stat ) );	
	}
	if ( response == "sniper_mp,0" && self getstat( int( tablelookup( "mp/statstable.csv", 4, "feature_sniper", 1 ) ) ) != 1 )
	{	
		sniper_stat = int( tablelookup( "mp/statstable.csv", 4, "feature_sniper", 1 ) );
		self setstat( sniper_stat, 1 );
		//println( "Sniper class [new status cleared]: stat(" + sniper_stat + ") = " + self getstat( sniper_stat ) );	
	}
	assert( !level.oldschool );
	
	// this should probably be an assert
	if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
		return;

	class = self maps\mp\gametypes\_class::getClassChoice( response );
	primary = self maps\mp\gametypes\_class::getWeaponChoice( response );

	if ( class == "restricted" )
	{
		self beginClassChoice();
		return;
	}

	if( (isDefined( self.pers["class"] ) && self.pers["class"] == class) && 
		(isDefined( self.pers["primary"] ) && self.pers["primary"] == primary) )
		return;

	if ( self.sessionstate == "playing" )
	{
		self.pers["class"] = class;
		self.class = class;
		self.pers["primary"] = primary;
		self.pers["weapon"] = undefined;

		if ( game["state"] == "postgame" )
			return;

		if ( level.inGracePeriod && !self.hasDoneCombat ) // used weapons check?
		{
			self maps\mp\gametypes\_class::setClass( self.pers["class"] );
			self.tag_stowed_back = undefined;
			self.tag_stowed_hip = undefined;
			self maps\mp\gametypes\_class::giveLoadout( self.pers["team"], self.pers["class"] );
		}
		else if ( !level.splitScreen )
		{
			self iPrintLnBold( game["strings"]["change_class"] );
		}
	}
	else
	{
		self.pers["class"] = class;
		self.class = class;
		self.pers["primary"] = primary;
		self.pers["weapon"] = undefined;

		if ( game["state"] == "postgame" )
			return;

		if ( game["state"] == "playing" )
			self thread [[level.spawnClient]]();
	}

	level thread updateTeamStatus();

	self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
}

/#
assertProperPlacement()
{
	numPlayers = level.placement["all"].size;
	for ( i = 0; i < numPlayers - 1; i++ )
	{
		if ( level.placement["all"][i].score < level.placement["all"][i + 1].score )
		{
			println("^1Placement array:");
			for ( i = 0; i < numPlayers; i++ )
			{
				player = level.placement["all"][i];
				println("^1" + i + ". " + player.name + ": " + player.score );
			}
			assertmsg( "Placement array was not properly sorted" );
			break;
		}
	}
}
#/


removeDisconnectedPlayerFromPlacement()
{
	offset = 0;
	numPlayers = level.placement["all"].size;
	found = false;
	for ( i = 0; i < numPlayers; i++ )
	{
		if ( level.placement["all"][i] == self )
			found = true;
		
		if ( found )
			level.placement["all"][i] = level.placement["all"][ i + 1 ];
	}
	if ( !found )
		return;
	
	level.placement["all"][ numPlayers - 1 ] = undefined;
	assert( level.placement["all"].size == numPlayers - 1 );

	/#
	// no longer calling this here because it's possible, due to delayed assist credit,
	// for someone's score to change after updatePlacement() is called.
	//assertProperPlacement();
	#/
	
	updateTeamPlacement();
	
	if ( level.teamBased )
		return;
		
	numPlayers = level.placement["all"].size;
	for ( i = 0; i < numPlayers; i++ )
	{
		player = level.placement["all"][i];
		player notify( "update_outcome" );
	}
	
}

updatePlacement()
{
	prof_begin("updatePlacement");
	
	if ( !level.players.size )
		return;

	level.placement["all"] = [];
	for ( index = 0; index < level.players.size; index++ )
	{
		if ( level.players[index].team == "allies" || level.players[index].team == "axis" )
			level.placement["all"][level.placement["all"].size] = level.players[index];
	}
		
	placementAll = level.placement["all"];
	
	for ( i = 1; i < placementAll.size; i++ )
	{
		player = placementAll[i];
				
		if(game["customEvent"] == "lastkingstanding")
		{
			playerScore = player.pers["kingtime"];

			for ( j = i - 1; j >= 0 && playerScore > placementAll[j].pers["kingtime"]; j-- )
				placementAll[j + 1] = placementAll[j];
		}
		else
		{
			playerScore = player.score;
		
			for ( j = i - 1; j >= 0 && (playerScore > placementAll[j].score || (playerScore == placementAll[j].score && player.deaths < placementAll[j].deaths)); j-- )
				placementAll[j + 1] = placementAll[j];
		}
		
		placementAll[j + 1] = player;
	}
	
	level.placement["all"] = placementAll;
	
	/#
	assertProperPlacement();
	#/
	
	updateTeamPlacement();

	prof_end("updatePlacement");
}


updateTeamPlacement()
{
	placement["allies"]    = [];
	placement["axis"]      = [];
	placement["spectator"] = [];
	
	if ( !level.teamBased )
		return;
	
	placementAll = level.placement["all"];
	placementAllSize = placementAll.size;
	
	for ( i = 0; i < placementAllSize; i++ )
	{
		player = placementAll[i];
		team = player.pers["team"];
		
		placement[team][ placement[team].size ] = player;
	}
	
	level.placement["allies"] = placement["allies"];
	level.placement["axis"]   = placement["axis"];
}

onXPEvent( event )
{
	self maps\mp\gametypes\_rank::giveRankXP( event );
}


givePlayerScore( event, player, victim )
{
	if ( level.overridePlayerScore )
		return;
	
	score = player.pers["score"];
	[[level.onPlayerScore]]( event, player, victim );
	
	if ( score == player.pers["score"] )
		return;
	
	player maps\mp\gametypes\_persistence::statAdd( "score", (player.pers["score"] - score) );
	
	player.score = player.pers["score"];
	
	if ( !level.teambased )
		thread sendUpdatedDMScores();
	
	player notify ( "update_playerscore_hud" );
	player thread checkScoreLimit();
}


default_onPlayerScore( event, player, victim )
{
	score = maps\mp\gametypes\_rank::getScoreInfoValue( event );
	
	assert( isDefined( score ) );
	/*
	if ( event == "assist" )
		player.pers["score"] += 2;
	else
		player.pers["score"] += 10;
	*/
	
	player.pers["score"] += score;
}


_setPlayerScore( player, score )
{
	if ( score == player.pers["score"] )
		return;

	player.pers["score"] = score;
	player.score = player.pers["score"];

	player notify ( "update_playerscore_hud" );
	player thread checkScoreLimit();
}


_getPlayerScore( player )
{
	return player.pers["score"];
}


giveTeamScore( event, team, player, victim )
{
	if ( level.overrideTeamScore )
		return;
		
	teamScore = game["teamScores"][team];
	[[level.onTeamScore]]( event, team, player, victim );
	
	if ( teamScore == game["teamScores"][team] )
		return;
	
	updateTeamScores( team );

	thread checkScoreLimit();
}

_setTeamScore( team, teamScore )
{
	if ( teamScore == game["teamScores"][team] )
		return;

	game["teamScores"][team] = teamScore;
	
	updateTeamScores( team );
	
	thread checkScoreLimit();
}

updateTeamScores( team1, team2 )
{
	setTeamScore( team1, getGameScore( team1 ) );
	if ( isdefined( team2 ) )
		setTeamScore( team2, getGameScore( team2 ) );
	
	if ( level.teambased )
		thread sendUpdatedTeamScores();
}


_getTeamScore( team )
{
	return game["teamScores"][team];
}


default_onTeamScore( event, team, player, victim )
{
	score = maps\mp\gametypes\_rank::getScoreInfoValue( event );
	
	assert( isDefined( score ) );
	
	otherTeam = level.otherTeam[team];
	
	if ( game["teamScores"][team] > game["teamScores"][otherTeam] )
		level.wasWinning = team;
	else if ( game["teamScores"][otherTeam] > game["teamScores"][team] )
		level.wasWinning = otherTeam;
		
	game["teamScores"][team] += score;

	isWinning = "none";
	if ( game["teamScores"][team] > game["teamScores"][otherTeam] )
		isWinning = team;
	else if ( game["teamScores"][otherTeam] > game["teamScores"][team] )
		isWinning = otherTeam;

	if ( !level.splitScreen && isWinning != "none" && isWinning != level.wasWinning && getTime() - level.lastStatusTime  > 5000 )
	{
		level.lastStatusTime = getTime();
		leaderDialog( "lead_taken", isWinning, "status" );
		if ( level.wasWinning != "none")
			leaderDialog( "lead_lost", level.wasWinning, "status" );		
	}

	if ( isWinning != "none" )
		level.wasWinning = isWinning;
}


sendUpdatedTeamScores()
{
	level notify("updating_scores");
	level endon("updating_scores");
	wait .05;
	
	WaitTillSlowProcessAllowed();

	for ( i = 0; i < level.players.size; i++ )
	{
		level.players[i] updateScores();
	}
}

sendUpdatedDMScores()
{
	level notify("updating_dm_scores");
	level endon("updating_dm_scores");
	wait .05;
	
	WaitTillSlowProcessAllowed();
	
	for ( i = 0; i < level.players.size; i++ )
	{
		level.players[i] updateDMScores();
		level.players[i].updatedDMScores = true;
	}
}

initPersStat( dataName )
{
	if( !isDefined( self.pers[dataName] ) )
		self.pers[dataName] = 0;
}


getPersStat( dataName )
{
	return self.pers[dataName];
}


incPersStat( dataName, increment )
{
	self.pers[dataName] += increment;
	self maps\mp\gametypes\_persistence::statAdd( dataName, increment );
}


updatePersRatio( ratio, num, denom )
{
	numValue = self maps\mp\gametypes\_persistence::statGet( num );
	denomValue = self maps\mp\gametypes\_persistence::statGet( denom );
	if ( denomValue == 0 )
		denomValue = 1;
	
	if(ratio == "kdratio")
	{
		if(numValue > 0 && denomValue > 0)
		{
			float = int((numValue/denomValue)*100)/100;
			helpstring = "" + float + "";
			
			kdratio = [];
			kdratio = strTok( helpstring, "." );
			
			if(!isDefined(kdratio[1]))
				kdratio[1] = 0;
			else
			{
				if(kdratio[1].size == 1)
				{
					kdratio[1] = int(kdratio[1]);
				
					if(kdratio[1] > 0)
						kdratio[1] *= 10;
				}
			}
		}
		else
		{
			kdratio = [];
			kdratio[0] = 0;
			kdratio[1] = 0;
		}
	
		self maps\mp\gametypes\_persistence::statSet( ratio, int(kdratio[0]) );
		self maps\mp\gametypes\_persistence::statSet( ratio + "_2", int(kdratio[1]) );
	}
	else
		self maps\mp\gametypes\_persistence::statSet( ratio, int( (numValue * 1000) / denomValue ) );		
}


updateTeamStatus()
{
	// run only once per frame, at the end of the frame.
	level notify("updating_team_status");
	level endon("updating_team_status");
	level endon ( "game_ended" );
	waittillframeend;
	
	wait 0;	// Required for Callback_PlayerDisconnect to complete before updateTeamStatus can execute

	if ( game["state"] == "postgame" )
		return;

	resetTimeout();
	
	prof_begin( "updateTeamStatus" );

	level.playerCount["allies"] = 0;
	level.playerCount["axis"] = 0;
	
	level.lastAliveCount["allies"] = level.aliveCount["allies"];
	level.lastAliveCount["axis"] = level.aliveCount["axis"];
	level.aliveCount["allies"] = 0;
	level.aliveCount["axis"] = 0;
	level.playerLives["allies"] = 0;
	level.playerLives["axis"] = 0;
	level.alivePlayers["allies"] = [];
	level.alivePlayers["axis"] = [];
	level.activePlayers = [];

	players = level.players;
	for ( i = 0; i < players.size; i++ )
	{
		player = players[i];
		
		if ( !isDefined( player ) && level.splitscreen )
			continue;

		team = player.team;
		class = player.class;
		
		if ( team != "spectator" && (level.oldschool || (isDefined( class ) && class != "")) )
		{
			level.playerCount[team]++;
			
			if ( player.sessionstate == "playing" )
			{
				level.aliveCount[team]++;
				level.playerLives[team]++;

				if ( isAlive( player ) )
				{
					level.alivePlayers[team][level.alivePlayers.size] = player;
					level.activeplayers[ level.activeplayers.size ] = player;
				}
			}
			else
			{
				if ( player maySpawn() )
					level.playerLives[team]++;
			}
		}
	}
	
	if ( level.aliveCount["allies"] + level.aliveCount["axis"] > level.maxPlayerCount )
		level.maxPlayerCount = level.aliveCount["allies"] + level.aliveCount["axis"];
	
	if ( level.aliveCount["allies"] )
		level.everExisted["allies"] = true;
	if ( level.aliveCount["axis"] )
		level.everExisted["axis"] = true;
	
	prof_end( "updateTeamStatus" );
	
	level updateGameEvents();
}

isValidClass( class )
{
	if ( level.oldschool )
	{
		assert( !isdefined( class ) );
		return true;
	}
	return isdefined( class ) && class != "";
}

playTickingSound()
{
	self endon("death");
	self endon("stop_ticking");
	level endon("game_ended");
	
	while(1)
	{
		self playSound( "ui_mp_suitcasebomb_timer" );
		wait 1.0;
	}
}

stopTickingSound()
{
	self notify("stop_ticking");
}

timeLimitClock()
{
	level endon ( "game_ended" );
	
	wait .05;
	
	clockObject = spawn( "script_origin", (0,0,0) );
	
	while ( game["state"] == "playing" )
	{
		if ( !level.timerStopped && level.timeLimit )
		{
			timeLeft = getTimeRemaining() / 1000;
			timeLeftInt = int(timeLeft + 0.5); // adding .5 and flooring rounds it.
			
			if ( timeLeftInt >= 30 && timeLeftInt <= 60 )
				level notify ( "match_ending_soon" );
				
			if ( timeLeftInt <= 10 || (timeLeftInt <= 30 && timeLeftInt % 2 == 0) )
			{
				level notify ( "match_ending_very_soon" );
				// don't play a tick at exactly 0 seconds, that's when something should be happening!
				if ( timeLeftInt == 0 )
					break;
				
				clockObject playSound( "ui_mp_timer_countdown" );
			}
			
			// synchronize to be exactly on the second
			if ( timeLeft - floor(timeLeft) >= .05 )
				wait timeLeft - floor(timeLeft);
		}

		wait ( 1.0 );
	}
}

timeLimitClock_Intermission( waitTime )
{
	setGameEndTime( getTime() + int(waitTime*1000) );
	clockObject = spawn( "script_origin", (0,0,0) );
	
	if ( waitTime >= 10.0 )
		wait ( waitTime - 10.0 );
		
	for ( ;; )
	{
		clockObject playSound( "ui_mp_timer_countdown" );
		wait ( 1.0 );
	}	
}


gameTimer()
{
	level endon ( "game_ended" );
	
	level waittill("prematch_over");
	
	level.startTime = getTime();
	level.discardTime = 0;
	
	if ( isDefined( game["roundMillisecondsAlreadyPassed"] ) )
	{
		level.startTime -= game["roundMillisecondsAlreadyPassed"];
		game["roundMillisecondsAlreadyPassed"] = undefined;
	}
	
	prevtime = gettime();
	
	while ( game["state"] == "playing" )
	{
		if ( !level.timerStopped )
		{
			// the wait isn't always exactly 1 second. dunno why.
			game["timepassed"] += gettime() - prevtime;
		}
		prevtime = gettime();
		wait ( 1.0 );
	}
}

getTimePassed()
{
	if ( !isDefined( level.startTime ) )
		return 0;
	
	if ( level.timerStopped )
		return (level.timerPauseTime - level.startTime) - level.discardTime;
	else
		return (gettime()            - level.startTime) - level.discardTime;

}


pauseTimer()
{
	if ( level.timerStopped )
		return;
	
	level.timerStopped = true;
	level.timerPauseTime = gettime();
}


resumeTimer()
{
	if ( !level.timerStopped )
		return;
	
	level.timerStopped = false;
	level.discardTime += gettime() - level.timerPauseTime;
}


startGame()
{
	thread gameTimer();
	level.timerStopped = false;
	thread maps\mp\gametypes\_spawnlogic::spawnPerFrameUpdate();

	prematchPeriod();
	level notify("prematch_over");

	thread timeLimitClock();
	thread gracePeriod();

	thread musicController();
	thread maps\mp\gametypes\_missions::roundBegin();	
}


musicController()
{
	level endon ( "game_ended" );

	//KILL THE KING
	return;
	
	if ( !level.hardcoreMode )
		thread suspenseMusic();
	
	level waittill ( "match_ending_soon" );

	if ( level.roundLimit == 1 || game["roundsplayed"] == (level.roundLimit - 1) )
	{	
		if ( !level.splitScreen )
		{
			if(GetTeamPlayersAlive(game["defenders"]) > GetTeamPlayersAlive(game["attackers"]))
			{
				if ( !level.hardcoreMode )
				{
					playSoundOnPlayers( game["music"]["winning"], "allies" );
					playSoundOnPlayers( game["music"]["losing"], "axis" );
				}
		
				leaderDialog( "winning", game["defenders"] );
				leaderDialog( "losing", game["attackers"] );
			}
			else if(GetTeamPlayersAlive(game["attackers"]) > GetTeamPlayersAlive(game["defenders"]))
			{
				if ( !level.hardcoreMode )
				{
					playSoundOnPlayers( game["music"]["winning"], "axis" );
					playSoundOnPlayers( game["music"]["losing"], "allies" );
				}
					
				leaderDialog( "winning", game["attackers"] );
				leaderDialog( "losing", game["defenders"] );
			}
			else
			{
				if ( !level.hardcoreMode )
					playSoundOnPlayers( game["music"]["losing"] );

				leaderDialog( "timesup" );
			}
	
			level waittill ( "match_ending_very_soon" );
			leaderDialog( "timesup" );
		}
	}
	else
	{
		if ( !level.hardcoreMode )
			playSoundOnPlayers( game["music"]["losing"] );

		leaderDialog( "timesup" );
	}
}


suspenseMusic()
{
	level endon ( "game_ended" );
	level endon ( "match_ending_soon" );
	
	numTracks = game["music"]["suspense"].size;
	for ( ;; )
	{
		wait ( randomFloatRange( 60, 120 ) );
		
		playSoundOnPlayers( game["music"]["suspense"][randomInt(numTracks)] ); 
	}
}


waitForPlayers( maxTime )
{
	endTime = gettime() + maxTime * 1000 - 200;
	
	if ( level.teamBased )
		while( (!level.everExisted[ "axis" ] || !level.everExisted[ "allies" ]) && gettime() < endTime )
			wait ( 0.05 );
	else
		while ( level.maxPlayerCount < 2 && gettime() < endTime )
			wait ( 0.05 );
}


prematchPeriod()
{
	makeDvarServerInfo( "ui_hud_hardcore", 1 );
	setDvar( "ui_hud_hardcore", 1 );
	level endon( "game_ended" );
	
	if ( level.prematchPeriod > 0 )
	{
		//KILL THE KING
		//matchStartTimer();
		matchStartTimerSkip();
	}
	else
	{
		matchStartTimerSkip();
	}
	
	level.inPrematchPeriod = false;
	
	for ( index = 0; index < level.players.size; index++ )
	{
		level.players[index] freezeControls( false );
		level.players[index] enableWeapons();

		hintMessage = getObjectiveHintText( level.players[index].pers["team"] );
		if ( !isDefined( hintMessage ) || !level.players[index].hasSpawned )
			continue;

		level.players[index] setClientDvar( "scr_objectiveText", hintMessage );
		level.players[index] thread maps\mp\gametypes\_hud_message::hintMessage( hintMessage );

	}

	leaderDialog( "offense_obj", game["attackers"], "introboost" );
	leaderDialog( "defense_obj", game["defenders"], "introboost" );

	if ( game["state"] != "playing" )
		return;

	setDvar( "ui_hud_hardcore", level.hardcoreMode );
}


gracePeriod()
{
	level endon("game_ended");
	
	wait ( level.gracePeriod );
	
	level notify ( "grace_period_ending" );
	wait ( 0.05 );
	
	level.inGracePeriod = false;
	
	if ( game["state"] != "playing" )
		return;
	
	if ( level.numLives )
	{
		// Players on a team but without a weapon show as dead since they can not get in this round
		players = level.players;
		
		for ( i = 0; i < players.size; i++ )
		{
			player = players[i];
			
			if ( !player.hasSpawned && player.sessionteam != "spectator" && !isAlive( player ) )
				player.statusicon = "hud_status_dead";
		}
	}
	
	level thread updateTeamStatus();
}


announceRoundWinner( winner, delay )
{
	if ( delay > 0 )
		wait delay;

	if ( !isDefined( winner ) || isPlayer( winner ) )
		return;

	if ( winner == "allies" )
	{
		leaderDialog( "round_success", "allies" );
		leaderDialog( "round_failure", "axis" );
	}
	else if ( winner == "axis" )
	{
		leaderDialog( "round_success", "axis" );
		leaderDialog( "round_failure", "allies" );
	}
	else
	{
//		leaderDialog( "mission_draw" );
	}
}


announceGameWinner( winner, delay )
{
	if ( delay > 0 )
		wait delay;

	if ( !isDefined( winner ) || isPlayer( winner ) )
		return;

	if ( winner == "allies" )
	{
		leaderDialog( "mission_success", "allies" );
		leaderDialog( "mission_failure", "axis" );
	}
	else if ( winner == "axis" )
	{
		leaderDialog( "mission_success", "axis" );
		leaderDialog( "mission_failure", "allies" );
	}
	else
	{
		leaderDialog( "mission_draw" );
	}
}


updateWinStats( winner )
{
	winner maps\mp\gametypes\_persistence::statAdd( "losses", -1 );
	
	println( "setting winner: " + winner maps\mp\gametypes\_persistence::statGet( "wins" ) );
	winner maps\mp\gametypes\_persistence::statAdd( "wins", 1 );
	winner updatePersRatio( "wlratio", "wins", "losses" );
	winner maps\mp\gametypes\_persistence::statAdd( "cur_win_streak", 1 );
	
	cur_win_streak = winner maps\mp\gametypes\_persistence::statGet( "cur_win_streak" );
	if ( cur_win_streak > winner maps\mp\gametypes\_persistence::statGet( "win_streak" ) )
		winner maps\mp\gametypes\_persistence::statSet( "win_streak", cur_win_streak );
}


updateLossStats( loser )
{	
	loser maps\mp\gametypes\_persistence::statAdd( "losses", 1 );
	loser updatePersRatio( "wlratio", "wins", "losses" );
	loser maps\mp\gametypes\_persistence::statSet( "cur_win_streak", 0 );	
}


updateTieStats( loser )
{	
	loser maps\mp\gametypes\_persistence::statAdd( "losses", -1 );
	
	loser maps\mp\gametypes\_persistence::statAdd( "ties", 1 );
	loser updatePersRatio( "wlratio", "wins", "losses" );
	loser maps\mp\gametypes\_persistence::statSet( "cur_win_streak", 0 );	
}


updateWinLossStats( winner )
{
	if ( level.roundLimit > 1 && !hitRoundLimit() )
		return;
		
	players = level.players;

	if ( !isDefined( winner ) || ( isDefined( winner ) && !isPlayer( winner ) && winner == "tie" ) )
	{
		for ( i = 0; i < players.size; i++ )
		{
			if ( !isDefined( players[i].pers["team"] ) )
				continue;

			if ( level.hostForcedEnd && players[i] getEntityNumber() == 0 )
				return;
				
			updateTieStats( players[i] );
		}		
	} 
	else if ( isPlayer( winner ) )
	{
		if ( level.hostForcedEnd && winner getEntityNumber() == 0 )
			return;
				
		updateWinStats( winner );
	}
	else
	{
		for ( i = 0; i < players.size; i++ )
		{
			if ( !isDefined( players[i].pers["team"] ) )
				continue;

			if ( level.hostForcedEnd && players[i] getEntityNumber() == 0 )
				return;

			if ( winner == "tie" )
				updateTieStats( players[i] );
			else if ( players[i].pers["team"] == winner )
				updateWinStats( players[i] );
		}
	}
}


TimeUntilWaveSpawn( minimumWait )
{
	// the time we'll spawn if we only wait the minimum wait.
	earliestSpawnTime = gettime() + minimumWait * 1000;
	
	lastWaveTime = level.lastWave[self.pers["team"]];
	waveDelay = level.waveDelay[self.pers["team"]] * 1000;
	
	// the number of waves that will have passed since the last wave happened, when the minimum wait is over.
	numWavesPassedEarliestSpawnTime = (earliestSpawnTime - lastWaveTime) / waveDelay;
	// rounded up
	numWaves = ceil( numWavesPassedEarliestSpawnTime );
	
	timeOfSpawn = lastWaveTime + numWaves * waveDelay;
	
	// avoid spawning everyone on the same frame
	if ( isdefined( self.waveSpawnIndex ) )
		timeOfSpawn += 50 * self.waveSpawnIndex;
	
	return (timeOfSpawn - gettime()) / 1000;
}

TeamKillDelay()
{
	teamkills = self.pers["teamkills"];
	if ( level.minimumAllowedTeamKills < 0 || teamkills <= level.minimumAllowedTeamKills )
		return 0;
	exceeded = (teamkills - level.minimumAllowedTeamKills);
	return maps\mp\gametypes\_tweakables::getTweakableValue( "team", "teamkillspawndelay" ) * exceeded;
}


TimeUntilSpawn( includeTeamkillDelay )
{
	if ( level.inGracePeriod && !self.hasSpawned )
		return 0;
	
	respawnDelay = 0;
	if ( self.hasSpawned )
	{
		result = self [[level.onRespawnDelay]]();
		if ( isDefined( result ) )
			respawnDelay = result;
		else
			respawnDelay = getDvarInt( "scr_" + level.gameType + "_playerrespawndelay" );
			
		if ( level.hardcoreMode && !isDefined( result ) && !respawnDelay )
			respawnDelay = 10.0;
			
		if ( includeTeamkillDelay && self.teamKillPunish )
			respawnDelay += TeamKillDelay();
	}

	waveBased = (getDvarInt( "scr_" + level.gameType + "_waverespawndelay" ) > 0);

	if ( waveBased )
		return self TimeUntilWaveSpawn( respawnDelay );
	
	return respawnDelay;
}


maySpawn()
{
	if ( level.inOvertime )
		return false;

	if ( level.numLives )
	{
		if ( level.teamBased )
			gameHasStarted = ( level.everExisted[ "axis" ] && level.everExisted[ "allies" ] );
		else
			gameHasStarted = (level.maxPlayerCount > 1);

		if ( !self.pers["lives"] && gameHasStarted )
		{
			return false;
		}
		else if ( gameHasStarted )
		{
			//KILL THE KING
			// disallow spawning for late comers
			if(!level.inGracePeriod && !self.hasSpawned )
			{
				if(game["customEvent"] == "traitors")
					return false;
					
				if(game["customEvent"] == "lastkingstanding")
				{
					//there are real player left - do not spawn late comers
					if((level.aliveCount["allies"] + level.aliveCount["axis"]) > GetAliveBots())
						return false;
				}
			}
		}
	}
	
	//KILL THE KING
	if(isDefined(self.pers["afkteam"]) && level.roundStarted)
	{
		self.pers["afkteam"] = undefined;
		return false;
	}
	
	return true;
}

spawnClient( timeAlreadyPassed )
{
	assert(	isDefined( self.team ) );
	assert(	isValidClass( self.class ) );
	
	if ( !self maySpawn() )
	{
		currentorigin =	self.origin;
		currentangles =	self.angles;
		
		shouldShowRespawnMessage = true;
		if ( level.roundLimit > 1 && game["roundsplayed"] >= (level.roundLimit - 1) )
			shouldShowRespawnMessage = false;
		if ( level.scoreLimit > 1 && level.teambased && game["teamScores"]["allies"] >= level.scoreLimit - 1 && game["teamScores"]["axis"] >= level.scoreLimit - 1 )
			shouldShowRespawnMessage = false;
		if ( shouldShowRespawnMessage )
		{
			setLowerMessage( game["strings"]["spawn_next_round"] );
			self thread removeSpawnMessageShortly( 3 );
		}
		self thread	[[level.spawnSpectator]]( currentorigin	+ (0, 0, 60), currentangles	);
		return;
	}
	
	if ( self.waitingToSpawn )
		return;
	self.waitingToSpawn = true;
	
	self waitAndSpawnClient( timeAlreadyPassed );
	
	if ( isdefined( self ) )
		self.waitingToSpawn = false;
}

waitAndSpawnClient( timeAlreadyPassed )
{
	self endon ( "disconnect" );
	self endon ( "end_respawn" );
	self endon ( "game_ended" );
	
	if ( !isdefined( timeAlreadyPassed ) )
		timeAlreadyPassed = 0;
	
	spawnedAsSpectator = false;
	
	if ( self.teamKillPunish )
	{
		teamKillDelay = TeamKillDelay();
		if ( teamKillDelay > timeAlreadyPassed )
		{
			teamKillDelay -= timeAlreadyPassed;
			timeAlreadyPassed = 0;
		}
		else
		{
			timeAlreadyPassed -= teamKillDelay;
			teamKillDelay = 0;
		}
		
		if ( teamKillDelay > 0 )
		{
			setLowerMessage( &"MP_FRIENDLY_FIRE_WILL_NOT", teamKillDelay );
			
			self thread	respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
			spawnedAsSpectator = true;
			
			wait( teamKillDelay );
		}
		
		self.teamKillPunish = false;
	}
	
	if ( !isdefined( self.waveSpawnIndex ) && isdefined( level.wavePlayerSpawnIndex[self.team] ) )
	{
		self.waveSpawnIndex = level.wavePlayerSpawnIndex[self.team];
		level.wavePlayerSpawnIndex[self.team]++;
	}
	
	timeUntilSpawn = TimeUntilSpawn( false );
	if ( timeUntilSpawn > timeAlreadyPassed )
	{
		timeUntilSpawn -= timeAlreadyPassed;
		timeAlreadyPassed = 0;
	}
	else
	{
		timeAlreadyPassed -= timeUntilSpawn;
		timeUntilSpawn = 0;
	}
	
	if ( timeUntilSpawn > 0 )
	{
		// spawn player into spectator on death during respawn delay, if he switches teams during this time, he will respawn next round
		setLowerMessage( game["strings"]["waiting_to_spawn"], timeUntilSpawn );
		
		if ( !spawnedAsSpectator )
			self thread	respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
		spawnedAsSpectator = true;
		
		self waitForTimeOrNotify( timeUntilSpawn, "force_spawn" );
	}
	
	waveBased = (getDvarInt( "scr_" + level.gameType + "_waverespawndelay" ) > 0);
	if ( maps\mp\gametypes\_tweakables::getTweakableValue( "player", "forcerespawn" ) == 0 && self.hasSpawned && !waveBased )
	{
		setLowerMessage( game["strings"]["press_to_spawn"] );
		
		if ( !spawnedAsSpectator )
			self thread	respawn_asSpectator( self.origin + (0, 0, 60), self.angles );
		spawnedAsSpectator = true;
		
		self waitRespawnButton();
	}
	
	self.waitingToSpawn = false;
	
	self clearLowerMessage();
	
	self.waveSpawnIndex = undefined;
	
	self thread	[[level.spawnPlayer]]();
}


waitForTimeOrNotify( time, notifyname )
{
	self endon( notifyname );
	wait time;
}


removeSpawnMessageShortly( delay )
{
	self endon("disconnect");
	
	waittillframeend; // so we don't endon the end_respawn from spawning as a spectator
	
	self endon("end_respawn");
	
	wait delay;
	
	self clearLowerMessage( 2.0 );
}


Callback_StartGameType()
{
	maps\mp\gametypes\_scriptcommands::init();

	level.prematchPeriod = 0;
	level.prematchPeriodEnd = 0;
	
	level.intermission = false;
	
	if ( !isDefined( game["gamestarted"] ) )
	{
		// defaults if not defined in level script
		if ( !isDefined( game["allies"] ) )
			game["allies"] = "marines";
		if ( !isDefined( game["axis"] ) )
			game["axis"] = "opfor";
		if ( !isDefined( game["attackers"] ) )
			game["attackers"] = "allies";
		if (  !isDefined( game["defenders"] ) )
			game["defenders"] = "axis";

		if ( !isDefined( game["state"] ) )
			game["state"] = "playing";
	
		precacheStatusIcon( "hud_status_dead" );
		precacheStatusIcon( "hud_status_connecting" );
		
		precacheRumble( "damage_heavy" );

		precacheShader( "white" );
		precacheShader( "black" );
		
		makeDvarServerInfo( "scr_allies", "usmc" );
		makeDvarServerInfo( "scr_axis", "arab" );
		
		//makeDvarServerInfo( "cg_thirdPersonAngle", 345 );

		//setDvar( "cg_thirdPersonAngle", 345 );

		game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
		if ( level.teamBased )
		{
			game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_TEAMS";
			game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
		}
		else
		{
			game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_PLAYERS";
			game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
		}
		game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
		game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
		game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
		game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
		game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
		game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
		
		game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
		
		game["strings"]["tie"] = &"MP_MATCH_TIE";
		game["strings"]["round_draw"] = &"MP_ROUND_DRAW";

		game["strings"]["enemies_eliminated"] = &"MP_ENEMIES_ELIMINATED";
		game["strings"]["score_limit_reached"] = &"MP_SCORE_LIMIT_REACHED";
		game["strings"]["round_limit_reached"] = &"MP_ROUND_LIMIT_REACHED";
		game["strings"]["time_limit_reached"] = &"MP_TIME_LIMIT_REACHED";
		game["strings"]["players_forfeited"] = &"MP_PLAYERS_FORFEITED";

		switch ( game["allies"] )
		{
			case "sas":
				game["strings"]["allies_win"] = &"MP_SAS_WIN_MATCH";
				game["strings"]["allies_win_round"] = &"MP_SAS_WIN_ROUND";
				game["strings"]["allies_mission_accomplished"] = &"MP_SAS_MISSION_ACCOMPLISHED";
				game["strings"]["allies_eliminated"] = &"MP_SAS_ELIMINATED";
				game["strings"]["allies_forfeited"] = &"MP_SAS_FORFEITED";
				game["strings"]["allies_name"] = &"MP_SAS_NAME";
				
				game["music"]["spawn_allies"] = "mp_spawn_sas";
				game["music"]["victory_allies"] = "mp_victory_sas";
				game["icons"]["allies"] = "faction_128_sas";
				game["colors"]["allies"] = (0.6,0.64,0.69);
				game["voice"]["allies"] = "UK_1mc_";
				setDvar( "scr_allies", "sas" );
				break;
			case "marines":
			default:
				game["strings"]["allies_win"] = &"MP_MARINES_WIN_MATCH";
				game["strings"]["allies_win_round"] = &"MP_MARINES_WIN_ROUND";
				game["strings"]["allies_mission_accomplished"] = &"MP_MARINES_MISSION_ACCOMPLISHED";
				game["strings"]["allies_eliminated"] = &"MP_MARINES_ELIMINATED";
				game["strings"]["allies_forfeited"] = &"MP_MARINES_FORFEITED";
				game["strings"]["allies_name"] = &"MP_MARINES_NAME";
				
				game["music"]["spawn_allies"] = "mp_spawn_usa";
				game["music"]["victory_allies"] = "mp_victory_usa";
				game["icons"]["allies"] = "faction_128_usmc";
				game["colors"]["allies"] = (0,0,0);
				game["voice"]["allies"] = "US_1mc_";
				setDvar( "scr_allies", "usmc" );
				break;
		}
		switch ( game["axis"] )
		{
			case "russian":
				game["strings"]["axis_win"] = &"MP_SPETSNAZ_WIN_MATCH";
				game["strings"]["axis_win_round"] = &"MP_SPETSNAZ_WIN_ROUND";
				game["strings"]["axis_mission_accomplished"] = &"MP_SPETSNAZ_MISSION_ACCOMPLISHED";
				game["strings"]["axis_eliminated"] = &"MP_SPETSNAZ_ELIMINATED";
				game["strings"]["axis_forfeited"] = &"MP_SPETSNAZ_FORFEITED";
				game["strings"]["axis_name"] = &"MP_SPETSNAZ_NAME";
				
				game["music"]["spawn_axis"] = "mp_spawn_soviet";
				game["music"]["victory_axis"] = "mp_victory_soviet";
				game["icons"]["axis"] = "faction_128_ussr";
				game["colors"]["axis"] = (0.52,0.28,0.28);
				game["voice"]["axis"] = "RU_1mc_";
				setDvar( "scr_axis", "ussr" );
				break;
			case "arab":
			case "opfor":
			default:
				game["strings"]["axis_win"] = &"MP_OPFOR_WIN_MATCH";
				game["strings"]["axis_win_round"] = &"MP_OPFOR_WIN_ROUND";
				game["strings"]["axis_mission_accomplished"] = &"MP_OPFOR_MISSION_ACCOMPLISHED";
				game["strings"]["axis_eliminated"] = &"MP_OPFOR_ELIMINATED";
				game["strings"]["axis_forfeited"] = &"MP_OPFOR_FORFEITED";
				game["strings"]["axis_name"] = &"MP_OPFOR_NAME";
				
				game["music"]["spawn_axis"] = "mp_spawn_opfor";
				game["music"]["victory_axis"] = "mp_victory_opfor";
				game["icons"]["axis"] = "faction_128_arab";
				game["colors"]["axis"] = (0.65,0.57,0.41);
				game["voice"]["axis"] = "AB_1mc_";
				setDvar( "scr_axis", "arab" );
				break;
		}
		game["music"]["defeat"] = "mp_defeat";
		game["music"]["victory_spectator"] = "mp_defeat";
		game["music"]["winning"] = "mp_time_running_out_winning";
		game["music"]["losing"] = "mp_time_running_out_losing";
		game["music"]["victory_tie"] = "mp_defeat";
		
		game["music"]["suspense"] = [];
		game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_01";
		game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_02";
		game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_03";
		game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_04";
		game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_05";
		game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_06";
		
		game["dialog"]["mission_success"] = "mission_success";
		game["dialog"]["mission_failure"] = "mission_fail";
		game["dialog"]["mission_draw"] = "draw";

		game["dialog"]["round_success"] = "encourage_win";
		game["dialog"]["round_failure"] = "encourage_lost";
		game["dialog"]["round_draw"] = "draw";
		
		// status
		game["dialog"]["timesup"] = "timesup";
		game["dialog"]["winning"] = "winning";
		game["dialog"]["losing"] = "losing";
		game["dialog"]["lead_lost"] = "lead_lost";
		game["dialog"]["lead_tied"] = "tied";
		game["dialog"]["lead_taken"] = "lead_taken";
		game["dialog"]["last_alive"] = "lastalive";

		game["dialog"]["boost"] = "boost";

		if ( !isDefined( game["dialog"]["offense_obj"] ) )
			game["dialog"]["offense_obj"] = "boost";
		if ( !isDefined( game["dialog"]["defense_obj"] ) )
			game["dialog"]["defense_obj"] = "boost";
		
		game["dialog"]["hardcore"] = "hardcore";
		game["dialog"]["oldschool"] = "oldschool";
		game["dialog"]["highspeed"] = "highspeed";
		game["dialog"]["tactical"] = "tactical";

		game["dialog"]["challenge"] = "challengecomplete";
		game["dialog"]["promotion"] = "promotion";

		game["dialog"]["bomb_taken"] = "bomb_taken";
		game["dialog"]["bomb_lost"] = "bomb_lost";
		game["dialog"]["bomb_defused"] = "bomb_defused";
		game["dialog"]["bomb_planted"] = "bomb_planted";

		game["dialog"]["obj_taken"] = "securedobj";
		game["dialog"]["obj_lost"] = "lostobj";

		game["dialog"]["obj_defend"] = "obj_defend";
		game["dialog"]["obj_destroy"] = "obj_destroy";
		game["dialog"]["obj_capture"] = "capture_obj";
		game["dialog"]["objs_capture"] = "capture_objs";

		game["dialog"]["hq_located"] = "hq_located";
		game["dialog"]["hq_enemy_captured"] = "hq_captured";
		game["dialog"]["hq_enemy_destroyed"] = "hq_destroyed";
		game["dialog"]["hq_secured"] = "hq_secured";
		game["dialog"]["hq_offline"] = "hq_offline";
		game["dialog"]["hq_online"] = "hq_online";

		game["dialog"]["move_to_new"] = "new_positions";

		game["dialog"]["attack"] = "attack";
		game["dialog"]["defend"] = "defend";
		game["dialog"]["offense"] = "offense";
		game["dialog"]["defense"] = "defense";

		game["dialog"]["halftime"] = "halftime";
		game["dialog"]["overtime"] = "overtime";
		game["dialog"]["side_switch"] = "switching";

		game["dialog"]["flag_taken"] = "ourflag";
		game["dialog"]["flag_dropped"] = "ourflag_drop";
		game["dialog"]["flag_returned"] = "ourflag_return";
		game["dialog"]["flag_captured"] = "ourflag_capt";
		game["dialog"]["enemy_flag_taken"] = "enemyflag";
		game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
		game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
		game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";

		game["dialog"]["capturing_a"] = "capturing_a";
		game["dialog"]["capturing_b"] = "capturing_b";
		game["dialog"]["capturing_c"] = "capturing_c";
		game["dialog"]["captured_a"] = "capture_a";
		game["dialog"]["captured_b"] = "capture_c";
		game["dialog"]["captured_c"] = "capture_b";

		game["dialog"]["securing_a"] = "securing_a";
		game["dialog"]["securing_b"] = "securing_b";
		game["dialog"]["securing_c"] = "securing_c";
		game["dialog"]["secured_a"] = "secure_a";
		game["dialog"]["secured_b"] = "secure_b";
		game["dialog"]["secured_c"] = "secure_c";

		game["dialog"]["losing_a"] = "losing_a";
		game["dialog"]["losing_b"] = "losing_b";
		game["dialog"]["losing_c"] = "losing_c";
		game["dialog"]["lost_a"] = "lost_a";
		game["dialog"]["lost_b"] = "lost_b";
		game["dialog"]["lost_c"] = "lost_c";

		game["dialog"]["enemy_taking_a"] = "enemy_take_a";
		game["dialog"]["enemy_taking_b"] = "enemy_take_b";
		game["dialog"]["enemy_taking_c"] = "enemy_take_c";
		game["dialog"]["enemy_has_a"] = "enemy_has_a";
		game["dialog"]["enemy_has_b"] = "enemy_has_b";
		game["dialog"]["enemy_has_c"] = "enemy_has_c";

		game["dialog"]["lost_all"] = "take_positions";
		game["dialog"]["secure_all"] = "positions_lock";

		[[level.onPrecacheGameType]]();

		game["gamestarted"] = true;
		
		game["teamScores"]["allies"] = 0;
		game["teamScores"]["axis"] = 0;
		
		// first round, so set up prematch
		level.prematchPeriod = maps\mp\gametypes\_tweakables::getTweakableValue( "game", "playerwaittime" );
		level.prematchPeriodEnd = maps\mp\gametypes\_tweakables::getTweakableValue( "game", "matchstarttime" );
	}
	
	if(!isdefined(game["timepassed"]))
		game["timepassed"] = 0;

	if(!isdefined(game["roundsplayed"]))
		game["roundsplayed"] = 0;
	
	level.skipVote = false;
	level.gameEnded = false;
	level.teamSpawnPoints["axis"] = [];
	level.teamSpawnPoints["allies"] = [];

	level.objIDStart = 0;
	level.forcedEnd = false;
	level.hostForcedEnd = false;

	level.hardcoreMode = getDvarInt( "scr_hardcore" );
	if ( level.hardcoreMode )
		logString( "game mode: hardcore" );

	// this gets set to false when someone takes damage or a gametype-specific event happens.
	level.useStartSpawns = true;
	
	// set to 0 to disable
	if ( getdvar( "scr_teamKillPunishCount" ) == "" )
		setdvar( "scr_teamKillPunishCount", "3" );
	level.minimumAllowedTeamKills = getdvarint( "scr_teamKillPunishCount" ) - 1; // punishment starts at the next one
	
	if( getdvar( "r_reflectionProbeGenerate" ) == "1" )
		level waittill( "eternity" );

	//KILL THE KING
	//close any file that was previously FS_opened
	FS_FCloseAll();

	thread maps\mp\gametypes\_persistence::init();
	thread maps\mp\gametypes\_menus::init();
	thread maps\mp\gametypes\_hud::init();
	thread maps\mp\gametypes\_serversettings::init();
	thread maps\mp\gametypes\_clientids::init();
	thread maps\mp\gametypes\_teams::init();
	thread maps\mp\gametypes\_weapons::init();
	thread maps\mp\gametypes\_scoreboard::init();
	thread maps\mp\gametypes\_killcam::init();
	thread maps\mp\gametypes\_shellshock::init();
	thread maps\mp\gametypes\_deathicons::init();
	thread maps\mp\gametypes\_damagefeedback::init();
	thread maps\mp\gametypes\_healthoverlay::init();
	thread maps\mp\gametypes\_spectating::init();
	thread maps\mp\gametypes\_objpoints::init();
	thread maps\mp\gametypes\_gameobjects::init();
	thread maps\mp\gametypes\_spawnlogic::init();
	thread maps\mp\gametypes\_oldschool::init();
	thread maps\mp\gametypes\_battlechatter_mp::init();
	thread maps\mp\gametypes\_hardpoints::init();

	if ( level.teamBased )
		thread maps\mp\gametypes\_friendicons::init();
		
	thread maps\mp\gametypes\_hud_message::init();

	if ( !level.console )
		thread maps\mp\gametypes\_quickmessages::init();

	//KILL THE King
	thread maps\mp\gametypes\_general::main();
		
	stringNames = getArrayKeys( game["strings"] );
	for ( index = 0; index < stringNames.size; index++ )
		precacheString( game["strings"][stringNames[index]] );

	level.maxPlayerCount = 0;
	level.playerCount["allies"] = 0;
	level.playerCount["axis"] = 0;
	level.aliveCount["allies"] = 0;
	level.aliveCount["axis"] = 0;
	level.playerLives["allies"] = 0;
	level.playerLives["axis"] = 0;
	level.lastAliveCount["allies"] = 0;
	level.lastAliveCount["axis"] = 0;
	level.everExisted["allies"] = false;
	level.everExisted["axis"] = false;
	level.waveDelay["allies"] = 0;
	level.waveDelay["axis"] = 0;
	level.lastWave["allies"] = 0;
	level.lastWave["axis"] = 0;
	level.wavePlayerSpawnIndex["allies"] = 0;
	level.wavePlayerSpawnIndex["axis"] = 0;
	level.alivePlayers["allies"] = [];
	level.alivePlayers["axis"] = [];
	level.activePlayers = [];

	if ( !isDefined( level.timeLimit ) )
		registerTimeLimitDvar( "default", 10, 1, 1440 );
		
	if ( !isDefined( level.scoreLimit ) )
		registerScoreLimitDvar( "default", 100, 1, 500 );

	if ( !isDefined( level.roundLimit ) )
		registerRoundLimitDvar( "default", 1, 0, 10 );

	makeDvarServerInfo( "ui_scorelimit" );
	makeDvarServerInfo( "ui_timelimit" );
	makeDvarServerInfo( "ui_allow_classchange", getDvar( "ui_allow_classchange" ) );
	makeDvarServerInfo( "ui_allow_teamchange", getDvar( "ui_allow_teamchange" ) );
	
	if ( level.numlives )
		setdvar( "g_deadChat", 0 );
	else
		setdvar( "g_deadChat", 1 );
	
	waveDelay = getDvarInt( "scr_" + level.gameType + "_waverespawndelay" );
	if ( waveDelay )
	{
		level.waveDelay["allies"] = waveDelay;
		level.waveDelay["axis"] = waveDelay;
		level.lastWave["allies"] = 0;
		level.lastWave["axis"] = 0;
		
		level thread [[level.waveSpawnTimer]]();
	}
	
	level.inPrematchPeriod = true;
	
	level.gracePeriod = 5; //15;
	
	level.inGracePeriod = true;
	
	level.roundEndDelay = 5;
	level.halftimeRoundEndDelay = 3;
	
	updateTeamScores( "axis", "allies" );
	
	if ( !level.teamBased )
		thread initialDMScoreUpdate();
	
	[[level.onStartGameType]]();
	
	// this must be after onstartgametype for scr_showspawns to work when set at start of game
	///#
	//thread maps\mp\gametypes\_dev::init();
	//#/
	
	thread startGame();
	level thread updateGameTypeDvars();
}

initialDMScoreUpdate()
{
	// the first time we call updateDMScores on a player, we have to send them the whole scoreboard.
	// by calling updateDMScores on each player one at a time,
	// we can avoid having to send the entire scoreboard to every single player
	// the first time someone kills someone else.
	wait .2;
	numSent = 0;
	while(1)
	{
		didAny = false;
		
		players = level.players;
		for ( i = 0; i < players.size; i++ )
		{
			player = players[i];
			
			if ( !isdefined( player ) )
				continue;
			
			if ( isdefined( player.updatedDMScores ) )
				continue;
			
			player.updatedDMScores = true;
			player updateDMScores();
			
			didAny = true;
			wait .5;
		}
		
		if ( !didAny )
			wait 3; // let more players connect
	}
}

checkRoundSwitch()
{
	if ( !isdefined( level.roundSwitch ) || !level.roundSwitch )
		return false;
	if ( !isdefined( level.onRoundSwitch ) )
		return false;
	
	assert( game["roundsplayed"] > 0 );
	
	if ( game["roundsplayed"] % level.roundswitch == 0 )
	{
		if(level.script != "lolzor")
		{
			[[level.onRoundSwitch]]();
			return true;
		}
	}
		
	return false;
}


getGameScore( team )
{
	return game["teamScores"][team];
}


fakeLag()
{
	self endon ( "disconnect" );
	self.fakeLag = randomIntRange( 50, 150 );
	
	for ( ;; )
	{
		self setClientDvar( "fakelag_target", self.fakeLag );
		wait ( randomFloatRange( 5.0, 15.0 ) );
	}
}

listenForGameEnd()
{
	self waittill( "host_sucks_end_game" );
	if ( level.console )
		endparty();
	level.skipVote = true;

	if ( !level.gameEnded )
		level thread maps\mp\gametypes\_globallogic::forceEnd();
}


Callback_PlayerConnect()
{
	thread notifyConnecting();

	self.statusicon = "hud_status_connecting";
	self waittill( "begin" );
	waittillframeend;

	self.statusicon = "";

	level notify( "connected", self );
	
//	self thread fakeLag();
	if ( level.console && self getEntityNumber() == 0 )
		self thread listenForGameEnd();

	lpselfnum = self getEntityNumber();
	self.guid = self GetUniquePlayerID();
	
	if(!self isABot())
		logPrint("J;" + self.guid + ";" + lpselfnum + ";" + self.name + "\n");

	// only print that we connected if we haven't connected in a previous round
	if( !level.splitscreen && !isdefined( self.pers["score"] ) )
		self thread maps\mp\gametypes\ktk::NewPlayerOnServer();
	
	//KILL THE KING - DO THIS WITH A SHORT DELAY
	self thread setClientDvarOnConnectDelayed();
	/*
	self setClientDvars( "cg_drawSpectatorMessages", 1,
						 "ui_hud_hardcore", getDvar( "ui_hud_hardcore" ),
						 "player_sprintTime", getDvar( "scr_player_sprinttime" ),
						 "ui_uav_client", getDvar( "ui_uav_client" ) );

	if ( level.hardcoreMode )
	{
		self setClientDvars( "cg_drawTalk", 3,
						 	 "cg_drawCrosshairNames", 1,
							 "cg_drawCrosshair", 0, 
							 "cg_hudGrenadeIconMaxRangeFrag", 0 );
	}
	else
	{
		self setClientDvars( "cg_drawCrosshair", 1,
						 	 "cg_drawCrosshairNames", 1,
							 "cg_hudGrenadeIconMaxRangeFrag", 250 );
	}

	self setClientDvars("cg_hudGrenadeIconHeight", "25", 
						"cg_hudGrenadeIconWidth", "25", 
						"cg_hudGrenadeIconOffset", "50", 
						"cg_hudGrenadePointerHeight", "12", 
						"cg_hudGrenadePointerWidth", "25", 
						"cg_hudGrenadePointerPivot", "12 27");
						//"cg_fovscale", "1");
	
	if ( level.oldschool )
	{
		self setClientDvars( "ragdoll_explode_force", 60000,
							 "ragdoll_explode_upbias", 0.8,
							 "bg_fallDamageMinHeight", 256,
							 "bg_fallDamageMaxHeight", 512 );
	}
	
	if ( getdvarint("scr_hitloc_debug") )
	{
		for ( i = 0; i < 6; i++ )
		{
			self setClientDvar( "ui_hitloc_" + i, "" );
		}
		self.hitlocInited = true;
	}
	*/
	
	self initPersStat( "score" );
	self.score = self.pers["score"];

	self initPersStat( "deaths" );
	self.deaths = self getPersStat( "deaths" );

	self initPersStat( "suicides" );
	self.suicides = self getPersStat( "suicides" );

	self initPersStat( "kills" );
	self.kills = self getPersStat( "kills" );

	self initPersStat( "headshots" );
	self.headshots = self getPersStat( "headshots" );

	self initPersStat( "assists" );
	self.assists = self getPersStat( "assists" );
	
	self initPersStat( "teamkills" );
	self.teamKillPunish = false;
	if ( level.minimumAllowedTeamKills >= 0 && self.pers["teamkills"] > level.minimumAllowedTeamKills )
		self thread reduceTeamKillsOverTime();
	
	if( getdvar( "r_reflectionProbeGenerate" ) == "1" )
		level waittill( "eternity" );

	self.killedPlayers = [];
	self.killedPlayersCurrent = [];
	self.killedBy = [];
	
	self.leaderDialogQueue = [];
	self.leaderDialogActive = false;
	self.leaderDialogGroups = [];
	self.leaderDialogGroup = "";

	self.cur_kill_streak = 0;
	self.cur_death_streak = 0;
	self.death_streak = self maps\mp\gametypes\_persistence::statGet( "death_streak" );
	self.kill_streak = self maps\mp\gametypes\_persistence::statGet( "kill_streak" );
	self.lastGrenadeSuicideTime = -1;

	self.teamkillsThisRound = 0;
	
	self.pers["lives"] = level.numLives;
	
	self.hasSpawned = false;
	self.waitingToSpawn = false;
	self.deathCount = 0;
	self.damageOwner = undefined; 
	
	self.wasAliveAtMatchStart = false;
	
	self thread maps\mp\_flashgrenades::monitorFlash();
	
	/* added to the above delay
	if ( level.numLives )
	{
		self setClientDvars("cg_deadChatWithDead", 1,
							"cg_deadChatWithTeam", 0,
							"cg_deadHearTeamLiving", 0,
							"cg_deadHearAllLiving", 0,
							"cg_everyoneHearsEveryone", 0 );
	}
	else
	{
		self setClientDvars("cg_deadChatWithDead", 0,
							"cg_deadChatWithTeam", 1,
							"cg_deadHearTeamLiving", 1,
							"cg_deadHearAllLiving", 0,
							"cg_everyoneHearsEveryone", 0 );
	}
	*/
	
	level.players[level.players.size] = self;
	
	if( level.splitscreen )
		setdvar( "splitscreen_playerNum", level.players.size );
	
	if ( level.teambased )
		self updateScores();
	
	// When joining a game in progress, if the game is at the post game state (scoreboard) the connecting player should spawn into intermission
	if ( game["state"] == "postgame" )
	{
		self.pers["team"] = "spectator";
		self.team = "spectator";

		self setClientDvars( "ui_hud_hardcore", 1,
							   "cg_drawSpectatorMessages", 0 );
		
		[[level.spawnIntermission]]();
		self closeMenu();
		self closeInGameMenu();
		return;
	}

	updateLossStats( self );

	level endon( "game_ended" );

	if ( level.oldschool )
	{
		self.pers["class"] = undefined;
		self.class = self.pers["class"];
	}

	if ( isDefined( self.pers["team"] ) )
		self.team = self.pers["team"];

	if ( isDefined( self.pers["class"] ) )
		self.class = self.pers["class"];
	
	if ( !isDefined( self.pers["team"] ) )
	{
		// Don't set .sessionteam until we've gotten the assigned team from code,
		// because it overrides the assigned team.
		self.pers["team"] = "spectator";
		self.team = "spectator";
		self.sessionstate = "dead";
		
		self updateObjectiveText();
		
		[[level.spawnSpectator]]();
		
		if ( level.rankedMatch && level.console )
		{
			[[level.autoassign]]();
			
			//self thread forceSpawn();
			self thread kickIfDontSpawn();
		}
		else if ( !level.teamBased && level.console )
		{
			[[level.autoassign]]();
		}
		else
		{
			self setclientdvar( "g_scriptMainMenu", game["menu_team"] );
			self openMenu( game["menu_team"] );
		}
		
		if ( self.pers["team"] == "spectator" )
			self.sessionteam = "spectator";
		
		if ( level.teamBased )
		{
			// set team and spectate permissions so the map shows waypoint info on connect
			self.sessionteam = self.pers["team"];
			if ( !isAlive( self ) )
				self.statusicon = "hud_status_dead";
			self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
		}
	}
	else if ( self.pers["team"] == "spectator" )
	{
		self setclientdvar( "g_scriptMainMenu", game["menu_team"] );
		self.sessionteam = "spectator";
		self.sessionstate = "spectator";
		[[level.spawnSpectator]]();
	}
	else
	{
		self.sessionteam = self.pers["team"];
		self.sessionstate = "dead";
		
		self updateObjectiveText();
		
		[[level.spawnSpectator]]();
		
		if ( isValidClass( self.pers["class"] ) )
		{
			self thread [[level.spawnClient]]();			
		}
		else
		{
			self showMainMenuForTeam();
		}
		
		self thread maps\mp\gametypes\_spectating::setSpectatePermissions();
	}
	
	if(self isABot())
		return;
		
	// <font size="8"><strong>TO DO: DELETE THIS WHEN CODE HAS CHECKSUM SUPPORT!</strong></font> :: Check for stat integrity
	for( i=0; i<5; i++ )
	{
		if( !level.onlinegame )
			return;
			
		if( self getstat( 205+(i*10) ) == 0 )
		{
			kick( self getentitynumber() );
			return;
		}
	}
}

setClientDvarOnConnectDelayed()
{
	self endon("disconnect");

	wait 1;

	if(level.oldschool)
	{
		self setClientDvars(
			"ragdoll_explode_force", 60000,
			"ragdoll_explode_upbias", 0.8,
			"bg_fallDamageMinHeight", 256,
			"bg_fallDamageMaxHeight", 512,
			"cg_drawSpectatorMessages", 1,
			"ui_hud_hardcore", getDvar("ui_hud_hardcore"),
			"player_sprintTime", getDvar("scr_player_sprinttime"),
			"ui_uav_client", getDvar("ui_uav_client"),
			"cg_hudGrenadeIconHeight", "25", 
			"cg_hudGrenadeIconWidth", "25", 
			"cg_hudGrenadeIconOffset", "50", 
			"cg_hudGrenadePointerHeight", "12", 
			"cg_hudGrenadePointerWidth", "25", 
			"cg_hudGrenadePointerPivot", "12 27",
			"cg_deadChatWithDead", level.numLives,
			"cg_deadChatWithTeam", !level.numLives,
			"cg_deadHearTeamLiving", !level.numLives,
			"cg_deadHearAllLiving", 1,
			"cg_everyoneHearsEveryone", 1);
	}
	else
	{
		if (level.hardcoreMode)
		{
			self setClientDvars(
				"cg_drawTalk", 3,
				"cg_drawCrosshairNames", 1,
				"cg_drawCrosshair", 0, 
				"cg_hudGrenadeIconMaxRangeFrag", 0,
				"cg_drawSpectatorMessages", 1,
				"ui_hud_hardcore", getDvar("ui_hud_hardcore"),
				"player_sprintTime", getDvar("scr_player_sprinttime"),
				"ui_uav_client", getDvar("ui_uav_client"),
				"cg_hudGrenadeIconHeight", "25", 
				"cg_hudGrenadeIconWidth", "25", 
				"cg_hudGrenadeIconOffset", "50", 
				"cg_hudGrenadePointerHeight", "12", 
				"cg_hudGrenadePointerWidth", "25", 
				"cg_hudGrenadePointerPivot", "12 27",
				"cg_deadChatWithDead", level.numLives,
				"cg_deadChatWithTeam", !level.numLives,
				"cg_deadHearTeamLiving", !level.numLives,
				"cg_deadHearAllLiving", 1,
				"cg_everyoneHearsEveryone", 1);
		}
		else
		{
			self setClientDvars(
				"cg_drawCrosshair", 1,
				"cg_drawCrosshairNames", 1,
				"cg_hudGrenadeIconMaxRangeFrag", 250,
				"cg_drawSpectatorMessages", 1,
				"ui_hud_hardcore", getDvar("ui_hud_hardcore"),
				"player_sprintTime", getDvar("scr_player_sprinttime"),
				"ui_uav_client", getDvar("ui_uav_client"),
				"cg_hudGrenadeIconHeight", "25", 
				"cg_hudGrenadeIconWidth", "25", 
				"cg_hudGrenadeIconOffset", "50", 
				"cg_hudGrenadePointerHeight", "12", 
				"cg_hudGrenadePointerWidth", "25", 
				"cg_hudGrenadePointerPivot", "12 27",
				"cg_deadChatWithDead", level.numLives,
				"cg_deadChatWithTeam", !level.numLives,
				"cg_deadHearTeamLiving", !level.numLives,
				"cg_deadHearAllLiving", 1,
				"cg_everyoneHearsEveryone", 1);
		}
	}
}


forceSpawn()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	self endon ( "spawned" );

	wait ( 60.0 );

	if ( self.hasSpawned )
		return;
	
	if ( self.pers["team"] == "spectator" )
		return;
	
	if ( !isValidClass( self.pers["class"] ) )
	{
		if ( getDvarInt( "onlinegame" ) )
			self.pers["class"] = "CLASS_CUSTOM1";
		else
			self.pers["class"] = "CLASS_ASSAULT";

		self.class = self.pers["class"];
	}
	
	self closeMenus();
	self thread [[level.spawnClient]]();
}

kickIfDontSpawn()
{
	if ( self getEntityNumber() == 0 )
	{
		// don't try to kick the host
		return;
	}
	
	self kickIfIDontSpawnInternal();
	// clear any client dvars here,
	// like if we set anything to change the menu appearance to warn them of kickness
}

kickIfIDontSpawnInternal()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	self endon ( "spawned" );
	
	waittime = 90;
	if ( getdvar("scr_kick_time") != "" )
		waittime = getdvarfloat("scr_kick_time");
	mintime = 45;
	if ( getdvar("scr_kick_mintime") != "" )
		mintime = getdvarfloat("scr_kick_mintime");
	
	starttime = gettime();
	
	kickWait( waittime );
	
	timePassed = (gettime() - starttime)/1000;
	if ( timePassed < waittime - .1 && timePassed < mintime )
		return;
	
	if ( self.hasSpawned )
		return;
	
	if ( self.pers["team"] == "spectator" )
		return;
	
	kick( self getEntityNumber() );
}

kickWait( waittime )
{
	level endon("game_ended");
	wait waittime;
}

Callback_PlayerDisconnect()
{
	//Viking - Pick a new special player if needed
	self thread maps\mp\gametypes\ktk::ReselectImportantPlayer();

	if(isDefined(self.revivemark) && self.revivemark <= 15)
		Objective_Delete(self.revivemark);
	
	self removePlayerOnDisconnect();
	
	if ( !level.gameEnded )
		self logXPGains();
	
	if ( level.splitscreen )
	{
		players = level.players;
		
		if ( players.size <= 1 )
			level thread maps\mp\gametypes\_globallogic::forceEnd();
			
		// passing number of players to menus in splitscreen to display leave or end game option
		setdvar( "splitscreen_playerNum", players.size );
	}

	if ( isDefined( self.score ) && isDefined( self.pers["team"] ) )
	{
		setPlayerTeamRank( self, level.dropTeam, self.score - 5 * self.deaths );
		self logString( "team: score " + self.pers["team"] + ":" + self.score );
		level.dropTeam += 1;
	}
	
	[[level.onPlayerDisconnect]]();
	
	lpselfnum = self getEntityNumber();
	guid = self GetUniquePlayerID();
	
	if(!self isABot())
		logPrint("Q;" + guid + ";" + lpselfnum + ";" + self.name + "\n");
	
	for ( entry = 0; entry < level.players.size; entry++ )
	{
		if ( level.players[entry] == self )
		{
			while ( entry < level.players.size-1 )
			{
				level.players[entry] = level.players[entry+1];
				entry++;
			}
			level.players[entry] = undefined;
			break;
		}
	}
	
	if(isDefined(self.clientid))
	{
		for ( entry = 0; entry < level.players.size; entry++ )
		{
			if ( isDefined( level.players[entry].killedPlayers[""+self.clientid] ) )
				level.players[entry].killedPlayers[""+self.clientid] = undefined;

			if ( isDefined( level.players[entry].killedPlayersCurrent[""+self.clientid] ) )
				level.players[entry].killedPlayersCurrent[""+self.clientid] = undefined;

			if ( isDefined( level.players[entry].killedBy[""+self.clientid] ) )
				level.players[entry].killedBy[""+self.clientid] = undefined;
		}
	}

	if ( level.gameEnded )
		self removeDisconnectedPlayerFromPlacement();

	level thread updateTeamStatus();
}


removePlayerOnDisconnect()
{
	if(self isABot())
		self thread maps\mp\gametypes\_bots::onBotDisconnect();

	for ( entry = 0; entry < level.players.size; entry++ )
	{
		if ( level.players[entry] == self )
		{
			while ( entry < level.players.size-1 )
			{
				level.players[entry] = level.players[entry+1];
				entry++;
			}
			level.players[entry] = undefined;
			break;
		}
	}
}

isHeadShot( sWeapon, sHitLoc, sMeansOfDeath )
{
	return (sHitLoc == "head" || sHitLoc == "helmet") && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_IMPACT" && !isMG( sWeapon );
}


Callback_PlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime )
{
	// create a class specialty checks; CAC:bulletdamage, CAC:armorvest
	iDamage = maps\mp\gametypes\_class::cac_modified_damage( self, eAttacker, iDamage, sMeansOfDeath );
	self.iDFlags = iDFlags;
	self.iDFlagsTime = getTime();
	
	if ( game["state"] == "postgame" )
		return;
	
	if ( self.sessionteam == "spectator" )
		return;
	
	if ( isDefined( self.canDoCombat ) && !self.canDoCombat )
		return;
	
	if ( isDefined( eAttacker ) && isPlayer( eAttacker ) && isDefined( eAttacker.canDoCombat ) && !eAttacker.canDoCombat )
		return;
	
	// KILL THE KING
	//->
	//Change the strength for wallbangs
	if(iDFlags & level.iDFLAGS_PENETRATION)
	{
		iDamage = int(iDamage*getDvarFloat("scr_mod_wallbangmodifier"));
	
		if(iDamage <= 0)
			return;
	}
	
	if(isDefined(self.inUfoMode) && self.inUfoMode)
		return;
	
	if(isDefined(self.godmode) && self.godmode)
	{
		if(!isDefined(self.forcedBounce) || !self.forcedBounce)
			return;
	}
		
	usingRiotShield = false;
	if(level.gametype == "ktk" && isPlayer( eAttacker ))
	{		
		if(eAttacker == self && sWeapon == level.ktkWeapon["mortars"])
			return;
	
		if(eAttacker isAnAssassin() && (sWeapon == "frag_grenade_short_mp"))
		{
			if(game["customEvent"] != "kingvsking")
				return;
		}
	
		if(eAttacker != self)
			thread maps\mp\gametypes\_awards::HitAwards(eAttacker, self, sWeapon, sHitLoc, sMeansOfDeath);

		if(eAttacker == self && (isSubStr( sMeansOfDeath, "MOD_GRENADE" ) || isSubStr( sMeansOfDeath, "MOD_PROJECTILE" )))
			return;
			
		if(self isABot())
			self thread maps\mp\gametypes\_bots::botUnderAttack(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath);
		
		if(self getCurrentWeapon() == level.ktkWeapon["riotshield"])
			usingRiotShield = true;
		
		if(eAttacker != self && usingRiotShield)
		{
			if(self attackerIsDamagingRiotShield(eInflictor, eAttacker, vPoint, vDir))
				return;
		}
		
		//does not work correctly - cod4 does not link it with rotations
		/*if(sWeapon == level.ktkWeapon["crossbow"] || sWeapon == level.ktkWeapon["crossbowExp"])
		{
			if(!self hasAttached("projectile_bo_arrow_explosive"))
				self attach("projectile_bo_arrow_explosive", sHitLoc, true);
		}*/
	}
	
	//disable falldamage when the admin changed the dvarString
	if(getDvarInt("bg_fallDamageMaxHeight") >= 9999 && sMeansOfDeath == "MOD_FALLING")
		return;
	//<-
	
	prof_begin( "Callback_PlayerDamage flags/tweaks" );
	
	// Don't do knockback if the damage direction was not specified
	if( !isDefined( vDir ) )
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;
	
	friendly = false;

	if ( (level.teamBased && (self.health == self.maxhealth)) || !isDefined( self.attackers ) )
	{
		self.attackers = [];
		self.attackerData = [];
	}

	if ( isHeadShot( sWeapon, sHitLoc, sMeansOfDeath ) )
		sMeansOfDeath = "MOD_HEAD_SHOT";
	
	if(game["customEvent"] == "zombie")
	{
		if(self isAnAssassin())
		{
			//No Falldamage for Zombies
			if(sMeansOfDeath == "MOD_FALLING")
				return;
			
			//Ladderprotection for Zombies 
			if(self isOnLadder())
				return;
			
			//No damage for bullets
			if(sMeansOfDeath == "MOD_PISTOL_BULLET" || sMeansOfDeath == "MOD_RIFLE_BULLET")
				iDamage = 0;
			
			//Insta Kill for headshots, melee and breast shots with a bolt sniper
			if(sMeansOfDeath == "MOD_HEAD_SHOT" || sMeansOfDeath == "MOD_MELEE" || (isSubStr(sHitLoc, "torso") && isSniper(sWeapon)))
				iDamage = self.health;
		
			if(iDamage <= 0)
				return;
		}
	}
	
	if(game["customEvent"] == "hideandseek")
	{
		if(self isAGuard())
		{
			//No Falldamage for props
			if(sMeansOfDeath == "MOD_FALLING")
				return;
		}
	}
	
	// explosive barrel/car detection
	if ( sWeapon == "none" && isDefined( eInflictor ) )
	{
		if ( isDefined( eInflictor.targetname ) && eInflictor.targetname == "explodable_barrel" )
			sWeapon = "explodable_barrel";
		else if ( isDefined( eInflictor.destructible_type ) && isSubStr( eInflictor.destructible_type, "vehicle_" ) )
			sWeapon = "destructible_car";
	}

	prof_end( "Callback_PlayerDamage flags/tweaks" );

	// check for completely getting out of the damage
	if( !(iDFlags & level.iDFLAGS_NO_PROTECTION) )
	{
		// return if helicopter friendly fire is on
		if ( level.teamBased && isdefined( level.chopper ) && isdefined( eAttacker ) && eAttacker == level.chopper && eAttacker.team == self.pers["team"] )
		{
//			if( level.friendlyfire == 0 )
//			{
				prof_end( "Callback_PlayerDamage player" );
				return;
//			}
		}
		
		//KILL THE KING
		//->
		if((sWeapon == level.ktkWeapon["crossbowExp"] || sWeapon == "frag_grenade_short_mp") && sMeansOfDeath == "MOD_IMPACT") 
		{
			scr_iPrintLn("PLAYER_SEMTEX_STUCK", undefined, self.name);
		
			self.damageOwner = eAttacker;
			eInflictor.origin = (eInflictor.origin[0], eInflictor.origin[1], -100000); // Throw the original nade away so it wont cause a 2nd explosion 
			self thread playergoboom(sWeapon, eAttacker.pers["team"], sHitLoc, usingRiotShield); 
		}
		//<-
		
		if ( (isSubStr( sMeansOfDeath, "MOD_GRENADE" ) || isSubStr( sMeansOfDeath, "MOD_EXPLOSIVE" ) || isSubStr( sMeansOfDeath, "MOD_PROJECTILE" )) && isDefined( eInflictor ) )
		{
			// protect players from spawnkill grenades
			if ( eInflictor.classname == "grenade" && (self.lastSpawnTime + 3500) > getTime() && distance( eInflictor.origin, self.lastSpawnPoint.origin ) < 250 )
			{
				prof_end( "Callback_PlayerDamage player" );
				return;
			}
			
			self.explosiveInfo = [];
			self.explosiveInfo["damageTime"] = getTime();
			self.explosiveInfo["damageId"] = eInflictor getEntityNumber();
			self.explosiveInfo["returnToSender"] = false;
			self.explosiveInfo["counterKill"] = false;
			self.explosiveInfo["chainKill"] = false;
			self.explosiveInfo["cookedKill"] = false;
			self.explosiveInfo["throwbackKill"] = false;
			self.explosiveInfo["weapon"] = sWeapon;
			
			isFrag = isSubStr( sWeapon, "frag_" );

			if ( eAttacker != self )
			{
				if ( (isSubStr( sWeapon, "c4_" ) || isSubStr( sWeapon, "claymore_" )) && isDefined( eAttacker ) && isDefined( eInflictor.owner ) )
				{
					self.explosiveInfo["returnToSender"] = (eInflictor.owner == self);
					self.explosiveInfo["counterKill"] = isDefined( eInflictor.wasDamaged );
					self.explosiveInfo["chainKill"] = isDefined( eInflictor.wasChained );
					self.explosiveInfo["bulletPenetrationKill"] = isDefined( eInflictor.wasDamagedFromBulletPenetration );
					self.explosiveInfo["cookedKill"] = false;
				}
				if ( isDefined( eAttacker.lastGrenadeSuicideTime ) && eAttacker.lastGrenadeSuicideTime >= gettime() - 50 && isFrag )
				{
					self.explosiveInfo["suicideGrenadeKill"] = true;
				}
				else
				{
					self.explosiveInfo["suicideGrenadeKill"] = false;
				}
			}
			
			if ( isFrag )
			{
				self.explosiveInfo["cookedKill"] = isDefined( eInflictor.isCooked );
				self.explosiveInfo["throwbackKill"] = isDefined( eInflictor.threwBack );
			}
		}

		if ( isPlayer( eAttacker ) )
			eAttacker.pers["participation"]++;
		
		prevHealthRatio = self.health / self.maxhealth;
		
		if ( level.teamBased && isPlayer( eAttacker ) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]) )
		{
			prof_begin( "Callback_PlayerDamage player" ); // profs automatically end when the function returns
			if ( level.friendlyfire == 0 ) // no one takes damage
			{
				if ( sWeapon == "artillery_mp" )
					self damageShellshockAndRumble( eInflictor, sWeapon, sMeansOfDeath, iDamage );
				return;
			}
			else if ( level.friendlyfire == 1 ) // the friendly takes damage
			{
				// Make sure at least one point of damage is done
				if ( iDamage < 1 )
					iDamage = 1;
				
				self.lastDamageWasFromEnemy = false;
				
				self finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
			}
			else if ( level.friendlyfire == 2 && isAlive( eAttacker ) ) // only the attacker takes damage
			{
				iDamage = int(iDamage * .5);

				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;
				
				eAttacker.lastDamageWasFromEnemy = false;
				
				eAttacker.friendlydamage = true;
				eAttacker finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
				eAttacker.friendlydamage = undefined;
			}
			else if ( level.friendlyfire == 3 && isAlive( eAttacker ) ) // both friendly and attacker take damage
			{
				iDamage = int(iDamage * .5);

				// Make sure at least one point of damage is done
				if ( iDamage < 1 )
					iDamage = 1;
				
				self.lastDamageWasFromEnemy = false;
				eAttacker.lastDamageWasFromEnemy = false;
				
				self finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
				if ( isAlive( eAttacker ) ) // may have died due to friendly fire punishment
				{
					eAttacker.friendlydamage = true;
					eAttacker finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
					eAttacker.friendlydamage = undefined;
				}
			}
			
			friendly = true;
		}
		else
		{
			prof_begin( "Callback_PlayerDamage world" );
			// Make sure at least one point of damage is done
			if(iDamage < 1)
				iDamage = 1;

			if ( level.teamBased && isDefined( eAttacker ) && isPlayer( eAttacker ) )
			{
				if ( !isdefined( self.attackerData[eAttacker.clientid] ) )
				{
					self.attackers[ self.attackers.size ] = eAttacker;
					// we keep an array of attackers by their client ID so we can easily tell
					// if they're already one of the existing attackers in the above if().
					// we store in this array data that is useful for other things, like challenges
					self.attackerData[eAttacker.clientid] = false;
				}
				if ( maps\mp\gametypes\_weapons::isPrimaryWeapon( sWeapon ) )
					self.attackerData[eAttacker.clientid] = true;
			}
			
			if ( isdefined( eAttacker ) )
				level.lastLegitimateAttacker = eAttacker;

			if ( isdefined( eAttacker ) && isPlayer( eAttacker ) && isDefined( sWeapon ) )
				eAttacker maps\mp\gametypes\_weapons::checkHit( sWeapon );

			/*			
			if ( isPlayer( eInflictor ) )
				eInflictor maps\mp\gametypes\_persistence::statAdd( "hits", 1 );
			*/

			if ( issubstr( sMeansOfDeath, "MOD_GRENADE" ) && isDefined( eInflictor.isCooked ) )
				self.wasCooked = getTime();
			else
				self.wasCooked = undefined;
			
			self.lastDamageWasFromEnemy = (isDefined( eAttacker ) && (eAttacker != self));
			
			self finishPlayerDamageWrapper(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);

			self thread maps\mp\gametypes\_missions::playerDamaged(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc );

			prof_end( "Callback_PlayerDamage world" );
		}

		if ( isdefined(eAttacker) && eAttacker != self )
		{
			hasBodyArmor = false;
			if ( self hasPerk( "specialty_armorvest" ) )
			{
				hasBodyArmor = true;
				/*
				damageScalar = level.cac_armorvest_data / 100;
				if ( prevHealthRatio > damageScalar )
					hasBodyArmor = true;
				*/
			}
			if ( iDamage > 0 )
				eAttacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback( hasBodyArmor );
		}
		
		self.hasDoneCombat = true;
	}

	if ( isdefined( eAttacker ) && eAttacker != self && !friendly )
		level.useStartSpawns = false;

	prof_begin( "Callback_PlayerDamage log" );

	// Do debug print if it's enabled
	if(getDvarInt("g_debugDamage"))
		println("client:" + self getEntityNumber() + " health:" + self.health + " attacker:" + eAttacker.clientid + " inflictor is player:" + isPlayer(eInflictor) + " damage:" + iDamage + " hitLoc:" + sHitLoc);

	if(self.sessionstate != "dead")
	{
		lpselfnum = self getEntityNumber();
		lpselfname = self.name;
		lpselfteam = self.pers["team"];
		lpselfGuid = self.guid; //self GetUniquePlayerID();
		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackGuid = eAttacker.guid; //eAttacker GetUniquePlayerID();
			lpattackname = eAttacker.name;
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackGuid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		if(!self isABot())
			logPrint("D;" + lpselfGuid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
	}
	
	if ( getdvarint("scr_hitloc_debug") )
	{
		if ( !isdefined( eAttacker.hitlocInited ) )
		{
			for ( i = 0; i < 6; i++ )
			{
				eAttacker setClientDvar( "ui_hitloc_" + i, "" );
			}
			eAttacker.hitlocInited = true;
		}
		
		if ( isPlayer( eAttacker ) && !level.splitscreen )
		{
			colors = [];
			colors[0] = 2;
			colors[1] = 3;
			colors[2] = 5;
			colors[3] = 7;
			
			elemcount = 6;
			if ( !isdefined( eAttacker.damageInfo ) )
			{
				eAttacker.damageInfo = [];
				for ( i = 0; i < elemcount; i++ )
				{
					eAttacker.damageInfo[i] = spawnstruct();
					eAttacker.damageInfo[i].damage = 0;
					eAttacker.damageInfo[i].hitloc = "";
					eAttacker.damageInfo[i].bp = false;
					eAttacker.damageInfo[i].jugg = false;
					eAttacker.damageInfo[i].colorIndex = 0;
				}
				eAttacker.damageInfoColorIndex = 0;
				eAttacker.damageInfoVictim = undefined;
			}
			
			for ( i = elemcount-1; i > 0; i-- )
			{
				eAttacker.damageInfo[i].damage = eAttacker.damageInfo[i - 1].damage;
				eAttacker.damageInfo[i].hitloc = eAttacker.damageInfo[i - 1].hitloc;
				eAttacker.damageInfo[i].bp = eAttacker.damageInfo[i - 1].bp;
				eAttacker.damageInfo[i].jugg = eAttacker.damageInfo[i - 1].jugg;
				eAttacker.damageInfo[i].colorIndex = eAttacker.damageInfo[i - 1].colorIndex;
			}
			eAttacker.damageInfo[0].damage = iDamage;
			eAttacker.damageInfo[0].hitloc = sHitLoc;
			eAttacker.damageInfo[0].bp = (iDFlags & level.iDFLAGS_PENETRATION);
			eAttacker.damageInfo[0].jugg = self hasPerk( "specialty_armorvest" );
			if ( isdefined( eAttacker.damageInfoVictim ) && eAttacker.damageInfoVictim != self )
			{ 
				eAttacker.damageInfoColorIndex++;
				if ( eAttacker.damageInfoColorIndex == colors.size )
					eAttacker.damageInfoColorIndex = 0;
			}
			eAttacker.damageInfoVictim = self;
			eAttacker.damageInfo[0].colorIndex = eAttacker.damageInfoColorIndex;
			
			for ( i = 0; i < elemcount; i++ )
			{
				color = "^" + colors[ eAttacker.damageInfo[i].colorIndex ];
				if ( eAttacker.damageInfo[i].hitloc != "" )
				{
					val = color + eAttacker.damageInfo[i].hitloc;
					if ( eAttacker.damageInfo[i].bp )
						val += " (BP)";
					if ( eAttacker.damageInfo[i].jugg  )
						val += " (Jugg)";
					eAttacker setClientDvar( "ui_hitloc_" + i, val );
				}
				eAttacker setClientDvar( "ui_hitloc_damage_" + i, color + eAttacker.damageInfo[i].damage );
			}
		}
	}

	//KILL THE KING
	//->
	if(getDvarInt("scr_mod_blood") == 1 )
		self thread maps\mp\gametypes\_blood::blood_splat( eInflictor, eAttacker, sMeansOfDeath, sHitLoc, sWeapon, vDir );
		
	if(getDvarInt("scr_mod_painsound") == 1)
	{
		painSound = true;
	
		if(self isDog() || self isTerminator())
			painSound = false;
	
		if(isDefined(self.voice) && painSound)
			self PlaySound("generic_pain_" + self.voice + "_" + (randomint(8)+1));
	}

	if(sWeapon == level.ktkWeapon["throwingKnife"] && (sMeansOfDeath == "MOD_IMPACT" || sMeansOfDeath == "MOD_GRENADE"))
	{
		//iPrintLn("^1" + self.name + " ^1was hit by a throwing knife!");

		if(isDefined(eInflictor))
		{
			// Throw the original knife away so it wont cause damage twice (rare bug) 
			eInflictor.origin = (eInflictor.origin[0], eInflictor.origin[1], -100000);
			eInflictor detonate();
		}
	}
	
	//update the healthbar
	if(self isTerminator())
		level maps\mp\gametypes\_huds::UpdateHealthbarPlayerNotify("update_healthbar", "terminator");
	else if(self isKing() && game["customEvent"] != "reversektk")
		level maps\mp\gametypes\_huds::UpdateHealthbarPlayerNotify("update_healthbar", "king");
	else if(self isMainAssassin() && game["customEvent"] == "reversektk")
		level maps\mp\gametypes\_huds::UpdateHealthbarPlayerNotify("update_healthbar", "assassin");
	//<-
	
	prof_end( "Callback_PlayerDamage log" );
}

finishPlayerDamageWrapper( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime )
{
	if(!isDefined(level.dogdamage)) level.dogdamage = 100;
	if(!isDefined(level.knifedamage)) level.knifedamage = 100;
	if(!isDefined(level.katanadamage)) level.katanadamage = 200;

	if(isAlive(self))
	{
		if(!isDefined(eAttacker) || eAttacker == self)
			self finishPlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
		else
		{
			if((eAttacker isDog() || (game["customEvent"] == "dogfight" && isPlayer(eAttacker) && eAttacker isAnAssassin())) && sMeansOfDeath == "MOD_MELEE")
				self FinishPlayerDamage( eAttacker, eAttacker, level.dogdamage, 0, "MOD_PROJECTILE", "defaultweapon_mp", eAttacker.origin, VectorToAngles(self.origin - eAttacker.origin), "none", 0 );
			else if(sWeapon == level.ktkWeapon["throwingKnife"])
				self FinishPlayerDamage( eAttacker, eAttacker, level.knifedamage, 0, "MOD_GRENADE", level.ktkWeapon["throwingKnife"], eAttacker.origin, VectorToAngles(self.origin - eAttacker.origin), "none", 0 );
			else if(sMeansOfDeath == "MOD_MELEE" && sWeapon == level.ktkWeapon["katana"])
				self FinishPlayerDamage( eAttacker, eAttacker, level.katanadamage, 0, "MOD_PROJECTILE", level.ktkWeapon["katana"], eAttacker.origin, VectorToAngles(self.origin - eAttacker.origin), "none", 0 );
			else if(self.pers["vip"] && (sMeansOfDeath == "MOD_MELEE" || sWeapon == level.ktkWeapon["knife"]))
			{
				if(!self isKing() && !self isTerminator())
					self FinishPlayerDamage( eAttacker, eAttacker, self.health, 0, "MOD_MELEE", level.ktkWeapon["knife"], eAttacker.origin, VectorToAngles(self.origin - eAttacker.origin), "none", 0 );
				else
					self FinishPlayerDamage( eAttacker, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
			}
			else if(sWeapon == "ac130_25mm_mp")
			{
				if(isDefined(level.ac130Player) && eAttacker == level.ac130Player)
					self FinishPlayerDamage( eAttacker, eAttacker, 500, 0, "MOD_RIFLE_BULLET", sWeapon, eAttacker.origin, VectorToAngles(self.origin - eAttacker.origin), "none", 0 );
				else if(eAttacker isInMannedHelicopterTurret())
					self FinishPlayerDamage( eAttacker, eAttacker, 500, 0, "MOD_RIFLE_BULLET", "cobra_20mm_mp", eAttacker.origin, VectorToAngles(self.origin - eAttacker.origin), "none", 0 );
			}
			else
			{
				self finishPlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
			}
		}
		
		if(isDefined(eAttacker) && sMeansOfDeath == "MOD_MELEE")
			eAttacker notify("stop_knifeassist");

		self damageShellshockAndRumble( eInflictor, sWeapon, sMeansOfDeath, iDamage );
	}
}

damageShellshockAndRumble( eInflictor, sWeapon, sMeansOfDeath, iDamage )
{
	self thread maps\mp\gametypes\_weapons::onWeaponDamage( eInflictor, sWeapon, sMeansOfDeath, iDamage );
	self PlayRumbleOnEntity( "damage_heavy" );
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
	self endon( "spawned" );
	self notify( "killed_player" );
	
	if ( self.sessionteam == "spectator" )
		return;
	
	if ( game["state"] == "postgame" )
		return;
	
	prof_begin( "PlayerKilled pre constants" );
	
	deathTimeOffset = 0;
	if ( isdefined( self.useLastStandParams ) )
	{
		self.useLastStandParams = undefined;
		
		assert( isdefined( self.lastStandParams ) );
		
		eInflictor = self.lastStandParams.eInflictor;
		attacker = self.lastStandParams.attacker;
		iDamage = self.lastStandParams.iDamage;
		sMeansOfDeath = self.lastStandParams.sMeansOfDeath;
		sWeapon = self.lastStandParams.sWeapon;
		vDir = self.lastStandParams.vDir;
		sHitLoc = self.lastStandParams.sHitLoc;
		
		deathTimeOffset = (gettime() - self.lastStandParams.lastStandStartTime) / 1000;
		
		self.lastStandParams = undefined;
	}

	if( isHeadShot( sWeapon, sHitLoc, sMeansOfDeath ) )
		sMeansOfDeath = "MOD_HEAD_SHOT";
	
	if( attacker.classname == "script_vehicle" && isDefined( attacker.owner ) )
		attacker = attacker.owner;
		
	// send out an obituary message to all clients about the kill
	if( level.teamBased && isDefined( attacker.pers ) && self.team == attacker.team && sMeansOfDeath == "MOD_GRENADE" && level.friendlyfire == 0 )
		obituary(self, self, sWeapon, sMeansOfDeath);
	else
		obituary(self, attacker, sWeapon, sMeansOfDeath);

//	self maps\mp\gametypes\_weapons::updateWeaponUsageStats();

	// KILL THE KING
	//->
	riotDeathModel = undefined;
	if(self getCurrentWeapon() == level.ktkWeapon["riotshield"])
	{
		if(self hasAttached("worldmodel_riot_shield_iw5"))
		{
			self detach("worldmodel_riot_shield_iw5", "tag_weapon_left");
	
			riotDeathModel = spawn("script_model", self getTagOrigin("tag_weapon_left"));
			riotDeathModel.angles = self getTagAngles("tag_weapon_left");
			riotDeathModel setModel("worldmodel_riot_shield_iw5");
			riotDeathModel PhysicsLaunch();
		}
	}

	if(level.gametype != "ktk")
	{
		if ( !level.inGracePeriod )
		{
			self maps\mp\gametypes\_weapons::dropWeaponForDeath( attacker );
			self maps\mp\gametypes\_weapons::dropOffhand();
		}
	}
	//<-

	maps\mp\gametypes\_spawnlogic::deathOccured(self, attacker);

	self.sessionstate = "dead";
	self.statusicon = "hud_status_dead";

	self.pers["weapon"] = undefined;
	
	self.killedPlayersCurrent = [];
	
	self.deathCount++;

	if( !isDefined( self.switching_teams ) )
	{
		// if team killed we reset kill streak, but dont count death and death streak
		if ( isPlayer( attacker ) && level.teamBased && ( attacker != self ) && ( self.pers["team"] == attacker.pers["team"] ) )
		{
			self.cur_kill_streak = 0;
		}
		else
		{		
			self incPersStat( "deaths", 1 );
			self.deaths = self getPersStat( "deaths" );
			self updatePersRatio( "kdratio", "kills", "deaths" );
			
			//Kill the king
			if(isDefined(attacker) && !attacker isABot())
				self.pers["totaldeaths"]++;
			
			self.cur_kill_streak = 0;
			self.cur_death_streak++;
			
			if ( self.cur_death_streak > self.death_streak )
			{
				self maps\mp\gametypes\_persistence::statSet( "death_streak", self.cur_death_streak );
				self.death_streak = self.cur_death_streak;
			}
		}
	}
	
	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpattackGuid = "";
	lpattackname = "";
	lpselfteam = "";
	lpselfguid = self.guid; //self GetUniquePlayerID();
	lpattackerteam = "";

	lpattacknum = -1;

	prof_end( "PlayerKilled pre constants" );

	if( isPlayer( attacker ) )
	{
		lpattackGuid = attacker.guid; //attacker GetUniquePlayerID();
		lpattackname = attacker.name;

		if ( attacker == self ) // killed himself
		{
			doKillcam = false;
			
			// suicide kill cam
			//lpattacknum = attacker getEntityNumber();
			//doKillcam = true;

			// switching teams
			if ( isDefined( self.switching_teams ) )
			{
				if ( !level.teamBased && ((self.leaving_team == "allies" && self.joining_team == "axis") || (self.leaving_team == "axis" && self.joining_team == "allies")) )
				{
					playerCounts = self maps\mp\gametypes\_teams::CountPlayers();
					playerCounts[self.leaving_team]--;
					playerCounts[self.joining_team]++;
				
					if( (playerCounts[self.joining_team] - playerCounts[self.leaving_team]) > 1 )
					{
						self thread [[level.onXPEvent]]( "suicide" );
						self incPersStat( "suicides", 1 );
						self.suicides = self getPersStat( "suicides" );
					}
				}
			}
			else
			{
				self thread [[level.onXPEvent]]( "suicide" );
				self incPersStat( "suicides", 1 );
				self.suicides = self getPersStat( "suicides" );

				if ( sMeansOfDeath == "MOD_SUICIDE" && sHitLoc == "none" && self.throwingGrenade )
				{
					self.lastGrenadeSuicideTime = gettime();
				}
			}
			
			if( isDefined( self.friendlydamage ) )
				self iPrintLn(&"MP_FRIENDLY_FIRE_WILL_NOT");
		}
		else
		{
			prof_begin( "PlayerKilled attacker" );

			lpattacknum = attacker getEntityNumber();

			doKillcam = true;

			if ( level.teamBased && self.pers["team"] == attacker.pers["team"] && sMeansOfDeath == "MOD_GRENADE" && level.friendlyfire == 0 )
			{		
			}
			else if ( level.teamBased && self.pers["team"] == attacker.pers["team"] ) // killed by a friendly
			{
				attacker thread [[level.onXPEvent]]( "teamkill" );

				attacker.pers["teamkills"] += 1.0;
				
				attacker.teamkillsThisRound++;

				if ( maps\mp\gametypes\_tweakables::getTweakableValue( "team", "teamkillpointloss" ) )
				{
					scoreSub = maps\mp\gametypes\_rank::getScoreInfoValue( "kill" );
					_setPlayerScore( attacker, _getPlayerScore( attacker ) - scoreSub );
				}
				
				if ( getTimePassed() < 5000 )
					teamKillDelay = 1;
				else if ( attacker.pers["teamkills"] > 1 && getTimePassed() < (8000 + (attacker.pers["teamkills"] * 1000)) )
					teamKillDelay = 1;
				else
					teamKillDelay = attacker TeamKillDelay();
					
				if ( teamKillDelay > 0 )
				{
					attacker.teamKillPunish = true;
					attacker suicide();
					attacker thread reduceTeamKillsOverTime();
				}
			}
			else
			{
				prof_begin( "pks1" );

				if ( sMeansOfDeath == "MOD_HEAD_SHOT" )
				{
					attacker incPersStat( "headshots", 1 );
					attacker.headshots = attacker getPersStat( "headshots" );

					if ( isDefined( attacker.lastStand ) )
						value = maps\mp\gametypes\_rank::getScoreInfoValue( "headshot" ) * 2;
					else
						value = undefined;

					attacker thread maps\mp\gametypes\_rank::giveRankXP( "headshot", value );
					attacker playLocalSound( "bullet_impact_headshot_2" );
				}
				else
				{
					if ( isDefined( attacker.lastStand ) )
						value = maps\mp\gametypes\_rank::getScoreInfoValue( "kill" ) * 2;
					else
						value = undefined;

					attacker thread maps\mp\gametypes\_rank::giveRankXP( "kill", value );
				}

				attacker incPersStat( "kills", 1 );
				attacker.kills = attacker getPersStat( "kills" );
				attacker updatePersRatio( "kdratio", "kills", "deaths" );

				if ( isAlive( attacker ) )
				{
					if ( !isDefined( eInflictor ) || !isDefined( eInflictor.requiredDeathCount ) || attacker.deathCount == eInflictor.requiredDeathCount )
					{					
						//KILL THE KING
						if(getDvarInt("scr_hardpoint_system") == 1 || 
						  (getDvarInt("scr_hardpoint_system") == 0 && 
						   sWeapon != level.ktkWeapon["ac130"] &&
						   sWeapon != level.ktkWeapon["mortars"] && 
						   sWeapon != "helicopter_mp" &&
						   sWeapon != "airstrike_mp" && 
						   sWeapon != "cobra_20mm_mp" && 
						   sWeapon != "ac130_25mm_mp" && 
						   sWeapon != "ac130_40mm_mp" && 
						   sWeapon != "ac130_105mm_mp" &&
						   /*!attacker isInRCToy() &&*/
						   !attacker isInPredator() &&
						   !attacker isInAC130() &&
						   !attacker isInMannedHelicopter() &&
						   !attacker isInMannedHelicopterTurret())
						)
						{
							attacker.cur_kill_streak++;
							attacker setKtkStat(2841, attacker.cur_kill_streak);
						}
					}
				}
				
				//if ( isDefined( level.hardpointItems ) && isAlive( attacker ) )
					//attacker thread maps\mp\gametypes\_hardpoints::giveHardpointItemForStreak();

				
				attacker.cur_death_streak = 0;
				
				if ( attacker.cur_kill_streak > attacker.kill_streak )
				{
					attacker maps\mp\gametypes\_persistence::statSet( "kill_streak", attacker.cur_kill_streak );
					attacker.kill_streak = attacker.cur_kill_streak;
				}
				
				givePlayerScore( "kill", attacker, self );

				name = ""+self.clientid;
				if ( !isDefined( attacker.killedPlayers[name] ) )
					attacker.killedPlayers[name] = 0;

				if ( !isDefined( attacker.killedPlayersCurrent[name] ) )
					attacker.killedPlayersCurrent[name] = 0;
					
				attacker.killedPlayers[name]++;
				attacker.killedPlayersCurrent[name]++;
				
				attackerName = ""+attacker.clientid;
				if ( !isDefined( self.killedBy[attackerName] ) )
					self.killedBy[attackerName] = 0;
					
				self.killedBy[attackerName]++;

				// helicopter score for team
				if( level.teamBased && isdefined( level.chopper ) && isdefined( Attacker ) && Attacker == level.chopper )
					giveTeamScore( "kill", attacker.team,  attacker, self );
				
				// to prevent spectator gain score for team-spectator after throwing a granade and killing someone before he switched
				if ( level.teamBased && attacker.pers["team"] != "spectator")
					giveTeamScore( "kill", attacker.pers["team"],  attacker, self );

				level thread maps\mp\gametypes\_battlechatter_mp::sayLocalSoundDelayed( attacker, "kill", 0.75 );

				prof_end( "pks1" );
				
				if ( level.teamBased )
				{
					prof_begin( "PlayerKilled assists" );
					
					if ( isdefined( self.attackers ) )
					{
						for ( j = 0; j < self.attackers.size; j++ )
						{
							player = self.attackers[j];
							
							if ( !isDefined( player ) )
								continue;
							
							if ( player == attacker )
								continue;
							
							player thread processAssist( self );
						}
						self.attackers = [];
					}
					
					prof_end( "PlayerKilled assists" );
				}
			}
			
			prof_end( "PlayerKilled attacker" );
		}
	}
	else
	{
		doKillcam = false;
		killedByEnemy = false;

		lpattacknum = -1;
		lpattackguid = "";
		lpattackname = "";
		lpattackerteam = "world";

		// even if the attacker isn't a player, it might be on a team
		if ( isDefined( attacker ) && isDefined( attacker.team ) && (attacker.team == "axis" || attacker.team == "allies") )
		{
			if ( attacker.team != self.pers["team"] ) 
			{
				killedByEnemy = true;
				if ( level.teamBased )
					giveTeamScore( "kill", attacker.team, attacker, self );
			}
		}
	}			

	//KILL THE KING
	if(level.gametype == "ktk")
		attacker thread maps\mp\gametypes\_killevents::killEvents(self, sWeapon, sHitLoc, sMeansOfDeath, deathTimeOffset, psOffsetTime, iDamage, eInflictor);
	
	prof_begin( "PlayerKilled post constants" );

	if ( isDefined( attacker ) && isPlayer( attacker ) && attacker != self && (!level.teambased || attacker.pers["team"] != self.pers["team"]) )
		self thread maps\mp\gametypes\_missions::playerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc );
	else
		self notify("playerKilledChallengesProcessed");
	
	if(isPlayer(attacker) && !attacker isABot())
		logPrint( "K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n" );
	
	attackerString = "none";
	if ( isPlayer( attacker ) ) // attacker can be the worldspawn if it's not a player
		attackerString = attacker getXuid() + "(" + lpattackname + ")";
	self logstring( "d " + sMeansOfDeath + "(" + sWeapon + ") a:" + attackerString + " d:" + iDamage + " l:" + sHitLoc + " @ " + int( self.origin[0] ) + " " + int( self.origin[1] ) + " " + int( self.origin[2] ) );

	level thread updateTeamStatus();

	self maps\mp\gametypes\_gameobjects::detachUseModels(); // want them detached before we create our corpse
	
	//KILL THE KING - Killed by a nuke
	if(isDefined(self.NukeKilled) && self.NukeKilled)
	{
		self detachAll();
		self setModel("body_complete_mp_skeleton");
	}
	
	body = self clonePlayer( deathAnimDuration );
	if ( self isOnLadder() || self isMantling() )
		body startRagDoll();
	
	thread delayStartRagdoll( body, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath );

	self.body = body;
	if ( !isDefined( self.switching_teams ) && (!isDefined(self.NukeKilled) || !self.NukeKilled))
		thread maps\mp\gametypes\_deathicons::addDeathicon( body, self, self.pers["team"], 5.0 );

	//KILL THE KING
	//->
	if(getDvarInt("scr_mod_blood") == 1)
	{
		if(!isDefined(self.NukeKilled) || !self.NukeKilled)
			self.body thread maps\mp\gametypes\_blood::blood_pool(self, sWeapon, sMeansOfDeath);
	}

	if(isDefined(riotDeathModel))
		riotDeathModel thread removeWithCorpse(body);
	
	if(sWeapon == level.ktkWeapon["disruptor"])
		body hide();
	
	self.NukeKilled = false;
	//<-
	
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;

	self thread [[level.onPlayerKilled]](eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration);

	//KILL THE KING
	//->
	killcamentity = -1;
	doKillcam = true;
	
	if(sWeapon == "none" || sWeapon == "artillery_mp")
		doKillcam = false;
	
	if((sWeapon == level.ktkWeapon["sentrygun"] || sWeapon == level.ktkWeapon["mortars"] || sWeapon == "marker_mp" || isSubStr(sWeapon, "cobra")) && isdefined(eInflictor))
		killcamentity = eInflictor getEntityNumber();
	//<-

	self.deathTime = getTime();
	perks = getPerks( attacker );
	
	// let the player watch themselves die
	wait ( 0.25 );
	self.cancelKillcam = false;
	self thread cancelKillCamOnUse();
	postDeathDelay = waitForTimeOrNotifies( 1.75 );
	self notify ( "death_delay_finished" );
	
	if ( game["state"] != "playing" )
		return;
	
	respawnTimerStartTime = gettime();
	
	/#
	if ( getDvarInt( "scr_forcekillcam" ) != 0 )
	{
		doKillcam = true;
		if ( lpattacknum < 0 )
			lpattacknum = self getEntityNumber();
	}
	#/
	
	if ( !self.cancelKillcam && doKillcam && level.killcam )
	{
		livesLeft = !(level.numLives && !self.pers["lives"]);
		timeUntilSpawn = TimeUntilSpawn( true );
		willRespawnImmediately = livesLeft && (timeUntilSpawn <= 0);
		
		self maps\mp\gametypes\_killcam::killcam( lpattacknum, killcamentity, sWeapon, postDeathDelay + deathTimeOffset, psOffsetTime, willRespawnImmediately, timeUntilRoundEnd(), perks, attacker );
	}

	prof_end( "PlayerKilled post constants" );
	
	if ( game["state"] != "playing" )
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		return;
	}
	
	// class may be undefined if we have changed teams
	if ( isValidClass( self.class ) )
	{
		timePassed = (gettime() - respawnTimerStartTime) / 1000;
		self thread [[level.spawnClient]]( timePassed );
	}
}

cancelKillCamOnUse()
{
	self endon ( "death_delay_finished" );
	self endon ( "disconnect" );
	level endon ( "game_ended" );
	
	for ( ;; )
	{
		if ( !self UseButtonPressed() )
		{
			wait ( 0.05 );
			continue;
		}
		
		buttonTime = 0;
		while( self UseButtonPressed() )
		{
			buttonTime += 0.05;
			wait ( 0.05 );
		}
		
		if ( buttonTime >= 0.5 )
			continue;
		
		buttonTime = 0;
		
		while ( !self UseButtonPressed() && buttonTime < 0.5 )
		{
			buttonTime += 0.05;
			wait ( 0.05 );
		}
		
		if ( buttonTime >= 0.5 )
			continue;
			
		self.cancelKillcam = true;
		return;
	}	
}


waitForTimeOrNotifies( desiredDelay )
{
	startedWaiting = getTime();
	
//	while( self.doingNotify )
//		wait ( 0.05 );

	waitedTime = (getTime() - startedWaiting)/1000;
	
	if ( waitedTime < desiredDelay )
	{
		wait desiredDelay - waitedTime;
		return desiredDelay;
	}
	else
	{
		return waitedTime;
	}
}

reduceTeamKillsOverTime()
{
	timePerOneTeamkillReduction = 20.0;
	reductionPerSecond = 1.0 / timePerOneTeamkillReduction;
	
	while(1)
	{
		if ( isAlive( self ) )
		{
			self.pers["teamkills"] -= reductionPerSecond;
			if ( self.pers["teamkills"] < level.minimumAllowedTeamKills )
			{
				self.pers["teamkills"] = level.minimumAllowedTeamKills;
				break;
			}
		}
		wait 1;
	}
}

getPerks( player )
{
	perks[0] = "specialty_null";
	perks[1] = "specialty_null";
	perks[2] = "specialty_null";
	
	/* KILL THE KING
	if ( isPlayer( player ) && !level.oldschool )
	{
		// if public game, if is not bot, if class selection is custom, if is currently using a custom class instead of pending class change
		if ( level.onlineGame && !isdefined( player.pers["isBot"] ) && isSubstr( player.curClass, "CLASS_CUSTOM" ) && isdefined(player.custom_class) )
		{
			//assertex( isdefined(player.custom_class), "Player: " + player.name + "'s Custom Class: " + player.pers["class"] + " is corrupted." );
			
			class_num = player.class_num;
			if ( isDefined( player.custom_class[class_num]["specialty1"] ) )
				perks[0] = player.custom_class[class_num]["specialty1"];
			if ( isDefined( player.custom_class[class_num]["specialty2"] ) )
				perks[1] = player.custom_class[class_num]["specialty2"];
			if ( isDefined( player.custom_class[class_num]["specialty3"] ) )
				perks[2] = player.custom_class[class_num]["specialty3"];
		}
		else
		{
			if ( isDefined( level.default_perk[player.curClass][0] ) )
				perks[0] = level.default_perk[player.curClass][0];
			if ( isDefined( level.default_perk[player.curClass][1] ) )
				perks[1] = level.default_perk[player.curClass][1];
			if ( isDefined( level.default_perk[player.curClass][2] ) )
				perks[2] = level.default_perk[player.curClass][2];
		}
	}*/
	
	return perks;
}

processAssist( killedplayer )
{
	self endon("disconnect");
	killedplayer endon("disconnect");
	
	wait .05; // don't ever run on the same frame as the playerkilled callback.
	WaitTillSlowProcessAllowed();
	
	if ( self.pers["team"] != "axis" && self.pers["team"] != "allies" )
		return;
	
	if ( self.pers["team"] == killedplayer.pers["team"] )
		return;
	
	self thread [[level.onXPEvent]]( "assist" );
	self incPersStat( "assists", 1 );
	self.assists = self getPersStat( "assists" );
	
	givePlayerScore( "assist", self, killedplayer );
	
	self thread maps\mp\gametypes\_missions::playerAssist();
}

Callback_PlayerLastStand( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration )
{
	self.health = 1;
	self.lastStand = true;
	
	//KILL THE KING
	self.godmode = false;
	
	self.lastStandParams = spawnstruct();
	self.lastStandParams.eInflictor = eInflictor;
	self.lastStandParams.attacker = attacker;
	self.lastStandParams.iDamage = iDamage;
	self.lastStandParams.sMeansOfDeath = sMeansOfDeath;
	self.lastStandParams.sWeapon = sWeapon;
	self.lastStandParams.vDir = vDir;
	self.lastStandParams.sHitLoc = sHitLoc;
	self.lastStandParams.lastStandStartTime = gettime();
		
	mayDoLastStand = mayDoLastStand( sWeapon, sMeansOfDeath, sHitLoc );
	/#
	if ( getdvar("scr_forcelaststand" ) == "1" )
		mayDoLastStand = true;
	#/
	
	if(self getCurrentWeapon() == level.ktkWeapon["riotshield"])
		mayDoLastStand = false;
	
	if ( !mayDoLastStand )
	{
		self.useLastStandParams = true;
		self ensureLastStandParamsValidity();
		self suicide();
		return;
	}
		
	self thread maps\mp\gametypes\_gameobjects::onPlayerLastStand();

	//KILL THE KING
	//->
	bleedOutDelay = 10;
	
	if(self getKtkStat(2362))
		bleedOutDelay = 15;	
	
	if(getDvarInt("scr_mod_revive") == 1)
		self thread maps\mp\gametypes\_revive::init(attacker, bleedOutDelay);

	if(level.gametype != "ktk")
		self maps\mp\gametypes\_weapons::dropWeaponForDeath(attacker);
		
	self thread lastStandTimer(bleedOutDelay);
	//<-
}


lastStandTimer( bleedOutDelay )
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "game_ended" );
	self endon( "revived"); //KILL THE KING
	
	self thread lastStandWaittillDeath();

	//self setLowerMessage( &"PLATFORM_COWARDS_WAY_OUT" );
	//self thread lastStandAllowSuicide();
	//self thread lastStandKeepOverlay();

	//KILL THE KING
	//->
	if(isDefined(self.pers["vip"]) && self.pers["vip"] && !self isKing())
	{
		if(level.VipsInServer < level.RegularsInServer)
		{
			if(isDefined(self.lowerMessage))
			{
				self.lowerMessage.label = self GetLocalizedString("REVIVE_INFO_YOUSELF"); //&"Hold ^3[{+activate}] ^7to revive yourself. (&&1)"; //&"KTK_HOLD_USE_REVIVE";
				self.lowerMessage setTimer(bleedOutDelay);
			}
		}
		else
		{
			if(isDefined(self.lowerMessage))
			{
				self.lowerMessage.label = self GetLocalizedString("LASTSTAND_MESSAGE"); //&"^1Bleeding out: &&1";
				self.lowerMessage setTimer(bleedOutDelay);
			}
		}
	}
	else
	{
		if(isDefined(self.lowerMessage))
		{
			self.lowerMessage.label = self GetLocalizedString("LASTSTAND_MESSAGE"); //&"^1Bleeding out: &&1";
			self.lowerMessage setTimer(bleedOutDelay);
		}
	}
	//<-

	wait bleedOutDelay;
	
	self thread LastStandBleedOut();
}



LastStandBleedOut()
{
	//KILL THE KING
	if(getDvarInt("scr_mod_blood") == 1)
		thread maps\mp\gametypes\_blood::blood_pool(self, self.lastStandParams.sWeapon, self.lastStandParams.sMeansOfDeath);

	self.useLastStandParams = true;
	self ensureLastStandParamsValidity();
	self suicide();
	
	if(isDefined(self.lowerMessage))
	{
		self.lowerMessage.label = &"";
		self.lowerMessage setText(&"");
	}
}

lastStandAllowSuicide()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "game_ended" );
	self endon( "revived"); //KILL THE KING
	
	while(1)
	{
		if ( self useButtonPressed() )
		{
			pressStartTime = gettime();
			while ( self useButtonPressed() )
			{
				wait .05;
				if ( gettime() - pressStartTime > 700 )
					break;
			}
			if ( gettime() - pressStartTime > 700 )
				break;
		}
		wait .05;
	}
	
	self thread LastStandBleedOut();
}

lastStandKeepOverlay()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "game_ended" );
	self endon( "revived"); //KILL THE KING
	
	// keep the health overlay going by making code think the player is getting damaged
	while(1)
	{
		self.health = 2;
		wait .05;
		self.health = 1;
		wait .5;
	}
}

lastStandWaittillDeath()
{
	self endon( "disconnect" );
	self endon( "revived"); //KILL THE KING
	
	self waittill( "death" );
	
	if(isDefined(self.lowerMessage))
	{
		self.lowerMessage.label = &"";
		self.lowerMessage setText(&"");
	}
	
	self clearLowerMessage();
	self.lastStand = undefined;
}

mayDoLastStand( sWeapon, sMeansOfDeath, sHitLoc )
{
	if ( sMeansOfDeath != "MOD_PISTOL_BULLET" && sMeansOfDeath != "MOD_RIFLE_BULLET" && sMeansOfDeath != "MOD_FALLING" )
		return false;
	
	if ( isHeadShot( sWeapon, sHitLoc, sMeansOfDeath ) )
		return false;
	
	return true;
}

ensureLastStandParamsValidity()
{
	// attacker may have become undefined if the player that killed me has disconnected
	if ( !isDefined( self.lastStandParams.attacker ) )
		self.lastStandParams.attacker = self;
}

setSpawnVariables()
{
	resetTimeout();

	// Stop shellshock and rumble
	self StopShellshock();
	self StopRumble( "damage_heavy" );
}

notifyConnecting()
{
	waittillframeend;

	if( isDefined( self ) )
		level notify( "connecting", self );
}


setObjectiveText( team, text )
{
	game["strings"]["objective_"+team] = text;
	precacheString( text );
}

setObjectiveScoreText( team, text )
{
	game["strings"]["objective_score_"+team] = text;
	precacheString( text );
}

setObjectiveHintText( team, text )
{
	game["strings"]["objective_hint_"+team] = text;
	precacheString( text );
}

getObjectiveText( team )
{
	return game["strings"]["objective_"+team];
}

getObjectiveScoreText()
{
	if(self isAnAssassin())
		return self GetLocalizedString("ASS_DESC");
	else if(self isAGuard())
		return self GetLocalizedString("GUARD_DESC");
}

getObjectiveHintText( team )
{
	return game["strings"]["objective_hint_"+team];
}

getHitLocHeight( sHitLoc )
{
	switch( sHitLoc )
	{
		case "helmet":
		case "head":
		case "neck":
			return 60;
		case "torso_upper":
		case "right_arm_upper":
		case "left_arm_upper":
		case "right_arm_lower":
		case "left_arm_lower":
		case "right_hand":
		case "left_hand":
		case "gun":
			return 48;
		case "torso_lower":
			return 40;
		case "right_leg_upper":
		case "left_leg_upper":
			return 32;
		case "right_leg_lower":
		case "left_leg_lower":
			return 10;
		case "right_foot":
		case "left_foot":
			return 5;
	}
	return 48;
}

debugLine( start, end )
{
	for ( i = 0; i < 50; i++ )
	{
		line( start, end );
		wait .05;
	}
}

delayStartRagdoll( ent, sHitLoc, vDir, sWeapon, eInflictor, sMeansOfDeath )
{
	if ( isDefined( ent ) )
	{
		deathAnim = ent getcorpseanim();
		if ( animhasnotetrack( deathAnim, "ignore_ragdoll" ) )
			return;
	}
	
	if ( level.oldschool )
	{
		if ( !isDefined( vDir ) )
			vDir = (0,0,0);
		
		explosionPos = ent.origin + ( 0, 0, getHitLocHeight( sHitLoc ) );
		explosionPos -= vDir * 20;
		//thread debugLine( ent.origin + (0,0,(explosionPos[2] - ent.origin[2])), explosionPos );
		explosionRadius = 40;
		explosionForce = .75;
		if ( sMeansOfDeath == "MOD_IMPACT" || sMeansOfDeath == "MOD_EXPLOSIVE" || isSubStr(sMeansOfDeath, "MOD_GRENADE") || isSubStr(sMeansOfDeath, "MOD_PROJECTILE") || sHitLoc == "head" || sHitLoc == "helmet" )
		{
			explosionForce = 2.5;
		}
		
		ent startragdoll( 1 );
		
		wait .05;
		
		if ( !isDefined( ent ) )
			return;
		
		// apply extra physics force to make the ragdoll go crazy
		physicsExplosionSphere( explosionPos, explosionRadius, explosionRadius/2, explosionForce );
		return;
	}
	
	wait( 0.2 );
	
	if ( !isDefined( ent ) )
		return;
	
	if ( ent isRagDoll() )
		return;
	
	deathAnim = ent getcorpseanim();

	startFrac = 0.35;

	if ( animhasnotetrack( deathAnim, "start_ragdoll" ) )
	{
		times = getnotetracktimes( deathAnim, "start_ragdoll" );
		if ( isDefined( times ) )
			startFrac = times[0];
	}

	waitTime = startFrac * getanimlength( deathAnim );
	wait( waitTime );

	if ( isDefined( ent ) )
	{
		println( "Ragdolling after " + waitTime + " seconds" );
		ent startragdoll( 1 );
	}
}


isExcluded( entity, entityList )
{
	for ( index = 0; index < entityList.size; index++ )
	{
		if ( entity == entityList[index] )
			return true;
	}
	return false;
}

leaderDialog( dialog, team, group, excludeList )
{
	assert( isdefined( level.players ) );

	if ( level.splitscreen )
		return;
		
	if ( !isDefined( team ) )
	{
		leaderDialogBothTeams( dialog, "allies", dialog, "axis", group, excludeList );
		return;
	}
	
	if ( level.splitscreen )
	{
		if ( level.players.size )
			level.players[0] leaderDialogOnPlayer( dialog, group );
		return;
	}
	
	if ( isDefined( excludeList ) )
	{
		for ( i = 0; i < level.players.size; i++ )
		{
			player = level.players[i];
			if ( (isDefined( player.pers["team"] ) && (player.pers["team"] == team )) && !isExcluded( player, excludeList ) )
				player leaderDialogOnPlayer( dialog, group );
		}
	}
	else
	{
		for ( i = 0; i < level.players.size; i++ )
		{
			player = level.players[i];
			if ( isDefined( player.pers["team"] ) && (player.pers["team"] == team ) )
				player leaderDialogOnPlayer( dialog, group );
		}
	}
}

leaderDialogBothTeams( dialog1, team1, dialog2, team2, group, excludeList )
{
	assert( isdefined( level.players ) );
	
	if ( level.splitscreen )
		return;

	if ( level.splitscreen )
	{
		if ( level.players.size )
			level.players[0] leaderDialogOnPlayer( dialog1, group );
		return;
	}
	
	if ( isDefined( excludeList ) )
	{
		for ( i = 0; i < level.players.size; i++ )
		{
			player = level.players[i];
			team = player.pers["team"];
			
			if ( !isDefined( team ) )
				continue;
			
			if ( isExcluded( player, excludeList ) )
				continue;
			
			if ( team == team1 )
				player leaderDialogOnPlayer( dialog1, group );
			else if ( team == team2 )
				player leaderDialogOnPlayer( dialog2, group );
		}
	}
	else
	{
		for ( i = 0; i < level.players.size; i++ )
		{
			player = level.players[i];
			team = player.pers["team"];
			
			if ( !isDefined( team ) )
				continue;
			
			if ( team == team1 )
				player leaderDialogOnPlayer( dialog1, group );
			else if ( team == team2 )
				player leaderDialogOnPlayer( dialog2, group );
		}
	}
}


leaderDialogOnPlayer( dialog, group )
{
	team = self.pers["team"];

	if ( level.splitscreen )
		return;
	
	if ( !isDefined( team ) )
		return;
	
	if ( team != "allies" && team != "axis" )
		return;
	
	if ( isDefined( group ) )
	{
		// ignore the message if one from the same group is already playing
		if ( self.leaderDialogGroup == group )
			return;

		hadGroupDialog = isDefined( self.leaderDialogGroups[group] );

		self.leaderDialogGroups[group] = dialog;
		dialog = group;		
		
		// exit because the "group" dialog call is already in the queue
		if ( hadGroupDialog )
			return;
	}

	if ( !self.leaderDialogActive )
		self thread playLeaderDialogOnPlayer( dialog, team );
	else
		self.leaderDialogQueue[self.leaderDialogQueue.size] = dialog;
}


playLeaderDialogOnPlayer( dialog, team )
{
	self endon ( "disconnect" );
	
	self.leaderDialogActive = true;
	if ( isDefined( self.leaderDialogGroups[dialog] ) )
	{
		group = dialog;
		dialog = self.leaderDialogGroups[group];
		self.leaderDialogGroups[group] = undefined;
		self.leaderDialogGroup = group;
	}

	self playLocalSound( game["voice"][team]+game["dialog"][dialog] );

	wait ( 3.0 );
	self.leaderDialogActive = false;
	self.leaderDialogGroup = "";

	if ( self.leaderDialogQueue.size > 0 )
	{
		nextDialog = self.leaderDialogQueue[0];
		
		for ( i = 1; i < self.leaderDialogQueue.size; i++ )
			self.leaderDialogQueue[i-1] = self.leaderDialogQueue[i];
		self.leaderDialogQueue[i-1] = undefined;
		
		self thread playLeaderDialogOnPlayer( nextDialog, team );
	}
}


getMostKilledBy()
{
	mostKilledBy = "";
	killCount = 0;
	
	killedByNames = getArrayKeys( self.killedBy );
	
	for ( index = 0; index < killedByNames.size; index++ )
	{
		killedByName = killedByNames[index];
		if ( self.killedBy[killedByName] <= killCount )
			continue;
		
		killCount = self.killedBy[killedByName];
		mostKilleBy = killedByName;
	}
	
	return mostKilledBy;
}


getMostKilled()
{
	mostKilled = "";
	killCount = 0;
	
	killedNames = getArrayKeys( self.killedPlayers );
	
	for ( index = 0; index < killedNames.size; index++ )
	{
		killedName = killedNames[index];
		if ( self.killedPlayers[killedName] <= killCount )
			continue;
		
		killCount = self.killedPlayers[killedName];
		mostKilled = killedName;
	}
	
	return mostKilled;
}

// Modified script _explosive_barrels.gsc - Used for the explosive crossbow
// Modified for KtK by Viking
playergoboom(sWeapon, ownerTeam, sHitLoc, usingRiotShield)
{
	self endon("disconnect");
	self endon("death");
	self endon("spawned_player"); //it's sometimes not ending on death so i try this

	if(self isInRCToy() || self isInAC130() || self isInMannedHelicopterTurret())
		return;

	if(!usingRiotShield && !isDefined(self.stickyNade_icon) && !isDefined(self.stickyNade_text))
		self thread maps\mp\gametypes\_huds::stickyNade();

	self.stickied = true;

	exparrow = spawn("script_model", self.origin);
	exparrow linkto(self);
	exparrow thread ExplodeAfterDelay(2, self, sWeapon, ownerTeam, sHitLoc, usingRiotShield);
	self thread UnlinkOnDeath(exparrow);
	self thread UnlinkOnDisconnect(exparrow);
}

ExplodeAfterDelay(delay, victim, sWeapon, ownerTeam, sHitLoc, usingRiotShield)
{
	if(!isDefined(sWeapon))
		DebugMessage(5, "^1CROSSBOW PROBLEM: sWeapon is not defined!");

	self playsound("semtex_beep_beep");

	dropped = false;
	while(delay >= 0)
	{
		wait .05;
		
		//removed - does not work correctly - cod4 does not link it with rotations
		//we need the correct tag of the arrow
		//if(victim hasAttached("projectile_bo_arrow_explosive"))
		//{
		//	if(delay == int(delay) || delay == (int(delay)/2))
		//		PlayFxonTag(level._effect["blinking_red"], victim, "tag_fx");
		//}
		
		delay -= .05;
		
		if(!isAlive(victim) || usingRiotShield)
		{
			dropped = true;
			self unlink();
			
			trace = BulletTrace(self.origin, self.origin - (0,0,10000), false, undefined);
			
			if(!isDefined(trace["position"]))
				dif = 120;
			else
				dif = int(CalcDif(trace["position"][2], self.origin[2]));
			
			if(!isDefined(dif) || dif <= 0)
				dif = 1;
			
			self moveZ(dif, (dif/800)); //dif = distance, 800 = default cod4 gravity
		}
	}

	self playsound(level.playerExpSound);
	playfx(level.nade_fx["nade"]["explode"], self.origin + (0,0,48));
		
	maxDamage = getDvarInt("scr_mod_expbolt_damage");
	minDamage = int(maxDamage/4);
	
	if(minDamage <= 0)
		minDamage = 1;

	if(maxDamage <= 0)
		maxDamage = 1;
		
	if(maxDamage <= minDamage)
		maxDamage = minDamage + 1;
	
	maxDistance = 256;
	physicsExplosionSphere(self.origin + (0,0,30), maxDistance, 128, 2);

	victim.stickied = false;

	if(isDefined(victim.stickyNade_icon))
		victim.stickyNade_icon destroy();
		
	if(isDefined(victim.stickyNade_text))
		victim.stickyNade_text destroy();
	
	//new
	if(getDvarInt("scr_arrow_radiusdamage_type") > 0)
	{
		if(!isdefined(victim.damageOwner) || !isDefined(ownerTeam) || ownerTeam == "spectator")
			ktkRadiusDamage(victim.origin + (0,0,16), maxDistance, maxDamage, minDamage, undefined, sWeapon, self);
		else
			ktkRadiusDamage(victim.origin + (0,0,16), maxDistance, maxDamage, minDamage, victim.damageOwner, sWeapon, self);
	}
	else
	{
		//old
		health = victim.health;
		
		if(!isdefined(victim.damageOwner) || !isDefined(ownerTeam) || ownerTeam == "spectator")
			radiusDamage(self.origin + (0,0,30), maxDistance, maxDamage, minDamage);
		else
		{
			radiusDamage(self.origin + (0,0,30), maxDistance, maxDamage, minDamage, victim.damageOwner, "MOD_EXPLOSIVE", sWeapon);
			
			//and damage rccars as well
			for(i=0;i<level.players.size;i++)
			{
				if(level.players[i].pers["team"] == "spectator")
					continue;
			
				if(!level.players[i] isInRCToy())
					continue;

				if(Distance(level.players[i].origin, self.origin) <= maxDistance)
				{
					if(level.players[i].pers["team"] != ownerTeam || level.players[i] == victim.damageOwner)
					{
						if(level.players[i] isInRCCar())
							level.players[i].rc_car thread maps\mp\gametypes\_rccar::Explode(level.players[i]);
						else if(level.players[i] isInRCHelicopter())
							level.players[i].rc_heli thread maps\mp\gametypes\_rchelicopter::Explode();
					}
				}
			}
		}
		
		if(isDefined(victim))
		{
			/* does not work correctly - cod4 does not link it with rotations
			if(victim hasAttached("projectile_bo_arrow_explosive"))
				victim detach("projectile_bo_arrow_explosive", sHitLoc);
			*/
			
			//no damage caused
			if(!dropped && victim.health == health && isAlive(victim) && (!isDefined(victim.godmode) || !victim.godmode))
			{
				if(victim isAGuard())
				{
					if(!isdefined(victim.damageOwner))
						victim ktkFinishPlayerDamage( victim, victim, randomIntRange(minDamage, maxDamage), 0, "MOD_EXPLOSIVE", sWeapon, victim.origin, VectorToAngles(victim.origin - victim.origin), "none", 0 );
					else
					{
						if(victim.pers["team"] != victim.damageOwner.pers["team"])
							victim ktkFinishPlayerDamage( victim.damageOwner, victim.damageOwner, randomIntRange(minDamage, maxDamage), 0, "MOD_EXPLOSIVE", sWeapon, victim.damageOwner.origin, VectorToAngles(victim.origin - victim.damageOwner.origin), "none", 0 );
					}
				}
			}
		}
	}
	
	if(getDvarInt("scr_mod_gore") > 0 && !isAlive(victim))
	{
		if(isDefined(victim.body))
		{
			if(isDefined(victim.damageOwner) && victim.damageOwner.pers["team"] != victim.pers["team"])
			{	
				playfx(level._effect["gib_splat"], victim.origin + (0,0,48));
				victim.body hide();
			}
		}
	}
	
	if(isDefined(self))
		self delete();
}

UnlinkOnDeath(exparrow)
{
	self endon("disconnect");
	
	self waittill("death");
	
	if(isDefined(exparrow))
		exparrow Unlink();
}

UnlinkOnDisconnect(exparrow)
{
	self endon("death");
	
	self waittill("disconnect");
	
	if(isDefined(exparrow))
		exparrow Unlink();
}

CheckGametype()
{
	if(level.gametype == "ktk" || level.gametype == "ctc" || level.gametype == "htt")
		return;

	iPrintLnBold(&"GAME_INVALIDGAMETYPE");
	DebugMessage(1, "Invalid gametype! - Restarting gametype now!");

	setDvar("sv_maprotation_stored", getDvar("sv_maprotation"));
	setDvar("sv_maprotation", "gametype ktk map mp_crash");
	setDvar("sv_maprotationcurrent", "gametype ktk map mp_crash");

	wait 5;
	
	exitLevel(false);
}

removeWithCorpse(corpse)
{
	self endon("death");
	
	while(isDefined(corpse))
		wait .1;
		
	self delete();
}