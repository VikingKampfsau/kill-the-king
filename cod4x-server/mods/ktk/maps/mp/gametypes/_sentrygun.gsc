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
#include common_scripts\utility;
#include maps\mp\gametypes\_misc;

init()
{
	precacheModel("sentry_gun");

	if(getDvar("scr_hardpoint_sentry_rotation") == "") setDvar("scr_hardpoint_sentry_rotation", 120);
	if(getDvar("scr_hardpoint_sentry_health") == "") setDvar("scr_hardpoint_sentry_health", 1000);
	if(getDvar("scr_hardpoint_sentry_aimdist") == "") setDvar("scr_hardpoint_sentry_aimdist", 3000);
	if(getDvar("scr_hardpoint_sentry_aimheight") == "") setDvar("scr_hardpoint_sentry_aimheight", 1000);
	if(getDvar("scr_hardpoint_sentry_firedelay") == "") setDvar("scr_hardpoint_sentry_firedelay", 0.05);
	if(getDvar("scr_hardpoint_sentry_maxamount") == "") setDvar("scr_hardpoint_sentry_maxamount", 5);
	if(getDvar("scr_hardpoint_sentry_time") == "") setDvar("scr_hardpoint_sentry_time", 0);

	level.SentryModel = "sentry_gun";								//model for the turret
	level.Sentrys = 0;												//current amount of turrets in map (don't change)
	level.SentryAimMinDist = 10;									//the position in front of the turret the targeting starts
	level.SentryRotation = getDvarInt("scr_hardpoint_sentry_rotation");		//max rotation angles (divide by 2 for each side)
	level.SentryHealth = getDvarInt("scr_hardpoint_sentry_health");			//health (melee is insta kill)
	level.SentryAimDist = getDvarInt("scr_hardpoint_sentry_aimdist");		//distance to detect enemies
	level.SentryAimHeight = getDvarInt("scr_hardpoint_sentry_aimheight");	//max height it can detect enemies in
	level.SentryFireDelay = getDvarInt("scr_hardpoint_sentry_firedelay");	//delay between 2 shots
	level.SentrysMax = getDvarInt("scr_hardpoint_sentry_maxamount");		//max amount of turrets in map
	level.SentryAliveTime = getDvarInt("scr_hardpoint_sentry_time");		//time the turret is active until self destruction

	level.SentryDetectionDot = cos(level.SentryRotation);
	
	if(level.SentryDetectionDot < 0)
		level.SentryDetectionDot *= -1;

	level._effect["sentry_flash"] = loadFx("muzzleflashes/saw_flash_wv");
	level._effect["sentry_shell"] = loadFx("shellejects/saw");
	level._effect["sentry_blood"] = loadFx("impacts/flesh_hit_body_fatal_exit");
	level._effect["sentry_explode"] = loadfx("explosions/grenadeExp_metal");

	precacheModel(level.SentryModel);
}

WaitForSentryDeploy(wasPickedUp, alivetime, takenDamage)
{
	self endon("disconnect");
	self endon("death");

	self thread OwnerEvents();
	
	if(!self isABot())
		self disableWeapons();

	self.SentryCarry = spawn("script_model", self.origin + (0,0,20) + AnglesToForward(self.angles)*50);
	self.SentryCarry.angles = (0, self.angles[1], self.angles[2]);
	self.SentryCarry linkTo(self);
	self.SentryCarry setModel(level.SentryModel);

	self.triesToPlantSentry = false;
	
	while(1)
	{
		if(isDefined(self.lowerMessage))
		{
			self.lowerMessage.label = self GetLocalizedString("HARDPOINT_SENTRY_PRESS_ATTACK"); //&"Press ^3[{+attack}] ^7to deploy the Sentry.";//&"KTK_SENTRY_PRESS_ATTACK";
			self.lowerMessage.alpha = 1;
			self.lowerMessage FadeOverTime(0.05);
			self.lowerMessage.alpha = 0;
		}

		if(self AttackButtonPressed())
		{
			if(self CanDeploy(wasPickedUp, alivetime, takenDamage))
			{
				if(isDefined(self.SentryCarry))
				{
					self.SentryCarry unlink();
					self.SentryCarry delete();
				}

				if(!self isABot())
					self enableWeapons();
				
				break;
			}

			while(self AttackButtonPressed())
				wait .05;
		}

	wait .05;
	}
}

