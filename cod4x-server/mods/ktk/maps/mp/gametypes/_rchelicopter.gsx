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
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_misc;

init()
{
	level.rc_heli_speed = 80;
	level.rc_heli_firerate = 0.1;
	level.rc_heli_nearGoalDist = 150;
	
	if(getDvar("scr_hardpoint_rc_heli_ammo") == "" || getDvarInt("scr_hardpoint_rc_heli_ammo") <= 0) setDvar("scr_hardpoint_rc_heli_ammo", 100);
	if(getDvar("scr_hardpoint_rc_heli_health") == "" || getDvarInt("scr_hardpoint_rc_heli_health") <= 0) setDvar("scr_hardpoint_rc_heli_health", 100);
	if(getDvar("scr_hardpoint_rc_heli_alivetime") == "" || getDvarInt("scr_hardpoint_rc_heli_alivetime") <= 0) setDvar("scr_hardpoint_rc_heli_alivetime", 10);
	if(getDvar("scr_hardpoint_rc_heli_reloadtime") == "" || getDvarInt("scr_hardpoint_rc_heli_reloadtime") <= 0.1) setDvar("scr_hardpoint_rc_heli_reloadtime", 1);
	
	level.rc_heli_ammo = getDvarInt("scr_hardpoint_rc_heli_ammo");
	level.rc_heli_health = getDvarInt("scr_hardpoint_rc_heli_health");
	level.rc_heli_alivetime = getDvarInt("scr_hardpoint_rc_heli_alivetime");
	level.rc_heli_reloadtime = getDvarInt("scr_hardpoint_rc_heli_reloadtime");
}

SpawnRCHelicopter()
{
	self endon("disconnect");
	self endon("death");

	self.rc_heli = spawnHelicopter(self, self getTagOrigin("j_head"), (0, self getPlayerAngles()[1], 0), "cobra_mp", "rchelicopter");
	self.rc_heli.rcHealth = level.rc_heli_health;
	self.rc_heli.health = 999999;
	self.rc_heli.takenDamage = 0;
	self.rc_heli.targetPos = self.rc_heli.origin;
	self.rc_heli.ammo = level.rc_heli_ammo;
	self.rc_heli.attacking = false;
	self.rc_heli.shotsFired = 0;
	self.rc_heli.owner = self;
	self.rc_heli.targetname = "vehicle_rcheli";

	self.rc_heli setneargoalnotifydist(level.rc_heli_nearGoalDist);
	self.rc_heli setyawspeed(150, 90, 90);
	self.rc_heli playLoopSound("mp_cobra_helicopter");
	
	self thread OnPlayerDeath();
	self thread OnPlayerDisconnect();
	self thread onRoundEnd();
	
	self thread maps\mp\gametypes\_huds::HardpointLiveTimeHud(level.ktkWeapon["rccar"], level.rc_heli_alivetime, self.rc_heli);
	
	self.rc_heli thread attachOwner();
	self.rc_heli thread monitorHealth();
	self.rc_heli thread monitorPlayerTouch();
	self.rc_heli thread rcHeliFly();
	self.rc_heli thread aliveTime();
	
	while(isDefined(self.rc_heli) && isAlive(self))
	{
		wait .1;
		
		if(!isDefined(self.rc_heli) || !isAlive(self))
			break;
		
		self.rc_heli.desiredTargetPos = self.rc_heli.targetPos;
		self.rc_heli.flyAngles = (0, self.rc_heli.angles[1], self.rc_heli.angles[2]);
		
		//if(self useButtonPressed())
		if(self forwardButtonPressed())
			self.rc_heli.desiredTargetPos = self.rc_heli.origin + AnglesToForward(self.rc_heli.flyAngles)*level.rc_heli_speed;

		//if(self fragButtonPressed())
		if(self leanleftButtonPressed())
		{
			//if(self useButtonPressed())
			if(self forwardButtonPressed())
				self.rc_heli.desiredTargetPos -= (0,0,30);
			else
				self.rc_heli.desiredTargetPos -= (0,0,10);
		}
			
		//if(self secondaryOffhandButtonPressed())
		if(self leanrightButtonPressed())
		{
			//if(self useButtonPressed())
			if(self forwardButtonPressed())
				self.rc_heli.desiredTargetPos += (0,0,30);
			else
				self.rc_heli.desiredTargetPos += (0,0,10);
		}
		
		if(self attackButtonPressed())
			self.rc_heli thread rcHeliAttack();

		self.rc_heli.pathCalc = PhysicsTrace(self.rc_heli.origin, self.rc_heli.desiredTargetPos);
		if(self.rc_heli.pathCalc == self.rc_heli.desiredTargetPos)
			self.rc_heli.targetPos = self.rc_heli.desiredTargetPos;
		else
		{
			//if(!self useButtonPressed())
			//if(!self forwardButtonPressed())
			{
				if(self.rc_heli.desiredTargetPos[2] < self.rc_heli.pathCalc[2])
					self.rc_heli.targetPos += (0,0,20);
				else if(self.rc_heli.desiredTargetPos[2] > self.rc_heli.pathCalc[2])
					self.rc_heli.targetPos -= (0,0,5);
			}
		}
	}
}

