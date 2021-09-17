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
#include maps\mp\_utility;

init()
{
	if(!isDefined(level.timeLimit) || level.timeLimit == 0)
		return;

	level.effect["flak_smoke"] = loadfx("distortion/distortion_tank_muzzleflash");
	level.effect["flak_flash"] = loadfx("explosions/default_explosion");
	level.effect["flak_dust"] = loadfx("explosions/aa_explosion");
	level.plane["explode"] = loadfx("explosions/vehicle_explosion_bm21");

	if(getDvar("allow_skyeffect_plane") == "") setDvar("allow_skyeffect_plane", 1);
	if(getDvar("allow_skyeffect_flak") == "") setDvar("allow_skyeffect_flak", 1);
	
	if(getdvarint("allow_skyeffect_plane") == 1)
		thread Plane();

	if(getdvarint("allow_skyeffect_flak") == 1)
		thread Flak88();
}

Flak88()
{
	spawnPoints = getentarray("mp_tdm_spawn", "classname");
	
	while(1)
	{
		wait 1;
		
		for(i=0;1<RandomInt(5);i++)
		{
			wait RandomFloat(0.3);

			SpawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( spawnPoints );

			flak = Spawn("script_origin", SpawnPoint.origin + (randomint(1000), randomint(1000), 1200));
			flak thread PlayFlakFX();
		}
	}
}

PlayFlakFX()
{
	self endon("death");

	self playsound("elm_explosions_dist");
	playfx(level.effect["flak_flash"], self.origin);
	wait 0.25;
	playfx(level.effect["flak_smoke"], self.origin);
	wait 0.25;
	playfx(level.effect["flak_dust"], self.origin);
	wait 0.25;
	self delete();
}

Plane()
{
	while(1)
	{
		wait 5; //RandomIntRange(int(level.timeLimit*60*RandomFloatRange(0.1,0.7)), int(level.timeLimit*60*2));
	
		direction = (0,randomint(360),0);
		startPoint = (0,0,0) + vector_scale(anglestoforward(direction),-24000);
		startPoint += ( 0, 0, 1300);

		endPoint = (0,0,0) + vector_scale(anglestoforward(direction), 24000);
		endPoint += (0, 0, 1300);

		flyTime = length(startPoint-endPoint)/3000;

		pathStart = startPoint + ((randomfloat(2)-1)*100,(randomfloat(2)-1)*100, 0);
		pathEnd = endPoint + ((randomfloat(2)-1)*150, (randomfloat(2)-1)*150, 0);

		plane = spawn("script_model", pathStart);
		plane setModel("vehicle_mig29_desert");
		plane.angles = direction;
		
		plane thread playPlaneFx();

		if(RandomFloat(1) == 0.8)
		{
			plane moveTo(pathEnd, flyTime);
			wait flyTime;
			plane delete();
		}
		else
		{	
			CrashOrigin = pathStart + AnglesToForward(plane.angles)*RandomIntRange(int(length(pathStart, pathEnd)/4),int(length(pathStart, pathEnd)));
			flyTime = length(pathStart - CrashOrigin)/3000;
			
			plane moveTo(CrashOrigin, flyTime);
			wait flyTime;
			plane GoCrash();
		}
	}
}

playPlaneFx()
{
	self endon("death");

	self playLoopSound("veh_mig29_dist_loop");
	playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_right" );
	playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_left" );
	playfxontag( level.fx_airstrike_contrail, self, "tag_right_wingtip" );
	playfxontag( level.fx_airstrike_contrail, self, "tag_left_wingtip" );
}

GoCrash()
{
	self endon("death");

	trace = BulletTrace(self.origin, (self.origin[0], self.origin[1] + RandomIntRange(-500,500), level.mapCenter[2]) + AnglesToForward(self.angles)*RandomIntRange(1500,4000), false, self);
	flyTime = length(self.origin - trace["position"])/1800;
	
    PlayFX(level._effect["barrelExp"], self.origin);
	playfx(level.effect["flak_smoke"], self.origin);
	playfx(level.effect["flak_dust"], self.origin);
	self rotateTo(vectortoangles(vectornormalize(trace["position"] - self.origin)), flyTime/0.35);
	self moveTo(trace["position"], flyTime);

	wait flyTime;
	self PlaySound("hind_helicopter_crash");
	RadiusDamage(self.origin, 600, 1000, 5);
	playfx(level.plane["explode"], self.origin);
	self delete();
}