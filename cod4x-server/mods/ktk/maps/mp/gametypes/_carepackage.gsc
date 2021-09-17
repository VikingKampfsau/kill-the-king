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
	precacheItem("marker_mp");
	
	precacheModel("com_plasticcase_green_big");
	
	precacheShader("hud_grenadeicon");
	precacheShader("guards_logo");
	precacheShader("hud_mw2_magnum");
	precacheShader("hud_icon_c4");
	precacheShader("hud_icon_ac130");
	precacheShader("hud_icon_carepackage");
	precacheShader("hud_icon_juggernaut");
	precacheShader("hud_icon_nuke");
	precacheShader("hud_icon_predator");
	precacheShader("hud_icon_javelin");
	precacheShader("hud_icon_rccar");
	precacheShader("hud_icon_sentrygun");
	precacheShader("compass_objpoint_airstrike");
	precacheShader("compass_objpoint_helicopter");
	precacheShader("compass_objpoint_flak");
	precacheShader("killiconsuicide");
	
	level.effect["decoy"] = loadFx("cs/decoy_explosion");
	level._effect["cpsmoke"] = loadfx("red_smoke");
	level._effect["cpexplosion"] = LoadFX( "explosions/aa_explosion" );

	if(getDvar("scr_hardpoint_carepackage_killtype") == "") setDvar("scr_hardpoint_carepackage_killtype", 0);
	if(getDvar("scr_hardpoint_carepackage_stealtype") == "") setDvar("scr_hardpoint_carepackage_stealtype", 0);
	if(getDvar("scr_hardpoint_carepackage_ownerpick") == "") setDvar("scr_hardpoint_carepackage_ownerpick", 1);
	if(getDvar("scr_hardpoint_carepackage_playerpick") == "") setDvar("scr_hardpoint_carepackage_playerpick", 3);
	if(getDvar("scr_hardpoint_juggernaut_healthAssassins") == "") setDvar("scr_hardpoint_juggernaut_healthAssassins", 500);
	if(getDvar("scr_hardpoint_juggernaut_healthGuards") == "") setDvar("scr_hardpoint_juggernaut_healthGuards", 300);
	
	level.cp_content["axis"] = [];
	level.cp_content["allies"] = [];
	level.crateOwnerUseTime = getDvarFloat("scr_hardpoint_carepackage_ownerpick");
	level.crateNonOwnerUseTime = getDvarFloat("scr_hardpoint_carepackage_playerpick");
	
	level.totalcps = 0;
	
	if(isDefined(game["switchedsides"]) && game["switchedsides"])
		wait 1;
	
	AddToPackage(game["defenders"], level.ktkWeapon["rccar"], 13);
	AddToPackage(game["defenders"], "airstrike_mp", 12);
	AddToPackage(game["defenders"], level.ktkWeapon["mortars"], 12);
	AddToPackage(game["defenders"], level.ktkWeapon["predator"], 11);
	AddToPackage(game["defenders"], "marker_mp", 11);
	AddToPackage(game["defenders"], "tripwire", 9);
	AddToPackage(game["defenders"], level.ktkWeapon["sentrygun"], 8);
	AddToPackage(game["defenders"], "juggernaut", 8);
	AddToPackage(game["defenders"], "helicopter_mp", 8);
	AddToPackage(game["defenders"], level.ktkWeapon["ac130"], 7);
	AddToPackage(game["defenders"], level.ktkWeapon["nuke"], 1);
	
	AddToPackage(game["attackers"], level.ktkWeapon["magnum"], 30);
	AddToPackage(game["attackers"], level.ktkWeapon["crossbowExp"], 20);
	AddToPackage(game["attackers"], "javelin", 15);
	AddToPackage(game["attackers"], "juggernaut", 13);
	AddToPackage(game["attackers"], "marker_mp", 11);
	AddToPackage(game["attackers"], "fakeguard", 10);
	AddToPackage(game["attackers"], level.ktkWeapon["nuke"], 1);
}

