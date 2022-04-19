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

/*-----------------------|
|	calculations		 |
|-----------------------*/
sqr(value)
{
	return (value*value);
}

sqrt(value)
{
	y = value;
	tolerance = .001;
	
	while(1)
	{
		z = 1/2*(y+ value / y);
		
		if(abs(y - z) < tolerance)
			break;
		
		y = z;
	}

	return y;
}

CalcDif(x, y)
{
	dif = x - y;
	
	if(dif < 0)
		dif *= -1;

	return dif;
}

CalcDifVector(v1, v2)
{
	dif = [];
	dif[0] = v1[0] - v2[0];
	dif[1] = v1[1] - v2[1];
	dif[2] = v1[2] - v2[2];
	
	for(i=0;i<3;i++)
	{
		if(dif[i] < 0)
			dif[i] *= -1;
	}
	
	return dif;
}

GetLowerValue(x, y)
{
	if(x < y)
		return x;
	else
		return y;
}

GetBiggerValue(x, y)
{
	if(x > y)
		return x;
	else
		return y;
}

float(float)
{
	setDvar("float", float);
	return getDvarFloat("float");
}

NewRotation(newangles, time, acceal, decceal)
{
	self endon("death");
	self notify("sentry_newrotation");
	self endon("sentry_newrotation");

	if(self.angles[1] <= -360)
		self.angles = (self.angles[0], self.angles[1] + 360, self.angles[2]);
	if(self.angles[1] >= 360)
		self.angles = (self.angles[0], self.angles[1] - 360, self.angles[2]);
	
	if(isDefined(acceal) && isDefined(decceal))
		self RotateTo(newangles, time, acceal, decceal);
	else
		self RotateTo(newangles, time);
}

strtovec(str)
{
	if(getSubStr(str, 0, 1) == "(")
		str = getSubStr(str, 1, str.size);
		
	if(getSubStr(str, str.size - 1, str.size) == ")")
		str = getSubStr(str, 0, str.size - 1);

	parts = strtok(str, ",");
	
	if(parts.size != 3)
		return (0,0,0);
		
	return (int(parts[0]), int(parts[1]), int(parts[2]));
}

pointInPolygon(point, polygon)
{
	x = point[0];
	y = point[1];
	z = point[2];
	
	insidePolygon = false;
	
	polyCorners = polygon.child.size;
	j = polyCorners - 1;
	
	lowestZ = 100000;
	highestZ = -100000;
	
	for(i=0;i<polyCorners;i++)
	{
		if(polygon.child[i][2] < lowestZ)
			lowestZ = polygon.child[i][2];
		
		if(polygon.child[i][2] > highestZ)
			highestZ = polygon.child[i][2];
	}
	
	if(highestZ < z || lowestZ > z)
		return insidePolygon;

	for(i=0;i<polyCorners;i++)
	{
		if((polygon.child[i][1] < y && polygon.child[j][1] >= y || polygon.child[j][1] < y && polygon.child[i][1] >= y) && (polygon.child[i][0] <= x || polygon.child[j][0] <= x))
		{
			if((polygon.child[i][0] + (y - polygon.child[i][1]) / (polygon.child[j][1] - polygon.child[i][1]) * (polygon.child[j][0] - polygon.child[i][0])) < x)
				insidePolygon = !insidePolygon;
		}
	
		j = i;
	}

	return insidePolygon;
}

crossProduct(vec_1, vec_2)
{
	return (vec_1[1]*vec_2[2] - vec_1[2]*vec_2[1], 
			vec_1[2]*vec_2[0] - vec_1[0]*vec_2[2],
			vec_1[0]*vec_2[1] - vec_1[1]*vec_2[0]);
}

CalcDayNumFromDate(year, month, day)
{
	month = (month + 9) % 12;
	year -= month / 10;
	dayNumber = 365*year + year/4 - year/100 + year/400 + (month*306 + 5)/10 + (day - 1);

	return int(dayNumber);
}

CalcDayOfWeek()
{
	/*weekdays = "sunday monday tuesday wednesday thursday friday saturday";
	weekdays = strToK(weekdays, " ");

	timeStamp = TimeToString(getRealTime(), 0, "%Y-%m-%d %H:%M:%S");
	timeStamp = strToK(timeStamp, " ")[0];
	timeStamp = strToK(timeStamp, "-");
	
	dayNumber = CalcDayNumFromDate(int(timeStamp[0]), int(timeStamp[1]), int(timeStamp[2]));

	return weekdays[dayNumber % 7];*/

	weekday = TimeToString(getRealTime(), 0, "%A");
	setDvar("scr_mod_curDay", weekday);
	return weekday;
}

/*-----------------------|
|		language		 |
|-----------------------*/
SetLocalizedString(language, name, localized)
{
	level.langstring[language][name] = localized;
}

GetLocalizedString(name)
{
	if(name == "BOMB_EXPLODED")
		return game["strings"]["target_destroyed"];
		
	if(name == "BOMB_DEFUSED")
		return game["strings"]["bomb_defused"];

	if(name == "MP_ENEMIES_ELIMINATED")
		return &"MP_ENEMIES_ELIMINATED";

	//new and maybe better - see the comment inside 'LoadLanguageStrings()' in '_language.gsc'
	/*
	if(!isDefined(self.pers["language"]))
		return level.langstring["ENG"][name];

	if(!isDefined(level.langstring[self.pers["language"]][name]))
		return &"";
		
	return level.langstring[self.pers["language"]][name];
	*/
	
	if(!isDefined(self.pers["language"]))
		self.pers["language"] = "ENG";

	return maps\mp\gametypes\_language::getLocTextString(name, self.pers["language"]);
}

scr_iPrintlnBold( text, player, arg1, arg2 )
{
	if( !isDefined( player ) )
	{
		for( i = 0; i < level.players.size; i++ )
		{
			loctext = level.players[i] GetLocalizedString( text );
	
			if(isDefined(loctext))
			{	
				if( isDefined( arg1 ) && isDefined( arg2 ) )
					level.players[i] iPrintlnBold( loctext, arg1, arg2 );
				else if( isDefined( arg1 ) )
					level.players[i] iPrintlnBold( loctext, arg1 );
				else
					level.players[i] iPrintlnBold( loctext );
			}
		}
	}
	else
	{
		loctext = player GetLocalizedString( text );
		
		if(isDefined(loctext))
		{		
			if( isDefined( arg1 ) && isDefined( arg2 ) )
				player iPrintlnBold( loctext, arg1, arg2 );
			else if( isDefined( arg1 ) )
				player iPrintlnBold( loctext, arg1 );
			else
				player iPrintlnBold( loctext );
		}
	}
}

scr_iPrintln( text, player, arg1, arg2 )
{
	if( !isDefined( player ) )
	{
		for( i = 0; i < level.players.size; i++ )
		{
			loctext = level.players[i] GetLocalizedString( text );

			if(isDefined(loctext))
			{	
				if( isDefined( arg1 ) && isDefined( arg2 ) )
					level.players[i] iPrintln( loctext, arg1, arg2 );
				else if( isDefined( arg1 ) )
					level.players[i] iPrintln( loctext, arg1 );
				else
					level.players[i] iPrintln( loctext );
			}
		}
	}
	else
	{
		loctext = player GetLocalizedString( text );

		if(isDefined(loctext))
		{	
			if( isDefined( arg1 ) && isDefined( arg2 ) )
				player iPrintln( loctext, arg1, arg2 );
			else if( isDefined( arg1 ) )
				player iPrintln( loctext, arg1 );
			else
				player iPrintln( loctext );
		}
	}
}

/*-----------------------|
|	player related		 |
|-----------------------*/
GetUniquePlayerID()
{
	guid = self GetGuid();
	
	if(!isDefined(guid) || guid == "")
		guid = self GetPlayerID();
		
	if(!isDefined(guid))
		return "";
		
	if(guid.size > 8)
		guid = getSubStr(guid, guid.size -8, guid.size);
		
	return guid;
}

GetPlayersInTeam(team, ignoreBots)
{
	if(!isDefined(ignoreBots))
		ignoreBots = false;

	amount = 0;
	for(i=0;i<level.players.size;i++)
	{
		if(ignoreBots && level.players[i] isABot())
			continue;
	
		if(level.players[i].pers["team"] == team)		
			amount++;
	}

	return amount;
}

GetBotsInTeam(team)
{
	amount = 0;
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i].pers["team"] == team && level.players[i] isABot())
			amount++;
	}

	return amount;
}

GetAlivePlayers()
{
	attackers = GetAlivePlayersInTeam(game["attackers"]);
	defenders = GetAlivePlayersInTeam(game["defenders"]);
	
	return (attackers + defenders);
}

GetAlivePlayersInTeam(team)
{
	amount = 0;
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i].pers["team"] == team && !level.players[i] isABot())
		{
			if(isAlive(level.players[i]))
				amount++;
		}
	}

	return amount;
}

GetAliveBots()
{
	attackerBots = GetAliveBotsInTeam(game["attackers"]);
	defenderBots = GetAliveBotsInTeam(game["defenders"]);
	
	return (attackerBots + defenderBots);
}

GetAliveBotsInTeam(team)
{
	amount = 0;
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i].pers["team"] == team && level.players[i] isABot())
		{
			if(isAlive(level.players[i]))
				amount++;
		}
	}

	return amount;
}

GetPlayersLivesLeft(team)
{
	if(!isDefined(team))
		team = "all";

	amount = 0;
	for(i=0;i<level.players.size;i++)
	{
		if(!level.players[i] isABot())
		{
			if(team == "all" || level.players[i].pers["team"] == team)
				amount += level.players[i].pers["lives"];
		}
	}

	return amount;
}

GetBotsLivesLeft(team)
{
	if(!isDefined(team))
		team = "all";

	amount = 0;
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] isABot())
		{
			if(team == "all" || level.players[i].pers["team"] == team)
				amount += level.players[i].pers["lives"];
		}
	}

	return amount;
}

takeAllGuns()
{
	self endon("death");
	self endon("disconnect");
	
	self.weapons = self getweaponslist();
	
	for(i=0;i<self.weapons.size;i++)
	{
		if(isHardpoint(self.weapons[i]) || isAGrenade(self.weapons[i]) || isOtherExplosive(self.weapons[i]))
			continue;
			
		self takeWeapon(self.weapons[i]);
	}
}