attachOwner()
{
	self endon("death");
	self endon("rc_heli_explode");

	self.owner.oldstance = self.owner getStance();
	self.owner.oldorigin = self.owner.origin;
	self.owner.oldangles = self.owner.angles;
	self.owner.oldhealth = self.owner.health;
	self.owner.godmode = true;

	self.owner SetOrigin(self.origin - (0,0,20));
	self.owner TakeWeapon(level.ktkWeapon["rccar"]);
	self.owner GetInventory();
	self.owner DetachAll();
	self.owner setModel("fake_player"); //self.owner hide();
	self.owner TakeAllWeapons();
	
	self.owner SetClientDvars("cg_drawgun", 0,
						"cg_fovScale", 0.35,
						"cg_thirdperson", 1,
						"cg_thirdpersonrange", 300);
	
	self.owner thread maps\mp\gametypes\_huds::Crosshair();
	
	self.attachPos = spawn("script_origin", self.origin);
	self.attachPos linkTo(self);
	self.owner linkTo(self.attachPos);
}

aliveTime()
{
	self endon("death");
	self endon("rc_heli_explode");

	aliveTime = level.rc_heli_alivetime;
	while(aliveTime >= 0)
	{
		aliveTime -= 0.1;
		wait .1;
	}
		
	self thread Explode();
}

rcHeliAttack()
{
	self endon("death");
	self endon("rc_heli_explode");
	
	if(self.attacking)
		return;
	
	self.attacking = true;
	self thread monitorReload();

	while(isDefined(self) && isDefined(self.owner) && self.owner attackButtonPressed())
	{
		wait level.rc_heli_firerate;

		if(!isDefined(self) || !isDefined(self.owner))
			break;
		
		if(self.shotsFired >= self.ammo)
			continue;
		
		self.shotsFired++;

		self playSound("weap_m197_cannon_fire");
		playFX(level._effect["heli_turret_flash"], self getTagOrigin("tag_flash"), AnglesToForward(self.angles));

		trace = BulletTrace(self.owner getEye(), self.owner getEye() + AnglesToForward(self.owner getPlayerAngles())*5000, true, self.owner);

		if(isDefined(trace["entity"]))
		{
			if(trace["entity"] == self)
				continue;
		
			if(!isPlayer(trace["entity"]))
			{
				//trace["entity"] notify("damage", 50, self.owner);//, VectorToAngles(trace["entity"].origin - self.origin), self.origin, "MOD_PROJECTILE");
				RadiusDamage(trace["entity"].origin, 2, 50, 50, self.owner, "MOD_PROJECTILE", "helicopter_mp");
			}
			else
			{
				self thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback( false );
			
				if(trace["entity"].pers["team"] != self.owner.pers["team"] && isAlive(trace["entity"]))
					trace["entity"] ktkFinishPlayerDamage(self, self.owner, 50, 0, "MOD_PROJECTILE", "helicopter_mp", self.origin, VectorToAngles(trace["entity"].origin - self.origin), "none", 0);
			}
		}
		
		if(isDefined(trace["position"]))
		{	
			//thread DrawDebugLine(self.owner getEye(), trace["position"], (1,0,0));
				
			if(isDefined(trace["surface"]) && trace["surface"] != "default")
				playFX(level.effect["turret_dirt_impact"], trace["position"]);
		}
	}
	
	self.attacking = false;
}

monitorReload()
{
	self endon("death");
	self endon("rc_heli_explode");
	
	self notify("rc_heli_reload");
	self endon("rc_heli_reload");
	
	while(self.shotsFired < self.ammo)
		wait .05;
	
	self thread reloadTurret();
}

reloadTurret()
{
	self endon("death");
	self endon("rc_heli_explode");
	
	//play reload sound
	//self playSound("");
	
	wait level.rc_heli_reloadtime;
	
	self.shotsFired = 0;
}

rcHeliFly()
{
	self endon("death");
	self endon("rc_heli_explode");
	
	while(1)
	{
		wait .05;
		
		if(!isDefined(self) || !isDefined(self.owner))
			break;
		
		self setgoalyaw(self.owner getPlayerAngles()[1]);
		
		if(isDefined(self.targetPos))//&& self.targetPos != self.origin)
		{
			self setspeed(30+randomInt(20), 15+randomInt(15));	
			self setvehgoalpos(self.targetPos, 1);

			self waittill("near_goal");
			//self waittillmatch("goal");			
		}
	}
	
	self thread Explode();
}

