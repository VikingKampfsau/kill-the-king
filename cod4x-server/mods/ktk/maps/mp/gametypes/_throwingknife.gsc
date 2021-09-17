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
// Original script attached on the bottom.
// Script used for the mod completely rewritten myself!

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_misc;

init()
{
	if(getDvar("scr_mod_throwknife_alivetime") == "") setDvar("scr_mod_throwknife_alivetime", 0);
	if(getDvar("scr_mod_throwknife_damage") == "") setDvar("scr_mod_throwknife_damage", 100);
	if(getdvar("player_throwbackOuterRadius") != "70") setDvar("player_throwbackOuterRadius", 70 );
	if(getdvar("player_throwbackInnerRadius") != "70") setDvar("player_throwbackInnerRadius", 70 );

	level.knifeAlivetime = getDvarInt("scr_mod_throwknife_alivetime");
	level.knifepickupradius = getDvarInt("player_throwbackOuterRadius");
	level.knifedamage = getDvarInt("scr_mod_throwknife_damage");
	level.katanadamage = getDvarInt("scr_mod_katana_damage");
}

CheckForKnifeThrow()
{
	self endon("disconnect");
	self endon("death");

	self.UnusedNades = 0;
	
	while(1)
	{
		self waittill("grenade_fire", grenade, weaponName);
		
		if(isDefined(grenade))
		{
			grenade.HeliAttacker = self;
			grenade.usedWeapon = weaponName;
			grenade.HeliDamage = 300;

			if(weaponName == level.ktkWeapon["crossbowExp"])
				grenade.HeliDamage = getDvarInt("scr_mod_expbolt_damage");
			else if(weaponName == level.ktkWeapon["throwingKnife"])
			{
				grenade.HeliDamage = getDvarInt("scr_mod_throwknife_damage");
			
				grenade thread CheckForPickUp();

				if(self GetWeaponAmmoClip(level.ktkWeapon["throwingKnife"]) <= 0)
				{
					self TakeWeapon(level.ktkWeapon["throwingKnife"]);
				
					if(isDefined(self.UnusedNades) && self.UnusedNades > 0)
					{
						self GiveWeapon("frag_grenade_short_mp");
						self setWeaponAmmoClip("frag_grenade_short_mp", self.UnusedNades);
						self switchToOffhand("frag_grenade_short_mp");
					}
				}
			}
		}
	}
}

CheckForPickUp()
{
	self endon("death");

	self waitTillNotMoving();
	
	self.trigger = spawn("trigger_radius", self.origin - (0,0,level.knifepickupradius/2), 0, level.knifepickupradius, level.knifepickupradius);
	self thread DeleteAfterTime();
	
	while(isDefined(self.trigger))
	{
		self.trigger waittill("trigger", player);

		if(player isReviving() || player isInRCToy() || player isDog())
			continue;

		if(isDefined(player.lowerMessage))
		{
			player.lowerMessage.label = player GetLocalizedString("THROWBACKGRENADE");
			player.lowerMessage.alpha = 1;
			player.lowerMessage FadeOverTime(0.05);
			player.lowerMessage.alpha = 0;
		}

		if(player UseButtonPressed())
		{
			if(player hasWeapon(level.ktkWeapon["throwingKnife"]))
			{
				player setWeaponAmmoClip(level.ktkWeapon["throwingKnife"], player getWeaponAmmoClip(level.ktkWeapon["throwingKnife"]) + 1);
				break;
			}
			else
			{
				if(player hasWeapon("frag_grenade_short_mp"))
					player.UnusedNades = player GetWeaponAmmoClip("frag_grenade_short_mp");
			
				player TakeWeapon("frag_grenade_short_mp");
				player GiveWeapon(level.ktkWeapon["throwingKnife"]);
				player setWeaponAmmoClip(level.ktkWeapon["throwingKnife"], 1);
				player switchToOffhand(level.ktkWeapon["throwingKnife"]);
				break;
			}
		}
	}

	if(isDefined(self.trigger))
		self.trigger delete();

	if(isDefined(self))
		self delete();
}