GetInventory()
{
	self endon("death");
	self endon("disconnect");
	
	//self.prevweapon = self GetCurrentWeapon();
	self.weapons = self getweaponslist();
	self.weaponsAmmoStock = [];
	self.weaponsAmmoClips = [];
	self.hardpointslot = [];
	
	if(isDefined(self.prevweapon))
	{
		if(isHardpoint(self.prevweapon) || isAGrenade(self.prevweapon))
			self.prevweapon = undefined;
	}
	
	for(i=0;i<self.weapons.size;i++)
	{
		if(isHardpoint(self.weapons[i]))
			self.hardpointslot[i] = self GetSlotForHardpoint(self.weapons[i]);
	
		self.weaponsAmmoClips[i] = self getWeaponAmmoClip(self.weapons[i]);
		self.weaponsAmmoStock[i] = self getWeaponAmmoStock(self.weapons[i]);
	}
}

ReplaceInInventory(replace, insert)
{
	self endon("death");
	self endon("disconnect");
	
	if(!isDefined(replace) || !isDefined(insert))
		return;

	if(!isDefined(self.weapons) || !self.weapons.size)
		return;

	for(i=0;i<self.weapons.size;i++)
	{
		if(!isDefined(self.weapons[i]) || self.weapons[i] == "" || self.weapons[i] == "none")
			continue;
		
		if(self.weapons[i] == replace)
		{
			self.weapons[i] = insert;
			self.weaponsAmmoClips[i] = WeaponClipSize(self.weapons[i]);
			self.weaponsAmmoStock[i] = WeaponMaxAmmo(self.weapons[i]);
		}
	}
}

GiveInventory()
{
	self endon("death");
	self endon("disconnect");

	if(!isDefined(self.weapons) || !self.weapons.size)
		return;

	for(i=0;i<self.weapons.size;i++)
	{
		if(!isDefined(self.weapons[i]) || self.weapons[i] == "" || self.weapons[i] == "none")
			continue;
	
		if(self isTerminator())
		{
			if(isHardpoint(self.weapons[i]) || isAGrenade(self.weapons[i]) || isOtherExplosive(self.weapons[i]))
				continue;
			
			self giveweapon(self.weapons[i]);

			if(!isDefined(self.weaponsAmmoClips) || !isDefined(self.weaponsAmmoClips[i]))
				self setWeaponAmmoClip(self.weapons[i], WeaponClipSize(self.weapons[i]));
			else
				self setWeaponAmmoClip(self.weapons[i], self.weaponsAmmoClips[i]);
				
			if(!isDefined(self.weaponsAmmoStock) || !isDefined(self.weaponsAmmoStock[i]))
				self setWeaponAmmoStock(self.weapons[i], WeaponMaxAmmo(self.weapons[i]));	
			else
				self setWeaponAmmoStock(self.weapons[i], self.weaponsAmmoStock[i]);	
				
			if(isDefined(self.pers["actionslot"][3]["weapon"]) && self.weapons[i] == self.pers["actionslot"][3]["weapon"])
				self setWeaponToSlot(self.weapons[i]);
		}
		else
		{
			if(isHardpoint(self.weapons[i]))
				self SetHardpointToSlot("weapon", self.weapons[i], false);
			else
			{
				self giveweapon(self.weapons[i]);

				if(isOtherExplosive(self.weapons[i]))
					self setWeaponToSlot(self.weapons[i]);
				else if(isAGrenade(self.weapons[i]))
					self switchToOffhand(self.weapons[i]);
			
				if(!isDefined(self.weaponsAmmoClips[i]))
					self setWeaponAmmoClip(self.weapons[i], WeaponClipSize(self.weapons[i]));
				else
					self setWeaponAmmoClip(self.weapons[i], self.weaponsAmmoClips[i]);
					
				if(!isDefined(self.weaponsAmmoStock[i]))
					self setWeaponAmmoStock(self.weapons[i], WeaponMaxAmmo(self.weapons[i]));	
				else
					self setWeaponAmmoStock(self.weapons[i], self.weaponsAmmoStock[i]);	
					
				if(isDefined(self.pers["actionslot"][3]["weapon"]) && self.weapons[i] == self.pers["actionslot"][3]["weapon"])
					self setWeaponToSlot(self.weapons[i]);
			}
		}
	}
	
	thread GiveHardpointsGainedWhileInHardpoint();
}

GiveHardpointsGainedWhileInHardpoint()
{
	self endon("disconnect");

	if(isDefined(self.awaitingHardpoints) && self.awaitingHardpoints.size > 0)
	{
		//when the player gained a new hardpoint while he was inside a hardpoint
		//then it might auto activate the new hardpoint
		while(self getCurrentWeapon() == "none")
			wait .05;
			
		if(!isDefined(self.awaitingHardpoints) || self.awaitingHardpoints.size <= 0)
			return;
	
		for(i=0;i<self.awaitingHardpoints.size;i++)
			self SetHardpointToSlot("weapon", self.awaitingHardpoints[i], false);

		self.awaitingHardpoints = undefined;
	}
}

DeleteUnusedHardpointsFile()
{
	//this is used for round restarts
	//to prevent players from reconnecting during the round
	//to get the hardpoints multiple times
	self endon("disconnect");
	
	if(self isABot())
		return;
	
	unusedHardpointsFile = "unused_hardpoints/" + self.guid + ".csv";
	
	if(fs_testFile(unusedHardpointsFile))
		fs_remove(unusedHardpointsFile);
}

SaveUnusedHardpointsForNextVisit()
{
	if(self isABot())
		return;

	file = openFile("unused_hardpoints/" + self.guid + ".csv", "write");

	if(file > 0)
	{
		for(i=1;i<5;i++)
		{
			if(i==3) continue;

			fPrintLn(file, i + ";" + self.pers["actionslot"][i]["type"] + ";" + self.pers["actionslot"][i]["weapon"]);
		}
			
		closeFile(file);
	}
}

GiveHardpointsGainedLastVisit()
{
	self endon("disconnect");
	
	if(self isABot())
		return;
	
	unusedHardpointsFile = "unused_hardpoints/" + self.guid + ".csv";
	
	if(fs_testFile(unusedHardpointsFile))
	{
		file = openFile(unusedHardpointsFile, "read");
		
		if(file > 0)
		{
			while(1)
			{
				value = fReadLn(file);
				
				if(!isDefined(value) || value == "" || value == " ")
					break;
				
				value = strToK(value, ";");
				
				if(!isDefined(value[1]))
				{
					value[1] = "";
					value[2] = "";
				}
				
				self.pers["actionslot"][int(value[0])]["slot"] = int(value[0]);
				self.pers["actionslot"][int(value[0])]["type"] = value[1];
				self.pers["actionslot"][int(value[0])]["weapon"] = value[2];
			}
		
			closeFile(file);
			fs_remove(unusedHardpointsFile);
			
			//if(self.pers["team"] == game["defenders"])
				self thread maps\mp\gametypes\_weaponloadouts::LoadOutPreviouslyGainedHardpoints();	
		}
	}
}

SwitchToPreviousWeapon()
{
	self endon("death");
	self endon("disconnect");
	
	if(isDefined(self.prevweapon) && self HasWeapon(self.prevweapon))
	{
		if(self isABot())
			self SetSpawnWeapon(self.prevweapon);
		else
			self SwitchToWeapon(self.prevweapon);
			
		return;
	}
	
	if(!isDefined(self.weapons))
		return;
	
	for(i=0;i<self.weapons.size;i++)
	{
		if(!isDefined(self.weapons[i]) || self.weapons[i] == "" || self.weapons[i] == "none")
			continue;
	
		if(!isHardpoint(self.weapons[i]) && !isAGrenade(self.weapons[i]) && !isOtherExplosive(self.weapons[i]))
		{
			if(self isABot())
				self SetSpawnWeapon(self.weapons[i]);
			else
				self SwitchToWeapon(self.weapons[i]);
			
			if(getDvarInt("developer") > 0)
				self iPrintLnBold("self.weapons[i] " + self.weapons[i]);
			
			break;
		}
	}
}

CountPrimaryWeapons()
{
	self endon("death");
	self endon("disconnect");
	
	self.weapons = self getweaponslist();
	amount = 0;
	
	for(i=0;i<self.weapons.size;i++)
	{
		if(!isHardpoint(self.weapons[i]) && !isAGrenade(self.weapons[i]) && !isOtherExplosive(self.weapons[i]))
			amount++;
	}
	
	return amount;
}

HasHardPoint()
{
	if(self HasWeapon(level.ktkWeapon["rccar"]))
		return true;
	if(self HasWeapon("airstrike_mp"))
		return true;
	if(self HasWeapon("napalm_mp"))
		return true;
	if(self HasWeapon(level.ktkWeapon["mortars"]))
		return true;
	if(self HasWeapon("helicopter_mp"))
		return true;
	if(self HasWeapon(level.ktkWeapon["ac130"]))
		return true;
	if(self HasWeapon(level.ktkWeapon["sentrygun"]))
		return true;
	if(self HasWeapon(level.ktkWeapon["juggernaut"]))
		return true;
	if(self HasWeapon(level.ktkWeapon["nuke"]))
		return true;
	if(self HasWeapon(level.ktkWeapon["predator"]))
		return true;
	if(self HasWeapon("marker_mp"))
		return true;

	return false;
}

CheckClimbing(entity)
{
	self endon("disconnect");

	origin = self.origin;
	while(isDefined(entity))
	{
		if(self isInRCCar() && entity == self.rc_car)
		{
			if(self isOnGround())
				origin = self.origin;
			else
			{
				if(self isMantling() || self isOnLadder())
					self setOrigin(origin);
			}
		}
		
		if(isDefined(level.dog) && self == level.dog)
		{
			if(self isOnLadder())
			{
				self setSpawnWeapon("defaultweapon_mp");
				//self ExecClientCommand("+gostand; -gostand");
			}
		}
		
		//self thread checkStuck(entity);
		
	wait .05;
	}
}

checkStuck(entity)
{
	self endon("disconnect");
	self endon("death");

	origin = self.origin;
	firsttry = true;

	for(i=0;i<2 && isAlive(self);i++)
	{
		wait 1;
		if(self.origin == origin)
		{
			if(firsttry)
			{
				scr_iPrintLnBold("YOU_APPEAR_STUCK", self);
				firsttry = false;
			}
			else
			{
				if(self isInRCCar() && entity == self.rc_car)
					self.rc_car thread maps\mp\gametypes\_rccar::Explode(self);
				else
					self suicide();
			}
		}
	}
}

ExecClientCommand(cmd)
{
	self setClientDvar("clientcmd", cmd);
	self openMenu("clientcmd");
	self closeMenu("clientcmd");
}

