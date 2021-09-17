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
	if(getDvar("scr_mod_tripwire_planttime") == "")
		setDvar("scr_mod_tripwire_planttime", 3);

	if(getDvar("scr_mod_tripwire_defusetime") == "")
		setDvar("scr_mod_tripwire_defusetime", 5);

	if(getDvar("scr_mod_tripwire_defuse") == "")
		setDvar("scr_mod_tripwire_defuse", 0);
		
	if(getDvar("scr_mod_tripwire_damage") == "")
		setDvar("scr_mod_tripwire_damage", 100);
		
	if(getDvar("scr_mod_tripwire_radius") == "")
		setDvar("scr_mod_tripwire_radius", 300);

	level.tripwireRadius = getDvarInt("scr_mod_tripwire_radius");
	level.tripwireDamage = getDvarInt("scr_mod_tripwire_damage");
	level.tripwirePlanttime = getDvarFloat("scr_mod_tripwire_planttime");
	level.tripwireDefusetime = getDvarFloat("scr_mod_tripwire_defusetime");
	level.tripwireActiveTime = 3;
	level.tripwireHealth = 10;

	level._effect["tripwire_wire"] = LoadFX("misc/light_c4_blink");
}

CheckDeploy()
{
	self endon("disconnect");
	self endon("intermission");
	self endon("death");

	if(!isDefined(self.pers["hastripwires"]))
		self.pers["hastripwires"] = 0;
	
	while(self.pers["hastripwires"] <= 0)
		wait .05;
	
	self.tripwire = [];
	self.deployedtripwires = 0;
	self.IsPlantingTrip = false;
	self.IsDefusingTrip = false;
	
	if(self isABot())
		return;
	
	while(1)
	{
		wait .05;

		if(!isDefined(self.pers["hastripwires"]))
			continue;
			
		if(self isReviving() || self isInRCToy())
			continue;
			
		if(self GetStance() == "prone" && self.pers["hastripwires"] > 0)
		{
			if(isDefined(self.lowerMessage))
			{
				self.lowerMessage.label = self GetLocalizedString("TRIP_PLANT"); //&"Hold ^3[{+activate}] ^7to plant a tripwire.";//&"KTK_HOLD_USE_TRIP";
				self.lowerMessage.alpha = 1;
				self.lowerMessage FadeOverTime(0.05);
				self.lowerMessage.alpha = 0;
			}

			if(self UseButtonPressed())
				self thread DeployTripwire();

			while(self useButtonPressed())
				wait .05;
		}
	}
}

