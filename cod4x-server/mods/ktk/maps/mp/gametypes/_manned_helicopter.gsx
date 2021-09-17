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

CalculateHelicopterFlytime(startnode)
{
	//this is where the heli will be spawned at
	currentnode = startnode;
	
	flytime = 0;
	loopcount = 0;
	leaving = false;
	while(isDefined(currentnode.target))
	{
		if(!leaving)
			nextnode = getEnt(currentnode.target, "targetname");
		else
		{
			if(getDvarInt("scr_hardpoint_helicoptertype") == 0)
				nextnode = GetClosestLeaveNode(currentnode.origin);
			else
				break;
		}

		// motion change via node
		if(isDefined(currentnode.script_airspeed) && isDefined(currentnode.script_accel))
		{
			heli_speed = currentnode.script_airspeed;
			heli_accel = currentnode.script_accel;
		}
		else
		{
			heli_speed = 40; //30+randomInt(20);
			heli_accel = 20; //15+randomInt(15);
		}
		
		//calculations by [Ninja]Aura<3
		//Mt = Distance(currentnode.origin, nextnode.origin);			//Miles traveling
		//Ms = heli_speed;												//Maximum speed in mph
		//As = heli_accel;												//Acceleration speed in mphs
		//Ss = 0;														//The speed the heli is starting with
		//X = ((((Ms/As)*3)*((Ms-Ss)/2))/3600);							//The miles he travels by speeding up / slowing down: ((((max speed in mph / acceleration speed in mphs)*3)*((max speed in mph - start speed in mph)/2))/3600)
		//Y = (((Ms/As)*3)/3600);										//The amount of hours he needs to speed up / slow down: (((max speed in mph / acceleration speed in mphs) *3)/3600)
		//Ft = (Mt-X)/Ms+Y;												//The total flytime
			
		//my calculations
		//Note: in cod the decceleration is half of the acceleration
		//1. If the distance is big enough for a full acceleration and decceleration (and maybe a part for traveling at max speed)
		//Part 1 - Acceleration: 	t1 = Vmax / a1				s1(t) = 1/2 * a1 * t1²
		//Part 3 - Decceleration: 	v3(t) = Vmax - a2 * t3		t3 = (Vmax - v3(t)) / a2		s3(t) = Vmax * t3 - 1/2 * a2 * t3²
		//Part 2 - Constant speed: 	s2 = Smax - s1 - s3			t2 = s2 / Vmax
		//The sum:					Smax = s1 + s2 + s3			Tmax = t1 + t2 + t3
			
		t1 = (heli_speed / heli_accel);
		s1 = (1/2 * heli_accel * sqr(t1));
			
		t3 = ((heli_speed - 0) / (heli_accel/2));
		v3 = (heli_speed - (heli_accel/2) * t3);
		s3 = (heli_speed * t3 - 1/2 * (heli_accel/2) * sqr(t3));
			
		s2 = (Distance(currentnode.origin, nextnode.origin) - s1 - s3);
		t2 = (s2 / heli_speed);
			
		if(s2 >= 0 && t2 >= 0)
			flytime += int(t1 + t2 + t3);
		else
		{
			//2. Else it has to stop accelerating and start to deccelerate
			//Split the distance:	s1 = Smax / 3				s2 = 2 * s1
			//Calculate the time:	t1 = √(s1 / (1/2 * a1))		t2 = √(s2 / (1/2 * a2))
			//The sum:				Tmax = t1 + t2				Smax = s1 + s2
				
			s1 = (Distance(currentnode.origin, nextnode.origin) / 3);
			s2 = (2 * s1);
			t1 = sqrt(s1 / (1/2 * heli_accel));
			t2 = sqrt(s2 / (1/2 * (heli_accel/2)));
				
			flytime += int(t1 + t2);
		}
			
		//heli starts to fly circles from now on
		if(!isDefined(nextnode.target) || nextnode == level.heli_loop_paths[0])
		{
			loopcount++;

			if(loopcount <= level.heli_mg_loopmax)
				nextnode = level.heli_loop_paths[0];
			else
			{
				leaving = true;				
				
				//we are already leaving, so stop here
				if(currentnode == nextnode)
					break;
			}
		}
		
		currentnode = nextnode;
		wait .05;
	}
	
	return (flytime/10);
}

