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
	if(getDvar("scr_mod_spawnprotection") == "") setDvar("scr_mod_spawnprotection", 1);
	if(getDvar("scr_mod_spawnprotectionradius") == "") setDvar("scr_mod_spawnprotectionradius", 150);
	if(getDvar("scr_mod_spawnprotectiontime") == "") setDvar("scr_mod_spawnprotectiontime", 5);

	level.ProtectionMaxDist = getDvarInt("scr_mod_spawnprotectionradius");
	level.ProtectionMaxTime = getDvarInt("scr_mod_spawnprotectiontime");
}

Spawnprotection()
{
	self endon("death");
	self endon("disconnect");
	
	self notify("spawnprotected");
	self endon("spawnprotected");
	
	scr_iPrintLn("SPAWNPROTECTION_ENABLED", self);
	
	dist = 0;
	ProtectionTime = level.ProtectionMaxTime;
	spawn = self.origin;
	self.godmode = true;

	//don't cancle the spawnprotection when the use button is still
	//hold after skipping the killcam - add a short delay to give
	//the player time to release the use button
	if(isDefined(self.killcamSkipped) && self.killcamSkipped)
		killcamDelay = 2;
	else
		killcamDelay = 0;
		
	if(isDefined(self.headicon) && self.headicon == "talkingicon")
	{
		scr_iPrintLnBold("AFK_TIMER_DUPLICATED", self);
		ProtectionTime *= 2;
	}
	
	while(dist <= level.ProtectionMaxDist && ProtectionTime > 0 )
	{
		if(!level.roundstarted)
		{
			while(!level.roundstarted)
				wait .1;
		}
		else
		{
			while(self UseButtonPressed() && killcamDelay > 0)
			{
				wait .1;
				killcamDelay -= .1;
			}
		}
		
		if(self UseButtonPressed() || self ADSButtonPressed() || self FragButtonPressed() || self MeleeButtonPressed() || self AttackButtonPressed() || self SecondaryOffhandButtonPressed())
			break;

		dist = distance(spawn, self.origin);
		ProtectionTime -= .1;
		wait .1;
	}
	
	scr_iPrintLn("SPAWNPROTECTION_DISABLED", self);
	
	if(self isInPredator() || self isInRCToy() || self isInParachute() || self isInAC130() || self isInMannedHelicopterTurret())
		return;

	self.godmode = false;
}