AddToPackage(team, weapon, chance)
{
	weaponName = getHardpointNameFromWeapon(weapon);
	
	if(weaponName != "" && !maps\mp\gametypes\_awards::isEnabledOnMap(weaponName, "", false))
		return;

	teamRole = team;	
	if(teamRole == game["defenders"])
		teamRole = "guards";
	else
		teamRole = "assassins";
	
	if(weaponName == "")
	{
		if(weapon == level.ktkWeapon["crossbowExp"])
			weaponName = "crossbowExp";
		else if(weapon == level.ktkWeapon["magnum"])
			weaponName = "magnum";
		else
			weaponName = weapon;
	}
	else
	{
		if(weaponName == "cp")
			weaponName = "decoy";
	}
	
	if(getSubStr(weaponName, weaponName.size-3, weaponName.size) == "_mp")
	{
		weaponName = getSubStr(weaponName, 0, weaponName.size-3);
	
		if(getDvarInt("scr_hardpoint_carepackage_" + teamRole + "_" + weaponName) == 0)
			setDvar("scr_hardpoint_carepackage_" + teamRole + "_" + weaponName, chance);
	}
	else
	{
		if(getDvarInt("scr_hardpoint_carepackage_" + teamRole + "_" + weaponName) == 0)
			setDvar("scr_hardpoint_carepackage_" + teamRole + "_" + weaponName, chance);
	}

	struct = spawnstruct();
	struct.team = team;
	struct.weapon = weapon;
	struct.chance = getDvarInt("scr_hardpoint_carepackage_" + teamRole + "_" + weaponName);
	
	level.cp_content[team][level.cp_content[team].size] = struct;
}

WaitForSupplyCall(lastWeapon)
{
	self notify("double_cp");
	self endon("double_cp");
	self endon("disconnect");
	self endon("death");

	if(!isDefined(self.pers["carepackagetype"]))
		self.pers["carepackagetype"] = "carepackage";
	
	while(1)
	{
		self waittill("grenade_fire", grenade, weapon);
			
		if(weapon == "marker_mp")
		{
			if(game["customEvent"] == "traitors")
			{
				grenade thread maps\mp\gametypes\_decoy::spawnDecoy(self);
				continue;
			}
		
			//just in case we have to give the hardpoint back
			self ResetHardpointSlot(self GetSlotForHardpoint(weapon));
		
			if(!VehicleCanSpawn())
			{
				scr_iPrintLnBold("CAREPACKAGE_NO_HELI_AVAILABLE", self);
				self SetHardpointToSlot("weapon", weapon, true);
				self GiveMaxAmmo(weapon);
				continue;
			}
			
			if(!isDefined(lastWeapon))
			{
				//try to find a primary weapon
				self GetInventory();
				self SwitchToPreviousWeapon();
			}
			else
			{
				if(lastWeapon != "none")
					self switchToWeapon(lastWeapon);
			}

			if(!isDefined(grenade))
				scr_iPrintlnBold("CP_NOTAVAILABLE", self);
			else
			{
				grenade WaitTillNotMoving();
				
				if(isDefined(grenade))
				{
					grenade PlaySound("smokegrenade_explode_default");
					PlayFx(level._effect["cpsmoke"], grenade.origin);

					self thread SpawnSupplyHeli(grenade.origin);
					break;
				}
			}
			
			self SetHardpointToSlot("weapon", weapon, true);
			self GiveMaxAmmo(weapon);
		}
	}
}

SpawnSupplyHeli(position)
{
	self endon("death");
	self endon("disconnect");

	height = GetSkyHeight();
	Flypath = GetFlyPath(position, height);
	
	if(!isDefined(Flypath) || !isDefined(Flypath[0]) || !isDefined(Flypath[1]))
		return;
	
	level.CpChopper = spawnHelicopter(self, Flypath[0], vectortoangles(vectornormalize((position[0],position[1],height) - Flypath[0])), "blackhawk_mp", "vehicle_blackhawk");
	level.CpChopper playLoopSound("mp_cobra_helicopter");
	level.CpChopper SetDamageStage(3);
	level.CpChopper setCanDamage(true);
	
	level.CpChopper thread check_damage();
	level.CpChopper thread CallSupplyHeli((position[0],position[1],height), Flypath[1], self);
	level.CpChopper thread HeliCloseNades();
}

