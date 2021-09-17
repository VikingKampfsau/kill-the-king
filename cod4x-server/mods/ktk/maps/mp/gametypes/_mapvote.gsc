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
	if(getDvar("scr_mod_mapvote") == "") setDvar("scr_mod_mapvote", 0);
	if(getDvar("scr_mod_votetime") == "") setDvar("scr_mod_votetime", 20);
	if(getDvar("scr_mod_mapvote_playerbased") == "") setDvar("scr_mod_mapvote_playerbased", 0);
	
	if(getDvar("rotation") == "") setDvar("rotation", "mp_backlot;mp_crash;mp_showdown;mp_bloc;mp_shipment");
	if(getDvar("rotation_few_players") == "") setDvar("rotation_few_players", "mp_shipment;mp_showdown;mp_vacant");
	if(getDvar("rotation_some_players") == "") setDvar("rotation_some_players", "mp_crash;mp_bloc;mp_ambush");
	if(getDvar("rotation_many_players") == "") setDvar("rotation_many_players", "mp_overgrown;mp_creek");
	
	if(getDvar("scr_mod_ktk_events") == "") setDvar("scr_mod_ktk_events", "none;alien;beastking;dogfight;funday;kingvsking;knifeonly;lastkingstanding;reversektk;revolt;sniperonly;tankking;terror;unknownking;zombie");
	if(getDvar("scr_mod_ktk_eventdays") == "") setDvar("scr_mod_ktk_eventdays", "saturday;sunday");
	if(getDvar("scr_mod_ktk_eventtime_weekend") == "") setDvar("scr_mod_ktk_eventtime_weekend", "00:00-23:59");
	if(getDvar("scr_mod_ktk_eventtime_midweek") == "") setDvar("scr_mod_ktk_eventtime_midweek", "18:00-23:59");
	
	if(getDvarInt("scr_mod_mapvote") > 0)
	{
		if(getDvar("sv_maprotation") != "") setDvar("sv_maprotation", "");
		if(getDvar("sv_maprotationcurrent") != "") setDvar("sv_maprotationcurrent", "");
		
		thread UpdateMaprotationForB3();
	}

	if(getDvar("timescale") != "1") setDvar("timescale", "1");
	
	level.mapvotetime = int(getDvarInt("scr_mod_votetime")/2);
	level.winnermap = undefined;
	level.PrecachedStrings = [];
	
	level.usedPlayerRotation = undefined;
	level.rotationLowPlayers = getDvarInt("rotation_few_players_amount");
	level.rotationMedPlayers = getDvarInt("rotation_some_players_amount");
	
	if(!level.rotationLowPlayers && !level.rotationMedPlayers)
		setDvar("scr_mod_mapvote_playerbased", 0);
	
	thread UpdateBlockedMaps();
	
	if(getDvarInt("scr_mod_mapvote") == 2)
	{
		thread onPlayerConnect();

		if(getMaps())
			thread sendVoteableMapsToPlayer();
	}
}

onPlayerConnect()
{
	while(1)
	{
		level waittill("connected", player);
		player.hasVotedMap = undefined;
	}
}

UpdateMaprotationForB3()
{
	maps = strTok(getDvar("rotation") , ";");
	
	if(!isDefined(maps) || maps.size <= 0)
	{
		setDvar("sv_maprotation_stored", "");
		return;
	}
	
	string = "gametype ktk";
	for(i=0;i<maps.size;i++)
		string = string + " map " + maps[i]; 
	
	setDvar("sv_maprotation_stored", string);
	
	wait 3;
	
	setDvar("sv_mapRotation", getDvar("sv_maprotation_stored"));
	setDvar("sv_mapRotation_current", getDvar("sv_maprotation_stored"));
}