DeleteAfterTime()
{
	self endon("death");
	
	self thread DeleteWhenNoTrigger();
	
	if(level.knifeAlivetime > 0)
	{
		for(i=0;i<level.knifeAlivetime;i++)
			wait 1;
			
		if(isDefined(self.trigger))
			self.trigger delete();
			
		if(isDefined(self))
			self delete();
	}
}

DeleteWhenNoTrigger()
{
	self endon("death");
	
	while(isDefined(self.trigger))
		wait .05;
		
	if(isDefined(self))
		self delete();
}

// KKKKKKKKK    KKKKKKK  iiii  kkkkkkkk             iiii    
// K:::::::K    K:::::K i::::i k::::::k            i::::i  
// K:::::::K    K:::::K  iiii  k::::::k             iiii   
// K:::::::K   K::::::K        k::::::k                    
// KK::::::K  K:::::KKKiiiiiii  k:::::k    kkkkkkkiiiiiii  
//   K:::::K K:::::K   i:::::i  k:::::k   k:::::k i:::::i  
//   K::::::K:::::K     i::::i  k:::::k  k:::::k   i::::i  
//   K:::::::::::K      i::::i  k:::::k k:::::k    i::::i   
//   K:::::::::::K      i::::i  k::::::k:::::k     i::::i  
//   K::::::K:::::K     i::::i  k:::::::::::k      i::::i  
//   K:::::K K:::::K    i::::i  k:::::::::::k      i::::i  
// KK::::::K  K:::::KKK i::::i  k::::::k:::::k     i::::i  
// K:::::::K   K::::::Ki::::::ik::::::k k:::::k   i::::::i 
// K:::::::K    K:::::Ki::::::ik::::::k  k:::::k  i::::::i 
// K:::::::K    K:::::Ki::::::ik::::::k   k:::::k i::::::i 
// KKKKKKKKK    KKKKKKKiiiiiiiikkkkkkkk    kkkkkkkiiiiiiii 
// 

/* IF you dont want to display grenade throwback notifications
EDIT _weapons.gsc :

watchForThrowbacks()
{
	self endon ( "death" );
	self endon ( "disconnect" );
	
	for ( ;; )
	{
		self waittill ( "grenade_fire", grenade, weapname );
		if ( self.gotPullbackNotify )
		{
			self.gotPullbackNotify = false;
			continue;
		}
		if ( !isSubStr( weapname, "frag_" ) )
			continue;
		
		// no grenade_pullback notify! we must have picked it up off the ground.
		grenade.threwBack = true;
		
		grenade thread maps\mp\gametypes\_shellshock::grenade_earthQuake();
		grenade.originalOwner = self;
	}
}*/