monitorHealth()
{
	self endon("rc_heli_explode");
	self endon("death");

	self.maxHealth = self.health;
	self.currentstate = "ok";
	self.laststate = "ok";
	self setdamagestage(3);
	
	while(1)
	{
		self waittill("damage", amount, attacker);

		if(isDefined(attacker) && isPlayer(attacker))
		{
			if(isDefined(self.owner) && attacker isInSameTeamAs(self.owner))
			{
				self.health = self.maxHealth;
				continue;
			}
			
			attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback( false );
		}

		self.takenDamage += amount;
		
		if(self.takenDamage >= self.rcHealth)
		{
			self thread Explode();
			break;
		}
		else
		{
			if(self.takenDamage >= int(self.rcHealth*1/3) && self.laststate != "heavy smoke")
			{
				self.currentstate = "heavy smoke";
				self setdamagestage(1);
				self notify("stop body smoke");
			}
			else
			{
				if(self.takenDamage >= int(self.rcHealth*2/3) && self.laststate != "light smoke")
				{
					self.currentstate = "light smoke";
					self setdamagestage(2);
				}
			}
			
			self.laststate = self.currentstate;
		}
	}
}

monitorPlayerTouch()
{
	self endon("rc_heli_explode");
	self endon("death");
	
	while(1)
	{
		wait .05;
		
		if(!isDefined(self) || !isDefined(self.owner))
			break;
		
		for(i=0;i<level.players.size;i++)
		{
			if(level.players[i] == self.owner)
				continue;
				
			if(level.players[i] isInSameTeamAs(self.owner))
				continue;
				
			if(isPlayer(level.players[i]) && isALive(level.players[i]))
			{
				if(level.players[i] isTouching(self))
					level.players[i] ktkFinishPlayerDamage(self, self.owner, level.players[i].health, 0, "MOD_PROJECTILE", "helicopter_mp", self.origin, VectorToAngles(level.players[i].origin - self.origin), "none", 0);
			}
		}
	}
}

Explode()
{
	if(!isDefined(self))
		return;

	self notify("rc_heli_explode");

	if(isDefined(self.owner) && isPlayer(self.owner) && isAlive(self.owner))
	{
		if(!isDefined(self.owner.pers["thirdperson"]) || !self.owner.pers["thirdperson"]) 
			self.owner setclientdvars("cg_thirdperson", 0, "cg_thirdpersonrange", 120, "cg_drawgun", 1, "cg_fovScale", 1 + (self.owner getKtkStat(2407)*0.001));
		else
			self.owner setclientdvars("cg_thirdpersonrange", 120, "cg_drawgun", 1, "cg_fovScale", 1 + (self.owner getKtkStat(2407)*0.001));	
		
		self.owner unlink();
		self.owner TakeAllWeapons();
		self.owner ReturnToOldPosition();
		self.owner thread ReturnStance();
		self.owner SetMoveSpeedScale(1);
		self.owner AllowSprint(true);
		self.owner AllowJump(true);
		self.owner StopShellShock();
		
		if(self.owner isKing() || self.owner isTerminator())
			self.owner maps\mp\gametypes\_bossmodels::SetBossModel();
		else
			self.owner maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self.owner show();
		
		self.owner GiveInventory();
		self.owner SwitchToPreviousWeapon();
		self.owner EnableWeapons();
	}
	
	if(!isDefined(self.owner))
		self RadiusDamage(self.origin, 0, 0, 0);
	else
	{
		if(self.owner getKtkStat(2377) > 0)
			self RadiusDamage(self.origin, 255, 375, 100, self.owner, "MOD_EXPLOSIVE", level.ktkWeapon["rccar"]);
		else
			self RadiusDamage(self.origin, 255, 300, 80, self.owner, "MOD_EXPLOSIVE", level.ktkWeapon["rccar"]);
	}

	self PlaySound("detpack_explo_main");
	PlayFX(level._effect["rc_heli_explode"], self.origin);

	wait .1;
	
	if(isDefined(self.attachPos))
		self.attachPos delete();
		
	if(isDefined(self))
		self delete();
	
	if(isDefined(self.owner))
	{
		self.owner.godmode = false;
		self.owner thread maps\mp\gametypes\_huds::Crosshair();
	}
}

OnPlayerDeath()
{
	self waittill_any("death", "end_respawn"); //("death", "joined_team", "joined_spectators");

	if(isDefined(self.rc_heli))
		self.rc_heli thread Explode();
	else
	{
		self SetMoveSpeedScale(1);
		self AllowSprint(true);
		self AllowJump(true);

		if(!self.pers["thirdperson"])
			self setclientdvars("cg_thirdperson", 0, "cg_thirdpersonrange", 120, "cg_drawgun", 1, "cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
		else
			self setclientdvars("cg_thirdpersonrange", 120, "cg_drawgun", 1, "cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
	}
}

OnPlayerDisconnect()
{
	self endon("death");
	self waittill("disconnect");

	if(isDefined(self) && isDefined(self.rc_heli))
		self.rc_heli delete();
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
		
	if(isDefined(self.rc_heli))
		self.rc_heli delete();
	
	if(!isDefined(self.pers["thirdperson"]) || !self.pers["thirdperson"])
		self setclientdvars("cg_thirdperson", 0, "cg_thirdpersonrange", 120, "cg_drawgun", 1, "cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
	else
		self setclientdvars("cg_thirdpersonrange", 120, "cg_drawgun", 1, "cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
}