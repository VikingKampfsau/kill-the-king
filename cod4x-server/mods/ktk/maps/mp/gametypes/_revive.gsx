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

init(attacker, bleedOutDelay)
{
	self endon("death");
	self endon("disconnect");

	if(!isDefined(attacker) || !isDefined(attacker.name))
	{
		if(self isKing())
			scr_iPrintln("KING_ON_GROUND");
		else
			scr_iPrintln("PLAYER_ON_GROUND", undefined, self.name);
	}
	else
	{
		if(attacker.name == self.name)
		{
			/*if(self isKing())
				iPrintln("The king has plunged himself!");
			else
				iPrintln(self.name + " has downed himself!");*/
				
			if(self isKing())
				scr_iPrintln("KING_ON_GROUND");
		}
		else
		{
			if(self isKing())
				scr_iPrintln("KING_ON_GROUND_ATTACKER", undefined, attacker.name);
			else
				scr_iPrintln("PLAYER_ON_GROUND_ATTACKER", undefined, attacker.name, self.name);			
		}
	}
	
	/*if(self isKing())
		scr_iPrintln("KING_ON_GROUND", undefined);
	else
		scr_iPrintln("PLAYER_ON_GROUND", undefined, self.name);*/

	self saveHeadIcon();		
	self.headiconteam = self.pers["team"];
	self.headicon = "revive";
	self.HasMedic = false;
	self.isReviving = false;
		
	self thread markOnMinimap();
	self thread createReviveObject();
	
	self shellshock("laststand", bleedOutDelay);
}
	
createReviveObject()
{
	self endon("death");
	self endon("disconnect");

	while(!self isOnGround())
		wait .05;
	
	if(level.ktk_bots_reviveAmount > 0 && (level.players.size - level.bots.size) > level.ktk_bots_reviveAmount)
		self thread maps\mp\gametypes\_bots::callBotsForReviveHelp();
	
	reviveObj = spawn("script_model", self.origin);
	reviveObj.isInUse = false;
	reviveObj.isInUseBy = undefined;
	reviveObj.victim = self;
	
	reviveObj thread MoveReviveObj(self);
	reviveObj thread monitorReviveAttempts();
}

MoveReviveObj(player)
{
	self endon("death");

	if(!isDefined(player))
		return;
		
	if(!isAlive(player))
		return;
	
	player linkTo(self);
	
	newPos = player.origin + (0,0,5);
	while(1)
	{
		wait .1;

		if(!isDefined(player) || !isAlive(player))
			break;
		
		if(player forwardButtonPressed())
			newPos += AnglesToForward((player.angles[0], player.angles[1], 0))*1; //2;

		if(player backbuttonpressed())
			newPos -= AnglesToForward((player.angles[0], player.angles[1], 0))*1; //2;
		
		if(player moveleftbuttonpressed())
			newPos -= AnglesToRight((player.angles[0], player.angles[1], 0))*1; //2;
		
		if(player moverightbuttonpressed())
			newPos += AnglesToRight((player.angles[0], player.angles[1], 0))*1; //2;

		newPos = PlayerPhysicsTrace(player.origin + (0,0,5), newPos);
		newPos = PlayerPhysicsTrace(newPos, newPos - (0,0,1000));
		
		if(newPos[2] < player.origin[2])
		{
			if(CalcDif(newPos[2], player.origin[2]) > 50)
				continue;
		}

		self MoveTo(newPos, 0.1);
	}
}

