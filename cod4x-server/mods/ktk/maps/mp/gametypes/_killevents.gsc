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

killEvents(victim, sWeapon, sHitLoc, sMeansOfDeath, predelay, psOffsetTime, iDamage, eInflictor)
{
	self endon("disconnect");
	self notify("made_a_kill");
	
	if(!isPlayer(self))// && !victim isKing())
		return;

	if(isDefined(victim) && isPlayer(victim) && !victim isABot() && victim != self)
		self.pers["totalkills"]++;
	
	if(self.cur_kill_streak > self.pers["killstreak"])
		self.pers["killstreak"] = self.cur_kill_streak;
		
	victim.lastattacker = self.name;
	victim.lastattackerEnt = self;
	BulletsInChamber = self getWeaponAmmoClip(sWeapon);
	thread maps\mp\gametypes\_awards::KillAwards(self, victim, sWeapon, sHitLoc, sMeansOfDeath, iDamage, BulletsInChamber);

	if(sWeapon == level.ktkWeapon["throwingKnife"] && (sMeansOfDeath == "MOD_IMPACT" || sMeansOfDeath == "MOD_GRENADE"))
	{
		//iPrintLn("^1" + victim.name + " ^1was killed by a throwing knife!");
		
		if(self hasWeapon(level.ktkWeapon["throwingKnife"]))
			self setWeaponAmmoClip(level.ktkWeapon["throwingKnife"], self getWeaponAmmoClip(level.ktkWeapon["throwingKnife"]) + 1);
		else
		{
			self giveWeapon(level.ktkWeapon["throwingKnife"]);
			self setWeaponAmmoClip(level.ktkWeapon["throwingKnife"], self getWeaponAmmoClip(level.ktkWeapon["throwingKnife"]) + 1);
			self switchToOffhand(level.ktkWeapon["throwingKnife"]);
		}
	}
	
	if(sWeapon == level.ktkWeapon["disruptor"])
		PlayFX(level._effect["distorted_death"], victim.origin);
	
	if(self isAGuard())
	{
		if(!isDefined(level.king))
			return;
	
		if(self isKing() && victim isAnAssassin())
		{
			if(game["customEvent"] == "hideandseek")
				return;

			if(!isOtherExplosive(sWeapon) && !isAGrenade(sWeapon) && !isHardpoint(sWeapon))
			{
				if(sWeapon != "" && sWeapon != "none" && sMeansOfDeath != "MOD_MELEE")
				{
					if(WeaponMaxAmmo(sWeapon) >= 10)
						self SetWeaponAmmoStock(sWeapon, self GetWeaponAmmoStock(sWeapon) + 10);
					else if(WeaponMaxAmmo(sWeapon) >= 5)
						self SetWeaponAmmoStock(sWeapon, self GetWeaponAmmoStock(sWeapon) + 5);
					else
						self SetWeaponAmmoStock(sWeapon, self GetWeaponAmmoStock(sWeapon) + 1);
				}
			}

			if(getDvarInt("scr_ktk_kingGungame") == 1)
			{			
				if(self.weaponstate < (level.GunGameWeapons.size-1) && !self isInRCToy() && !self isInMannedHelicopter() && !self isInAC130())
				{
					if(!isDefined(self.pers["actionslot"][3]["weapon"]) || sWeapon != self.pers["actionslot"][3]["weapon"])
					{
						if(game["customEvent"] != "knifeonly" && game["customEvent"] != "traitors")
						{
							self.weaponstate++;
							self thread maps\mp\gametypes\_gungame::WeaponState(false, false);
						}
					}
				}
			}
			
			if(victim isMainAssassin())
				return;

			if(victim isDog())
				return;
					
			if(victim isSlave())
				return;
			
			if(game["customEvent"] != "kingvsking")
			{
				if(getDvarInt("scr_ktk_assassin_switch") == 0)
					return;
						
				if(getDvarInt("scr_ktk_assassin_switch") == 1 && sWeapon != level.ktkWeapon["knife"] && sWeapon != level.ktkWeapon["katana"] && sWeapon != level.ktkWeapon["throwingKnife"] && sMeansOfDeath != "MOD_MELEE")
					return;
							
				if(getDvarInt("scr_ktk_assassin_switch") == 2 && (sMeansOfDeath == "MOD_EXPLOSIVE" || sWeapon == "cobra_20mm_mp" || sWeapon == "artillery_mp" || sWeapon == "airstrike_mp" || sWeapon == level.ktkWeapon["mortars"]|| sWeapon == level.ktkWeapon["ac130"]))
					return;
				
				maxGuardBots = getDvarInt("scr_ktk_bots_guardlimit");
				if(maxGuardBots > 0)
				{
					if(level.king isABot())
						maxGuardBots++;
				
					if(GetBotsInTeam(game["defenders"]) >= maxGuardBots)
						return;
				}
			}

			if(game["customEvent"] != "reversektk")
				victim thread MakeAssassinAGuard();
		}
		else if((self isKing() && self == victim) || (victim isKing() && sMeansOfDeath == "MOD_FALLING"))
		{
			if(game["customEvent"] != "kingvsking")
			{
				if(getDvarInt("scr_mod_finalkillcam_suicide") == 1)
				{
					if(game["customEvent"] == "traitors")
						thread maps\mp\gametypes\ktk::onEndGame("traitors", "KING_DIED", "died");
					else
						thread maps\mp\gametypes\ktk::onEndGame(game["attackers"], "KING_DIED", "died");
					
					thread maps\mp\gametypes\_finalkillcam::init(level.king, level.king, sWeapon, sMeansofDeath, predelay, psOffsetTime, eInflictor, true);
				}
			}
		}
		else if(!self isKing() && victim isAnAssassin())
		{
			if(game["customEvent"] == "hideandseek")
				return;
		
			if(self isTerminator())
				return;

			if(isDefined(level.ac130Player) && self == level.ac130Player)
				return;

			if(sWeapon == "airstrike_mp" || sWeapon == "artillery_mp" || sWeapon == level.ktkWeapon["mortars"] || sWeapon == "helicopter_mp" || sWeapon == "cobra_20mm_mp" || sWeapon == level.ktkWeapon["ac130"])
				return;

			if(self.weaponstate < (level.GunGameWeapons.size-1) && !self isInRCToy() && !self isInMannedHelicopter() && !self isInAC130())
			{
				if(!isDefined(self.pers["actionslot"][3]["weapon"]) || sWeapon != self.pers["actionslot"][3]["weapon"])
				{
					if(game["customEvent"] != "knifeonly" && game["customEvent"] != "traitors")
					{
						self.weaponstate++;
						self thread maps\mp\gametypes\_gungame::WeaponState(false, false);
					}
				}
			}
				
			if(game["customEvent"] == "kingvsking")
			{
				if(victim isMainAssassin())
					return;

				if(victim isDog())
					return;
						
				if(victim isSlave())
					return;
			
				victim thread MakeAssassinAGuard();
			}
			else
			{
				if(self isInLastStand())
				{
					scr_iPrintLn("EXTRA_LIFE_EARNED", self);
				
					self.pers["secondchance"] = true;
					self thread maps\mp\gametypes\_huds::ExtraLife();
				}
			}
		}
		else if(!self isKing() && victim isKing())
		{
			if(game["customEvent"] != "kingvsking")
			{
				//Show a finalkillcam when the king was hit by a carepackage
				if(sMeansOfDeath == "MOD_SUICIDE" && sWeapon == "none" && isDefined(eInflictor.type))
				{
					if(eInflictor.type == "carepackage" || eInflictor.type == "trappackage")
					{
						self.pers["kingskilled"]++;
						self.pers["kingkilltime"] = int(maps\mp\gametypes\_globallogic::getTimePassed()/1000);
						
						if(game["customEvent"] == "traitors")
							thread maps\mp\gametypes\ktk::onEndGame("traitors", "KING_DIED", "died");
						else
							thread maps\mp\gametypes\ktk::onEndGame(game["attackers"], "KING_DIED", "died");
						
						thread maps\mp\gametypes\_finalkillcam::init(self, victim, sWeapon, sMeansofDeath, predelay, psOffsetTime, eInflictor, true);
					}
				}
			}
		}
	}
	else if(self isAnAssassin())
	{
		if(victim == self)
		{
			if(game["customEvent"] != "reversektk")
				return;
		}
		
		if(!isDefined(level.assassin))
			return;
		
		if(game["customEvent"] == "kingvsking")
		{
			if(self isMainAssassin())
			{
				if(getDvarInt("scr_ktk_kingGungame") == 1)
				{			
					if(self.weaponstate < (level.GunGameWeapons.size-1) && !self isInRCToy() && !self isInMannedHelicopter() && !self isInAC130())
					{
						if(!isDefined(self.pers["actionslot"][3]["weapon"]) || sWeapon != self.pers["actionslot"][3]["weapon"])
						{
							if(game["customEvent"] != "knifeonly" && game["customEvent"] != "traitors")
							{
								self.weaponstate++;
								self thread maps\mp\gametypes\_gungame::WeaponState(false, false);
							}
						}
					}
				}
			}
			else
			{
				if(self.weaponstate < (level.GunGameWeapons.size-1) && !self isInRCToy() && !self isInMannedHelicopter() && !self isInAC130())
				{
					if(!isDefined(self.pers["actionslot"][3]["weapon"]) || sWeapon != self.pers["actionslot"][3]["weapon"])
					{
						if(game["customEvent"] != "knifeonly" && game["customEvent"] != "traitors")
						{
							self.weaponstate++;
							self thread maps\mp\gametypes\_gungame::WeaponState(false, false);
						}
					}
				}
			}
		}
		
		if(victim isKing())
		{
			if(game["customEvent"] != "kingvsking" && game["customEvent"] != "reversektk")
			{
				self.pers["kingskilled"]++;
				self.pers["kingkilltime"] = int(maps\mp\gametypes\_globallogic::getTimePassed()/1000);
				
				if(game["customEvent"] == "traitors")
					thread maps\mp\gametypes\ktk::onEndGame("traitors", "KING_DIED", "died");
				else
					thread maps\mp\gametypes\ktk::onEndGame(game["attackers"], "KING_DIED", "died");
				
				thread maps\mp\gametypes\_finalkillcam::init(self, victim, sWeapon, sMeansofDeath, predelay, psOffsetTime, eInflictor, false);
			}
		}
		else if(victim isTerminator() && getDvarInt("scr_ktk_terminator") == 1)
		{
			RadiusDamage(level.terminator.origin, 150 , 80 , 20, self);
			PlayFX(level._effect["barrelExp"], level.terminator.origin);
			level.terminator playsound("explo_mine");
			level.terminator = undefined;
		}
		else if((self isMainAssassin() && victim == self) || (victim isMainAssassin() && sMeansOfDeath == "MOD_FALLING"))
		{
			if(game["customEvent"] == "reversektk")
			{
				if(getDvarInt("scr_mod_finalkillcam_suicide") == 1)
				{
					thread maps\mp\gametypes\ktk::onEndGame(game["defenders"], "KING_DIED", "died");
					thread maps\mp\gametypes\_finalkillcam::init(level.assassin, level.assassin, sWeapon, sMeansofDeath, predelay, psOffsetTime, eInflictor, true);
				}
			}
		}
		else if(!self isMainAssassin() && victim isMainAssassin())
		{
			if(game["customEvent"] == "reversektk")
			{
				//Show a finalkillcam when the assassin was hit by a carepackage
				if(sMeansOfDeath == "MOD_SUICIDE" && sWeapon == "none" && isDefined(eInflictor.type))
				{
					if(eInflictor.type == "carepackage" || eInflictor.type == "trappackage")
					{
						self.pers["kingskilled"]++;
						self.pers["kingkilltime"] = int(maps\mp\gametypes\_globallogic::getTimePassed()/1000);
						thread maps\mp\gametypes\ktk::onEndGame(game["defenders"], "KING_DIED", "died");
						thread maps\mp\gametypes\_finalkillcam::init(self, victim, sWeapon, sMeansofDeath, predelay, psOffsetTime, eInflictor, false);
					}
				}
			}
		}
		else if(self isMainAssassin() && victim isAGuard())
		{
			if(victim isKing())
				return;
			
			if(game["customEvent"] == "reversektk")
				victim thread MakeAssassinAGuard();
		}
		
		self maps\mp\gametypes\_rank::giveRankXP( "kill", 150 );
		self notify ( "update_playerscore_hud" );
	}
}

