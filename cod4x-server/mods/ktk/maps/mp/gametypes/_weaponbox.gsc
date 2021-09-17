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
	if(getDvar("scr_mod_weaponbox") == "") setDvar("scr_mod_weaponbox", 1);
	if(getDvar("scr_mod_weaponbox_priceGuards") == "") setDvar("scr_mod_weaponbox_priceGuards", 50);
	if(getDvar("scr_mod_weaponbox_priceAssassins") == "") setDvar("scr_mod_weaponbox_priceAssassins", 50);
	if(getDvar("scr_mod_weaponbox_weapon_1") == "" || getDvar("scr_mod_weaponbox_assassinweapon_1") == "") setDvar("scr_mod_weaponbox", 0);
	if(getDvar("scr_mod_weaponbox_picktime") == "" || getDvarFloat("scr_mod_weaponbox_picktime") < 1) setDvar("scr_mod_weaponbox_picktime", 1);
	
	level.weaponboxPriceGuards = getDvarInt("scr_mod_weaponbox_priceGuards");
	level.weaponboxPriceAssassins = getDvarInt("scr_mod_weaponbox_priceAssassins");
	level.weaponboxPickTime = getDvarFloat("scr_mod_weaponbox_picktime");
	
	weaponbox = getEntArray( "bombzone", "targetname" );
	
	if(game["customEvent"] == "sniperonly" || game["customEvent"] == "knifeonly" || game["customEvent"] == "hideandseek")
		return;
	
	if(getDvarInt("scr_mod_weaponbox") > 0 && isDefined(weaponbox))
	{
		thread SpawnRandomWeaponBox();
		thread initRandomWeaponsGuards();
		thread initRandomWeaponsAssassins();
	}
}

initRandomWeaponsGuards()
{
	level.BoxGuardWeapons = [];

	for(index=1;getDvar("scr_mod_weaponbox_weapon_" + index) != "";index++)
	{
		level.BoxGuardWeapons[index-1] = getDvar("scr_mod_weaponbox_weapon_" + index);
		
		if(level.BoxGuardWeapons[index-1] == level.ktkWeapon["syrette"])
			level.BoxGuardWeapons[index-1] = "flash_grenade_mp";
			
		if(getSubStr(level.BoxGuardWeapons[index-1], level.BoxGuardWeapons[index-1].size-3, level.BoxGuardWeapons[index-1].size) == "_mp")
			precacheItem(level.BoxGuardWeapons[index-1]);
	}
}

initRandomWeaponsAssassins()
{
	level.BoxAssassinWeapons = [];

	for(index=1; getDvar("scr_mod_weaponbox_assassinweapon_" + index) != ""; index++)
	{
		level.BoxAssassinWeapons[index-1] = getDvar("scr_mod_weaponbox_assassinweapon_" + index);
		
		if(level.BoxAssassinWeapons[index-1] == level.ktkWeapon["syrette"])
			level.BoxAssassinWeapons[index-1] = "flash_grenade_mp";
			
		if(getSubStr(level.BoxAssassinWeapons[index-1], level.BoxAssassinWeapons[index-1].size-3, level.BoxAssassinWeapons[index-1].size) == "_mp")
			precacheItem(level.BoxAssassinWeapons[index-1]);
	}
}

SpawnRandomWeaponBox()
{
	weaponbox = getEntArray( "bombzone", "targetname" );

	if(isDefined(weaponbox))
	{
		for(i=0;i<weaponbox.size;i++)
		{
		wait .1;
			trigger = weaponbox[i];
			visuals = getEntArray( weaponbox[i].target, "targetname" );
			
			BoxObject = maps\mp\gametypes\_gameobjects::createUseObject( game["defenders"], trigger, visuals, (0,0,64) );
			BoxObject maps\mp\gametypes\_gameobjects::setModelVisibility( true );
			BoxObject maps\mp\gametypes\_gameobjects::enableObject();
			BoxObject maps\mp\gametypes\_gameobjects::allowUse( "any" );
			BoxObject maps\mp\gametypes\_gameobjects::setUseTime( level.weaponboxPickTime );
			BoxObject maps\mp\gametypes\_gameobjects::setUseText( "" );
			BoxObject maps\mp\gametypes\_gameobjects::setUseHintText( "" );
			BoxObject maps\mp\gametypes\_gameobjects::setVisibleTeam( "any" );
			BoxObject maps\mp\gametypes\_gameobjects::set2DIcon( "friendly", "compass_waypoint_captureneutral" );
			BoxObject maps\mp\gametypes\_gameobjects::set3DIcon( "friendly", "waypoint_targetneutral" );
			BoxObject maps\mp\gametypes\_gameobjects::set2DIcon( "enemy", "compass_waypoint_captureneutral" );
			BoxObject maps\mp\gametypes\_gameobjects::set3DIcon( "enemy", "waypoint_targetneutral" );
			BoxObject.onBeginUse = ::onBeginUse;
			BoxObject.onUse = ::onUse;
			
			BoxObject thread monitorhintHUD();
		}
	}
}

