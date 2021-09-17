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
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_misc;

init()
{
	level.barsize = 100;
	level.updatingHealthbars = false;

	if(level.gametype == "htt")
	{
		thread HackTheTerminalHUD();
		return;
	}
	
	if(level.gametype == "ctc")
	{
		thread containCodesHUD();
		return;
	}
	
	if(level.gametype == "ktk")
	{
		if(getDvar("scr_ktk_kinghealthbar") == "")
			setDvar("scr_ktk_kinghealthbar", 1);

		thread MonitorHealthBars();
			
		return;
	}
}

CustomEventHUD()
{
	level.customEvent_text = newHudElem();
	level.customEvent_text.alignX = "right";
	level.customEvent_text.alignY = "bottom";
	level.customEvent_text.horzAlign = "right";
	level.customEvent_text.vertAlign = "bottom";
	level.customEvent_text.alpha = 0.75;
	level.customEvent_text.sort = 1;
	level.customEvent_text.x = -5;
	level.customEvent_text.y = 2;
	level.customEvent_text.font = "default";
	level.customEvent_text.fontScale = 1.4;
	level.customEvent_text.archived = false;
	level.customEvent_text.foreground = true;
	level.customEvent_text.hidewheninmenu = true;
	level.customEvent_text.label = getLocalizedEventTextFromName();
}

FlagCounterHUD()
{
	level endon("game_ended");

	level.customEvent_revoltFlags = newHudElem();
	level.customEvent_revoltFlags.alignX = "right";
	level.customEvent_revoltFlags.alignY = "bottom";
	level.customEvent_revoltFlags.horzAlign = "right";
	level.customEvent_revoltFlags.vertAlign = "bottom";
	level.customEvent_revoltFlags.alpha = 0.75;
	level.customEvent_revoltFlags.sort = 1;
	level.customEvent_revoltFlags.x = -5;
	level.customEvent_revoltFlags.y = -60;
	level.customEvent_revoltFlags.font = "default";
	level.customEvent_revoltFlags.fontScale = 1.4;
	level.customEvent_revoltFlags.archived = false;
	level.customEvent_revoltFlags.foreground = true;
	level.customEvent_revoltFlags.hidewheninmenu = true;
	level.customEvent_revoltFlags.label = &"^3Flags ^7- ^1Att: ^71 ^2Def: ^71 ^3No: ^7&&1";
	level.customEvent_revoltFlags setValue(level.flags.size - 2);
	
	while(1)
	{
		level waittill("spawn_flag_captured");
		
		thread UpdateSpawnFlagCounter();
	}
}

UpdateSpawnFlagCounter()
{
	attackerFlagCount = maps\mp\gametypes\_revolt::getTeamFlagCount(game["attackers"]);
	defenderFlagCount = maps\mp\gametypes\_revolt::getTeamFlagCount(game["defenders"]);
	neutralFlagCount = level.flags.size - attackerFlagCount - defenderFlagCount;
		
	if(isDefined(level.customEvent_revoltFlags))
	{
		level.customEvent_revoltFlags.label = &"&&1";
		level.customEvent_revoltFlags setText("^3Flags ^7- ^1Att: ^7" + attackerFlagCount + " ^2Def: ^7" + defenderFlagCount + " ^3No: ^7" + neutralFlagCount);
	}
}

minplayerHUD(minplayers)
{
	if(self isABot())
		return;

	if(!isDefined(self.minplayerhud))
	{
		self.minplayerhud = NewClientHudElem(self);
		self.minplayerhud.alignX = "center";
		self.minplayerhud.alignY = "middle";
		self.minplayerhud.horzalign = "center";
		self.minplayerhud.vertalign = "middle";
		self.minplayerhud.alpha = 1;
		self.minplayerhud.sort = 1;
		self.minplayerhud.x = 0;
		self.minplayerhud.y = 0;
		self.minplayerhud.font = "objective";
		self.minplayerhud.fontscale = 1.6;
		self.minplayerhud.archived = false;
		self.minplayerhud.hidewheninmenu = true;
		self.minplayerhud.label = self GetLocalizedString("NOT_ENOUGH_PLAYERS");
		self.minplayerhud setValue(minplayers);
	}
	
	while(GetPlayersInTeam("axis") + GetPlayersInTeam("allies") < minplayers)
		wait .5;
	
	if(isDefined(self.minplayerhud))	
		self.minplayerhud destroy();
}

KingHUD()
{
	self endon("disconnect");

	if(game["customEvent"] == "unknownking" || game["customEvent"] == "kingvsking" || game["customEvent"] == "lastkingstanding")
		return;
	
	if(self isABot())
		return;
	
	while(!isDefined(self.pers["language"]))
		wait .1;
	
	self.kinghud_text = NewClientHudElem(self);
	self.kinghud_text.font = "default";
	self.kinghud_text.fontScale = 1.4;
	self.kinghud_text.alignX = "left";
	self.kinghud_text.alignY = "top";
	self.kinghud_text.horzAlign = "left";
	self.kinghud_text.vertAlign = "top";
	self.kinghud_text.alpha = 0.75;
	self.kinghud_text.sort = 1;
	self.kinghud_text.x = 6;
	self.kinghud_text.y = 120;
	self.kinghud_text.archived = false;
	self.kinghud_text.foreground = true;
	self.kinghud_text.hidewheninmenu = true;

	self.kinghud_text.label = self GetLocalizedString("NO_KING_YET");

	while(!level.roundstarted)
		wait .05;
	
	if(game["customEvent"] == "reversektk")
	{
		if(isDefined(level.assassin))
		{
			self.kinghud_text.label = self GetLocalizedString("PICKED_ASSASSIN_IS");
			self.kinghud_text setText("^1" + level.assassin.name);
		}
	}
	else
	{
		if(isDefined(level.king))
		{
			self.kinghud_text.label = self GetLocalizedString("KING_IS");
			self.kinghud_text setText(level.king.name);
		}
	}
}

