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

init()
{
	if(game["customEvent"] != "alien")
		return;

	//if(getDvar("scr_nanosuit_team") == "") setDvar("scr_nanosuit_team", "both");
	//level.nanosuitTeam = getDvar("scr_nanosuit_team");
	
	level.nanosuitTeam = game["attackers"];
	
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

		self.energyGainDelay = 0;
		self.isSprinting = false;
		self.isStealth = false;
		self.isArmored = false;

		self thread MonitorNanoSuitUsage();
	}
}

MonitorNanoSuitUsage()
{
	self endon("disconnect");
	self endon("death");

	if(!isDefined(level.nanosuitTeam))
		level.nanosuitTeam = "both";
			
	if(level.nanosuitTeam != "both")
	{
		if(self.pers["team"] != level.nanosuitTeam)
			return;
		
		if(level.nanosuitTeam == game["attackers"])
		{
			if(self isDog())
				return;
		}
		else		
		{
			if(	self isInRCToy() ||
				self isInParachute() ||
				self isCarryingExpBolt() ||
				self isInLastStand() ||
				!self isAtOldOrigin() ||
				self isTerminator() ||
				self isInMannedHelicopterTurret() ||
				self isInAC130())
			return;
		}
	}
	
	//self thread NanosuitStaticSound();
	self thread NanosuitPhysicsBall();
	self thread MonitorNanosuitEnergie();

	while(1)
	{
		wait .1;

		if(self getCurrentWeapon() != level.ktkWeapon["disruptor"])
			continue;
		
		if(self leanleftButtonPressed())
		{
			self thread ToggleNanoSuit("stealth");
		
			while(self leanleftButtonPressed())
				wait .05;
				
			continue;
		}
		
		if(self leanrightButtonPressed())
		{
			self thread ToggleNanoSuit("armor");
		
			while(self leanrightButtonPressed())
				wait .05;
				
			continue;
		}
	}
}


ToggleNanoSuit(event)
{
	self endon("disconnect");
	self endon("death");

	if(event == "armor")
	{
		self.isArmored = !self.isArmored;

		if(self.isArmored)
		{
			self thread maps\mp\gametypes\_huds::ArmorHud();
			self PlaySound("armor_mode");
		}
	}

	if(event == "stealth")
	{
		self.isStealth = !self.isStealth;
		self.weapons = self getWeaponsList();
		currentWeapon = self getCurrentWeapon();

		for(i=0;i<self.weapons.size;i++)
		{
			self.ammoclip[i] = self getWeaponAmmoClip(self.weapons[i]);
			self.ammostock[i] = self getWeaponAmmoStock(self.weapons[i]);

			self TakeWeapon(self.weapons[i]);
			
			if(self.isStealth)
				self GiveWeapon(self.weapons[i], 1);
			else
				self GiveWeapon(self.weapons[i]);

			self setSpawnWeapon(self.weapons[i]);
				
			self.ammoclip[i] = self getWeaponAmmoClip(self.weapons[i]);
			self.ammostock[i] = self getWeaponAmmoStock(self.weapons[i]);
		}
		
		if(self.isStealth)
		{
			self detachAll();
			self setModel(self.alienModel + "_invisible");
			self setViewModel("viewhands_fake_player");
			
			self PlaySound("stealth_mode");
		}
		else
		{
			self setViewModel("viewmodel_base_viewhands");
			self maps\mp\gametypes\_teams::playerModelForWeapon("ak47_mp");
		}		
		
		if(!isSubStr(currentWeapon, "_grenade_"))
			self setSpawnWeapon(currentWeapon);
		else
		{
			for(i=0;i<self.weapons.size;i++)
			{
				if(!isSubStr(currentWeapon, "_grenade_"))
				{
					self setSpawnWeapon(self.weapons[i]);
					break;
				}
			}
		}
	}
	
	if(event == "shutdown")
	{
		self.isSprinting = false;
		self.isArmored = false;
	
		if(self.isStealth)
			self thread ToggleNanoSuit("stealth");
	}
	
	self.energyGainDelay = 0;
}