monitorhintHUD()
{
	level endon("game_ended");
	self endon("death");
	
	while(1)
	{
		for(i=0;i<level.players.size;i++)
		{
			if(level.players[i] isTouching(self.trigger))
			{
				if(!level.players[i] isReviving() && !level.players[i] isInRCToy() && !level.players[i] isDog() && !level.players[i] isABot())
					level.players[i] thread showUseHintMessage(self.trigger);
			}
		}
		
		wait .1;
	}
}

showUseHintMessage(trigger)
{
	self endon("disconnect");

	if(isDefined(self.useHintText))
		return;

	self.useHintText = NewClientHudElem(self);
	self.useHintText.alignX = "center";
	self.useHintText.alignY = "middle";
	self.useHintText.horzalign = "center";
	self.useHintText.vertalign = "middle";
	self.useHintText.sort = 1;
	self.useHintText.alpha = 1;
	self.useHintText.x = -2;
	self.useHintText.y = 60;
	self.useHintText.font = "default";
	self.useHintText.fontscale = 1.44;
	self.useHintText.archived = false;
	self.useHintText.hidewheninmenu = true;
	self.useHintText.label = self GetLocalizedString("BOX_PRESS_USE");
	
	while(1)
	{
		if(!isAlive(self) || !self isTouching(trigger) || !isDefined(self.useHintText))
			break;
	
		self.useHintText MoveOverTime(0.5);
		self.useHintText.x = 2;
	
		wait 0.5;

		if(!isAlive(self) || !self isTouching(trigger) || !isDefined(self.useHintText))
			break;

		self.useHintText MoveOverTime(0.5);
		self.useHintText.x = -2;
	
		wait 0.5;
	}
		
	self.useHintText destroy();
}

onBeginUse(player)
{
	if(!player isReviving() && !player isInRCToy() && !player isDog() && !player isABot())
	{
		player.isBuyingWeapon = true;
		player playSound("mp_bomb_plant");
	}
}

onEndUse(team, player, success)
{
	player.isBuyingWeapon = false;
}

onUse( player )
{
	if(isDefined(player.pers["actionslot"][3]["weapon"]) && player.pers["actionslot"][3]["weapon"] == player getCurrentWeapon())
	{
		scr_iPrintLnBold("PLAYER_SIDEARM_NO_REPLACE", player);
		return;
	}

	if(!player isReviving() && !player isInRCToy() && !player isDog())
	{
		if(isDefined(player.pers["vip"]) && player.pers["vip"])
		{
			if(player isAGuard())
			{
				if(player.pers["score"] >= int(level.weaponboxPriceGuards*0.75))
					player GiveItem(int(level.weaponboxPriceGuards*0.75));
				else
					scr_iPrintLnBold("BOX_PICK", player, int(level.weaponboxPriceGuards*0.75));
			}
			else
			{
				if(player.pers["score"] >= int(level.weaponboxPriceAssassins*0.75))
					player GiveItem(int(level.weaponboxPriceAssassins*0.75));
				else
					scr_iPrintLnBold("BOX_PICK", player, int(level.weaponboxPriceAssassins*0.75));
			}
		}
		else if((!isDefined(player.pers["vip"]) || !player.pers["vip"]))
		{
			if(player isAGuard())
			{
				if(player.pers["score"] >= level.weaponboxPriceGuards)
					player GiveItem(level.weaponboxPriceGuards);
				else
					scr_iPrintLnBold("BOX_PICK", player, level.weaponboxPriceGuards);
			}
			else
			{
				if(player.pers["score"] >= level.weaponboxPriceAssassins)
					player GiveItem(level.weaponboxPriceAssassins);
				else
					scr_iPrintLnBold("BOX_PICK", player, level.weaponboxPriceAssassins);			
			}
		}
		
		player notify("update_playerscore_hud");
	}
}

