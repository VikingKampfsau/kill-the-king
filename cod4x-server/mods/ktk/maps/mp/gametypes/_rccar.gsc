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
/*	Yea yea blame me for the shitty controls of the car, but im fking to lazy
	to make the controls menubased */

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_misc;

init()
{
	PrecacheShellShock("rccar");

	if(getDvar("scr_mod_rccar_health") == "") setDvar("scr_mod_rccar_health", 100);
	if(getDvar("scr_mod_rccar_alivetime") == "") setDvar("scr_mod_rccar_alivetime", 30);

	if(getDvarInt("scr_mod_rccar_health") < 1) setDvar("scr_mod_rccar_health", 1);
	if(getDvarInt("scr_mod_rccar_alivetime") < 1) setDvar("scr_mod_rccar_alivetime", 1);

	level.rccarAlivetime = getDvarInt("scr_mod_rccar_alivetime");
	
	level._effect["blinking_red"] = LoadFX( "misc/light_c4_blink" );
	level._effect["rc_car_explosion"] = LoadFX( "explosions/aa_explosion" );
}

SpawnCar()
{
	self endon("disconnect");
	self endon("death");
	
	self.rc_car = spawn("script_model", self.origin);
	self.rc_car setModel("rccar");
	self.rc_car setCanDamage(true);
	self.rc_car.angles = (self.angles[0],self.angles[1],0);
	self.rc_car.health = getDvarInt("scr_mod_rccar_health");
	self.rc_car.targetname = "vehicle_rccar";

	self.rc_car thread attachOwner(self);
	self.rc_car thread AliveTime(self);
	self.rc_car thread CheckDamage(self);
	self.rc_car PlayLoopSound("rccar_driving");

	self thread Horn();
	self thread CheckClimbing(self.rc_car);
	self thread OnPlayerDeath();
	self thread OnPlayerDisconnect();
	self thread onRoundEnd();
	
	self thread maps\mp\gametypes\_huds::HardpointLiveTimeHud(level.ktkWeapon["rccar"], level.rccarAlivetime, self.rc_car);
	
	while(isAlive(self) && self isInRCCar())
	{
		wait .05;

		if(self AttackButtonPressed())
		{
			self.rc_car thread Explode(self);
			break;
		}
	}
}

Horn()
{
	self endon("disconnect");
	self endon("death");

	self.rc_car.horn = spawn("script_model", self.rc_car.origin);
	self.rc_car.horn linkto(self.rc_car);
	
	while(isDefined(self.rc_car) && isDefined(self.rc_car.horn))
	{
		wait .05;

		if(self FragButtonPressed())
		{
			if(isDefined(self.rc_car.horn))
				self.rc_car.horn PlaySound("rccar_horn");

			while(self FragButtonPressed())
				wait .1;
		}
	}
}

attachOwner(owner)
{
	owner.oldstance = owner getStance();
	owner.oldorigin = owner.origin;
	owner.oldangles = owner.angles;
	owner.oldhealth = owner.health;
	owner.godmode = true;

	owner setClientDvars("cg_thirdperson", 1,
						"cg_thirdpersonrange", 180);
	
	owner SetOrigin(self.origin);
	owner SetMoveSpeedScale(1.75);
	owner AllowSprint(false);
	owner AllowJump(false);
	owner TakeWeapon(level.ktkWeapon["rccar"]);
	owner GetInventory();
	owner DetachAll();
	owner setModel("fake_player"); //owner hide();
	owner TakeAllWeapons();
	owner shellShock("rccar", level.rccarAlivetime);
	self linkto(owner);
}

CheckDamage(owner)
{
	self endon("rccar_exploded");

	while(1)
	{
		self waittill("damage", amount, attacker);

		if(isDefined(attacker) && isPlayer(attacker))
		{
			if(isDefined(owner) && attacker isInSameTeamAs(owner))
				continue;
			
			attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback( false );
		}

		self.health -= amount;
		
		if(self.health <= 0)
		{
			self thread Explode(owner);
			break;
		}
	}
}

AliveTime(owner)
{
	self endon("rccar_exploded");
	self endon("death");

	alivetime = level.rccarAlivetime;
	
	for(i=0;i<alivetime;i++)
	{
		wait 1;
		PlayFxonTag( level._effect["blinking_red"], self, "tag_ant" );
	}
	self thread Explode(owner);
}

Explode(owner)
{
	if(!isDefined(self))
		return;

	self notify("rccar_exploded");
	self StopLoopSound("rccar_driving");
	self.horn StopLoopSound("rccar_horn");
	self unlink();

	if(!isDefined(owner))
		self RadiusDamage(self.origin, 0, 0, 0);
	else
	{
		if(owner getKtkStat(2377) > 0)
			self RadiusDamage(owner.origin, 255, 375, 100, owner, "MOD_EXPLOSIVE", level.ktkWeapon["rccar"]);
		else
			self RadiusDamage(owner.origin, 255, 300, 80, owner, "MOD_EXPLOSIVE", level.ktkWeapon["rccar"]);
	}

	self PlaySound("detpack_explo_main");
	PlayFX(level._effect["rc_car_explosion"], self.origin);

	wait .1;
	
	if(isDefined(owner) && isPlayer(owner) && isAlive(owner))
	{
		if(!isDefined(owner.pers["thirdperson"]) || !owner.pers["thirdperson"]) 
			owner setclientdvars("cg_thirdperson", 0, "cg_thirdpersonrange", 120);
		else
			owner setclientdvar("cg_thirdpersonrange", 120);	
		
		owner.godmode = false;
		owner ReturnToOldPosition();
		owner thread ReturnStance();
		owner SetMoveSpeedScale(1);
		owner AllowSprint(true);
		owner AllowJump(true);
		owner StopShellShock();
		
		if(owner isKing() || owner isTerminator())
			owner maps\mp\gametypes\_bossmodels::SetBossModel();
		else
			owner maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //owner show();
		
		owner GiveInventory();
		owner SwitchToPreviousWeapon();
		owner EnableWeapons();
	}

	if(isDefined(self))
		self delete();
}

OnPlayerDeath()
{
	self waittill_any("death", "end_respawn"); //("death", "joined_team", "joined_spectators");

	if(isDefined(self.rc_car))
		self.rc_car thread Explode(self);
	else
	{
		self SetMoveSpeedScale(1);
		self AllowSprint(true);
		self AllowJump(true);

		if(!self.pers["thirdperson"])
			self setclientdvars("cg_thirdperson", 0, "cg_thirdpersonrange", 120);
		else
			self setclientdvar("cg_thirdpersonrange", 120);
	}
}

OnPlayerDisconnect()
{
	self endon("death");
	self waittill("disconnect");

	if(isDefined(self) && isDefined(self.rc_car))
		self.rc_car delete();
}

onRoundEnd()
{
	self endon("disconnect");
	self endon("death");

	while(level.roundstarted)
		wait 1;

	if(self isKing() || self isTerminator())
		self maps\mp\gametypes\_bossmodels::SetBossModel();
	else
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();
		
	if(isDefined(self.rc_car))
		self.rc_car delete();
	
	if(!isDefined(self.pers["thirdperson"]) || !self.pers["thirdperson"])
		self setclientdvars("cg_thirdperson", 0, "cg_thirdpersonrange", 120);
	else
		self setclientdvar("cg_thirdpersonrange", 120);
}