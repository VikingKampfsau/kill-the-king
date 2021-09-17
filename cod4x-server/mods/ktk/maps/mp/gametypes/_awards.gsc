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
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_misc;

init()
{
	if(getDvar("scr_hardpoint_guard_rccar") == "") setDvar("scr_hardpoint_guard_rccar", 3);
	if(getDvar("scr_hardpoint_guard_rchelicopter") == "") setDvar("scr_hardpoint_guard_rchelicopter", 3);
	if(getDvar("scr_hardpoint_guard_poison") == "") setDvar("scr_hardpoint_guard_poison", 5);
	if(getDvar("scr_hardpoint_carepackage") == "") setDvar("scr_hardpoint_carepackage", 5);
	if(getDvar("scr_hardpoint_guard_airstrike") == "") setDvar("scr_hardpoint_guard_airstrike", 7);
	if(getDvar("scr_hardpoint_guard_mortar") == "") setDvar("scr_hardpoint_guard_mortar", 9);
	if(getDvar("scr_hardpoint_guard_helicopter") == "") setDvar("scr_hardpoint_guard_helicopter", 12);
	if(getDvar("scr_hardpoint_guard_ac130") == "") setDvar("scr_hardpoint_guard_ac130", 20);
	if(getDvar("scr_hardpoint_guard_juggernaut") == "") setDvar("scr_hardpoint_guard_juggernaut", 20);
	
	if(getDvar("scr_hardpoint_assassin_m21") == "") setDvar("scr_hardpoint_assassin_m21", 3);
	if(getDvar("scr_hardpoint_helicoptertype") == "") setDvar("scr_hardpoint_helicoptertype", 0);
	if(getDvar("scr_hardpoint_king_weapon") == "") setDvar("scr_hardpoint_king_weapon", level.ktkWeapon["ump45Silencer"]);
	if(getDvar("scr_hardpoint_repeat") == "" ) setDvar("scr_hardpoint_repeat", "0" );
	if(getDvar("scr_hardpoint_system") == "") setDvar("scr_hardpoint_system", 0);
	if(getDvar("scr_hardpoint_kingsystem") == "") setDvar("scr_hardpoint_kingsystem", 0);
	
	if(getDvarInt("scr_hardpoint_system") >= 1)
	{
		if(getDvar("scr_hardpoint_guard_rccar") == "") setDvar("scr_hardpoint_guard_rccar", 3);
		if(getDvar("scr_hardpoint_guard_rchelicopter") == "") setDvar("scr_hardpoint_guard_rchelicopter", 3);
		if(getDvar("scr_hardpoint_guard_poison") == "") setDvar("scr_hardpoint_guard_poison", 5);
		if(getDvar("scr_hardpoint_carepackage") == "") setDvar("scr_hardpoint_carepackage", 5);
		if(getDvar("scr_hardpoint_guard_airstrike") == "") setDvar("scr_hardpoint_guard_airstrike", 7);
		if(getDvar("scr_hardpoint_guard_mortar") == "") setDvar("scr_hardpoint_guard_mortar", 9);
		if(getDvar("scr_hardpoint_guard_helicopter") == "") setDvar("scr_hardpoint_guard_helicopter", 12);
		if(getDvar("scr_hardpoint_guard_ac130") == "") setDvar("scr_hardpoint_guard_ac130", 18);
		if(getDvar("scr_hardpoint_guard_SentryGun") == "") setDvar("scr_hardpoint_guard_SentryGun", 24);
		if(getDvar("scr_hardpoint_guard_Predator") == "") setDvar("scr_hardpoint_guard_Predator", 30);
		if(getDvar("scr_hardpoint_guard_Nuke") == "") setDvar("scr_hardpoint_guard_Nuke", 45);
	}
	
	if(getDvarInt("scr_hardpoint_kingsystem") == 1)
		level.kingUsesNewSystem = true;
	else
	{
		level.kingUsesNewSystem = false;
		thread initKingHardpoints();
	}
		

	level.lasthardpoint = GetLastHardpoint();
	
	if(!isDefined(level.lasthardpoint) || level.lasthardpoint == "") setDvar("scr_hardpoint_repeat", "0" );
	
	level.hardpointItems = [];
	level.hardpointItems[level.ktkWeapon["rccar"]] = GetDvarInt("scr_hardpoint_guard_rccar");
	level.hardpointItems[level.ktkWeapon["marker"]] = GetDvarInt("scr_hardpoint_carepackage");
	level.hardpointItems["airstrike_mp"] = GetDvarInt("scr_hardpoint_guard_airstrike");
	level.hardpointItems[level.ktkWeapon["mortars"]] = GetDvarInt("scr_hardpoint_guard_mortar");
	level.hardpointItems["helicopter_mp"] = GetDvarInt("scr_hardpoint_guard_helicopter");
	level.hardpointItems[level.ktkWeapon["ac130"]] = GetDvarInt("scr_hardpoint_guard_ac130");
	level.hardpointItems[level.ktkWeapon["juggernaut"]] = GetDvarInt("scr_hardpoint_guard_juggernaut");
	
	if(isDefined(level.lasthardpoint))
	{
		level.hardpointItems[level.ktkWeapon["predator"]] = GetDvarInt("scr_hardpoint_guard_" + level.lasthardpoint);
		level.hardpointItems[level.ktkWeapon["sentrygun"]] = GetDvarInt("scr_hardpoint_guard_" + level.lasthardpoint);
		level.hardpointItems[level.ktkWeapon["nuke"]] = GetDvarInt("scr_hardpoint_guard_" + level.lasthardpoint);				
	}
}

checkForHardpointUpdateOnSpawn()
{
	self endon("disconnect");

	if(getDvarInt("scr_hardpoint_system") == 1)
	{
		count = 0;

		for(i=2388;i<=2398;i++)
		{
			if(self getKtkStat(i) == 1)
				count++;
		}
		
		if(count > 0)
			self.pers["update_selected_hardpoints"] = true;
		else
		{
			self.pers["update_selected_hardpoints"] = false;
			scr_iPrintLnBold("HARDPOINT_SYSTEM_NEW_INFO", self);
		}
		
		if(isDefined(self.pers["update_selected_hardpoints"]) && self.pers["update_selected_hardpoints"])
		{
			self.forceHardpointUpdate = true;
			self thread UpdateHardpointSelection();
		}
	}
}

