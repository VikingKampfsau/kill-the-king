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
	if(getDvarInt("scr_ktk_maxZiplines") < 0) setDvar("scr_ktk_maxZiplines", 0);
	if(getDvarInt("scr_ktk_maxZiplines") > 100) setDvar("scr_ktk_maxZiplines", 100);

	if(game["customEvent"] == "hideandseek")
		return;
	
	level.escapeRope = [];
	level.escapeRope_speed = 300;
	level.escapeRope_hookDist = 50;
	level.escapeRope_minLength = 500;
	level.escapeRope_maxLength = 5000;
	level.escapeRope_partLength = 50;
	level.escapeRope_modelLength = 1000;
	level.escapeRope_xmodel = "rappelrope";
	level.escapeRope_sound["clipin"] = "rappel_liftrope_clipin_plr";
	level.escapeRope_sound["clipout"] = "rappel_clipout_plr";
	level.escapeRope_sound["pushoff_initial"] = "rappel_pushoff_initial_plr";
	level.escapeRope_sound["pushoff_repeat"] = "rappel_pushoff_repeat_plr";
	
	level.max_escapeRope_amount = getDvarInt("scr_ktk_maxZiplines");
	
	precacheModel(level.escapeRope_xmodel);
}

onPlayerDeath()
{
	self endon("disconnect");
	self endon("detaching_from_escapeRope");
	
	while(isAlive(self))
		wait .05;

	self.usingEscapeRope = false;
	self unLink();
		
	if(isDefined(self.escapeRopeLinker))
		self.escapeRopeLinker delete();
}

escapeRopeMonitor()
{
	self endon("disconnect");
	self endon("death");
	
	self notify("escapeRopeMonitor");
	self endon("escapeRopeMonitor");
	
	if(level.max_escapeRope_amount <= 0)
		return;
	
	if(game["customEvent"] == "hideandseek")
		return;
	
	if(self isABot())
		return;
	
	if(self isDog())
		return;
	
	self.escapeRopeInfo = spawnStruct();
	self.escapeRopeInfo.hooked = false;
	self.escapeRopeInfo.hookPos = undefined;
	
	while(self getCurrentWeapon() == level.ktkWeapon["crossbow"])
	{
		wait .05;
		
		if(self GetAmmoCount(level.ktkWeapon["crossbow"]) <= 0)
			break;
		
		if(self useButtonPressed())
		{
			//add a short delay to give the player time to release the use button
			//when the use button is still hold after skipping the killcam
			killcamDelay = 0;
			if(!self.hasDoneCombat || (isDefined(self.killcamSkipped) && self.killcamSkipped))
				killcamDelay = 2;
			
			while((!self.hasDoneCombat || self UseButtonPressed()) && killcamDelay > 0)
			{
				wait .1;
				killcamDelay -= .1;
			}

			if(self useButtonPressed())
				self thread createEscapeRopeHook();
		}
		
		if(self attackButtonPressed())
		{
			self thread createEscapeRopeTargetHook();
		
			while(self attackButtonPressed())
				wait .05;
		}
	}

	self.escapeRopeInfo.hooked = false;
	self.escapeRopeInfo.hookPos = undefined;
}

createEscapeRopeHook()
{
	self endon("disconnect");
	self endon("death");

	//a little delay - just in case we want to revive
	//or to perform any action which requires the use button
	wait .1;
	
	if(isDefined(level.roundstarted) && !level.roundstarted)
		return;
	
	if(level.escapeRope.size >= level.max_escapeRope_amount)
	{
		scr_iPrintLnBold("ZIPLINE_MAX_AMOUNT_REACHED", self);
		return;
	}

	if(self.escapeRopeInfo.hooked)
		return;
		
	if(self isUsingEscapeRope())
		return;
	
	if(self isReviving())
		return;
		
	if(self isBuyingWeapon())
		return;
	
	if(isDefined(self.gungamehint))
		return;
	
	//DO I NEED THIS HERE?
	/*if(self GetAmmoCount(level.ktkWeapon["crossbow"]) <= 0)
	{
		self iPrintLnBold(&"WEAPON_NO_AMMO");
		return;
	}*/
		
	trace = BulletTrace(self getEye(), self getEye() + AnglesToForward(self getPlayerAngles())*level.escapeRope_hookDist, false, self);
	
	if(!isHookablePosition(trace, self))
	{
		if(!self isOnGround())
			scr_iPrintLnBold("ZIPLINE_BAD_START", self);
		else
		{
			scr_iPrintLnBold("ZIPLINE_PLACED_START", self);
			self.escapeRopeInfo.hooked = true;
			self.escapeRopeInfo.hookPos = self.origin;
		}
	}
	else
	{
		scr_iPrintLnBold("ZIPLINE_PLACED_START", self);
		self.escapeRopeInfo.hooked = true;
		self.escapeRopeInfo.hookPos = trace["position"];
	}
}