GetFlyPath(position, height)
{
	radius = 99999999999;
	start = undefined;
	end = undefined;
	path = [];
	random = randomInt(360);
	
	for(i=random;i<(random+360);i++)
	{
		start = BulletTrace((position[0],position[1],height), (position[0],position[1],height) + AnglesToForward((0,i,0))*radius, false, undefined);
		end = BulletTrace((position[0],position[1],height), (position[0],position[1],height) - AnglesToForward((0,i,0))*radius, false, undefined);

		if(BulletTracePassed(start["position"], end["position"], false, undefined))
			break;
	}
	
	if(isDefined(start["position"]) && isDefined(end["position"]))
	{
		path[0] = start["position"];
		path[1] = end["position"];
		return path;
	}
}

check_damage()
{
	self.crashing = false;
	self.health = CalculateHeliHealth();
	
	while(1)
	{
		self waittill("damage", amount, attacker);

		if(!isDefined(self) || self.crashing)
			break;
		
		if((isplayer(attacker) && attacker isInSameTeamAs(level.king)) || attacker isKing())
			continue;
		
		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback( false );
		
		self.health -= amount;
		
		if(self.health <= 0)
		{
			attacker maps\mp\gametypes\_rank::giveRankXP("kill", 400);
			self thread CpChopperCrash();
			break;
		}
	}
}

CpChopperCrash()
{
	self endon("death");
	
	self.crashing = true;
	self setCanDamage(false);
	
	self.pathclear = true;
	self setvehgoalpos(self.origin,0);
	self StopLoopSound();

	self thread heli_spin();
	self playSound(level.heli_sound[level.king.team]["hitsecondary"]);
	
	x = 0;
	while(self.pathclear)
	{
		wait 0.5;
		x += 0.5;
		if(x>= 10)
		{
			self.pathclear = false;
			break;
		}
	}

	forward = ( self.origin + ( 0, 0, 100 ) ) - self.origin;
	playfx ( level.chopper_fx["explode"]["death"], self.origin, forward );
	self playSound( level.heli_sound[level.king.team]["crash"] );
	RadiusDamage( self.origin, 600, 1000, 5, level.king, "MOD_EXPLOSIVE", "cobra_20mm_mp");
	
	if(isDefined(self))
		self delete();
}

