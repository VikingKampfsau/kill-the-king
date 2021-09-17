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
	if(getDvar("scr_mod_afk") == "") setDvar("scr_mod_afk", 0);
	if(getDvar("scr_mod_afkdelay") == "") setDvar("scr_mod_afkdelay", 10);

	level.afkdelay = getDvarInt("scr_mod_afkdelay");
}

CheckForAFK()
{
	self endon("disconnect");
	self endon("death");
	
	while(!level.roundstarted)
		wait .1;

	if(self isMainAssassin())
		return;
		
	if(self isKing())
		return;
		
	if(self isDog())
		return;
		
	if(self isSlave())
		return;
		
	if(self isAFK() && !self isASpectator())
	{
		scr_iPrintLn( "HE_APPEARS_AFK", undefined, self.name );
		self.pers["afkteam"] = self.pers["team"];
		self thread [[level.spectator]]();
	}
}

isAFK()
{
	self endon("disconnect");
	self endon("death");
		
	prevorigin = self.origin;
	afkTimer = level.afkdelay;
	
	if(isDefined(self.pers["adminStatus"]) && self.pers["adminStatus"] > 1)
		afkTimer *= 2;
	
	for(i=0;i<afkTimer;i++)
	{
		if(!level.roundstarted)
			return false;

		if(self.origin != prevorigin && Distance(self.origin, prevorigin) > 30)
			return false;
		
		if(self UseButtonPressed() || self ADSButtonPressed() || self FragButtonPressed() || self MeleeButtonPressed() || self AttackButtonPressed() || self SecondaryOffhandButtonPressed())
			return false;
		
		if(i == int(afkTimer/2))
			scr_iPrintLnBold( "YOU_APPEAR_AFK", self );

		wait 1;
	}
	
	self.pers["afkteam"] = self.pers["team"];
	return true;
}

checkForReconnectToAvoidRole()
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(game["last_assassin_guid"]) && self.guid /*self GetUniquePlayerID()*/ == game["last_assassin_guid"])
		return game["attackers"];
	
	if(isDefined(game["last_helper_guid"]) && self.guid /*self GetUniquePlayerID()*/ == game["last_helper_guid"])
		return game["attackers"];
		
	if(isDefined(game["last_king_guid"]) && self.guid /*self GetUniquePlayerID()*/ == game["last_king_guid"])
		return game["defenders"];
		
	return undefined;		
}