MakeAssassinAGuard()
{
	self endon("disconnect");
	
	if(game["customEvent"] != "reversektk")
	{
		if(getDvarInt("scr_ktk_AssassinSwitchType") > 0)
		{
			if(isDefined(self.lastattackerEnt))
			{
				if(!self.lastattackerEnt isKing())
					return;
			}
		}
	}
	
	//self.switchedByKing = true;
				
	wait 1; //add a little delay so they see themself dying
			
	if(isDefined(self) && isPlayer(self))
		self [[level.switchTeam]](game["defenders"], false, true);
}

MakeGuardAnAssassin()
{
	self endon("disconnect");

	if(game["customEvent"] == "reversektk")
		return;
	
	if(getDvarInt("scr_ktk_GuardSwitchType") > 0)
	{
		if(isDefined(self.lastattackerEnt))
		{
			if(!self.lastattackerEnt isMainAssassin() && self.lastattackerEnt != self)
				return;
		}
	}
	
	if(!isDefined(self.pers["secondchance"]) || !self.pers["secondchance"])
	{
		wait 1; //add a short delay so players can see themselves die
		self [[level.switchTeam]](game["attackers"], false, true);
	}
	else
	{
		//wouldnt it be better here?
		self waittill("spawned_player");
				
		scr_iPrintLn("EXTRA_LIFE_USED", self);
				
		self.pers["secondchance"] = false;
					
		if(isDefined(self.extralifehud))
			self.extralifehud destroy();
	}
}