DeployTripwire()
{
	self endon("disconnect");
	self endon("intermission");
	self endon("death");

	if(self isReviving())
		return;
		
	if(self isPlantingTripwire())
		return;
		
	if(self isDefusingTripwire())
		return;
		
	self.tripwire[self.deployedtripwires] = Spawn("script_origin", self.origin);
	tripwire = self.tripwire[self.deployedtripwires];
	
	self thread OnPlayerDeath();
	self thread OnPlayerDisconnect();
	
	trace = BulletTrace(tripwire.origin + (0,0,20), tripwire.origin + (0,0,20) + vector_scale(anglesToForward(self GetPlayerAngles() + (0,90,0)),50),false,undefined);
	trace = BulletTrace(trace["position"] + (0,0,20), trace["position"] - (0,0,20),false,undefined);
	leftorigin = (trace["position"][0], trace["position"][1], self.origin[2]);
	
	trace = BulletTrace(tripwire.origin + (0,0,20), tripwire.origin + (0,0,20) - vector_scale(anglesToForward(self GetPlayerAngles() + (0,90,0)),50),false,undefined);
	trace = BulletTrace(trace["position"] + (0,0,0), trace["position"] - (0,0,20),false,undefined);
	rightorigin = (trace["position"][0], trace["position"][1], self.origin[2]);

	allowedpositions = CheckConnection(leftorigin, rightorigin, tripwire);
	
	if(!allowedpositions)
	{
		scr_iPrintLnBold("TRIP_BAD_SPOT", self);
		return;
	}

	//it's ok so start deploying
	self playsound("MP_bomb_plant");		
	self DisableWeapons();
	self freezeControls(true);
	self.IsPlantingTrip = true;
	
	progress = self TripwireProgress(level.tripwirePlanttime);
	
	self EnableWeapons();
	self freezeControls(false);
	self.IsPlantingTrip = false;
			
	if(!isDefined(progress) || progress > 0)
		return;

	self.pers["hastripwires"]--;
	self.deployedtripwires++;
	
	tripwire.grenade[0] = Spawn("script_model", leftorigin);
	tripwire.grenade[0] SetModel("projectile_m67fraggrenade");
	tripwire.grenade[1] = Spawn("script_model", rightorigin);
	tripwire.grenade[1] SetModel("projectile_m67fraggrenade");

	tripwire.grenade[0].baseModel = tripwire;
	tripwire.grenade[1].baseModel = tripwire;
	
	tripwire.grenade[0] thread TripwireWireFx();

	scr_iPrintLnBold("TRIP_ACTIVE_IN", self, level.tripwireActiveTime);
	
	wait level.tripwireActiveTime;
	
	tripwire.active = true;
	tripwire thread CheckDefuse(self);
	tripwire thread CheckTriggering(self);
	tripwire thread maps\mp\_entityheadicons::setEntityHeadIcon(self.pers["team"], (0,0,20));
	
	tripwire.grenade[0] thread TripDamageMonitor(self);
	tripwire.grenade[1] thread TripDamageMonitor(self);
}

TripwireWireFx()
{
	self endon("death");

	/*i don't have an fx yet
	while(1)
	{
		if(!isDefined(self))
			break;
	
		PlayFxonTag(level._effect["tripwire_wire"], self, "tag_origin");
		wait .05;
	}*/
}

TripDamageMonitor(owner)
{
	self endon("death");

	self setCanDamage(true);

	self.baseModel.TakenDamage = 0;
	self.health = 999;

	while(self.baseModel.TakenDamage < level.tripwireHealth)
	{
		self waittill("damage", damage, attacker, vDir, vPoint, sMeansOfDeath);

		if(sMeansOfDeath == "MOD_MELEE")
			continue;

		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);

		self.baseModel.TakenDamage += damage;
		if(self.baseModel.TakenDamage >= level.tripwireHealth)
		{
			self.baseModel thread Explode(owner);
			break;
		}
	}
}

CheckConnection(start, end, entity)
{
	if(BulletTracePassed(start, end, false, entity))
		return true;

	return false;
}

CheckTriggering(owner)
{
	start = self.grenade[0].origin + (0,0,5);
	end = self.grenade[1].origin + (0,0,5);

	while(isDefined(self) && self.active)
	{
		if(getDvarInt("developer") == 1)
			line(start, end, (1,1,1));

		if(!BulletTracePassed(start, end, true, self))
		{
			trace = BulletTrace(start, end, true, self);

			if(isDefined(trace["entity"]) && isPlayer(trace["entity"]) && isAlive(trace["entity"]))
			{
				if(!isDefined(owner) || trace["entity"].pers["team"] != owner.pers["team"])
					self Explode(owner);
			}
		}
	wait .05;
	}
}

Explode(owner)
{
	if(!isDefined(owner))
		self RadiusDamage(self.origin, 0 , 0 , 0);
	else
	{
		if(owner getKtkStat(2377) == 1)
			self RadiusDamage(self.origin, level.tripwireRadius, (level.tripwireDamage + int(level.tripwireDamage*25/100)), 1, owner, "MOD_EXPLOSIVE", "claymore_mp");
		else
			self RadiusDamage(self.origin, level.tripwireRadius, level.tripwireDamage, 1, owner, "MOD_EXPLOSIVE", "claymore_mp");
	}		

	self playsound("rocket_explode_default");
	playfx(level._effect["tripwireexplosion"], self.origin);
	PlayRumbleOnPosition( "artillery_rumble", self.origin );
	
	self RemoveTripwire(owner);
}