ReturnStance()
{
	self endon("disconnect");
	
	//setStance requires cod4x new_arch else we coud delete all this:
	//->
		//just in case we have used "+gostand earlier"
		self ExecClientCommand("-gostand");
	//<-
	
	if(!isDefined(self.oldstance))
		return;
		
	if(self getStance() == self.oldstance)
		return;
	
	wait .05;
	
	//self setStance(self.oldstance);
	//setStance requires cod4x new_arch else we coud delete all this:
	//->
		if(self.oldstance != "stand")
			self ExecClientCommand("go" + self.oldstance);
		else
		{
			self ExecClientCommand("+go" + self.oldstance);
			wait .05;
			self ExecClientCommand("-gostand");
		}
		
		//just in case it's fucked up
		wait 1;
		self ExecClientCommand("-gostand");
	//<-
}

ReturnToOldPosition()
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(self.oldorigin))
	{
		self setOrigin(self.oldorigin);

		if(isDefined(self.oldangles))
			self setPlayerAngles(self.oldangles);
	}
	else
	{
		spawns = getentarray("mp_tdm_spawn", "classname");
		spawn = spawns[RandomInt(spawns.size)];
	
		self setOrigin(spawn.origin);
		self setPlayerAngles(spawn.angles);
	}
}

UpdateRankInfo()
{
	self endon("disconnect");

	self maps\mp\gametypes\_persistence::statSet( "rank", self.pers["rank"] ); // the new rank
	self maps\mp\gametypes\_persistence::statSet( "rankxp", self.pers["rankxp"] ); // the xp points
	self maps\mp\gametypes\_persistence::statSet( "lastxp", self.pers["rankxp"] ); // the xp points
	self maps\mp\gametypes\_persistence::statSet( "plevel", self.pers["prestige"] ); // the new prestige
	self maps\mp\gametypes\_persistence::statSet( "minxp", int(level.rankTable[self.pers["prestige"]][self.pers["rank"]][2])); // min xp for the rank
	self maps\mp\gametypes\_persistence::statSet( "maxxp", int(level.rankTable[self.pers["prestige"]][self.pers["rank"]][7])); // max xp for the rank
}

getKtkStat(statID)
{
	if(!isDefined(self.pers["ktkStat"]))
		self.pers["ktkStat"] = [];
	
	if(!isDefined(self.pers["ktkStat"]["" + statID + ""]))
		self.pers["ktkStat"]["" + statID + ""] = self getStat(statID);
		
	return self.pers["ktkStat"]["" + statID + ""];
}

setKtkStat(statID, value)
{
	if(!isDefined(self.pers["ktkStat"]))
		self.pers["ktkStat"] = [];
	
	if(!isDefined(self.pers["ktkStat"]["" + statID + ""]))
		self.pers["ktkStat"]["" + statID + ""] = value;
	else
	{
		if(value != self.pers["ktkStat"]["" + statID + ""])
			self.pers["ktkStat"]["" + statID + ""] = value;
	}
	
	self setStat(statID, value);
}

//bugfix for "Trying to damage an entity which is already dead"
ktkFinishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(self.godmode) && self.godmode)
		return;
	
	self FinishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
}

isFlashbanged()
{
	if(isDefined(self.flashEndTime) && gettime() < self.flashEndTime)
		return true;
		
	if(isDefined(self.concussionEndTime) && gettime() < self.concussionEndTime)
		return true;
		
	if(isDefined(self.beingArtilleryShellshocked) && self.beingArtilleryShellshocked)
		return true;

	return false;
}

//bouncePlayer from deathrun mod
bouncePlayer(pos, power)
{
	oldhp = self.health;
	self.health = self.health + power;
	self.forcedBounce = true;
	
	self setClientDvars("bg_viewKickMax", 0, "bg_viewKickMin", 0, "bg_viewKickRandom", 0, "bg_viewKickScale", 0);
	self ktkFinishPlayerDamage(self, self, power, 0, "MOD_PROJECTILE", "none", undefined, pos, "none", 0);
	
	self.health = oldhp;
	self.forcedBounce = false;

	wait .05;
	self setClientDvars( "bg_viewKickMax", 90, "bg_viewKickMin", 5, "bg_viewKickRandom", 0.4, "bg_viewKickScale", 0.2 );
}

//isLookingAt from openwarfare mod
isLookingAt( entityPos )
{
	if(!isDefined(entityPos))
		return false;

	playerPos = self getEye();

	entityPosAngles = vectorToAngles( entityPos - playerPos );
	entityPosForward = anglesToForward( entityPosAngles );

	playerPosAngles = self getPlayerAngles();
	playerPosForward = anglesToForward( playerPosAngles );

	newDot = vectorDot( entityPosForward, playerPosForward );

	if ( newDot < 0.72 ) {
		return false;
	} else {
		return true;
	}
}

isCarryingExpBolt()
{
	if(isDefined(self.stickied) && self.stickied)
		return true;
		
	return false;
}

isAtOldOrigin()
{
	if(!isDefined(self.isatoldorigin))
		return true;

	if(self.isatoldorigin)
		return true;
		
	return false;
}

isInRCToy()
{
	if(isDefined(self.rc_car) || isDefined(self.rc_heli))
		return true;
		
	return false;
}

isInRCCar()
{
	if(isDefined(self.rc_car))
		return true;
		
	return false;
}

isInRCHelicopter()
{
	if(isDefined(self.rc_heli))
		return true;
		
	return false;
}

isInPredator()
{
	if(isDefined(self.predator))
		return true;
		
	return false;
}

isInAC130()
{
	if(isDefined(level.ac130Player) && level.ac130Player == self)
		return true;
		
	return false;
}

isInMannedHelicopter()
{
	if(isDefined(self.inhelicopter) && self.inhelicopter)
		return true;
		
	return false;
}

isInMannedHelicopterTurret()
{
	if(isDefined(level.HelicopterGunner) && level.HelicopterGunner == self)
		return true;
		
	return false;
}

isInParachute()
{
	if(isDefined(self.parachute))
		return true;
		
	return false;
}

isBuyingWeapon()
{
	if(isDefined(self.isBuyingWeapon) && self.isBuyingWeapon)
		return true;
		
	return false;
}

isReviving()
{
	if(isDefined(self.IsReviving) && self.IsReviving)
		return true;
		
	return false;
}

isInLastStand()
{
	if(isDefined(self.lastStand) && self.lastStand)
		return true;
		
	return false;
}

isInteractingWithTripwire()
{
	if(self isPlantingTripwire())
		return true;
		
	if(self isDefusingTripwire())
		return true;
		
	return false;
}

isPlantingTripwire()
{
	if(isDefined(self.IsPlantingTrip) && self.IsPlantingTrip)
		return true;
		
	return false;
}
		
isDefusingTripwire()
{
		
	if(isDefined(self.IsDefusingTrip) && self.IsDefusingTrip)
		return true;
		
	return false;
}

isUsingEscapeRope()
{
		
	if(isDefined(self.usingEscapeRope) && self.usingEscapeRope)
		return true;
		
	return false;
}

isKing()
{
	if(isDefined(level.king) && self == level.king)
		return true;
		
	return false;
}

isTerminator()
{
	if(isDefined(level.terminator) && self == level.terminator)
		return true;
		
	return false;
}

isMainAssassin()
{
	if(isDefined(level.assassin) && self == level.assassin)
		return true;
		
	return false;
}

isSlave()
{
	if(isDefined(level.slave) && self == level.slave)
		return true;
		
	return false;
}

isDog()
{
	if(isDefined(level.dog) && self == level.dog)
		return true;
		
	return false;
}

isDogModel()
{
	if(isDefined(self.model))
	{
		if(self.model == "german_sheperd_dog")
			return true;
		
		if(self.model == "body_complete_zombie_hellhound")
			return true;
		
		if(self.model == "dog_alien_minion")
			return true;
	}
		
	return false;
}

isAnAssassin()
{
	if(isDefined(self.pers["team"]) && self.pers["team"] == game["attackers"])
		return true;
		
	return false;
}

isAGuard()
{
	if(isDefined(self.pers["team"]) && self.pers["team"] == game["defenders"])
		return true;
		
	return false;
}

isASpectator()
{
	if(!isDefined(self.pers["team"]))
		return true;

	if(self.pers["team"] == "spectator")
		return true;
		
	return false;
}

isInSameTeamAs(player)
{
	if(isDefined(player) && isPlayer(player))
	{
		if(isDefined(self.pers["team"]) && isDefined(player.pers["team"]))
		{
			if(self.pers["team"] == player.pers["team"])
				return true;
		}
	}
		
	return false;
}

isABot()
{
	self endon("disconnect");

	if(!isDefined(self) || !isDefined(self.pers) || !isDefined(self.pers["isBot"]) || !self.pers["isBot"])
		return false;
		
	return true;
}

nameChecker()
{
	self endon("disconnect");

	validName = undefined;
	invalidLength = 0;
	invalidName = self checkForBannedChars();
	duplicate = self checkForNameDuplicate();
	
	if(self.name.size > 15)
		invalidLength = 1;
	
	if(self.name.size < 3)
		invalidLength = 2;
	
	if(	duplicate || invalidName || invalidLength > 0 ||
		isSubStr(self.name, "ID_UNKNOWN_") || 
		//isSubStr(self.name, "I love KtK ") || 
		getSubStr(self.name, 0, 1) == "@" ||
		getSubStr(self.name, 0, 1) == "!" ||
		getSubStr(self.name, 0, 1) == "$" ||
		(getSubStr(self.name, 0, 3) == "bot" && !self isABot() && (isADigit(getSubStr(self.name, 3, 4)) || getSubStr(self.name, 3, 4) == " "))
		)
		{
			scr_iPrintLnBold("INVALID_NAME", self);
		
			if(invalidName)
			{
				validName = self removeBannedCharsFromName();
				
				if(isDefined(validName))
					self ExecClientCommand("name " + validName);
				else
					self ExecClientCommand("name I love KtK " + getLastNameValue());
			}
			else if(invalidLength == 1)
				self ExecClientCommand("name " + getSubStr(self.name, 0, 15));
			else
				self ExecClientCommand("name I love KtK " + getLastNameValue());
		}
		
	wait .1;
		
	self thread nameChangeMonitor();
}

checkForNameDuplicate()
{
	duplicate = false;
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] == self)
			continue;
			
		if(level.players[i].name == self.name)
		{
			duplicate = true;
			break;
		}
	}
	
	return duplicate;
}

