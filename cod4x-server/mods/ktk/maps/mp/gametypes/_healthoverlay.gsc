#include maps\mp\gametypes\_misc;

init()
{
	if(getDvar("scr_mod_healthregen") == "")
		SetDvar("scr_mod_healthregen", 10);

	precacheShader("overlay_low_health");
	
	level.healthOverlayCutoff = 0.55; // getting the dvar value directly doesn't work right because it's a client dvar getdvarfloat("hud_healthoverlay_pulseStart");
	
	regenTime = getDvarInt("scr_mod_healthregen");
	
	level.playerHealth_RegularRegenDelay = regenTime * 1000;
	
	level.healthRegenDisabled = (level.playerHealth_RegularRegenDelay <= 0);
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player thread onPlayerSpawned();
		
		/* Kill the King - why did they use so many notify threads instead of endon events in the function?
		player thread onPlayerKilled();
		player thread onJoinedTeam();
		player thread onJoinedSpectators();
		player thread onPlayerDisconnect();
		*/
	}
}

onJoinedTeam()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("joined_team");
		self notify("end_healthregen");
	}
}

onJoinedSpectators()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("joined_spectators");
		self notify("end_healthregen");
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("spawned_player");
		self thread playerHealthRegen();
	}
}

onPlayerKilled()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("killed_player");
		self notify("end_healthregen");
	}
}

onPlayerDisconnect()
{
	self waittill("disconnect");
	self notify("end_healthregen");
}

playerHealthRegen()
{
	self endon("end_healthregen");
	
	self endon("disconnect");
	self endon("death");
	self endon("end_respawn");
	
	if ( self.health <= 0 )
	{
		assert( !isalive( self ) );
		return;
	}
	
	if(game["customEvent"] == "tankking" && self isKing())
		return;
	
	maxhealth = self.health;
	oldhealth = maxhealth;
	//health_add = 0;
	
	regenRate = 0.1; // 0.017;
	veryHurt = false;
	
	self.breathingStopTime = -10000;
	
	thread playerBreathingSound(maxhealth * 0.35);
	
	lastSoundTime_Recover = 0;
	hurtTime = 0;
	newHealth = 0;
	
	for (;;)
	{
		wait (0.05);
		
		if(isDefined(self.maxhealth))
			maxhealth = self.maxhealth;
		
		if (self.health == maxhealth)
		{
			veryHurt = false;
			self.atBrinkOfDeath = false;
			//continue;
		}
					
		if (self.health <= 0)
			return;

		wasVeryHurt = veryHurt;
		ratio = self.health / maxHealth;
		if (ratio <= level.healthOverlayCutoff)
		{
			veryHurt = true;
			self.atBrinkOfDeath = true;
			if (!wasVeryHurt)
			{
				hurtTime = gettime();
			}
		}
			
		if (self.health >= oldhealth)
		{
			if (gettime() - hurttime < level.playerHealth_RegularRegenDelay)
				continue;
			
			if ( level.healthRegenDisabled )
				continue;

			//if(!self isKing() && !self isTerminator() && !self isMainAssassin())
				//continue;

			if (gettime() - lastSoundTime_Recover > level.playerHealth_RegularRegenDelay)
			{
				lastSoundTime_Recover = gettime();
				//self playLocalSound("breathing_better");
			}
	
			if (veryHurt)
			{
				newHealth = ratio;
				if (gettime() > hurtTime + 3000)
					newHealth += regenRate;
			}
			else
				newHealth = 1;
							
			if ( newHealth >= 1.0 )
			{
				if ( veryHurt )
					self maps\mp\gametypes\_missions::healthRegenerated();
				newHealth = 1.0;
			}
				
			if (newHealth <= 0)
			{
				// Player is dead
				return;
			}

			//self setnormalhealth (newHealth);
			self.health = int(newHealth * self.maxhealth);

			//update the healthbar
			if(self.health != oldhealth)
			{
				if(self isTerminator())
					level maps\mp\gametypes\_huds::UpdateHealthbarPlayerNotify("update_healthbar", "terminator");
				else if(self isKing() && game["customEvent"] != "reversektk")
					level maps\mp\gametypes\_huds::UpdateHealthbarPlayerNotify("update_healthbar", "king");
				else if(self isMainAssassin() && game["customEvent"] == "reversektk")
					level maps\mp\gametypes\_huds::UpdateHealthbarPlayerNotify("update_healthbar", "assassin");
			}
			
			oldhealth = self.health;
			continue;
		}

		oldhealth = self.health;
			
		//health_add = 0;
		hurtTime = gettime();
		self.breathingStopTime = hurtTime + 6000;
	}
}

playerBreathingSound(healthcap)
{
	self endon("end_healthregen");
	
	self endon("disconnect");
	self endon("death");
	self endon("end_respawn");
	
	wait (2);
	for (;;)
	{
		wait (0.2);
		if (self.health <= 0)
			return;
			
		// Player still has a lot of health so no breathing sound
		if (self.health >= healthcap)
			continue;
		
		if ( level.healthRegenDisabled && gettime() > self.breathingStopTime )
			continue;
			
		self playLocalSound("breathing_hurt");
		wait .784;
		wait (0.1 + randomfloat (0.8));
	}
}
