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
#include maps\mp\_utility;
#include maps\mp\gametypes\_misc;

init()
{
	if(getDvar("scr_mod_parachutespawn") == "") setDvar("scr_mod_parachutespawn", 1);
	
	if(getDvarInt("scr_mod_parachutespawn") == 0) 
		return;

	level.chopper_seat = 130;
	level.parachute_glidetime = 6;
		
	while(1)
	{
		level waittill("connected", player);
		player thread onFirstSpawn();
	}
}

onFirstSpawn()
{
	self endon("disconnect");

	if(self isABot())
		return;
	
	self waittill("spawned_player");
	
	if(!isDefined(level.roundstarted) || !level.roundstarted)
		return;
		
	self thread check_spawnarea();
}

check_spawnarea()
{
	self endon("death");
	self endon("disconnect");

	trace = PlayerPhysicsTrace(self.origin, self.origin + (0, 0, 10000));
	
	if(Distance(self.origin, trace) < 2000)
		return;
	
	if(game["customEvent"] == "revolt")
		spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_NearTeamFlag(self.pers["team"]);
	else
		spawnPoint = self GetSpawnPoint();
	
	if(isDefined(spawnPoint))
	{
		if(VehicleCanSpawn() && VehicleUsage() <= 2)
			self thread SpawnBlackHawk(spawnPoint);
		else
			self diveIntoSpawn(spawnPoint);
	}
}

GetSpawnPoint()
{
	self endon("death");
	self endon("disconnect");
	
	spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(self.pers["team"]);
	dist = 99999999999;
	spawn = undefined;

	if(!isDefined(spawnPoints) || !spawnPoints.size)
		return undefined;
	
	for(i=0;i<spawnPoints.size;i++)
	{
		tempDist = distance(spawnPoints[i].origin, self.origin);
		if(tempDist < dist)
		{
			dist = tempDist;
			spawn = spawnPoints[i];
		}
	}
	return spawn;
}

diveIntoSpawn(spawnPoint)
{
	self endon("disconnect");
	self endon("death");

	self setOrigin(spawnPoint.origin);
	self SetPlayerAngles(spawnPoint.angles);
	wait .05;
	body = self clonePlayer(10000);
	wait .05;
	
	ent = spawn("script_model", (0,0,0));
	ent.origin = spawnPoint.origin + (0, 0, 5000);
	ent.angles = spawnPoint.angles + (90,0,0);
	
	self thread forcePlayerAnglesToEntAngles(ent);
	self setOrigin(ent.origin);
	self DisableWeapons();
	self linkTo(ent);

	wait .5;
	
	ent moveTo(spawnPoint.origin, 2, 0, 2);	
	self playLocalSound("ui_camera_whoosh_in");
	
	wait 1.6;

	ent rotateTo(spawnPoint.angles, 0.5, 0.3, 0.2);
	
	wait .6;
	
	self unlink();
	body delete();
	ent delete();
	
	self EnableWeapons();
}

forcePlayerAnglesToEntAngles(ent)
{
	self endon("disconnect");
	self endon("death");

	while(isDefined(ent))
	{
		self SetPlayerAngles(ent.angles);
		wait 0.05;
	}
}


SpawnBlackHawk(spawnPoint)
{
	self endon("death");
	self endon("disconnect");
	
	height = GetSkyHeight();
	Flypath = GetBlackHawkFlypath(spawnPoint, height);
	
	if(!isDefined(Flypath) || !isDefined(Flypath[0]) || !isDefined(Flypath[1]))
		return;
	
	chopper = spawnHelicopter( self, Flypath[0], vectortoangles(vectornormalize((spawnPoint.origin[0],spawnPoint.origin[1],height) - Flypath[0])), "blackhawk_mp", "vehicle_blackhawk" );
	chopper playLoopSound( "mp_cobra_helicopter" );
	chopper SetDamageStage(3);
	chopper setCanDamage(false);
	chopper thread CallBlackhawk((spawnPoint.origin[0],spawnPoint.origin[1],height), Flypath[1], self);
	chopper thread HeliCloseNades();
	
	self thread AttachPlayer(spawnPoint, chopper);
}

GetBlackHawkFlypath(spawnPoint, height)
{
	radius = 99999999999;
	start = undefined;
	end = undefined;
	path = [];
	
	for(i=0;i<360;i++)
	{
		start = BulletTrace((spawnPoint.origin[0],spawnPoint.origin[1],height), (spawnPoint.origin[0],spawnPoint.origin[1],height) + AnglesToForward((0,i,0))*radius, false, undefined);
		end = BulletTrace((spawnPoint.origin[0],spawnPoint.origin[1],height), (spawnPoint.origin[0],spawnPoint.origin[1],height) - AnglesToForward((0,i,0))*radius, false, undefined);

		if(BulletTracePassed(start["position"], end["position"], false, undefined))
			break;
	}
	
	if(isDefined(start["position"]) && isDefined(end["position"]))
	{
		path[0] = start["position"];
		path[1] = end["position"];
		return path;
	}
}

AttachPlayer(spawnPoint, chopper)
{
	self endon("death");
	self endon("disconnect");

	entity = spawn("script_model",chopper.origin - (5,0,level.chopper_seat));
	entity.angles = chopper.angles;
	entity linkto(chopper);	
	
	self.godmode = true;
	self DetachAll();
	self setModel("fake_player");
	self setOrigin(entity.origin);
	self linkto(entity);
	self DisableWeapons();
	
	self waittill("open_parachute");
	
	self unlink();
	entity delete();
	self thread parachute(spawnPoint);
	
	self thread maps\mp\gametypes\_teams::playerModelForWeapon(level.ktkWeapon["intervention"]);
}

CallBlackhawk(Start, Target, player)
{
	self clearTargetYaw();
	self clearGoalYaw();
	self setspeed( 80, 25 );	
	self setyawspeed( 75, 45, 45 );
	self setmaxpitchroll( 15, 15 );
	self setneargoalnotifydist( 200 );
	self setturningability( 0.9 );
	self setvehgoalpos( Start, 0 );

	self waittillmatch( "goal" );
	
	self setvehgoalpos( Target, 0 );
	player notify("open_parachute");
	
	self waittillmatch( "goal" );
	
	self stopLoopSound();
	self hide();
	wait .1;
	self delete();
}

parachute(spawnPoint)
{
	self endon("death");
	self endon("disconnect");

	parachute = spawn("script_model", (self.origin[0], self.origin[1], self.origin[2] + 55));
	parachute.angles = (0, 0, 180);
	parachute setModel("parachute");
	parachute thread DeleteAfterTime(level.parachute_glidetime);
	parachute moveTo((spawnPoint.origin[0], spawnPoint.origin[1], spawnPoint.origin[2] + 55), level.parachute_glidetime);

	self.godmode = true;
	self linkTo(parachute);
	self playlocalsound("parachute");

	timer = level.parachute_glidetime;
	while(timer > 0)
	{
		if(isDefined(self))
			parachute RotateTo((0,self.angles[1]-90,180), 0.8);
	
		timer -= .1;
		wait .1;
	}

	self.godmode = false;

	self EnableWeapons();
	self playlocalsound("parachute_landing");
	self unlink();
	self ShellShock("frag_grenade_mp", 1);
	
	if(getDvarInt("scr_mod_spawnprotection") == 1)
		self thread maps\mp\gametypes\_spawnprotection::Spawnprotection();
}

DeleteAfterTime(delay)
{
	self endon("death");

	wait delay;
	self hide();
	wait 1;
	self delete();
}