monitorReviveAttempts()
{
	self endon("death");
		
	while(isDefined(self.victim) && isAlive(self.victim))
	{
		wait .1;
		
		if(!isDefined(self.victim) || !isAlive(self.victim))
			break;
		
		if(self.isInUse)
			continue;
		
		progress = 999;
		for(i=0;i<level.players.size;i++)
		{
			if(!isDefined(self.victim) || !isAlive(self.victim))
				break;

			if(Distance(level.players[i].origin, self.origin) > 50)
				continue;
				
			if(!level.players[i] isInSameTeamAs(self.victim))
				continue;
					
			if(level.players[i] isInRCToy())
				continue;

			if(level.players[i] isInLastStand() && self.victim != level.players[i])
				continue;

			if(level.players[i] isReviving())
				continue;
				
			if(level.players[i] isABot())
			{
				self.isInUse = false;
				self.isInUseBy = undefined;
			
				//allow them to revive when there are enough players online
				if(level.ktk_bots_reviveAmount > 0 && (level.players.size - level.bots.size) > level.ktk_bots_reviveAmount)
				{
					//but not when they are attacking an enemy
					if(!level.players[i].isAttacking)
					{
						//and it's no self revive
						if(self.victim != level.players[i])
						{
							self.isInUse = true;
							self.isInUseBy = level.players[i];
						}
					}
				}
			}
			else
			{
				if(self.victim != level.players[i])
				{
					if(isDefined(level.players[i].lowerMessage))
					{
						level.players[i].lowerMessage.label = level.players[i] GetLocalizedString("REVIVE_INFO"); //&"Hold ^3[{+activate}] ^7to revive.";//&"KTK_HOLD_USE_REVIVE";
						level.players[i].lowerMessage.alpha = 1;
						level.players[i].lowerMessage FadeOverTime(0.1);
						level.players[i].lowerMessage.alpha = 0;
					}
				}
				
				if(level.players[i] UseButtonPressed())
				{
					self.isInUse = true;
					self.isInUseBy = level.players[i];
				
					if(self.victim == level.players[i])
					{
						if(level.players[i] isKing() || !isDefined(level.players[i].pers["vip"]) || !level.players[i].pers["vip"] || level.VipsInServer >= level.RegularsInServer)
						{
							self.isInUse = false;
							self.isInUseBy = undefined;
						}
					}
				}
			}
		}
		
		if(self.isInUse)
		{
			self.victim GetInventory();
			
			if(self.isInUseBy getCurrentWeapon() != level.ktkWeapon["syrette"])
				self.isInUseBy GetInventory();

			self.isInUseBy thread giveSyrette();
		
			progress = self.isInUseBy reviveProgress(self.victim);
			
			self.isInUseBy thread takeSyrette();
			
			if(!isDefined(self.victim) || !isAlive(self.victim))
				break;
		}
				
		if(isDefined(progress) && progress <= 0)
		{
			finishRevive(self);
			break;
		}
		
		self.isInUse = false;
		self.isInUseBy = undefined;
	}
	
	self delete();
}

reviveProgress(victim)
{
	if(self getKtkStat(2362) == 1)
		timer = getdvarFloat("scr_mod_revivetime") * 0.5;
	else
		timer = getdvarFloat("scr_mod_revivetime");

	self.bar = self maps\mp\gametypes\_hud_util::createBar((1,1,1), 128, 8);
	self.bar maps\mp\gametypes\_hud_util::setPoint("CENTER", 0, 0, 0);
	self.bar maps\mp\gametypes\_hud_util::updateBar(0, 1/timer);
			
	self.isReviving = true;
	victim.HasMedic = true;
			
	while(1)
	{
		wait .05;
		timer -= .05;
	
		if(!isDefined(self) || !isAlive(self))
			break;
			
		if(!self isABot() && !self UseButtonPressed())
			break;
		
		if(timer <= 0)
			break;
		
		if(!isDefined(victim) || !isAlive(victim))
			break;
		
		if(victim != self)
		{
			if(self isInLastStand())
				break;
		}
	}

	if(isDefined(self))
	{
		self.isReviving = false;
	
		if(isDefined(self.bar))
			self.bar maps\mp\gametypes\_hud_util::destroyElem();
	}
	
	if(isDefined(victim))
	{
		victim.HasMedic = false;
		
		if(!isAlive(victim))
		{
			victim restoreHeadIcon();
			victim deletMinimapMarker();
		}
	}
	
	return timer;
}

