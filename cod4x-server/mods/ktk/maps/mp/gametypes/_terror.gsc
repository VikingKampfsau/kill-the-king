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
	level.terror_bombTimer = 90;
	level.terror_bombPlantTime = 3; 
	level.terror_bombDefuseTime = 5;
	
	level.BombPlanted = false;
	level.BombDefused = false;
	level.BombExploded = false;
	
	level.bombModel = "weapon_c4_bomb";
	
	level._effect["bomblight"] = LoadFX("misc/lift_light_red");
	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
}

/*--------------------------------------------------------------------------|
|							Player planting									|
|--------------------------------------------------------------------------*/
monitorPossibleBombPlanting()
{
	self endon("disconnect");
	self endon("death");

	self notify("bomb_monitor_called");
	self endon("bomb_monitor_called");
	
	self thread WaitTillBombPlanted();

	self.isPlantingBomb = false;
	while(!level.BombPlanted)
	{
		wait .05;
	
		if(!self isOnGround())
		{
			self setWeaponAmmoClip(level.ktkWeapon["c4bomb"], 0);
			self setWeaponAmmoStock(level.ktkWeapon["c4bomb"], 0);
		}
		else
		{
			if(self getAmmoCount(level.ktkWeapon["c4bomb"]) == 0)
			{
				self setWeaponAmmoClip(level.ktkWeapon["c4bomb"], 1);
				self setWeaponAmmoStock(level.ktkWeapon["c4bomb"], 0);
			}
		}
		
		if(self getCurrentWeapon() == level.ktkWeapon["c4bomb"] && self AttackButtonPressed())
		{
			self.isPlantingBomb = true;
			
			//self thread PlayBombButtonSounds();
			
			while(self getCurrentWeapon() == level.ktkWeapon["c4bomb"] && self AttackButtonPressed())
				wait .05;
			
			self.isPlantingBomb = false;
		}
	}
	
	if(self hasWeapon(level.ktkWeapon["c4bomb"]))
	{
		if(self getCurrentWeapon() == level.ktkWeapon["c4bomb"])
			self switchToWeapon(level.assassin_primary);
	
		self takeWeapon(level.ktkWeapon["c4bomb"]);
	}
}

PlayBombButtonSounds()
{
	self endon("disconnect");
	self endon("death");
	
	code = 0;
	while(self.isPlantingBomb)
	{
		code++;
		
		if(code == 1) wait .4;
		else if(code == 2) wait .3;
		else if(code == 3) wait .1;
		else if(code == 4) wait .1;
		else if(code == 5) wait .05;
		else if(code == 6) wait .1;
		else if(code == 7) wait .1;
		else if(code == 8)
		{
			wait .05;
			break;
		}

		if(!isDefined(self.isPlantingBomb) || !self.isPlantingBomb)
			break;
		
		self playSound("ui_mp_suitcasebomb_timer");
	}
}

WaitTillBombPlanted()
{
	level endon("game_ended");

	self endon("disconnect");
	self endon("death");
	self endon("bomb_monitor_called");

	self waittill("grenade_fire", c4bomb, weaponName);	
	
	if(weaponName == level.ktkWeapon["c4bomb"])
	{
		self switchToWeapon(level.assassin_primary);
		self takeWeapon(level.ktkWeapon["c4bomb"]);
	
		if(isDefined(level.BombPlanted) && level.BombPlanted)
		{
			scr_iPrintLnBold("EXPLOSIVES_ALREADY_PLANTED", self);
			return;
		}
		
		level.c4bomb = c4bomb;
		thread startBombBehaviour(self.origin);
	}
}

startBombBehaviour(bombOrigin)
{
	level endon("game_ended");
	
	iPrintLnBold(&"MP_EXPLOSIVESPLANTED");
	
	level.c4bomb.origin = PlayerPhysicsTrace(bombOrigin + (0,0,20), bombOrigin - (0,0,2000));
	level.c4bomb thread playTickingSound();
	level.c4bomb thread monitorDefusing();
	
	setGameEndTime(int(gettime() + (level.terror_bombTimer * 1000)));
	setDvar("ui_bomb_timer", 1);
	
	timer = level.terror_bombTimer;
	level.BombPlanted = true;

	while(isDefined(level.c4bomb) && !level.BombDefused && !level.BombExploded && timer > 0)
	{	
		wait 1;
		timer--;
	}
	
	setDvar("ui_bomb_timer", 0);

	if(level.bombDefused)
		return;

	if(timer <= 0)
	{
		level.c4bomb thread stopTickingSound();

		explosionEffect = spawnFx(level._effect["bombexplosion"], level.c4bomb.origin + (0,0,50), (0,0,1), (cos(randomfloat(360)),sin(randomfloat(360)),0));
		triggerFx(explosionEffect);
			
		//thread playSoundinSpace("exp_suitcase_bomb_main", level.c4bomb.origin);
		level.c4bomb playSound("exp_suitcase_bomb_main");
		
		level.c4bomb detonate();
		level.bombExploded = true;
		
		setGameEndTime(0);
		//wait 3;
		maps\mp\gametypes\ktk::onEndGame(game["attackers"], "BOMB_EXPLODED", undefined);
	}
}

