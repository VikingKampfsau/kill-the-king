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
	if(getDvar("scr_mod_ac130_alivetime") == "") setDvar("scr_mod_ac130_alivetime", 30);

	precacheShader("ac130_overlay_25mm");
	precacheShader("ac130_overlay_40mm");
	precacheShader( "ac130_overlay_105mm" );
	precacheShader("ac130_overlay_grain");
	
	precacheItem("ac130_25mm_mp");
	precacheItem("ac130_40mm_mp");
	precacheItem("ac130_105mm_mp");
	
	precacheRumble("ac130_25mm_fire");
	precacheRumble("ac130_40mm_fire");
	precacheRumble("ac130_105mm_fire");

	level.gunReady["ac130_25mm"] = true;
	level.gunReady["ac130_40mm"] = true;
	level.gunReady["ac130_105mm"] = true;

	level.ac130FlyRadius = 1500;
	level.ac130Alivetime = getDvarInt("scr_mod_ac130_alivetime");
}

ac130_attachPlayer(player)
{
	if(isDefined(level.ac130Player))
		return;

	level.ac130Player = player;
	level.ac130Player.isatoldorigin = false;
	level.ac130Player.oldorigin = level.ac130Player.origin;
	level.ac130Player.oldstance = level.ac130Player getStance();

	level.ac130Player TakeWeapon(level.ktkWeapon["ac130"]);
	level.ac130Player GetInventory();
	level.ac130Player TakeAllWeapons();
	level.ac130Player GiveWeapon("ac130_105mm_mp");
	
	if(self isABot())
		level.ac130Player setSpawnWeapon("ac130_105mm_mp");
	else
		level.ac130Player SwitchToWeapon("ac130_105mm_mp");

	//level.ac130Player setStance("stand");
	//setStance requires cod4x new_arch
	level.ac130Player ExecClientCommand("+gostand");
	
	level.ac130Player thread TargetMarkers();
	level.ac130Player thread weaponChangeHUD();
	level.ac130Player thread overlay();
	level.ac130Player thread attachPlayer();
	level.ac130Player thread changeWeapons();
	level.ac130Player thread flytime();
	
	level.ac130Player thread onPlayerDeath();
	level.ac130Player thread onPlayerDisconnect();
	level.ac130Player thread onRoundEnd();
	level.ac130Player thread Ac130CheckDamage();

	level.ac130Player thread maps\mp\gametypes\_huds::HardpointLiveTimeHud(level.ktkWeapon["ac130"], level.ac130Alivetime, level.ac130Player);
	level.ac130marker = maps\mp\gametypes\_gameobjects::getNextObjID();

	//Sadly the game does not allow more than 15 elements on the minimap
	if(isDefined(level.ac130marker) && level.ac130marker <= 15)
	{
		Objective_Add(level.ac130marker, "active", level.ac130Player.origin);
		Objective_Icon( level.ac130marker, "waypoint_bomb" );
		Objective_OnEntity( level.ac130marker, level.ac130Player );
	}
	
	while(isDefined(level.ac130Player))
		wait .05;
		
	//Sadly the game does not allow more than 15 elements on the minimap
	if(isDefined(level.ac130marker) && level.ac130marker <= 15)
		Objective_Delete( level.ac130marker );
		
	level.ac130marker = undefined;
	
	if(isDefined(level.ac130PlaneModel))
		level.ac130PlaneModel delete();
}