initKingHardpoints()
{
	current = 1;
	level.kingHardpoint = [];
	
	if(getDvar("scr_hardpoint_king_1") == "") setDvar("scr_hardpoint_king_1", "perk;fastreload;3");
	
	while(1)
	{
		kingHardpoint = getDvar("scr_hardpoint_king_" + current);
		
		if(kingHardpoint == "")
			break;
		
		slot = level.kingHardpoint.size;
		level.kingHardpoint[slot] = strTok(kingHardpoint, ";");

		//I have seen some wrong weapon names used for hardpoints so i have to recheck the name
		level.kingHardpoint[slot][1] = AssignCorrectHardpointWeapon(level.kingHardpoint[slot][1]);
		
		if(isSubStr(level.kingHardpoint[slot][1], "_mp"))
			level.kingHardpoint[slot][1] = getSubStr(level.kingHardpoint[slot][1], 0, level.kingHardpoint[slot][1].size - 3);

		level.kingHardpoint[slot][2] = int(level.kingHardpoint[slot][2]);
		
		current++;
		wait .1;
	}

	//Check if they are allowed on map
	for(i=0;i<level.kingHardpoint.size;i++)
	{
		if(level.kingHardpoint[i][0] != "hardpoint")
			continue;
	
		if(!isEnabledOnMap(getHardpointNameFromWeapon(level.kingHardpoint[i][1] + "_mp"), undefined, false))
		{
			//logPrint(getHardpointNameFromWeapon(level.kingHardpoint[i][1] + "_mp") + " is disabled on this map - replacing with a random hardpoint!\n");

			level.king_hardpointReplacement = [];
			level.king_hardpointReplacement[0] = "rccar";
			level.king_hardpointReplacement[1] = "rccar";
			level.king_hardpointReplacement[2] = "rccar";
			level.king_hardpointReplacement[3] = "rccar";
			level.king_hardpointReplacement[4] = "rccar";
			level.king_hardpointReplacement[5] = "poison";
			level.king_hardpointReplacement[6] = "poison";
			level.king_hardpointReplacement[7] = "poison";
			level.king_hardpointReplacement[8] = "poison";
			level.king_hardpointReplacement[9] = "poison";
			level.king_hardpointReplacement[10] = "airstrike";
			level.king_hardpointReplacement[11] = "airstrike";
			level.king_hardpointReplacement[12] = "airstrike";
			level.king_hardpointReplacement[13] = "airstrike";
			level.king_hardpointReplacement[14] = "mortar";
			level.king_hardpointReplacement[15] = "mortar";
			level.king_hardpointReplacement[16] = "mortar";
			level.king_hardpointReplacement[17] = "mortar";
			level.king_hardpointReplacement[18] = "predator";
			level.king_hardpointReplacement[19] = "predator";
			level.king_hardpointReplacement[20] = "predator";
			level.king_hardpointReplacement[21] = "predator";
			level.king_hardpointReplacement[22] = "helicopter";
			level.king_hardpointReplacement[23] = "helicopter";
			level.king_hardpointReplacement[24] = "sentrygun";
			level.king_hardpointReplacement[25] = "sentrygun";
			/*level.king_hardpointReplacement[26] = "ac130";
			level.king_hardpointReplacement[27] = "nuke";*/

			level.king_hardpointReplacement = shuffleArray(level.king_hardpointReplacement);
			
			while(1)
			{
				wait .05;
				
				//wow we really did not find a replacement
				if(!isDefined(level.king_hardpointReplacement) || !level.king_hardpointReplacement.size)
				{
					//logPrint("Unable to replace hardpoint - Changing order!\n");
				
					for(i=i;i<(level.kingHardpoint.size -1);i++)
						level.kingHardpoint[i] = level.kingHardpoint[i+1];
						
					level.kingHardpoint[level.kingHardpoint.size-1] = undefined;
					break;
				}
			
				level.kingHardpoint[i][1] = level.king_hardpointReplacement[randomInt(level.king_hardpointReplacement.size)];
				
				if(!isEnabledOnMap(level.kingHardpoint[i][1], undefined, false))
				{
					removeHardpointFromTries(level.kingHardpoint[i][1]);
					continue;
				}
				
				level.kingHardpoint[i][1] = AssignCorrectHardpointWeapon(level.kingHardpoint[i][1]);
				
				if(!KingHardpointAlreadyInUse(i, level.kingHardpoint[i][1]))
				{
					//logPrint("Replaced with " + getHardpointNameFromWeapon(level.kingHardpoint[i][1] + "_mp") + "\n");
					break;
				}
			}
		}
	}
	
	//logPrint("end \n");
	
	//for(i=0;i<level.kingHardpoint.size;i++)
	//	logPrint("King hardpoint: " + level.kingHardpoint[i][1] + " - " + level.kingHardpoint[i][2] + " kills \n");
}

removeHardpointFromTries(hardpoint)
{
	if(level.king_hardpointReplacement.size > 0)
	{
		for(i=0;i<level.king_hardpointReplacement.size;i++)
		{
			if(isDefined(level.king_hardpointReplacement[i]) && level.king_hardpointReplacement[i] == hardpoint)
			{
				for(j=i;j<level.king_hardpointReplacement.size-1;j++)
					level.king_hardpointReplacement[j] = level.king_hardpointReplacement[j+1];
				
				level.king_hardpointReplacement[level.king_hardpointReplacement.size-1] = undefined;
			}
		}
	}
	
	updatedArray = [];
	for(i=0;i<level.king_hardpointReplacement.size;i++)
	{
		if(isDefined(level.king_hardpointReplacement[i]))
			updatedArray[updatedArray.size] = level.king_hardpointReplacement[i];
	}
	
	level.king_hardpointReplacement = updatedArray;
}

