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
// Remember that some weapons got replace by new ones, so check the readme.txt
// before you change the weapons

#include maps\mp\gametypes\_misc;

init()
{
	if(getDvar("scr_mod_grenadelauncher") == "") setDvar("scr_mod_grenadelauncher", 1);
	if(getDvar("scr_king_primary") == "") setDvar("scr_king_primary", level.ktkWeapon["dbShotgun"]);
	if(getDvar("scr_king_secondary") == "") setDvar("scr_king_secondary", level.ktkWeapon["magnum"]);
	if(getDvar("scr_assassin_primary") == "") setDvar("scr_assassin_primary", level.ktkWeapon["crossbow"]);
	if(getDvar("scr_assassin_secondary") == "") setDvar("scr_assassin_secondary", level.ktkWeapon["mosinnagat"]);

	level.king_primary = getDvar("scr_king_primary");
	level.king_secondary = getDvar("scr_king_secondary");
	level.assassin_primary = getDvar("scr_assassin_primary");
	level.assassin_secondary = getDvar("scr_assassin_secondary");
}

giveWeapons()
{
	self endon("disconnect");
	self endon("death");

	self notify("giveKtkWeaponloadout");
	self endon("giveKtkWeaponloadout");
	
	if(!isDefined(self.pers["team"]))
	{
		DebugMessage(5, "The team of " + self.name + " is not defined!");
		return;
	}
	
	self ClearPerks();
	self TakeAllWeapons();

	if(self hasAttached("worldmodel_riot_shield_iw5"))
		self detach("worldmodel_riot_shield_iw5", "tag_weapon_left");

	if(self hasAttached("worldmodel_knife"))
		self detach("worldmodel_knife", "tag_weapon_left");
	
	wait .1; //WHY WAIT? //Well, else it's totally fucked up
	
	if(getDvarInt("scr_mod_grenadelauncher") == 1)
		self SetActionSlot(3, "altmode");	

	self SetHealth();
	self LoadOutPerks();
	self LoadOutPreviouslyGainedHardpoints();
	
	self setViewModel("viewmodel_base_viewhands");
	
	if(self isAGuard() || game["customEvent"] == "kingvsking" || game["customEvent"] == "lastkingstanding" || game["customEvent"] == "traitors")
	{
		if(game["customEvent"] == "hideandseek")
		{
			self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
			return;
		}

		if(self isKing() || game["customEvent"] == "lastkingstanding" || (self isMainAssassin() && game["customEvent"] == "kingvsking"))
		{
			if(getDvarInt("scr_ktk_kingGungame") == 0)
			{
				self LoadOutWeapons(level.king_primary, level.king_secondary);
				
				if(!isDefined(self.pers["actionslot"][3]["weapon"]) || self.pers["actionslot"][3]["weapon"] == "")
					self LoadOutExplosive("claymore_mp", 2);
				
				self detachAll();
				self thread maps\mp\gametypes\_bossmodels::SetBossModel();
				
				if(self getKtkStat(2361) == 1)
					self SetMoveSpeedScale( 1.05 );
				else
					self SetMoveSpeedScale( 0.9 );
					
				return;
			}
		}
		
		if(game["customEvent"] == "traitors")
		{
			self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
			self LoadOutWeapons(level.GunGameWeapons[randomInt(level.GunGameWeapons.size)], "nothing");
			self SetMoveSpeedScale( 1 );
		}
		else
		{
			self thread maps\mp\gametypes\_gungame::WeaponState(true, false);
			
			self.pers["primaryWeapon"] = "usp_mp";
			self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
		
			if(isDefined(self.pers["vip"]) && self.pers["vip"] && self getKtkStat(2380) != 2)
				self LoadOutExplosive("rpg_mp", 0);
				
			self SetMoveSpeedScale( 1 );
		}
		
		if(self isKing() || game["customEvent"] == "lastkingstanding")
		{
			self detachAll();
			self thread maps\mp\gametypes\_bossmodels::SetBossModel();

			if(self getKtkStat(2361) == 1)
				self SetMoveSpeedScale( 1.05 );
			else
				self SetMoveSpeedScale( 0.9 );
		}
	}
	else if(self isAnAssassin())
	{
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
	
		if((self isDog() && game["customEvent"] != "hideandseek") || game["customEvent"] == "dogfight")
		{
			self GiveWeapon( "defaultweapon_mp" );
			self SetSpawnWeapon( "defaultweapon_mp" );
			self.pers["primaryWeapon"] = "defaultweapon_mp";
			self SetMoveSpeedScale( 1.3 );
			self.assassintype = "dog";
		}
		else if(self isMainAssassin() && game["customEvent"] != "hideandseek")
		{
			self SetMoveSpeedScale( 1 );
			self.assassintype = "assassin";

			if(game["customEvent"] == "zombie" || game["customEvent"] == "knifeonly")
			{
				self.assassintype = "knife";

				self LoadOutWeapons(level.ktkWeapon["knife"], "nothing");			
				self SetMoveSpeedScale( 1.15 );
				return;
			}

			if(game["customEvent"] == "alien")
			{
				self LoadOutWeapons(level.ktkWeapon["disruptor"], "nothing");
				return;
			}
			
			if(game["customEvent"] == "terror")
			{
				if(!isDefined(level.BombPlanted) || !level.BombPlanted)
				{
					self LoadOutExplosive(level.ktkWeapon["c4bomb"], 0);
					self thread maps\mp\gametypes\_terror::monitorPossibleBombPlanting();
				}
			}
			
			self LoadOutWeapons(level.assassin_primary, level.assassin_secondary);
				
			if(game["customEvent"] != "sniperonly" && game["customEvent"] != "terror")
				self LoadOutExplosive(level.ktkWeapon["crossbowExp"], 0);
		}
		else
		{
			if(!isDefined(self.assassintype))
				self.assassintype = maps\mp\gametypes\ktk::GetRandomAssassinType();
		
			if(game["customEvent"] == "alien")
			{
				self LoadOutWeapons(level.ktkWeapon["disruptor"], "nothing");
				return;
			}
			
			if(game["customEvent"] == "hideandseek")
			{
				self SetMoveSpeedScale( 1 );
				self.assassintype = "assassin";
				
				self LoadOutWeapons("remington700_mp", level.ktkWeapon["intervention"]);
				return;
			}
		
			if(self.assassintype == "knife")
			{
				self LoadOutWeapons(level.ktkWeapon["knife"], "nothing");
				
				if(game["customEvent"] != "zombie" && game["customEvent"] != "knifeonly")
				{
					self LoadOutOffhand(level.ktkWeapon["throwingKnife"], 3);
					self LoadOutExplosive(level.ktkWeapon["javelin"], 0);
				}
				
				self SetMoveSpeedScale( 1.15 );
			}
			else if(self.assassintype == "katana")
			{
				self LoadOutWeapons(level.ktkWeapon["katana"], "nothing");
				self LoadOutExplosive(level.ktkWeapon["javelin"], 0);
				self SetMoveSpeedScale( 1.15 );
			}
			else if(self.assassintype == "bolt")
			{
				self LoadOutWeapons(level.ktkWeapon["mosinnagat"], "nothing");
				self LoadOutExplosive(level.ktkWeapon["javelin"], 0);
				self SetMoveSpeedScale( 1.05 );
			}
			else if(self.assassintype == "scope")
			{
				self LoadOutWeapons("remington700_mp", "nothing");
				self SetMoveSpeedScale( 1 );
			}
			else if(self.assassintype == "strongscope")
			{
				self LoadOutWeapons("m40a3_acog_mp", "nothing");
				self SetMoveSpeedScale( 1 );
			}
			else if(self.assassintype == "hardscope")
			{
				self LoadOutWeapons(level.ktkWeapon["intervention"], "nothing");
				self SetMoveSpeedScale( 1 );
			}
		}
	}
	
	//give unlockables last to avoid overwriting during class loadout
	//like rpg for vips would overwrite claymore/rpg/etc
	self LoadoutUnlockables(false);
}

