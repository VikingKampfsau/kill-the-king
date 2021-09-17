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
	if(getDvar("scr_mod_antiglitch") == "") setDvar("scr_mod_antiglitch", 1);
	if(getDvar("scr_mod_antiglitch_punish") == "") setDvar("scr_mod_antiglitch_punish", 3);

	thread ActiveBlockers();
	
	level.allowedGlitching = getDvarInt("scr_mod_antiglitch_punish");
	
	if(getDvarInt("scr_mod_antiglitch") > 0)
	{
		thread SpawnTriggers();
		thread SpawnBulletTraces();
	}
}

ActiveBlockers()
{
	level.blockers = [];
	level.blockers = maps\_antiglitchPositions::initBlockers();

	if(!isDefined(level.blockers) || level.blockers.size == 0)
		return;
	
	for(i=0; i<level.blockers.size; i++)
		level.blockers[i] setContents(1);
}

SpawnTriggers()
{
	level.glitchtriggers = [];
	level.glitchtriggers = maps\_antiglitchPositions::initGlitchTriggers();

	if(!isDefined(level.glitchtriggers) || level.glitchtriggers.size == 0)
		return;
	
	for(i=0; i<level.glitchtriggers.size; i++)
	{
		if(getDvarInt("scr_mod_antiglitch") == 1)
			level.glitchtriggers[i] makeSolid();
		else
			level.glitchtriggers[i] thread OnTriggering();
	}
}

OnTriggering()
{
	if(getDvarInt("scr_devtool") && level.gametype != "ktk")
		return;

	spawnPoints = getentarray("mp_tdm_spawn", "classname");

	while(1)
	{
		self waittill("trigger", player);

		if(player isInParachute() || player isInAC130() || player isInMannedHelicopterTurret() || player isInRCToy())
			continue;
		
		scr_iPrintlnBold( "NO_GLITCH", player, undefined );
		
		if(getDvarInt("scr_mod_antiglitch") == 1)
		{
			player thread bouncePlayer((player.origin - self.origin), int(length(player getVelocity())));
			continue;
		}
		
		if(getDvarInt("scr_mod_antiglitch") == 2)
		{
			if(!isDefined(player.pers["glitched"]))
				player.pers["glitched"] = 1;
			else
				player.pers["glitched"]++;
		
			if(isDefined(level.allowedGlitching) && player.pers["glitched"] > level.allowedGlitching)
				player suicide();
			else
			{
				spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );
				player setOrigin(spawnPoint.origin);
				player ShellShock( "frag_grenade_mp", 1 );
			}
			continue;
		}
		
		if(getDvarInt("scr_mod_antiglitch") == 3)
			player suicide();
	}
}

SpawnBulletTraces()
{
	level.glitchtrace = [];
	level.glitchtrace = maps\_antiglitchPositions::initGlitchLasers();

	if(!isDefined(level.glitchtrace) || level.glitchtrace.size == 0)
		return;

	if(getDvarInt("scr_devtool") && level.gametype != "ktk")
		return;
	spawnPoints = getentarray("mp_tdm_spawn", "classname");
	
	while(1)
	{
		for(i=0;i<level.glitchtrace.size;i++)
		{
			if(!BulletTracePassed(level.glitchtrace[i].origin, level.glitchtrace[i].end.origin, true, undefined))
			{
				trace = BulletTrace(level.glitchtrace[i].origin, level.glitchtrace[i].end.origin, true, undefined);
			
				if(!isDefined(trace["entity"]) || !isPlayer(trace["entity"]))
					continue;
			
				scr_iPrintlnBold( "NO_GLITCH", trace["entity"], undefined );

				if(getDvarInt("scr_mod_antiglitch") <= 2)
				{
					spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );
					trace["entity"] setOrigin(spawnPoint.origin);
					trace["entity"] ShellShock( "frag_grenade_mp", 1 );
				}
				else
					trace["entity"] suicide();
			}
		}
	wait .05;
	}
}

makeSolid()
{
	//this also makes exp arrows and throwing knives stuck in air
	//self setContents(1);
	
	self thread OnTriggering();
}