createEscapeRopeTargetHook()
{
	self endon("disconnect");
	self endon("death");

	if(!self.escapeRopeInfo.hooked)
		return;
	
	if(level.escapeRope.size >= level.max_escapeRope_amount)
	{
		scr_iPrintLnBold("ZIPLINE_MAX_AMOUNT_REACHED", self);
		return;
	}
	
	//DO I NEED THIS HERE?
	/*if(self GetAmmoCount(level.ktkWeapon["crossbow"]) <= 0)
	{
		self iPrintLnBold(&"WEAPON_NO_AMMO");
		return;
	}*/
	
	trace = BulletTrace(self getEye(), self getEye() + AnglesToForward(self getPlayerAngles())*level.escapeRope_maxLength, true, self);
	
	if(!isHookablePosition(trace, self))
		scr_iPrintLnBold("ZIPLINE_BAD_END", self);
	else
	{
		scr_iPrintLnBold("ZIPLINE_PLACED_END", self);
		TieEscapeRope(self.escapeRopeInfo.hookPos, trace["position"]);
	}
	
	self.escapeRopeInfo.hooked = false;
	self.escapeRopeInfo.hookPos = undefined;
}

isHookablePosition(trace, player)
{
	if(!isDefined(trace) || !isDefined(trace["position"]) || !isDefined(trace["surfacetype"]))
		return false;

	if(!isDefined(player) || !isPlayer(player) || !isAlive(player))
		return false;

	if(player.escapeRopeInfo.hooked)
	{
		if(Distance(player.escapeRopeInfo.hookPos, trace["position"]) < level.escapeRope_minLength)
			return false;

		if(Distance(player.escapeRopeInfo.hookPos, trace["position"]) > level.escapeRope_maxLength)
			return false;

		if(!BulletTracePassed(player.escapeRopeInfo.hookPos, trace["position"], false, player))
			return false;
	}

	if(isDefined(trace["entity"]))
	{
		if(isPlayer(trace["entity"]))
			return false;
			
		if(isDefined(level.uav) && trace["entity"] == level.uav)
			return false;
			
		if(isDefined(level.ah6) && trace["entity"] == level.ah6)
			return false;
		
		if(isDefined(level.CpChopper) && trace["entity"] == level.CpChopper)
			return false;
			
		if(isDefined(level.helicopter) && trace["entity"] == level.helicopter)
			return false;

		if(isDefined(trace["entity"].type) && isSubStr(trace["entity"].type, "package"))
			return false;
			
		if(isDefined(trace["entity"].model) && trace["entity"].model == level.SentryModel)
			return false;
			
		if(isDefined(trace["entity"].targetname) && (isSubStr(trace["entity"].targetname, "vehicle") || isSubStr(trace["entity"].targetname, "destructible")))
			return false;
	}
	
	return true;
}