GetClosestLeaveNode(origin)
{
	curDistance = 999999999;
	curNode = undefined;
	
	for(i=0;i<level.heli_leavenodes.size;i++)
	{
		distance = Distance(origin, level.heli_leavenodes[i].origin);
		
		if(distance <= curDistance)
		{
			curDistance = distance;
			curNode = level.heli_leavenodes[i];
		}
	}
	
	return curNode;
}

init()
{
	if(getDvar("scr_mod_heli_loops") == "") setDvar("scr_mod_heli_loops", 2);
	if(getDvar("scr_mod_heli_drop") == "") setDvar("scr_mod_heli_drop", 1);

	if(getDvarInt("scr_mod_heli_loops") > 3) setDvar("scr_mod_heli_loops", 3);
	else if(getDvarInt("scr_mod_heli_loops") < 1) setDvar("scr_mod_heli_loops", 1);

	level.heli_mg_loopmax = getDvarInt("scr_mod_heli_loops");
	
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

	level.HelicopterGunner = undefined;
}

spawnHeli(startnode)
{
	level.HelicopterGunner = self;

	heliFlytime = CalculateHelicopterFlytime(startnode);
	
	//did the round end while the flytime was calculated?
	if(!level.roundstarted)
		return;
	
	level.helicopter = spawnHelicopter( level.HelicopterGunner, startnode.origin, startnode.angles, "cobra_mp", "vehicle_cobra_helicopter_fly" );
	
	level.helicopter.turret = spawn ("script_model",level.helicopter.origin + (0,0,-250));
	level.helicopter.turret.angles = level.helicopter.angles;
	level.helicopter.turret linkto(level.helicopter);
	
	level.helicopter.health = CalculateHeliHealth();
	level.helicopter.currentstate = "ok";
	level.helicopter.crashing = false;
	level.helicopter.leaving = false;
	
	level.helicopter playLoopSound( "mp_cobra_helicopter" );
	level.helicopter SetDamageStage(3);
	level.helicopter setCanDamage(true);
	level.helicopter thread check_damage();
	level.helicopter thread heli_fly(startnode);
	level.helicopter thread HeliCloseNades();
	
	if(isDefined(level.helicopter) && isDefined(level.HelicopterGunner) && isPlayer(level.HelicopterGunner) && isAlive(level.HelicopterGunner))
	{
		level.HelicopterGunner thread attach_owner();
		level.HelicopterGunner thread maps\mp\gametypes\_huds::HardpointLiveTimeHud("helicopter_mp", heliFlytime, level.helicopter);
	}
}

check_damage()
{
	while(1)
	{
		self waittill("damage", amount, attacker);

		if(level.helicopter.crashing || level.helicopter.leaving || !isDefined(self))
			break;
		
		if(!isDefined(level.HelicopterGunner))
			break;
		
		if((isplayer(attacker) && attacker isInSameTeamAs(level.HelicopterGunner)) || attacker == level.HelicopterGunner)
			continue;
		
		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback( false );
		
		self.health -= amount;
		
		if(self.health <= 0)
		{
			attacker maps\mp\gametypes\_rank::giveRankXP("kill", 400);
			self thread heli_crash();
			break;
		}
	}
}

