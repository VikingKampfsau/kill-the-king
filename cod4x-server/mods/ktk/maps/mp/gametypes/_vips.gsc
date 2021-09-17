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
	level.VipsInServer = 0;
	level.RegularsInServer = 0;

	level.vips = [];
	
	for(index=1; getDvar("scr_mod_vip_" + index) != ""; index++)
		level.vips[index-1] = getDvar("scr_mod_vip_" + index);
	
	thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);

		player.pers["vip"] = false;
		player thread CheckForVip();
	}
}

CheckForVip()
{
	self endon("disconnect");

	if(self isABot())
		level.RegularsInServer++;
	else
	{
		guid = self.guid; //self GetUniquePlayerID();
		
		if(!isDefined(guid) || guid == "")
			self.pers["vip"] = false;
		else
			self.pers["vip"] = isVip(guid);
		
		if(isDefined(self.pers["vip"]) && self.pers["vip"])
			level.VipsInServer++;
		else
			level.RegularsInServer++;
	}
		
	if((level.VipsInServer + level.RegularsInServer) != level.players.size)
		thread RecountVips();
}

isVip(guid) 
{
	self endon("disconnect");

	/*these are the vips forced by the mod, mainly because they helped a lot*/ 
	switch(guid) 
	{ 
		case "1aac7d28": /*Viking (developer)*/ 
		case "c2246916": /*Mr-X*/ 
		case "767ba2b1": /*Rycoon*/ 
		case "0cc2d6a8": /*Blonsky*/
		case "a97fd418": /*Darkjan*/
		case "c743c983": /*Fearz*/
		case "35aedf63": /*Harry*/
			return true; 
		default: break; 
	}

	/*these are the vips set by the serveradmin*/ 
	for(i=0;i<level.vips.size;i++) 
	{ 
		wait .1; 
		if(guid == level.vips[i])
			return true;
	}

	return false; 
}

RecountVips()
{
	self notify("counting_vips");
	self endon("counting_vips");

	while(!isDefined(level.roundstarted) || !level.roundstarted)
		wait .1;

	level.VipsInServer = 0;
	level.RegularsInServer = 0;
	
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].pers["vip"]) && level.players[i].pers["vip"])
			level.VipsInServer++;
		else
			level.RegularsInServer++;
	}
	
	if((level.VipsInServer + level.RegularsInServer) != level.players.size)
		thread RecountVips();
}

onPlayerDisconnect()
{
	self waittill("disconnect");

	if(isDefined(self.pers["vip"]) && self.pers["vip"])
		level.VipsInServer--;
	else
		level.RegularsInServer--;
	
	if((level.VipsInServer + level.RegularsInServer) != level.players.size)
			thread RecountVips();
}