TieEscapeRope(start, end)
{
	entryNo = level.escapeRope.size;
	level.escapeRope[entryNo] = spawnStruct();
	level.escapeRope[entryNo].lookAtPartsOrigins = [];
	level.escapeRope[entryNo].xmodelPart = [];
	level.escapeRope[entryNo].radius = 100;
	level.escapeRope[entryNo].height = Distance(start, end);
	
	if(start[2] >= end[2])
	{
		level.escapeRope[entryNo].hookPos = start;
		level.escapeRope[entryNo].targetPos = end;
	}
	else
	{
		level.escapeRope[entryNo].hookPos = end;
		level.escapeRope[entryNo].targetPos = start;
	}
	
	level.escapeRope[entryNo].lookAtParts = int(Distance(level.escapeRope[entryNo].hookPos, level.escapeRope[entryNo].targetPos) / level.escapeRope_partLength);
	level.escapeRope[entryNo].xmodelParts = Distance(level.escapeRope[entryNo].hookPos, level.escapeRope[entryNo].targetPos) / level.escapeRope_modelLength;
	level.escapeRope[entryNo].lookAtPartsOrigins[0] = level.escapeRope[entryNo].hookPos;
	
	forward = VectorToAngles(level.escapeRope[entryNo].targetPos - level.escapeRope[entryNo].hookPos);
	
	for(j=0;j<=level.escapeRope[entryNo].lookAtParts;j++)
		level.escapeRope[entryNo].lookAtPartsOrigins[j] = level.escapeRope[entryNo].hookPos + AnglesToForward(forward) * (level.escapeRope_partLength * (j+1));

	for(i=1;i<=ceil(level.escapeRope[entryNo].xmodelParts);i++)
	{
		level.escapeRope[entryNo].xmodelPart[i-1] = spawn("script_model", level.escapeRope[entryNo].hookPos + AnglesToForward(forward) /** level.escapeRope_modelLength*/ * i);
		level.escapeRope[entryNo].xmodelPart[i-1] setModel(level.escapeRope_xmodel);
		level.escapeRope[entryNo].xmodelPart[i-1].angles = forward;// + (90,0,0);
		
		if((level.escapeRope[entryNo].xmodelParts - i) < 0)
		{
			//20 because the model has 20 joints in total (21 if tag_origin is counted)
			for(k=floor(20 * (level.escapeRope[entryNo].xmodelParts - i));k>0;k++)
			{
				level.escapeRope[entryNo].xmodelPart[i-1] HidePart("joint" + (20-k), level.escapeRope_xmodel);
				level.escapeRope[entryNo].xmodelPart[i-1].origin += (0,0,100);
			}
		}
	}
	
	level.escapeRope[entryNo] thread escapeRopeUsage(entryNo);
}

escapeRopeUsage(entryNo)
{
	self endon("death");
	
	while(1)
	{
		wait .05;
	
		for(i=0;i<level.players.size;i++)
		{
			if(level.players[i] isASpectator())
				continue;
				
			if(level.players[i] isABot())
				continue;

			if(level.players[i] isDog())
				continue;
			
			if(level.players[i] isInRCToy())
				continue;
			
			if(level.players[i] isInPredator())
				continue;

			if(level.players[i] isInAC130())
				continue;

			if(level.players[i] isInMannedHelicopter())
				continue;

			if(level.players[i] isInMannedHelicopterTurret())
				continue;

			if(level.players[i] isInParachute())
				continue;

			if(level.players[i] isReviving())
				continue;

			if(level.players[i] isInLastStand())
				continue;

			if(level.players[i] isInteractingWithTripwire())
				continue;
			
			//if(level.players[i] isLookingAtEscapeRope(entryNo) && level.players[i] isNextToEscapeRope(entryNo))
			if(level.players[i] isCloseToAndLookingAtEscapeRope(entryNo))
			{
				if(isDefined(level.players[i].lowerMessage))
				{
					level.players[i].lowerMessage.label = level.players[i] GetLocalizedString("ZIPLINE_USAGE_INFO"); //&"Press ^3[{+activate}] ^7/ ^1[{+melee}] ^7to ^3Use^7/^1Destroy ^7the escape rope.";
					level.players[i].lowerMessage.alpha = 1;
					level.players[i].lowerMessage FadeOverTime(0.05);
					level.players[i].lowerMessage.alpha = 0;
				}
			
				if(level.players[i] useButtonPressed())
					level.players[i] thread useEscapeRope(entryNo);
					
				if(level.players[i] meleeButtonPressed())
					level.players[i] thread destroyEscapeRope(entryNo);
			}
		}
	}
}

useEscapeRope(i)
{
	self endon("disconnect");
	self endon("death");
	
	self notify("using_escapeRope");
	self endon("using_escapeRope");
	
	while(self useButtonPressed())
		wait .05;
	
	if(!isDefined(level.escapeRope[i]))
	{
		scr_iPrintLnBold("ZIPLINE_DESTROIED_USAGE", self);
		return;
	}
	
	if(!isDefined(level.escapeRope[i].targetPos))
	{
		scr_iPrintLnBold("ZIPLINE_DESTROIED_USAGE", self);
		return;
	}
	
	if(!isDefined(level.escapeRope[i].hookPos))
	{
		scr_iPrintLnBold("ZIPLINE_DESTROIED_USAGE", self);
		return;
	}
	
	if(self isUsingEscapeRope())
		return;
	
	if(isDefined(self.escapeRopeLinker))
		self.escapeRopeLinker delete();
	
	self thread onPlayerDeath();
	
	self.usingEscapeRope = true;
	self.escapeRopeLinker = spawn("script_model", self.origin);
	
	self.escapeRopeLinker playSound(level.escapeRope_sound["clipin"]);
	self.escapeRopeLinker playSound(level.escapeRope_sound["pushoff_repeat"]);

	self linkTo(self.escapeRopeLinker);
	
	dropTarget = PlayerPhysicsTrace(self.origin, level.escapeRope[i].targetPos - (0,0,level.escapeRope[i].hookPos[2] - self.origin[2]));
	time = Distance(self.origin, dropTarget) / level.escapeRope_speed;
	
	if(time <= 0)
		time = 0.05;
	
	self.escapeRopeLinker moveTo(dropTarget, time);
	self thread detachFromEscapeRope(time);
}