UpdateBlockedMaps()
{
	if(getDvar("scr_mod_mapvote_blocktime") == "") setDvar("scr_mod_mapvote_blocktime", 1);

	blockedMaps = [];
	blockedMaps = strTok(getDvar("blockedMaps") , ";");

	updateBlockList = true;
	setDvar("blockedMaps", "");
	for(i=0;i<blockedMaps.size;i++)
	{
		blockSettings = strTok(blockedMaps[i], " ");
		
		if(!isDefined(blockSettings) || !isDefined(blockSettings[0]) || !isDefined(blockSettings[1]))
		{
			updateBlockList = false;
			break;
		}
		
		blockedMapName = blockSettings[0];
		blockedMapTime = int(blockSettings[1]);
		
		if(isDefined(blockedMapTime))
		{
			blockedMapTime--;
			
			if(blockedMapTime > 0)
				setDvar("blockedMaps", getDvar("blockedMaps") + ";" + blockedMapName + " " + blockedMapTime);
		}
	}
	
	if(updateBlockList)
	{
		if(getDvar("blockedMaps") == "")
			setDvar("blockedMaps", getDvar("mapname") + " " + getDvarInt("scr_mod_mapvote_blocktime"));
		else
			setDvar("blockedMaps", getDvar("blockedMaps") + ";" + getDvar("mapname") + " " + getDvarInt("scr_mod_mapvote_blocktime"));
	}
}

startMapvote()
{
	if(getDvarInt("scr_mod_mapvote") < 2)
	{
		if(getDvar("scr_mod_ktk_events") != "")
		{
			eventDay = false;
			eventTime = false;
			
			eventDays = strToK(getDvar("scr_mod_ktk_eventdays"), ";");

			if(eventDays.size > 0)
			{
				weekday = toLower(CalcDayOfWeek());
				for(i=0;i<eventDays.size;i++)
				{
					if(weekday == toLower(eventDays[i]))
					{
						eventDay = true;
						break;
					}
				}
				
				daytime = TimeToString(getRealTime(), 0, "%H:%M");
				daytime = strToK(daytime, ":");
				
				if(weekday == "saturday" || weekday == "sunday")
					eventPeriod = strToK(getDvar("scr_mod_ktk_eventtime_weekend"), "-");
				else
					eventPeriod = strToK(getDvar("scr_mod_ktk_eventtime_midweek"), "-");
				
				if(eventPeriod.size > 0)
				{
					eventPeriod_Start = strToK(eventPeriod[0], ":");
					eventPeriod_End = strToK(eventPeriod[1], ":");
					
					if(eventPeriod_Start.size >= 2 && eventPeriod_End.size >= 2)
					{
						if(int(daytime[0]) >= int(eventPeriod_Start[0]) && int(daytime[1]) >= int(eventPeriod_Start[1]))
						{
							if(int(daytime[0]) <= int(eventPeriod_End[0]) && int(daytime[1]) <= int(eventPeriod_End[1]))
								eventTime = true;
						}
					}
				}
			}

			if(eventDay && eventTime)
			{
				if(getEvents())
				{
					createHUD("eventvote");
					wait level.mapvotetime;
					endVoteProcess("eventvote");
				}
			}
		}
	}

	if(getMaps())
	{
		createHUD("mapvote");
		wait level.mapvotetime;
		endVoteProcess("mapvote");
	}
	
	EndVote();
}

getEvents()
{
	events = strToK(getDvar("scr_mod_ktk_events"), ";");
	
	if(events.size > 5)
		votesize = 5;
	else
	{
		if(events.size == 0)
			return false;
	
		votesize = events.size;
	}
	
	events = shuffleArray(events);
	
	for(i=0;i<votesize;i++)
	{
		if(i == 0)
			level.event[i] = "none";
		else
			level.event[i] = events[RandomInt(events.size)];
		
		while(1)
		{
			wait .05;

			if(checkForDuplicate(level.event[i], "event"))
			{
				level.event[i] = events[RandomInt(events.size)];
				continue;
			}
			break;
		}
		
		level.point_map[i] = 0;
		level.map_voters[i] = "";
	}
	
	return true;
}