//CanDeploy by Braxi
CanDeploy(wasPickedUp, alivetime, takenDamage)
{
	self endon("disconnect");
	self endon("death");

	if(isDefined(self.triesToPlantSentry) && self.triesToPlantSentry)
		return false;
	
	self.triesToPlantSentry = true;
	
	start = self.origin + (0,0,40) + vectorscale(anglesToForward( self.angles ), 20);
	end = self.origin + (0,0,40) + vectorscale(anglesToForward( self.angles ), 40);

	left = vectorscale(anglesToRight( self.angles ), -10);
	right = vectorscale(anglesToRight( self.angles ), 10);
	back = vectorscale(anglesToForward( self.angles ), -6);
	
	canPlantThere1 = BulletTracePassed( start, end, true, self.SentryCarry);
	canPlantThere2 = BulletTracePassed( start + (0,0,-7) + left, end + left + back, true, self.SentryCarry);
	canPlantThere3 = BulletTracePassed( start + (0,0,-7) + right , end + right + back, true, self.SentryCarry);
	
	trace = BulletTrace( end, end - (0,0,250), false, self.SentryCarry );

	if( !canPlantThere1 || !canPlantThere2 || !canPlantThere3 || trace["fraction"] == 1 )
	{
		scr_iPrintlnBold("SENTRY_GUN_BAD_SPOT", self);
		self.triesToPlantSentry = false;
		return false;
	}
	
	self thread SpawnSentry( trace["position"], (0,int(self.angles[1]),0), wasPickedUp, alivetime, takenDamage);
	self.triesToPlantSentry = false;
	return true;
}

SpawnSentry(pos, angles, wasPickedUp, alivetime, takenDamage)
{
	level.Sentrys++;

	self.SentryGun = [];
	slot = self.SentryGun.size;
	
	self.SentryGun[slot] = spawn("script_model", pos);
	self.SentryGun[slot] setModel(level.SentryModel);
	self.SentryGun[slot] HidePart("bi_base", level.SentryModel);
	self.SentryGun[slot] HidePart("tag_spin", level.SentryModel);
	self.SentryGun[slot].angles = angles;
	self.SentryGun[slot].baseModel = self.SentryGun[slot];
	self.SentryGun[slot].firedelay = level.SentryFireDelay;
	self.SentryGun[slot].startangles = self.SentryGun[slot].angles;
	self.SentryGun[slot].left_maxrotation = (int(self.angles[0]), int(self.angles[1]+level.SentryRotation/2), int(self.angles[2]));
	self.SentryGun[slot].right_maxrotation = (int(self.angles[0]), int(self.angles[1]-level.SentryRotation/2), int(self.angles[2]));
	
	self.SentryGun[slot].Bipod = spawn("script_model", pos);
	self.SentryGun[slot].Bipod setModel(level.SentryModel);
	self.SentryGun[slot].Bipod HidePart("tag_aim", level.SentryModel);
	self.SentryGun[slot].Bipod HidePart("tag_aim_pitch", level.SentryModel);
	self.SentryGun[slot].Bipod HidePart("tag_spin", level.SentryModel);
	self.SentryGun[slot].Bipod.angles = self.SentryGun[slot].angles;
	self.SentryGun[slot].Bipod.baseModel = self.SentryGun[slot];
	
	self.SentryGun[slot].Barrel = spawn("script_model", pos);
	self.SentryGun[slot].Barrel setModel(level.SentryModel);
	self.SentryGun[slot].Barrel HidePart("tag_aim", level.SentryModel);
	self.SentryGun[slot].Barrel HidePart("tag_aim_pitch", level.SentryModel);
	self.SentryGun[slot].Barrel HidePart("bi_base", level.SentryModel);
	self.SentryGun[slot].Barrel.angles = self.SentryGun[slot].angles;
	self.SentryGun[slot].Barrel.baseModel = self.SentryGun[slot];
	self.SentryGun[slot].Barrel linkTo(self.SentryGun[slot]);

	self.SentryGun[slot] maps\mp\_entityheadicons::setEntityHeadIcon(self.pers["team"], (0,0,80));
	self.SentryGun[slot] PlaySound("sentry_gun_deploy");
	self.SentryGun[slot] thread PickupTrigger(self);
	self.SentryGun[slot] thread CoverArea(self);
	
	self.SentryGun[slot] SetContents(1);
	self.SentryGun[slot].Bipod SetContents(1);
	self.SentryGun[slot].Barrel SetContents(1);
	
	if(isDefined(wasPickedUp) && wasPickedUp)
	{
		if(!isDefined(alivetime) || alivetime <= 0)
			self.SentryGun[slot].alivetime = .1;
		else
			self.SentryGun[slot].alivetime = alivetime;
			
		if(!isDefined(takenDamage) || takenDamage >= level.SentryHealth)
			self.SentryGun[slot].TakenDamage = 0;
		else
			self.SentryGun[slot].TakenDamage = takenDamage;
	}
	else
	{
		self.SentryGun[slot].alivetime = level.SentryAliveTime;
		self.SentryGun[slot].TakenDamage = 0;
	}
	
	self.SentryGun[slot] thread AliveTime(self);
	self.SentryGun[slot] thread SentryDamageMonitor();
	self.SentryGun[slot].Bipod thread SentryDamageMonitor();
	self.SentryGun[slot].Barrel thread SentryDamageMonitor();
	
	self thread maps\mp\gametypes\_huds::HardpointLiveTimeHud(level.ktkWeapon["sentrygun"], self.SentryGun[slot].alivetime, self.SentryGun[slot]);
}

