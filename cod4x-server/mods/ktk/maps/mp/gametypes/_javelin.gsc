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
#include common_scripts\utility;
#include maps\mp\gametypes\_misc;

init()
{
	precacheItem("javelin_mp");
	precacheModel("projectile_javelin_missile");
	precacheShader("javelin_hud_target");

	if(getDvar("scr_mod_javelin_ammo") == "") setDvar("scr_mod_javelin_ammo", 1);
	if(getDvarInt("scr_mod_javelin_ammo") == 0) setDvar("scr_mod_javelin_ammo", 1);

	if(getDvar("scr_mod_javelin_locktime") == "") setDvar("scr_mod_javelin_locktime", 0.6);
	if(getDvarFloat("scr_mod_javelin_locktime") < 0.1) setDvar("scr_mod_javelin_locktime", 0.1);
	
	level.JavelinMaxAmmo = getDvarInt("scr_mod_javelin_ammo");
	level.JavelinLockTime = getDvarFloat("scr_mod_javelin_locktime");
		
	level._effect["javelin_trail"] = LoadFX("smoke/smoke_geotrail_hellfire");
	level._effect["javelin_muzzleflash"] = LoadFX("muzzleflashes/at4_flash");
	level._effect["javelin_explosion"] = LoadFX("explosions/javelin_explosion");
}

onPlayerDeath()
{
	self notify("javelin_onDeath_waiter");
	self endon("javelin_onDeath_waiter");

	self endon("disconnect");
	self waittill("death");
	
	if(isDefined(self.javelinAmmoHud))
		self.javelinAmmoHud destroy();
	
	self thread RemoveJavelinTargetMarker();
}

WaitForJavelinPullout()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isAGuard())
		return;
	
	while(1)
	{
		oldWeapon = self getCurrentWeapon();
		self waittill("weapon_change", newWeapon);
		
		if(newWeapon == level.ktkWeapon["javelin"] && oldWeapon != level.ktkWeapon["javelin"])
		{		
			self thread JavelinAsCurrentWeapon();
			self thread JavelinAmmoCounter();
			self thread WaitTillAiming();
		}
		
		if(oldWeapon == level.ktkWeapon["javelin"])
		{
			self setWeaponAmmoClip(level.ktkWeapon["javelin"], 0);
			self setWeaponAmmoStock(level.ktkWeapon["javelin"], level.JavelinMaxAmmo - self.javelinsFired);
			self thread RemoveJavelinTargetMarker();
		}
	}
}

JavelinAsCurrentWeapon()
{
	self endon("disconnect");
	self endon("death");

	if((level.JavelinMaxAmmo - self.javelinsFired) > 0)
	{
		self setWeaponAmmoClip(level.ktkWeapon["javelin"], 1);
		self setWeaponAmmoStock(level.ktkWeapon["javelin"], level.JavelinMaxAmmo - self.javelinsFired -1);
	}
	
	while(self getCurrentWeapon() == level.ktkWeapon["javelin"])
		wait .05;

	self notify("end_javelin_ammo_watch");
			
	if(isDefined(self.javelinAmmoHud))
		self.javelinAmmoHud destroy();
		
	self setClientDvar("ammoCounterHide", 0);

}

JavelinAmmoCounter()
{
	self endon("disconnect");
	self endon("death");
	self endon("end_javelin_ammo_watch");
	
	self setClientDvar("ammoCounterHide", 1);
	
	self thread onPlayerDeath();
	
	if(isDefined(self.javelinAmmoHud))
		self.javelinAmmoHud destroy();
	
	self.javelinAmmoHud =  NewClientHudElem(self);
	self.javelinAmmoHud.font = "objective";
	self.javelinAmmoHud.alignX = "right";
	self.javelinAmmoHud.alignY = "bottom";
	self.javelinAmmoHud.horzAlign = "right";
	self.javelinAmmoHud.vertAlign = "bottom";
	self.javelinAmmoHud.x = -14;
	self.javelinAmmoHud.y = -14;
	self.javelinAmmoHud.archived = true;
	self.javelinAmmoHud.fontScale = 1.4;
	self.javelinAmmoHud.alpha = 1;
	self.javelinAmmoHud.glowColor = (1,0,0);
	self.javelinAmmoHud.glowAlpha = 1;
	self.javelinAmmoHud.foreground = true;
	self.javelinAmmoHud.hidewheninmenu = true;
	self.javelinAmmoHud setValue(level.JavelinMaxAmmo - self.javelinsFired);
	
	curFired = self.javelinsFired;
	while(isDefined(self.javelinAmmoHud))
	{
		if(curFired != self.javelinsFired)
		{
			self.javelinAmmoHud setValue(level.JavelinMaxAmmo - self.javelinsFired);
			self setWeaponAmmoStock(level.ktkWeapon["javelin"], level.JavelinMaxAmmo - self.javelinsFired -1);
		}
		
		wait .05;
	}
}