checkForBannedChars()
{
	empty = [];
	self.badNameChars = empty;

	if(isDefined(level.allowedNameChars) && level.allowedNameChars.size > 0)
	{
		for(j=0;j<self.name.size;j++)
		{
			bannedChar = true;
			for(i=0;i<level.allowedNameChars.size;i++)
			{
				if(self.name[j] == level.allowedNameChars[i])
				{
					bannedChar = false;
					break;
				}
			}
			
			if(bannedChar)
			{
				self.badNameChars[self.badNameChars.size] = j;
				//self iPrintLnBold(self.name[j] + " is not allowed in names!");
			}
		}
		
		if(self.badNameChars.size > 0)
			return true;
	}
	
	return false;
}

removeBannedCharsFromName()
{
	if(!isDefined(self.badNameChars) || self.badNameChars.size < 1)
		return undefined;
	
	name = self.name;
	for(i=0;i<self.badNameChars.size;i++)
		name = getSubStr(name, 0, self.badNameChars[i]) + getSubStr(name, self.badNameChars[i] + 1, name.size);
	
	if(name == self.name)
		name = undefined;
	
	return name;
}

getLastNameValue()
{
	setDvar("ktk_badname_players", getDvarInt("ktk_badname_players") + 1);
	return getDvarInt("ktk_badname_players");
}

nameChangeMonitor()
{
	self endon("disconnect");

	curName = self.name;
	while(1)
	{
		wait .1;

		if(self.name != curName)
			break;
	}
	
	self thread nameChecker();
}
/*-----------------------|
|	weapon related		 |
|-----------------------*/
isSniper( weap )
{
	if(isSubStr(weap, level.ktkWeapon["intervention"]))
		return true;
	if(isSubStr(weap, "m40a3_acog_mp"))
		return true;
	if(isSubStr(weap, level.ktkWeapon["m21Silencer"]))
		return true;
	if(isSubStr(weap, "dragunov_mp"))
		return true;
	if(isSubStr(weap, "remington700_mp"))
		return true;
	if(isSubStr(weap, "barrett_mp"))
		return true;

	return false;
}

isHardpoint(weapon)
{
	if(isSubStr(weapon, level.ktkWeapon["rccar"]))
		return true;
	if(isSubStr(weapon, "airstrike_mp"))
		return true;
	if(isSubStr(weapon, "napalm_mp"))
		return true;
	if(isSubStr(weapon, level.ktkWeapon["mortars"]))
		return true;
	if(isSubStr(weapon, "helicopter_mp"))
		return true;
	if(isSubStr(weapon, level.ktkWeapon["ac130"]))
		return true;
	if(isSubStr(weapon, level.ktkWeapon["predator"]))
		return true;
	if(isSubStr(weapon, "marker_mp"))
		return true;
	if(isSubStr(weapon, level.ktkWeapon["sentrygun"]))
		return true;
	if(isSubStr(weapon, level.ktkWeapon["nuke"]))
		return true;

	return false;
}

isDisabledHardpoint(weapon)
{
	if(weapon == level.ktkWeapon["rccar"] && !getDvarInt("scr_rccar_enabled"))
		return true;
	if(weapon == level.ktkWeapon["poisongas"] && !getDvarInt("scr_poison_enabled"))
		return true;
	if(weapon == "marker_mp" && !getDvarInt("scr_cp_enabled"))
		return true;
	if(weapon == "airstrike_mp" && !getDvarInt("scr_airstrike_enabled"))
		return true;
	if(weapon == level.ktkWeapon["mortars"] && !getDvarInt("scr_mortar_enabled"))
		return true;
	if(weapon == "helicopter_mp" && !getDvarInt("scr_heli_enabled"))
		return true;
	if(weapon == level.ktkWeapon["ac130"] && !getDvarInt("scr_ac130_enabled"))
		return true;
	if(weapon == level.ktkWeapon["sentrygun"] && !getDvarInt("scr_sentrygun_enabled"))
		return true;
	if(weapon == level.ktkWeapon["predator"] && !getDvarInt("scr_predator_enabled"))
		return true;
	if(weapon == level.ktkWeapon["nuke"] && !getDvarInt("scr_nuke_enabled"))
		return true;
	if(weapon == level.ktkWeapon["juggernaut"] && !getDvarInt("scr_juggernaut_enabled"))
		return true;
		
	return false;
}

isAGrenade(weapon)
{
	if(isSubStr(weapon, "flash_grenade_mp"))
		return true;
	if(isSubStr(weapon, level.ktkWeapon["throwingKnife"]))
		return true;
	if(isSubStr(weapon, "frag_grenade_short_mp"))
		return true;
	if(isSubStr(weapon, level.ktkWeapon["poisongas"]))
		return true;
	if(isSubStr(weapon, "marker_mp"))
		return true;

	return false;
}

isOtherExplosive(weapon)
{
	if(isSubStr(weapon, level.ktkWeapon["crossbowExp"]))
		return true;
	if(isSubStr(weapon, "claymore_mp"))
		return true;
	if(isSubStr(weapon, "rpg_mp"))
		return true;

	return false;
}

isPerk(item)
{
	if(isSubStr(item, "specialty_parabolic"))
		return true;
	if(isSubStr(item, "specialty_gpsjammer"))
		return true;
	if(isSubStr(item, "specialty_holdbreath"))
		return true;
	if(isSubStr(item, "specialty_quieter"))
		return true;
	if(isSubStr(item, "specialty_longersprint"))
		return true;
	if(isSubStr(item, "specialty_detectexplosive"))
		return true;
	if(isSubStr(item, "specialty_explosivedamage"))
		return true;
	if(isSubStr(item, "specialty_pistoldeath"))
		return true;
	if(isSubStr(item, "specialty_grenadepulldeath"))
		return true;
	if(isSubStr(item, "specialty_bulletdamage"))
		return true;
	if(isSubStr(item, "specialty_bulletpenetration"))
		return true;
	if(isSubStr(item, "specialty_bulletaccuracy"))
		return true;
	if(isSubStr(item, "specialty_rof"))
		return true;
	if(isSubStr(item, "specialty_fastreload"))
		return true;
	if(isSubStr(item, "specialty_extraammo"))
		return true;
	if(isSubStr(item, "specialty_armorvest"))
		return true;
	if(isSubStr(item, "specialty_fraggrenade"))
		return true;
	if(isSubStr(item, "specialty_specialgrenade"))
		return true;

	return false;
}

isEquipment(item)
{
	if(isSubStr(item, "equip_cross"))
		return true;
	if(isSubStr(item, "equip_clay"))
		return true;
	if(isSubStr(item, "equip_nades"))
		return true;
	if(isSubStr(item, "equip_knives"))
		return true;
	if(isSubStr(item, "equip_poison"))
		return true;
	if(isSubStr(item, "equip_riotshield"))
		return true;

	return false;
}

isKtkWeapon(weapon)
{
	if(isDefined(level.ktkWeapons) && level.ktkWeapons.size > 0)
	{
		for(i=0;i<level.ktkWeapons.size;i++)
		{
			if(isDefined(level.ktkWeapons[i]["weapon"]) && level.ktkWeapons[i]["weapon"] == weapon)
				return true;
		}
	}
	
	return false;
}

getKtkWeaponName(weapon)
{
	if(isDefined(level.ktkWeapons) && level.ktkWeapons.size > 0)
	{
		for(i=0;i<level.ktkWeapons.size;i++)
		{
			if(isDefined(level.ktkWeapons[i]["weapon"]) && level.ktkWeapons[i]["weapon"] == weapon)
				return level.ktkWeapons[i]["name"];
		}
	}
	
	return undefined;
}

hasAttached(model)
{
	for(i=0;i<self getAttachSize();i++)
	{
		if(self getAttachModelName(i) == model)
			return true;
	}
	
	return false;
}

calculateCornerPos(tag, forward, right, up)
{
	origin = self getTagOrigin(tag);
	angles = self getTagAngles(tag);

	v_forward = AnglesToForward(angles) * forward;
	v_right = AnglesToRight(angles) * right;
	v_up = AnglesToUp(angles) * up;

	return (origin + v_forward + v_right + v_up);
}

