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
	if(getDvar("scr_gungame_autoswitch") == "")
		setDvar("scr_gungame_autoswitch", 1);
		
	if(getDvar("scr_gungame_weapon1") == "") setDvar("scr_gungame_weapon1", "colt45_mp");
	if(getDvar("scr_gungame_weapon2") == "") setDvar("scr_gungame_weapon2", "deserteagle_mp");
	if(getDvar("scr_gungame_weapon3") == "") setDvar("scr_gungame_weapon3", level.ktkWeapon["ump45"]);
	if(getDvar("scr_gungame_weapon4") == "") setDvar("scr_gungame_weapon4", "m4_mp");

	initGunGameWeapons();
}

initGunGameWeapons()
{
	level.GunGameWeapons = [];
	level.GunGameWeapons[0] = "usp_mp"; //in ktk: skipped at spawn

	for(index=1; getDvar("scr_gungame_weapon" + index) != ""; index++)
	{
		if(game["customEvent"] == "traitors" && getDvar("scr_gungame_weapon" + index) == "saw_acog_mp")
			continue;
	
		level.GunGameWeapons[index] = getDvar("scr_gungame_weapon" + index);
		
		if(getSubStr(level.GunGameWeapons[index], level.GunGameWeapons[index].size-3, level.GunGameWeapons[index].size) == "_mp")
			precacheItem(level.GunGameWeapons[index]);
	}
}

WeaponState(spawned, switchWeapon)
{
	self endon("disconnect");
	self endon("death");
	
	self notify("repeated_gungame");
	self endon("repeated_gungame");
	
	if(!isDefined(self.pers["team"]))
		return;
		
	if(self.pers["team"] != game["defenders"])
	{
		if(game["customEvent"] != "kingvsking")
			return;
	}
	
	if(!isdefined(self.weaponstate))
		self.weaponstate = 1;
	
	if(!isdefined(spawned))
		spawned = false;
		
	if(!isdefined(switchWeapon))
		switchWeapon = false;		
	
	if(self.weaponstate == (level.GunGameWeapons.size - 1))
		self thread maps\mp\gametypes\_missions::GunGame();
	
	autoSwitch = getDvarInt("scr_gungame_autoswitch");
	if(self isABot())
		autoSwitch = true;
	
	if(!autoSwitch && self.weaponstate > 1 && !spawned && !switchWeapon)
	{
		if(self getKtkStat(2363) == 0 || self.weaponstate > 2)
		{
			if(!isDefined(self.gungamehint))
				self thread maps\mp\gametypes\_huds::gungameHUD();

			self.gungameUpgraded = false;
				
			while(!self UseButtonPressed())
				wait .1;
				
			wait .05; //give the script time to check for other actions (like revive)
				
			self.gungameUpgraded = true;
				
			if(self isReviving() || (isDefined(self.IsOpeningCrate) && self.IsOpeningCrate) || (isDefined(self.climbing) && self.climbing))
			{
				while(self UseButtonPressed())
					wait .1;
					
				/* 
				removed - this was the old way
				it was always upgrading the weapon after the revive - that's not wanted
				while(!self UseButtonPressed())
					wait .1;
				*/
					
				self thread RestartGungameUpgrade(spawned, switchWeapon);
				return;
			}
			
			if(isDefined(self.pers["actionslot"][3]["weapon"]) && self.pers["actionslot"][3]["weapon"] == self getCurrentWeapon())
			{
				scr_iPrintLnBold("PLAYER_SIDEARM_NO_REPLACE", self);
				
				while(self UseButtonPressed())
					wait .1;
				
				self thread RestartGungameUpgrade(spawned, switchWeapon);
				return;
			}
				
			if(isDefined(self.gungamehint))
				self.gungamehint destroy();
		}
	}
		
	//don't give a weapon to the blocked players right now!
	if(!spawned && !self GungameForPlayer())
	{
		if(autoSwitch)
		{
			while(!self GungameForPlayer())
				wait .1;
		}
		else
		{
			//self iPrintLnBold("You can not upgrade your weapon when using a killstreak!");
					
			while(self UseButtonPressed())
				wait .1;
		}
				
		self thread RestartGungameUpgrade(spawned, switchWeapon);
		return;
	}
	
	//in case of a respawn let the player decide when to upgrade his weapon
	if(spawned && !autoSwitch)
	{
		self giveCurrentGungameWeapon();

		if(isDefined(self.gungameUpgraded) && !self.gungameUpgraded)
		{
			//add a short delay to give the player time to release the use button
			//when the use button is still hold after skipping the killcam
			killcamDelay = 0;
			if(isDefined(self.killcamSkipped) && self.killcamSkipped)
				killcamDelay = 2;
			
			while(self UseButtonPressed() && killcamDelay > 0)
			{
				wait .1;
				killcamDelay -= .1;
			}

			self thread RestartGungameUpgrade(false, switchWeapon);
		}
		
		if(!isDefined(self.gungameUpgraded) || !self.gungameUpgraded)
			return;
	}
	
	self giveNextGungameWeapon();
}