WaitTillAiming()
{
	self endon("disconnect");
	self endon("death");
	self endon("weapon_change");
	
	oldAds = self playerADS();
	isUsingJavelin = false;
	
	while(1)
	{
		wait .05;

		//ADSButtonPressed - entering the view
		if(self playerADS() > oldAds)
		{
			self notify("javelin_entering");
			
			isUsingJavelin = false;
		}
		//Completely in ADS
		else if(self playerADS() == 1)
		{
			self notify("javelin_aiming");
			
			if(!isUsingJavelin)
			{
				isUsingJavelin = true;
				self thread SearchValidTarget();
			}
		}
		//ADSButtonPressed - leaving the view
		else if(self playerADS() < oldAds)
		{
			wait .05; //else it does not shoot when the player is not moving
			self notify("javelin_leaving");
		
			isUsingJavelin = false;
			self thread RemoveJavelinTargetMarker();
		}
		
		oldAds = self playerADS();
	}
}

SearchValidTarget()
{
	self endon("disconnect");
	self endon("death");
	self endon("weapon_change");
	self endon("javelin_leaving");
	
	JavelinTargetGoneMessage = true;
	JavelinTargetIsAc130 = false;
	level.JavelinLockTime = int(level.JavelinLockTime*10)/10;
	
	while(1)
	{
		time = 0;
		raised = true;
		trace = BulletTrace(self GetEye(), self GetEye() + AnglesToForward(self getPlayerAngles())*99999999, false, self);
	
		if(self.javelinsFired >= level.JavelinMaxAmmo)
			break;
	
		wait .1;
		
		if(TargetIsAc130(self))
			JavelinTargetIsAc130 = true;
		else
			JavelinTargetIsAc130 = false;
		
		if((isDefined(trace["entity"]) && trace["entity"] isPossibleTarget(self)) || JavelinTargetIsAc130)
		{
			JavelinTargetGoneMessage = true;
		
			if(JavelinTargetIsAc130)
				target = level.ac130Trigger;
			else
				target = trace["entity"];
		
			//This is the vehicle the player is aiming at
			while(isValidTarget(target))
			{
				wait .1;
				time += .1;
					
				if(raised)
				{
					raised = false;
					
					if(JavelinTargetIsAc130)
						self thread JavelinTargetMarker(level.ac130Player);
					else
						self thread JavelinTargetMarker(target);
				}
				
				if(time == int(time/level.JavelinLockTime) && time < (level.JavelinLockTime * 3))
					self playLocalSound("javelin_clu_aquiring_lock");
					
				if(time == (level.JavelinLockTime * 3))
				{
					self playLocalSound("javelin_clu_lock");
					
					if(self.javelinsFired < level.JavelinMaxAmmo)
					{
						self setWeaponAmmoClip(level.ktkWeapon["javelin"], 1);
						self thread WaitTillFiringJavelin(target);
					}
				}
			}
			
			if(JavelinTargetGoneMessage)
			{
				JavelinTargetGoneMessage = false;
				scr_iPrintLnBold("JAVELIN_VEHICLE_OUT_OF_RANGE", self);
			}
			
			self setWeaponAmmoClip(level.ktkWeapon["javelin"], 1);
			self setWeaponAmmoStock(level.ktkWeapon["javelin"], level.JavelinMaxAmmo - self.javelinsFired -1);
			self thread RemoveJavelinTargetMarker();
		}
	}
	
	self iPrintLnBold(&"WEAPON_NO_AMMO");
}

isPossibleTarget(player)
{
	if(isDefined(level.uav) && self == level.uav)
		return true;
		
	if(isDefined(level.chopper) && self == level.chopper)
		return true;
		
	if(isDefined(level.ah6) && self == level.ah6)
		return true;
		
	if(isDefined(level.CpChopper) && self == level.CpChopper)
		return true;
		
	if(isDefined(level.helicopter) && self == level.helicopter)
		return true;

	if(isDefined(self.targetname))
	{
		if(isSubStr(self.targetname, "vehicle") || isSubStr(self.targetname, "destructible"))
		{
			if(isDefined(self.model) && !isSubStr(self.model, "_destroyed"))
				return true;
		}
	}
	
	return false;
}