KingHealthHUD()
{
	level endon("play_finalcam");
	self endon("disconnect");
	
	if(game["customEvent"] == "kingvsking" || game["customEvent"] == "lastkingstanding")
		return;
	
	if(isDefined(self.kinghealthhud))
	{
		if(isDefined(self.kinghealthhud.background))
			self.kinghealthhud.background destroy();

		self.kinghealthhud destroy();
	}
		
	if(self getKtkStat(2418) == 1)
	{
		self.kinghealthhud = newClientHudElem(self);
		self.kinghealthhud.font = "default";
		self.kinghealthhud.fontScale = 1.4;
		self.kinghealthhud.alignX = "left";
		self.kinghealthhud.alignY = "top";
		self.kinghealthhud.horzAlign = "left";
		self.kinghealthhud.vertAlign = "top";
		self.kinghealthhud.x = 6;
		self.kinghealthhud.y = 140;
		self.kinghealthhud.sort = 1;
		self.kinghealthhud.alpha = 0;
		self.kinghealthhud.archived = false;
		self.kinghealthhud.foreground = true;
		self.kinghealthhud.hidewheninmenu = false;
		self.kinghealthhud.label = &"King health: &&1";
		self.kinghealthhud.color = (0, 1, 0);
		self.kinghealthhud setValue(0);
	}
	else
	{
		self.kinghealthhud = newClientHudElem(self);
		self.kinghealthhud.font = "default";
		self.kinghealthhud.fontScale = 1.4;
		self.kinghealthhud.alignX = "left";
		self.kinghealthhud.alignY = "top";
		self.kinghealthhud.horzAlign = "left";
		self.kinghealthhud.vertAlign = "top";
		self.kinghealthhud.x = 6;
		self.kinghealthhud.y = 140;
		self.kinghealthhud.sort = 1;
		self.kinghealthhud.alpha = 0;
		self.kinghealthhud.archived = false;
		self.kinghealthhud.foreground = true;
		self.kinghealthhud.hidewheninmenu = false;
		self.kinghealthhud setShader("white", level.barsize, 10);
		self.kinghealthhud.color = (0, 1, 0);
		
		self.kinghealthhud.background = newClientHudElem(self);
		self.kinghealthhud.background.font = "default";
		self.kinghealthhud.background.fontScale = 1.4;
		self.kinghealthhud.background.alignX = "left";
		self.kinghealthhud.background.alignY = "top";
		self.kinghealthhud.background.horzAlign = "left";
		self.kinghealthhud.background.vertAlign = "top";
		self.kinghealthhud.background.alpha = 0;
		self.kinghealthhud.background.x = 4;
		self.kinghealthhud.background.y = 138;
		self.kinghealthhud.background.sort = 0;
		self.kinghealthhud.background.archived = false;
		self.kinghealthhud.background.foreground = true;
		self.kinghealthhud.background.hidewheninmenu = false;
		self.kinghealthhud.background setShader("black", level.barsize + 4, 10 + 4);
	}
}

TerminatorHealthHUD()
{
	level endon("play_finalcam");
	self endon("disconnect");

	if(getdvarint("scr_ktk_terminator") == 0)
		return;
		
	while(!isDefined(level.terminator))
		wait .1;
	
	if(isDefined(self.terminatorhealthhud))
	{
		if(isDefined(self.terminatorhealthhud.background))
			self.terminatorhealthhud.background destroy();
		
		self.terminatorhealthhud destroy();
	}

	if(self getKtkStat(2418) == 1)
	{
		self.terminatorhealthhud = newClientHudElem(self);
		self.terminatorhealthhud.font = "default";
		self.terminatorhealthhud.fontScale = 1.4;
		self.terminatorhealthhud.alignX = "left";
		self.terminatorhealthhud.alignY = "top";
		self.terminatorhealthhud.horzAlign = "left";
		self.terminatorhealthhud.vertAlign = "top";
		self.terminatorhealthhud.x = 6;
		self.terminatorhealthhud.y = 160;
		self.terminatorhealthhud.sort = -1;
		self.terminatorhealthhud.alpha = 0;
		self.terminatorhealthhud.archived = false;
		self.terminatorhealthhud.foreground = true;
		self.terminatorhealthhud.hidewheninmenu = false;
		self.terminatorhealthhud.label = &"Terminator health: &&1";
		self.terminatorhealthhud.color = (0, 1, 0);
		self.terminatorhealthhud setValue(0);
	}
	else
	{	
		self.terminatorhealthhud = newClientHudElem(self);
		self.terminatorhealthhud.font = "default";
		self.terminatorhealthhud.fontScale = 1.4;
		self.terminatorhealthhud.alignX = "left";
		self.terminatorhealthhud.alignY = "top";
		self.terminatorhealthhud.horzAlign = "left";
		self.terminatorhealthhud.vertAlign = "top";
		self.terminatorhealthhud.x = 6;
		self.terminatorhealthhud.y = 160;
		self.terminatorhealthhud.sort = 1;
		self.terminatorhealthhud.alpha = 0;
		self.terminatorhealthhud.archived = false;
		self.terminatorhealthhud.foreground = true;
		self.terminatorhealthhud.hidewheninmenu = false;
		self.terminatorhealthhud setShader("white", level.barsize, 10);
		self.terminatorhealthhud.color = (0, 1, 0);

		self.terminatorhealthhud.background = newClientHudElem(self);
		self.terminatorhealthhud.background.font = "default";
		self.terminatorhealthhud.background.fontScale = 1.4;
		self.terminatorhealthhud.background.alignX = "left";
		self.terminatorhealthhud.background.alignY = "top";
		self.terminatorhealthhud.background.horzAlign = "left";
		self.terminatorhealthhud.background.vertAlign = "top";
		self.terminatorhealthhud.background.alpha = 0;
		self.terminatorhealthhud.background.x = 4;
		self.terminatorhealthhud.background.y = 158;
		self.terminatorhealthhud.background.sort = 0;
		self.terminatorhealthhud.background.archived = false;
		self.terminatorhealthhud.background.foreground = true;
		self.terminatorhealthhud.background.hidewheninmenu = false;
		self.terminatorhealthhud.background setShader("black", level.barsize + 4, 10 + 4);
	}
}

