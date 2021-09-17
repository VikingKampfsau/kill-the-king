/*	      _ _ _ _ _ _ _ _ 				  _ _ _ _ _ _
	    /_ _ _     _ _ _/_ _     _ _    _ _ _ _ _    /    _ _    \    _ _ _ _ _    _ _ _ _ _ _    _ _ _ _ _ 
	          /  /      /  /    /  /  /   _ _ _ /   /   /_ _ /   |   /   _ _ _ /  /    _ _    /  /    _ _   \
	         /  /	   /  /	   /  /  /   /_ _ _    /          _ /   /   /_ _ _   /   /_ _/   /  /   /_ _/   /
	        /  /	  /  /_ _ /  /  /    _ _ _/   /    _ _    \    /    _ _ _/  /   _ _     /  /   _ _     /
   _ _ _ _ _   /  /	 /   _ _    /  /   / _ _ _   /   /_ _ /    |  /   / _ _ _  /   /   /   /  /   /   \   \     _ _ _ _ _
 /_ _ _ _ _/  /__/      /_ /    /_ /  /_ _ _ _ _ /  / _ _ _ _ _ _ /  /_ _ _ _ _ / /_ _/   /_ _/  /_ _/     \_ _\  /_ _ _ _ _/
 
							2 0 1 2

				    ////////////////////////////////////////////////
				    ////////////////////////////////////////////////
				    //					          //
				    //	Minigun by _TheBear_           	   	  //
				    //						  //
				    //  Xfire: 5f546865426561725f	          //				   
				    //	Steam: _TheBear_		          //
				    //	E-Mail: pc_bear@hotmail.fi	          //
				    //					          //
				    ////////////////////////////////////////////////
				    //////////////////////////////////////////////*/

#include maps\mp\gametypes\_misc;

init()
{
	precacheShader( "reticle_minigun" );
	precacheShader( "hud_icon_minigun" );
	precacheShader( "mtl_main_minigun_carry" );
	precacheShader( "mtl_main_minigun_carry_decal" );
	precacheShader( "mtl_weapon_ammo_chute" );
	precacheShader( "mtl_weapon_minigun_bullets" );
	precacheShader( "hud_temperature_gauge" );
	
	precacheModel( "viewmodel_bear_minigun" );
	precacheModel( "weapon_bear_minigun" );
	
	precacheItem( level.ktkWeapon["minigun"]  );
	
	precacheShellshock( "minigun" );
	
	level.MinHeat = getDvarInt("scr_mod_minigun_minheat");
	level.MaxHeat = getDvarInt("scr_mod_minigun_maxheat");
	level.OverheatRate = getDvarFloat("scr_mod_minigun_overheatrate");
	level.CooldownRate = getDvarFloat("scr_mod_minigun_cooldownrate");

	level._effect["turret_overheat_smoke"] = loadfx("distortion/armored_car_overheat");
}

MinigunOnPlayerSpawned()
{
	self endon("disconnect");
	
	self.overheat = 1;
	self.cooldown = false;
		
	self thread watchWeaponChange();
	self thread onPlayerDeath();
}

onPlayerDeath()
{
	self endon("disconnect");
	self waittill("death");

	if( isDefined( self.minigunAmmo ) )
		self.minigunAmmo destroy();

	if(isdefined(self.overheat_hud_bg))
		self.overheat_hud_bg destroy();

	if(isdefined(self.overheat_hud_status))
		self.overheat_hud_status destroy();

	if(isDefined(self.overheateffect))
		self.overheateffect delete();
}