SetHealth()
{
	self.maxhealth = 100;

	if(self isAGuard())
	{
		if(isDefined(self.pers["vip"]) && self.pers["vip"])
			self.maxhealth = 120;
	
		if(game["customEvent"] == "hideandseek")
			self.maxhealth = 1;
	
		if(self isKing())
		{
			self.maxhealth = getDvarInt("scr_ktk_king_health");
			
			if(game["customEvent"] == "reversektk")
				self.maxhealth = 100;
		}
	}
	else if(self isAnAssassin())
	{
		if(self isDog())
			self.maxhealth = getDvarInt("scr_ktk_dog_health");
		
		if(self isMainAssassin())
		{
			if(game["customEvent"] == "kingvsking" || game["customEvent"] == "reversektk")
				self.maxhealth = getDvarInt("scr_ktk_king_health");	
		}
		
		if(self.cur_death_streak >= 10)
			self.maxhealth += 20;
	}
	
	self.health = self.maxhealth;
}

LoadOutPreviouslyGainedHardpoints()
{
	self endon("disconnect");
	self endon("death");

	for(i=1;i<5;i++)
	{
		if(i==3) continue;

		if(game["customEvent"] != "kingvsking")
		{
			if(self isAnAssassin() && self.pers["actionslot"][i]["weapon"] != "marker_mp")
				continue;
		}

		if(game["customEvent"] == "traitors")
			self SetHardpointToSlot("weapon", self.pers["actionslot"][i]["weapon"], false, i);
		else
			self SetHardpointToSlot("weapon", self.pers["actionslot"][i]["weapon"], true, i);
	}
}

LoadOutWeapons(primary, secondary)
{
	self endon("disconnect");
	self endon("death");
	
	self.weaponCamo = 0;
	
	//weaponfiles which share multiple weapon models
	if(primary == level.ktkWeapon["knife"])
		self.weaponCamo = randomInt(4);
	else if(primary == level.ktkWeapon["katana"])
		self.weaponCamo = randomInt(3);
	else if(primary == level.ktkWeapon["mosinnagat"])
		self.weaponCamo = randomInt(2);
	else if(primary == "remington700_mp")
		self.weaponCamo = randomInt(2);
	
	self GiveWeapon(primary, self.weaponCamo);
	self GiveMaxAmmo(primary);
	
	if(secondary != "nothing")
	{
		self GiveWeapon(secondary);
		self GiveMaxAmmo(secondary);
	}
	
	self SetSpawnWeapon(primary);
	self.pers["primaryWeapon"] = primary;
}