MonitorHealthBars()
{
	while(!level.roundstarted)
		wait .05;

	if(game["customEvent"] == "reversektk")
		thread MonitorHealthBar("assassin");
	else
		thread MonitorHealthBar("king");

	thread MonitorHealthBar("terminator");
}

MonitorHealthBar(type)
{
	if(type == "king")
	{
		while(!isDefined(level.king))
			wait .05;
		
		while(isDefined(level.king))
		{
			thread UpdatePlayerHealthbars("king", undefined);
			level.king waittill("update_healthbar");
		}
	}
	
	if(type == "assassin")
	{
		while(!isDefined(level.assassin))
			wait .05;
		
		while(isDefined(level.assassin))
		{
			thread UpdatePlayerHealthbars("assassin", undefined);
			level.assassin waittill("update_healthbar");
		}
	}
	
	if(type == "terminator")
	{
		while(!isDefined(level.terminator))
			wait .05;
		
		while(isDefined(level.terminator))
		{
			thread UpdatePlayerHealthbars("terminator", undefined);
			level.terminator waittill("update_healthbar");
		}
	}
}

UpdatePlayerHealthbars(type, player)
{
	level endon("game_ended");
	
	//level notify("update_healthbar_" + type);
	//level endon("update_healthbar_" + type);

	if(level.updatingHealthbars)
	{
		if(isDefined(player) && !player isABot())
			player thread UpdatePlayerHealthbar(type);
			
		return;
	}
	
	level.updatingHealthbars = true;
	
	for(i=0;i<level.players.size;i++)
	{
		if(!level.players[i] isABot())
			level.players[i] thread UpdatePlayerHealthbar(type);
	}
	
	level.updatingHealthbars = false;
}

UpdatePlayerHealthbar(type)
{
	self endon("disconnect");
	
	self notify("UpdateHealthBar_" + type);
	self endon("UpdateHealthBar_" + type);

	if(type == "king")
	{
		if(!isDefined(level.king))
			return;
			
		if(!isDefined(self.kinghealthhud))
			return;
	
		if(self getKtkStat(2418) == 1)
		{
			self.kinghealthhud.alpha = 0.75;
			self.kinghealthhud setValue(int(level.king.health));
		}
		else
		{
			self.kinghealthhud.alpha = 1;
			
			if(isDefined(self.kinghealthhud.background))
				self.kinghealthhud.background.alpha = 1;
			
			if(level.king.health <= 0)
				self.kinghealthhud setShader("white", 0, 10);
			else
				self.kinghealthhud setShader("white", int(level.king.health/level.king.maxhealth*level.barsize), 10);
		}
		
		if(level.king.health > 0)
			self.kinghealthhud.color = ColorForHealth(int(level.king.health/level.king.maxhealth*100));
	}
	
	if(type == "assassin")
	{
		if(!isDefined(level.assassin))
			return;
	
		if(!isDefined(self.kinghealthhud))
			return;
	
		if(self getKtkStat(2418) == 1)
		{
			self.kinghealthhud.alpha = 0.75;
			self.kinghealthhud setValue(int(level.assassin.health));
		}
		else
		{
			self.kinghealthhud.alpha = 1;
			
			if(isDefined(self.kinghealthhud.background))
				self.kinghealthhud.background.alpha = 1;
			
			if(level.assassin.health <= 0)
				self.kinghealthhud setShader("white", 0, 10);
			else
				self.kinghealthhud setShader("white", int(level.assassin.health/level.assassin.maxhealth*level.barsize), 10);
		}
			
		if(level.assassin.health > 0)
			self.kinghealthhud.color = ColorForHealth(int(level.assassin.health/level.assassin.maxhealth*100));
	}
	
	if(type == "terminator")
	{
		if(!isDefined(level.terminator))
		{
			if(isDefined(self.terminatorhealthhud))
			{
				if(isDefined(self.terminatorhealthhud.background))
					self.terminatorhealthhud.background destroy();
				
				self.terminatorhealthhud destroy();
			}
		
			return;
		}
	
		if(!isDefined(self.terminatorhealthhud))
			return;

		if(self getKtkStat(2418) == 1)
		{
			self.terminatorhealthhud.alpha = 0.75;
			self.terminatorhealthhud setValue(int(level.terminator.health));
		}
		else
		{
			self.terminatorhealthhud.alpha = 1;
			
			if(isDefined(self.terminatorhealthhud.background))
				self.terminatorhealthhud.background.alpha = 1;
	
			if(level.terminator.health <= 0)
				self.terminatorhealthhud setShader("white", 0, 10);
			else
				self.terminatorhealthhud setShader("white", int(level.terminator.health/level.terminator.maxhealth*level.barsize), 10);
		}
		
		if(level.terminator.health > 0)
			self.terminatorhealthhud.color = ColorForHealth(int(level.terminator.health/level.terminator.maxhealth*100));
	}
}