giveCurrentGungameWeapon()
{
	self endon("disconnect");
	self endon("death");
	
	weapon = level.GunGameWeapons[self.weaponstate-1];
	
	if(self.weaponstate == 1 || (self.weaponstate == 2 && self getKtkStat(2363) == 1))
		weapon = level.GunGameWeapons[self.weaponstate];	

	if(!isDefined(weapon))
	{
		if(isDefined(self.weaponstate))
		{
			logPrint("weapon not defined :" + self.weaponstate + "\n");
			logPrint("-1 " + level.GunGameWeapons[self.weaponstate-1] + "\n");
			logPrint("cur " + level.GunGameWeapons[self.weaponstate] + "\n");
		}
		else
			logPrint("weapon and weaponstate not defined\n");
	}
	
	self giveWeapon(weapon);
	self GiveMaxAmmo(weapon);
	wait .05;
		
	if(self isABot())
		self setSpawnWeapon(weapon);
	else
		self switchToWeapon(weapon);

	self thread infiniteAmmo();
	
	if(self.weaponstate == 1 || (self.weaponstate == 2 && self getKtkStat(2363) == 1))
	{
		if(	getDvar("g_gametype") == "ktk" && !self HasPerk( "specialty_pistoldeath" )) 
			self SetPerk( "specialty_pistoldeath" );
			
		if(isDefined(self.pers["vip"]) && self.pers["vip"] && self getKtkStat(2380) != 2)
		{
			self giveWeapon("rpg_mp");
			self setWeaponAmmoClip("rpg_mp", 1);
			self setWeaponToSlot("rpg_mp");
			self setweaponammostock("rpg_mp", 0);
		}
	}
}

giveNextGungameWeapon()
{
	self endon("disconnect");
	self endon("death");
	
	weapon = level.GunGameWeapons[self.weaponstate-1];
	newweapon = level.GunGameWeapons[self.weaponstate];

	if(!self HasWeapon(weapon) || self CountPrimaryWeapons() >= 2)
		weapon = self GetCurrentWeapon();

	self takeWeapon(weapon);	
	self giveWeapon(newweapon);
	self GiveMaxAmmo(newweapon);
	
	if(self isInLastStand())
		self thread ReplaceInInventory(weapon, newweapon);
	
	wait .05;
		
	if(self getCurrentWeapon() != "rpg_mp")
	{
		if(self isABot())
			self setSpawnWeapon(newweapon);
		else
			self switchToWeapon(newweapon);
	}

	self thread infiniteAmmo();
	
	if(self.weaponstate == 1 || (self.weaponstate == 2 && self getKtkStat(2363) == 1))
	{
		if(	getDvar("g_gametype") == "ktk" && !self HasPerk( "specialty_pistoldeath" )) 
			self SetPerk( "specialty_pistoldeath" );
			
		if(isDefined(self.pers["vip"]) && self.pers["vip"] && self getKtkStat(2380) != 2)
		{
			self giveWeapon("rpg_mp");
			self setWeaponAmmoClip("rpg_mp", 1);
			self setWeaponToSlot("rpg_mp");
			self setweaponammostock("rpg_mp", 0);
		}
	}
}

infiniteAmmo()
{
	self endon("disconnect");
	self endon("death");
	
	self notify("gungame_infinite_ammo");
	self endon("gungame_infinite_ammo");
	
	while(self.weaponstate == 1 || (self.weaponstate == 2 && self getKtkStat(2363) == 1))
	{
		self waittill("weapon_fired");
		
		if(self GetCurrentWeapon() == level.GunGameWeapons[self.weaponstate])
			self giveMaxAmmo(self GetCurrentWeapon());
	}
}

GungameForPlayer()
{
	self endon("disconnect");
	self endon("death");

	if(self isInRCToy())
		return false;

	if(self isInPredator())
		return false;
	
	if(self isTerminator())
		return false;
	
	if(self isInAC130())
		return false;
	
	if(self isInMannedHelicopterTurret())
		return false;
		
	return true;
}

RestartGungameUpgrade(spawned, switchWeapon)
{
	self endon("disconnect");
	self endon("death");

	wait .05;
	self thread WeaponState(spawned, switchWeapon);
}