GiveItem(price)
{
	self endon("death");
	self endon("disconnect");

	self.pers["score"] -= price;
	
	current = self GetCurrentWeapon();

	if(self isAGuard() || game["customEvent"] == "kingvsking" || game["customEvent"] == "lastkingstanding" || game["customEvent"] == "traitors")
	{
		weapon = level.BoxGuardWeapons[randomint(level.BoxGuardWeapons.size)];
	
		while(self HasWeapon(weapon) || (isHardpoint(weapon) && (self HasFreeHardpointSlots() <= 0 || isDisabledHardpoint(weapon))))
			weapon = level.BoxGuardWeapons[randomint(level.BoxGuardWeapons.size)];
	}
	else
	{
		weapon = level.BoxAssassinWeapons[randomint(level.BoxAssassinWeapons.size)];
	
		while(self HasWeapon(weapon) || (isHardpoint(weapon) && (self HasFreeHardpointSlots() <= 0 || isDisabledHardpoint(weapon))))
			weapon = level.BoxAssassinWeapons[randomint(level.BoxAssassinWeapons.size)];
	}

	if(weapon == "javelin" || weapon == level.ktkWeapon["javelin"])
	{
		self maps\mp\gametypes\_weaponloadouts::LoadOutExplosive(level.ktkWeapon["javelin"], 0);
		scr_iPrintLnBold("BOX_JAVELIN_PICKUP", self);
	}
	else if(weapon == "tripwire" || weapon == "tripwire_mp")
	{
		scr_iPrintLnBold("BOX_TRIP", self);
		self.pers["hastripwires"]++;
	}
	else if(isHardpoint(weapon) || weapon == "napalm_mp")
	{
		if(self isKing())
		{
			if(weapon == "helicopter_mp")
				weapon = "airstrike_mp";
			else if(weapon == "skorpion_acog_mp_mp")
				weapon = level.ktkWeapon["mortars"];
		}
		if(weapon == level.ktkWeapon["rccar"])
			scr_iPrintLnBold("BOX_RCXD", self);
		else
			scr_iPrintLnBold("AIRSUPPORT", self);
		
		if(weapon == "napalm_mp")
			weapon = "airstrike_mp";
		
		self SetHardpointToSlot("weapon", weapon, true);
	}
	else if(isAGrenade(weapon) || weapon == level.ktkWeapon["syrette"])
	{
		if(weapon == level.ktkWeapon["syrette"])
			weapon = level.ktkWeapon["throwingKnife"];
		
		if(weapon == level.ktkWeapon["throwingKnife"] || weapon == "frag_grenade_short_mp")
		{
			if(weapon == "frag_grenade_short_mp")
				scr_iPrintLnBold("BOX_NADES", self);
			else
				scr_iPrintLnBold("BOX_KNIVES", self);
		
			self giveWeapon( weapon );
			self setWeaponAmmoClip( weapon, 3 );
			self switchToOffhand( weapon );
		}
		else 
		{
			if(weapon == level.ktkWeapon["poisongas"])
			{
				scr_iPrintLnBold("BOX_POISON", self);
				self setOffhandSecondaryClass("smoke");
			}
			else
			{
				scr_iPrintLnBold("BOX_FLASH", self);
				self setOffhandSecondaryClass("flash");
			}
			
			self giveWeapon( weapon );
			self setWeaponAmmoClip( weapon, 3 );
		}
	}
	else if(isOtherExplosive(weapon))
	{
		scr_iPrintLnBold("BOX_EXPLOSIVE", self);
		
		self giveWeapon( weapon );
		self setWeaponAmmoClip(weapon, 1);
		self setWeaponToSlot(weapon);
		self setweaponammostock(weapon, 2);
	}
	else
	{
		if(self CountPrimaryWeapons() >= 2)
			self TakeWeapon(current);
		
		if(isSubStr(weapon, "_gl_mp") && getDvarInt("scr_mod_grenadelauncher") == 1)
			self SetActionSlot(3, "altmode");	
		
		self GiveWeapon(weapon);
		self GiveMaxAmmo(weapon);
		wait .1;
		self SwitchToWeapon(weapon);
	}
}