KillRatioHud()
{
	self endon("disconnect");
	self endon("death");

	if(self isABot())
		return;
	
	if(isDefined(self.kdhud))
		self.kdhud destroy();
	
	if(isDefined(level.gameEnded) && level.gameEnded)
		return;
		
	while(!level.roundstarted)
		wait .05;

	if(isDefined(self.kdhud))
		self.kdhud destroy();
		
    self.kdhud = newclientHudElem(self);
    self.kdhud.font = "default";
    self.kdhud.fontScale = 1.4;
	self.kdhud.alignX = "left";
	self.kdhud.alignY = "bottom";
	self.kdhud.horzAlign = "left";
	self.kdhud.vertAlign = "top";
	self.kdhud.x = 110;
	self.kdhud.y = 50;
    self.kdhud.alpha = 1;
    self.kdhud.sort = 1;
	self.kdhud.archived = false;
    self.kdhud.foreground = true;
    self.kdhud.hidewheninmenu = true;
	self.kdhud.label = &"K/D: ^2&&1";
	self.kdhud setValue(0);
	
	while(1)
	{
		if(isDefined(level.gameEnded) && level.gameEnded)
			break;
			
		if(!level.roundstarted)
			break;
	
		if(self.pers["totalkills"] > 0 && self.pers["totaldeaths"] > 0)
			self.pers["kdratio"] = int((self.pers["totalkills"]/self.pers["totaldeaths"])*100)/100;
		else
		{
			if(self.pers["totalkills"] > 0 && self.pers["totaldeaths"] <= 0)
				self.pers["kdratio"] = self.pers["totalkills"];
			else
				self.pers["kdratio"] = 0;
		}
			
		self.kdhud setValue(self.pers["kdratio"]);
		
		self waittill_any("made_a_kill", "death");
	}

	if(isDefined(self.kdhud))
		self.kdhud destroy();
}

stickyNade()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isABot())
		return;
	
	if(!isDefined(self.stickyNade_icon))
	{
		self.stickyNade_icon = NewClientHudElem(self);
		self.stickyNade_icon.x = 0;
		self.stickyNade_icon.y = 0;
		self.stickyNade_icon setshader( "hud_grenadeicon", 30, 30 );
		self.stickyNade_icon.alignX = "center";
		self.stickyNade_icon.alignY = "middle";
		self.stickyNade_icon.horzAlign = "center";
		self.stickyNade_icon.vertAlign = "middle";
		self.stickyNade_icon.foreground = true;
		self.stickyNade_icon.archived = true;
		self.stickyNade_icon.sort = 1;
		self.stickyNade_icon.alpha = 0;
		self.stickyNade_icon fadeOverTime( 1 );
		self.stickyNade_icon.alpha = 1;
	}
	
	if(!isDefined(self.stickyNade_text))	
	{
		self.stickyNade_text = NewClientHudElem(self);
		self.stickyNade_text.elemType = "font";
		self.stickyNade_text.font = "default";
		self.stickyNade_text.fontscale = 1.5;
		self.stickyNade_text.x = 0;
		self.stickyNade_text.y = -30;
		self.stickyNade_text.alignX = "center";
		self.stickyNade_text.alignY = "middle";
		self.stickyNade_text.horzAlign = "center";
		self.stickyNade_text.vertAlign = "middle";
		self.stickyNade_text.label = self GetLocalizedString("NADE_ON_YOU");
		self.stickyNade_text.foreground = true;
		self.stickyNade_text.sort = 1;
		self.stickyNade_text.archived = true;
		self.stickyNade_text.alpha = 0;
		self.stickyNade_text fadeOverTime( 1 );
		self.stickyNade_text.alpha = 1;
	}
	
	self thread RemoveHudsonDeath();
}

TerminatorHUD()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isABot())
		return;
	
	if(!isDefined(self.juggernaut))
	{
		self.juggernaut = NewClientHudElem(self);
		self.juggernaut.alignX = "left";
		self.juggernaut.alignY = "top";
		self.juggernaut.x = 0;
		self.juggernaut.y = 0;
		self.juggernaut.horzAlign = "fullscreen";
		self.juggernaut.vertAlign = "fullscreen";
		self.juggernaut.foreground = false;
		self.juggernaut.archived = true;
		self.juggernaut.sort = 0;
		self.juggernaut.alpha = 1;
		self.juggernaut setShader("juggernaut_view", 640, 480);
	}
	
	self thread RemoveHudsonDeath();
}