getMaps()
{
	rotation = [];

	if(getDvarInt("scr_mod_mapvote") == 2)
		level waittill("game_ended");
	
	if(isDefined(level.winnerevent) && level.winnerevent != "none")
		rotation = strTok(getDvar("rotation_" + level.winnerevent) , ";");
	
	if(rotation.size == 0)
	{
		if(getDvarInt("scr_mod_mapvote_playerbased") == 0)
			rotation = strTok(getDvar("rotation") , ";");
		else
		{
			if(level.players.size <= level.rotationLowPlayers)
			{
				level.usedPlayerRotation = "few";
				rotation = strTok(getDvar("rotation_few_players") , ";");
			}
			else if(level.players.size > level.rotationLowPlayers && level.players.size <= level.rotationMedPlayers)
			{
				level.usedPlayerRotation = "some";
				rotation = strTok(getDvar("rotation_some_players") , ";");
			}
			else if(level.players.size > level.rotationMedPlayers)
			{
				level.usedPlayerRotation = "many";
				rotation = strTok(getDvar("rotation_many_players") , ";");
			}
		}
	}
	
	if(rotation.size > 5)
		votesize = 5;
	else
	{
		if(rotation.size == 0)
			return false;

		votesize = rotation.size;
	}
	
	rotation = shuffleArray(rotation);
	
	for(i=0;i<votesize;i++)
	{
		level.map[i] = rotation[RandomInt(rotation.size)];
		
		while(1)
		{
			wait .05;

			if(rotation.size >= (votesize+getDvarInt("scr_mod_mapvote_blocktime")))
			{
				if(isBlockedMap(level.map[i]))
				{
					level.map[i] = rotation[RandomInt(rotation.size)];
					continue;
				}
			}
			
			if(checkForDuplicate(level.map[i], "map"))
			{
				level.map[i] = rotation[RandomInt(rotation.size)];
				continue;
			}
			break;
		}
		
		level.point_map[i] = 0;
		level.map_voters[i] = "";
		level.mapname[i] = GetMapName(level.map[i]);

		hasWaypoints = fs_testFile("waypoints\\" + level.map[i] + "_waypoints.gsc");
		if(!hasWaypoints) hasWaypoints = fs_testFile("waypoints\\" + level.map[i] + "_waypoints.gsx");
		
		if(hasWaypoints)	
			level.botsupport[i] = "";
		else
			level.botsupport[i] = " (No Bots!)";
	}
	
	if(getDvarInt("scr_mod_mapvote") == 2)
	{
		//random map in case noone votes
		randomMap = level.map[RandomInt(level.map.size)];
		setDvar("sv_maprotation","gametype " + level.gametype + " map " + randomMap);
		setDvar("sv_maprotationcurrent", "gametype " + level.gametype + " map " + randomMap);
	}
	
	return true;
}

checkForDuplicate(entry, type)
{
	count = 0;
	if(type == "map")
		count = level.map.size;
	else if(type == "event")
		count = level.event.size;
	
	for(i=0;i<count-1;i++)
	{
		if(type == "map" && entry == level.map[i])
			return true;
			
		if(type == "event" && entry == level.event[i])
			return true;
	}
	
	return false;
}

isBlockedMap(currentmap)
{
	blockedMaps = [];
	blockedMaps = strTok(getDvar("blockedMaps") , ";");

	for(i=0;i<blockedMaps.size;i++)
	{
		blockSettings = strTok(blockedMaps[i], " ");
		blockName = blockSettings[0];
		blockTime = int(blockSettings[1]);
		
		if(blockName == currentmap)
		{
			if(isDefined(blockTime) && blockTime > 0)
				return true;
				
			return false;
		}
	}
	
	return false;
}

