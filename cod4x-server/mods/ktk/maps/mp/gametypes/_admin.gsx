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
// The XXX_threaded() functions do look bad, but they are necessary to cancel
// the script, when the player dies/disconnects...

#include maps\mp\gametypes\_misc;

init()
{
	thread GetAdmins();
	thread AutoGetSS();

	setDvar("admin_rankrestore","");
	
	setDvar("admin_sayadmin","");
	setDvar("admin_saybold","");
	setDvar("admin_burn","");
	setDvar("admin_explode","");
	setDvar("admin_kill","");
	setDvar("admin_afk","");
	setDvar("admin_switch","");
	setDvar("admin_disableweapon","");
	setDvar("admin_enableweapon","");
	setDvar("admin_spawn","");
	setDvar("admin_teleport","");
	setDvar("admin_noclip","");
	setDvar("admin_freeze","");
	
	setDvar("admin_kick","");
	setDvar("admin_ban","");
	
	setDvar("admin_rebootServer","");
	setDvar("admin_dvarChange","");
	setDvar("admin_ExecutePlayerCmd","");
	setDvar("admin_getss","");
	
	setDvar("admin_changeEvent","");
	level.adminChangedEvent = false;
	level.adminMapSwitch = undefined;
	
	setDvar("admin_mutePlayer","");
	setDvar("admin_changeMap","");
	
	level._effect["barrelExp"] = LoadFX( "props/barrelExp" );
	level._effect["firelp_med_pm"] = LoadFX( "fire/firelp_med_pm" );

	for(;;)
	{
	wait .1;
		if(getdvar("admin_sayadmin") != "") thread Admin_Message();
		if(getdvar("admin_saybold") != "") thread Admin_Bold();
		if(getdvar("admin_burn") != "") thread Admin_Burn();
		if(getdvar("admin_explode") != "") thread Admin_Explode();
		if(getdvar("admin_switch") != "") thread Admin_Switch();
		if(getdvar("admin_afk") != "") thread Admin_AFK();
		if(getdvar("admin_kill") != "") thread Admin_Kill();
		if(getdvar("admin_disableweapon") != "") thread Admin_DisableWeapon();
		if(getdvar("admin_enableweapon") != "") thread Admin_EnableWeapon();
		if(getdvar("admin_spawn") != "") thread Admin_spawnPlayer();
		if(getdvar("admin_teleport") != "") thread Admin_Teleport();
		if(getdvar("admin_noclip") != "") thread Admin_Noclip();
		if(getdvar("admin_freeze") != "") thread Admin_Freeze();
		
		if(getdvar("admin_kick") != "") thread Admin_Kick();
		if(getdvar("admin_ban") != "") thread Admin_Ban();
		
		if(getdvar("admin_rankrestore") != "") thread RestoreRank();
		if(getDvar("admin_rebootServer") != "") thread Admin_ServerReboot();
		if(getdvar("admin_dvarChange") != "") thread Admin_changeProtectedDvar();
		if(getdvar("admin_ExecutePlayerCmd") != "") thread Admin_ExecuteCmdOnPlayer();
		if(getdvar("admin_getss") != "") thread Admin_GetPBScreenshot();
		
		if(getdvar("admin_changeEvent") != "") thread Admin_ChangeEvent();
		if(getdvar("admin_mutePlayer") != "") thread Admin_MutePlayerThread();
		if(getdvar("admin_changeMap") != "") thread Admin_ChangeMapThread();
	}
}

GetAdmins()
{ 
	level.admins = [];
	index = 1;

	while(1) 
	{ 
		wait .1; 
		level.admins[index-1] = strTok(getDvar("scr_loginpass_admin_" + index), ";");
		
		if(!isDefined(level.admins[index-1]) || !isDefined(level.admins[index-1][0]) || !isDefined(level.admins[index-1][1]))
		{
			level.admins[index-1] = undefined;
			break;
		}
			
		index++;
	}
}

/* taken out - not secure
login(guid)
{
	self endon("disconnect");

	for(i=0;i<level.admins.size;i++) 
	{ 
		if(guid == level.admins[i])
		{
			self.pers["admin"] = true;
			self setClientDvar("i_am_admin", 1);
			self thread ExecClientCommand("rcon login " + getDvar("rcon_password"));
			self thread onPlayerSpawned();
			break;
		}
	}
}
*/