PickupTrigger(owner)
{
	self endon("death");
	
	owner.hasPickedUpSentry = false;
	self.PickupTrigger = spawn("trigger_radius", self.origin, 0, 100, 100);
	
	while(1)
	{
		self.PickupTrigger waittill("trigger", player);
		
		if(isDefined(owner) && player == owner && player UseButtonPressed())
		{
			if(isDefined(player.hasPickedUpSentry) && player.hasPickedUpSentry)
				continue;
	
			player.hasPickedUpSentry = true;
		
			cur_alivetime = self.alivetime;
			cur_takenDamage = self.TakenDamage;

			player thread WaitForSentryDeploy(true, cur_alivetime, cur_takenDamage);
			self thread DeleteSentry();

			break;
		}	
	}
}

CoverArea(owner)
{
	self endon("death");

	trace = BulletTrace(self GetTagOrigin("tag_flash"), self GetTagOrigin("tag_flash") + AnglesToForward(self.angles)*999999999, false, self);
	self.SentryAimDist = distance(trace["position"], self GetTagOrigin("tag_flash"));

	if(self.SentryAimDist > level.SentryAimDist)
		self.SentryAimDist = level.SentryAimDist;

	self.SentryAimHeight = level.SentryAimHeight;
		
	trigger = spawn("trigger_radius", self GetTagOrigin("tag_flash") - (0, 0, self.SentryAimHeight), 0, self.SentryAimDist, self.SentryAimHeight*2);

	self.state = "observe";
	self.currenttarget = undefined;

	self thread Observing();
	
	while(1)
	{
		trigger waittill("trigger", player);
		
		if(isDefined(self.currenttarget) || self.state == "attack")
			continue;
		
		if(!isPlayer(player) || !isAlive(player))
			continue;
		
		if(player isAGuard())
			continue;

		if(lengthSquared(player getVelocity()) < 10)
			continue;
			
		if(!player AffectingSentry(self))
			continue;

		self thread ShootTarget(player, owner);
	}
}

Observing()
{
	self endon("death");
	
	delay = 0;
	self.TurningLeft = false;
	self.TurningRight = false;
	
	while(1)
	{
	wait 0.05;

		if(self.state != "observe")
			continue;

		self PlaySound("sentry_gun_turning");
		
		if(self.angles == self.startangles && !self.TurningLeft && !self.TurningRight)
		{
			delay = level.SentryRotation/60;
			acceal = int(delay/2*100)/100;
			deceal = delay - acceal;
		
			if(randomInt(2) == 0)
			{
				self.TurningLeft = true;
				self NewRotation(self.left_maxrotation, delay, acceal, deceal);
			}
			else
			{
				self.TurningRight = true;
				self NewRotation(self.right_maxrotation, delay, acceal, deceal);
			}
		}
		else
		{
			delay = level.SentryRotation/30;
			acceal = int(delay/1.6*100)/100;
			deceal = delay - acceal;
	
			if(self.TurningLeft)
			{
				self NewRotation(self.right_maxrotation, delay, acceal, deceal);
				self.TurningLeft = false;
				self.TurningRight = true;
			}
			else if(self.TurningRight)
			{
				self NewRotation(self.left_maxrotation, delay, acceal, deceal);
				self.TurningLeft = true;
				self.TurningRight = false;
			}
		}

	wait (delay+1);
	}
}

ShootTarget(target, owner)
{
	self endon("death");

	self.state = "attack";
	self.currenttarget = target;
	
	self thread AimForTarget();
	
	i = 1;
	while(isDefined(self.currenttarget) && isAlive(self.currenttarget) && self.currenttarget AffectingSentry(self))
	{
		i++;

		if(int(i/2) == (i/2))
		{
			self PlaySound("sentry_gun_fire");
			PlayFxOnTag(level._effect["sentry_flash"], self, "tag_flash");
			PlayFx(level._effect["sentry_shell"], self GetTagOrigin("tag_brass"), anglesToRight(self.angles));
		}

		trace = BulletTrace(self GetTagOrigin("tag_flash"), self GetTagOrigin("tag_flash") + AnglesToForward(self.angles)*999999999, true, self);

		if(isDefined(trace["entity"]) && trace["entity"] == self.currenttarget)
		{
			self.currenttarget ktkFinishPlayerDamage(self, owner, 15, 0, "MOD_RIFLE_BULLET", level.ktkWeapon["sentrygun"], self GetTagOrigin("tag_flash"), VectorToAngles(self.currenttarget.origin - self GetTagOrigin("tag_flash")), "none", 0 );
			PlayFx(level._effect["sentry_blood"], self.currenttarget GetTagOrigin("j_spine4"));
		}
		
	wait .05;
	}

	self.state = "observe";
	self.currenttarget = undefined;
}