createHUD(votetype)
{
	//black background
	level.votetable_bg = newHudElem();
	level.votetable_bg.horzalign = "center";
	level.votetable_bg.vertalign = "middle";
	level.votetable_bg.foreground = true;
	level.votetable_bg setShader("black", 350, 110);
	level.votetable_bg.alpha = 0.85;
	level.votetable_bg.sort = -1;
	level.votetable_bg.x = -175;
	level.votetable_bg.y = -140;
	
	//the title
	level.votetable_title = newHudElem();
	level.votetable_title.horzalign = "center";
	level.votetable_title.vertalign = "middle";
	level.votetable_title.foreground = true;
	level.votetable_title.fontScale = 1.5;
	level.votetable_title.alpha = 1;
	level.votetable_title.sort = 1;
	level.votetable_title.x = -170;
	level.votetable_title.y = -140;
	
	if(votetype == "mapvote")
		level.votetable_title.label = &"Press ^1[{+attack}] ^7to vote for a map!";
	else if(votetype == "eventvote")
		level.votetable_title.label = &"Press ^1[{+attack}] ^7to vote for an event!";
	
	//the timer
	level.votetable_timer = newHudElem();
	level.votetable_timer.horzalign = "center";
	level.votetable_timer.vertalign = "middle";
	level.votetable_timer.foreground = true;
	level.votetable_timer.fontScale = 1.5;
	level.votetable_timer.alpha = 1;
	level.votetable_timer.sort = 1;
	level.votetable_timer.x = 130;
	level.votetable_timer.y = -140;
	level.votetable_timer SetTenthsTimer(level.mapvotetime);
	//thread RemainingTime();
	
	if(votetype == "mapvote")
	{
		//the maps
		for(i=0; i<level.map.size; i++)
		{	
			level.votetable_map[i] = newHudElem();
			level.votetable_map[i].alignX = "left";
			level.votetable_map[i].alignY = "middle";
			level.votetable_map[i].horzalign = "center";
			level.votetable_map[i].vertalign = "middle";
			level.votetable_map[i].foreground = true;
			level.votetable_map[i].fontScale = 1.6;
			level.votetable_map[i].alpha = 1;
			level.votetable_map[i].sort = 1;
			level.votetable_map[i].x = -150;
			level.votetable_map[i].y = -112 + i * 16;
			level.votetable_map[i].label = &"&&1";
			level.votetable_map[i] setText(level.mapname[i] + level.botsupport[i]);
			
			level.votetable_votes[i] = newHudElem();
			level.votetable_votes[i].alignX = "left";
			level.votetable_votes[i].alignY = "middle";
			level.votetable_votes[i].horzalign = "center";
			level.votetable_votes[i].vertalign = "middle";
			level.votetable_votes[i].foreground = true;
			level.votetable_votes[i].fontScale = 1.6;
			level.votetable_votes[i].alpha = 1;
			level.votetable_votes[i].sort = 1;
			level.votetable_votes[i].x = -170;
			level.votetable_votes[i].y = -112 + i * 16;
			level.votetable_votes[i].label = &"&&1 - ";
			level.votetable_votes[i] setValue(0);

			level.votetable_voters[i] = newHudElem();
			level.votetable_voters[i].alignX = "left";
			level.votetable_voters[i].alignY = "middle";
			level.votetable_voters[i].horzalign = "center";
			level.votetable_voters[i].vertalign = "middle";
			level.votetable_voters[i].foreground = true;
			level.votetable_voters[i].fontScale = 1.6;
			level.votetable_voters[i].alpha = 1;
			level.votetable_voters[i].sort = 1;
			level.votetable_voters[i].x = 0;
			level.votetable_voters[i].y = -112 + i * 16;
		}
	}
	else if(votetype == "eventvote")
	{
		//the events
		for(i=0; i<level.event.size; i++)
		{
			level.votetable_event[i] = newHudElem();
			level.votetable_event[i].alignX = "left";
			level.votetable_event[i].alignY = "middle";
			level.votetable_event[i].horzalign = "center";
			level.votetable_event[i].vertalign = "middle";
			level.votetable_event[i].foreground = true;
			level.votetable_event[i].fontScale = 1.6;
			level.votetable_event[i].alpha = 1;
			level.votetable_event[i].sort = 1;
			level.votetable_event[i].x = -150;
			level.votetable_event[i].y = -112 + i * 16;
			level.votetable_event[i].label = &"&&1";
			level.votetable_event[i] setText(getEventName(level.event[i]));
			
			level.votetable_votes[i] = newHudElem();
			level.votetable_votes[i].alignX = "left";
			level.votetable_votes[i].alignY = "middle";
			level.votetable_votes[i].horzalign = "center";
			level.votetable_votes[i].vertalign = "middle";
			level.votetable_votes[i].foreground = true;
			level.votetable_votes[i].fontScale = 1.6;
			level.votetable_votes[i].alpha = 1;
			level.votetable_votes[i].sort = 1;
			level.votetable_votes[i].x = -170;
			level.votetable_votes[i].y = -112 + i * 16;
			level.votetable_votes[i].label = &"&&1 - ";
			level.votetable_votes[i] setValue(0);

			level.votetable_voters[i] = newHudElem();
			level.votetable_voters[i].alignX = "left";
			level.votetable_voters[i].alignY = "middle";
			level.votetable_voters[i].horzalign = "center";
			level.votetable_voters[i].vertalign = "middle";
			level.votetable_voters[i].foreground = true;
			level.votetable_voters[i].fontScale = 1.6;
			level.votetable_voters[i].alpha = 1;
			level.votetable_voters[i].sort = 1;
			level.votetable_voters[i].x = 0;
			level.votetable_voters[i].y = -112 + i * 16;
		}
	}
	
	//the bar which shows which map the player is voting for
	for(i=0; i<level.players.size; i++)
	{
		if(level.players[i] isABot())
			continue;
	
		level.players[i].vote_indicator = newClientHudElem(level.players[i]);
		level.players[i].vote_indicator.horzalign = "center";
		level.players[i].vote_indicator.vertalign = "middle";
		level.players[i].vote_indicator.foreground = true;
		level.players[i].vote_indicator.x = -175;
		level.players[i].vote_indicator.y = -120;
		level.players[i].vote_indicator.sort = 0;
		level.players[i].vote_indicator.alpha = 0;
		level.players[i].vote_indicator.color = (0, 0, 1);
		level.players[i].vote_indicator setShader("white", 350, 17);
		
		level.players[i] thread PlayerVoting(votetype);
	}
}