LoadOutPerks()
{
	self endon("disconnect");
	self endon("death");
	
	if(game["customEvent"] == "lastkingstanding" || game["customEvent"] == "traitors" || game["customEvent"] == "hideandseek")
		return;
	
	if(self isAGuard() || game["customEvent"] == "kingvsking")
		self SetPerk( "specialty_pistoldeath" );
	else if(self isAnAssassin())
	{
		if(!self isDog())
			self SetPerk( "specialty_quieter" );
	}
}

LoadOutExplosive(weapon, ammo)
{
	self endon("disconnect");
	self endon("death");

	if(isDefined(self.pers["actionslot"][3]["weapon"]) && self.pers["actionslot"][3]["weapon"] != "")
		self takeWeapon(self.pers["actionslot"][3]["weapon"]);
	
	self giveWeapon(weapon);
	self setWeaponToSlot(weapon);
	
	self setWeaponAmmoClip(weapon, 1);
	
	if(ammo == 0)
	{
		if(weapon == level.ktkWeapon["crossbow"])
			self setWeaponAmmoClip(weapon, 0);
	}
	
	if(self isAGuard() || game["customEvent"] == "kingvsking" || game["customEvent"] == "lastkingstanding")
	{
		self setweaponammostock(weapon, ammo);
	}
	else if(self isAnAssassin())
	{
		if(weapon == level.ktkWeapon["javelin"])
		{
			self.javelinsFired = 0;
			self setweaponammostock( level.ktkWeapon["javelin"], level.JavelinMaxAmmo);
		}
		else if(weapon == level.ktkWeapon["crossbowExp"])
		{
			AttackingPlayers = GetPlayersInTeam(game["attackers"]);

			if(AttackingPlayers < getDvarInt("scr_assassin_explosive_teamSize"))
				self setweaponammostock( weapon, 2);
			else
				self setweaponammostock( weapon, 0);		
		}
	}
}

LoadOutOffhand(weapon, ammo)
{
	self endon("disconnect");
	self endon("death");

	if(weapon == level.ktkWeapon["throwingKnife"] || weapon == "frag_grenade_short_mp")
	{
		self giveWeapon( weapon );
		self setWeaponAmmoClip( weapon, ammo );
		self switchToOffhand( weapon );
	}
	else if(weapon == level.ktkWeapon["poisongas"])
	{
		self setOffhandSecondaryClass("smoke");
		self giveWeapon( weapon );
		self setWeaponAmmoClip( weapon, ammo );
	}
	else if(weapon == "flash_grenade_mp")
	{
		self setOffhandSecondaryClass("flash");
		self giveWeapon( weapon );
		self setWeaponAmmoClip( weapon, ammo );
	}
}

LoadoutUnlockables(revived)
{
	self endon("disconnect");
	self endon("death");

	if(game["customEvent"] == "hideandseek")
		return;
	
	//Perks
	if(self getKtkStat(2370) == 1)
		self setPerk("specialty_quieter");
	if(self getKtkStat(2371) == 1)
		self setPerk("specialty_holdbreath");
	if(self getKtkStat(2372) == 1)
		self setPerk("specialty_bulletaccuracy");
	if(self getKtkStat(2373) == 1)
		self setPerk("specialty_longersprint");
	if(self getKtkStat(2374) == 1)
		self setPerk("specialty_bulletpenetration");
	if(self getKtkStat(2375) == 1)
		self setPerk("specialty_rof");
	if(self getKtkStat(2376) == 1)
		self setPerk("specialty_bulletdamage");
	if(self getKtkStat(2377) == 1)
		self setPerk("specialty_explosivedamage");
	if(self getKtkStat(2378) == 1)
		self setPerk("specialty_fastreload");
	if(self getKtkStat(2379) == 1 && !self isDog())
		self setPerk("specialty_armorvest");
	
	if(game["customEvent"] == "knifeonly")
		return;
	
	//Equipments
	if((self isAGuard() || game["customEvent"] == "kingvsking") && (!isDefined(revived) || !revived))
	{
		switch(self getKtkStat(2380))
		{
			case 1: self LoadOutExplosive(level.ktkWeapon["crossbow"], self getKtkStat(2382) * 3); break;
			case 2: self LoadOutExplosive("claymore_mp", self getKtkStat(2383)); break;
			case 3: self LoadOutOffhand("frag_grenade_short_mp", self getKtkStat(2384)); break;
			case 4: self LoadOutOffhand(level.ktkWeapon["throwingKnife"], self getKtkStat(2385)); break;
			case 5: self LoadOutOffhand(level.ktkWeapon["poisongas"], self getKtkStat(2386)); break;
			case 6: self LoadOutExplosive(level.ktkWeapon["riotshield"], 1); break;
			default: break;
		}
	}
}