ArmorHud()
{
	self endon("disconnect");
	self endon("death");

	if(isDefined(self.ArmorHud))
		self.ArmorHud destroy();
		
	self.ArmorHud = NewClientHudElem(self);
	self.ArmorHud.alignX = "left";
	self.ArmorHud.alignY = "top";
	self.ArmorHud.x = 0;
	self.ArmorHud.y = 0;
	self.ArmorHud.horzAlign = "fullscreen";
	self.ArmorHud.vertAlign = "fullscreen";
	self.ArmorHud.foreground = false;
	self.ArmorHud.archived = true;
	self.ArmorHud.alpha = .35;
	self.ArmorHud setShader("armor_overlay", 640, 480);
	
	while(isDefined(self.ArmorHud) && self.isArmored)
		wait .1;
	
	if(isDefined(self.ArmorHud))
		self.ArmorHud destroy();
}

GungameHUD()
{
	self endon("disconnect");
	self endon("death");
	
	//nextWeapon = level.GunGameWeapons[self.weaponstate];
	//nextWeaponName = getLocalizedWeaponName(nextWeapon);
	
	if(self isABot())
		return;
	
	if(!isDefined(self.gungamehint))
	{
		self.gungamehint = NewClientHudElem(self);
		self.gungamehint.elemType = "font";
		self.gungamehint.font = "default";
		self.gungamehint.fontscale = 1.5;
		self.gungamehint.x = 0;
		self.gungamehint.y = 160;
		self.gungamehint.alignX = "center";
		self.gungamehint.alignY = "middle";
		self.gungamehint.horzAlign = "center";
		self.gungamehint.vertAlign = "middle";
		self.gungamehint.foreground = true;
		self.gungamehint.archived = false;
		self.gungamehint.alpha = 1;
		self.gungamehint.sort = 1;
		
		/*if(!isDefined(nextWeapon) || !isDefined(nextWeaponName) || nextWeaponName == &"")
			self.gungamehint.label = self GetLocalizedString("WEAPONCHANGE_GUNGAME");
		else
		{
			self.gungamehint.label = &"Press ^3[{+activate}] ^7for the new weapon. (&&1)";
			self.gungamehint setText(nextWeaponName);
		}*/
		
		self.gungamehint.label = self GetLocalizedString("WEAPONCHANGE_GUNGAME");
	}
	
	self thread RemoveHudsonDeath();
}

WeaponState()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isABot())
		return;
	
	/*if(!isDefined(self.gungameprogress))
	{
		self.gungameprogress = NewClientHudElem(self);
		self.gungameprogress.elemType = "font";
		self.gungameprogress.font = "default";
		self.gungameprogress.fontscale = 1.4;
		self.gungameprogress.alignX = "left";
		self.gungameprogress.alignY = "middle";
		self.gungameprogress.horzAlign = "fullscreen";
		self.gungameprogress.vertAlign = "middle";
		self.gungameprogress.x = 550;
		self.gungameprogress.y = 180;
		self.gungameprogress.foreground = true;
		self.gungameprogress.archived = false;
		self.gungameprogress.alpha = 1;
		self.gungameprogress.label = self GetLocalizedString("GUNGAME_STAGE");
		self.gungameprogress.hidewheninmenu = true;
		self.gungameprogress setValue(self.weaponstate);
	}
	
	if(!isDefined(self.gungameprogress2))
	{
		self.gungameprogress2 = NewClientHudElem(self);
		self.gungameprogress2.elemType = "font";
		self.gungameprogress2.font = "default";
		self.gungameprogress2.fontscale = 1.4;
		self.gungameprogress2.alignX = "left";
		self.gungameprogress2.alignY = "middle";
		self.gungameprogress2.horzAlign = "fullscreen";
		self.gungameprogress2.vertAlign = "middle";
		self.gungameprogress2.x = self.gungameprogress.x + 45;
		self.gungameprogress2.y = 180;
		self.gungameprogress2.foreground = true;
		self.gungameprogress2.archived = false;
		self.gungameprogress2.alpha = 1;
		self.gungameprogress2.label = self GetLocalizedString("GUNGAME_MAXSTAGE");
		self.gungameprogress2.hidewheninmenu = true;
		self.gungameprogress2 setValue(1);
	}
	
	self thread RemoveHudsonDeath();
	self thread RemoveHudsonDeath();
	
	while(!level.roundstarted)
		wait .1;
	
	if(self isKing())
		self.gungameprogress2 setValue(1);
	else
		self.gungameprogress2 setValue(level.GunGameWeapons.size-1);
	*/
	
	while(1)
	{
		self waittill("made_a_kill");
		
		if(self.weaponstate == level.GunGameWeapons.size)
			break;
		
		if(game["customEvent"] != "kingvsking")
		{
			if(self isAnAssassin())
				break;
		}
		
		self setClientDvar("gungame_cur", self.weaponstate);
		
		/*
		self.gungameprogress setValue(self.weaponstate);
		
		if(self.weaponstate >= 10 && self.gungameprogress2.x != self.gungameprogress.x + 50)
			self.gungameprogress2.x = self.gungameprogress.x + 50;
			
		if(self.weaponstate < 10 && self.gungameprogress2.x != self.gungameprogress.x + 45)
			self.gungameprogress2.x = self.gungameprogress.x + 45;
		*/
	}
}