RemainingTime()
{
	time = level.mapvotetime;
	
	while(time >= 0)
	{
		level.votetable_timer setValue(time);
		time -= 1;
		wait 1;
	}
}

PlayerVoting(votetype)
{
	self endon("disconnect");
	
	self closeMenu();
	self closeInGameMenu();
	self notify("reset_outcome");
	self setDepthOfField(0, 128, 512, 4000, 6, 1.8);
	[[level.onSpawnIntermission]]();
	
	spawnpoints = getentarray("mp_global_intermission", "classname");
	
	if(!isDefined(spawnpoints) || spawnpoints.size <= 0)
		spawnpoints = getentarray("mp_tdm_spawn", "classname");

	self linkTo(spawnPoints[0]);
	self hide();
	
	self.vote_choice = -1;
	time = level.mapvotetime;
	
	while(time >= 0)
	{
		if(votetype == "mapvote" && isDefined(level.winnermap))
			break;
			
		if(votetype == "eventvote" && isDefined(level.winnerevent))
			break;
	
		// Attack (FIRE) button to vote            
		if(isplayer(self) && self attackButtonPressed())
		{
			self Vote(votetype);
			self playLocalSound("ui_mp_suitcasebomb_timer");
			
			while(isPlayer(self) && self attackButtonPressed())
				wait .05;
		}

		if(isPlayer(self) && self.sessionstate != "spectator" && self.spectatorclient != -1)
		{
			self.sessionstate = "spectator";
			self.spectatorclient = -1;
		}
		
		wait .05;
		time -= .05;
	}
}

Vote(votetype)
{
	self endon("disconnect");

	choices = 0;
	if(votetype == "mapvote")
		choices = level.map.size;
	else if(votetype == "eventvote")
		choices = level.event.size;
	
	if(self.vote_choice >= 0)
	{
		if(level.point_map[self.vote_choice] > 0)
		{
			level.point_map[self.vote_choice]--;
		}
	}
	
	self.vote_choice++;

	if(self.vote_choice > (choices - 1))
		self.vote_choice = 0;
	
	level.point_map[self.vote_choice]++;
	
	thread UpdateMapVotes(votetype);
	//thread UpdateVoterNames();
	
	if(isDefined(self.vote_indicator))
	{
		if(self.vote_indicator.alpha != 0.8)
			self.vote_indicator.alpha = 0.8;
	
		self.vote_indicator.y = -120 + (self.vote_choice * 16);
	}
}

UpdateMapVotes(votetype)
{
	self notify("update_mapvotes");
	self endon("update_mapvotes");

	count = 0;
	if(votetype == "mapvote")
		count = level.map.size;
	else if(votetype == "eventvote")
		count = level.event.size;
	
	for(i=0;i<count;i++)
		level.votetable_votes[i] setValue(level.point_map[i]);
}