/*
#include maps\mp\_utility;
#include common_scripts\utility;

init()
{
	game["tknife_pickup_hint"] = &"MPUI_TKNIFE_HINT";
	precacheString( game["tknife_pickup_hint"] );

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);

		player thread onPlayerSpawned();
		player thread onPlayerKilled();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");

		if (self hasWeapon( level.ktkWeapon["throwingKnife"] )) {
			self.hadthrowingknife = true;
			self thread checkthrowingknifeUtilization();
		} else {
			self.hadthrowingknife = false;
		}
	}
}

onPlayerKilled()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("killed_player");

		if ( isDefined( self.checkRetrieve ) )
			self.checkRetrieving = false;

	}
}

checkthrowingknifeUtilization()
{
	self endon("disconnect");
	self endon("killed_player");

	for (;;)
	{
		self waittill("grenade_fire", Knife, weaponName);
		if ( weaponName == level.ktkWeapon["throwingKnife"] ) {
			knife.weaponName = weaponName;
			knife thread throwingknifeMonitor();
		}
	}
}

throwingknifeMonitor()
{
	self endon( "death" );

	self maps\mp\gametypes\_weapons::waitTillNotMoving();

	if ( isDefined( self ) ) {
		self.triggerRadius = spawn( "trigger_radius", self.origin + ( 0, 0, -40 ), 0, 35, 80 );
		self thread deleteTriggerOnDeath();

		for (;;)
		{
			wait (0.05);

			self.triggerRadius waittill("trigger", player);

			if ( !isDefined( player.checkRetrieving ) || !player.checkRetrieving ) {
				player thread checkForRetrieving( self );
			}
		}
	}
}


deleteTriggerOnDeath()
{
	self waittill("death");

	self.triggerRadius delete();
}


checkForRetrieving( knife )
{
	self endon("disconnect");
	self endon("death");

	self.checkRetrieving = true;
	throwingknifeRetrieved = false;

	while ( !throwingknifeRetrieved && isDefined( knife.triggerRadius ) && self isTouching( knife.triggerRadius ) ) {
		// Just a wait so the thread doesn't kill the game
		wait (0.05);


		self createHudTextElement( "tknife_pickup_hint", 0, 30, "center", "middle", "center_safearea", "center_safearea", false, 1, .7, 1, 1, 1, 1.4, game["tknife_pickup_hint"] );


		while ( !throwingknifeRetrieved && isDefined( knife.triggerRadius ) && self isTouching( knife.triggerRadius ) && ( self UseButtonPressed() || level.inTimeoutPeriod ) && isDefined( knife ) && self IsLookingAt( knife )  && ( !isDefined( self.isPlanting ) || !self.isPlanting ) && ( !isDefined( self.isDefusing ) || !self.isDefusing ) ) {

				self thread maps\mp\gametypes\_gameobjects::_disableWeapon();

				if ( self.hadthrowingknife ) {

					ammoCount = self getWeaponAmmoStock( knife.weaponName );
					if ( ammoCount == 0 ) {

						self giveWeapon( knife.weaponName );
						self setWeaponAmmoClip( knife.weaponName, 1 );
					}

					maxAmmo = weaponMaxAmmo( knife.weaponName );
					if ( ammoCount < maxAmmo ) {

						self setWeaponAmmoClip( knife.weaponName, ammoCount + 1 );
					}
				}

				if ( isDefined( knife ) ) {
					knife delete();
					throwingknifeRetrieved = true;

					wait (0.5);

					self thread maps\mp\gametypes\_gameobjects::_enableWeapon();

				}
			
		}
	}

	self.checkRetrieving = false;

	self deleteHudTextElementbyName( "tknife_pickup_hint" );

}


createHudTextElement( hud_text_name, x, y, xAlign, yAlign, horzAlign, vertAlign, foreground, sort, alpha, color_r, color_g, color_b, size, text ) 
{
	if( !isDefined( self.txt_hud ) ) self.txt_hud = [];
	
	count = self.txt_hud.size;

	self.txt_hud[count] = newClientHudElem( self );
	self.txt_hud[count].name = hud_text_name;
	self.txt_hud[count].x = x;
	self.txt_hud[count].y = y;
	self.txt_hud[count].alignX = xAlign;
	self.txt_hud[count].alignY = yAlign;
	self.txt_hud[count].horzAlign = horzAlign;
	self.txt_hud[count].vertAlign = vertAlign;
	self.txt_hud[count].foreground = foreground;	
	self.txt_hud[count].sort = sort;
	self.txt_hud[count].color = ( color_r, color_g, color_b );
	self.txt_hud[count].hideWhenInMenu = true;
	self.txt_hud[count].alpha = alpha;
	self.txt_hud[count].fontScale = size;
	self.txt_hud[count].font = "objective";
	self.txt_hud[count] setText( text );
}


deleteHudTextElementbyName( hud_text_name )
{
	if( isDefined( self.txt_hud ) && self.txt_hud.size > 0 ) 
	{
		for(i=0; i<self.txt_hud.size; i++ ) 
		{
			if( isDefined( self.txt_hud[i].name ) && self.txt_hud[i].name == hud_text_name ) 
			{
				self.txt_hud[i] destroy();
				self.txt_hud[i].name = undefined;
			}
		}	
	}
}*/