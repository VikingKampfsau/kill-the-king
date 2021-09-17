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

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_misc;

init()
{
	//precacheItem("nuke_mp");
	precacheShader("hud_icon_nuke");
	precacheShellshock("radiation_med");

	if(getDvar("scr_hardpoint_nukeTimer") == "") setDvar("scr_hardpoint_nukeTimer", 10);
	level.nukeTimer = getDvarInt("scr_hardpoint_nukeTimer");

	level._effect["nuke_explosion"] = loadFx("explosions/nuke_explosion");
	level._effect["nuke_flash"] = loadFx("explosions/nuke_flash");
	level._effect["nuke_dirt_shockwave"] = loadFx("explosions/nuke_dirt_shockwave");

	if(!isDefined(level.nuke_icon))
	{
		level.nuke_icon = newHudElem();
		level.nuke_icon.x = 20;
		level.nuke_icon.y = 390;
		level.nuke_icon setshader( "hud_icon_nuke", 30, 30 );
		level.nuke_icon.alignX = "left";
		level.nuke_icon.alignY = "top";
		level.nuke_icon.horzAlign = "left";
		level.nuke_icon.vertAlign = "top";
		level.nuke_icon.foreground = true;
		level.nuke_icon.hideWhenInMenu = true;
	}
	
	while(1)
	{
		level.nuke_icon.alpha = 0;

		level waittill("nuke_launched_now");
		
		level.nuke_icon.alpha = 1;

		level.nuke_timer = createServerTimer( "objective", 1.4 );
		level.nuke_timer setPoint( "TOP", "LEFT", 80, 160 );
		level.nuke_timer setTimer( level.nukeTimer );
		level.nuke_timer.color = (1,0.45,0);
		level.nuke_timer.sort = 1001;
		level.nuke_timer.foreground = true;
		level.nuke_timer.hideWhenInMenu = true;
			
		wait level.nukeTimer;

		level.nuke_timer destroyElem();
	}
}

LaunchNuke()
{
	level.NukeLaunched = true;

	for(i=0;i<level.players.size;i++)
		level.players[i] thread KilledByNuke(self, self.pers["team"]);
	
	wait 2.3;
	
	NukeTickSound = spawn("script_origin", (0,0,0));
	NukeTickSound thread playTickingSound();
	
	maps\mp\gametypes\_globallogic::pauseTimer();
	setGameEndTime(int(gettime() + (level.nukeTimer*1000)));
	
	wait level.nukeTimer;
	
	level.NukeLaunched = false;
	level.GameNuked = true;

	thread ExplosionEffects();

	NukeTickSound delete();	
	maps\mp\gametypes\_globallogic::resumeTimer();
	setGameEndTime(int(gettime() - (level.nukeTimer*1000)));
	
	visionSetNaked("mpnuke", 3);
	wait .25;
	visionSetNaked("mpnuke_aftermath", 5);
	wait 20;
	visionSetNaked(getDvar("mapname"), 10);
	level.GameNuked = false;
}

KilledByNuke(owner, team)
{
	self endon("disconnect");

	self PlayLocalSound("nuke_incoming");
	
	wait 2.3;
	wait level.nukeTimer;
	
	self playlocalsound("nuke_explosion");
	self ShellShock("radiation_med", 2.5);
	self thread maps\mp\gametypes\_vision::init();

	if(isDefined(owner) && owner == self)
		return;
	
	wait 2.5;

	//Only cause damage when the owner is a guard or is still in the team he called the nuke from
	if(isDefined(owner) && !self isInSameTeamAs(owner) && (owner isAGuard() || owner.pers["team"] == team))
	{
		self.NukeKilled = true;
	
		//kill the king last, so the owner kills the whole team
		if(self isKing())
			wait .1;
	
		if(isPlayer(self) && isAlive(self))
			self ktkFinishPlayerDamage(owner, owner, self.health, 0, "MOD_EXPLOSIVE", level.ktkWeapon["nuke"], self.origin, self.origin, "none", 0);
	}
	
	if(self isDog())
	{
		self setClientDvars("ammoCounterHide", 1,
							"cg_drawgun", 0,
							"cg_fovmin", 95);
	}
}

ExplosionEffects()
{
	AmbientStop(1);
	Earthquake(0.7, 5, (0,0,0), 99999999999);
	PlayFx(level._effect["nuke_flash"], level.MapCenter);
	
	wait 1;
	
	PlayFx(level._effect["nuke_explosion"], level.MapCenter);
	PlayFx(level._effect["nuke_dirt_shockwave"], level.MapCenter);
}

playTickingSound()
{
	self endon("death");
	level notify("nuke_launched_now");
	
	while(1)
	{
		self playSound("ui_mp_nuketimer");
		wait 1;
	}
}