UpdateVoterNames()
{
	self notify("update_mapvoter_names");
	self endon("update_mapvoter_names");

	visibleNames = [];
	newEndString = [];
	
	for(i=0;i<level.map.size;i++)
	{
		level.map_voters[i] = "";
		newEndString[i] = "";
		visibleNames[i] = -1;
	}
	
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].vote_choice) && level.players[i].vote_choice >= 0)
		{
			if(level.map_voters[level.players[i].vote_choice] == "")
			{
				visibleNames[level.players[i].vote_choice]++;
				level.map_voters[level.players[i].vote_choice] = level.players[i].name;
				AddStringToPrecacheArray(level.map_voters[level.players[i].vote_choice]);
			}
			else
			{
				if(!VoterNameVisible(level.players[i], level.players[i].vote_choice))
				{
					visibleNames[level.players[i].vote_choice]++;
				
					if(visibleNames[level.players[i].vote_choice] > 1)
					{
						newEndString[i] = (" and " + (visibleNames[level.players[i].vote_choice] - 1) + " more!");
						AddStringToPrecacheArray(level.map_voters[level.players[i].vote_choice] + newEndString[i]);
					}
					else
					{
						newEndString[i] = ""; 
						level.map_voters[level.players[i].vote_choice] += (", " + level.players[i].name);
						AddStringToPrecacheArray(level.map_voters[level.players[i].vote_choice]);
					}
				}
			}
		}
	}
	
	if(!WillCauseStringOverflow())
	{
		for(i=0;i<level.map.size;i++)
		{
			if(!isDefined(level.votetable_voters[i].label))
				level.votetable_voters[i].label = &"&&1";

			if(isDefined(level.map_voters[i]) && level.map_voters[i] != "" && isDefined(newEndString[i]) && newEndString[i] != "")
				level.votetable_voters[i] SetText(level.map_voters[i] + newEndString[i]);
			else
				level.votetable_voters[i] SetText(level.map_voters[i]);
		}
	}
}

VoterNameVisible(player, mapInt)
{
	names = StrToK(level.map_voters[mapInt], ",");
	
	if(!isDefined(names) || !names.size)
		return false;
		
	for(i=0;i<names.size;i++)
	{
		if(isDefined(names[i]) && names[i] == player.name)
			return true;
	}
	
	return false;
}

AddStringToPrecacheArray(string)
{
	if(level.PrecachedStrings.size > 0)
	{
		//see maximum reason below
		if(level.PrecachedStrings.size > 20)
			return;
	
		for(i=0;i<level.PrecachedStrings.size;i++)
		{
			if(level.PrecachedStrings[i] == string)
				return;
		}
	}

	level.PrecachedStrings[level.PrecachedStrings.size] = string;
}

WillCauseStringOverflow()
{
	//gonna have to play around with the maximum (last crash was between 30 and 40 - let's try 20)
	if(level.PrecachedStrings.size > 20)
	{
		//return true;
	
		for(i=0;i<level.map.size;i++)
		{
			level.votetable_voters[i] SetText(level.PrecachedStrings[0]);
			level.votetable_voters[i] ClearAllTextAfterHudelem();
			//what is that doing? ClearLocalizedStrings( <firstString> )
		}
	}

	return false;
}

endVoteProcess(votetype)
{
	count = 0;
	if(votetype == "mapvote")
	{
		count = level.map.size;
		level.winnermap = GetVoteWinner(votetype, count);
	}
	else if(votetype == "eventvote")
	{
		count = level.event.size;
		level.winnerevent = GetVoteWinner(votetype, count);
	}
	
	level.votetable_bg fadeovertime(1);
	level.votetable_title fadeovertime(1);
	level.votetable_timer fadeovertime(1);
	level.votetable_bg.alpha = 0;
	level.votetable_title.alpha = 0;
	level.votetable_timer.alpha = 0;
	
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].vote_indicator))
		{
			level.players[i].vote_indicator fadeovertime(1);
			level.players[i].vote_indicator.alpha = 0;
		}
	}
		
	for(i=0;i<count;i++)
	{
		if(votetype == "mapvote")
		{
			level.votetable_map[i] fadeovertime(1);
			level.votetable_map[i].alpha = 0;
		}
		else if(votetype == "eventvote")
		{
			level.votetable_event[i] fadeovertime(1);
			level.votetable_event[i].alpha = 0;
		}

		level.votetable_votes[i] fadeovertime(1);
		level.votetable_votes[i].alpha = 0;
		
		level.votetable_voters[i] fadeovertime(1);
		level.votetable_voters[i].alpha = 0;
	}
		
	wait 1;
	
	level.votetable_bg destroy();
	level.votetable_title destroy();
	level.votetable_timer destroy();
	
	for(i = 0; i < level.players.size; i++)
	{
		if(isDefined(level.players[i].vote_indicator))
			level.players[i].vote_indicator destroy();
	}
	
	for(i=0;i<count;i++)
	{
		if(votetype == "mapvote")
			level.votetable_map[i] destroy();
		else if(votetype == "eventvote")
			level.votetable_event[i] destroy();

		level.votetable_votes[i] destroy();
		level.votetable_voters[i] destroy();
	}
}