Cash()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isABot())
		return;
	
	/*if(!isDefined(self.moneyhud))
	{
		self.moneyhud = NewClientHudElem(self);
		self.moneyhud.elemType = "font";
		self.moneyhud.font = "default";
		self.moneyhud.fontscale = 1.4;
		self.moneyhud.alignX = "left";
		self.moneyhud.alignY = "middle";
		self.moneyhud.horzAlign = "fullscreen";
		self.moneyhud.vertAlign = "middle";
		self.moneyhud.x = 550;
		self.moneyhud.y = 165;
		self.moneyhud.foreground = true;
		self.moneyhud.archived = false;
		self.moneyhud.alpha = 1;
		self.moneyhud.label = self GetLocalizedString("MONEY");
		self.moneyhud.hidewheninmenu = true;
		self.moneyhud setValue(self.pers["score"]);
	}*/
	
	self thread RemoveHudsonDeath();
	
	while(1)
	{
		curMoney = self.pers["score"];
		self waittill( "update_playerscore_hud" );
		
		if(curMoney != self.pers["score"])
		{
			self setClientDvar("cash", self.pers["score"]);
			//self.moneyhud setValue(self.pers["score"]);
		}
	}
}

Crosshair()
{
	//controlled in _quickmessage.gsc (toggle 3rdperson)
	
	self endon("disconnect");

	if(self isABot())
		return;
	
	if(isDefined(self.crosshairhud))
		self.crosshairhud destroy();
	
	self.crosshairhud = newClientHudElem(self);
	self.crosshairhud.horzAlign = "center";
	self.crosshairhud.vertAlign = "middle";
	self.crosshairhud.x = -16;
	self.crosshairhud.y = -16;
	self.crosshairhud.sort = 1;
	self.crosshairhud.archived = false;
	self.crosshairhud.alpha = 0;
	self.crosshairhud setShader("reticle_minigun", 32, 32);
	
	if(!self isDog())
	{
		if(isDefined(self.pers["thirdperson"]) && self.pers["thirdperson"])
		{
			if(isDefined(self.pers["3rd_person_crosshair"]) && !self.pers["3rd_person_crosshair"])
			{
				self.crosshairhud.alpha = 0;
				return;
			}
			
			self.crosshairhud.alpha = 1;
		}
		else if(isDefined(self.rc_heli))
			self.crosshairhud.alpha = 1;
	}
}

NVGHUD(enabled)
{
	self endon("disconnect");

	if(self isABot())
		return;
	
	if(isDefined(self.nvghud))
		self.nvghud destroy();
		
	if(enabled)
	{
		self.nvghud = newClientHudElem(self);
		self.nvghud.horzAlign = "fullscreen";
		self.nvghud.vertAlign = "fullscreen";
		self.nvghud.x = 0;
		self.nvghud.y = 0;
		self.nvghud.alpha = 1;
		self.nvghud.foreground = false;
		self.nvghud.archived = true;
		self.nvghud.sort = 1;
		self.nvghud setShader("nightvision_overlay_goggles", 640, 480);
	}
}

NVGiconHUD()
{
	/*self endon("disconnect");

	if(!isDefined(self.nvghudicon))
	{
		self.nvghudicon = newClientHudElem(self);
		self.nvghudicon.horzAlign = "center";
		self.nvghudicon.vertAlign = "bottom";
		self.nvghudicon.x = -12;
		self.nvghudicon.y = -51;
		self.nvghudicon.alpha = 0.65;
		self.nvghudicon.foreground = true;
		self.nvghudicon.archived = false;
		self.nvghudicon.hidewheninmenu = true;
		self.nvghudicon setShader("hud_icon_nvg", 24, 24);
	}
	
	while(1)
	{
		if(self.sessionstate == "playing")
			self.nvghudicon.alpha = 0.65;
		else
			self.nvghudicon.alpha = 0;
	
	wait .1;
	}*/
}

ExtraLife()
{
	self endon("disconnect");

	if(self isABot())
		return;
	
	if(isDefined(self.extralifehud))
		self.extralifehud destroy();

	self.extralifehud = newClientHudElem(self);
	self.extralifehud.alignX = "left";
	self.extralifehud.alignY = "middle";
	self.extralifehud.horzAlign = "fullscreen";
	self.extralifehud.vertAlign = "middle";
	self.extralifehud.x = 500;
	self.extralifehud.y = 170;
	self.extralifehud.alpha = 1;
	self.extralifehud.archived = false;
	self.extralifehud.hidewheninmenu = true;
	self.extralifehud.foreground = true;
	self.extralifehud.hidewheninmenu = true;
	self.extralifehud.sort = 1;
	self.extralifehud setShader( "stance_stand", 64, 64 );
}

showAttackerName(attacker)
{
	self endon("disconnect");

	if(self isABot())
		return;
	
	if(!isDefined(self.killcamAttacker))
	{
		self.killcamAttacker = newClientHudElem(self);
		self.killcamAttacker.elemType = "font";
		self.killcamAttacker.font = "default";
		self.killcamAttacker.fontscale = 2.25;
		self.killcamAttacker.x = 0;
		self.killcamAttacker.y = -160;
		self.killcamAttacker.alignX = "center";
		self.killcamAttacker.alignY = "middle";
		self.killcamAttacker.horzAlign = "center";
		self.killcamAttacker.vertAlign = "middle";
		self.killcamAttacker.foreground = true;
		self.killcamAttacker.archived = false;
		self.killcamAttacker.alpha = 1;
		self.killcamAttacker.sort = 1;
	}
	
	self.killcamAttacker.label = self GetLocalizedString("FOLLOWING");
	self.killcamAttacker setText(attacker.name);
	
	while(level.finalcamplaying)
		wait .1;
		
	self.killcamAttacker destroy();
}

