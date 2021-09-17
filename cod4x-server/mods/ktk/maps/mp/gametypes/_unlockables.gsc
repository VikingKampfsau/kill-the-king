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
	while(1) 
	{ 
		level waittill("connected", player);
		player thread onFirstSpawn();
	}
}

onFirstSpawn()
{
	self endon("disconnect");

	if(self isABot())
		return;
	
	self waittill("spawned_player");
	
	self thread CheckValidUnlock();
}

CheckValidUnlock()
{
	self endon("disconnect");

	costs = 0;
	unlockStatInfo = [];
	
	for(i=2326;i<2480;i++)
	{
		if(i != 2326 && i != 2357 && !valueIsInRange(i, 2359, 2365) && !valueIsInRange(i, 2370, 2379) && !valueIsInRange(i, 2381, 2386) && !valueIsInRange(i, 2430, 2479))
			continue;

		unlockStatInfo[""+i+""] = self getKtkStat(i);
	}

	//First check the correct amount of prestige points
	if(unlockStatInfo["2359"] != (unlockStatInfo["2326"] - unlockStatInfo["2360"]))
		self setKtkStat(2359, (unlockStatInfo["2326"] - unlockStatInfo["2360"]));

	//Then check the amount of unlocks
	//The sum of the prices of the bought items has to be the height of the prestige
	for(i=2361;i<2366;i++)
	{ 
		if(unlockStatInfo[""+i+""] == 1) 
			costs += 2; 
	}
	
	for(i=2370;i<2380;i++)
	{ 
		if(unlockStatInfo[""+i+""] == 1)
		{
			if(i == 2379)
				costs += 2;
			else
				costs++;
		}
	}
	
	for(i=2381;i<2387;i++)
	{ 
		if(unlockStatInfo[""+i+""] >= 1)
		{
			//Check the ammo of the equipment
			if(unlockStatInfo[""+i+""] > 3)
				self setKtkStat(i, 3);
		
			if(i == 2384 || i == 2386)
				costs += (3*unlockStatInfo[""+i+""]);
			else
				costs += (2*unlockStatInfo[""+i+""]);
		}
	}
	
	for(i=2430;i<2480;i++)
	{ 
		if(unlockStatInfo[""+i+""] == 1)
			costs += int(tablelookup("mp/playermodels.csv", 0, i, 7));
	}
	
	//When the sum of the prices of the bought items differs the height of the prestige it's memory dumped
	if(costs > unlockStatInfo["2357"])
		self thread RestoreDefault();
}

valueIsInRange(value, start, end)
{
	if(value < start)
		return false;
		
	if(value > end)
		return false;
		
	return true;
}

unlockableResponseHandler(response)
{
	self endon("disconnect");
	
	if(isSubStr(response, "shop_item_description_"))
	{
		search = getSubStr(response, 22, response.size);
			
		if(search == "nodesc" || int(search) == 7)
			dvarset = "";
		else
		{
			if(int(search) < 13 || int(search) > 22)
			{
				if(self.pers["language"] != "RU")
					dvarset = (TableLookup("mp/unlockables.csv",0,search,2) + "_" + self.pers["language"]);
				else
					dvarset = (self.pers["language"] + TableLookup("mp/unlockables.csv",0,search,2) + "_" + self.pers["language"]);
			}
			else
			{
				dvarset = TableLookup("mp/unlockables.csv",0,search,2);
			}
		}
	
		self setClientDvar("shop_item_description", dvarset);
	}
		
	if(isEquipment(response))
	{
		self setKtkStat(2380, ChangeStatForResponse(response));
		self setKtkStat(GetStatForResponse(response), self getKtkStat(GetStatForResponse(response)) + 1);
		self PayUnlock(response, "equip");
	}
	else if(isSubStr(response, "specialty_"))
	{
		if(isPerk(response))
			self PayUnlock(response, "perk");
		else
			self PayUnlock(response, "misc");
			
		self setKtkStat(GetStatForResponse(response), 1);
	}
	else if(isSubStr(response, "equip_change_"))
		self setKtkStat(2380, ChangeStatForResponse("equip_" + getSubStr(response, 13, response.size)));
	else if(response == "sell_prestige_awards")
		self RestoreDefault();	
}

RestoreDefault()
{
	self endon("disconnect");
	
	for(i=2361;i<2366;i++)
		self setKtkStat(i, 0);

	for(i=2370;i<2380;i++)
		self setKtkStat(i, 0);

	for(i=2381;i<2387;i++)
		self setKtkStat(i, 0);
	
	self setKtkStat(2360, 0);
	self setKtkStat(2359, self getKtkStat(2326));
	
	for(i=2430;i<2480;i++)
	{
		if(i == 2430 || i == 2440 || i == 2450 || i == 2460 || i == 2470)
		{
			self setKtkStat(i, 1);
			continue;
		}

		self setKtkStat(i, 0);
	}
		
	self setKtkStat(2425, 0);
	self setKtkStat(2426, 0);
	self setKtkStat(2427, 0);
	self setKtkStat(2428, 0);
	self setKtkStat(2429, 0);
}

PayUnlock(response, type, minPrice)
{
	self endon("disconnect");

	if(!isDefined(minPrice))
		minPrice = 0;
	
	price = 0;
	
	if(type == "misc") 
		price = 2;
	else if(type == "playermodel")
		price = 2;
	else if(type == "perk")
	{
		if(response == "specialty_armorvest")
			price = 2;
		else
			price = 1;
	}
	else if(type == "equip")
	{
		if(response == "equip_nades" || response == "equip_poison")
			price = 3;
		else
			price = 2;
	}
	
	if(price < minPrice)
		price = minPrice;
	
	self setKtkStat(2359, self getKtkStat(2359) - price);
	self setKtkStat(2360, self getKtkStat(2360) + price);
	
	if(self getKtkStat(2359) < 0)
		self RestoreDefault();
}

GetStatForResponse(response)
{
	switch(response)
	{
		case "specialty_misc_kingspeed": return 2361;
		case "specialty_misc_medic": return 2362;
		case "specialty_misc_gungame": return 2363;
		case "specialty_misc_hardliner": return 2364;
		case "specialty_misc_kingonradar": return 2365;
		
		case "specialty_quieter": return 2370;
		case "specialty_holdbreath": return 2371;
		case "specialty_bulletaccuracy": return 2372;
		case "specialty_longersprint": return 2373;
		case "specialty_bulletpenetration": return 2374;
		case "specialty_rof": return 2375;
		case "specialty_bulletdamage": return 2376;
		case "specialty_explosivedamage": return 2377;
		case "specialty_fastreload": return 2378;
		case "specialty_armorvest": return 2379;

		case "equip_riotshield": return 2381;
		case "equip_cross": return 2382;
		case "equip_clay": return 2383;
		case "equip_nades": return 2384;
		case "equip_knives": return 2385;
		case "equip_poison": return 2386;
		default: return 3499;
	}
}

ChangeStatForResponse(response)
{
	switch(response)
	{
		case "equip_none": return 0;
		case "equip_cross": return 1;
		case "equip_clay": return 2;
		case "equip_nades": return 3;
		case "equip_knives": return 4;
		case "equip_poison": return 5;
		case "equip_riotshield": return 6;
		default: return 0;
	}
}