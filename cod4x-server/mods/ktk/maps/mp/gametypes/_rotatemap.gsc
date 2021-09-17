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
	if(getdvar("scr_mod_empty_time") == "" ) setDvar("scr_mod_empty_time", 5);

	level.serverEmptyMapSwitch = undefined;

	if(getdvarint("scr_mod_empty_time") > 0)
	{
		emptytime = 0;
		switchtime = int(getdvarint("scr_mod_empty_time"));
		
		thread SwitchEmptyMap(emptytime, switchtime);
	}
}

SwitchEmptyMap(emptytime, switchtime)
{
	while(emptytime < switchtime)
	{
		wait 60;

		if(isDefined(level.ktkPlayers) && level.ktkPlayers.size > 0)
			emptytime = 0;
		else
			emptytime++;
	}

	rotation = undefined;
	if(getDvarInt("scr_mod_mapvote") > 0)
	{
		if(getDvar("rotation_few_players") != "")
			rotation = strTok(getDvar("rotation_few_players"), ";");
		else
		{
			if(getDvar("rotation") != "")
				rotation = strTok(getDvar("rotation"), ";");
		}

		if(isDefined(rotation) && rotation.size > 0)
		{
			botrotation = [];
			for(i=0;i<rotation.size;i++)
			{
				hasWaypoints = fs_testFile("waypoints\\" + rotation[i] + "_waypoints.gsc");
				if(!hasWaypoints) hasWaypoints = fs_testFile("waypoints\\" + rotation[i] + "_waypoints.gsx");
			
				if(hasWaypoints)	
					botrotation[botrotation.size] = rotation[i];
			}
		
			if(isDefined(botrotation) && botrotation.size > 0)
				randomMap = botrotation[randomInt(botrotation.size)];
			else
				randomMap = rotation[randomInt(rotation.size)];
		
			level.serverEmptyMapSwitch = true;

			setDvar("sv_maprotation","gametype " + level.gametype + " map " + randomMap);
			setDvar("sv_maprotationcurrent", "gametype " + level.gametype + " map " + randomMap);
		}
	}
	else
	{
		rotation = strTok(getDvar("sv_maprotation"), " ");
		
		for(i=0;i<3;i++)
		{
			if(!isDefined(rotation) || rotation.size <= 0)
				break;
		
			if(i == 0)
				rotation = removeElementFromArray(rotation, "gametype");
			else if(i == 1)
				rotation = removeElementFromArray(rotation, level.gametype);
			else if(i == 2)
				rotation = removeElementFromArray(rotation, "map");
		}
		
		if(isDefined(rotation) && rotation.size > 0)
		{
			randomMap = rotation[randomInt(rotation.size)];

			setDvar("sv_maprotation","gametype " + level.gametype + " map " + randomMap);
			setDvar("sv_maprotationcurrent", "gametype " + level.gametype + " map " + randomMap);
		}
	}
	
	maps\mp\gametypes\_bots::updatePezbotMapList();
	
	//reset the event before switching the map
	setDvar("admin_changeEvent", "none");
	wait 2;
	
	exitLevel(false);
}