TargetIsAc130(player)
{
	//sadly we can not trace triggers - so we do a distance check to the (invisible) player
	if(isDefined(level.ac130Trigger))
	{
		curDist = Distance(player.origin, level.ac130Trigger.origin);
		aimPos = PhysicsTrace(player GetEye(), player GetEye() + AnglesToForward(player getPlayerAngles())*curDist);
		
		if(isDefined(aimPos) && Distance(aimPos, level.ac130Trigger.origin) <= 400)
			return true;
	}
	
	//with the new plane model the ac130 can be found - yay :Distance
	if(isDefined(level.ac130PlaneModel) && self == level.ac130PlaneModel)
		return true;
	
	return false;
}

isValidTarget(target)
{
	self endon("disconnect");

	if(!isDefined(target))
		return false;
	
	//Gerade = Punkt1 + x * (Punkt2-Punkt1)
	//Gerade vom Spieler zum Schaupunkt:	g = self.origin + x * ((self.origin + AnglesToForward(self getPlayerAngles())*100) - self.origin)
	//Gerade vom Spieler zum Fahrzeug: 		h = self.origin + x * (target.origin - self.origin)
	//-----
	//Richtungsvektor aus g: ((self.origin + AnglesToForward(self getPlayerAngles())*100) - self.origin)
	//Richtungsvektor aus h: (target.origin - self.origin)
	//Richtungsvektoren multipliziert: (Richtungsvektor aus g[0]*Richtungsvektor aus h[0]) + (Richtungsvektor aus g[1]*Richtungsvektor aus h[1]) + (Richtungsvektor aus g[2]*Richtungsvektor aus h[2])
	//Betrag von Richtungsvektor aus g:	sqrt(sqr(Richtungsvektor aus g[0]) + sqr(Richtungsvektor aus g[1]) +sqr(Richtungsvektor aus g[2]))
	//Betrag von Richtungsvektor aus h:	sqrt(sqr(Richtungsvektor aus h[0]) + sqr(Richtungsvektor aus h[1]) +sqr(Richtungsvektor aus h[2]))
	//-----
	//Schnittwinkel berechnen:
	//Schnittwinkel = aCos(Richtungsvektoren multipliziert / (Betrag von Richtungsvektor aus g * Betrag von Richtungsvektor aus h))
	
	calc1 = ((self.origin + AnglesToForward(self getPlayerAngles())*100) - self.origin);
	calc2 = (target.origin - self.origin);
	calc3 = (calc1[0] * calc2[0] + calc1[1] * calc2[1] + calc1[2] * calc2[2]);
	calc4 = sqrt(sqr(calc1[0]) + sqr(calc1[1]) +sqr(calc1[2]));
	calc5 = sqrt(sqr(calc2[0]) + sqr(calc2[1]) +sqr(calc2[2]));
	calc6 = acos(calc3 / (calc4 * calc5));
	
	if(calc6 > 10)
		return false;
		
	if(self SightConeTrace(target.origin, target) < 0.5)
		return false;
		
	return true;
}

WaitTillFiringJavelin(target)
{
	self endon("disconnect");
	self endon("death");
	self endon("weapon_change");
	self endon("javelin_leaving");
	
	while(!self AttackbuttonPressed())
		wait .05;

	if(isValidTarget(target))
	{
		self.javelinsFired++;
		self thread JavelinFired(target);
	}
}

JavelinFired(target)
{
	missile = spawn("script_model", (0,0,0));
	missile.origin = self.origin + (0,0,16) + vectorscale(anglesToForward(self.angles), 50);
	missile.angles = VectorToAngles((missile.origin + (0,0,100)) - missile.origin);
	missile.speed = 1000;
	missile.owner = self;
	missile.targetEntity = target;
	
	playFX(level._effect["javelin_muzzleflash"], missile.owner getTagOrigin("tag_weapon_right"));
	missile playSound("javelin_fire");
	
	missile SetModel("projectile_javelin_missile");
	missile thread JavelinMissileThink();
}

