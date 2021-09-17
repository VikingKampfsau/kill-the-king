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
#include maps\mp\gametypes\_misc;

init()
{
	if(getDvar("scr_ktk_allow_ah6") == "") setDvar("scr_ktk_allow_ah6", 1);
	if(getDvar("scr_ktk_ah6_repeat") == "") setDvar("scr_ktk_ah6_repeat", 1);
	if(getDvar("scr_ktk_ah6_repeatdelay") == "") setDvar("scr_ktk_ah6_repeatdelay", 30);
	
	if(getDvarInt("scr_ktk_allow_ah6") == 0)
		return;

	level.ah6 = undefined;
	level.ah6_targeting_delay = 3;
	level.ah6_called = false;
	level.ah6_repeat = getDvarInt("scr_ktk_ah6_repeat");
	level.ah6_repeat_delay = getDvarInt("scr_ktk_ah6_repeatdelay");
	
	level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
	level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["allies"]["crash"] = "cobra_helicopter_crash";
	level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
	level.heli_sound["axis"]["hit"] = "hind_helicopter_hit";
	level.heli_sound["axis"]["hitsecondary"] = "hind_helicopter_secondary_exp";
	level.heli_sound["axis"]["damaged"] = "hind_helicopter_damaged";
	level.heli_sound["axis"]["spinloop"] = "hind_helicopter_dying_loop";
	level.heli_sound["axis"]["spinstart"] = "hind_helicopter_dying_layer";
	level.heli_sound["axis"]["crash"] = "hind_helicopter_crash";
	level.heli_sound["axis"]["missilefire"] = "weap_hind_missile_fire";

	level.chopper_fx["explode"]["death"] = loadfx ("explosions/helicopter_explosion_cobra");
	level.chopper_fx["explode"]["large"] = loadfx ("explosions/aerial_explosion_large");
	level.chopper_fx["explode"]["medium"] = loadfx ("explosions/aerial_explosion");
	level.chopper_fx["smoke"]["trail"] = loadfx ("smoke/smoke_trail_white_heli");
	level.chopper_fx["fire"]["trail"]["medium"] = loadfx ("smoke/smoke_trail_black_heli");
	level.chopper_fx["fire"]["trail"]["large"] = loadfx ("fire/fire_smoke_trail_L");

	if(!isDefined(level.heli_paths))
		return;
	
	thread WaitTillKingIsAlone();
}
	
WaitTillKingIsAlone()
{
	while(1)
	{
	wait .1;

		while(!isDefined(level.roundstarted) || !level.roundstarted)
			wait .1;
	
		if(GetTeamPlayersAlive(game["defenders"]) == 1 && GetTeamPlayersAlive(game["attackers"]) >= 5 && !level.ah6_called)
		{
			if(game["customEvent"] == "reversektk")
			{
				if(level.assassin isInRCToy() || level.assassin isInParachute())
					continue;
			}
			else
			{
				if(level.king isInRCToy() || level.king isInParachute())
					continue;
			}

			if(isDefined(level.ac130Player) || isDefined(level.helicopter) || isDefined(level.chopper))
				continue;
		
			if(VehicleCanSpawn())
				thread SpawnAh6();
			
			if(level.ah6_repeat == 0)
				break;

			while(isDefined(level.ah6))
				wait .1;
				
			wait level.ah6_repeat_delay;
		}
	}
}

SpawnAh6()
{
	if(level.ah6_called)
		return;

	level.random_path = randomint( level.heli_paths[0].size );
	level.startnode = level.heli_paths[0][level.random_path];	
	level.random_leave_node = randomInt( level.heli_leavenodes.size );
	level.leavenode = level.heli_leavenodes[level.random_leave_node];

	level.ah6_called = true;
	
	if(game["customEvent"] == "reversektk")
	{
		level.ah6 = spawnHelicopter( level.assassin, level.startnode.origin, level.startnode.angles, "cobra_mp", "vehicle_cobra_helicopter_fly" );
		level.ah6.team = level.assassin.pers["team"];
	}
	else
	{
		level.ah6 = spawnHelicopter( level.king, level.startnode.origin, level.startnode.angles, "cobra_mp", "vehicle_cobra_helicopter_fly" );
		level.ah6.team = level.king.pers["team"];
	}
	
	level.ah6 playLoopSound( "mp_cobra_helicopter" );
	level.ah6.health = CalculateHeliHealth();
	level.ah6.currentstate = "ok";
	level.ah6 SetDamageStage(3);
	level.ah6 setCanDamage(true);

	level.ah6 thread check_damage();
	level.ah6 thread CallInAh6(level.startnode);
	level.ah6 thread HeliCloseNades();
	level.ah6 thread RemoveOnTeamIncrease();
}