attach_owner()
{
	self endon("disconnect");
	self endon("death");

	self thread onOwnerDeath();
	self thread onOwnerDisconnect();
	self thread onRoundEnd();
	
	//self setStance("stand"); 
	//setStance requires cod4x new_arch
	self ExecClientCommand("+gostand");
	
	self.oldstance = self getStance();
	self.oldorigin = self.origin;
	self.isatoldorigin = false;
	self.inhelicopter = true;
	self.godmode = true;
	
	if(!isDefined(level.helicopter))
		DebugMessage(5, "Manned helicopter is not defined! level.roundstarted is: " + int(level.roundstarted));
	
	if(!isDefined(level.helicopter.turret))
		DebugMessage(5, "Manned helicopter turret is not defined! level.roundstarted is: " + int(level.roundstarted));
	
	if(!isDefined(level.helicopter.turret.origin))
		DebugMessage(5, "Manned helicopter turret ORIGIN is not defined! level.roundstarted is: " + int(level.roundstarted));
	
	self setorigin(level.helicopter.turret.origin);
	self setplayerangles(level.helicopter.turret.angles);
	self linkto (level.helicopter.turret);

	self DetachAll();
	self setModel("fake_player"); //self hide();
	self TakeWeapon("helicopter_mp");
	self GetInventory();
	self TakeAllWeapons();
	self GiveWeapon( "ac130_25mm_mp" );
	
	if(self isABot())
		self setSpawnWeapon("ac130_25mm_mp");
	else
		self switchToWeapon("ac130_25mm_mp");
	
	self SetClientDvars("cg_drawgun", 0,
						"cg_fovScale", 0.35);
	
	self thread TargetMarkers();
	self thread ac130_hud( "ac130_overlay_25mm");
	self thread remove_player_hud();
	self thread check_firing();

	while(1)
	{
	wait .1;
		
		if(!isDefined(self) || !isAlive(self))
			return;
			
		if(!isDefined(level.helicopter))
			return;
			
		if(!self isInMannedHelicopterTurret())
			return;
			
		if(!self isInMannedHelicopter())
			return;
	
		if(self UseButtonPressed())
		{
			pressStartTime = gettime();
			while ( self useButtonPressed() )
			{
				wait .05;
				if ( gettime() - pressStartTime > 700 )
					break;
			}
			if ( gettime() - pressStartTime > 700 )
				break;
		}
	}

	if(isDefined(level.helicopter))
		level.helicopter thread heli_leave();
}

check_firing()
{
	self endon("disconnect");
	self endon("death");
	
	while(1)
	{
	self waittill ( "weapon_fired" );
		
		if(isDefined(level.helicopter.leaving) && level.helicopter.leaving)
			break;

		if(isDefined(level.helicopter.crashing) && level.helicopter.crashing)
			break;

		if(!self isInMannedHelicopterTurret())
			break;
		
		self SetWeaponAmmoClip( self GetCurrentWeapon(), WeaponClipSize( self GetCurrentWeapon() ) );

		trace = BulletTrace( self getEye() + (0, 0, 20) , self GetEye()+(0,0,20)+AnglesToForward( self GetPlayerAngles() )*10000, false, self);
		target = trace["position"];
		PlayFX( level.effect["turret_dirt_impact"], target);
	}
}

