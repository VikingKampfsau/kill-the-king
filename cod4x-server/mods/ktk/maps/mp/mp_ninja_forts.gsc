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
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_ninja_forts");
 
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
 
	setdvar( "r_specularcolorscale", "1" );
	setdvar("compassmaxrange","1600");
	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
	setDvar("bg_falldamagemaxheight", 300000 );
	setDvar("bg_falldamageminheight", 128000 );
	
	precacheShader("black");
	precacheShader("white");
	
	level._effect["FortsWaterSplat"] = loadfx ("explosions/grenadeexp_water");
	level.maxSwimTime = 8;
	level.barsize = 200;
	
	waterbrushes = getentArray("drown_water", "targetname");
	
	if(isDefined(waterbrushes) && waterbrushes.size > 0)
	{
		for(i=0;i<waterbrushes.size;i++)
			waterbrushes[i] thread waitForSwimmingPlayer();
	}
	
	if(getDvar("mp_ninja_forts_underwaterview") == "") setDvar("mp_ninja_forts_underwaterview", 0.5);
	if(getDvar("mp_ninja_forts_underwaterspeed") == "") setDvar("mp_ninja_forts_underwaterspeed", 0.85);
	
	while(1)
	{
		level waittill("connected", player);
		player thread onPlayerSpawn();
	}
}

onPlayerSpawn()
{
	self endon("disconnect");
	
	while(1)
	{
		self waittill("spawned_player");
		self thread onPlayerDeath();
		
		self.doWaterSplat = true;
		self.isDrowning = false;
		self.swimTime = 0;
	}	
}

onPlayerDeath()
{
	self endon("disconnect");
	self waittill("death");

	self thread removeWaterHud();
	
	if(isDefined(self.isDrowning) && self.isDrowning)
	{
		if(self.swimTime >= level.maxSwimTime)
		{
			switch(randomInt(3))
			{
				case 0: iPrintLn("Hey " + self.name + ", that's water, it kills."); break;
				case 1: iPrintLn(self.name + " swallowed Some Water"); break;
				default: iPrintLn(self.name + " drowned"); break;
			}
			
			self playSound("mdrown");
		}
	}
}

waitForSwimmingPlayer()
{
	self endon("death");
	
	while(1)
	{
		self waittill("trigger", player);
		
		player thread doWaterSplat(self);
		
		if(player isUnderWater(self) && (!isDefined(self.isDrowning) || !self.isDrowning))
			player thread startDrowning(self);
	}
}

startDrowning(trigger)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	
	self.isDrowning = true;
	self.swimTime = 0;
	
	self thread createWaterHud();
	self setMoveSpeedScale(getDvarFloat("mp_ninja_forts_underwaterspeed"));
	
	hits = 0;
	damage = 0;
	while(self isUnderWater(trigger) && self.swimTime <= level.maxSwimTime)
	{
		if(hits == 0)
	
		hits++;
		self.swimTime += 0.05;
		
		if(isAlive(self) && hits > 60)
		{
			damage = int(self.health/((level.maxSwimTime/0.05)-hits));
			
			if(isDefined(damage) && damage > 0)
				self FinishPlayerDamage(self, self, damage, 0, "MOD_SUICIDE", "none", self.origin, VectorToAngles(self.origin - self.origin), "none", 0);
		}

		wait .05;
	}

	if(self.swimTime > level.maxSwimTime)
		self suicide();
	
	self.isDrowning = false;
	self thread removeWaterHud();
	self setMoveSpeedScale(1);
}

isUnderWater(trigger)
{
	if(!self isTouching(trigger))
		return false;
	
	if(isDefined(trigger.watersurface))
	{
		if(self getEye()[2] >= trigger.watersurface)
			return false;
	}
	else
	{
		if(self getEye()[2] >= -50)
			return false;
	}

	return true;
}

doWaterSplat(trigger)
{
	self endon("disconnect");

	if(isDefined(self.doWaterSplat) && !self.doWaterSplat)
		return;
		
	self.doWaterSplat = false;
	
	self playsound("rocket_explode_water");
	playfx(level._effect["FortsWaterSplat"], self.origin);
	
	while(self isTouching(trigger))
		wait .05;
		
	self.doWaterSplat = true;
}

createWaterHud()
{
	self endon("disconnect");
	self endon("death");
	
	if(!isDefined(self.water_vision))
	{
		self.water_vision = newClientHudElem(self);
		self.water_vision.x = 0;
		self.water_vision.y = 0;
		self.water_vision setshader ("white", 640, 480);
		self.water_vision.alignX = "left";
		self.water_vision.alignY = "top";
		self.water_vision.horzAlign = "fullscreen";
		self.water_vision.vertAlign = "fullscreen";
		self.water_vision.color = (.16, .38, .5);
		self.water_vision.alpha = getDvarFloat("mp_ninja_forts_underwaterview");
	}
		
	if(!isDefined(self.water_progressbackground))
	{
		self.water_progressbackground = newClientHudElem(self);				
		self.water_progressbackground.alignX = "center";
		self.water_progressbackground.alignY = "middle";
		self.water_progressbackground.x = 320;
		self.water_progressbackground.y = 385;
		self.water_progressbackground.alpha = 0.5;
		self.water_progressbackground setShader("black", (level.barsize + 4), 14);
	}

	if(!isDefined(self.water_progressbar))
	{
		self.water_progressbar = newClientHudElem(self);				
		self.water_progressbar.alignX = "left";
		self.water_progressbar.alignY = "middle";
		self.water_progressbar.x = (320 - (level.barsize / 2.0));
		self.water_progressbar.y = 385;
		self.water_progressbar setShader("white", 0, 8);			
		self.water_progressbar scaleOverTime(level.maxSwimTime, level.barsize, 8);
	}
}

removeWaterHud()
{
	self endon("disconnect");

	if(isDefined(self.water_vision))
	{
		self.water_vision.alpha = .5;
		self.water_vision fadeOverTime(3);
		self.water_vision.alpha = 0;
		self.water_vision destroy();
	}

	if(isDefined(self.water_progressbackground))
		self.water_progressbackground destroy();
		
	if(isDefined(self.water_progressbar))
		self.water_progressbar destroy();
}