watchWeaponChange()
{
	self endon( "disconnect" );
	self endon( "death" );
	
	if(getDvarInt("scr_mod_minigun_overheat") == 1)
		self thread minigunOverheating();
	
	while( 1 )
	{
		oldWeapon = self getCurrentWeapon();
		self waittill( "weapon_change", newWeapon );
		
		if(self isDog())
			continue;
		
		if( newWeapon == level.ktkWeapon["minigun"]  && oldWeapon != level.ktkWeapon["minigun"]  )
		{
			self.overheateffect = spawn("script_model", (0,0,0));
			self.overheateffect setmodel("tag_origin");
			self.overheateffect.origin = self.origin;
			self.overheateffect.angles = self.angles;
			self.overheateffect linkto(self, "tag_weapon_right", (12,0,0), (0,0,0));
		
			self thread minigunAmmoCounter();
			self thread minigunShellshock();
			
			if(getDvarInt("scr_mod_minigun_overheat") == 1)
				self thread minigunOverheatHud();
			
			self minigunAsCurrentWeapon();
				
			self notify( "end_minigun_ammo_watch" );
			self notify( "end_minigun_shellshock" );
			
			if( isDefined( self.minigunAmmo ) )
				self.minigunAmmo destroy();

			if(isdefined(self.overheat_hud_bg))
				self.overheat_hud_bg destroy();

			if(isdefined(self.overheat_hud_status))
				self.overheat_hud_status destroy();
				
			if(isDefined(self.overheateffect))
				self.overheateffect delete();
		}
	}
}

minigunAsCurrentWeapon()
{
	self endon( "disconnect" );
	self endon( "death" );
	
	while( self getCurrentWeapon() == level.ktkWeapon["minigun"]  )
		wait( 0.05 );
}

minigunAmmoCounter()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "end_minigun_ammo_watch" );
	
	// DISPLAY MINIGUN AMMO ON THE BOTTOM OF THE SCREEN
	// BECAUSE MINIGUN MAX AMMO IS 999 AND LOOKS STUPID
	// IF IT'S DISPLAYED AS BELTFED AMMO :/
	
	if(self isABot())
		return;
	
	if(isDefined(self.minigunAmmo))
		self.minigunAmmo destroy();
		
	self.minigunAmmo =  NewClientHudElem( self );
	self.minigunAmmo.font = "objective";
	self.minigunAmmo.alignX = "right";
	self.minigunAmmo.alignY = "bottom";
	self.minigunAmmo.horzAlign = "right";
	self.minigunAmmo.vertAlign = "bottom";
	self.minigunAmmo.x = -14;
	self.minigunAmmo.y = -14;
	self.minigunAmmo.archived = true;
	self.minigunAmmo.fontScale = 1.4;
	self.minigunAmmo.glowColor = ( 1, 0, 0 );
	self.minigunAmmo.glowAlpha = 1;
	self.minigunAmmo.foreground = true;
	self.minigunAmmo.hidewheninmenu = true;
	self.minigunAmmo setValue( self getWeaponAmmoClip( level.ktkWeapon["minigun"]  ) );
	
	self.minigunAmmo.alpha = self getKtkStat(2402);
	
	while( 1 )
	{
		//Hide Hud when AmmoCounter is numerical - by Viking
		if(self getKtkStat(2402) == 1 && self.minigunAmmo.alpha != 0)
		{
			self setClientDvar("ammoCounterHide", 0);
			self.minigunAmmo.alpha = 0;
		}
		else if(self getKtkStat(2402) == 0 && self.minigunAmmo.alpha != 1)
		{
			self setClientDvar("ammoCounterHide", 1);
			self.minigunAmmo.alpha = 1;
		}
	
		self.minigunAmmo setValue( self getWeaponAmmoClip( level.ktkWeapon["minigun"]  ) );
		wait( 0.05 );
	}
}

minigunShellshock()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "end_minigun_shellshock" );
	
	// SHELLSHOCK WILL FIX THE 3RD PERSON ANIMATIONS ( INFINITE LOOP )
	// WHEN SWITCHING WEAPONS / THROWING GRENADES PLAYER MODEL WILL FREEZE
	// THIS SCRIPT FIXES IT AS THE SHELLSHOCK ANIM FOR MINIGUN IS SAME AS THE FIRE ANIM
	
	while( 1 )
	{	
		self shellshock( "minigun", 0.05 );
		wait( 0.05 );
	}
}

