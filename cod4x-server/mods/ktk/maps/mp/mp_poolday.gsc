#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main()
{
	precacheShader("black");
	precacheShader("white");

	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_poolday");
	
	ambientPlay("ambient_backlot_ext");
	
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1000");
	
	level._effect["PooldayWaterSplat"] = loadfx ("explosions/grenadeexp_water");
	
	thread initDrown();
	thread scripted_door();
	thread spawnSpringBoard();
}

scripted_door()
{
	doortrigger = getentarray("doortrig","targetname");
	
	for(i=0;i<doortrigger.size;i++)
		doortrigger [i] thread door_think();
}

door_think()
{
	self.doormoving = false;
	self.doorclosed = true;
	self.doormodel = getent(self.target, "targetname");

	while (1)
	{
		self waittill("trigger");
		
		if(!self.doormoving)
			self thread door_move();
	}
}

door_move()
{
	self.doormoving = true;
	
	if(self.doorclosed)
	{
		self.doormodel rotateyaw(-90, 1, 0.5, 0.5);
		self.doormodel waittill("rotatedone");
		self.doorclosed = false;
		
		self thread door_autoclose();
	}
	else
	{
		self.doormodel rotateyaw(90, 1, 0.5, 0.5);
		self.doormodel waittill("rotatedone");
		self.doorclosed = true;
	}
	
	self.doormoving = false;
}

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
door_autoclose()
{
	self endon("trigger");

	time = 5;
	while(time > 0)
	{
		wait 1;
		time--;
	}
	
	if(self.doorclosed)
		return;
		
	self notify("trigger");
}

//POOLDAY WATER FIX
//Completely recoded the drown script

initDrown()
{
	level.maxSwimTime = 8;
	level.barsize = 200;
	
	waterbrushes = getentArray("drown", "targetname");
	
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
		
		self.isOnSpringboard = false;
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
	
	if(self getEye()[2] >= -9) //water texture is at (about) (0,0,-9)
		return false;
	
	return true;
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

/*--------------------------------------------------------------------------|
|				 		  A little easter egg ;)						    |
|--------------------------------------------------------------------------*/
spawnSpringboard()
{
	
	springboard = spawn( "trigger_radius", (-1, -180, 21), 0, 10, 5 );
	
	while(isDefined(springboard))
	{
		springboard waittill("trigger", player);
		
		if(isAlive(player) && player.sessionstate == "playing" && !player isOnGround() && !player.isOnSpringboard)
			player thread bouncePlayer(springboard);
	}
}

bouncePlayer(springboard)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");

	self.isOnSpringboard = true;
	
	while(!self isOnGround())
		wait .05;
		
	if(self isTouching(springboard))
	{
		self iPrintLnBold("Yippieeeh!");

		power = int(self.maxhealth * 500);
		curHealth = self.health;
		self.health += power;

		self finishPlayerDamage(springboard, springboard, power, 0, "MOD_PROJECTILE", "none", springboard.origin, (0,0,1), "none", 0);

		self.health = curHealth;
	}

	self.isOnSpringboard = false;
}

doWaterSplat(trigger)
{
	self endon("disconnect");

	if(isDefined(self.doWaterSplat) && !self.doWaterSplat)
		return;
		
	self.doWaterSplat = false;
	
	self playsound("rocket_explode_water");
	playfx(level._effect["PooldayWaterSplat"], self.origin);
	
	while(self isTouching(trigger))
		wait .05;
		
	self.doWaterSplat = true;
}