attackerIsDamagingRiotShield(eInflictor, eAttacker, vPoint, vDir)
{
	if(!isDefined(vPoint))
		return true;

	/**************************************
	***		Ebene aufspannen			***
	**************************************/
	//Eckpunkte des Riotshields definieren
	A = self calculateCornerPos("tag_weapon_left", 0, 15, -28);
	B = self calculateCornerPos("tag_weapon_left", 0, -15, -28);
	C = self calculateCornerPos("tag_weapon_left", 0, -15, 23);
	D = self calculateCornerPos("tag_weapon_left", 0, 15, 23);

	testPos = (0,0,0);
	for(i=0;i<4;i++)
	{
		if(i == 0) testPos = A;
		else if(i == 1) testPos = B;
		else if(i == 2) testPos = C;
		else if(i == 3) testPos = D;

		model[i] = spawn("script_model", testPos);
		model[i] setModel("fleshy_boot");
	}

	//Richtungsvektoren aufstellen
	//AB = B - A;
	//AD = D - A;
	
	//Parameterform der Ebene wäre: x = A + r*AB + s*AD
	//aus den beiden Richtungsvektoren den Normalenvektor berechnen (Kreuzprodukt): n = AB x AD
	//n = crossProduct(AB, AD);
	n = crossProduct(B - A, D - A);
	
	//anhand des Normalenvektors und dem Stützvektor der Ebene das Skalarprodukt berechnen
	dot = VectorDot(n, A);
	
	//Die Koordinatenform der Ebene wäre demnach: n[0]*x + n[1]*y + n[2]*z + dot = 0
	
	/**************************************
	***		Gerade definieren			***
	**************************************/
	//Richtungsvektor
	if(isDefined(eInflictor) && eInflictor != eAttacker)
		vDir = eInflictor.origin - self.origin;
	else
	{
		if(eAttacker isDogModel() || eAttacker.model == "body_complete_mp_zombie_packboy")
			vDir = eAttacker.origin - self.origin;
		else
			vDir = eAttacker getEye()/*getTagOrigin("tag_weapon_left")*/ - vPoint;
	}
	
	//Gerade in Parameterform wäre: vPoint + t*vDir
	
	//Gerade in Koordinatenform umwandeln:
	//x = vPoint[0] + vDir[0] * t
	//y = vPoint[1] + vDir[1] * t
	//z = vPoint[2] + vDir[2] * t
	
	/**************************************
	***		Lageprüfung von E und G		***
	**************************************/
	//Gerade und Ebene sind parallel, wenn n*v=0
	//n ist der Normalenvektor der Ebene
	//v ist der Richtungsvektoren der Geraden
	if(VectorDot(n, vDir) == 0)
	{
		//Die Gerade liegt gänzlich in der Ebene, wenn der Stützvektor der Gerade in der Ebene liegt
		//Dazu den Stützvektor in die Koordinatenform der Ebene einsetzen
		if((n[0]*vPoint[0] + n[1]*vPoint[1] + n[2]*vPoint[2] - dot) == 0)
			return true;

		return false;
	}
		
	/**************************************
	***			Durchstosspunkt			***
	**************************************/
	//Die Gerade ist also nicht parallel zur Ebene, d.h. sie durchstösst die Ebene an einem Punkt
	
	//Die Koordinatenformen der Gerade in die Koordinatenform der Ebene einsetzen
	//und nach t ausmultiplizieren
	t = (0-(n[0]*vPoint[0] + n[1]*vPoint[1] + n[2]*vPoint[2] - dot)) / (n[0]*vDir[0] + n[1]*vDir[1] + n[2]*vDir[2]);

	//Wurde der Spieler in den Rücken getroffen, dann ist es definitiv kein Schildtreffer!
	if(t < 0)
		return false;

	//t in die Koordinatenformen der Gerade einsetzen um die Koordinaten des Durchstosspunkts zu bekommen
	SP = vPoint + vDir * t;	
	
	self thread DebugRiotShield(A,B,C,D,vPoint,SP,eAttacker,eInflictor);
	
	//Hier noch prüfen, ob der Durchstosspunkt innerhalb der Rechtecks liegt
	//Dazu die Richtungsvektoren des Rechtecks aufspannen
	//w wird nur benötigt, wenn das Rechteck keine Fläche, sondern ein Körper ist:
	u = B - A;
	v = D - A;
	//w = A_A - A;
	
	//Ein Punkt liegt im Rechteck, wenn alle (bei einer Fläche nur die ersten beiden) Bedingungen erfüllt sind:
	//Das Skalarprodukt von u.SP liegt zwischen dem Skalarprodukt von u.A um dem Skalarprodukt von u.B
	//Das Skalarprodukt von v.SP liegt zwischen dem Skalarprodukt von v.A um dem Skalarprodukt von v.D
	//Das Skalarprodukt von w.SP liegt zwischen dem Skalarprodukt von w.A um dem Skalarprodukt von w.A_A
	dots = [];
	dots["u"] = [];
	dots["u"]["x"] = VectorDot(u, SP);
	dots["u"]["A"] = VectorDot(u, A);
	dots["u"]["B"] = VectorDot(u, B);
	
	dots["v"] = [];
	dots["v"]["x"] = VectorDot(v,SP);
	dots["v"]["A"] = VectorDot(v,A);
	dots["v"]["D"] = VectorDot(v,D);
	
	//dots["w"] = [];
	//dots["w"]["x"] = VectorDot(w,SP);
	//dots["w"]["A"] = VectorDot(w,A);
	//dots["w"]["B"] = VectorDot(w,A_A);
	
	if((dots["u"]["A"] <= dots["u"]["x"] && dots["u"]["x"] <= dots["u"]["B"]) || (dots["u"]["B"] <= dots["u"]["x"] && dots["u"]["x"] <= dots["u"]["A"]))
	{
		if((dots["v"]["A"] <= dots["v"]["x"] && dots["v"]["x"] <= dots["v"]["D"]) || (dots["v"]["D"] <= dots["v"]["x"] && dots["v"]["x"] <= dots["v"]["A"]))
		{
			//if((dots["w"]["A"] <= dots["w"]["x"] && dots["w"]["x"] <= dots["w"]["A_A"]) || (dots["w"]["A_A"] <= dots["w"]["x"] && dots["w"]["x"] <= dots["w"]["A"]))
			{
				PlayFx(level._effect["riotshield_impact"], SP);
				return true;
			}
		}
	}
	
	return false;
}

DebugRiotShield(A,B,C,D,vPoint,SP,eAttacker,eInflictor)
{
	self notify("riot_debug_line");
	self endon("riot_debug_line");

	if(isDefined(eInflictor) && eInflictor != eAttacker)
		weapon = eInflictor getTagOrigin("tag_origin");
	else
	{
		if(eAttacker isDogModel() || eAttacker.model == "body_complete_mp_zombie_packboy")
			return;
		
		weapon = eAttacker getEye()/*getTagOrigin("tag_weapon_left")*/;
	}
	
	while(1)
	{
		wait.05;
		
		line(A, B, (1,0,0));
		line(B, C, (1,0,0));
		line(C, D, (1,0,0));
		line(D, A, (1,0,0));
		line(vPoint, SP, (0,1,0));
		line(vPoint, weapon, (0,0,1));
	}
}

/*-----------------------|
|	huds/menu related	 |
|-----------------------*/
isADigit(letter)
{
	switch(letter)
	{
		case "0":
		case "1":
		case "2":
		case "3":
		case "4":
		case "5":
		case "6":
		case "7":
		case "8":
		case "9":	return true;
		default: 	return false;
	}
}

FirstLetterToUpper(string)
{
	letter = getSubStr(string, 0, 1);
	
	if(letter == "a") letter = "A";
	else if(letter == "b") letter = "B";
	else if(letter == "c") letter = "C";
	else if(letter == "d") letter = "D";
	else if(letter == "e") letter = "E";
	else if(letter == "f") letter = "F";
	else if(letter == "g") letter = "G";
	else if(letter == "h") letter = "H";
	else if(letter == "i") letter = "I";
	else if(letter == "j") letter = "J";
	else if(letter == "k") letter = "K";
	else if(letter == "l") letter = "L";
	else if(letter == "m") letter = "M";
	else if(letter == "n") letter = "N";
	else if(letter == "o") letter = "O";
	else if(letter == "p") letter = "P";
	else if(letter == "q") letter = "Q";
	else if(letter == "r") letter = "R";
	else if(letter == "s") letter = "S";
	else if(letter == "t") letter = "T";
	else if(letter == "u") letter = "U";
	else if(letter == "v") letter = "V";
	else if(letter == "w") letter = "W";
	else if(letter == "x") letter = "X";
	else if(letter == "y") letter = "Y";
	else if(letter == "z") letter = "Z";
	
	string = letter + getSubStr(string, 1, string.size);
	
	return string;
}

ColorForHealth(percentage)
{
	color = (0,0,0);
	
	if(isDefined(percentage))
	{
		if(percentage >= 0 && percentage <= 10)
			color = (1, 0, 0);
		else if(percentage >= 11 && percentage <= 20)
			color = (1, 0.175, 0);
		else if(percentage >= 21 && percentage <= 30)
			color = (1, 0.325, 0);
		else if(percentage >= 31 && percentage <= 40)
			color = (1, 0.65, 0);
		else if(percentage >= 41 && percentage <= 50)
			color = (1, 0.825, 0);
		else if(percentage >= 51 && percentage <= 60)
			color = (1, 1, 0);
		else if(percentage >= 61 && percentage <= 70)
			color = (0.825, 1, 0);
		else if(percentage >= 71 && percentage <= 80)
			color = (0.65, 1, 0);
		else if(percentage >= 81 && percentage <= 90)
			color = (0.325, 1, 0);
		else if(percentage >= 91 && percentage <= 100)
			color = (0, 1, 0);
	}
		
	return color;
}

getLocalizedWeaponName(weapon)
{
	if(!isDefined(weapon) || weapon == "")
		return &"";

	weaponName = tableLookup("mp/statstable.csv", 4, getSubStr(weapon, 0, weapon.size - 3), 3);

	switch(weaponName)
	{
		case "WEAPON_AK47": return &"WEAPON_AK47";
		case "WEAPON_AK74U": return &"WEAPON_AK74U";
		case "WEAPON_BARRETT": return &"WEAPON_BARRETT";
		case "WEAPON_BENELLI": return &"WEAPON_BENELLI";
		case "WEAPON_C4": return &"WEAPON_C4";
		case "WEAPON_CLAYMORE": return &"WEAPON_CLAYMORE";
		case "WEAPON_COLT1911": return &"WEAPON_COLT1911";
		case "WEAPON_CONCUSSION_GRENADE": return &"WEAPON_CONCUSSION_GRENADE";
		case "WEAPON_DESERTEAGLE": return &"WEAPON_DESERTEAGLE";
		case "WEAPON_DESERTEAGLEGOLD": return &"WEAPON_DESERTEAGLEGOLD";
		case "WEAPON_DRAGUNOV": return &"WEAPON_DRAGUNOV";
		case "WEAPON_FLASH_GRENADE": return &"WEAPON_FLASH_GRENADE";
		case "WEAPON_FRAGGRENADE": return &"WEAPON_FRAGGRENADE";
		case "WEAPON_G3": return &"WEAPON_G3";
		case "WEAPON_G36C": return &"WEAPON_G36C";
		case "WEAPON_GRENADE_LAUNCHER": return &"WEAPON_GRENADE_LAUNCHER";
		case "WEAPON_M14": return &"WEAPON_M14";
		case "WEAPON_M21": return &"WEAPON_M21";
		case "WEAPON_M16": return &"WEAPON_M16";
		case "WEAPON_SAW": return &"WEAPON_SAW";
		case "WEAPON_M40A3": return &"WEAPON_M40A3";
		case "WEAPON_M4_CARBINE": return &"WEAPON_M4_CARBINE";
		case "WEAPON_M60E4": return &"WEAPON_M60E4";
		case "WEAPON_BERETTA": return &"WEAPON_BERETTA";
		case "WEAPON_UZI": return &"WEAPON_UZI";
		case "WEAPON_MP44": return &"WEAPON_MP44";
		case "WEAPON_MP5": return &"WEAPON_MP5";
		case "WEAPON_P90": return &"WEAPON_P90";
		case "WEAPON_REMINGTON700": return &"WEAPON_REMINGTON700";
		case "WEAPON_RPD": return &"WEAPON_RPD";
		case "WEAPON_RPG": return &"WEAPON_RPG";
		case "WEAPON_SKORPION": return &"WEAPON_SKORPION";
		case "WEAPON_SMOKE_GRENADE": return &"WEAPON_SMOKE_GRENADE";
		case "WEAPON_USP": return &"WEAPON_USP";
		case "WEAPON_WINCHESTER1200": return &"WEAPON_WINCHESTER1200";
		default: return &"";
	}
}