remove_owner()
{
	self endon("death");
	self endon("disconnect");
	
	if(isDefined(self.ac130_hud)) self.ac130_hud destroy();

	level.HelicopterGunner = undefined;
	
	if(getDvarInt("scr_mod_heli_drop") == 1)
	{
		if(self isKing() || self isTerminator())
			self maps\mp\gametypes\_bossmodels::SetBossModel();
		else
			self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();
		
		haselim = false;
		
		if(self HasPerk("specialty_pistoldeath"))
		{
			haselim = true;
			self UnSetPerk("specialty_pistoldeath");
		}

		self thread DeleteTargetMarkers();
		self thread ReturnStance();
		
		self unlink();
		self TakeAllWeapons();
		self GiveInventory();
		self SwitchToPreviousWeapon();
		
		self SetClientDvars("cg_drawgun", 1,
							"cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
		
		self.godmode = false;
		self.isatoldorigin = true;
		self.inhelicopter = false;
		self.droppedparachute = false;
		
		self spawnParachute();
		self playloopsound("parachute");
		
		while(1)
		{
			forward = self.origin - (0,0,5) + AnglesToForward((self.angles[0],self.angles[1],0)) * 150;
			target = PlayerPhysicsTrace(self.origin, forward);
			distance = Distance(self.origin, target);
			
			findGroud = BulletTrace(self.origin, self.origin - (0,0,30), false, self);
			
			if(distance <= 100 || findGroud["fraction"] < 1)
			{
				self.droppedparachute = true;
				self DropParachute();
				
				if(distance == 0)
				{
					dropNewPos = playerPhysicsTrace(self.origin + (0,0,50), self.origin - (0,0,200));
					self SetOrigin(dropNewPos);
				}
				
				break;
			}
			else
			{
				self.parachute RotateTo((0,self.angles[1]-90,180), 0.8);
				self.parachute MoveTo(target, 0.4);
			
				if(self UseButtonPressed())
				{
					pressStartTime = gettime();
					while(self useButtonPressed())
					{
						wait .05;
						
						if(gettime() - pressStartTime > 700)
							break;
					}
					
					if(gettime() - pressStartTime > 700)
					{
						self.droppedparachute = true;
						self DropParachute();
						break;
					}
				}
			}

			wait .1;
		}
			
		if(haselim)
			self SetPerk("specialty_pistoldeath");
	}
	else
	{
		spawns = getentarray("mp_tdm_spawn", "classname");

		if(getDvarInt("scr_mod_heli_drop") == 2) 
			self ReturnToOldPosition();
		else if(getDvarInt("scr_mod_heli_drop") == 3) 
			self setOrigin(spawns[RandomInt(spawns.size)].origin);
		
		if(isDefined(self.remove_player_hud))
			self.remove_player_hud destroy();

		if(self isKing() || self isTerminator())
			self maps\mp\gametypes\_bossmodels::SetBossModel();
		else
			self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();

		self thread DeleteTargetMarkers();
		self thread ReturnStance();

		self unlink();
		self TakeAllWeapons();
		self GiveInventory();
		self SwitchToPreviousWeapon();
		
		self SetClientDvars("cg_drawgun", 1,
							"cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
		
		self.isatoldorigin = true;
		self.inhelicopter = false;
		self.godmode = false;
	}
}

spawnParachute()
{
	self endon("disconnect");
	self endon("death");

	self.parachute = spawn("script_model", self.origin + (0,-15,55));
	self.parachute setModel("parachute");
	self.parachute.angles = (0,0,180);
	
	self playlocalsound("parachute");
	self linkto(self.parachute);
}

DropParachute()
{
	self endon("disconnect");
	self endon("death");

	if(isDefined(self.remove_player_hud))
		self.remove_player_hud destroy();

	self stoploopsound();
	self unlink();
	
	if(!self.droppedparachute)
		self.godmode = true;

	if(self HasPerk( "specialty_pistoldeath" ))
		self UnsetPerk("specialty_pistoldeath");

	while(!self isOnGround())
		wait .1;
	
	if(self.godmode)
		self.godmode = false;
	
	self playlocalsound("parachute_landing");
	self ShellShock( "frag_grenade_mp", 1 );
	
	if(isDefined(self.parachute))
		self.parachute delete();
}

heli_fly(currentnode)
{
	self endon( "death" );
	
	self.loopcount = 0;
	
	// only one thread instance allowed
	self notify( "flying");
	self endon( "flying" );
	
	// if owner switches teams, helicopter should leave
	self endon( "abandoned" );
	
	self.reached_dest = false;
	self clearTargetYaw();
	self clearGoalYaw();
	self setspeed( 60, 25 );	
	self setyawspeed( 75, 45, 45 );
	self setmaxpitchroll( 30, 30 );
	self setneargoalnotifydist( 256 );
	self setturningability(0.9);
	
	pos = self.origin;

	while ( isdefined( currentnode.target ) )
	{	
		nextnode = getent( currentnode.target, "targetname" );
		assertex( isdefined( nextnode ), "Next node in path is undefined, but has targetname" );
		
		// offsetted 
		pos = nextnode.origin+(0,0,30);
		
		// motion change via node
		if( isdefined( currentnode.script_airspeed ) && isdefined( currentnode.script_accel ) )
		{
			heli_speed = currentnode.script_airspeed;
			heli_accel = currentnode.script_accel;
		}
		else
		{
			heli_speed = 40; //30+randomInt(20);
			heli_accel = 20; //15+randomInt(15);
		}
		
		// fly nonstop until final destination
		if ( !isdefined( nextnode.target ) )
			stop = 1;
		else
			stop = 0;
		
		// debug ==============================================================
		//debug_line( currentnode.origin, nextnode.origin, ( 1, 0.5, 0.5 ), 200 );
		
		// if in damaged state, do not stop at any node other than destination
		if( self.currentstate == "heavy smoke" || self.currentstate == "light smoke" )	
		{
			// movement change due to damage
			self setspeed( heli_speed, heli_accel );	
			self setvehgoalpos( (pos), stop );
		
			self waittill( "near_goal" ); //self waittillmatch( "goal" );
			self notify( "path start" );
			
		}
		else
		{
			// if the node has helicopter stop time value, we stop
			if( isdefined( nextnode.script_delay ) ) 
				stop = 1;
	
			self setspeed( heli_speed, heli_accel );	
			self setvehgoalpos( (pos), stop );
		
			if ( !isdefined( nextnode.script_delay ) )
			{
				self waittill( "near_goal" ); //self waittillmatch( "goal" );
				self notify( "path start" );
			}
			else
			{			
				// post beta addition --- (
				self setgoalyaw( nextnode.angles[1] );
				// post beta addition --- )
			
				self waittillmatch( "goal" );				
				wait( level.heli_dest_wait );
			}
		}
		
		// increment loop count when helicopter is circling the map
		for( index = 0; index < level.heli_loop_paths.size; index++ )
		{
			if ( level.heli_loop_paths[index].origin == nextnode.origin )
				self.loopcount++;
		}
		if( self.loopcount >= level.heli_mg_loopmax )
		{
			self thread heli_leave();
			return;
		}
		currentnode = nextnode;
	}

	self setgoalyaw( currentnode.angles[1] );
	self.reached_dest = true;	// sets flag true for helicopter circling the map
	self notify ( "destination reached" );
	// wait at destination
	wait( level.heli_dest_wait );

	if(!self.leaving && !self.crashing)
	{
		// set helicopter path to circle the map level.heli_mg_loopmax number of times
		loop_startnode = level.heli_loop_paths[0];
		self thread heli_fly( loop_startnode );
	}
}

heli_crash()
{
	self endon("death");

	owner = level.HelicopterGunner;
	
	self.crashing = true;	
	self setCanDamage(false);
	
	self.pathclear = true;
	self setvehgoalpos(self.origin,0);
	self StopLoopSound();

	if(!isDefined(owner))
		self playSound ( level.heli_sound[game["defenders"]]["hitsecondary"] );
	else
	{
		if(owner isInMannedHelicopter())
			owner thread remove_owner();
		
		random = randomint(3);
		if(random == 0) owner PlayLocalSound("airlift_fhp_mayday");
		else if(random == 1) owner PlayLocalSound("villagedef_hcc_takingfire");
		else if(random == 2) owner PlayLocalSound("villagedef_hcc_goindown");
		
		self playSound ( level.heli_sound[owner.team]["hitsecondary"] );
	}

	self thread heli_spin(owner);
	
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

	if(isDefined(owner))
	{
		self playSound( level.heli_sound[owner.team]["crash"] );
		RadiusDamage( self.origin, 600, 1000, 5, owner, "MOD_EXPLOSIVE", "helicopter_mp");
	}
	else
	{
		self playSound( level.heli_sound[game["defenders"]]["crash"] );
		RadiusDamage( self.origin, 600, 1000, 5);
	}
	
	forward = ( self.origin + ( 0, 0, 100 ) ) - self.origin;
	playfx ( level.chopper_fx["explode"]["death"], self.origin, forward );
	if(isDefined(self.turret)) self.turret delete();
	if(isDefined(self)) self delete();
}

heli_leave()
{
	self endon("death");

	if(isDefined(self.leaving) && self.leaving)
		return;
	
	self.leaving = true;

	if(isDefined(level.HelicopterGunner))
	{
		random = randomint(4);
		if(random == 0) level.HelicopterGunner PlayLocalSound("sniperescape_hp1_toolow");
		else if(random == 1) level.HelicopterGunner PlayLocalSound("vassault_rhp_refuelandrearm");
		else if(random == 2) level.HelicopterGunner PlayLocalSound("villagedef_hp2_outtahere");
		else if(random == 3) level.HelicopterGunner PlayLocalSound("airlift_fhp_refitandrefuel");

		if(level.HelicopterGunner isInMannedHelicopter() && !level.HelicopterGunner isAtOldOrigin())
			level.HelicopterGunner thread remove_owner();

		level.HelicopterGunner = undefined;
	}

	leavenode = GetClosestLeaveNode(self.origin);
	if(isDefined(leavenode))
	{
		self setspeed( 100, 45 );
		self setvehgoalpos( leavenode.origin, 1 );
		self waittillmatch( "goal" );
	}
	
	if(isDefined(self)) self delete();
	if(isDefined(self.turret)) self.turret delete();
}

heli_spin(owner)
{
	self endon( "death" );
	
	playfxontag( level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt" );
	self playSound ( level.heli_sound[owner.team]["hit"] );
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
	self endon( "death" );
	
	while(1)
	{
		wait .1;
		if(!bullettracepassed( self.origin, self.origin - (0,0,150), false, self ) || !bullettracepassed( self.origin, self.origin + (0,0,25), false, self ) || !bullettracepassed( self.origin, self.origin + (160,0,0), false, self ) || !bullettracepassed( self.origin, self.origin - (328,0,0), false, self )) 
		{
			self.pathclear = false;
			break;
		}
	}
}

spinSoundShortly()
{
	self endon("death");
	
	if(isDefined(level.HelicopterGunner))
		team = level.HelicopterGunner.team;
	else
		team = game["defenders"];
	
	wait .25;
	self stopLoopSound();
	wait .05;
	self playLoopSound( level.heli_sound[team]["spinloop"] );
	wait .05;
	self playSound( level.heli_sound[team]["spinstart"] );
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

onOwnerDeath()
{
	self endon("disconnect");
	self waittill("death");
	
	self StopLoopSound();
	self.isatoldorigin = true;
	self.godmode = false;
	
	self SetClientDvars("cg_drawgun", 1,
						"cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
	
	if(isDefined(self.ac130_hud)) self.ac130_hud destroy();
	if(isDefined(self.remove_player_hud)) self.remove_player_hud destroy();
	if(isDefined(self.parachute)) self.parachute delete();
	
	if(isDefined(level.helicopter))
		level.helicopter thread heli_leave();
}

onOwnerDisconnect()
{
	self endon("death");
	self waittill("disconnect");
	
	if(isDefined(level.helicopter))
		level.helicopter thread heli_leave();
	
	if(isDefined(self.parachute))
		self.parachute delete();
}

onRoundEnd()
{
	self endon("disconnect");
	self endon("death");
	
	while(level.roundstarted)
		wait 1;
	
	if(!self isInMannedHelicopterTurret())
		return;
	
	if(self isKing() || self isTerminator())
		self maps\mp\gametypes\_bossmodels::SetBossModel();
	else
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();
	
	self show();
	self unlink();
	self ReturnToOldPosition();
	self StopLoopSound();
	self.godmode = false;
	self.isatoldorigin = true;
	self.inhelicopter= false;

	self SetClientDvars("cg_drawgun", 1,
						"cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
	
	self thread ReturnStance();
	
	level.HelicopterGunner = undefined;
	
	if(isDefined(self.ac130_hud)) self.ac130_hud destroy();
	if(isDefined(self.remove_player_hud)) self.remove_player_hud destroy();	
	if(isDefined(self.parachute)) self.parachute delete();
	if(isDefined(level.helicopter)) level.helicopter delete();
	if(isDefined(level.helicopter.turret)) level.helicopter.turret delete();
}

ac130_hud(shader)
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(self.ac130_hud)) self.ac130_hud destroy();
	
	self.ac130_hud = newClientHudElem( self );
	self.ac130_hud.x = 0;
	self.ac130_hud.y = 0;
	self.ac130_hud.alignX = "center";
	self.ac130_hud.alignY = "middle";
	self.ac130_hud.horzAlign = "center";
	self.ac130_hud.vertAlign = "middle";
	self.ac130_hud.foreground = true;
	self.ac130_hud.hidewheninmenu = false;
	self.ac130_hud setshader(shader, 640, 480);
}

remove_player_hud()
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(self.remove_player_hud)) self.remove_player_hud destroy();	
	
	self.remove_player_hud = newClientHudElem( self );
	self.remove_player_hud.fontScale = 1.4;
	self.remove_player_hud.horzAlign = "center";
	self.remove_player_hud.vertAlign = "middle";
	self.remove_player_hud.alignX = "center";
	self.remove_player_hud.alignY = "middle";
	self.remove_player_hud.x = 0;
	self.remove_player_hud.y = 100;
	self.remove_player_hud.alpha = 0.75;
	self.remove_player_hud.sort = 1001;
	self.remove_player_hud.hidewheninmenu = false;
	self.remove_player_hud.label = self GetLocalizedString("HOLD_USE_TO_LEAVE");
}