check_damage()
{
	while(1)
	{
		self waittill("damage", amount, attacker);

		if(level.ah6.crashing || level.ah6.leaving || !isDefined(level.ah6))
			break;
		
		if(isPlayer(attacker) && attacker.pers["team"] == self.team)
			continue;
		
		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback( false );
		
		self.health -= amount;
		
		if(self.health <= 0)
		{
			attacker maps\mp\gametypes\_rank::giveRankXP("kill", 400);
			self thread CrashAh6();
			break;
		}
	}
}

CallInAh6(currentnode)
{
	self endon("death");
	self notify( "ah6_flying");
	self endon( "ah6_flying" );

	self.crashing = false;
	self.leaving = false;
	
	self clearTargetYaw();
	self clearGoalYaw();
	self SetSpeedPlayerBased();
	self setmaxpitchroll( 30, 30 );
	self setneargoalnotifydist( 256 );
	self setturningability(0.9);
	
	pos = self.origin;
	wait( 2 );

	self thread SearchTarget();
	self thread ShootTarget();
	
	if(game["customEvent"] == "reversektk")
	{
		while(isDefined(level.assassin))
		{
		wait .1;

			if(GetTeamPlayersAlive(game["attackers"]) > 3 || GetTeamPlayersAlive(game["defenders"]) < 5)
				break;
		
			pos = (level.assassin.origin[0], level.assassin.origin[1], level.assassin.origin[2] + 1000);
			heli_speed = 30+randomInt(20);
			heli_accel = 15+randomInt(15);
			stop = 0;
			
			self setspeed( heli_speed, heli_accel );	
			self setvehgoalpos( (pos), stop );
			
			self waittill( "near_goal" );
		}
	}
	else
	{
		while(isDefined(level.king))
		{
		wait .1;

			if(GetTeamPlayersAlive(game["defenders"]) > 3 || GetTeamPlayersAlive(game["attackers"]) < 5)
				break;
		
			pos = (level.king.origin[0], level.king.origin[1], level.king.origin[2] + 1000);
			heli_speed = 30+randomInt(20);
			heli_accel = 15+randomInt(15);
			stop = 0;
			
			self setspeed( heli_speed, heli_accel );	
			self setvehgoalpos( (pos), stop );
			
			self waittill( "near_goal" );
		}
	}
	
	if(isDefined(self) && !self.leaving && !self.crashing)
		self Ah6LeaveMap();
}

SetSpeedPlayerBased()
{
	if(level.players.size > 0 && level.players.size <= 5)
	{
		self setspeed( 60, 25 );
		self setyawspeed( 75, 45, 45 );
	}
	else if(level.players.size > 5 && level.players.size <= 10)
	{
		self setspeed( 70, 35 );
		self setyawspeed( 85, 45, 45 );
	}
	else if(level.players.size > 10 && level.players.size <= 15)
	{
		self setspeed( 80, 45 );
		self setyawspeed( 95, 45, 45 );
	}
	else if(level.players.size > 15 && level.players.size <= 20)
	{
		self setspeed( 90, 55 );
		self setyawspeed( 105, 45, 45 );
	}
	else if(level.players.size > 25 && level.players.size <= 30)
	{
		self setspeed( 100, 55 );
		self setyawspeed( 115, 45, 45 );
	}
	else
	{
		self setspeed( 110, 55 );
		self setyawspeed( 125, 45, 45 );
	}
}

Ah6LeaveMap()
{
	self endon("death");

	self.leaving = true;

	self setspeed( 100, 45 );	
	self setvehgoalpos( level.leavenode.origin, 1 );
	self waittillmatch( "goal" );
	
	level.ah6_called = false;
	
	if(isDefined(self)) 
		self delete();
}

