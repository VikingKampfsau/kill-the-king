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
	if(isDefined(level.uav))
		return;

	thread SpawnUAV();
}

SpawnUAV()
{
	level.uav = Spawn("script_model", (1500, 0, 1500));
	level.uav.helper = Spawn("script_model", level.mapcenter);
	
	level.uav thread UAVFly();
	level.uav thread UAVCheckDamage();
}

UAVCheckDamage()
{
	self endon("death");
	
	self setCanDamage(true);
	self.health = 350;

	while(1)
	{
		self waittill("damage", amount, attacker);

		if((isplayer(attacker) && attacker isInSameTeamAs(level.king)) || attacker isKing())
			continue;
		
		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
		
		self.health -= amount;
		
		if(self.health <= 0)
		{
			attacker maps\mp\gametypes\_rank::giveRankXP("kill", 400);
			self thread RemoveUAV();
			break;
		}
	}
}

UAVFly()
{
	self endon("death");
	
	self setModel("vehicle_uav");
	self linkto(self.helper, "", (1500,0,1500), (0,90,-30));
	self.helper RotateYaw(360, level.radarViewTime);

	wait (level.radarViewTime);

	self thread RemoveUAV();
}

RemoveUAV()
{
	if(isDefined(self))
	{
		self unlink();
		self delete();
	}
}