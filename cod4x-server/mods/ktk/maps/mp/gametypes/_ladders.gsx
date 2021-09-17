//Taken from the HNS mod created by iCore
//Changed to the needs of KtK by Viking

#include maps\mp\gametypes\_misc;

init()
{
	level.ladder = [];
	level.laddermodel = [];

	precacheModel("com_steel_ladder");
	precacheItem("ladderclimb_mp");
	
	thread maps\_ladderPositions::initLadders();
}

spawnLadderModel(origin, angles)
{
	slot = level.laddermodel.size;
	level.laddermodel[slot] = spawn("script_model", origin);
	level.laddermodel[slot].angles = angles;
	level.laddermodel[slot] setModel("com_steel_ladder");
}

spawnLadderTrigger(num, origin, angles, distance, elevation, width, height)
{
	if(!isDefined(height))
		height = width;

	//for climbing
	level.ladder[num] = spawn("trigger_radius", origin, 0, width, elevation);
	level.ladder[num].angle = angles;
	level.ladder[num].angles = (0,angles,0);
	
	if(getDvarInt("scr_devtool") && level.gametype != "ktk")
		return;

	level.ladder[num] thread monitorClimbs();
}

monitorClimbs()
{
	self endon("death");
	
	curAngle = 0;
	while(true)
	{
		self waittill("trigger", player);
		
		if(player isReviving())
			continue;
		
		if(player isInRCToy())
			continue;

		if(player isDog())
			continue;

		//if(player.origin[2] <= self.origin[2])
			//continue;
			
		if(!isDefined(player.climbing))
			player.climbing = false;
			
		if(player getStance() == "stand" && !player.climbing)
		{
			angles = player.angles[1] - self.angle;
				
			if(angles > 180)
				angles -= 360;
			else if(angles < -180)
				angles += 360;

			forward = abs(angles) <= 45;
			curAngle = abs(invertAngle(angles));			
			
			if(!forward && curAngle <= 45 && curAngle >= -45)
				player thread climbLadder(self, forward);
		}
	}
}

#using_animtree("multiplayer");
climbLadder(trigger, forward)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("joined_spectators");
	self endon("death");
	
	self setOrigin((trigger.origin[0], trigger.origin[1], self.origin[2]));
	
	self.climbing = true;
	jumpedToLadder = false;
	jumpLeftLadder = false;
	
	self.climbWeapon = self getCurrentWeapon();
	if(self.climbWeapon != "none")
	{
		self.climbClip = self getWeaponAmmoClip(self.climbWeapon);
		self.climbStock = self getWeaponAmmoStock(self.climbWeapon);
		self takeWeapon(self.climbWeapon);
	}

	self.tempWeapon = "ladderclimb_mp";
	self giveWeapon(self.tempWeapon);
	self switchToWeapon(self.tempWeapon);

	obj = spawn("script_model", self.origin);
	obj setModel("tag_origin");
	self thread DeleteObjOnPlayerDeath(obj);
	self linkTo(obj);
	
	length = .05;
	
	if(self jumpButtonPressed())
		jumpedToLadder = true;
	
	inAirTime = 0;
	oldyaw = self getPlayerAngles()[1];
	while(self isTouching(trigger))
	{
		targetPos = obj.origin;
		
		pitch = self getPlayerAngles()[0];
		yaw = self getPlayerAngles()[1];
		roll = self getPlayerAngles()[2];
		yawDif = yaw - oldyaw;
		
		if(yawDif > 45)
			self setPlayerAngles((pitch, oldyaw + 45, roll));
		else if(yawDif < -45)
			self setPlayerAngles((pitch, oldyaw - 45, roll));

		if(obj.origin[2] <= trigger.origin[2])
			break;
	
		if(!self jumpButtonPressed())
			jumpedToLadder = false;
	
		if(self jumpButtonPressed() && !jumpedToLadder)
		{
			targetPos = PlayerPhysicsTrace(self.origin, self.origin + (0,0,45) - AnglesToForward(self.angles)*60);
			targetDistance = Distance(self.origin, targetPos);
			inAirTime = (targetDistance/65*100)*(0.25/100);
			
			if(inAirTime <= 0.05)
				inAirTime = 0.05;
			
			obj moveTo(targetPos, inAirTime);
		
			jumpLeftLadder = true;
			break;
		}

		if(self forwardButtonPressed())
		{
			if(pitch > 0)
				targetPos = PlayerPhysicsTrace(self.origin, self.origin - (0,0,5));
			else
				targetPos = PlayerPhysicsTrace(self.origin, self.origin + (0,0,5));
		}
		
		if(self backButtonPressed())
		{
			if(pitch > 0)
				targetPos = PlayerPhysicsTrace(self.origin, self.origin + (0,0,5));
			else
				targetPos = PlayerPhysicsTrace(self.origin, self.origin - (0,0,5));
		}
		
		obj moveTo(targetPos, length);
		
		wait length;
	}

	if(self.origin[2] <= trigger.origin[2])
	{
		self setOrigin(self.origin + (0,0,CalcDif(self.origin[2],trigger.origin[2])+5));
	}
	else
	{
		if(!jumpLeftLadder)
		{
			targetPos = PlayerPhysicsTrace(self.origin, self.origin + (0,0,5) + AnglesToForward(self.angles)*10);
			obj moveTo(targetPos, 0.5);
			wait .05;
		}
	}

	self takeWeapon(self.tempWeapon);
	self.tempWeapon = undefined;

	if(self.climbWeapon != "none")
	{
		if(!isDefined(self.weaponCamo))
			self giveWeapon(self.climbWeapon);
		else
			self giveWeapon(self.climbWeapon, self.weaponCamo);
		
		self setWeaponAmmoClip(self.climbWeapon, self.climbClip);
		self setWeaponAmmoStock(self.climbWeapon, self.climbStock);
		self switchToWeapon(self.climbWeapon);

		self.climbWeapon  = undefined;
		self.climbClip  = undefined;
		self.climbStock  = undefined;
	}

	if(jumpLeftLadder)
		wait inAirTime;
	
	self unLink();
	obj delete();
	
	wait 1.5;
	
	self.climbing = false;
}

invertAngle(a)
{
	if(a > 0)
		return a - 180;
	else
		return a + 180;
}

DeleteObjOnPlayerDeath(obj)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("joined_spectators");
	
	self waittill("death");
	
	if(isDefined(obj))
		obj delete();
}