GetVoteWinner(votetype, size)
{
	possibleWinner = [];
	winner = undefined;
	count = 0;

	if(!level.players.size)
	{
		if(votetype == "mapvote")
			return level.map[randomInt(level.map.size)];
			
		if(votetype == "eventvote")
			return level.event[randomInt(level.event.size)];
	}

	for(i=0;i<size;i++)
	{
		if(level.point_map[i] > count)
		{
			count = level.point_map[i];
			
			possibleWinner = undefined;
			
			if(votetype == "mapvote")
				possibleWinner[0] = level.map[i];
			else if(votetype == "eventvote")
				possibleWinner[0] = level.event[i];
		
			continue;
		}
		
		if(level.point_map[i] == count)
		{
			count = level.point_map[i];
			
			if(votetype == "mapvote")
				possibleWinner[possibleWinner.size] = level.map[i];
			else if(votetype == "eventvote")
				possibleWinner[possibleWinner.size] = level.event[i];
		}
	}

	if(isDefined(count) && count == 0)
	{
		if(votetype == "mapvote")
			return level.map[randomInt(level.map.size)];
			
		if(votetype == "eventvote")
			return level.event[randomInt(level.event.size)];
	}
	
	winner = possibleWinner[randomInt(possibleWinner.size)];
	
	if(votetype == "mapvote")
		updateFavouritMapsList(winner);
	
	return winner;
}

EndVote()
{
	if(isDefined(level.winnermap))
	{
		scr_iPrintlnBold("MAPVOTE_NEXTMAP", undefined, GetMapName(level.winnermap));
		setDvar("sv_maprotation","gametype " + level.gametype + " map " + level.winnermap);
		setDvar("sv_maprotationcurrent", "gametype " + level.gametype + " map " + level.winnermap);
	}
	
	if(!isDefined(level.winnerevent))
		setDvar("scr_mod_ktk_gameevent", "none");
	else
	{
		scr_iPrintLnBold("EVENT", undefined, getEventName(level.winnerevent));
		setDvar("scr_mod_ktk_gameevent", level.winnerevent);
		
		//thread maps\mp\gametypes\ktk::execConfig(0, "config/events/" + level.winnerevent + ".cfg", "Loading event config: " + level.winnerevent);
	}
	
	wait 2;
}

//=====================
//Menu based mapvote
//=====================
castVote(response)
{
	if(game["state"] != "postgame")
		return;

	vote = getSubStr(response, (response.size - 1), response.size);
	vote = int(vote);

	if(!isDefined(self.hasVotedMap))
		self.hasVotedMap = vote;
	else
	{
		level.point_map[self.hasVotedMap]--;
		self.hasVotedMap = vote;
	}
		
	level.point_map[vote]++;
	
	thread UpdateWinningMap();
}

UpdateWinningMap()
{
	self notify("update_winnermap_only_once");
	self endon("update_winnermap_only_once");

	count = 0;
	winnername = "";
	winner = undefined;
	
	for(i=0;i<level.map.size;i++)
	{
		if(level.point_map[i] > count)
		{
			count = level.point_map[i];
			winnername = level.mapname[i];
			winner = level.map[i];
		}
	}
	
	setDvar("sv_maprotation","gametype " + level.gametype + " map " + winner);
	setDvar("sv_maprotationcurrent", "gametype " + level.gametype + " map " + winner);
	
	scr_iPrintlnBold("MAPVOTE_NEXTMAP", undefined, winnername + " (" + count + "x)");
	
	for(j=0;j<level.players.size;j++)
		level.players[j] setClientDvar("scr_mapvote_winner", "Next map: " + winnername + " (" + count + " votes)");
}

sendVoteableMapsToPlayer()
{
	for(i=0;i<level.mapname.size;i++)
	{
		for(j=0;j<level.players.size;j++)
		{
			level.players[j] setClientDvars("scr_mapvote_map" + (i+1), level.mapname[i] + level.botsupport[i],
											"scr_mapvote_winner", "Next map: Random (no votes yet)");
		}
	}
	
	//port the player to the mp_global_intermission - we have removed that part fomr globallogic because it blocks menuresponses
	spawnpoints = getentarray("mp_global_intermission", "classname");
	
	for(i=0;i<level.players.size;i++)
		level.players[i] thread fakeIntermission(spawnPoints[0]);
}