KillstreakHud()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isABot())
		return;
	
	if(isDefined(self.killstreak_hud))
		self.killstreak_hud destroy();

	if(isDefined(level.gameEnded) && level.gameEnded)
		return;
		
	while(!level.roundstarted)
		wait .05;
	
	if(isDefined(self.killstreak_hud))
		self.killstreak_hud destroy();
	
	self.killstreak_hud = newClientHudElem(self);
	self.killstreak_hud.label = &"Killstreak: ^2&&1";
	self.killstreak_hud.alignX = "left";
	self.killstreak_hud.alignY = "bottom";
	self.killstreak_hud.horzAlign = "left";
	self.killstreak_hud.vertAlign = "top";
	self.killstreak_hud.x = 110;
	self.killstreak_hud.y = 35;
	self.killstreak_hud.sort = 1;
	self.killstreak_hud.alpha = 1;
	self.killstreak_hud.archived = false;
	self.killstreak_hud.font = "default";
	self.killstreak_hud.fontScale = 1.4;
	self.killstreak_hud.hidewheninmenu = true;
	self.killstreak_hud setValue(0);
	
	while(isDefined(self.killstreak_hud))
	{
		self waittill("made_a_kill");
		
		if(!isDefined(self.killstreak_hud))
			break;
		
		self.killstreak_hud setValue(self.cur_kill_streak);
	}
}

HardpointLiveTimeHud(hardpoint, timer, definition)
{
	self endon("disconnect");
	self endon("death");
	
	self notify("second_hardpoint_timer");
	self endon("second_hardpoint_timer");

	if(self isABot())
		return;
	
	if(isDefined(self.hardpointTime_hud))
		self.hardpointTime_hud destroy();

	self.hardpointTime_hud = newClientHudElem(self);
	self.hardpointTime_hud.alignX = "left";
	self.hardpointTime_hud.alignY = "bottom";
	self.hardpointTime_hud.horzAlign = "left";
	self.hardpointTime_hud.vertAlign = "top";
	self.hardpointTime_hud.x = 110;
	self.hardpointTime_hud.y = 65;
	self.hardpointTime_hud.sort = 1;
	self.hardpointTime_hud.alpha = 1;
	self.hardpointTime_hud.archived = false;
	self.hardpointTime_hud.font = "default";
	self.hardpointTime_hud.fontScale = 1.4;
	self.hardpointTime_hud.hidewheninmenu = true;

	self thread RemoveHudsonDeath();
	
	if(!isDefined(hardpoint))
	{
		self.hardpointTime_hud.label = &"";
		self.hardpointTime_hud setValue(0);
	}
	else
	{
		if(isDefined(timer) && isDefined(definition))
		{
			if(!isDefined(hardpoint))
				self.hardpointTime_hud.label = &"";
			else
			{
				if(hardpoint == level.ktkWeapon["rccar"]) 			self.hardpointTime_hud.label = &"RC-XD explodes in: ^2&&1";
				else if(hardpoint == level.ktkWeapon["ac130"]) 		self.hardpointTime_hud.label = &"AC130 leaves in: ^2&&1";
				else if(hardpoint == level.ktkWeapon["predator"]) 	self.hardpointTime_hud.label = &"Predator explodes in: ^2&&1";
				else if(hardpoint == level.ktkWeapon["sentrygun"]) 	self.hardpointTime_hud.label = &"Sentry Gun explodes in: ^2&&1";
				else if(hardpoint == "helicopter_mp") 				self.hardpointTime_hud.label = &"Helicopter leaves in: ^2&&1";
				else												self.hardpointTime_hud.label = &"";
			}

			newtimer = int(timer);
			while(newtimer > 0)
			{
				if(!isDefined(self.hardpointTime_hud))
					break;
			
				if(!isDefined(definition))
					break;
			
				if(newtimer == int(newtimer))
					self.hardpointTime_hud setValue(newtimer);
			
				wait .5;
				
				newtimer -= .5;
				
				//just in case the value is not 1 digit after the comma
				newtimer = int(newtimer*10)/10;
			}
		}
		
		if(isDefined(self.hardpointTime_hud))
			self.hardpointTime_hud destroy();
	}
}

containCodesHUD()
{
	level endon("play_finalcam");

	level.captureCrown_text = newHudElem();
	level.captureCrown_text.font = "default";
	level.captureCrown_text.fontScale = 1.4;
	level.captureCrown_text.alignX = "left";
	level.captureCrown_text.alignY = "top";
	level.captureCrown_text.horzAlign = "left";
	level.captureCrown_text.vertAlign = "top";
	level.captureCrown_text.alpha = 0.75;
	level.captureCrown_text.x = 6;
	level.captureCrown_text.y = 135;
	level.captureCrown_text.hidewheninmenu = true;

	level.captureCrown_text.label = &"Codes stolen in: ";
	
	while(1)
	{
	wait .5;
		level.captureCrown_text setValue(level.captureTime);
	}
}

