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
	if(getDvar("scr_knife_assist_range") == "")
		setDvar("scr_knife_assist_range", 128);
		
	if(getDvar("scr_knife_assist_angle") == "")
		setDvar("scr_knife_assist_angle", 15);
	
	level.knife_assist_maxRange	= getDvarInt("scr_knife_assist_range");
	level.knife_assist_maxAngle = getDvarInt("scr_knife_assist_angle");
}

activateKnifeAssist()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_knifeassist");

	if(game["customEvent"] == "hideandseek")
		return;

	if(level.knife_assist_maxRange <= 0)
		return;
		
	if(level.knife_assist_maxAngle <= 0)
		return;
	
	if(self isABot())
		return;

	if(self getKtKStat(2412) == 0)
		return;
	
	if(self getStance() != "stand")
		return;
		
	if(self isInLastStand())
		return;
		
	if(self isReviving())
		return;
		
	if(self isBuyingWeapon())
		return;

	targetInfo = [];
	targetInfo["alpha"] = undefined;
	targetInfo["player"] = undefined;
	targetInfo["vDirToTarget"] = undefined;
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] == self)
			continue;
			
		if(!isAlive(level.players[i]))
			continue;
	
		if(level.teamBased && level.players[i].pers["team"] == self.pers["team"])
			continue;
	
		if(level.players[i] isInRCToy())
			continue;
			
		if(level.players[i] isInPredator())
			continue;
			
		if(level.players[i] isInAC130())
			continue;
			
		if(level.players[i] isInMannedHelicopter())
			continue;
			
		if(level.players[i] isInParachute())
			continue;
			
		if(Distance(level.players[i].origin, self.origin) > level.knife_assist_maxRange)
			continue;

		//player in my back
		angleDiff = maps\mp\gametypes\_missions::AngleClamp180(VectorToAngles(level.players[i].origin - self.origin)[1] - self getPlayerAngles()[1]);
		if(abs(angleDiff) > 30)
			continue;

		//calculate the angle between the 2 lines (view and direct way to target)
		vDist = Distance(self.origin, level.players[i].origin);
		vDirView = VectorToAngles((self getEye() + AnglesToForward(self getPlayerAngles())*vDist) - self getEye());
		vDirToTarget = VectorToAngles(level.players[i].origin - self.origin);

		//!canProne
		if(!BulletTracePassed(self.origin + (0,0,20), self.origin + (0,0,20) + AnglesToForward((0, self getPlayerAngles()[1], 0))*vDist, false, self))
			continue;
		
		//!canCrouch
		if(!BulletTracePassed(self.origin + (0,0,40), self.origin + (0,0,40) + AnglesToForward((0, self getPlayerAngles()[1], 0))*vDist, false, self))
			continue;
			
		//!canStand
		if(!BulletTracePassed(self.origin + (0,0,75), self.origin + (0,0,75) + AnglesToForward((0, self getPlayerAngles()[1], 0))*vDist, false, self))
			continue;
		
		vLengthView = length(vDirView);
		vLengthToTarget = length(vDirToTarget);
		
		if(vLengthView > 0 && vLengthToTarget > 0)
		{
			vDot = vectorDot(vDirView, vDirToTarget);
			alpha = acos(vDot/(vLengthView*vLengthToTarget));
			
			if(alpha <= level.knife_assist_maxAngle)
			{
				if(!isDefined(targetInfo["alpha"]) || alpha < targetInfo["alpha"])
				{
					targetInfo["alpha"] = alpha;
					targetInfo["player"] = level.players[i];
					targetInfo["vDist"] = vDist;
					targetInfo["vDirToTarget"] = vDirToTarget;
				}
			}
		}
	}
	
	if(isDefined(targetInfo["player"]) && isAlive(targetInfo["player"]))
	{
		if(!self isOnGround())
			self setOrigin(self.origin);
	
		targetOrigin = targetInfo["player"].origin - AnglesToForward(targetInfo["vDirToTarget"])*64;
		
		if(PlayerPhysicsTrace(self.origin, targetOrigin, false, self) != targetOrigin)
			return;
			
		if(targetInfo["vDist"] > Distance(self.origin, targetOrigin))
			self setOrigin(targetOrigin);
		
		self setPlayerAngles(VectorToAngles((targetInfo["player"] getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));		
		
		//taken out - when the knife hits an enemy the damage is done and the hitmarker shown anyways
		//this will just confuse players when they get a hitmarker but the enemy does not take damage (and die)
		//self thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
		//targetInfo["player"] maps\mp\gametypes\_globallogic::finishPlayerDamageWrapper(self, self, 1, 0, "MOD_MELEE", level.ktkWeapon["knife"], targetInfo["player"].origin, VectorToAngles(targetInfo["player"].origin - self.origin), "none", 0);
	}
}