getEventTextFromName()
{
	switch(game["customEvent"])
	{
		case "alien": 				return "Current Event: ^1Alien";
		case "beastking": 			return "Current Event: ^1Beastking";
		case "dogfight": 			return "Current Event: ^1Dogfight";
		case "funday": 				return "Current Event: ^1Funday";
		case "kingvsking": 			return "Current Event: ^1King vs King";
		case "hideandseek": 		return "Current Event: ^1Hide and Seek";
		case "knifeonly": 			return "Current Event: ^1Knife Only";
		case "lastkingstanding":	return "Current Event: ^1Last King Standing";
		case "reversektk": 			return "Current Event: ^1Reverse KtK";
		case "revolt": 				return "Current Event: ^1Revolt";
		case "sniperonly": 			return "Current Event: ^1Sniper only";
		case "tankking": 			return "Current Event: ^1Tankking";
		case "terror": 				return "Current Event: ^1Terror";
		case "traitors": 			return "Current Event: ^1Traitors";
		case "unknownking": 		return "Current Event: ^1Unknown King";
		case "zombie": 				return "Current Event: ^1Zombie";
		default:					return "Current Event: ^1None (default KtK)";
	}
}

getLocalizedEventTextFromName()
{
	switch(game["customEvent"])
	{
		case "alien": 				return &"Current Event: ^1Alien";
		case "beastking": 			return &"Current Event: ^1Beastking";
		case "dogfight": 			return &"Current Event: ^1Dogfight";
		case "funday": 				return &"Current Event: ^1Funday";
		case "hideandseek": 		return &"Current Event: ^1Hide and Seek";
		case "kingvsking": 			return &"Current Event: ^1King vs King";
		case "knifeonly": 			return &"Current Event: ^1Knife Only";
		case "lastkingstanding":	return &"Current Event: ^1Last King Standing";
		case "reversektk": 			return &"Current Event: ^1Reverse KtK";
		case "revolt": 				return &"Current Event: ^1Revolt";
		case "sniperonly": 			return &"Current Event: ^1Sniper only";
		case "tankking": 			return &"Current Event: ^1Tankking";
		case "terror": 				return &"Current Event: ^1Terror";
		case "traitors": 			return &"Current Event: ^1Traitors";
		case "unknownking": 		return &"Current Event: ^1Unknown King";
		case "zombie": 				return &"Current Event: ^1Zombie";
		default:					return &"Current Event: ^1None (default KtK)";
	}
}

getEventName(event)
{
	switch(event)
	{
		case "alien": 				return "Alien";
		case "beastking": 			return "Beastking";
		case "dogfight": 			return "Dogfight";
		case "funday": 				return "Funday";
		case "hideandseek": 		return "Hide and Seek";
		case "kingvsking": 			return "King vs King";
		case "knifeonly": 			return "Knife Only";
		case "lastkingstanding":	return "Last King Standing";
		case "reversektk": 			return "Reverse KtK";
		case "revolt": 				return "Revolt";
		case "sniperonly": 			return "Sniper Only";
		case "tankking": 			return "Tankking";
		case "terror": 				return "Terror";
		case "traitors": 			return "Traitors";
		case "unknownking": 		return "Unknown King";
		case "zombie": 				return "Zombie";
		default:					return "None (default KtK)";
	}
}

getEventNameFromShortcut(shortcut)
{
	switch(shortcut)
	{
		case "aliens": 
		case "alien": 				return "alien";
		case "beast": 
		case "beastking": 			return "beastking";
		case "dog":
		case "dogs":
		case "doggy":
		case "dogfight": 			return "dogfight";
		case "fun":
		case "funny":
		case "funday": 				return "funday";
		case "hns":
		case "props":
		case "seek":
		case "hideandseek": 		return "hideandseek";
		case "kvk":
		case "king":
		case "kings":
		case "kingvsking": 			return "kingvsking";
		case "knife":
		case "knifes":
		case "melee":
		case "knifeonly":			return "knifeonly";
		case "lks":
		case "last":
		case "lastking":
		case "deathmatch":
		case "dm":
		case "lastkingstanding":	return "lastkingstanding";
		case "reverse":
		case "reversed":
		case "opposite":
		case "reversektk": 			return "reversektk";
		case "revolt": 				return "revolt";
		case "sniper":
		case "snipers":
		case "sniping":
		case "sniperonly":			return "sniperonly";
		case "tank":
		case "tankking": 			return "tankking";
		case "bomb":
		case "terrorists":
		case "infidel":
		case "terror":				return "terror";
		case "traitor":
		case "traitors": 			return "traitors";
		case "secret":
		case "hide":
		case "hidden":
		case "unknow":
		case "unknown":
		case "unknownking": 		return "unknownking";
		case "undead":
		case "zom":
		case "zombie":
		case "zombies": 			return "zombie";
		default:					return "none";
	}
}

GetMapName(map)
{
	if(getSubStr(map, 0, 3) == "mp_")
		mapname = getSubStr(map, 3, map.size);
	else
		mapname = map;
		
	mapname = FirstLetterToUpper(mapname);

	return mapname;
}

/*-----------------------|
|	entity related		 |
|-----------------------*/
waitTillNotMoving()
{
	self endon("death");

	while(1)
	{
		if(!level.roundstarted)
			break;
	
		prevorigin = self.origin;
		wait .05;
		
		if(!isDefined(self))
			break;
		
		if(self.origin == prevorigin)
			break;
	}
}

/*-----------------------|
|		hardpoints		 |
|-----------------------*/
canUseHardpoint(hardpoint)
{
	if(game["customEvent"] != "kingvsking")
	{
		if(self isAnAssassin())
		{
			if(hardpoint == level.ktkWeapon["rccar"])
				return false;
			else if(hardpoint == level.ktkWeapon["mortars"])
				return false;
			else if(hardpoint == level.ktkWeapon["ac130"])
				return false;
			else if(hardpoint == level.ktkWeapon["predator"])
				return false;
			else if(hardpoint == level.ktkWeapon["sentrygun"])
				return false;
			else if(hardpoint == "helicopter_mp")
				return false;
			else if(hardpoint == "airstrike_mp")
				return false;
			else if(hardpoint == "napalm_mp")
				return false;
		}
	}
		
	return true;
}

CalculateHeliHealth()
{
	basicHealth = getDvarInt("scr_mod_heli_health");
	additionalHealth = getDvarInt("scr_mod_heli_healthaddition");

	totalAddition = (level.players.size * additionalHealth);
	totalHealth = basicHealth + totalAddition;
	
	return totalHealth;
}

VehicleCanSpawn()
{
	vehicles = getEntArray("script_vehicle", "classname");

	if(vehicles.size > 6)
		return false;

	return true;
}

VehicleUsage()
{
	vehicles = getEntArray("script_vehicle", "classname");

	return vehicles.size;
}

GetSkyHeight()
{
	if(isDefined(level.heli_paths))
	{
		heli_loop_start = getEntArray("heli_loop_start", "targetname");
		
		if(isDefined(heli_loop_start) && heli_loop_start.size > 0)
		{
			height = heli_loop_start[0].origin[2];
			
			heli_nodes = [];
			heli_nodes[0] = heli_loop_start[0];
			for(i=1;i<20;i++)
			{
				heli_nodes[i] = getEnt(heli_nodes[i-1].target, "targetname");
				
				if(!isDefined(heli_nodes[i]))
					break;
				
				if(heli_nodes[i].target == heli_nodes[0].target)
					break;
				
				if(heli_nodes[i].origin[2] >= height)
					height = heli_nodes[i].origin[2];
			}
			
			return height;
		}
	}
	
	trace = BulletTrace((level.mapCenter[0], level.mapCenter[1], 100000), level.mapCenter, false, undefined);
	trace = BulletTrace((level.mapCenter[0], level.mapCenter[1], 1000), trace["position"], false, undefined);
	
	if((trace["position"][2] - level.mapCenter[2]) > 1600)
		trace["position"] = (trace["position"][0], trace["position"][1], 1600);

	return (trace["position"][2] - 100);
}

HeliCloseNades()
{
	self endon("death");
	
	while(1)
	{
		pos = self.origin;
	
		for(i=0;i<level.grenades.size;i++)
		{
			if(isDefined(level.grenades[i]) && level.grenades[i].model != "" && level.grenades[i].model != "com_plasticcase_green_big" && (Distance(level.grenades[i].origin, (pos + (-224, 0, -88))) <= 176 || Distance(level.grenades[i].origin, (pos + (128, 0, -88))) <= 176))
			{
				if(isDefined(level.grenades[i].HeliAttacker))
					self notify("damage", level.grenades[i].HeliDamage, level.grenades[i].HeliAttacker);
				
				if(isDefined(level.grenades[i].usedWeapon) && level.grenades[i].usedWeapon == level.ktkWeapon["throwingKnife"])
					level.grenades[i] delete();
				else
					level.grenades[i] Detonate();
			}
		}
		wait 0.1;
	}
}

TargetMarkers()
{
	self endon("death");
	self endon("disconnect");

	if(getDvarInt("scr_mod_targetmarkers") == 0)
		return;

	self setClientDvars("waypointiconheight", 20,
						"waypointiconwidth", 20);

	self.targetMarkers = [];

	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(self.targetMarkers[i]))
			self.targetMarkers[i] delete();
	
		self.targetMarkers[i] = newClientHudElem(self);
		self.targetMarkers[i].x = level.players[i].origin[0];
		self.targetMarkers[i].y = level.players[i].origin[1];
		self.targetMarkers[i].z = level.players[i].origin[2];
		self.targetMarkers[i].isFlashing = false;
		self.targetMarkers[i].isShown = true;
		self.targetMarkers[i].baseAlpha = 0;
		self.targetMarkers[i].alpha = 0;
		self.targetMarkers[i].owner = self;
		self.targetMarkers[i].team = self.pers["team"];
		self.targetMarkers[i].target = level.players[i];
		self.targetMarkers[i] setShader("waypoint_kill", 15, 15);
		self.targetMarkers[i] setWayPoint(true, "waypoint_kill");
		self.targetMarkers[i] setTargetEnt(level.players[i]);
		
		self.targetMarkers[i] thread monitorMarkerVisibility();
	}
}

monitorMarkerVisibility()
{
	self endon("death");
	
	if(isDefined(self.owner) && isDefined(self.target) && self.owner == self.target)
		return;
	
	while(1)
	{
		wait .05;
		
		if(!isDefined(self))
			break;
			
		if(!isDefined(self.owner) || !isPlayer(self.owner) || !isAlive(self.owner))
			break;
			
		if(!isDefined(self.target) || !isPlayer(self.target) || !isDefined(self.target getEntityNumber()))
			break;

		if(!isAlive(self.target) || self.target.sessionstate != "playing")
		{
			self.baseAlpha = 0;
			self.alpha = 0;
			continue;
		}

		if(self.target.pers["team"] == self.team)
		{
			self.baseAlpha = 0;
			self.alpha = 0;
			continue;
		}
	
		if(self.target hasWeapon(level.ktkWeapon["javelin"]))
		{
			self.baseAlpha = 0;
			self.alpha = 0;
			continue;
		}
	
		self.baseAlpha = 1;
		self.alpha = 1;
	}
}