finishRevive(reviveObj)
{
	reviveObj.victim notify("revived");

	//just in case it is still there (no idea why but it happens sometimes)
	reviveObj.isInUseBy.isReviving = false;
		
	if(isDefined(reviveObj.isInUseBy.bar))
		reviveObj.isInUseBy.bar maps\mp\gametypes\_hud_util::destroyElem();

	if(reviveObj.isInUseBy == reviveObj.victim)
		scr_iPrintln("SELF_REVIVED", undefined, reviveObj.isInUseBy.name);
	else
	{
		if(!reviveObj.isInUseBy isKing())
		{
			if(!isDefined(reviveObj.isInUseBy.pers["secondchance"]) || !reviveObj.isInUseBy.pers["secondchance"])
			{
				scr_iPrintLn("EXTRA_LIFE_EARNED", reviveObj.isInUseBy);
			
				reviveObj.isInUseBy.pers["secondchance"] = true;
				reviveObj.isInUseBy thread maps\mp\gametypes\_huds::ExtraLife();
			}
		}
		
		reviveObj.isInUseBy thread maps\mp\gametypes\_missions::Medic();
		reviveObj.isInUseBy thread maps\mp\gametypes\_awards::ReviveAward();
		reviveObj.victim thread maps\mp\gametypes\_awards::SurviveAward();
		
		/*
		random = randomint(4);
		if(random == 0)
			reviveObj.victim sayTeam("Thanks " + reviveObj.isInUseBy.name + "!");
		else if(random == 1)
			reviveObj.victim sayTeam("Thank you " + reviveObj.isInUseBy.name + "!");
		else if(random == 2)
			reviveObj.victim sayTeam("Thx " + reviveObj.isInUseBy.name + "!");
		else if(random == 3)
			reviveObj.victim sayTeam("Ty " + reviveObj.isInUseBy.name + "!");
		*/

		scr_iPrintln("REVIVED_BY", undefined, reviveObj.victim.name, reviveObj.isInUseBy.name);
	}

	if(isDefined(reviveObj.victim.lowerMessage))
	{
		reviveObj.victim.lowerMessage.label = &"";
		reviveObj.victim.lowerMessage setText(&"");
	}
	
	reviveObj.victim reviveVictim();
}
	
reviveVictim()
{
	self endon("disconnect");
	self endon("death");

	dropTarget = PlayerPhysicsTrace(self.origin + (0,0,5), self.origin);
	
	self spawn(dropTarget, self.angles);
	
	if(getDvarInt("scr_mod_grenadelauncher") == 1)
		self SetActionSlot(3, "altmode");
	
	self.lastStand = false;
		
	if(self isKing())
		self.health = 200;
	else if(self isTerminator())
		self.health = 250;
	else
		self.health = 100;

	self deletMinimapMarker();
	self restoreHeadIcon();
	self GiveInventory();

	wait .1;
	
	self SwitchToPreviousWeapon();
	
	self thread maps\mp\gametypes\_weaponloadouts::LoadoutUnlockables(true);
	self UnSetPerk("specialty_pistoldeath");
	
	if(!self isKing())
		self thread maps\mp\gametypes\_gungame::WeaponState(false, true);
}

saveHeadIcon()
{
	if(isdefined(self.headicon))
		self.oldheadicon = self.headicon;

	if(isdefined(self.headiconteam))
		self.oldheadiconteam = self.headiconteam;
}

restoreHeadIcon()
{
	if(isdefined(self.oldheadicon))
		self.headicon = self.oldheadicon;

	if(isdefined(self.oldheadiconteam))
		self.headiconteam = self.oldheadiconteam;
}

markOnMinimap()
{
	self.revivemark = maps\mp\gametypes\_gameobjects::getNextObjID();

	//Sadly the game does not allow more than 15 elements on the minimap
	if(!isDefined(self.revivemark) || self.revivemark > 15)
		return;

	Objective_Add(self.revivemark, "active", self.origin);
	Objective_OnEntity(self.revivemark, self);
	Objective_Team(self.revivemark, self.pers["team"]);
	Objective_Icon(self.revivemark, "hud_health");
}

deletMinimapMarker()
{
	if(isDefined(self.revivemark) && self.revivemark <= 15)
		Objective_Delete(self.revivemark);
}

giveSyrette()
{
	self endon("disconnect");
	self endon("death");

	self TakeAllWeapons();
	self GiveWeapon(level.ktkWeapon["syrette"]);
	wait .1;
	self SwitchToWeapon(level.ktkWeapon["syrette"]);
	self freezeControls(true);
}

takeSyrette()
{
	self endon("disconnect");
	self endon("death");
	
	self TakeWeapon(level.ktkWeapon["syrette"]);		
	self GiveInventory();
	wait .1;
	self SwitchToPreviousWeapon();
	self freezeControls(false);
	self.isReviving = false;
}