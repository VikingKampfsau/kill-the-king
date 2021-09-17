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
#include maps\mp\gametypes\_misc;

init()
{
	//precacheItem("predator_mp");
	precacheShellshock("predator");
	precacheModel("projectile_hellfire_missile");

	level._effect["predatorexplosion"] = loadfx("explosions/tanker_explosion");
	level._effect["predatortrail"] = loadfx ("smoke/smoke_geotrail_hellfire");

	if(getDvar("scr_hardpoint_predator_time") == "") setDvar("scr_hardpoint_predator_time", 10);
	if(getDvar("scr_hardpoint_predator_speed") == "") setDvar("scr_hardpoint_predator_speed", 100);

	level.PredatorTime = getDvarInt("scr_hardpoint_predator_time");
	level.PredatorSpeed = getDvarInt("scr_hardpoint_predator_speed");
}

LaunchPredator()
{
	self endon("disconnect");
	self endon("death");

	self.godmode = true;
	self.oldorigin = self.origin;
	self.oldangles = self.angles;
	self.oldstance = self getStance();
	self.isatoldorigin = false;

	self setClientDvar("cg_thirdperson", 0);
	self ExecClientCommand("gocrouch");
	self TakeWeapon(level.ktkWeapon["predator"]);
	self GetInventory();
	self DetachAll();
	self setModel("fake_player"); //owner hide();
	self TakeAllWeapons();
	
	self.predator = spawn("script_model", self.origin + (0,0, GetSkyHeight()));
	self.predator.angles = self.angles + (90,0,0);
	self.predator.maxSpeed = 250;
	self.predator.speedup = 2;
	self.predator.speed = 0;
	self.predator setModel("projectile_hellfire_missile");
	self.predator hide();

	for(i=0;i<level.players.size;i++)
	{
		if(self != level.players[i])
			self.predator showToPlayer(level.players[i]);
	}
	
	self thread PredatorOverlay(level.PredatorTime);
	self thread OnOwnerTeamswitch(self.predator);
	self thread OnOwnerDisconnect(self.predator);
	self thread OnOwnerDeath(self.predator);
	self thread OnGameEnd(self.predator);
	self thread watchForTargetLock();
	self thread TargetMarkers();
	self thread Fired();
	
	self thread maps\mp\gametypes\_huds::HardpointLiveTimeHud(level.ktkWeapon["predator"], level.PredatorTime, self.predator);
}

PredatorOverlay(duration)
{
	self endon("disconnect");
	self endon("death");
	
	//sometimes no crosshair - so i redefine them
	if(isDefined(self.speed_up_hud)) self.speed_up_hud destroy();
	if(isDefined(self.Predator_Hud_BG)) self.Predator_Hud_BG destroy();
	if(isDefined(self.Predator_Hud_BG2)) self.Predator_Hud_BG2 destroy();
	if(isDefined(self.Predator_Hud_Cross)) self.Predator_Hud_Cross destroy();
	
	self.Predator_Hud_BG = newClientHudElem(self);
	self.Predator_Hud_BG.horzAlign = "fullscreen";
	self.Predator_Hud_BG.vertAlign = "fullscreen";
	self.Predator_Hud_BG setShader("white", 640, 480);
	self.Predator_Hud_BG.archive = true;
	self.Predator_Hud_BG.sort = 10;
	self.Predator_Hud_BG.alpha = 0.2;

	self.Predator_Hud_BG2 = newClientHudElem(self);
	self.Predator_Hud_BG2.horzAlign = "fullscreen";
	self.Predator_Hud_BG2.vertAlign = "fullscreen";
	self.Predator_Hud_BG2 setShader("ac130_overlay_grain", 640, 480);
	self.Predator_Hud_BG2.archive = true;
	self.Predator_Hud_BG2.sort = 20;
	self.Predator_Hud_BG2.alpha = 0.7;
	
	self.Predator_Hud_Cross = newClientHudElem( self );
	self.Predator_Hud_Cross.x = 0;
	self.Predator_Hud_Cross.y = 0;
	self.Predator_Hud_Cross.alignX = "center";
	self.Predator_Hud_Cross.alignY = "middle";
	self.Predator_Hud_Cross.horzAlign = "center";
	self.Predator_Hud_Cross.vertAlign = "middle";
	self.Predator_Hud_Cross.foreground = true;
	self.Predator_Hud_Cross setshader ("ac130_overlay_105mm", 640, 480);
	
	self.speed_up_hud = newClientHudElem( self );
	self.speed_up_hud.fontScale = 1.4;
	self.speed_up_hud.horzAlign = "center";
	self.speed_up_hud.vertAlign = "middle";
	self.speed_up_hud.alignX = "center";
	self.speed_up_hud.alignY = "middle";
	self.speed_up_hud.x = 0;
	self.speed_up_hud.y = 100;
	self.speed_up_hud.alpha = 0.75;
	self.speed_up_hud.sort = 1001;
	self.speed_up_hud.hidewheninmenu = false;
	self.speed_up_hud.label = self GetLocalizedString("HARDPOINT_PREDATOR_SPEEDUP"); //&"Press ^3[{+activate}] ^7to speed up.";

	wait(duration);
	
	self thread RemoveHud();
}