fakeIntermission(spawnPoint)
{
	self endon("disconnect");

	self waittill("reset_outcome");
	
	self takeAllWeapons();
	self setOrigin(spawnPoint.origin);
	self setPlayerAngles(spawnPoint.angles);
	self linkTo(spawnPoint);
	self setDepthOfField( 0, 128, 512, 4000, 6, 1.8 );
	
	//self.sessionstate = "intermission";
}

updateFavouritMapsList(winner)
{
	level.ktk_favouritMaps_logfile = "ktk_favourit_maps.log";

	//collect the informations from previous cycles
	if(fs_testFile(level.ktk_favouritMaps_logfile))
	{
		file = openFile(level.ktk_favouritMaps_logfile, "read");
		
		if(file > 0)
		{
			level.currentFavouritMaps = [];
			while(1)
			{
				value = fReadLn(file);
				
				if(!isDefined(value) || value == "" || value == " ")
					break;
				
				value = strToK(value, ";");
			
				newEntry = level.currentFavouritMaps.size;
				level.currentFavouritMaps[newEntry] = spawnStruct();
				level.currentFavouritMaps[newEntry].map = value[0];
				level.currentFavouritMaps[newEntry].cycles = int(value[1]);
				level.currentFavouritMaps[newEntry].waypoints = int(value[2]);
			}
		
			closeFile(file);
		}
	}

	if(!isDefined(level.currentFavouritMaps) || !level.currentFavouritMaps.size)
	{
		level.currentFavouritMaps[0] = spawnStruct();
		level.currentFavouritMaps[0].map = winner;
		level.currentFavouritMaps[0].cycles = 0;
		level.currentFavouritMaps[0].waypoints = 0;
	}
	
	winnerIsInsideFile = false;
	//check if the current mapvote winner is inside the collected data
	for(i=0;i<level.currentFavouritMaps.size;i++)
	{
		if(level.currentFavouritMaps[i].map == winner)
		{
			level.currentFavouritMaps[i].cycles++;
			winnerIsInsideFile = true;
			break;
		}
	}

	if(!winnerIsInsideFile)
	{
		newEntry = level.currentFavouritMaps.size;
		level.currentFavouritMaps[newEntry] = spawnStruct();
		level.currentFavouritMaps[newEntry].map = winner;
		level.currentFavouritMaps[newEntry].cycles = 1;
		level.currentFavouritMaps[newEntry].waypoints = 0;
	}
	
	level.currentFavouritMaps = sortResults(level.currentFavouritMaps, undefined, "descending");
	
	//save the updated list into a file - overwrite if the file exists
	file = openFile(level.ktk_favouritMaps_logfile, "write");
		
	if(file > 0)
	{
		for(i=0;i<level.currentFavouritMaps.size;i++)
		{
			ResetTimeout();
		
			hasWaypoints = fs_testFile("waypoints\\" + level.currentFavouritMaps[i].map + "_waypoints.gsc");
			if(!hasWaypoints) hasWaypoints = fs_testFile("waypoints\\" + level.currentFavouritMaps[i].map + "_waypoints.gsx");

			level.currentFavouritMaps[i].waypoints = hasWaypoints;

			fPrintLn(file, level.currentFavouritMaps[i].map + ";" + level.currentFavouritMaps[i].cycles + ";" + level.currentFavouritMaps[i].waypoints);
			
		}

		closeFile(file);
	}
}

sortResults(array, max, sorting)
{
	if(!isDefined(max))
		max = array.size;
		
	if(!isDefined(sorting))
		sorting = "ascending";

	index = [];
	value = [];
	
	for(i=0;i<array.size;i++)
	{
		index[index.size] = i;
		value[value.size] = array[i].cycles;
	}
	
	while(1)
	{
		change = false;
		
		for(i=0;i<value.size-1;i++)
		{
			if(sorting == "ascending")
			{
				if(value[i] <= value[i+1])
					continue;
			}
			else
			{
				if(value[i] >= value[i+1])
					continue;
			}

			change = true;
			temp = value[i];
			value[i] = value[i+1];
			value[i+1] = temp;
			temp = index[i];
			index[i] = index[i+1];
			index[i+1] = temp;
		}
		
		if(!change)
			break;
	}
	
	newArray = [];
	if(max > value.size)
		max = value.size;
	
	for(i=0;i<max;i++)
		newArray[i] = array[index[i]];
	
	return newArray;
}