CheckDefuse(owner)
{
	self endon("death");

	if(getDvarInt("scr_mod_tripwire_defuse") == 0)
		return;

	if(self isDefusingTripwire())
		return;
		
	self.trigger = spawn("trigger_radius", self.origin, 0, 30, 30 );

	while(isDefined(self) && self.active)
	{
		self.trigger waittill("trigger", player);

		if(player GetStance() == "prone" && player UseButtonPressed())
		{
			if(getDvarInt("scr_mod_tripwire_defuse") == 2 && player != owner)
				continue;
			
			player DefuseTripwire(self, owner);

			while (self.active && player useButtonPressed())
				wait .05;
		}
	}
}

DefuseTripwire(tripwire, owner)
{
	self endon("disconnect");
	self endon("intermission");
	self endon("death");
	
	self thread OnPlayerDeath();
	
	self playsound("MP_bomb_defuse");		
	self DisableWeapons();
	self freezeControls(true);
	self.IsDefusingTrip = true;

	progress = self TripwireProgress(level.tripwireDefusetime);

	self EnableWeapons();
	self freezeControls(false);
	self.IsDefusingTrip = false;
			
	if(!isDefined(progress) || progress > 0)
		return;

	tripwire RemoveTripwire(owner);
}

RemoveTripwire(owner)
{
	self endon("death");

	if(isDefined(self))
	{
		self.active = false;
		
		if(isDefined(owner))
		{
			if(isDefined(owner.deployedtripwires) && owner.deployedtripwires > 0)
				owner.deployedtripwires--;
			else
				owner.deployedtripwires = 0;
		}

		wait .1;

		self maps\mp\_entityheadicons::setEntityHeadIcon("none");	
		
		if(isDefined(self.grenade) && isDefined(self.grenade[0]))
			self.grenade[0] delete();
		
		if(isDefined(self.grenade) && isDefined(self.grenade[1]))
			self.grenade[1] delete();
		
		if(isDefined(self))
			self delete();
	}
}

TripwireProgress(timer)
{
	self endon("death");
	self endon("disconnect");
	
	self.tripbar = self maps\mp\gametypes\_hud_util::createBar((1,1,1), 128, 8);
	self.tripbar maps\mp\gametypes\_hud_util::setPoint("CENTER", 0, 0, 0);
	self.tripbar maps\mp\gametypes\_hud_util::updateBar(0, 1/timer);
			
	while(self UseButtonPressed() && timer > 0)
	{		
		wait .1;
		timer -= .1;
	}
			
	self.tripbar maps\mp\gametypes\_hud_util::destroyElem();
	
	return timer;
}

OnPlayerDeath()
{
	self endon("disconnect");
	self waittill("death");
	
	self thread RemoveTripwiresAndLoadBar();
}

onPlayerDisconnect()
{
	self waittill("disconnect");

	self thread RemoveTripwiresAndLoadBar();
}

RemoveTripwiresAndLoadBar()
{
	if(!isDefined(self))
	{
		DebugMessage(1, "Tripwire owner is not defined anymore");
		return;
	}

	if(isDefined(self.tripbar))
		self.tripbar maps\mp\gametypes\_hud_util::destroyElem();
	
	if(!isDefined(self.tripwire))
	{
		DebugMessage(1, "self.tripwire is not defined");
		return;
	}
		
	if(self.tripwire.size == 0)
	{
		DebugMessage(1, "Tripwire size is 0");
		return;
	}
	
	for(i=0;i<self.tripwire.size;i++)
	{
		if(isDefined(self.tripwire[i]))
			self.tripwire[i] RemoveTripwire(self);
	}
}