KingHardpointAlreadyInUse(curSlot, hardpointWeapon)
{
	for(i=0;i<level.kingHardpoint.size;i++)
	{
		if(i == curSlot)
			continue;
	
		if(hardpointWeapon == level.kingHardpoint[i][1])
			return true;
	}
	
	return false;
}

AssignCorrectHardpointWeapon(curName)
{
	weapon = StrToK(curName, " ");
	string = toLower(weapon[0]);

	if(isSubStr(string, "_mp"))
		string = getSubStr(string, 0, string.size-3);	

	switch(string)
	{
		case "cp":						weapon = level.ktkWeapon["marker"]; break;
		case "carepackage":				weapon = level.ktkWeapon["marker"]; break;
		case "crossbow":				weapon = level.ktkWeapon["crossbow"]; break;
		case "crossbowexplosive":		weapon = level.ktkWeapon["crossbowExp"]; break;
		case "explosivecrossbow":		weapon = level.ktkWeapon["crossbowExp"]; break;
		case "intervention":			weapon = level.ktkWeapon["intervention"]; break;
		case "magnum":					weapon = level.ktkWeapon["magnum"]; break;
		case "mg42":					weapon = level.ktkWeapon["mg42"]; break;
		case "minigun": 				weapon = level.ktkWeapon["minigun"]; break;
		case "mortar":					weapon = level.ktkWeapon["mortars"]; break;
		case "mortars":					weapon = level.ktkWeapon["mortars"]; break;
		case "mosin":					weapon = level.ktkWeapon["mosinnagat"]; break;
		case "mosinnagat":				weapon = level.ktkWeapon["mosinnagat"]; break;
		case "m21":						weapon = level.ktkWeapon["m21Silencer"]; break;
		case "silenced":				weapon = level.ktkWeapon["m21Silencer"]; break;
		case "silencedm21":				weapon = level.ktkWeapon["m21Silencer"]; break;
		case "throwing":				weapon = level.ktkWeapon["throwingKnife"]; break;
		case "throwingknife":			weapon = level.ktkWeapon["throwingKnife"]; break;
		case "rc":						weapon = level.ktkWeapon["rccar"]; break;
		case "rccar":					weapon = level.ktkWeapon["rccar"]; break;
		case "poison":					weapon = level.ktkWeapon["poisongas"]; break;
		case "poisongrenade":			weapon = level.ktkWeapon["poisongas"]; break;
		case "knife":					weapon = level.ktkWeapon["knife"]; break;
		case "ump45":					weapon = level.ktkWeapon["ump45"]; break;
		case "mp5_silencer":			weapon = level.ktkWeapon["ump45"]; break;
		case "famas":					weapon = level.ktkWeapon["famas"]; break;
		case "ac130":					weapon = level.ktkWeapon["ac130"]; break;
		case "aug":						weapon = level.ktkWeapon["aug"]; break;
		case "sentrygun":				weapon = level.ktkWeapon["sentrygun"]; break;
		case "sentry":					weapon = level.ktkWeapon["sentrygun"]; break;
		case "predator":				weapon = level.ktkWeapon["predator"]; break;
		case "nuke":					weapon = level.ktkWeapon["nuke"]; break;
		case "katana":					weapon = level.ktkWeapon["katana"]; break;
		default:						weapon = curName; break;
	}
	
	if(isSubStr(weapon, "_mp"))
		return getSubStr(weapon, 0, weapon.size-3);

	return weapon;
}

ReviveAward()
{
	if(!isDefined(self))
		return;

	if(!isDefined(self.msginprogress))
		self.msginprogress = false;
		
	self GiveAward("MEDIC", "MEDIC_DESC", 50);
}

SurviveAward()
{
	if(!isDefined(self))
		return;

	if(!isDefined(self.msginprogress))
		self.msginprogress = false;

	self GiveAward("COFFIN_DODGER", "COFFIN_DODGER_DESC", 25);
}

HitAwards(attacker, victim, sWeapon, sHitLoc, sMeansOfDeath)
{
	if(!isDefined(attacker) || !isDefined(victim))
		return;

	if(!isDefined(attacker.msginprogress))
		attacker.msginprogress = false;

	if(attacker != victim && sWeapon == level.ktkWeapon["crossbowExp"] && sMeansOfDeath == "MOD_IMPACT" && attacker.pers["team"] != victim.pers["team"])
		attacker GiveAward("STUCK", "STUCK_DESC", 50);
}