AimForTarget()
{
	self endon("death");
	
	while(isDefined(self.state) && self.state == "attack")
	{
		if(!isDefined(self.currenttarget))
			break;
	
		dif = CalcDif(self.angles[1], self.currenttarget.angles[1]);
		time = 0.3;
		
		if(dif > 90 && dif <= 120)
			time = 0.2;
		else if(dif > 50 && dif <= 90)
			time = 0.1;
		else if(dif > level.SentryAimMinDist && dif <= 50)
			time = 0.05;
		
		self NewRotation(VectorToAngles(self.currenttarget.origin - self.origin), time);

	wait .05;
	}
}

AffectingSentry(sentry)
{
	self endon("disconnect");
	self endon("death");

	pos = self getEye();
	
	dirToPos = pos - sentry GetTagOrigin("tag_flash");
	sentryForward = anglesToForward(sentry.angles);
	
	dist = vectorDot(dirToPos, sentryForward);
	if(dist < level.SentryAimMinDist)
		return false;
	
	//checks if the player can be seen by the sentry and is not behind a wall/entity
	if(self SightConeTrace(sentry GetTagOrigin("tag_flash"), self) <= 0)
		return false;
	
	if(CalcDif(sentry.left_maxrotation[1], sentry.angles[1]) <= 2 || CalcDif(sentry.right_maxrotation[1], sentry.angles[1]) <= 2)
		return false;
	
	/*dirToPos = vectornormalize(dirToPos);
	
	dot = vectorDot(dirToPos, sentryForward);
	return (dot > level.SentryDetectionDot);*/
	
	return true;
}

AliveTime(owner)
{
	self endon("death");
	
	if(self.alivetime <= 0)
		self.alivetime = .1;
	
	while(self.alivetime > 0 && isDefined(self))
	{
		self.alivetime -= .1;
		wait .1;
	}

	if(isDefined(self))
		self thread DeleteSentry();
}

SentryDamageMonitor()
{
	self endon("death");

	self setCanDamage(true);

	self.health = 9999;

	if(!isDefined(self.baseModel.TakenDamage))
		self.baseModel.TakenDamage = 0;
	
	while(self.baseModel.TakenDamage < level.SentryHealth)
	{
		self waittill("damage", damage, attacker, vDir, vPoint, sMeansOfDeath);

		if(isPlayer(attacker) && attacker isAGuard())
			continue;

		switch(sMeansOfDeath)
		{
			case "MOD_PROJECTILE":
			case "MOD_EXPLOSIVE":
			case "MOD_GRENADE": damage *= 3; break;
			case "MOD_MELEE": damage = level.SentryHealth; break;
			default: break;
		}

		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
		
		self.baseModel.TakenDamage += damage;
		if(self.baseModel.TakenDamage >= level.SentryHealth)
		{
			self.baseModel thread DeleteSentry();
			break;
		}
	}
}

DeleteSentry()
{
	level.Sentrys--;

	//in case it's a pickup only
	self.TurningLeft = false;
	self.TurningRight = false;

	playFX(level._effect["sentry_explode"], self getTagOrigin("tag_aim_pitch"));
	
	self maps\mp\_entityheadicons::setEntityHeadIcon("none");
	self.PickupTrigger delete();
	self.Barrel delete();
	self.Bipod delete();
	self delete();
}

OwnerEvents()
{
	self endon("disconnect");
	
	self notify("sentry_player_event_handler");
	self endon("sentry_player_event_handler");
	
	self waittill_any("death", "end_respawn"); //("joined_spectators", "joined_team", "death", "spawned_player");
	
	if(isDefined(self.SentryCarry))
	{
		self.SentryCarry unlink();
		self.SentryCarry delete();
		self enableWeapons();
	}

	if(!isDefined(self.SentryGun) || !self.SentryGun.size)
		return;
	
	for(i=0;i<self.SentryGun.size;i++)
	{
		if(isDefined(self.SentryGun[i]))
			self.SentryGun[i] thread DeleteSentry();
	}
}