login(slot)
{
	self endon("disconnect");

	if(!isDefined(level.admins) || !level.admins.size)
		return false;

	if(!isDefined(level.admins[slot]) || !level.admins[slot].size)
		return false;

	if(!isDefined(level.admins[slot][2]))
		return false;
	
	if(level.admins[slot][2] == "member")
	{
		self setClientDvar("i_am_admin", 1);
		self.pers["adminStatus"] = 1;
	}
	
	if(level.admins[slot][2] == "mod")
	{
		self setClientDvar("i_am_admin", 2);
		self.pers["adminStatus"] = 2;
	}
		
	if(level.admins[slot][2] == "admin")
	{
		self setClientDvar("i_am_admin", 3);
		self.pers["adminStatus"] = 3;
	
		if(getDvarInt("scr_admin_rconlogin") == 1)
			self thread ExecClientCommand("rcon login " + getDvar("rcon_password"));
	}
	
	self.pers["admin"] = true;
	return true;
}

Admin_Message()
{
	adminMsg = getdvar("admin_sayadmin");
	setdvar("admin_sayadmin", "");
	
	notifyData = spawnStruct();
	notifyData.titleText = "^1THE ADMIN:";
	notifyData.notifyText = (adminMsg);
	notifyData.Duration = 7.0;
	notifyData.sound = "mp_last_stand";

	for(i=0;i<level.players.size;i++)
		level.players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

Admin_bold()
{
	//for(i=0;i<level.players.size;i++)
	//	level.players[i] iprintlnbold(getdvar("admin_saybold"));

	iprintlnbold(getdvar("admin_saybold"));

	setdvar("admin_saybold", "");
}

Admin_Teleport()
{
	command = strTok(getDvar("admin_teleport") , ";");
	setdvar("admin_teleport", "");

	player[0] = getPlayer(command[0]);
	player[1] = getPlayer(command[1]);
	admin = getPlayer(command[2]);

	if(!CanExecuteAdminCmd("teleport", player, admin))
		return;

	if(isDefined(player[0]) && isAlive(player[0]) && isDefined(player[1]) && isAlive(player[1]))
		player[0] setOrigin(player[1].origin);
}

Admin_burn()
{
	command = strTok(getDvar("admin_burn") , ";");
	setdvar("admin_burn", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("burn", player, admin))
		return;
	
	if(!isDefined(player.burnedout))
		player.burnedout = false;
	
	if(isDefined(player) && !player isASpectator() && isAlive(player) && !player.burnedout)
		player thread _burn_threaded();
}

_burn_threaded()
{
	self endon("death");
	self endon("disconnect");

	self.burnedout = true;

	if(self isDogModel())
		PlayFxOnTag(level._effect["firelp_med_pm"], self, "j_spine2");
	else
		PlayFxOnTag(level._effect["firelp_med_pm"], self, "torso_stabilizer");
	
	wait .1;
	self ShellShock( "default", 4 );
	wait 4.5;

	if(self isInRCToy() || self isInParachute() || self isInAC130() || self isInMannedHelicopterTurret())
	{
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
		wait .1;
	}

	self.godmode = false;
	self.burnedout = false;
	self clearPerks();
	self suicide();
}

Admin_explode()
{
	command = strTok(getDvar("admin_explode") , ";");
	setdvar("admin_explode", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("explode", player, admin))
		return;
	
	if(!isDefined(player.exploded))
		player.exploded = false;
	
	if(isDefined(player) && !player isASpectator() && isAlive(player) && !player.exploded)
		player thread _explode_threaded();
}

_explode_threaded()
{
	self endon("death");
	self endon("disconnect");

	self.exploded = true;
	
	if(self isInRCToy() || self isInParachute() || self isInAC130() || self isInMannedHelicopterTurret())
	{
		self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
		wait .1;
	}
		
	PlayFX(level._effect["barrelExp"], self.origin);
	self playsound("explo_mine");
	self.godmode = false;
	self.exploded = false;
	self clearPerks();
	self suicide();
}

Admin_Kill()
{
	command = strTok(getDvar("admin_kill") , ";");
	setdvar("admin_kill", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("kill", player, admin))
		return;

	if(isDefined(player) && isAlive(player))
	{
		if(player isInRCToy() || player isInParachute() || player isInAC130() || player isInMannedHelicopterTurret())
		{
			player maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
			wait .1;
		}
			
		player.godmode = false;
		player clearPerks();
		player suicide();
	}
}

Admin_disableweapon()
{
	command = strTok(getDvar("admin_disableweapon") , ";");
	setdvar("admin_disableweapon", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("disableweapon", player, admin))
		return;
	
	if(isDefined(player) && !player isASpectator() && isAlive(player) && (!isDefined(player.disableweapon) || !player.disableweapon))
	{
		player disableWeapons();
		player.disableweapon = true;
	}
}

Admin_enableweapon()
{
	command = strTok(getDvar("admin_enableweapon") , ";");
	setdvar("admin_enableweapon", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("enableweapon", player, admin))
		return;
	
	if(isDefined(player) && !player isASpectator() && isAlive(player) && isDefined(player.disableweapon) && player.disableweapon)
	{
		player enableWeapons();
		player.disableweapon = false;
	}
}

Admin_Switch()
{
	command = strTok(getDvar("admin_switch") , ";");
	setdvar("admin_switch", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("switch", player, admin))
		return;

	if(isDefined(player))
	{
		DebugMessage(1, "Admin-Switch of " + player.name);
	
		if(player isAnAssassin())
		{
			player [[level.spectator]]();
			wait .1;
			
			if(isDefined(player))
			{
				scr_iprintln( "ADMIN_HE_WAS_SWITCHED", undefined, player.name, " ^2Guardians" );
				scr_iprintlnbold( "ADMIN_YOU_WERE_SWITCHED", player, "^2Guardians" );
				player [[level.switchTeam]](game["defenders"], false, true);
			}
		}
		else if(player isAGuard())
		{
			player [[level.spectator]]();
			wait .1;
			
			if(isDefined(player))
			{
				scr_iprintln( "ADMIN_HE_WAS_SWITCHED", undefined, player.name, " ^1Assassins" );
				scr_iprintlnbold( "ADMIN_YOU_WERE_SWITCHED", player, "^1Assassins" );
				player [[level.switchTeam]](game["attackers"], false, true);
			}
		}
		else if(player isASpectator())
		{
			if(isDefined(player.pers["afkteam"]) && isDefined(level.roundStarted) && level.roundStarted)
			{
				scr_iprintln("ACP_ERROR_NO_SPAWN");
				return;
			}
		
			playerCounts = player maps\mp\gametypes\_teams::CountPlayers();
			
			if(playerCounts[game["attackers"]] < playerCounts[game["defenders"]])
				player [[level.switchTeam]](game["attackers"], false, true);
			else if(playerCounts[game["defenders"]] < playerCounts[game["attackers"]])
				player [[level.switchTeam]](game["defenders"], false, true);			
			else
			{
				if(isDefined(player.pers["afkteam"]))
				{
					player [[level.switchTeam]](player.pers["afkteam"], false, true);
					player.pers["afkteam"] = undefined;
				}
				else
				{
					if(randomInt(2) == 0)
						player [[level.switchTeam]](game["attackers"], false, true);
					else
						player [[level.switchTeam]](game["defenders"], false, true);
				}
			}				

			scr_iprintln( "ADMIN_HE_IS_BACK", undefined, player.name );
		}
	}
}

Admin_AFK()
{
	command = strTok(getDvar("admin_afk") , ";");
	setdvar("admin_afk", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("afk", player, admin))
		return;

	if(isDefined(player))
	{
		DebugMessage(1, "Admin-AFK-Switch of " + player.name);
	
		if(player isASpectator())
			player.pers["afkteam"] = game["attackers"];
		else	
			player.pers["afkteam"] = player.pers["team"];

		//if(level.gametype == "ktk" && player isKing())
		//	thread maps\mp\gametypes\ktk::onEndGame(game["attackers"], "KING_DIED", "died");
		player thread maps\mp\gametypes\ktk::ReselectImportantPlayer();			
		player [[level.spectator]]();
		scr_iprintlnbold("YOU_APPEAR_AFK", player);
		scr_iprintln( "HE_APPEARS_AFK", undefined, player.name );
	}
}

Admin_spawnPlayer()
{
	command = strTok(getDvar("admin_spawn") , ";");
	setdvar("admin_spawn", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("spawn", player, admin))
		return;

	if(isDefined(player))
	{
		if(!isDefined(player.pers["team"]) || player isASpectator())
			player [[level.autoassign]]();
		else
		{
			if(player.pers["team"] == "allies")
				player [[level.allies]]();
			else
				player [[level.axis]]();
		}
	}
}

Admin_Kick()
{
	command = strTok(getDvar("admin_kick") , ";");
	setdvar("admin_kick", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("kick", player, admin))
		return;

	if(isDefined(player))
	{
		//Kick(player getEntityNumber());
		exec("kick " + player getEntityNumber());
	}
}

Admin_Ban()
{
	command = strTok(getDvar("admin_ban") , ";");
	setdvar("admin_ban", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("ban", player, admin))
		return;

	if(isDefined(player))
	{
		//Ban(player getEntityNumber());
		exec("ban " + player getEntityNumber());
	}
}

RestoreRank()
{
	Restore = strTok( getDvar("admin_rankrestore") , ":" );
	setdvar("admin_rankrestore", "");

	if(!isDefined(level.roundstarted) || !level.roundstarted)
	{
		scr_iPrintLn("ACP_ERROR_NO_RANKUPDATE");
			return;
	}
	
	//0 = playerid, 1=rank, 2=prestige, 3=allow to overwrite higher ranks
	if(!isDefined(Restore[0]) /*|| !isDefined(Restore[1]) || !isDefined(Restore[2])*/)
		return;

	if(!isDefined(Restore[3]))
		Restore[3] = 1;
		
	player = undefined;
	
	for(i=0;i<3;i++)
	{
		if(i == 0)
		{
			player = getPlayer(Restore[i]);
			continue;
		}
		else
		{
			if(isDefined(Restore[i]) && (Restore[i] == "" || Restore[i] == " "))
				Restore[i] = undefined;
		
			if(!isDefined(Restore[i]))
				continue;
				
			Restore[i] = int(Restore[i]);
		
			if(i == 1)
			{
				Restore[i]--;

				if(Restore[i] >= level.maxRank)
					Restore[i] = level.maxRank;
					
				continue;
			}
				
			if(i == 2 && Restore[i] >= level.maxPrestige)
				Restore[i] = level.maxPrestige;
		}
	}
	
	if(isDefined(player))
		player thread _restore_threaded(Restore);
}

_restore_threaded(Restore)
{
	self endon("disconnect");
	//self endon("death");
	
	if(!isDefined(Restore[1]))
		Restore[1] = self.pers["rank"];
		
	if(!isDefined(Restore[2]))
		Restore[2] = self.pers["prestige"];
	
	if(!Restore[3])
	{
		if(self.pers["prestige"] > Restore[2])
		{
			scr_iprintln( "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER", undefined, self.name );
			return;
		}
		else if(self.pers["prestige"] == Restore[2])
		{
			if(self.pers["rank"] == Restore[1])
			{
				scr_iprintln( "ACP_ERROR_NO_RESTORE_RANK_EQUAL", undefined, self.name );
				return;
			}
			else if(self.pers["rank"] > Restore[1])
			{
				scr_iprintln( "ACP_ERROR_NO_RESTORE_RANK_HIGHER", undefined, self.name );
				return;
			}
		}
	}

	if(Restore[2] < self.pers["prestige"])
	{
		//reset prestige points & unlockables
		for(i=2359;i<2387;i++)
			self setKtkStat(i, 0);
	}

	self.pers["prestige"] = Restore[2];

	if(Restore[1] != self.pers["rank"])
	{
		self.pers["rankxp"] = 1;
		self.pers["rank"] = 0;

		for(i=self.pers["rank"];i<Restore[1];i++)
		{
			self maps\mp\gametypes\_rank::giveRankXp("kill", int(level.rankTable[self.pers["prestige"]][i][3]), true);
			wait .1;
		}
	}
		
	self setKtkStat( 252, self.pers["rank"]);
	self setKtkStat( 2356, self.pers["rank"]);
	self setKtkStat( 2357, self.pers["prestige"] );
	self setKtkStat( 2359, self.pers["prestige"] );
	self setKtkStat( 2326, self.pers["prestige"] );
	self setKtkStat( 2360, 0);
	
	self setRank(self.pers["rank"], self.pers["prestige"]);
}

getPlayer(value)
{
	if(!isDefined(value) || !value.size)
		return;

	//A Name for sure
	if(value.size > 2)
	{
		counter = 0;
		player = 0;

		for(i=0;i<level.players.size;i++)
		{
			if(isSubStr(toLower(level.players[i].name), toLower(value))) 
			{
				player = level.players[i];
				counter++;
			}
		}
		
		if(counter == 1)
			return player;
		else	
		{
			if(counter == 0)
				scr_iPrintLn("ACP_ERROR_NO_PLAYER_FOUND");
			else
				scr_iPrintLn("ACP_ERROR_MANY_PLAYERS_FOUND");
		}
	}
	//A Slot
	else
	{
		for(i=0;i<level.players.size;i++)
		{
			if(level.players[i] getEntityNumber() == int(value)) 
				return level.players[i];
		}
	}
	
	return undefined;
}

CanExecuteAdminCmd(cmd, player, admin)
{
	if(cmd == "teleport")
		return CanExecuteTeleport(cmd, player, admin);

	if(!isDefined(player) || !isPlayer(player))
		return false;

	//was called from the admin menu (it's undefined when called with rcon)
	if(!isDefined(admin))
	{
		scr_iprintln( "ACP_COMMAND_EXECUTED_RCON", undefined, cmd, player.name );
		//iPrintLn("^1ACP: An admin executed '" + cmd + "' on " + player.name + " via rcon.");
		//iPrintLn("^1ACP error: '" + cmd + "' can not be executed via rcon.");
	}
	else
	{
		if(!isDefined(admin.pers["adminStatus"]) || !admin.pers["adminStatus"])
		{
			iPrintLn("^1ACP: " + admin.name + "^1has not enough power to execute '" + cmd + "' on " + player.name + ".");
			return false;
		}
		
		if(isDefined(player.pers["adminStatus"]) && player.pers["adminStatus"] > admin.pers["adminStatus"])
		{
			iPrintLn("^1ACP: " + admin.name + "^1has not enough power to execute '" + cmd + "' on " + player.name + ".");
			return false;
		}
			
		iPrintLn("^1ACP: " + admin.name + "^1 executed '" + cmd + "' on " + player.name + ".");
	}

	return true;
}

CanExecuteTeleport(cmd, player, admin)
{
	
	if(!isDefined(player) || player.size < 2)
		return false;
	
	//was called from the admin menu (it's undefined when called with rcon)
	if(!isDefined(admin))
	{
		iPrintLn("^1ACP: An admin '" + cmd + "ed' " + player[0].name + " to " + player[1].name + " via rcon.");
		//iPrintLn("^1ACP error: '" + cmd + "' can not be executed via rcon.");
	}	
	else
	{
		if(!isDefined(admin.pers["adminStatus"]) || !admin.pers["adminStatus"])
		{
			iPrintLn("^1ACP: " + admin.name + "^1has not enough power to execute '" + cmd + "' on " + player[0].name + " and " + player[1].name + ".");
			return false;
		}
		
		if(isDefined(player[0].pers["adminStatus"]) && player[0].pers["adminStatus"] > admin.pers["adminStatus"])
		{
			iPrintLn("^1ACP: " + admin.name + "^1has not enough power to execute '" + cmd + "' on " + player[0].name + ".");
			return false;
		}
		
		if(isDefined(player[1].pers["adminStatus"]) && player[1].pers["adminStatus"] > admin.pers["adminStatus"])
		{
			iPrintLn("^1ACP: " + admin.name + "^1has not enough power to execute '" + cmd + "' on " + player[1].name + ".");
			return false;
		}
			
		iPrintLn("^1ACP: " + admin.name + " '" + cmd + "ed' " + player[0].name + " to " + player[1].name + ".");
	}
	
	return true;
}

Admin_ServerReboot()
{
	mapname = getDvar("admin_rebootServer");	

	setdvar("admin_rebootServer", "");
	
	if(!isDefined(mapname) || mapname == "")
	{
		if(isDefined(level.script))
			mapname = level.script;
		else
			mapname = "mp_shipment";
	}

	for(i=0;i<level.players.size;i++)
		level.players[i] execClientCommand("reconnect");
	
	exec("killserver;wait 1;map " + mapname);
}

Admin_changeProtectedDvar()
{
	command = strTok(getDvar("admin_dvarChange") , " ");
	setdvar("admin_dvarChange", "");

	if(!isDefined(command[1]))
	{
		scr_iPrintLn("ACP_ERROR_DVAR_NO_VALUE", undefined, command[0]);
		return;
	}
	
	if(command[0] == "jump_height")
	{
		if(int(command[1]) >= 9999)
		{
			setDvar("bg_fallDamageMaxHeight", int(command[1]));
			setDvar("bg_fallDamageMinHeight", int(int(command[1]) - 1));
		}
		else
		{
			setDvar("bg_fallDamageMaxHeight", int(int(command[1])*7.69));
			setDvar("bg_fallDamageMinHeight", int(int(command[1])*3.28));
		}
	}

	scr_iPrintLn("ACP_ERROR_DVAR_VALUE_CHANGED", undefined, command[0], command[1]);
	
	setDvar(command[0], command[1]);
}

Admin_ExecuteCmdOnPlayer()
{
	command = strTok(getDvar("admin_ExecutePlayerCmd") , ":");
	setdvar("admin_ExecutePlayerCmd", "");

	player = getPlayer(command[0]);
	admin = undefined;

	if(!CanExecuteAdminCmd("playercmd", player, admin))
		return;

	if(isDefined(player) && isDefined(command[1]))
	{
		if(getSubStr(command[1], 0, 8) == "say_team")
			player sayTeam(getSubStr(command[1], 9, command[1].size));
		else if(getSubStr(command[1], 0, 3) == "say")
			player sayAll(getSubStr(command[1], 4, command[1].size));
		else
			player execClientCommand(command[1]);
	}
}

AutoGetSS()
{
	setting = getDvarInt("scr_admin_autoGetSS");
	lastValue = getDvarInt("autoGetSS_cur");

	if(setting <= 0)
	{
		setDvar("autoGetSS_cur", 0);
		return;
	}
	
	if(game["roundsplayed"] == 0)
		delay = setting;
	else
	{
		if(lastValue <= 0)
			delay = setting;
		else
			delay = lastValue;
	}
	
	while(1)
	{
		for(i=1;i<=delay;i++)
		{
			wait 1;
			
			setDvar("autoGetSS_cur", int(delay-i));
			
			if(isDefined(level.gameEnded) && level.gameEnded)
				return;
		}

		while(!isDefined(level.roundStarted) || !level.roundStarted)
			wait .05;
		
		exec("getss all");

		delay = setting;
	}
}

Admin_GetPBScreenshot()
{
	command = strTok(getDvar("admin_getss") , ";");
	setdvar("admin_getss", "");

	if(isDefined(command[0]))
		exec("getss " + command[0]);
}

Admin_ChangeEvent()
{
	eventname = getDvar("admin_changeEvent");	

	setdvar("admin_changeEvent", "");
	
	if(!isDefined(eventname) || eventname == "")
		return;
		
	eventname = getEventNameFromShortcut(eventname);
		
	if(isDefined(game["customEvent"]) && game["customEvent"] == eventname)
	{
		scr_iPrintLn("ACP_ERROR_EVENT_IN_PROGRESS");
		return;
	}
		
	/*timeLeft = maps\mp\gametypes\_globallogic::timeUntilRoundEnd();
	if(!isDefined(timeLeft) || timeLeft < 3)
	{
		iPrintLn("^1Unable to start/stop event - Not enough time to load settings!");
		return;
	}*/
	
	if(eventname == "none")
	{
		scr_iPrintLn("ACP_EVENT_STOPPED");
		//thread maps\mp\gametypes\ktk::execConfig(0, getDvar("scr_mod_ktk_mainconfig"), "Loading default config");
	}
	else
	{
		scr_iPrintLn("ACP_EVENT_STARTED", undefined, eventname);
		//thread maps\mp\gametypes\ktk::execConfig(0, getDvar("scr_mod_ktk_mainconfig"), "Loading default config");
		//wait 2;
		//thread maps\mp\gametypes\ktk::execConfig(0, "config/events/" + eventname + ".cfg", "Loading event config: " + eventname);
	}
	
	setDvar("scr_mod_ktk_gameevent", eventname);
	level.adminChangedEvent = true;
}

Admin_MutePlayerThread()
{
	command = strTok(getDvar("admin_mutePlayer") , ":");
	setdvar("admin_mutePlayer", "");

	player = getPlayer(command[0]);
	admin = undefined;

	if(!CanExecuteAdminCmd("mutecmd", player, admin))
		return;

	if(!isDefined(command[1]))
		command[1] = 1;
		
	if(!isDefined(command[2]))
		command[2] = "";
		
	if(isDefined(player) && isDefined(command[1]))
	{
		if(int(command[1]) == 1)
		{
			if(!isPlayerChatMuted(player))
			{
				mutePlayerChat(player, int(1));
				player thread maps\mp\gametypes\_mute::writeMuteFile(command[2]);
			}
		}
		else
		{
			if(isPlayerChatMuted(player))
			{
				scr_iprintlnbold("ACP_PLAYER_UNMUTED", player);
				
				mutePlayerChat(player, int(0));
				thread maps\mp\gametypes\_mute::deleteMuteFile(player.guid); //player GetUniquePlayerID());
			}
		}
	}
}

Admin_ChangeMapThread()
{
	mapname = getDvar("admin_changeMap");	

	setdvar("admin_changeMap", "");
	
	if(!isDefined(mapname) || mapname == "")
		return;

	level.adminMapSwitch = true;
	setDvar("sv_maprotation","gametype " + level.gametype + " map " + mapname);
	setDvar("sv_maprotationcurrent", "gametype " + level.gametype + " map " + mapname);

	maps\mp\gametypes\_bots::kickAllBots();
	maps\mp\gametypes\_bots::updatePezbotMapList();
	exitLevel(false);
}

Admin_Noclip()
{
	command = strTok(getDvar("admin_noclip") , ";");
	setdvar("admin_noclip", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("noclip", player, admin))
		return;
	
	if(!isDefined(player.inUfoMode))
		player.inUfoMode = false;
	
	if(isDefined(player) && !player isASpectator() && isAlive(player))
	{
		if(!player.inUfoMode)
		{
			player iPrintLnBold("^1Noclip enabled!");
			player thread _noclip_threaded();
		}
		else
		{
			player iPrintLnBold("^1Noclip disabled!");
		
			player unlink();
		
			player.inUfoMode = false;
			
			if(isdefined(player.newufo))
				player.newufo delete();
		}
	}
}

_noclip_threaded()
{
	self endon("disconnect");
	self endon("death");
	self endon("joined_spectators");

	self.inUfoMode = true;

	if(isdefined(self.newufo))
		self.newufo delete();
	
	self.newufo = spawn("script_origin", self.origin);
	self linkTo(self.newufo);

	ufoSpeed = 30;	
	while(self.inUfoMode)
	{
		angles = self getPlayerAngles();
		
		if(self forwardButtonPressed() || self backButtonPressed())
		{
			forward = anglesToForward(angles) * ufoSpeed;
			
			if(self forwardButtonPressed())
				self.newufo.origin = self.newufo.origin + forward;
			else
				self.newufo.origin = self.newufo.origin - forward;
		}
			
		if(self moveleftbuttonpressed() || self moverightbuttonpressed())
		{
			right = anglesToRight(angles) * ufoSpeed;
			
			if(self moverightbuttonpressed())
				self.newufo.origin = self.newufo.origin + right;
			else
				self.newufo.origin = self.newufo.origin - right;
		}
			
		if(self leanLeftButtonPressed() || self leanRightButtonPressed())
		{
			up = anglesToUp(angles) * ufoSpeed;
			
			if(self leanRightButtonPressed())
				self.newufo.origin = self.newufo.origin + up;
			else
				self.newufo.origin = self.newufo.origin - up;
		}

		wait .05;
	}

	self unlink();

	if(isdefined(self.newufo))
		self.newufo delete();
		
	self.godmode = false;
}

Admin_Freeze()
{
	command = strTok(getDvar("admin_freeze") , ";");
	setdvar("admin_freeze", "");

	player = getPlayer(command[0]);
	admin = getPlayer(command[1]);

	if(!CanExecuteAdminCmd("freeze", player, admin))
		return;
	
	if(!isDefined(player.isFrozen))
		player.isFrozen = false;
	
	if(isDefined(player) && !player isASpectator() && isAlive(player))
	{
		if(!player.isFrozen)
		{
			player iPrintLnBold("^1You are frozen!");
			player freezeControls(true);
			player.isFrozen = true;
		}
		else
		{
			player iPrintLnBold("^1You are thawed!");
			player freezeControls(false);
			player.isFrozen = false;
		}
	}
}