DeleteTargetMarkers()
{
	self endon("disconnect");

	if(!isDefined(self))
		return;
	
	self setClientDvars("waypointiconheight", 36,
						"waypointiconwidth", 36);
	
	if(!isDefined(self.targetMarkers))
		return;
	
	for(i=0;i<self.targetMarkers.size;i++)
	{
		if(isDefined(self.targetMarkers[i]))
		{
			self.targetMarkers[i] clearTargetEnt();
			self.targetMarkers[i] destroy();
		}
	}
}

//new actionslot system :)
DefineHardpointSlots()
{
	self endon("disconnect");
	
	if(isDefined(self.pers["actionslot"]))
		return;
	
	self.pers["actionslot"] = [];
	
	for(i=1;i<5;i++)
	{
		self.pers["actionslot"][i]["slot"] = i;
		self.pers["actionslot"][i]["type"] = "";
		self.pers["actionslot"][i]["weapon"] = "";
	}
}

setWeaponToSlot(weapon)
{
	self endon("disconnect");
	self endon("death");
	
	if(!isDefined(weapon) || weapon == "")
	{
		self.pers["actionslot"][3]["slot"] = 3;
		self.pers["actionslot"][3]["type"] = "";
		self.pers["actionslot"][3]["weapon"] = "";
		
		self setActionSlot(3, "");
		return;
	}
	
	self.pers["actionslot"][3]["slot"] = 3;
	self.pers["actionslot"][3]["type"] = "weapon";
	self.pers["actionslot"][3]["weapon"] = weapon;
	
	self setActionSlot(3, "weapon", weapon);
}

SetHardpointToSlot(type, weapon, playsound, forcedSlot)
{
	self endon("disconnect");

	if(isDefined(forcedSlot))
		slot = forcedSlot;
	else
	{
		if(self AlreadyHasThisHardpoint(weapon))
			slot = GetSlotForHardpoint(weapon);
		else
			slot = self HasFreeHardpointSlots();
	}

	if(slot <= 0)
	{
		scr_iPrintLnBold("NO_FREE_SLOTS", self);
		return undefined;
	}
	
	if(!isDefined(weapon) || weapon == "")
		return undefined;
	
	if(!isDefined(type) || type != "weapon")
		return undefined;

	if(!isDefined(self.pers["actionslot"]) || !isDefined(self.pers["actionslot"][slot]))
		return undefined;
	
	self.pers["actionslot"][slot]["type"] = type;
	self.pers["actionslot"][slot]["weapon"] = weapon;

	if(self hasWeapon(weapon))
		self takeWeapon(weapon);

	self giveWeapon(weapon);
	self giveMaxAmmo(weapon);
	self setActionSlot(slot, type, weapon);

	if(!isDefined(playsound))
		playsound = false;

	if(playsound && level.roundstarted)
	{
		if(self isAGuard() || game["customEvent"] == "knifeonly")
			self PlayLocalSound(getHardpointSoundFromWeapon(weapon));
	}
			
	if(self isABot())
	{
		wait .05;
		self setSpawnWeapon(weapon);
	}
		
	return weapon;
}

GetHardpointInSlot(slot)
{
	self endon("disconnect");

	if(self.pers["actionslot"][slot]["type"] == "weapon")
		return self.pers["actionslot"][slot]["weapon"];

	return "none";
}

GetSlotForHardpoint(weapon)
{
	self endon("disconnect");

	for(i=1;i<5;i++)
	{
		if(isDefined(self.pers["actionslot"][i]["weapon"]) && self.pers["actionslot"][i]["weapon"] == weapon)
			return self.pers["actionslot"][i]["slot"];
	}
	
	return undefined;
}

HasFreeHardpointSlots()
{
	self endon("disconnect");

	for(i=1;i<5;i++)
	{
		if(i==3)
			continue;
		
		if(self GetHardpointInSlot(self.pers["actionslot"][i]["slot"]) == "" || self GetHardpointInSlot(self.pers["actionslot"][i]["slot"]) == "none")
			return self.pers["actionslot"][i]["slot"];
	}
	
	return 0;
}

ResetHardpointSlot(slot)
{
	self endon("disconnect");

	if(isDefined(slot))
	{
		if(self HasWeapon(self GetHardpointInSlot(slot)))
			self TakeWeapon(self GetHardpointInSlot(slot));
	
		self setActionSlot(slot, "");
		self.pers["actionslot"][slot]["type"] = "";
		self.pers["actionslot"][slot]["weapon"] = "";
	}
}

UpdateHardpointSelection()
{
	self endon("disconnect");
	
	if(!isDefined(self.forceHardpointUpdate) || !self.forceHardpointUpdate)
	{
		if(isDefined(level.roundstarted) && level.roundstarted)
			return;
	}
		
	if(isDefined(self.pers["update_selected_hardpoints"]) && !self.pers["update_selected_hardpoints"])
		return;
	
	for(j=0;j<3;j++)
	{
		for(i=2388;i<=2398;i++)
		{
			if(self GetStat(i) == 1)
			{
				hardpoint = GetHardpointForStat(i);
				
				if(j>0)
				{
					if(isDefined(self.pers["selected_hardpoints"][0]) && self.pers["selected_hardpoints"][0] == hardpoint)
						continue;
						
					if(isDefined(self.pers["selected_hardpoints"][1]) && self.pers["selected_hardpoints"][1] == hardpoint)
						continue;
				}
			
				self.pers["selected_hardpoints"][j] = hardpoint;
				break;
			}
		}
	}
	
	self thread maps\mp\gametypes\_awards::GetPersonalLastHardpoint();
	
	self.pers["update_selected_hardpoints"] = false;
}

GetHardpointForStat(stat)
{
	self endon("disconnect");
	
	switch(stat)
	{
		case 2388: return level.ktkWeapon["rccar"];
		case 2389: return level.ktkWeapon["poisongas"];
		case 2390: return "marker_mp";
		case 2391: return "airstrike_mp";
		case 2392: return level.ktkWeapon["mortars"];
		case 2393: return "helicopter_mp";
		case 2394: return level.ktkWeapon["ac130"];
		case 2395: return level.ktkWeapon["sentrygun"];
		case 2396: return level.ktkWeapon["predator"];
		case 2397: return level.ktkWeapon["nuke"];
		case 2398: return level.ktkWeapon["juggernaut"];
		default: return;
	}
}

HasChosenHardpoint(hardpoint)
{
	self endon("disconnect");

	if(getDvarInt("scr_hardpoint_system") == 0)
		return true;
	
	if(!isDefined(hardpoint) || hardpoint == "")
		return false;
		
	if(isDefined(self.pers["selected_hardpoints"][0]) && self.pers["selected_hardpoints"][0] == hardpoint)
		return true;

	if(isDefined(self.pers["selected_hardpoints"][1]) && self.pers["selected_hardpoints"][1] == hardpoint)
		return true;

	if(isDefined(self.pers["selected_hardpoints"][2]) && self.pers["selected_hardpoints"][2] == hardpoint)
		return true;
	
	return false;
}

AlreadyHasThisHardpoint(weapon)
{
	self endon("disconnect");

	if(isDefined(weapon) && (/*self HasWeapon(weapon) ||*/ isDefined(self GetSlotForHardpoint(weapon))))
		return true;
		
	return false;
}

getHardpointNameFromWeapon(weapon)
{
	if(isDefined(weapon) && weapon == level.ktkWeapon["rccar"]) 		return "rccar";
	if(isDefined(weapon) && weapon == level.ktkWeapon["poisongas"]) 	return "poison";
	if(isDefined(weapon) && weapon == level.ktkWeapon["mortars"]) 		return "mortar";
	if(isDefined(weapon) && weapon == level.ktkWeapon["ac130"]) 		return "ac130";
	if(isDefined(weapon) && weapon == level.ktkWeapon["sentrygun"]) 	return "sentrygun";
	if(isDefined(weapon) && weapon == level.ktkWeapon["predator"]) 		return "predator";
	if(isDefined(weapon) && weapon == level.ktkWeapon["nuke"]) 			return "nuke";
	if(isDefined(weapon) && weapon == level.ktkWeapon["juggernaut"]) 	return "juggernaut";
	if(isDefined(weapon) && weapon == "helicopter_mp") 					return "heli";
	if(isDefined(weapon) && weapon == "airstrike_mp") 					return "airstrike";
	if(isDefined(weapon) && weapon == "marker_mp") 						return "cp";

	return "";
}

getCPIconFromWeapon(weapon)
{
	if(isDefined(weapon) && weapon == level.ktkWeapon["crossbowExp"]) 	return "hud_icon_c4";
	if(isDefined(weapon) && weapon == level.ktkWeapon["rccar"]) 		return "hud_icon_rccar";
	if(isDefined(weapon) && weapon == level.ktkWeapon["mortars"])		return "compass_objpoint_flak";
	if(isDefined(weapon) && weapon == level.ktkWeapon["predator"])		return "hud_icon_predator";
	if(isDefined(weapon) && weapon == level.ktkWeapon["nuke"])			return "hud_icon_nuke";
	if(isDefined(weapon) && weapon == level.ktkWeapon["sentrygun"])		return "hud_icon_sentrygun";
	if(isDefined(weapon) && weapon == level.ktkWeapon["ac130"])			return "hud_icon_ac130";
	if(isDefined(weapon) && weapon == level.ktkWeapon["magnum"])		return "hud_mw2_magnum";
	if(isDefined(weapon) && weapon == "helicopter_mp")					return "compass_objpoint_helicopter";
	if(isDefined(weapon) && weapon == "airstrike_mp")					return "compass_objpoint_airstrike";
	if(isDefined(weapon) && weapon == "marker_mp")						return "hud_icon_carepackage";
	if(isDefined(weapon) && weapon == "juggernaut")						return "hud_icon_juggernaut";
	if(isDefined(weapon) && weapon == "tripwire")						return "hud_grenadeicon";
	if(isDefined(weapon) && weapon == "fakeguard")						return "guards_logo";
	if(isDefined(weapon) && weapon == "javelin") 						return "hud_icon_javelin";
	if(isDefined(weapon) && weapon == level.ktkWeapon["javelin"]) 		return "hud_icon_javelin";
	
	return "";
}