HackTheTerminalHUD()
{
	level endon("play_finalcam");

	level.hackTerminal_text = newHudElem();
	level.hackTerminal_text.font = "default";
	level.hackTerminal_text.fontScale = 1.4;
	level.hackTerminal_text.alignX = "left";
	level.hackTerminal_text.alignY = "bottom";
	level.hackTerminal_text.horzAlign = "left";
	level.hackTerminal_text.vertAlign = "bottom";
	level.hackTerminal_text.alpha = 0.75;
	level.hackTerminal_text.x = 6;
	level.hackTerminal_text.y = 120;
	level.hackTerminal_text.hidewheninmenu = true;

	level.hackTerminal_text.label = &"Terminals left: ";

	while(1)
	{
	wait .5;
		level.hackTerminal_text setValue(level.runningTerminals);
	}
}

RemoveHudsonDeath()
{
    self endon("disconnect");
    
    self notify("remove_huds_on_death_waiter");
    self endon("remove_huds_on_death_waiter");
    
    self waittill("death");
    self RemoveCustomHuds("death");
}

RemoveCustomHuds(type)
{
	if(isDefined(self.ArmorHud)) self.ArmorHud destroy();
    if(isDefined(self.juggernaut)) self.juggernaut destroy();
    if(isDefined(self.gungamehint)) self.gungamehint destroy();
    if(isDefined(self.gungameprogress)) self.gungameprogress destroy();
    if(isDefined(self.gungameprogress2)) self.gungameprogress2 destroy();
    if(isDefined(self.stickyNade_icon)) self.stickyNade_icon destroy();
    if(isDefined(self.stickyNade_text)) self.stickyNade_text destroy();
    if(isDefined(self.moneyhud)) self.moneyhud destroy();
    if(isDefined(self.hardpointTime_hud)) self.hardpointTime_hud destroy();    
    
    if(type == "roundend")
    {
        if(isDefined(self.kinghud_text)) self.kinghud_text destroy();
        if(isDefined(self.killstreak_hud)) self.killstreak_hud destroy();
        if(isDefined(self.kdhud)) self.kdhud destroy();
        if(isDefined(self.crosshairhud)) self.crosshairhud destroy();
		if(isDefined(self.kinghealthhud))
		{
			if(isDefined(self.kinghealthhud.background))
				self.kinghealthhud.background destroy();
			
			self.kinghealthhud destroy();
		}
		
		if(isDefined(self.terminatorhealthhud))
		{
			if(isDefined(self.terminatorhealthhud.background))
				self.terminatorhealthhud.background destroy();
			
			self.terminatorhealthhud destroy();
		}
		
		if(isDefined(level.kinghealthhud))
		{
			if(isDefined(level.kinghealthhud.background))
				level.kinghealthhud.background destroy();
			
			level.kinghealthhud destroy();
		}
		
		if(isDefined(level.terminatorhealthhud))
		{
			if(isDefined(level.terminatorhealthhud.background))
				level.terminatorhealthhud.background destroy();
			
			level.terminatorhealthhud destroy();
		}
    }
}

showHudsForAwardMenu()
{
    if(isDefined(self.juggernaut)) self.juggernaut thread FakeShowHudOnAwardMessage();
    if(isDefined(self.gungamehint)) self.gungamehint thread FakeShowHudOnAwardMessage();
    if(isDefined(self.gungameprogress)) self.gungameprogress thread FakeShowHudOnAwardMessage();
    if(isDefined(self.gungameprogress2)) self.gungameprogress2 thread FakeShowHudOnAwardMessage();
    if(isDefined(self.stickyNade_icon)) self.stickyNade_icon thread FakeShowHudOnAwardMessage();
    if(isDefined(self.stickyNade_text)) self.stickyNade_text thread FakeShowHudOnAwardMessage();
    if(isDefined(self.moneyhud)) self.moneyhud thread FakeShowHudOnAwardMessage();
    if(isDefined(self.hardpointTime_hud)) self.hardpointTime_hud thread FakeShowHudOnAwardMessage();    
    if(isDefined(self.kinghud_text)) self.kinghud_text thread FakeShowHudOnAwardMessage();
	if(isDefined(self.killstreak_hud)) self.killstreak_hud thread FakeShowHudOnAwardMessage();
	if(isDefined(self.kdhud)) self.kdhud thread FakeShowHudOnAwardMessage();
	if(isDefined(self.crosshairhud)) self.crosshairhud thread FakeShowHudOnAwardMessage();
	if(isDefined(self.kinghealthhud))
	{
		if(isDefined(self.kinghealthhud.background))
			self.kinghealthhud.background thread FakeShowHudOnAwardMessage();
			
		self.kinghealthhud thread FakeShowHudOnAwardMessage();
	}
		
	if(isDefined(self.terminatorhealthhud))
	{
		if(isDefined(self.terminatorhealthhud.background))
			self.terminatorhealthhud.background thread FakeShowHudOnAwardMessage();
			
		self.terminatorhealthhud thread FakeShowHudOnAwardMessage();
	}
}

FakeShowHudOnAwardMessage()
{
	self endon("death");

	oldvalue = self.hidewheninmenu;
	
	if(!oldvalue)
		return;

	self.hidewheninmenu = false;
	
	wait 3;
	
	if(isDefined(self))
		self.hidewheninmenu = oldvalue;
}