/* old - not compatible when the killcam follows the javelin missile
JavelinMissileThink()
{
	self endon("death");

	flyingUp = true;
	skyDist = 4500;
	upTime = skyDist/self.speed;
	
	PlayFxOnTag(level._effect["javelin_trail"], self, "tag_fx");
	
	while(isDefined(self.targetEntity))
	{
		if(flyingUp)
		{
			flyingUp = false;
			nextPos = self.origin + (0,0,skyDist);
	
			if(!isCleanFlypath(nextpos))
				break;
		
			self moveTo(nextpos, upTime);
			wait upTime;	
		}
		
		forward = vectorNormalize(anglesToForward(self.angles));
		nextPos = self.origin + forward * (self.speed/10);
		flyTime = (Distance(self.origin, nextpos)/self.speed);

		if(!isDefined(self.targetEntity))
			break;
		else
		{
			if(isDefined(level.ac130Trigger) && self.targetEntity == level.ac130Trigger)
			{
				if(self isTouching(self.targetEntity))
					break;

				if(Distance(self.origin, self.targetEntity.origin) <= 200)
					break;
			}
		}
		
		if(!isCleanFlypath(nextpos))
			break;
		
		self moveTo(nextpos, flyTime);
		self rotateTo(VectorToAngles(self.targetEntity.origin - self.origin), flyTime);
			
		wait flyTime;
	}

	self thread JavelinExplode(self.origin);
}

isCleanFlypath(nextpos)
{
	self endon("death");

	trace = BulletTrace(self.origin, nextPos, false, self);
	if(trace["fraction"] != 1 && trace["surfacetype"] != "default" && !isSubStr(trace["surfacetype"], "sky_"))
		return false;
		
	return true;
}*/


JavelinMissileThink()
{
	self endon("death");

	nextPos = self.origin + (0,0,4500);
	colPos = getCollisionPosition(nextpos);
	flyTime = Distance(self.origin, colPos) / self.speed;

	PlayFxOnTag(level._effect["javelin_trail"], self, "tag_fx");

	self moveTo(colPos, flyTime);
	wait flyTime;	

	if(colPos == nextPos)
	{
		if(isDefined(self.targetEntity) && isDefined(self.targetEntity.origin))
		{
			nextPos = self.targetEntity.origin;
			colPos = getCollisionPosition(nextpos);
			flyTime = Distance(self.origin, colPos) / self.speed;

			self moveTo(colPos, flyTime);
			wait flyTime;
		}
	}

	self thread JavelinExplode();
}

getCollisionPosition(nextpos)
{
	self endon("death");

	trace = BulletTrace(self.origin, nextPos, false, self);
	if(trace["fraction"] != 1 && trace["surfacetype"] != "default" && !isSubStr(trace["surfacetype"], "sky_"))
		return trace["position"];

	return nextpos;
}

JavelinExplode()
{
	location = self.origin;

	if(!isDefined(self.owner))
		self RadiusDamage(location, 450, 4000, 3000);
	else
	{
		if(self.owner getKtkStat(2377) > 0)
			self RadiusDamage(self.origin, 500, 4000, 3000, self.owner, "MOD_EXPLOSIVE", level.ktkWeapon["javelin"]);
		else
			self RadiusDamage(self.origin, 450, 4000, 3000, self.owner, "MOD_EXPLOSIVE", level.ktkWeapon["javelin"]);
	}

	Earthquake(1.4, 1, location, 2000);
	PhysicsExplosionSphere(location, 400, 200, 3);
	PlayRumbleOnPosition("artillery_rumble", location);
	PlayFx(level._effect["javelin_explosion"], location, (location + (0,0,15 + randomint(120))) - location);
	self playSound("exp_javelin_armor_destroy");

	//wait a bit to make sure the missile is used in killcam
	if(isDefined(self))
	{
		self hide();
		
		wait 10;

		if(isDefined(self))
			self delete();
	}
}

JavelinTargetMarker(target)
{
	self setClientDvars("waypointiconheight", 100,
						"waypointiconwidth", 100);
	
	if(isDefined(self.JavelinTargetMarker))
		self.JavelinTargetMarker destroy();
	
	if(!isDefined(target))
		return;
	
	self.JavelinTargetMarker = newClientHudElem(self);
	
	switch(target.model)
	{
		case "vehicle_cobra_helicopter_fly":
		case "vehicle_mi24p_hind_desert": 
					self.JavelinTargetMarker.x = target.origin[0];
					self.JavelinTargetMarker.y = target.origin[1];
					self.JavelinTargetMarker.z = target.origin[2];
					break;
		
		default:	self.JavelinTargetMarker.x = target.origin[0];
					self.JavelinTargetMarker.y = target.origin[1];
					self.JavelinTargetMarker.z = target.origin[2];
					break;
	}	

	self.JavelinTargetMarker.baseAlpha = 1;
	self.JavelinTargetMarker.isFlashing = false;
	self.JavelinTargetMarker.isShown = true;
	self.JavelinTargetMarker setShader("javelin_hud_target", 100, 100);
	self.JavelinTargetMarker setWayPoint(true, "javelin_hud_target");
	self.JavelinTargetMarker setTargetEnt(target);
}

RemoveJavelinTargetMarker()
{
	self endon("disconnect");
	
	self setClientDvars("waypointiconheight", 36,
						"waypointiconwidth", 36);
	
	if(isDefined(self.JavelinTargetMarker))
		self.JavelinTargetMarker destroy();
}