Ac130CheckDamage()
{
	self endon("disconnect");
	self endon("death");
	
	level.ac130Trigger = spawn("trigger_radius", level.ac130Player.origin - (0,0,200), 0, 400, 400);
	level.ac130Trigger thread ForceOrigin(undefined, level.ac130Player);
	level.ac130Trigger setCanDamage(true);

	level.ac130Trigger.health = 3000;
	
	while(1)
	{
		level.ac130Trigger waittill("damage", amount, attacker, vDir, vPoint, sMeansOfDeath);

		if((isplayer(attacker) && attacker isInSameTeamAs(level.king)) || attacker isKing())
			continue;
		
		if(!isSubStr(sMeansOfDeath, "MOD_EXPLOSIVE") && !isSubStr(sMeansOfDeath, "MOD_PROJECTILE"))
			continue;
		
		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
		
		level.ac130Trigger.health -= amount;

		if(level.ac130Trigger.health <= 0)
		{
			attacker maps\mp\gametypes\_rank::giveRankXP("kill", 400);
			
			if(self isInAC130())
			{
				self thread detachPlayer();
				self thread destroyHUDs();
			}
			
			break;
		}
	}
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

attachPlayer()
{
	self endon("disconnect");
	self endon("death");

	helper = Spawn("script_model", level.mapCenter);
	radius = Distance(level.spawnMins, level.mapCenter);
	height = GetSkyHeight();
	
	if(radius > level.ac130FlyRadius)
		radius = level.ac130FlyRadius;
	
	self.godmode = true;
	
	self DetachAll();
	self setModel("fake_player"); //self hide();
	self setOrigin(helper.origin + (0,0,height) + AnglesToForward(helper.angles)*radius);
	self linkto(helper);	
	self enterAC130Plane(helper, height);
	
	while(self isInAC130())
	{
		helper RotateYaw(10, 1);
		wait 1;
	}
	
	if(isDefined(level.ac130PlaneModel))
		level.ac130PlaneModel delete();
	
	helper delete();
}

enterAC130Plane(helper, height)
{
	if(isDefined(level.ac130PlaneModel))
		level.ac130PlaneModel delete();

	level.ac130PlaneModel = spawn("script_model", level.mapCenter);
	
	if(height > 5000)
		level.ac130PlaneModel setModel("ac130miniplane_big");
	else if(height > 3000)
		level.ac130PlaneModel setModel("ac130miniplane_medium");
	else
		level.ac130PlaneModel setModel("ac130miniplane_small");
	
	level.ac130PlaneModel linkTo(helper, "", self.origin, (0,-90,30));
	level.ac130PlaneModel hide();

	for(i=0;i<level.players.size;i++)
	{
		if(self != level.players[i])
			level.ac130PlaneModel showToPlayer(level.players[i]);
	}
}

overlay()
{
	self endon("disconnect");
	self endon("death");

	//buggy sometimes - so i redefine it
	if(isDefined(self.ac130_hud)) self.ac130_hud destroy();
	if(isDefined(self.grain)) self.grain destroy();
	
	self.ac130_hud = newClientHudElem( self );
	self.ac130_hud.x = 0;
	self.ac130_hud.y = 0;
	self.ac130_hud.alignX = "center";
	self.ac130_hud.alignY = "middle";
	self.ac130_hud.horzAlign = "center";
	self.ac130_hud.vertAlign = "middle";
	self.ac130_hud.foreground = true;
	self.ac130_hud.hidewheninmenu = false;
	self.ac130_hud.alpha = 1;
	
	self.grain = newClientHudElem( self );
	self.grain.x = 0;
	self.grain.y = 0;
	self.grain.alignX = "left";
	self.grain.alignY = "top";
	self.grain.horzAlign = "fullscreen";
	self.grain.vertAlign = "fullscreen";
	self.grain.foreground = true;
	self.grain.alpha = 0.7;
	
	self.ac130_hud setshader ("ac130_overlay_105mm", 640, 480);
	self.grain setshader ("ac130_overlay_grain", 640, 480);
}

changeWeapons()
{
	self endon("disconnect");
	self endon("death");

	weapon = [];
	
	weapon[0] = spawnstruct();
	weapon[0].overlay = "ac130_overlay_105mm";
	weapon[0].fov = "1";
	weapon[0].name = "105mm";
	weapon[0].sound = "ac130_105mm_fire";
	weapon[0].weapon = "ac130_105mm_mp";
	
	weapon[1] = spawnstruct();
	weapon[1].overlay = "ac130_overlay_40mm";
	weapon[1].fov = "0.6";
	weapon[1].name = "40mm";
	weapon[1].sound = "ac130_40mm_fire";
	weapon[1].weapon = "ac130_40mm_mp";
	
	weapon[2] = spawnstruct();
	weapon[2].overlay = "ac130_overlay_25mm";
	weapon[2].fov = ".2";
	weapon[2].name = "25mm";
	weapon[2].sound = "ac130_25mm_fire";
	weapon[2].weapon = "ac130_25mm_mp";

	currentWeapon = 0;
	level.currentWeapon = weapon[currentWeapon];
	
	self thread check_firing();
	
	while(1)
	{
	wait 0.05;
	
		if(!isDefined(level.ac130Player))
			break;
			
		if(level.ac130Player != self)
			break;
	
		if(self useButtonPressed())
		{
			currentWeapon++;
			if (currentWeapon >= weapon.size)
				currentWeapon = 0;
			level.currentWeapon = weapon[currentWeapon];
			
			self.ac130_hud setShader (weapon[currentWeapon].overlay, 640, 480);
			self setClientDvar( "cg_fovScale", weapon[currentWeapon].fov );
			self takeAllWeapons();
			self giveWeapon( weapon[currentWeapon].weapon );
			wait .1;
			
			if(self isABot())
				self setSpawnWeapon(weapon[currentWeapon].weapon);
			else
				self SwitchToWeapon(weapon[currentWeapon].weapon);
			
			while(self useButtonPressed())
				wait 0.05;
		}
	}
}

check_firing()
{
	self endon("disconnect");
	self endon("death");
	
	while(self isInAC130())
	{
		self waittill("weapon_fired");
		
		if(isDefined(level.currentWeapon) && level.currentWeapon.weapon == "ac130_25mm_mp")
		{
			trace = BulletTrace( self getEye() + (0, 0, 20) , self GetEye()+(0,0,20)+AnglesToForward( self GetPlayerAngles() )*10000, false, self);
			target = trace["position"];
			PlayFX( level.effect["turret_dirt_impact"], target);
		}
	}
}

flytime()
{
	self endon("disconnect");
	self endon("death");

	alivetime = level.ac130Alivetime;

	for(i=0;i<alivetime;i++)
		wait 1;
		
	if(isDefined(level.ac130Player))
	{
		level.ac130Player thread destroyHUDs();
		level.ac130Player thread detachPlayer();
	}
}

detachPlayer()
{
	self endon("disconnect");
	self endon("death");

	level.ac130Player = undefined;
	
	if(isDefined(level.ac130PlaneModel))
		level.ac130PlaneModel delete();
	
	if(isDefined(level.ac130Trigger))
		level.ac130Trigger delete();
	
	if(self isKing() || self isTerminator())
		self maps\mp\gametypes\_bossmodels::SetBossModel();
	else
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();

	self.godmode = false;
	self.isatoldorigin = true;
	
	self unlink();
	self StopLoopSound();
	self TakeAllWeapons();
	self ReturnToOldPosition();
	self thread DeleteTargetMarkers();
	self thread ReturnStance();
	self setClientDvar("cg_fovScale", 1 + (self getKtkStat(2407)*0.001));
	self GiveInventory();
	self SwitchToPreviousWeapon();
}

destroyHUDs()
{
	self endon("disconnect");
	self endon("death");

	if(isDefined(self.ac130_hud)) self.ac130_hud destroy();
	if(isDefined(self.grain)) self.grain destroy();
	if(isDefined(self.changegun_hud)) self.changegun_hud destroy();
}

onPlayerDeath()
{
	self endon("disconnect");

	self waittill("death");

	self ExecClientCommand("-gostand");
	self thread DeleteTargetMarkers();
	self thread destroyHUDs();
	
	self setClientDvars("cg_fovScale", 1 + (self getKtkStat(2407)*0.001),
						"ui_hud_hardcore", 0);
	
	self.isatoldorigin = true;
	level.ac130Player = undefined;
	
	if(isDefined(level.ac130Trigger))
		level.ac130Trigger delete();
}

onPlayerDisconnect()
{
	self endon("death");

	self waittill("disconnect");

	level.ac130Player = undefined;
	
	if(isDefined(level.ac130Trigger))
		level.ac130Trigger delete();
}

onRoundEnd()
{
	self endon("disconnect");
	self endon("death");

	while(level.roundstarted)
		wait 1;
	
	if(!isDefined(level.ac130Player) || level.ac130Player != self)
		return;
	
	if(self isKing() || self isTerminator())
		self maps\mp\gametypes\_bossmodels::SetBossModel();
	else
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] ); //self show();

	self.godmode = false;
	self.isatoldorigin = true;
		
	self show();
	self unlink();
	self ReturnToOldPosition();
	self thread ReturnStance();
	
	self thread destroyHUDs();
	self setClientDvars("cg_fovScale", 1 + (self getKtkStat(2407)*0.001),
						"ui_hud_hardcore", 0);
	
	level.ac130Player = undefined;
	
	if(isDefined(level.ac130Trigger))
		level.ac130Trigger delete();
}

weaponChangeHUD()
{
	self endon("disconnect");
	self endon("death");

	if(isDefined(self.changegun_hud)) self.changegun_hud destroy();
	
	self.changegun_hud = newClientHudElem( self );
	self.changegun_hud.fontScale = 1.4;
	self.changegun_hud.horzAlign = "center";
	self.changegun_hud.vertAlign = "middle";
	self.changegun_hud.alignX = "center";
	self.changegun_hud.alignY = "middle";
	self.changegun_hud.x = 0;
	self.changegun_hud.y = 100;
	self.changegun_hud.alpha = 0.75;
	self.changegun_hud.sort = 1001;
	self.changegun_hud.hidewheninmenu = false;
	self.changegun_hud.label = self GetLocalizedString("WEAPONCHANGE_PRESS_USE");
}