heli_spin()
{
	self endon("death");

	playfxontag( level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt" );
	self playSound ( level.heli_sound[level.king.team]["hit"] );
	self thread spinSoundShortly();
	self thread trail_fx( level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke" );

	self setyawspeed( 180,180,180 );

	for(i=0;i<5;i++)
	{
		if(!self.pathclear) break;
		self setvehgoalpos((self.origin[0] + RandomInt(300),self.origin[1] + RandomInt(300),self.origin[2] - RandomIntRange(100,200)),0);
		self settargetyaw( self.angles[1]+(180*0.9) );
		wait 2;
	}
	
	self thread check_colliding();
}

check_colliding()
{
	self endon("death");
	
	while(1)
	{
		wait .1;
		if(!bullettracepassed( self.origin,  self.origin - (0,0,150), false, self ) || !bullettracepassed( self.origin,  self.origin + (0,0,25), false, self ) || !bullettracepassed( self.origin,  self.origin + (160,0,0), false, self ) || !bullettracepassed( self.origin,  self.origin - (328,0,0), false, self )) 
		{
			self.pathclear = false;
			break;
		}
	}
}

spinSoundShortly()
{
	self endon("death");
	
	wait .25;
	self stopLoopSound();
	wait .05;
	self playLoopSound( level.heli_sound[level.king.team]["spinloop"] );
	wait .05;
	self playSound( level.heli_sound[level.king.team]["spinstart"] );
}

trail_fx( trail_fx, trail_tag, stop_notify )
{
	// only one instance allowed
	self notify( stop_notify );
	self endon( stop_notify );
	self endon( "death" );
		
	for ( ;; )
	{
		playfxontag( trail_fx, self, trail_tag );
		wait( 0.05 );
	}
}

CallSupplyHeli(Start, Target, owner)
{
	self endon("death");
	
	self clearTargetYaw();
	self clearGoalYaw();
	self setspeed(90, 40);	
	self setyawspeed(75, 45, 45);
	self setmaxpitchroll(15, 15);
	self setneargoalnotifydist(200);
	self setturningability(0.9);
	self setvehgoalpos(Start, 0);

	self waittillmatch("goal");
	
	self setvehgoalpos(Target, 0);
	self thread DropCarePackage(owner);
	
	self waittillmatch("goal");
	
	self stopLoopSound();
	self hide();
	wait .1;
	self delete();
}

DropCarePackage(owner)
{
	level.totalcps++;

	carepackage = spawn("script_model", (self.origin[0], self.origin[1], self.origin[2]-130));
	carepackage SetModel("com_plasticcase_green_big");
	
	carepackage.angles = (0, randomInt(360), 0);
	carepackage.number = level.totalcps;
	
	if(isDefined(owner) && isDefined(owner.pers["carepackagetype"]))
		carepackage.type = owner.pers["carepackagetype"];
	else
		carepackage.type = "carepackage";

	ground = BulletTrace(carepackage.origin, carepackage.origin-(0,0,100000), false, carepackage);
	
	carepackage.blocker = [];
	carepackage.blocker[0] = spawn("trigger_radius", carepackage.origin, 0, 32, 35);
	carepackage.blocker[1] = spawn("trigger_radius", carepackage.origin + vectorscale(anglesToRight( self.angles ), 32), 0, 32, 35);
	carepackage.blocker[2] = spawn("trigger_radius", carepackage.origin + vectorscale(anglesToRight( self.angles ), -32), 0, 32, 35);
	
	for(i=0;i<carepackage.blocker.size;i++)
	{
		carepackage.blocker[i] thread ForceOrigin(undefined, carepackage);
		carepackage.blocker[i] thread DontBlockBots();
	}

	carepackage.deathtrigger = spawn("trigger_radius", carepackage.origin, 0, 50, 1);
	carepackage.deathtrigger thread ForceOrigin(undefined, carepackage);
	carepackage.deathtrigger thread MakeDeadly(owner, carepackage);

	carepackage MoveTo(ground["position"], 0.1 + abs(Distance(ground["position"], carepackage.origin)/800));
	carepackage waittill("movedone");

	carepackage.deathtrigger delete();
	
	for(i=0;i<carepackage.blocker.size;i++)
		carepackage.blocker[i] setContents(1);
	
	carepackage Bounce(ground["surfacetype"]);
	
	carepackage.trigger = spawn("trigger_radius", carepackage.origin - (0,0,40), 0, 100, 80);
	
	if(carepackage.type == "carepackage")
	{
		carepackage.content = [];
		carepackage.content[game["defenders"]] = CalculateContent(game["defenders"]);
		
		if(game["customEvent"] == "kingvsking")
			carepackage.content[game["attackers"]] = CalculateContent(game["defenders"]);
		else
			carepackage.content[game["attackers"]] = CalculateContent(game["attackers"]);
		
		if(isDefined(owner))
			carepackage thread crateUseThinkOwner(owner);
	}

	carepackage thread ContentDescription(owner);
	
	if(getDvarInt("scr_hardpoint_carepackage_stealtype") > 0 || carepackage.type == "trappackage")
		carepackage thread crateUseThink(owner);
}

ForceOrigin(prevorigin, entity)
{
	self endon("death");

	while(1)
	{
		if(isDefined(prevorigin) && self.origin != prevorigin)
			self.origin = prevorigin;
		else if(isDefined(entity) && self.origin != entity.origin)
			self.origin = entity.origin;
	wait .05;
	}
}

Bounce(type)
{
	self endon("death");
	
	BounceTargets[0][0] = 32;
	BounceTargets[0][1] = 0.4;
	BounceTargets[0][2] = 0;
	BounceTargets[0][3] = 0.4;

	BounceTargets[1][0] = -32;
	BounceTargets[1][1] = 0.425;
	BounceTargets[1][2] = 0.425;
	BounceTargets[1][3] = 0;

	BounceTargets[2][0] = 0.16;
	BounceTargets[2][1] = 0.25;
	BounceTargets[2][2] = 0;
	BounceTargets[2][3] = 0.25;

	BounceTargets[3][0] = -0.16;
	BounceTargets[3][1] = 0.275;
	BounceTargets[3][2] = 0.275;
	BounceTargets[3][3] = 0;
	
	for(i=0;i<BounceTargets.size;i++)
	{
		self PlaySound("grenade_bounce_" + type);
		self MoveZ(BounceTargets[i][0], BounceTargets[i][1], BounceTargets[i][2], BounceTargets[i][3]);
		wait BounceTargets[i][1];
	}
}

DontBlockBots()
{
	self endon("death");

	while(1)
	{
		self waittill("trigger", player);
		
		if(player isABot())
			player thread maps\mp\gametypes\_bots::botJump();
	}
}

MakeDeadly(owner, eInflictor)
{
	self endon("death");

	while(1)
	{
		self waittill("trigger", player);
		
		if(player isInRCCar())
		{
			player.rc_car thread maps\mp\gametypes\_rccar::Explode(player);
			continue;
		}
		
		if(player isInRCHelicopter())
		{
			player.rc_heli thread maps\mp\gametypes\_rchelicopter::Explode();
			continue;
		}
		
		if(getDvarInt("scr_hardpoint_carepackage_killtype") == 0 || (getDvarInt("scr_hardpoint_carepackage_killtype") == 1 && player isInSameTeamAs(owner)))
		{
			player SetOrigin(player.origin + (0,0,40));
			continue;
		}
		
		if((getDvarInt("scr_hardpoint_carepackage_killtype") == 1 && player.pers["team"] != owner.pers["team"]) || getDvarInt("scr_hardpoint_carepackage_killtype") == 2)
			player ktkFinishPlayerDamage(eInflictor, owner, player.health, 0, "MOD_SUICIDE", "none", self.origin, VectorToAngles(player.origin - self.origin), "none", 0);
	}
}

CalculateContent(team)
{
	random = RandomInt(100);
	parent = 0;
	
	for(i=0;i<level.cp_content[team].size;i++)
	{
		next = parent + level.cp_content[team][i].chance;
	
		if(random >= parent && random < next)
		{
			if(level.cp_content[team][i].weapon == "helicopter_mp" && !isDefined(level.heli_paths))
				break;

			return level.cp_content[team][i].weapon;
		}
		
		parent = next;
	}
	
	return level.cp_content[team][0].weapon;
}

ContentDescription(owner)
{
	for(i=0;i<level.players.size;i++)
		level.players[i] thread ContentHUD(self, owner);

	while(1)
	{
		self.trigger waittill("trigger", player);
		
		if(!isDefined(self))
			break;
		
		if(!isPlayer(player))
			continue;

		if(isAlive(player) && isDefined(owner))
		{
			if(self.type != "trappackage")
			{
				if(getDvarInt("scr_hardpoint_carepackage_stealtype") < 3 && player != owner)
				{
					if(getDvarInt("scr_hardpoint_carepackage_stealtype") == 1 && player.pers["team"] != owner.pers["team"])
					{
						if(isDefined(player.lowerMessage))
						{
							player.lowerMessage.label = player GetLocalizedString("CP_CANT_STEAL");
							player.lowerMessage.alpha = 1;
							player.lowerMessage FadeOverTime(0.05);
							player.lowerMessage.alpha = 0;
						}
						continue;
					}
					
					if(getDvarInt("scr_hardpoint_carepackage_stealtype") == 2 && player.pers["team"] == owner.pers["team"])
					{
						if(isDefined(player.lowerMessage))
						{
							player.lowerMessage.label = player GetLocalizedString("CP_CANT_STEAL");
							player.lowerMessage.alpha = 1;
							player.lowerMessage FadeOverTime(0.05);
							player.lowerMessage.alpha = 0;
						}
						continue;
					}
				}
				else
				{
					if(isDefined(player.lowerMessage))
					{
						player.lowerMessage.label = player GetLocalizedString("CP_PRESS_USE");
						player.lowerMessage.alpha = 1;
						player.lowerMessage FadeOverTime(0.05);
						player.lowerMessage.alpha = 0;
					}
				}
			}
			else
			{
				if(player isAGuard() || player == owner)
				{
					if(isDefined(player.lowerMessage))
					{
						player.lowerMessage.label = player GetLocalizedString("CP_IS_A_TRAP");
						player.lowerMessage.alpha = 1;
						player.lowerMessage FadeOverTime(0.05);
						player.lowerMessage.alpha = 0;
					}
				}
				else
				{
					if(isDefined(player.lowerMessage))
					{
						player.lowerMessage.label = player GetLocalizedString("CP_PRESS_USE");
						player.lowerMessage.alpha = 1;
						player.lowerMessage FadeOverTime(0.05);
						player.lowerMessage.alpha = 0;
					}
				}
			}
		}
	}
}

ContentHud(carepackage, owner)
{
	self endon("disconnect");

	team = self.pers["team"];
	icon = self GetIconForContent(carepackage, owner);
	
	if(!isDefined(self.hud_cpContent))
		self.hud_cpContent = [];
	
	self.hud_cpContent[carepackage.number] = newClientHudElem(self);
	self.hud_cpContent[carepackage.number].x = carepackage.origin[0];
	self.hud_cpContent[carepackage.number].y = carepackage.origin[1];
	self.hud_cpContent[carepackage.number].z = carepackage.origin[2]+55;
	self.hud_cpContent[carepackage.number].alpha = .75;
	self.hud_cpContent[carepackage.number].archived = true;
	self.hud_cpContent[carepackage.number] setShader(icon, 25, 25);
	self.hud_cpContent[carepackage.number] setWaypoint(true, icon);

	while(1)
	{
		self waittill("spawned_player");
	
		if(!isDefined(carepackage))
			break;
	
		if(self.pers["team"] != team)
		{
			team = self.pers["team"];
			icon = self GetIconForContent(carepackage, owner);
			
			if(isDefined(self.hud_cpContent[carepackage.number]))
			{
				self.hud_cpContent[carepackage.number] setShader(icon, 25, 25);
				self.hud_cpContent[carepackage.number] setWaypoint(true, icon);
			}
		}
	}
}

GetIconForContent(carepackage, owner)
{
	self endon("disconnect");

	if(isDefined(carepackage.type) && carepackage.type == "trappackage")
	{
		if(self isAGuard() || self == owner)
			return "killiconsuicide";
		else
		{
			icon = self GetRandomIcon();
			return icon;
		}
	}
	
	if(self isASpectator())
		return "";

	return getCPIconFromWeapon(carepackage.content[self.pers["team"]]);
}

GetRandomIcon()
{
	self endon("disconnect");
	
	switch(randomInt(5))
	{
		case 0: return "hud_mw2_magnum";
		case 1: return "hud_icon_juggernaut";
		case 2: return "guards_logo";
		case 3: return "hud_icon_c4";
		case 4: return "hud_icon_nuke";
		default: return "hud_icon_nuke";
	}
}

crateUseThink(owner)
{
	while(isDefined(self))
	{
		self.trigger waittill("trigger", player);
		
		if(!isAlive(player))
			continue;
			
		if(!player isOnGround())
			continue;
		
		if(player isInRCToy())
			continue;
		
		if(player isReviving())
			continue;
			
		if(player isDog())
			continue;
		
		if(isDefined(owner) && owner == player)
			continue;
		
		if(isDefined(owner) && self.type == "carepackage")
		{
			if(isDefined(owner) && getDvarInt("scr_hardpoint_carepackage_stealtype") < 3)
			{
				if(getDvarInt("scr_hardpoint_carepackage_stealtype") == 1 && !player isInSameTeamAs(owner))
					continue;
				
				if(getDvarInt("scr_hardpoint_carepackage_stealtype") == 2 && player isInSameTeamAs(owner))
					continue;
			}

			useEnt = self spawnUseEnt();
			result = useEnt useHoldThink(player, level.crateNonOwnerUseTime);
			
			if(isDefined(useEnt))
				useEnt Delete();

			if(result)
			{
				player GivePackageContent(self);
				break;
			}
		}
		else if(isDefined(owner) && self.type == "trappackage")
		{
			if(player isAnAssassin() && player UseButtonPressed())
			{
				useEnt = self spawnUseEnt();
				result = useEnt useHoldThink(player, level.crateNonOwnerUseTime);
			
				if(isDefined(useEnt))
					useEnt Delete();

				if(result)
				{
					self PackageExplode(owner);
					break;
				}
			}
		}
	}
}

crateUseThinkOwner(owner) 
{
	while(isDefined(self))
	{
		self.trigger waittill("trigger", player);

		if(!isDefined(owner))
			break;
		
		if(!isAlive(player))
			continue;
			
		if(!player isOnGround())
			continue;

		if(isDefined(owner) && owner != player)
			continue;
	
		if(player isInRCToy())
			continue;
		
		if(player isReviving())
			continue;

		if(player isDog())
			continue;

		result = self useHoldThink(player, level.crateOwnerUseTime);

		if(result)
		{
			player GivePackageContent(self);
			break;
		}
	}
}

useHoldThink(player, useTime) 
{
	player freezeControls(true);
	player disableWeapons();
	self.curProgress = 0;
	self.inUse = true;
	self.useRate = 0;
	self.useTime = useTime;

	result = useHoldThinkLoop(player);
	
	if(isDefined(player) && isAlive(player))
	{
		player enableWeapons();
		player freezeControls(false);
	}
	
	if(isDefined(self))
		self.inUse = false;
	
	if(isdefined(result) && result)
		return true;
	
	return false;
}

useHoldThinkLoop(player)
{
	level endon("game_ended");

	player.IsOpeningCrate = true;
	
	while(isDefined(self) && isAlive(player) && player useButtonPressed() && self.curProgress < self.useTime)
	{
		player thread personalUseBar(self);
	
		self.curProgress += self.useRate*0.05;
		self.useRate = 1;

		if(self.curProgress >= self.useTime)
		{
			self.inUse = false;
			player.IsOpeningCrate = undefined;
			return isAlive(player);
		}
	wait .05;
	}
	
	player.IsOpeningCrate = undefined;
	
	return false;
}

personalUseBar(object) 
{
	self endon("disconnect");
	
	if(isDefined(self.useBar))
		return;
	
	self.useBar = self maps\mp\gametypes\_hud_util::createBar((1,1,1), 128, 8);
	self.useBar maps\mp\gametypes\_hud_util::setPoint("CENTER", 0, 0, 0);

	lastRate = -1;
	while(isAlive(self) && isDefined(object) && object.inUse && !level.gameEnded)
	{
		if(lastRate != object.useRate)
		{
			if(object.curProgress > object.useTime)
				object.curProgress = object.useTime;

			self.useBar maps\mp\gametypes\_hud_util::updateBar(object.curProgress/object.useTime, 1/object.useTime);

			if(!object.useRate)
				self.useBar maps\mp\gametypes\_hud_util::hideElem();
			else
				self.useBar maps\mp\gametypes\_hud_util::showElem();
		}

		lastRate = object.useRate;
		wait .05;
	}
	
	self.useBar maps\mp\gametypes\_hud_util::destroyElem();
}

spawnUseEnt()
{
	useEnt = spawn("script_origin", self.origin);
	useEnt.curProgress = 0;
	useEnt.inUse = false;
	useEnt.useRate = 0;
	useEnt.useTime = 0;
	useEnt.owner = self;
	
	useEnt thread useEntOwnerDeathWaiter(self);
	return useEnt;
}

useEntOwnerDeathWaiter(owner)
{
	self endon("death");
	owner waittill("death");
	
	self delete();
}

GivePackageContent(carepackage)
{
	self endon("death");
	self endon("disconnect");
	
	for(i=0;i<carepackage.blocker.size;i++)
		carepackage.blocker[i] delete();
		
	carepackage.trigger delete();
	carepackage delete();
	
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].hud_cpContent))
		{
			if(isDefined(level.players[i].hud_cpContent[carepackage.number])) 
				level.players[i].hud_cpContent[carepackage.number] destroy();
		}
	}
	
	weapon = carepackage.content[self.pers["team"]];
	empty = false;

	for(i=1;i<5;i++)
	{
		if(!isDefined(weapon) || self GetHardpointInSlot(i) == weapon)
		{
			scr_iPrintLnBold("YOU_HAVE_THE_WEAPON", self);
			return;
		}
	}
	
	if(self isAnAssassin())
	{
		if(weapon == "javelin")
		{
			self maps\mp\gametypes\_weaponloadouts::LoadOutExplosive(level.ktkWeapon["javelin"], 0);
			return;
		}
		else if(weapon == "juggernaut")
		{
			self.maxhealth = getDvarInt("scr_hardpoint_juggernaut_healthAssassins");
			self.health = self.maxhealth;

			if(self HasPerk("specialty_armorvest"))
				self UnSetPerk("specialty_armorvest");
			
			self thread maps\mp\gametypes\_huds::TerminatorHUD();
			self detachAll();
			self SetModel("playermodel_mw3_exp_juggernaunt");

			self SetMoveSpeedScale(0.85);
		}
		else if(weapon == level.ktkWeapon["magnum"] || weapon == level.ktkWeapon["nuke"] || weapon == level.ktkWeapon["crossbowExp"] || weapon == "marker_mp")
		{
			self giveWeapon(weapon);
			self giveMaxAmmo(weapon);
			
			self.weaponCpAssassins = weapon;

			if(weapon == level.ktkWeapon["magnum"])
				self SwitchToWeapon(weapon);
			else if(weapon == level.ktkWeapon["crossbowExp"])
			{
				self setWeaponToSlot(weapon);
				self setWeaponAmmoClip(weapon, 1);
				self setweaponammostock(weapon, 2);
			}
			else
			{
				if(isDefined(self SetHardpointToSlot("weapon", weapon, true)))
				{
					if(weapon == "marker_mp")
						self.pers["carepackagetype"] = "trappackage";
				}
			}
		}
		else if(weapon == "fakeguard")
		{
			self detachAll();
			[[game[game["defenders"]+"_model"]["ASSAULT"]]]();
			
			scr_iPrintLnBold("UNIFORM_OF_GUARD", self);
		}
	}
	else
	{
		if(weapon == "tripwire" || weapon == "tripwire_mp")
		{
			scr_iPrintLnBold("BOX_TRIP", self);
			
			if(isDefined(self.pers["hastripwires"]))
				self.pers["hastripwires"]++;
			else
				self.pers["hastripwires"] = 1;
		}
		else if(weapon == "juggernaut")
		{
			if(self HasPerk("specialty_armorvest"))
				self UnSetPerk("specialty_armorvest");

			if(!self isTerminator())
			{
				self detachAll();
				self SetModel("playermodel_mw3_exp_juggernaunt");
				self thread maps\mp\gametypes\_huds::TerminatorHUD();
				self SetMoveSpeedScale(0.85);
			}
			
			if(self isKing() || self isTerminator())
				self.maxhealth = self.maxhealth + getDvarInt("scr_hardpoint_juggernaut_healthGuards");
			else
				self.maxhealth = getDvarInt("scr_hardpoint_juggernaut_healthGuards");
			
			self.health = self.maxhealth;

			self TakeWeapon(self GetCurrentWeapon());
			self GiveWeapon(level.ktkWeapon["mg42"]);
			self GiveMaxAmmo(level.ktkWeapon["mg42"]);
			wait .1;
			self SwitchToWeapon(level.ktkWeapon["mg42"]);
		}
		else
		{
			if(isDefined(self SetHardpointToSlot("weapon", weapon, true)))
			{
				if(weapon == "marker_mp")
					self.pers["carepackagetype"] = "trappackage";
			}
		}
	}
}

PackageExplode(owner)
{
	self PlaySound("carepackage_trigger");
	
	wait 1;
	
	if(isDefined(self.blocker))
	{
		for(i=0;i<self.blocker.size;i++)
			self.blocker[i] delete();
	}

	PlayFX(level._effect["cpexplosion"], self.origin);
	PlayRumbleOnPosition( "artillery_rumble", self.origin );
	Earthquake( 0.7, 0.5, self.origin, 800 );
	
	if(isDefined(owner))
		self RadiusDamage(self.origin, 300 , 400 , 100, owner, "MOD_EXPLOSIVE", "marker_mp");
	else
		self RadiusDamage(self.origin, 300 , 400 , 100);

	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].hud_cpContent))
		{
			if(isDefined(level.players[i].hud_cpContent[self.number])) 
				level.players[i].hud_cpContent[self.number] destroy();
		}
	}

	self.trigger delete();
	self hide();
	wait 1; //for the killcam
	self delete();
}