getHardpointSoundFromWeapon(weapon)
{
	if(isDefined(weapon) && weapon == level.ktkWeapon["ac130"]) return "hardpoint_ac130_ready"; 
	if(isDefined(weapon) && weapon == level.ktkWeapon["mortars"]) return "hardpoint_airstrike_ready"; 
	if(isDefined(weapon) && weapon == level.ktkWeapon["rccar"]) return "hardpoint_rccar_ready"; 
	if(isDefined(weapon) && weapon == level.ktkWeapon["predator"]) return "hardpoint_predator_ready"; 
	if(isDefined(weapon) && weapon == level.ktkWeapon["sentrygun"]) return "hardpoint_sentrygun_ready"; 
	if(isDefined(weapon) && weapon == level.ktkWeapon["nuke"]) return "hardpoint_nuke_ready"; 
	if(isDefined(weapon) && weapon == "helicopter_mp") return "hardpoint_heli_ready"; 
	if(isDefined(weapon) && weapon == "airstrike_mp") return "hardpoint_airstrike_ready"; 
	if(weapon == "marker_mp" && isDefined(self.pers["carepackagetype"]))
	{
		if(self.pers["carepackagetype"] == "carepackage")
			return "hardpoint_carepackage_ready";
		else
			return "hardpoint_airtrap_ready";
	}
	
	return "";
}

/*-----------------------|
|	array related		 |
|-----------------------*/
RemoveUndefinedEntriesFromArray(array)
{
	tempArray = [];
	
	if(array.size > 0)
	{
		for(i=0;i<array.size;i++)
		{
			if(isDefined(array[i]))
				tempArray[tempArray.size] = array[i];
		}
	}
	
	return tempArray;
}

get_array_of_closest( org, array, excluders, max, maxdist )
{
	// pass an array of entities to this function and it will return them in the order of closest
	// to the origin you pass, you can also set max to limit how many ents get returned
	if( !isdefined( max ) )
		max = array.size;
	if( !isdefined( excluders ) )
		excluders = [];
	
	maxdists2rd = undefined;
	if( isdefined( maxdist ) )
		maxdists2rd = maxdist * maxdist;
	
	// return the array, reordered from closest to farthest
	dist = [];
	index = [];
	for( i = 0;i < array.size;i ++ )
	{
		excluded = false;
		for( p = 0;p < excluders.size;p ++ )
		{
			if( array[ i ] != excluders[ p ] )
				continue;
			excluded = true;
			break;
		}
		if( excluded )
			continue;
		
		length = distancesquared( org, array[ i ].origin );
		
		if( isdefined( maxdists2rd ) && maxdists2rd < length )
			continue;
			
		dist[ dist.size ] = length;
		
		
		index[ index.size ] = i;
	}
		
	for( ;; )
	{
		change = false;
		for( i = 0;i < dist.size - 1;i ++ )
		{
			if( dist[ i ] <= dist[ i + 1 ] )
				continue;
			change = true;
			temp = dist[ i ];
			dist[ i ] = dist[ i + 1 ];
			dist[ i + 1 ] = temp;
			temp = index[ i ];
			index[ i ] = index[ i + 1 ];
			index[ i + 1 ] = temp;
		}
		if( !change )
			break;
	}
	
	newArray = [];
	if( max > dist.size )
		max = dist.size;
	for( i = 0;i < max;i ++ )
		newArray[ i ] = array[ index[ i ] ];
	return newArray;
}

sortArray(array, max, sorting)
{
	if(!isDefined(max))
		max = array.size;
		
	if(!isDefined(sorting))
		sorting = "ascending";
		
	index = [];
	value = [];
	
	for(i=0;i<array.size;i++)
	{
		index[index.size] = i;
		value[value.size] = array[i];
	}
	
	while(1)
	{
		change = false;
		
		for(i=0;i<value.size-1;i++)
		{
			if(sorting == "ascending")
			{
				if(value[i] <= value[i+1])
					continue;
			}
			else
			{
				if(value[i] >= value[i+1])
					continue;
			}

			change = true;
			temp = value[i];
			value[i] = value[i+1];
			value[i+1] = temp;
			temp = index[i];
			index[i] = index[i+1];
			index[i+1] = temp;
		}
		
		if(!change)
			break;
	}
	
	newArray = [];
	if(max > value.size)
		max = value.size;
	
	for(i=0;i<max;i++)
		newArray[i] = array[index[i]];
	
	return newArray;
}

shuffleArray(array)
{
	currentIndex = array.size;
	temporaryValue = undefined;
	randomIndex = undefined;

	// While there remain elements to shuffle...
	while(currentIndex != 0)
	{
		// Pick a remaining element...
		randomIndex = randomInt(currentIndex);
		currentIndex -= 1;

		// And swap it with the current element.
		temporaryValue = array[currentIndex];
		array[currentIndex] = array[randomIndex];
		array[randomIndex] = temporaryValue;
	}
	
	return array;
}

removeDuplicatesInArray(array)
{
	newArray = [];

	for(i=0;i<array.size;i++)
	{
		duplication = false;
		for(j=0;j<newArray.size;j++)
		{
			if(array[i].origin == newArray[j])
			{
				duplication = true;
				break;
			}
		}
		
		if(!duplication)
			newArray[newArray.size] = array[i];
	}

    return newArray;
}

removeElementFromArray(array, element)
{
	if(!isDefined(element))
		return array;

	newarray = [];
	for(i=0;i<array.size;i++)
	{
		if(array[i] == element)
			continue;

		newarray[newarray.size] = array[i];
	}

	return newarray;
}

isInArray(array, x, y, z)
{
	for(i=0;i<array.size;i++)
	{
		if(isDefined(x) && array[i] == x)
			return true;
			
		if(isDefined(y) && array[i] == y)
			return true;
		
		if(isDefined(z) && array[i] == z)
			return true;
	}

	return false;
}

/*-----------------------|
|		damage		 |
|-----------------------*/
ktkRadiusDamage(pos, radius, max, min, owner, sWeapon, eInflictor)
{
	curRadiusDamagedEnts = [];
	ents = maps\mp\gametypes\_weapons::getDamageableEnts(pos, radius, true);

	for (i = 0; i < ents.size; i++)
	{
		if (ents[i].entity == self)
			continue;
		
		dist = distance(pos, ents[i].damageCenter);
		
		if ( ents[i].isPlayer )
		{
			// check if there is a path to this entity 130 units above his feet. if not, they're probably indoors
			indoors = !maps\mp\gametypes\_weapons::weaponDamageTracePassed( ents[i].entity.origin, ents[i].entity.origin + (0,0,130), 0, undefined );
			if ( !indoors )
			{
				indoors = !maps\mp\gametypes\_weapons::weaponDamageTracePassed( ents[i].entity.origin + (0,0,130), pos + (0,0,130 - 16), 0, undefined );
				if ( indoors )
				{
					// give them a distance advantage for being indoors.
					dist *= 4;
					if ( dist > radius )
						continue;
				}
			}
			
			if(ents[i].entity isInRCToy() && ents[i].entity.pers["team"] != owner.pers["team"] && isDefined(owner))
			{
				if(ents[i].entity isInRCCar())
					ents[i].entity.rc_car thread maps\mp\gametypes\_rccar::Explode(ents[i].entity);
				else if(ents[i].entity isInRCHelicopter())
					ents[i].entity.rc_heli thread maps\mp\gametypes\_rchelicopter::Explode();
					
				continue;
			}
		}

		ents[i].damage = int(max + (min-max)*dist/radius);
		ents[i].pos = pos;
		ents[i].damageOwner = owner;
		ents[i].weapon = sWeapon;
		ents[i].eInflictor = eInflictor;

		curRadiusDamagedEnts[curRadiusDamagedEnts.size] = ents[i];
	}
	
	if(isDefined(curRadiusDamagedEnts) && curRadiusDamagedEnts.size > 0)
		thread ktkRadiusDamageEntsThread(curRadiusDamagedEnts);
}


ktkRadiusDamageEntsThread(curRadiusDamagedEnts)
{
	self notify ( "ktkRadiusDamageEntsThread" );
	self endon ( "ktkRadiusDamageEntsThread" );

	for (i=0; i < curRadiusDamagedEnts.size; i++)
	{
		if ( !isDefined( curRadiusDamagedEnts[i] ) )
			continue;

		ent = curRadiusDamagedEnts[i];
		
		if ( !isDefined( ent.entity ) )
			continue; 
			
		if ( !ent.isPlayer || isAlive( ent.entity ) )
		{
			ent maps\mp\gametypes\_weapons::damageEnt(
				ent.eInflictor, // eInflictor = the entity that causes the damage (e.g. a claymore)
				ent.damageOwner, // eAttacker = the player that is attacking
				ent.damage, // iDamage = the amount of damage to do
				"MOD_EXPLOSIVE", // sMeansOfDeath = string specifying the method of death (e.g. "MOD_PROJECTILE_SPLASH")
				ent.weapon, // sWeapon = string specifying the weapon used (e.g. "claymore_mp")
				ent.pos, // damagepos = the position damage is coming from
				vectornormalize(ent.damageCenter - ent.pos) // damagedir = the direction damage is moving in
			);
		}
	}
}



/*-----------------------|
|		debugging		 |
|-----------------------*/
DrawDebugLine(start, end, color)
{
	self endon("death");

	while(1)
	{
		wait .05;
		
		line(start, end, color);
	}
}

//this is used at places in the scripts where a notification for the admin/developer
//is needed -> mostly when searching for the origin of a bug
DebugMessage(type, message)
{
	if(!level.ktk_debug_mode)
		return;
	
	if(!isDefined(message))
		return;	
	
	if(!isDefined(type))
		type = 3;
		
	switch(type)
	{
		case 1: messageType = "Info"; break;
		case 2: messageType = "Suggestion"; break;
		case 3: messageType = "Bugreport"; break;
		case 4: messageType = "Warning"; break;
		default: messageType = "Error"; break;
	}
		
	if(type >= level.ktk_debug_mode)
	{
		switch(type)
		{
			case 2: thread maps\mp\gametypes\_debugmessage::feedbackMessage("KTK DEBUG: " + messageType + ": " + message); break;
			case 3: thread maps\mp\gametypes\_debugmessage::bugMessage("KTK DEBUG: " + messageType + ": " + message); break;
			case 4: thread maps\mp\gametypes\_debugmessage::printSecurityMessage("KTK DEBUG: " + messageType + ": " + message); break;
			default: thread maps\mp\gametypes\_debugmessage::printDebugMessage("KTK DEBUG: " + messageType + ": " + message); break;
		}
	}
}