MonitorNanoSuitEnergie()
{
	self endon("disconnect");
	self endon("death");

	self thread MonitorSprint();
	self thread MonitorWeaponUsage();
	
	power_stealth = 5;
	power_armor = 3;
	power_sprint = 2;

	self.nanosuit_energy = 100;
	self.nanosuit_maxEnergy = 100;
	
	while(1)
	{
		if(self.nanosuit_energy <= 0 || (!self.isStealth && !self.isArmored && !self.isSprinting))
		{
			if(self.nanosuit_energy <= 0 && (self.isStealth || self.isArmored || self.isSprinting))
				self thread ToggleNanoSuit("shutdown");

			if(self.nanosuit_energy < self.nanosuit_maxEnergy)
			{
				if(self EnergyGain())
				{
					dif = (self.nanosuit_maxEnergy - self.nanosuit_energy);

					if(dif < 4)
						self.nanosuit_energy += dif;
					else
						self.nanosuit_energy += 4;
				}
			}
		}
		else
		{
			if(self.isStealth && !self.isArmored && !self.isSprinting)
				self.nanosuit_energy -= power_stealth;
			else if(!self.isStealth && self.isArmored && !self.isSprinting)
				self.nanosuit_energy -= power_armor;
			else if(!self.isStealth && !self.isArmored && self.isSprinting)
				self.nanosuit_energy -= power_sprint;
			else if(self.isStealth && self.isArmored && !self.isSprinting)
				self.nanosuit_energy -= (power_stealth + power_armor);
			else if(self.isStealth && !self.isArmored && self.isSprinting)
				self.nanosuit_energy -= (power_stealth + power_sprint);
			else if(!self.isStealth && self.isArmored && self.isSprinting)
				self.nanosuit_energy -= (power_armor + power_sprint);
			else if(self.isStealth && self.isArmored && self.isSprinting)
				self.nanosuit_energy -= (power_stealth + power_armor + power_sprint);
		}

	wait 1;
	}
}

EnergyGain()
{
	self endon("disconnect");
	self endon("death");
	
	self.energyGainDelay++;

	if(self.energyGainDelay > 4)
		return true;
	
	return false;
}

MonitorWeaponUsage()
{
	self endon("disconnect");
	self endon("death");

	while(1)
	{
		self waittill("begin_firing");
		self thread ToggleNanoSuit("shutdown");
	}
}

MonitorSprint()
{
	self endon("disconnect");
	self endon("death");

	self thread SprintEnd();
	
	while(1)
	{
		self waittill("sprint_begin");
		self.isSprinting = true;
	}
}

SprintEnd()
{
	self endon("disconnect");
	self endon("death");

	while(1)
	{
		self waittill("sprint_end");
		self.isSprinting = false;
	}
}

NanosuitStaticSound()
{
	self endon("disconnect");
	self endon("death");
	
	while(1)
	{
		wait .25;
		
		vel = length(self getVelocity());
		if(!isDefined(vel))
			continue;
			
		if(self getStance() != "stand")
			continue;
			
		if(!self.isStealth && !self.isArmored)
			continue;
		
		if(vel > 200)
		{
			if(vel > 230)
				self playSoundToTeam("hstatic" + (randomInt(72) + 1), game["defenders"]);
			else
				self playSoundToTeam("mstatic" + (randomInt(72) + 1), game["defenders"]);
		}
	}
}

NanosuitPhysicsBall()
{
	self endon("death");
	self endon("disconnect");
	
	while(1) 
	{
		wait .05;
		
		if(!self.isStealth && !self.isArmored)
			continue;
		
		moveSpeed = length(self getVelocity());
		force = moveSpeed / 900;
		physOuter = int(moveSpeed / 2 + 0.5);
		
		if(physOuter <= 0)
			continue;
		
		physicsExplosionSphere(self.origin, physOuter, 0, force);
	}
}