KillAwards(attacker, victim, sWeapon, sHitLoc, sMeansOfDeath, iDamage, BulletsInChamber)
{
	attacker endon("disconnect");
	attacker endon("death");

	if(!isDefined(attacker) || !isPlayer(attacker))
		return;
	
	if(!isDefined(victim) || !isPlayer(victim))
		return;
	
	attacker thread maps\mp\gametypes\_missions::processChallenge( "ch_ktk_unstoppable_" );	
	
	if(!isDefined(attacker.msginprogress))
		attacker.msginprogress = false;
	
	if(attacker != victim && !victim isKing())
	{
		attacker thread GiveGainedHardpoint(sWeapon);
		attacker thread StreakMessage();
	
		if( !isDefined( level.firstblood ) || !level.firstblood)
		{
			level.firstblood = true;
			attacker GiveAward("FIRST_BLOOD", "FIRST_BLOOD_DESC", 100);
		}
	
		if(attacker.cur_death_streak >= 3)
			attacker GiveAward("COMEBACK", "COMEBACK_DESC", 100);
	
		if(isDefined(victim) && isDefined(attacker.lastattacker) && isDefined(victim.name) && victim.name == attacker.lastattacker)
			attacker GiveAward("PAYBACK", "PAYBACK_DESC", 50);
			
		if(isDefined(victim) && isDefined(victim.origin) && distance(victim.origin, attacker.origin) > 3000 && sMeansOfDeath != "MOD_MELEE" && !attacker isKing() && !attacker isDog() && !isSniper(sWeapon))
			attacker GiveAward("LONGSHOT", "LONGSHOT_DESC", 30);
			
		if(isDefined(victim) && isDefined(victim.angles) && (sMeansOfDeath == "MOD_MELEE" || sWeapon == level.ktkWeapon["knife"]) && attacker.angles[1] - victim.angles[1] <= 65 && attacker.angles[1] - victim.angles[1] >= -65)
			attacker GiveAward("BACKSTABBER", "BACKSTABBER_DESC", 30);
			
		if(sMeansOfDeath == "MOD_HEAD_SHOT")
		{
			if(isDefined(victim) && victim isInLastStand())
				attacker GiveAward("EXECUTION", "EXECUTION_DESC", 50);
			else
			{
				attacker.lastattacker = undefined;
				attacker GiveAward("HEADSHOT", "HEADSHOT_DESC", 20);
			}
		}
		
		if(	!isHardpoint(sWeapon) && !isAGrenade(sWeapon) && !isOtherExplosive(sWeapon) && BulletsInChamber == 0 && sMeansofDeath != "MOD_MELEE" )
		{
			if(self isInAC130() || self isInMannedHelicopterTurret())
				return;
		
			if(getDvarInt("scr_gungame_autoswitch") == 0 || (getDvarInt("scr_gungame_autoswitch") == 1 && attacker isAnAssassin()))
				attacker GiveAward("ONE_IN_CHAMBER", "ONE_IN_CHAMBER_DESC", 50);
		}

		if(!attacker isonGround() && (sMeansOfDeath == "MOD_MELEE" || sWeapon == level.ktkWeapon["knife"]))
			attacker GiveAward("FALCON", "FALCON_DESC", 50);
		
		if(isDefined(victim) && isDefined(victim.pers["team"]))
		{
			if(	victim isAnAssassin() && getDvarInt("scr_hardpoint_assassin_m21") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_assassin_m21")-1)
					attacker GiveAward("BUZZKILL", "BUZZKILL_DESC", 100);
			
			if(victim isAGuard() && 
			  (getDvarInt("scr_hardpoint_guard_rccar") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_guard_rccar")-1 ||
			   getDvarInt("scr_hardpoint_guard_rchelicopter") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_guard_rchelicopter")-1 ||
			   getDvarInt("scr_hardpoint_guard_poison") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_guard_poison")-1 ||
			   getDvarInt("scr_hardpoint_guard_airstrike") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_guard_airstrike")-1 ||
			   getDvarInt("scr_hardpoint_guard_mortar") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_guard_mortar")-1 ||
			   getDvarInt("scr_hardpoint_guard_helicopter") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_guard_helicopter")-1 ||
			   getDvarInt("scr_hardpoint_guard_ac130") > 1 && victim.cur_kill_streak == getDvarInt("scr_hardpoint_guard_ac130")-1)
			   )
					attacker GiveAward("BUZZKILL", "BUZZKILL_DESC", 100);
		}	
		
		if(sWeapon == level.ktkWeapon["throwingKnife"])
			attacker GiveAward("SKEWER", "SKEWER_DESC", 50);
	}
}

GiveGainedHardpoint(sWeapon)
{
	self endon("disconnect");
	self endon("death");

	if(game["customEvent"] == "reversektk" || game["customEvent"] == "lastkingstanding" || game["customEvent"] == "zombie" || game["customEvent"] == "revolt" || game["customEvent"] == "knifeonly" || game["customEvent"] == "hideandseek")
		return;
	
	if(getDvarInt("scr_hardpoint_system") == 0)
	{
		if(self isInAC130() || self isInMannedHelicopterTurret())
			return;
		
		if(sWeapon == level.ktkWeapon["ac130"] || sWeapon == "helicopter_mp" || sWeapon == level.ktkWeapon["mortars"] || sWeapon == "airstrike_mp" || sWeapon == "cobra_20mm_mp" || sWeapon == "ac130_25mm_mp" || sWeapon == "ac130_40mm_mp" || sWeapon == "ac130_105mm_mp")
			return;
	}

	received = undefined;
	self.pers["hardPointItem"] = undefined;
	
	if(self isAGuard() || game["customEvent"] == "kingvsking")
	{
		if(!self isKing() || (self isKing() && level.kingUsesNewSystem) || game["customEvent"] == "kingvsking")
		{
			//if(self.cur_kill_streak == 1)
			//	self SetPerk("specialty_fastreload");

			if(getDvarInt("scr_hardpoint_guard_rccar") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_rccar") && self HasChosenHardpoint(level.ktkWeapon["rccar"]) && self isEnabledOnMap("rccar", "RC-XD", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["rccar"]) && self getKtkStat(2399) == 0)
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["rccar"], true);
			else if(getDvarInt("scr_hardpoint_guard_rchelicopter") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_rchelicopter") && self HasChosenHardpoint(level.ktkWeapon["rccar"]) && self isEnabledOnMap("rccar", "RC-XD", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["rccar"]) && self getKtkStat(2399) == 1)
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["rccar"], true);
			else if(getDvarInt("scr_hardpoint_guard_airstrike") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_airstrike") && self HasChosenHardpoint("airstrike_mp") && self isEnabledOnMap("airstrike", "airstrike", true) && !self AlreadyHasThisHardpoint("airstrike_mp"))
				received = self SetHardpointToSlot("weapon", "airstrike_mp", true);
			else if(getDvarInt("scr_hardpoint_guard_mortar") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_mortar") && self HasChosenHardpoint(level.ktkWeapon["mortars"]) && self isEnabledOnMap("mortar", "mortar", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["mortars"]))
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["mortars"], true);
			else if(getDvarInt("scr_hardpoint_guard_ac130") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_ac130") && self HasChosenHardpoint(level.ktkWeapon["ac130"]) && self isEnabledOnMap("ac130", "ac130", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["ac130"]))
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["ac130"], true);
			else if(getDvarInt("scr_hardpoint_guard_juggernaut") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_juggernaut") && self HasChosenHardpoint(level.ktkWeapon["juggernaut"]) && self isEnabledOnMap("juggernaut", "juggernaut", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["juggernaut"]))
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["juggernaut"], true);
			else if(getDvarInt("scr_hardpoint_carepackage") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_carepackage") && self HasChosenHardpoint(level.ktkWeapon["marker"]) && self isEnabledOnMap("cp", "carepackage", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["marker"]))
			{
				self.pers["carepackagetype"] = "carepackage";
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["marker"], true);
			}
			else if(getDvarInt("scr_hardpoint_guard_poison") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_poison") && self HasChosenHardpoint(level.ktkWeapon["poisongas"]) && self isEnabledOnMap("poison", "poison grenade", true))
			{
				if(self getKtkStat(2386) > 0 && self HasWeapon(level.ktkWeapon["poisongas"]))
					self setWeaponAmmoClip(level.ktkWeapon["poisongas"], self getWeaponAmmoClip(level.ktkWeapon["poisongas"]) + 1);
				else
				{
					self giveWeapon(level.ktkWeapon["poisongas"]);
					self setWeaponAmmoClip(level.ktkWeapon["poisongas"], 1);
				}
						
				self switchToOffhand(level.ktkWeapon["poisongas"]);
			}
			else if(getDvarInt("scr_hardpoint_guard_helicopter") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_helicopter") && self HasChosenHardpoint("helicopter_mp") && self isEnabledOnMap("heli", "helicopter", true) && !self AlreadyHasThisHardpoint("helicopter_mp"))
			{
				if(isDefined(level.heli_paths))
					weapon = "helicopter_mp";
				else
					weapon = self GetFollowingHardpoint();

				if(isDefined(weapon))
				{
					if(weapon != level.ktkWeapon["poisongas"])
						received = self SetHardpointToSlot("weapon", weapon, true);
					else
					{
						self giveWeapon( weapon );
						self setWeaponAmmoClip( weapon, 1 );
						self switchToOffhand( weapon );
					}
				}
			}
			else if(getDvarInt("scr_hardpoint_system") == 1 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_sentrygun") && self HasChosenHardpoint(level.ktkWeapon["sentrygun"]) && self isEnabledOnMap("sentrygun", "sentrygun", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["sentrygun"]))
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["sentrygun"], true);
			else if(getDvarInt("scr_hardpoint_system") == 1 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_predator") && self HasChosenHardpoint(level.ktkWeapon["predator"]) && self isEnabledOnMap("predator", "predator", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["predator"]))
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["predator"], true);
			else if(getDvarInt("scr_hardpoint_system") == 1 && self.cur_kill_streak == getDvarInt("scr_hardpoint_guard_nuke") && self HasChosenHardpoint(level.ktkWeapon["nuke"]) && self isEnabledOnMap("nuke", "nuke", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["nuke"]))
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["nuke"], true);
				
			if(getDvarInt("scr_hardpoint_repeat") == 1)
			{
				if(getDvarInt("scr_hardpoint_system") == 0)
					lasthardpoint = level.lasthardpoint;
				else
					lasthardpoint = self.lasthardpoint;
			
				if(isDefined(lasthardpoint) && lasthardpoint != "" && self.cur_kill_streak >= getDvarInt("scr_hardpoint_guard_" + lasthardpoint))
				{
					//do only reset the streak when he has no hardpoints left (no that sucks)
					//if(self HasHardPoint())
					//	return;
				
					if(self isInAC130() || self isInMannedHelicopterTurret() || self isInRCToy())
						return;
						
					self.cur_kill_streak = 0;
				}
			}
		}
		else if(self isKing() && !level.kingUsesNewSystem)
		{
			if(isDefined(level.kingHardpoint) && level.kingHardpoint.size)
			{
				for(i=0;i<level.kingHardpoint.size;i++)
				{
					if(self.cur_kill_streak == level.kingHardpoint[i][2])
					{
						if(level.kingHardpoint[i][0] == "perk")
							self SetPerk("specialty_" + level.kingHardpoint[i][1]);
						else if(level.kingHardpoint[i][0] == "hardpoint" || level.kingHardpoint[i][0] == "weapon")
						{
							weapon = level.kingHardpoint[i][1];
						
							if(getSubStr(weapon, 0, weapon.size - 3) != "_mp")
								weapon = level.kingHardpoint[i][1] + "_mp";
						
							if(isHardpoint(weapon) && !self AlreadyHasThisHardpoint(weapon))
							{
								if(self isEnabledOnMap(weapon, getSubStr(weapon, 0, weapon.size - 3), true))
									received = self SetHardpointToSlot("weapon", weapon, true);
							}
							else if(isAGrenade(weapon))
							{
								if(!self hasWeapon(weapon))
								{
									self giveWeapon(weapon);
									wait .05; 
									self setWeaponAmmoClip(weapon, 0);
								}
								
								self switchToOffhand(weapon);
								self setWeaponAmmoClip(weapon, self getWeaponAmmoClip(weapon) + 1);
							}
							else if(isOtherExplosive(weapon))
							{
								if(!self hasWeapon(weapon))
								{
									self giveWeapon(weapon);
									wait .05; 
									self setWeaponAmmoClip(weapon, 0);
								}
								
								self setWeaponToSlot(weapon);
								self setWeaponAmmoStock(weapon, 0);
								self setWeaponAmmoClip(weapon, self getWeaponAmmoClip(weapon) + 1);
							}
							else
							{
								//Just in case it's maybe a wrong defined hardpoint
								if(isDefined(weapon) && isHardpoint(weapon))
								{
									if(!self AlreadyHasThisHardpoint(weapon))
									{
										self giveWeapon(weapon); 
										self giveMaxAmmo(weapon);
										wait .05;
										received = self SetHardpointToSlot("weapon", weapon, false);
									}
								}
								else
								{
									if(!self isABot())
									{
										if(!isDefined(self.gungamehint))
											self thread maps\mp\gametypes\_huds::gungameHUD();
								
										while(!self UseButtonPressed())
											wait .05;
										
										if(isDefined(self.gungamehint))
											self.gungamehint destroy();
								
										if(!self hasWeapon(weapon))
										{
											self giveWeapon(weapon); 
											self giveMaxAmmo(weapon);
											wait .05;
										}
										
										self switchtoWeapon(weapon);
									}
									else
									{
										if(!self hasWeapon(weapon))
										{
											self giveWeapon(weapon); 
											self giveMaxAmmo(weapon);
											wait .05;
										}
										
										self setSpawnWeapon(weapon);
									}
								}
							}
						}
					
						break;
					}
				}
			}
		}

		//when a player gained a hardpoint while he is inside an other one
		//then he will loose it as soon as he leaves the current hardpoint
		//this should fix it
		if(isDefined(received))
		{
			if(!isDefined(self.awaitingHardpoints))
				self.awaitingHardpoints = [];

			if(self isInRCToy() || self isInPredator() || self isInAC130() || self isInMannedHelicopter() || self isInParachute())
			{
				self takeWeapon(received);
				self.awaitingHardpoints[self.awaitingHardpoints.size] = received;
			}
		}
	}
	else if(self isAnAssassin())
	{
		if(game["customEvent"] == "dogfight")
			return;
	
		if(self isDog())
		{
			if(self.cur_kill_streak == 3)
				self thread maps\mp\gametypes\_dogsniff::sniffForEnemies();
		}
		else
		{
			if(self.cur_kill_streak == 1)
				self SetPerk("specialty_longersprint");
	
			if(self.cur_kill_streak == 2)
				self SetPerk("specialty_bulletaccuracy");
			
			if(self.cur_kill_streak == 3)
				self SetPerk("specialty_extraammo");
				
			if(getDvarInt("scr_hardpoint_assassin_knife") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_assassin_knife"))
			{
				self giveWeapon( level.ktkWeapon["throwingKnife"] );
				self setWeaponAmmoClip( level.ktkWeapon["throwingKnife"], 3 );
				self switchToOffhand( level.ktkWeapon["throwingKnife"] );
			}
			else if(getDvarInt("scr_hardpoint_assassin_m21") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_assassin_m21"))
			{
				if(!self isABot())
				{
					if(!isDefined(self.gungamehint))
						self thread maps\mp\gametypes\_huds::gungameHUD();
			
					while(!self UseButtonPressed())
						wait .05;
					
					if(isDefined(self.gungamehint))
						self.gungamehint destroy();
				
					self giveWeapon(level.ktkWeapon["m21Silencer"]); 
					self giveMaxAmmo( level.ktkWeapon["m21Silencer"] );
					wait .05; 
					self switchtoWeapon(level.ktkWeapon["m21Silencer"]);
				}
				else
				{
					self giveWeapon(level.ktkWeapon["m21Silencer"]); 
					self giveMaxAmmo( level.ktkWeapon["m21Silencer"] );
					wait .05; 
					self setSpawnWeapon(level.ktkWeapon["m21Silencer"]);				
				}
			}
			else if(getDvarInt("scr_hardpoint_carepackage") > 0 && self.cur_kill_streak == getDvarInt("scr_hardpoint_carepackage") && self isEnabledOnMap("cp", "carepackage", true) && !self AlreadyHasThisHardpoint(level.ktkWeapon["marker"]))
			{
				self.pers["carepackagetype"] = "carepackage";
				received = self SetHardpointToSlot("weapon", level.ktkWeapon["marker"], true);
			}
		}
	}
}

StreakMessage()
{
	self endon("disconnect");
	self endon("death");

	if(self isAGuard())
	{
		if(self.cur_kill_streak == 2)
			self GiveAward("DOUBLE_KILL", "DOUBLE_KILL_DESC", 20);

		if(self.cur_kill_streak == 3) 
			self GiveAward("TRIPPLE_KILL", "TRIPPLE_KILL_DESC", 30);

		if(self.cur_kill_streak == 4) 
			self GiveAward("MULTI_KILL", "MULTI_KILL_DESC", 40);
			
		if(self.cur_kill_streak == 7) 
			self GiveAward("KILLINGSPREE", "KILLINGSPREE_DESC", 70);

		if(self.cur_kill_streak == 10) 
			self GiveAward("DOMINATING", "DOMINATING_DESC", 100);

		if(self.cur_kill_streak == 15) 
			self GiveAward("ULTRA_KILL", "ULTRA_KILL_DESC", 150);

		if(self.cur_kill_streak == 20) 
			self GiveAward("RAMPAGE", "RAMPAGE_DESC", 200);
		
		if(self.cur_kill_streak == 25) 
			self GiveAward("GODLIKE", "GODLIKE_DESC", 250);
		
		if(self.cur_kill_streak == 30) 
			self GiveAward("HOLY_SHIT", "HOLY_SHIT_DESC", 300);
		
		if(self.cur_kill_streak == 35) 
			self GiveAward("UNSTOPPABLE", "UNSTOPPABLE_DESC", 350);
		
		if(self.cur_kill_streak == 40) 
			self GiveAward("BLOODBATH", "BLOODBATH_DESC", 400);
		
		if(self.cur_kill_streak == 45) 
			self GiveAward("SLAUGHTER", "SLAUGHTER_DESC", 450);
	}
	else if(self isAnAssassin())
	{
		if(self.cur_kill_streak == 2)
			self GiveAward("DOUBLE_KILL", "DOUBLE_KILL_DESC", 20);

		if(self.cur_kill_streak == 3) 
			self GiveAward("TRIPPLE_KILL", "TRIPPLE_KILL_DESC", 30);

		if(self.cur_kill_streak == 4) 
			self GiveAward("MULTI_KILL", "MULTI_KILL_DESC", 40);
		
		if(self.cur_kill_streak == 5) 
			self GiveAward("KILLINGSPREE", "KILLINGSPREE_DESC_ASS", 50);
		
		if(self.cur_kill_streak == 7) 
			self GiveAward("DOMINATING", "DOMINATING_DESC_ASS", 70);
		
		if(self.cur_kill_streak == 10) 
			self GiveAward("UNSTOPPABLE", "UNSTOPPABLE_DESC_ASS", 100);
	}
}

GiveAward(title, text, xp)
{
	self endon("disconnect");
	self endon("death");	
	level endon("game_ended");

	if(level.gameEnded)
		return;
	
	if(self isABot())
		return;
	
	while(self.msginprogress)
		wait .1;
	
	self.msginprogress = true;
	
	self thread onDeath();
	
	if(isDefined(title))
	{
		startTime = getTime()/1000;
	
		while
		(
			self.doingNotify ||
			self playerAds() > 0 ||
			(!self forwardButtonPressed() && !self backButtonPressed() && !self moveLeftButtonPressed() && !self moveRightButtonPressed() && !self sprintButtonPressed() && !self jumpButtonPressed())
		)
		{
			wait .1;
			
			if(abs(getTime()/1000 - startTime) > 5)
			{
				self.msginprogress = false;
				self notify("award_done");
				return;
			}
		}

		if(title == "HEADSHOT")
				self ExecClientCommand("set ktk_award_msg MP_HEADSHOT; setdvartotime ui_time_marker");
		else
			self ExecClientCommand("set ktk_award_msg " + int(tablelookup("mp/unlockables.csv",1,"KTK_"+title,0)) + "; setdvartotime ui_time_marker");		
		
		self maps\mp\gametypes\_rank::giveRankXP("kill", xp);
		self notify("update_playerscore_hud");
		self playLocalSound("award");
		
		self thread resetMsgDvar(3);
		wait 3; 
	
		/* solution 3: taken out cuz i modified the menu again (and i think now it works)
		self setClientDvar("ktk_award_msg", int(tablelookup("mp/unlockables.csv",1,"KTK_"+title,0)));
		self thread maps\mp\gametypes\_huds::showHudsForAwardMenu();
		
		self maps\mp\gametypes\_rank::giveRankXP( "kill", xp );
		self notify ( "update_playerscore_hud" );
		self playLocalSound("award");
		self openMenu(game["menu_award_msg"]);
		
		wait 3;
		self closeMenu();
		self closeInGameMenu();
		*/
	}
	
	self.msginprogress = false;
	self notify("award_done");
	
	/* solution 2: taken out due to overflows	
	if(isDefined(self GetLocalizedString(title)) && isDefined(self GetLocalizedString(text)))
	{
		self SetClientDvar("ktk_award_title", self GetLocalizedString(title));
		self SetClientDvar("ktk_award_text", self GetLocalizedString(text));

		self maps\mp\gametypes\_rank::giveRankXP( "kill", xp );
		self notify ( "update_playerscore_hud" );
		self playLocalSound("award");

		for(i=1;i<11;i++)
		{
			self SetClientDvar("ktk_award_size", i);
			wait 0.05;
		}

		wait 2;
	}
	
	self SetClientDvar("ktk_award_size", 0);
	self.msginprogress = false;
	self notify( "award_done" );
	*/

	/* solution 1: taken out due to server crashes	
	self thread onDeath();
	self.msginprogress = true;

	if(!isDefined(self.award_icon))
	{
		self.award_icon = newClientHudElem(self);
		self.award_icon.x = 0;
		self.award_icon.y = -170;
		self.award_icon.alignX = "center";
		self.award_icon.alignY = "middle";
		self.award_icon.horzAlign = "center";
		self.award_icon.vertAlign = "middle";
		self.award_icon.alpha = .3;
		self.award_icon.archived = false;
		self.award_icon setShader("blood_background", 400, 100);
		self.award_icon.hidewheninmenu = true;
	}
		
	if(!isDefined(self.award_title))
	{
		self.award_title = newClientHudElem(self);
		self.award_title.font = "default";
		self.award_title.fontScale = 4.6;
		self.award_title.alignX = "center";
		self.award_title.alignY = "middle";
		self.award_title.horzAlign = "center";
		self.award_title.vertAlign = "middle";
		self.award_title.alpha = 1;
		self.award_title.x = 0;
		self.award_title.y = -180;
		self.award_title.archived = false;
		self.award_title.hidewheninmenu = true;
		self.award_title.label = &"Title";
	}
	
	if(!isDefined(self.award_text))
	{
		self.award_text = newClientHudElem(self);
		self.award_text.font = "default";
		self.award_text.fontScale = 4.2;
		self.award_text.alignX = "center";
		self.award_text.alignY = "middle";
		self.award_text.horzAlign = "center";
		self.award_text.vertAlign = "middle";
		self.award_text.alpha = 1;
		self.award_text.x = 0;
		self.award_text.y = -160;
		self.award_text.archived = false;
		self.award_text.hidewheninmenu = true;
		self.award_text.label = &"Text";
	}

	self maps\mp\gametypes\_rank::giveRankXP( "kill", xp );
	self notify ( "update_playerscore_hud" );
	self playLocalSound("award");
	
	while(self.award_text.fontScale >= 1.6)
	{
		wait 0.05;
		self.award_title.fontScale -= 0.2;
		self.award_text.fontScale -= 0.2;
	}
	
	wait 2;

	self DestroyHud();
	
	self notify( "award_done" );
	*/
}

resetMsgDvar(delay)
{
	self endon("disconnect");
	
	wait delay;
	self setClientDvar("ktk_award_msg", "");
}

onDeath()
{
	self endon("disconnect");
	self endon("award_done");
	
	self waittill("death");

	/*self SetClientDvars("ktk_award_title", "",
						"ktk_award_text", "",
						"ktk_award_size", 0);
						
	self closeMenu();
	self closeInGameMenu();*/

	self.msginprogress = false;
	
	if(isDefined(self.pers["hardPointItem"]))
		self TakeWeapon(self.pers["hardPointItem"]);
		
	//self DestroyHud();
}

DestroyHud()
{
	self endon("disconnect");
	self endon("award_done");
	
	if(isDefined(self.award_icon)) self.award_icon destroy();
	if(isDefined(self.award_title)) self.award_title destroy();
	if(isDefined(self.award_text)) self.award_text destroy();
	
	self.msginprogress = false;
}

GetLastHardpoint()
{
	hardpoint = "";
	temp = 0;
	
	for(i=0;i<10;i++)
	{
		switch(i)
		{
			case 0: hardpoint = "rccar"; break;
			case 1: hardpoint = "poison"; break;
			case 2: hardpoint = "airstrike"; break;
			case 3: hardpoint = "mortar"; break;
			case 4: hardpoint = "helicopter"; break;
			case 5: hardpoint = "ac130"; break;
			case 6: hardpoint = "carepackage"; break;
			case 7: if(getDvarInt("scr_hardpoint_system") == 1)
						hardpoint = "sentrygun";
					break;
			case 8: if(getDvarInt("scr_hardpoint_system") == 1)
						hardpoint = "predator";
					break;
			case 9: if(getDvarInt("scr_hardpoint_system") == 1)
						hardpoint = "nuke";
					break;
			default: break;
		}

		if(hardpoint == "carepackage")
			dvar = "scr_hardpoint_carepackage";
		else
			dvar = "scr_hardpoint_guard_" + hardpoint;
		
		if(getDvarInt(dvar) > temp)
			temp = getDvarInt("scr_hardpoint_guard_helicopter");
	}

	return hardpoint;
}

GetPersonalLastHardpoint()
{
	self endon("disconnect");
	
	self.lasthardpoint = "";
	temp = 0;
	
	for(i=0;i<3;i++)
	{
		if(isDefined(self.pers["selected_hardpoints"][i]))
		{
			fullname = getHardpointNameFromWeapon(self.pers["selected_hardpoints"][i]);
		
			if(fullname == "rccar" && self getKtkStat(2399) == 1)
				fullname = "rchelicopter";
		
			if(getDvarInt("scr_hardpoint_guard_" + fullname) > temp)
			{
				self.lasthardpoint = fullname;
				temp = getDvarInt("scr_hardpoint_guard_" + self.lasthardpoint);
			}
		}
	}
}
	
GetFollowingHardpoint()
{
	self endon("death");
	self endon("disconnect");
	
	hardpoint = [];
	
	for(i=0;i<5;i++)
	{
		if(getDvarInt("scr_hardpoint_guard_rccar") > self.cur_kill_streak && !isInHardpointArray(hardpoint, "rccar") && self getKtkStat(2399) == 0)
			hardpoint[i] = "rccar";
		else if(getDvarInt("scr_hardpoint_guard_rchelicopter") > self.cur_kill_streak && !isInHardpointArray(hardpoint, "rccar") && self getKtkStat(2399) == 1)
			hardpoint[i] = "rccar";
		else if(getDvarInt("scr_hardpoint_guard_poison") > self.cur_kill_streak && !isInHardpointArray(hardpoint, "poison"))
			hardpoint[i] = "poison";
		else if(getDvarInt("scr_hardpoint_guard_airstrike") > self.cur_kill_streak && !isInHardpointArray(hardpoint, "airstrike"))
			hardpoint[i] = "airstrike";
		else if(getDvarInt("scr_hardpoint_guard_mortar") > self.cur_kill_streak && !isInHardpointArray(hardpoint, "mortar"))
			hardpoint[i] = "mortar";
		else if(getDvarInt("scr_hardpoint_guard_ac130") > self.cur_kill_streak && !isInHardpointArray(hardpoint, "ac130"))
			hardpoint[i] = "ac130";
	}
	
	if(hardpoint.size > 1)
	{
		newhardpoint = "";
		value = 999;
	
		for(i=0;i<hardpoint.size;i++)
		{
			if(getDvarInt("scr_hardpoint_guard_" + hardpoint[i]) < value)
			{
				value = getDvarInt("scr_hardpoint_guard_" + hardpoint[i]);
				newhardpoint = hardpoint[i];
			}
		}
		
		self.cur_kill_streak = value;

		switch(newhardpoint)
		{
			case "rccar": return level.ktkWeapon["rccar"];
			case "poison": return level.ktkWeapon["poisongas"];
			case "airstrike": return "airstrike_mp";
			case "mortar": return level.ktkWeapon["mortars"];
			case "ac130": return level.ktkWeapon["ac130"];
			case "juggernaut": return level.ktkWeapon["juggernaut"];
			default: return level.ktkWeapon["poisongas"];
		}		
	}

	switch(hardpoint[0])
	{
		case "rccar": return level.ktkWeapon["rccar"];
		case "poison": return level.ktkWeapon["poisongas"];
		case "airstrike": return "airstrike_mp";
		case "mortar": return level.ktkWeapon["mortars"];
		case "ac130": return level.ktkWeapon["ac130"];
		case "juggernaut": return level.ktkWeapon["juggernaut"];
		default: return level.ktkWeapon["poisongas"];
	}
}

isInHardpointArray(array, hardpoint)
{
	for(i=0;i<array.size;i++)
	{
		if(array[i] == hardpoint)
			return true;
	}

	return false;
}

isEnabledOnMap(hardpoint, fullname, tellPlayer)
{
	self endon("disconnect");
	self endon("death");
	
	if(isSubStr(hardpoint, "_mp"))
		hardpoint = getHardpointNameFromWeapon(hardpoint);
	
	if(getDvarInt("scr_" + hardpoint + "_enabled"))
		return true;
	
	if(!isDefined(fullname) || !isString(fullname) || fullname == "")
		fullname = hardpoint;
	
	if(isDefined(tellPlayer) && tellPlayer)
		scr_iprintlnbold("AWARD_DISABLED_ON_THIS_MAP", self, fullname);
	
	return false;
}