CrashAh6()
{
	self endon("death");
	
	self.crashing = true;	
	self setCanDamage(false);
	
	self.pathclear = true;
	self setvehgoalpos(self.origin,0);
	self StopLoopSound();

	self thread heli_spin();
	self playSound ( level.heli_sound[self.team]["hitsecondary"] );
	
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
	self playSound( level.heli_sound[self.team]["crash"] );
	
	if(game["customEvent"] == "reversektk")
		RadiusDamage( self.origin, 600, 1000, 5, level.assassin, "MOD_EXPLOSIVE", "cobra_20mm_mp");
	else
		RadiusDamage( self.origin, 600, 1000, 5, level.king, "MOD_EXPLOSIVE", "cobra_20mm_mp");
	
	level.ah6_called = false;
	if(isDefined(self)) self delete();
}

heli_spin()
{
	self endon("death");

	playfxontag( level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt" );
	self playSound ( level.heli_sound[self.team]["hit"] );
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
	self playLoopSound( level.heli_sound[self.team]["spinloop"] );
	wait .05;
	self playSound( level.heli_sound[self.team]["spinstart"] );
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

SearchTarget()
{
	self endon("death");

	while(1)
	{
		currentTarget = undefined;
		currentTargetDistance = undefined;
		
		wait level.ah6_targeting_delay;

		if(self.crashing || self.leaving || !isDefined(self))
			break;
		
		for(i=0;i<level.players.size;i++)
		{
			if(level.players[i] isAnAssassin() && level.players[i].sessionstate == "playing")
			{
				TargetDistance = self ViewRange(level.players[i]);
				if(TargetDistance > 0 && (!isDefined(currentTargetDistance) || TargetDistance < currentTargetDistance))
				{
					currentTargetDistance = TargetDistance;
					currentTarget = level.players[i];
				}
			}
		}

		if(isDefined(currentTarget))
		{
			self.currenttarget = currentTarget;
         
			while(isAlive(self.currenttarget) && self.currenttarget.sessionstate == "playing" && self ViewRange(self.currenttarget) > 0)
				wait .1;
		}
		
		self.currenttarget = undefined;
	}
}

ViewRange(target)
{
	self endon("death");

	self.turretposition = self.origin + (152,0,-156);
	
	trace = bullettrace(self.turretposition, target getEye(), false, self);

	if(trace["fraction"] == 1 && target SightConeTrace(self.turretposition, self) > 0.6)
	{
		distance = Distance(self.turretposition, target.origin);
	
		if(distance <= level.heli_visual_range)
			return distance;
	}

	return 0;
}

ShootTarget()
{
	self endon("death");
	
	bullets = level.heli_turretClipSize;
	
	while(1)
	{
		wait level.ah6_targeting_delay;

		if(self.crashing || self.leaving || !isDefined(self))
			break;

		if(bullets <= 0)
		{
			wait level.heli_turretReloadTime;
			bullets = level.heli_turretClipSize;
		}

		clipsize = bullets;
		
		for(i=0;i<clipsize;i++)
		{
			if (!isAlive(self.currenttarget) || self.currenttarget.sessionstate != "playing" || !isDefined(self.currenttarget))
				break;
				
			self PlaySound("weap_m197_cannon_fire");
			PlayFX( level.effect["turret_dirt_impact"], self.currenttarget.origin);
			
			//a very bad way to simulate misses
			damage = RandomInt(15);
			
			if(damage > 0)
			{
				if(game["customEvent"] == "reversektk")
					self.currenttarget ktkFinishPlayerDamage( self, level.assassin, damage, 0, "MOD_RIFLE_BULLET", "cobra_20mm_mp", self.turretposition, VectorToAngles(self.currenttarget.origin - self.turretposition), "none", 0 );
				else
					self.currenttarget ktkFinishPlayerDamage( self, level.king, damage, 0, "MOD_RIFLE_BULLET", "cobra_20mm_mp", self.turretposition, VectorToAngles(self.currenttarget.origin - self.turretposition), "none", 0 );
			}

			bullets--;
			wait 0.11;
		}
	}
}

RemoveOnTeamIncrease()
{
	self endon("death");
	
	while(1)
	{
	wait .1;
	
		if(GetTeamPlayersAlive(game["defenders"]) > 3 && isDefined(self))
			break;
	}
	
	if(!self.leaving || !self.crashing)
		self thread Ah6LeaveMap();
}