Fired()
{
	self endon("disconnect");
	self endon("death");

	self SetPlayerAngles(self.predator.angles);
	self SetOrigin(self.predator.origin);
	self LinkTo(self.predator, "tag_origin", (50,0,0), (0,0,0));
	self setclientDvar("player_view_pitch_up" , 0);
	
	self.predator thread ExplodeAfterTime(level.PredatorTime, self);
	
	PlayFxOnTag(level._effect["predatortrail"], self.predator, "tag_fx");
	Earthquake(1, 1, self.origin, 1000);
	
	while(isDefined(self.predator))
	{
		if(self.predator.speed < self.predator.maxSpeed)
			self.predator.speed += self.predator.speedup;

		forward = vectorNormalize(anglesToForward(self getPlayerAngles()));
		nextPos = self.predator.origin + forward * self.predator.speed;

		trace = BulletTrace(self.predator.origin, nextPos, false, self.predator);
		if(trace["fraction"] != 1 && trace["surfacetype"] != "default")
		{
			finalPos = trace["position"] - forward * 100;
			self.predator moveto(finalPos, 0.1);
			
			wait .1;
			
			self.predator thread Explode(self, finalPos);
			break;
		}
		
		self.predator moveTo(nextpos, 0.1);
		self.predator.angles = self getPlayerAngles();
	
	wait 0.1;   
	}
}

watchForTargetLock()
{
	self endon("disconnect");
	self endon("death");

	while(!self useButtonPressed())
		wait 0.05;

	if(isDefined(self.speed_up_hud)) 
		self.speed_up_hud destroy();
	
	if(isDefined(self.predator))
	{
		self.predator.maxSpeed = self.predator.maxSpeed*1.5;
		self.predator.speedup = 20;
	}
}

ExplodeAfterTime(delay, owner)
{
	self endon("death");
	
	wait delay;
	self Explode(owner, self.origin);
}

Explode(owner, location)
{
	if(!isDefined(self))
		return;

	if(!isDefined(owner))
		self RadiusDamage(self.origin, 450, 370, 150);
	else
	{
		if(owner getKtkStat(2377) > 0)
			self RadiusDamage(location, 500, 470, 150, owner, "MOD_EXPLOSIVE", level.ktkWeapon["predator"]);
		else
			self RadiusDamage(location, 450, 370, 150, owner, "MOD_EXPLOSIVE", level.ktkWeapon["predator"]);
	}	
	
	Earthquake(1.4, 1, location, 2000);
	PhysicsExplosionSphere(location, 400, 200, 3);
	PlayRumbleOnPosition("artillery_rumble", location);
	PlayFx(level._effect["predatorexplosion"], location, (location + (0,0,15 + randomint(120))) - location);
	self playSound("exp_suitcase_bomb_main");
	
	wait .1;
	
	owner thread DetachPlayer();
	
	if(isDefined(self))
		self delete();
}

DetachPlayer()
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(self.pers["thirdperson"]) && self.pers["thirdperson"]) 
		self setclientdvars("cg_thirdperson", 1, "player_view_pitch_up" , 85);
	else
		self SetClientDvar("player_view_pitch_up" , 85);
	
	if(self isKing() || self isTerminator())
		self maps\mp\gametypes\_bossmodels::SetBossModel();
	else
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();

	self.godmode = false;
	self.isatoldorigin = true;
		
	self unlink();
	self StopShellShock();
	self thread RemoveHud();
	self ReturnToOldPosition();
	self thread ReturnStance();
	self GiveInventory();
	self SwitchToPreviousWeapon();
	self EnableWeapons();
}

OnOwnerTeamswitch(predator)
{
	predator endon("death");
	self endon("disconnect");

	self waittill("end_respawn"); //_any("joined_team", "joined_spectators");

	predator Explode(self, predator.origin);
}

OnOwnerDeath(predator)
{
	predator endon("death");
	self endon("disconnect");
	self waittill("death");	

	predator Explode(self, predator.origin);
}

OnOwnerDisconnect(predator)
{
	predator endon("death");
	self endon("death");
	self waittill("disconnect");

	self thread RemoveHud();
	
	if(isDefined(self))
		self Unlink();
	
	if(isDefined(predator))
		predator delete();
}

OnGameEnd(predator)
{
	predator endon("death");
	self endon("disconnect");
	self endon("death");
	
	level waittill("game_ended");

	self thread RemoveHud();
	
	if(self isKing() || self isTerminator())
		self maps\mp\gametypes\_bossmodels::SetBossModel();
	else
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();

	predator Explode(self, predator.origin);
}

RemoveHud()
{
	self endon("disconnect");
	
	self thread DeleteTargetMarkers();
	
	if(isDefined(self.speed_up_hud)) self.speed_up_hud destroy();
	if(isDefined(self.Predator_Hud_BG)) self.Predator_Hud_BG destroy();
	if(isDefined(self.Predator_Hud_BG2)) self.Predator_Hud_BG2 destroy();
	if(isDefined(self.Predator_Hud_Cross)) self.Predator_Hud_Cross destroy();
}