detachFromEscapeRope(delay)
{
	self endon("disconnect");

	self notify("detaching_from_escapeRope");
	self endon("detaching_from_escapeRope");

	wait delay;
	
	self.escapeRopeLinker playSound(level.escapeRope_sound["clipout"]);
	
	self.usingEscapeRope = false;
	self unLink();
		
	if(isDefined(self.escapeRopeLinker))
		self.escapeRopeLinker delete();
}

destroyEscapeRope(entryNo)
{
	if(isDefined(level.escapeRope[entryNo].xmodelPart))
	{
		for(i=0;i<level.escapeRope[entryNo].xmodelPart.size;i++)
			level.escapeRope[entryNo].xmodelPart[i] delete();
	}
	
	if(isDefined(level.escapeRope[entryNo]))
	{
		level.escapeRope[entryNo] notify("death");
		level.escapeRope[entryNo] = undefined;
	}
	
	level.escapeRope = RemoveUndefinedEntriesFromArray(level.escapeRope);
}

isLookingAtEscapeRope(entryNo)
{
	if(!isDefined(level.escapeRope[entryNo]))
		return false;

	if(!isDefined(level.escapeRope[entryNo].lookAtParts) || level.escapeRope[entryNo].lookAtParts <= 0)
		return false;
		
	for(i=0;i<=level.escapeRope[entryNo].lookAtParts;i++)
	{
		if(!isDefined(self))
			break;
			
		if(!isAlive(self))
			break;
	
		if(!isDefined(level.escapeRope[entryNo]))
			break;
			
		if(!isDefined(level.escapeRope[entryNo].lookAtPartsOrigins[i]))
			break;
	
		if(self isLookingAt(level.escapeRope[entryNo].lookAtPartsOrigins[i]))
			return true;
	}
	
	return false;
}

isNextToEscapeRope(entryNo)
{
	if(!isDefined(level.escapeRope[entryNo]))
		return false;
		
	if(!isDefined(level.escapeRope[entryNo].lookAtParts) || level.escapeRope[entryNo].lookAtParts <= 0)
		return false;

	for(i=0;i<=level.escapeRope[entryNo].lookAtParts;i++)
	{
		if(!isDefined(self))
			break;
			
		if(!isAlive(self))
			break;
		
		if(!isDefined(level.escapeRope[entryNo]))
			break;
			
		if(!isDefined(level.escapeRope[entryNo].lookAtPartsOrigins[i]))
			break;
		
		if(Distance(self.origin, level.escapeRope[entryNo].lookAtPartsOrigins[i]) <= 90)
			return true;
	}
	
	return false;
}

isCloseToAndLookingAtEscapeRope(entryNo)
{
	if(!isDefined(level.escapeRope[entryNo]))
		return false;

	if(!isDefined(level.escapeRope[entryNo].lookAtParts) || level.escapeRope[entryNo].lookAtParts <= 0)
		return false;
		
	for(i=0;i<=level.escapeRope[entryNo].lookAtParts;i++)
	{
		if(!isDefined(self))
			break;
			
		if(!isAlive(self))
			break;
	
		if(!isDefined(level.escapeRope[entryNo]))
			break;
			
		if(!isDefined(level.escapeRope[entryNo].lookAtPartsOrigins[i]))
			break;
	
		if(self isLookingAt(level.escapeRope[entryNo].lookAtPartsOrigins[i]))
		{
			if(Distance(self.origin, level.escapeRope[entryNo].lookAtPartsOrigins[i]) <= 90)
				return true;
		}
	}
	
	return false;
}