/*--------------------------------------------------------------------------|
|							Player defusing									|
|--------------------------------------------------------------------------*/
monitorDefusing()
{
	self endon("death");

	self.defuseTrigger = spawn("trigger_radius", self.origin, 0, 100, 100);

	while(1)
	{
		self.defuseTrigger waittill("trigger", player);

		if(isDefined(self.inUse) && self.inUse)
			continue;
		
		if(!isAlive(player))
			continue;
			
		if(!player isOnGround())
			continue;

		if(player isInRCToy())
			continue;
			
		if(player isInPredator())
			continue;
			
		if(player isInAC130())
			continue;
			
		if(player isInMannedHelicopter())
			continue;
			
		if(player isInParachute())
			continue;
			
		if(player isReviving())
			continue;
			
		if(player.pers["team"] != game["defenders"])
			continue;

		if(player UseButtonPressed() && level.bombPlanted && !level.bombDefused)
		{
			result = self useHoldThink(player, player.pers["team"]);	
			if(result)
			{
				thread BombDefused();
				break;
			}
		}
	}
}

BombDefused()
{
	level.bombDefused = true;
	level.c4bomb delete();

	setGameEndTime(0);
	//wait 1.5;
	maps\mp\gametypes\ktk::onEndGame(game["defenders"], "BOMB_DEFUSED", undefined);
}

useHoldThink(player, team)
{
	self endon("death");

	self.curProgress = 0;
	self.inUse = true;
	self.useRate = 0;
	self.useTime = level.terror_bombDefuseTime;

	player freezeControls(true);
	player playSound("mp_bomb_defuse");
	
	result = self useHoldThinkLoop(player, team);
	
	if(isDefined(player))
		player freezeControls(false);
	
	if(isDefined(self))
		self.inUse = false;
	
	if(isDefined(result)&& result)
		return true;
	
	return false;
}

useHoldThinkLoop(player, team)
{
	level endon("game_ended");
	
	self endon("death");

	while(isDefined(self) && isAlive(player) && player useButtonPressed() && isDefined(self.curProgress) && isDefined(self.useTime) && self.curProgress < self.useTime)
	{
		if(team == game["defenders"])
			player thread personalUseBar();
	
		self.curProgress += level.c4bomb.useRate*0.05;
		self.useRate = 1;

		if(self.curProgress >= self.useTime)
		{
			self.inUse = false;
			return isAlive(player);
		}

		wait .05;
	}
	
	return false;
}

personalUseBar()
{
	self endon("disconnect");
	
	if(isDefined(self.bombUseBar))
		return;
	
	self.bombUseBar = self maps\mp\gametypes\_hud_util::createBar((1,1,1), 128, 8);
	self.bombUseBar maps\mp\gametypes\_hud_util::setPoint("CENTER", 0, 0, 0);

	lastRate = -1;
	while(isAlive(self) && isDefined(level.c4bomb))
	{
		if(isDefined(level.gameEnded) && level.gameEnded)
			break;
			
		if(!isDefined(level.c4bomb.inUse) || !level.c4bomb.inUse)
			break;
	
		if(lastRate != level.c4bomb.useRate)
		{
			if(level.c4bomb.curProgress > level.c4bomb.useTime)
				level.c4bomb.curProgress = level.c4bomb.useTime;

			self.bombUseBar maps\mp\gametypes\_hud_util::updateBar(level.c4bomb.curProgress/level.c4bomb.useTime, 1/level.c4bomb.useTime);

			if(!level.c4bomb.useRate)
				self.bombUseBar maps\mp\gametypes\_hud_util::hideElem();
			else
				self.bombUseBar maps\mp\gametypes\_hud_util::showElem();
		}

		lastRate = level.c4bomb.useRate;
		wait .05;
	}
	
	self.bombUseBar maps\mp\gametypes\_hud_util::destroyElem();
}

/*--------------------------------------------------------------------------|
|									funtions								|
|--------------------------------------------------------------------------*/
playTickingSound()
{
	level endon("game_ended");

	self endon("death");
	self endon("stop_ticking");

	timer = level.terror_bombTimer;
	while(timer > 0)
	{
		self playSound("ui_mp_suitcasebomb_timer");
		PlayFxOnTag(level._effect["bomblight"], self, "tag_fx");

		if(timer > 20)
		{
			wait 1;
			timer -= 1;
		}
		else if(timer <=20 && timer > 10)
		{
			wait 0.5;
			timer -= 0.5;
		}

		else if(timer <=10 && timer > 5)
		{
			wait 0.33;
			timer -= 0.33;
		}
		else
		{
			wait 0.2;
			timer -= 0.2;
		}
	}
}

stopTickingSound()
{
	self notify("stop_ticking");
}

playSoundinSpace(alias, origin)
{
	sound_origin = spawn("script_origin", origin);
	sound_origin.origin = origin;
	sound_origin playSound(alias);
	wait 10; // MP doesn't have "sounddone" notifies =(
	sound_origin delete();
}