//Following additions by Viking
minigunOverheating()
{
	self endon("disconnect");
	self endon("death");

	//doesnt work for bots
	if(self isABot())
		return;
	
	increment = 0;
	iPercentage = 0;

	newColor = [];
	color_cold = (1.0, 0.9, 0.0);
	color_warm = (1.0, 0.5, 0.0);
	color_hot = (0.9, 0.16, 0.0);
	
	remainingClipSize = 0;
	
	while(1)
	{
		if(self GetCurrentWeapon() == level.ktkWeapon["minigun"]  && (self getWeaponAmmoClip(level.ktkWeapon["minigun"]) > 0 || remainingClipSize > 0))
		{
			if(self AttackButtonPressed() && self getWeaponAmmoClip(level.ktkWeapon["minigun"]) > 0)
			{
				if(self.overheat < level.MaxHeat && !self.cooldown)
					self.overheat += level.CooldownRate + level.OverheatRate;
				else
				{
					//self ExecClientCommand("-attack");
					self.cooldown = true;
					
					remainingClipSize = self getWeaponAmmoClip(level.ktkWeapon["minigun"]);
					self setWeaponAmmoStock(level.ktkWeapon["minigun"], remainingClipSize);
					self setWeaponAmmoClip(level.ktkWeapon["minigun"], 0);
				}
			}
			
			if(self.cooldown)
			{
				if(isDefined(self.overheateffect))
					PlayFxOnTag(level._effect["turret_overheat_smoke"], self.overheateffect, "tag_origin");	
			}
		}
		
		if(self.cooldown)
		{
			if(self.overheat < level.MinHeat)
			{
				self.cooldown = false;
				self setWeaponAmmoStock(level.ktkWeapon["minigun"], 0);
				self setWeaponAmmoClip(level.ktkWeapon["minigun"], remainingClipSize);
			}
		}

		if(isDefined(self.overheat))
		{
			if(self.overheat > 0)
			{
				self.overheat -= level.CooldownRate;
			
				if(self.overheat <= 0)
					self.overheat = 0;
			
				iPercentage = int(self.overheat/level.MaxHeat*100);
				
				for(i=0;i<3;i++)
				{
					//cold
					if(iPercentage <= 40)
					{
						increment = (color_warm[i]-color_cold[i])/100;
						newColor[i] = color_cold[i]+(increment*iPercentage);
					}
					//warm
					else if(iPercentage > 40 && iPercentage <= 80)
					{
						increment = (color_hot[i]-color_warm[i])/100;
						newColor[i] = color_warm[i]+(increment*iPercentage);
					}
					//hot
					else
					{
						newColor[i] = color_hot[i];
					}
				}

				
				if(isDefined(self.overheat_hud_status))
				{
					self.overheat_hud_status.alpha = 0.8;
					self.overheat_hud_status.color = (newColor[0], newColor[1], newColor[2]);
					
					newScale = int((150 - int(4 + abs(self.overheat_hud_bg.y - self.overheat_hud_status.y))) / level.MaxHeat * self.overheat);
					
					if(newScale <= 0)
						newScale = 1;
					
					self.overheat_hud_status ScaleOverTime( 0.05, 10, newScale);
				}
			}
		}

	wait .05;
	}
}

MinigunOverheatHud()
{
	self endon("disconnect");
	self endon("death");

	if(!isdefined(self.overheat_hud_bg))
	{
		self.overheat_hud_bg = newClientHudElem(self);
		self.overheat_hud_bg.alignX = "right";
		self.overheat_hud_bg.alignY = "bottom";
		self.overheat_hud_bg.horzAlign = "right";
		self.overheat_hud_bg.vertAlign = "bottom";
		self.overheat_hud_bg.x = 2;
		self.overheat_hud_bg.y = -120;
		self.overheat_hud_bg setShader("hud_temperature_gauge", 35, 150);
	}
	
	if(!isdefined(self.overheat_hud_status))
	{
		self.overheat_hud_status = newClientHudElem(self);
		self.overheat_hud_status.alignX = "right";
		self.overheat_hud_status.alignY = "bottom";
		self.overheat_hud_status.horzAlign = "right";
		self.overheat_hud_status.vertAlign = "bottom";
		self.overheat_hud_status.x = -10;
		self.overheat_hud_status.y = -154;
		self.overheat_hud_status.color = (1,.9,0);
		self.overheat_hud_status.alpha = 0;
		self.overheat_hud_status setShader("white", 10, 1);
	}
}