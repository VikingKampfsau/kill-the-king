#include maps\mp\gametypes\_misc;

init()
{
	game["menu_team"] = "team_marinesopfor";
	
	//do i need these?
	game["menu_class_allies"] = "class_marines";
	game["menu_changeclass_allies"] = "changeclass_marines";
	game["menu_initteam_allies"] = "initteam_marines";
	game["menu_class_axis"] = "class_opfor";
	game["menu_changeclass_axis"] = "changeclass_opfor";
	game["menu_initteam_axis"] = "initteam_opfor";
	game["menu_changeclass"] = "changeclass";
	game["menu_changeclass_offline"] = "changeclass_offline";
	
	game["menu_about"] = "about";
	game["menu_class"] = "class";
	game["menu_ghillie"] = "changeghillie";
	game["menu_clientcmd"] = "clientcmd";
	game["menu_unlockables"] = "unlockables";
	game["menu_adminmenu_1"] = "adminmenu_1";
	game["menu_adminaction"] = "adminaction";
	game["menu_adminlogin"] = "adminlogin";
	game["menu_language"] = "language";
	game["menu_ktk_settings"] = "ktk_settings";
	game["menu_addktkfavorit"] = "popup_addfavorite";
	game["menu_challenge_reset"] = "popup_reset_challenge";
	game["menu_ktk_hardpoint_selection"] = "ktk_hardpoint_selection";
	game["menu_keybinding"] = "keybinding";
	game["menu_charactermenu"] = "charactermenu";
	game["menu_character_warning"] = "popup_character_warning";
	game["menu_award_msg"] = "award_msg";
	
	if ( !level.console )
	{
		game["menu_callvote"] = "callvote";
		game["menu_muteplayer"] = "muteplayer";
		//precacheMenu(game["menu_callvote"]); not used in ktk
		//precacheMenu(game["menu_muteplayer"]); not used in ktk
		
		// ---- back up one folder to access game_summary.menu ----
		// game summary menu file precache
		game["menu_eog_main"] = "endofgame";
		
		// menu names (do not precache since they are in game_summary_ingame which should be precached
		game["menu_eog_unlock"] = "popup_unlock";
		game["menu_eog_summary"] = "popup_summary";
		game["menu_eog_unlock_page1"] = "popup_unlock_page1";
		game["menu_eog_unlock_page2"] = "popup_unlock_page2";
		
		/* not needed in ktk - removed to avoid reaching the precacheMenu limit
		precacheMenu(game["menu_eog_unlock"]);
		precacheMenu(game["menu_eog_summary"]);
		precacheMenu(game["menu_eog_unlock_page1"]);
		precacheMenu(game["menu_eog_unlock_page2"]); */
	
	}
	else
	{
		game["menu_controls"] = "ingame_controls";
		game["menu_options"] = "ingame_options";
		game["menu_leavegame"] = "popup_leavegame";

		if(level.splitscreen)
		{
			game["menu_team"] += "_splitscreen";
			game["menu_class_allies"] += "_splitscreen";
			game["menu_changeclass_allies"] += "_splitscreen";
			game["menu_class_axis"] += "_splitscreen";
			game["menu_changeclass_axis"] += "_splitscreen";
			game["menu_class"] += "_splitscreen";
			game["menu_changeclass"] += "_splitscreen";
			game["menu_controls"] += "_splitscreen";
			game["menu_options"] += "_splitscreen";
			game["menu_leavegame"] += "_splitscreen";
		}

		precacheMenu(game["menu_controls"]);
		precacheMenu(game["menu_options"]);
		precacheMenu(game["menu_leavegame"]);
	}

	precacheMenu(game["menu_ghillie"]);
	precacheMenu(game["menu_clientcmd"]);
	precacheMenu(game["menu_unlockables"]);
	precacheMenu(game["menu_adminmenu_1"]);
	precacheMenu(game["menu_adminaction"]);
	precacheMenu(game["menu_adminlogin"]);
	precacheMenu(game["menu_language"]);
	precacheMenu(game["menu_ktk_settings"]);
	precacheMenu(game["menu_addktkfavorit"]);
	precacheMenu(game["menu_about"]);
	precacheMenu(game["menu_challenge_reset"]);
	precacheMenu(game["menu_ktk_hardpoint_selection"]);
	precacheMenu(game["menu_eog_main"]);
	precacheMenu(game["menu_keybinding"]);
	precacheMenu(game["menu_charactermenu"]);
	precacheMenu(game["menu_character_warning"]);
	precacheMenu(game["menu_award_msg"]);
	
	precacheMenu("scoreboard");
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_class_allies"]);
	//precacheMenu(game["menu_changeclass_allies"]);
	precacheMenu(game["menu_initteam_allies"]);
	precacheMenu(game["menu_class_axis"]);
	//precacheMenu(game["menu_changeclass_axis"]);
	precacheMenu(game["menu_class"]);
	//precacheMenu(game["menu_changeclass"]);
	precacheMenu(game["menu_initteam_axis"]);
	//precacheMenu(game["menu_changeclass_offline"]);
	precacheString( &"MP_HOST_ENDED_GAME" );
	precacheString( &"MP_HOST_ENDGAME_RESPONSE" );

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);

		player thread onFirstSpawn();
		player thread onMenuResponse();
	}
}

onFirstSpawn()
{
	self endon("disconnect");
	self waittill("spawned_player");

	self.pers["nvg"] = false;
	
	if(self isABot())
	{
		self.pers["enableText"] = false;
		self.pers["enable3DWaypoints"] = false;
		self.pers["enableDeathIcons"] = false;
		self.pers["thirdperson"] = false;
		self.pers["dogthirdperson"] = false;
		return;
	}
	
	if(self getKtkStat(2408) == 1)
		self.pers["enableText"] = true;
	else
		self.pers["enableText"] = false;

	if(self getKtkStat(2409) == 1)
		self.pers["enable3DWaypoints"] = true;
	else
		self.pers["enable3DWaypoints"] = false;

	if(self getKtkStat(2410) == 1)
		self.pers["enableDeathIcons"] = true;
	else
		self.pers["enableDeathIcons"] = false;
	
	if(self getKtkStat(2403) == 1)
		self.pers["thirdperson"] = true;
	else
		self.pers["thirdperson"] = false;

	if(self getKtkStat(2414) == 1)
		self.pers["dogthirdperson"] = true;
	else
		self.pers["dogthirdperson"] = false;
		
	if(self getKtkStat(2417) == 1)
		self.pers["3rd_person_crosshair"] = true;
	else
		self.pers["3rd_person_crosshair"] = false;

	self thread maps\mp\gametypes\_huds::Crosshair();
}

onMenuResponse()
{
	self endon("disconnect");
	
	if(self isABot())
		return;
	
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		
		//logPrint(menu + ";" + response);
		//iPrintLnBold(menu + ";" + response);
		
		//KILL THE KING
		//***********************************
		//Suggestion report
		if(isSubStr(response, "suggestion:"))
		{
			text = strTok(response, ":");
			if(!isDefined(text[1]) || text[1] == "" || text[1] == " ")
				continue;
		
			DebugMessage(2, text[1]);
		}

		//Bug report
		if(isSubStr(response, "bug:"))
		{
			text = strTok(response, ":");
			if(!isDefined(text[1]) || text[1] == "" || text[1] == " ")
				continue;
		
			DebugMessage(3, text[1]);
		}
	
		//Suicide
		if(response == "suicide")
		{
			if(!isDefined(level.roundstarted) || !level.roundstarted)
			{
				self iPrintLnBold("^1You can not suicide during the selections!");
				continue;
			}
			
			if(self isInRCCar())
			{
				self.rc_car thread maps\mp\gametypes\_rccar::Explode(self);
				continue;
			}
			
			if(self isInRCHelicopter())
			{
				self.rc_heli thread maps\mp\gametypes\_rchelicopter::Explode();
				continue;
			}
		
			if(self isKing())
				self iPrintLnBold("^1The king can not suicide!");
			else
				self suicide();
				
			continue;
		}		
		
		if(response == "toggle_nvg")
		{
			self thread maps\mp\gametypes\_nightvision::ToggleNVG();
			continue;
		}
		
		if(menu == game["menu_unlockables"])
		{
			if(response == "back")
			{
				self closeMenu();
				self closeInGameMenu();
				continue;
			}
		
			self thread maps\mp\gametypes\_unlockables::unlockableResponseHandler(response);
			continue;
		}
		
		//Hardpoint selection
		if(menu == game["menu_ktk_hardpoint_selection"])
		{
			if(isSubStr(response, "hardpoints_description_"))
			{
				search = getSubStr(response, 23, response.size);
					
				if(search == "nodesc")
					dvarset = "";
				else
				{
					if(self.pers["language"] != "RU")
						dvarset = (TableLookup("mp/unlockables.csv",0,search,2) + "_" + self.pers["language"]);
					else
						dvarset = (self.pers["language"] + TableLookup("mp/unlockables.csv",0,search,2) + "_" + self.pers["language"]);
				}

				self setClientDvar("hardpoints_description", dvarset);
			}
		
			if(isSubStr(response, "activated_hardpoint_"))
			{
				self setKtkStat(2387, self getKtkStat(2387)+1);
				self setKtkStat(int(GetSubStr(response,20,response.size)), 1);
				self.pers["update_selected_hardpoints"] = true;
			}
				
			if(isSubStr(response, "locked_hardpoint_"))
			{
				self setKtkStat(2387, self getKtkStat(2387)-1);
				self setKtkStat(int(GetSubStr(response,17,response.size)), 0);
				self.pers["update_selected_hardpoints"] = true;
					
				if(self getKtkStat(2387) < 0)
					self setKtkStat(2387, 0);
			}

			if(isSubStr(response, "reset_hardpoint_selection"))
			{
				for(i=2387;i<=2398;i++)
					self setKtkStat(i, 0);
				
				self.pers["update_selected_hardpoints"] = true;
			}
			
			if(response == "back")
			{
				self closeMenu();
				self closeInGameMenu();
			
				if(isDefined(self.pers["update_selected_hardpoints"]) && self.pers["update_selected_hardpoints"])
				{
					scr_iPrintLnBold("HARDPOINTS_WILL_CHANGE", self);
					self thread UpdateHardpointSelection();
				}
			}
			
			if(response == "ToggleRCType")
			{
				if(self getKtkStat(2399) == 0)
					self setKtkStat(2399, 1);
				else
					self setKtkStat(2399, 0);
			}
			
			continue;
		}

		//Reset Challenges
		if(isSubStr(response, "reset_challenge_table"))
		{
			self.pers["reset_challenge_table"] = getSubStr(response, 22, response.size);
			continue;
		}

		if(isSubStr(response, "reset_challenge_slot"))
		{
			self.pers["reset_challenge_slot"] = getSubStr(response, 21, response.size);
			continue;
		}
		
		if(menu == game["menu_challenge_reset"])
		{
			if(getDvarInt("scr_mod_blockChallengeReset"))
				continue;
		
			if(response == "reset_challenge")
			{			
				if(isDefined(self.pers["reset_challenge_table"]) && isDefined(self.pers["reset_challenge_slot"]))
				{
					self setKtkStat(int(TableLookUp(self.pers["reset_challenge_table"], 1, self.pers["reset_challenge_slot"], 2)), 1);
					self setKtkStat(int(TableLookUp(self.pers["reset_challenge_table"], 1, self.pers["reset_challenge_slot"], 3)), 0);
				}
			}
			continue;
		}
		
		//GuidSpoof Fix for AdminMenu - Idea by Braxi
		//Admin tries to log in
		if(isSubStr(response, "login:"))
		{
			if(!isDefined(level.admins) || !level.admins.size)
				continue;
		
			tokens = strTok( response, ":" );
			
			if(tokens.size && tokens[0] == "login" && (!isDefined(self.pers["admin"]) || !self.pers["admin"]))
			{
				//self.guid = self GetUniquePlayerID();

				if(tokens.size > 2)
				{
					for(i=0;i<level.admins.size;i++) 
					{
						if(tokens[1] == level.admins[i][0] && tokens[2] == level.admins[i][1])
						{
							if(self thread maps\mp\gametypes\_admin::login(i))
							{
								scr_iPrintlnBold("LOGGED_IN", self);
								DebugMessage(4, "ADMINMENU;" + self.name + " [" + self.guid + "] has logged in as " + level.admins[i][0]);
							}
							
							break;
						}
					}
				}
				
				if(isDefined(self.pers["admin"]) && self.pers["admin"])
					continue;

				scr_iPrintlnBold("LOGIN_FAILED", self);
				DebugMessage(4, "ADMINMENU;" + self.name + " [" + self.guid + "] failed to login!");
				scr_iPrintLn("ACP_ERROR_FAILED_LOGIN", undefined, self.name);
			}
			continue;
		}
		
		//AdminMenu - open it
		if(response == game["menu_adminmenu_1"])
		{
			self closeMenu();
			self closeInGameMenu();

			if(!isDefined(self.pers["admin"]) || !self.pers["admin"])
			{
				//scr_iPrintlnBold("NO_PERMISSION", self);
				
				self openMenu(game["menu_adminlogin"]);
			}
			else
			{
				self openMenu(game["menu_adminmenu_1"]);
			}
			continue;
		}
		
		//AdminMenu - Selection
		if(menu == game["menu_adminmenu_1"])
		{
			//AdminMenu - update players
			if(isSubStr(response, "admin_update_playerlist"))
			{
				for(i=0;i<level.players.size;i++)
					self setClientDvar("adminmenu_name_" + level.players[i] getEntityNumber(), level.players[i].name);
				
				continue;
			}
		
			//AdminMenu - select a player to punish
			if(isSubStr(response, "admin_selected_"))
			{
				//makes sure players can't use through the console
				if(!isDefined(self.pers["admin"]) || !self.pers["admin"])
					scr_iPrintlnBold("NO_PERMISSION", self);

				victim = undefined;
				self.punishplayer = GetSubStr(response,15,response.size);
				
				if(isDefined(self.punishplayer))
				{
					victim = maps\mp\gametypes\_admin::getPlayer(self.punishplayer);
				
					if(!isDefined(victim) || !isDefined(victim.name))
						self setClientDvars("_selected", self.punishplayer, "_selected_name", "");
					else
						self setClientDvars("_selected", self.punishplayer, "_selected_name", victim.name);
				}
				
				continue;
			}
		}
		
		//AdminMenu - Make sure the popup menus get detected too
		if(isSubStr(response, "admin_action_changeEvent") || isSubStr(response, "admin_action_rank") || isSubStr(response, "admin_action_norank"))
			menu = game["menu_adminaction"];
		
		//AdminMenu - Actions
		if(menu == game["menu_adminmenu_1"] || menu == game["menu_adminaction"])
		{
			if(isSubStr(response, "admin_action_"))
			{
				//makes sure players can't use through the console
				if(!isDefined(self.pers["admin"]) || !self.pers["admin"])
					scr_iPrintlnBold("NO_PERMISSION", self);

				// ** server changes **
				if(response == "admin_action_endround")
				{
					setDvar("scr_ktk_timelimit", "0.1");
					continue;
				}
				if(response == "admin_action_endmap")
				{
					setDvar("scr_ktk_roundlimit", "1");
					setDvar("scr_ktk_timelimit", "0.1");
					continue;
				}
				if(response == "admin_action_restartmap")
				{
					exec("say ^1Restarting Map in 5 seconds!");
					wait 5;
					exec("map_restart"); //map_restart(false); default CoD4 function is just a fast_restart -> Risk to result in a Server CMD overflow
					continue;
				}
				if(isSubStr(response, "admin_action_changeEvent"))
				{
					iPrintLnBold(GetSubStr(response,25,response.size));
					setDvar("admin_changeEvent", GetSubStr(response,25,response.size));
					continue;
				}

				// ** punishment for the selected player **
				if(isDefined(self.punishplayer))
				{
					if(isSubStr(response, "admin_action_rank"))
					{
						if(response == "admin_action_rank_tr" || response == "admin_action_rank_tp")
						{
							if(response == "admin_action_rank_tr")
								setDvar("player_rankto", getDvar("temp_value"));
							else
								setDvar("player_prestigeto", getDvar("temp_value"));
							
							setDvar("temp_value", "");
							self setClientDvar("temp_value", getDvar("temp_value"));
							continue;
						}
					
						if(isSubStr(response, "admin_action_rank_"))
						{
							setDvar("temp_value", getDvar("temp_value") + GetSubStr(response,18,response.size));
							self setClientDvar("temp_value", getDvar("temp_value"));
						}
					
						if(response == "admin_action_rankrestore" || response == "admin_action_norankrestore")
						{
							if(response == "admin_action_rankrestore")
							{
								if(getDvar("player_rankto") == "")
									setDvar("player_rankto", " ");
									
								setDvar("admin_rankrestore", self.punishplayer + ":" + getDvar("player_rankto") + ":" + getDvar("player_prestigeto"));
							}
							
							setDvar("temp_value", "");
							setDvar("player_rankto", "");
							setDvar("player_prestigeto", "");
						}
					}
					else
					{
						if(response == "admin_action_kick" || response == "admin_action_ban")
							self setClientDvar("adminmenu_name_" + self.punishplayer, "");

						if(response == "admin_action_spec")
						{
							self.pers["adminspec"] = int(self.punishplayer);
							self [[level.spectator]]();
							continue;
						}
						
						if(!isSubStr(response, "admin_action_teleport_"))
							setDvar("admin_" + GetSubStr(response,13,response.size), self.punishplayer + ";" + self.name);
						else
						{
							self setClientDvar("admin_teleporting", 0);
							self.teleporttarget = GetSubStr(response,22,response.size);
							
							if(isDefined(self.punishplayer) && isDefined(self.teleporttarget))
								setDvar("admin_teleport", self.punishplayer + ";" + self.teleporttarget + ";" + self.name);
						}
					}
				}
				
				continue;
			}
		}
		
		//Open GhillieMenu
		if(response == game["menu_ghillie"])
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu(game["menu_ghillie"]);
			self.isPickingGhillie = true;
			continue;
		}

		//Choose Ghillie
		if(menu == game["menu_ghillie"])
		{
			if(response == "woodland" || response == "desert" || response == "winter" || response == "none")
			{
				self closeMenu();
				self closeInGameMenu();
				self setKtkStat(level.ghillieStat, maps\mp\gametypes\_charactermenu::getGhillieStatFromType(response));
				self.pers["ghillie"] = response;
				scr_iPrintlnBold("GHILLIE_CHANGES", self);
				
				if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator")
					self thread maps\mp\gametypes\_charactermenu::openCharacterMenu();
				
				continue;
			}
			
			if(response == "back")
			{
				self closeMenu();
				self closeInGameMenu();
			
				if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator")
					self thread maps\mp\gametypes\_charactermenu::openCharacterMenu();
					
				self.isPickingGhillie = false;
					
				continue;
			}
		}

		if(response == "ktk_lobby_opened")
		{
			if(getDvarInt("scr_mod_mapvote") != 2)
			{				
				self closeMenu();
				self closeInGameMenu();
			}
			
			continue;
		}
		
		//PlayerMenu (Settings)
		if(menu == game["menu_ktk_settings"] || menu == game["menu_keybinding"])
		{
			switch(response)		
			{
				case "enter_prestige": //enter next prestige
					self thread maps\mp\gametypes\_rank::EnterNextPrestige(false);
					break;
					
				case "toggle_badges":
					if(self getKtkStat(2358) == 0)
					{
						if((!isDefined(self.pers["admin"]) || !self.pers["admin"]) && (!isDefined(self.pers["vip"]) || !self.pers["vip"]))
							break;
						
						self setKtkStat(2358, 1);
						//self setClientDvar("r_ktk_badge", 1);
						
						if(isDefined(self.pers["admin"]) && self.pers["admin"])
						{
							if(isDefined(self.pers["adminStatus"]) && self.pers["adminStatus"] == 3)
								self.statusicon = "admin_icon";
							else
							{
								self.statusicon = "";
								self setKtkStat(2358, 0);
								//self setClientDvar("r_ktk_badge", 0);
							}
						}
						else if(isDefined(self.pers["vip"]) && self.pers["vip"])
							self.statusicon = "vip_icon";
						else
						{
							self.statusicon = "";
							self setKtkStat(2358, 0);
							//self setClientDvar("r_ktk_badge", 0);
						}
					}
					else
					{
						self.statusicon = "";
						self setKtkStat(2358, 0);
						//self setClientDvar("r_ktk_badge", 0);
					}
					break;
					
				case "toggle_thirdperson":
					if(self getKtkStat(2403) == 0)
					{
						self.pers["thirdperson"] = true;
						self setKtkStat(2403, 1);
					}
					else
					{
						self.pers["thirdperson"] = false;
						self setKtkStat(2403, 0);
					}
					
					//if(self isDog())
						//self setClientDvar("cg_thirdperson", 0);
					
					//if(menu == game["menu_keybinding"])
						//self setClientDvar("cg_thirdperson", self getKtkStat(2403));
					
					self thread maps\mp\gametypes\_huds::Crosshair();
					
					break;
					
				case "toggle_dogthirdperson":
					if(self getKtkStat(2414) == 0)
					{
						self.pers["dogthirdperson"] = true;
						self setKtkStat(2414, 1);
					}
					else
					{
						self.pers["dogthirdperson"] = false;
						self setKtkStat(2414, 0);
					}

					//if(self isDog())
						//self setClientDvar("cg_thirdperson", self getKtkStat(2414));
					
					break;
					
				case "toggle_fullbright":
					if(self getKtkStat(2401) == 0)
						self setKtkStat(2401, 1);
					else 
						self setKtkStat(2401, 0);
						
					//if(menu == game["menu_keybinding"])
						//self setClientDvar("r_fullbright", self getKtkStat(2401));
						
					break;
						
				case "toggle_ammocounter":
					if(self getKtkStat(2402) == 0)
						self setKtkStat(2402, 1);
					else 
						self setKtkStat(2402, 0);
						
					//if(menu == game["menu_keybinding"])
						//self setClientDvar("cg_drawAmmoNum", self getKtkStat(2402));
						
					break;
					
				case "toggle_laser":
					if(self getKtkStat(2404) == 0)
						self setKtkStat(2404, 1);
					else 
						self setKtkStat(2404, 0);

					//if(menu == game["menu_keybinding"])
						//self setClientDvar("cg_laserforceon", self getKtkStat(2404));
						
					break;
					
				case "toggle_fov":
					if(self getKtkStat(2406) == 0 || self getKtkStat(2406) == 65)
						self setKtkStat(2406, 72);
					else if(self getKtkStat(2406) == 72)
						self setKtkStat(2406, 80);
					else if(self getKtkStat(2406) == 80)
						self setKtkStat(2406, 65);

					//if(menu == game["menu_keybinding"])
						//self setClientDvar("cg_fov", self getKtkStat(2406));
						
					break;
					
				case "toggle_fovscale":
					if(self getKtkStat(2407) == 0)
						self setKtkStat(2407, 125);
					else if(self getKtkStat(2407) == 125)
						self setKtkStat(2407, 250);
					else if(self getKtkStat(2407) == 250)
						self setKtkStat(2407, 375);
					else if(self getKtkStat(2407) == 375)
						self setKtkStat(2407, 500);
					else
						self setKtkStat(2407, 0);

					break;
					
				case "toggle_vision":
					if(self getKtkStat(2405) == 0)
						self setKtkStat(2405, 1);
					else 
						self setKtkStat(2405, 0);
					
					//if(menu == game["menu_keybinding"])
						//self setClientDvar("r_ktk_vision", self getKtkStat(2405));
					
					self thread maps\mp\gametypes\_vision::init();
					break;
					
				case "xpTextToggle":
					if(self getKtkStat(2408) == 0)
					{
						self setKtkStat(2408, 1);
						self.pers["enableText"] = true;
						//self setClientDvar("ui_xpText", 1);
					}
					else
					{
						self setKtkStat(2408, 0);
						self.pers["enableText"] = false;
						//self setClientDvar("ui_xpText", 0);
					}
					break;

				case "waypointToggle":
					if(self getKtkStat(2409) == 0)
					{
						self setKtkStat(2409, 1);
						self.pers["enable3DWaypoints"] = true;
						//self setClientDvar("ui_3dwaypointtext", 1);
					}
					else
					{
						self setKtkStat(2409, 0);
						self.pers["enable3DWaypoints"] = false;
						//self setClientDvar("ui_3dwaypointtext", 0);
					}
					break;

				case "deathIconToggle":
					if(self getKtkStat(2410) == 0)
					{
						self setKtkStat(2410, 1);
						self.pers["enableDeathIcons"] = true;
						//self setClientDvar("ui_deathicontext", 1);
					}
					else
					{
						self setKtkStat(2410, 0);
						self.pers["enableDeathIcons"] = false;
						//self setClientDvar("ui_deathicontext", 0);
					}
					break;
					
				case "bloodsplatterToggle":
					if(self getKtkStat(2411) == 0)
					{
						self setKtkStat(2411, 1);
						//self setClientDvar("r_ktk_bloodsplatter", 1);
					}
					else
					{
						self setKtkStat(2411, 0);
						//self setClientDvar("r_ktk_bloodsplatter", 0);
					}
					break;
				
				case "AutoMeleeToggle":
					if(self getKtkStat(2412) == 0)
					{
						self setKtkStat(2412, 1);
						//self setClientDvar("aim_automelee_enabled", 1);
						self setClientDvar("aim_automelee_range", 128);
					}
					else
					{
						self setKtkStat(2412, 0);
						//self setClientDvar("aim_automelee_enabled", 0);
						self setClientDvar("aim_automelee_range", 0);
					}
					break;
					
				case "KillcamToggle":
					if(self getKtkStat(2413) == 0)
					{
						self setKtkStat(2413, 1);
						//self setClientDvar("r_ktk_disablekillcam", 1);
					}
					else
					{
						self setKtkStat(2413, 0);
						//self setClientDvar("r_ktk_disablekillcam", 0);
					}
					break;
				
				case "ToggleSlaveOrDog":
					if(self getKtkStat(2415) == 0)
					{
						self setKtkStat(2415, 1);
						//self setClientDvar("r_ktk_slaveordog", 1);
					}
					else
					{
						self setKtkStat(2415, 0);
						//self setClientDvar("r_ktk_slaveordog", 0);
					}
					break;
				
				case "TogglePrestiging":
					if(self getKtkStat(2416) == 0)
					{
						self setKtkStat(2416, 1);
						//self setClientDvar("r_ktk_prestiging", 1);
					}
					else
					{
						self setKtkStat(2416, 0);
						//self setClientDvar("r_ktk_prestiging", 0);
					}
					break;
					
				case "Toggle3rdCrosshaird":
					if(self getKtkStat(2417) == 0)
					{
						self setKtkStat(2417, 1);
						self.pers["3rd_person_crosshair"] = true;
						//self setClientDvar("r_ktk_crosshaird_3rd", 1);
					}
					else
					{
						self setKtkStat(2417, 0);
						self.pers["3rd_person_crosshair"] = false;
						//self setClientDvar("r_ktk_crosshaird_3rd", 0);
					}
					self thread maps\mp\gametypes\_huds::Crosshair();
					break;
					
				case "ToggleHealthbarType":
					if(self getKtkStat(2418) == 0)
					{
						self setKtkStat(2418, 1);
						//self.pers["healthbar_type"] = 1;
						//self setClientDvar("r_ktk_healthbar_type", 1);
					}
					else
					{
						self setKtkStat(2418, 0);
						//self.pers["healthbar_type"] = 0;
						//self setClientDvar("r_ktk_healthbar_type", 0);
					}
					self maps\mp\gametypes\_huds::KingHealthHUD();
					self notify("update_healthbar", "king");
					break;
					
				case "ToggleSelectionPreference_King":
					if(self getKtkStat(2368) == 0)
					{
						self setKtkStat(2368, 1);
						//self setClientDvar("r_ktk_preference_king", 1);
					}
					else if(self getKtkStat(2368) == 1)
					{
						self setKtkStat(2368, 2);
						//self setClientDvar("r_ktk_preference_king", 2);
					}
					else
					{
						self setKtkStat(2368, 0);
						//self setClientDvar("r_ktk_preference_king", 0);
					}
					break;
					
				case "ToggleSelectionPreference_Assassin":
					if(self getKtkStat(2367) == 0)
					{
						self setKtkStat(2367, 1);
						//self setClientDvar("r_ktk_preference_assassin", 1);
					}
					else if(self getKtkStat(2367) == 1)
					{
						self setKtkStat(2367, 2);
						//self setClientDvar("r_ktk_preference_assassin", 2);
					}
					else
					{
						self setKtkStat(2367, 0);
						//self setClientDvar("r_ktk_preference_assassin", 0);
					}
					break;
					
				case "ToggleSelectionPreference_Slave":
					if(self getKtkStat(2369) == 0)
					{
						self setKtkStat(2369, 1);
						//self setClientDvar("r_ktk_preference_slave", 1);
					}
					else if(self getKtkStat(2369) == 1)
					{
						self setKtkStat(2369, 2);
						//self setClientDvar("r_ktk_preference_slave", 2);
					}
					else
					{
						self setKtkStat(2369, 0);
						//self setClientDvar("r_ktk_preference_slave", 0);
					}
					break;
					
				default: break;
			}
			
			continue;
		}
		
		//Switch Language
		if(menu == game["menu_language"] && isSubStr(response, "language_"))
		{
			language = GetSubStr(response, 9, response.size);

			switch(language)
			{
				case "ENG":	self.pers["language"] = "ENG";
							self setKtkStat(2400, 0);
							break;
				case "FR":	self.pers["language"] = "FR";
							self setKtkStat(2400, 1);
							break;
				case "DE":	self.pers["language"] = "DE";
							self setKtkStat(2400, 2);
							break;
				case "IT":	self.pers["language"] = "IT";
							self setKtkStat(2400, 3);
							break;
				case "ESP":	self.pers["language"] = "ESP";
							self setKtkStat(2400, 4);
							break;
				case "RU":	self.pers["language"] = "RU";
							self setKtkStat(2400, 5);
							break;
				case "PL":	self.pers["language"] = "PL";
							self setKtkStat(2400, 6);
							break;
				case "HUN":	self.pers["language"] = "HUN";
							self setKtkStat(2400, 7);
							break;
				
				default: break;
			}
			
			if(self.pers["language"] == "RU")
				self setClientDvars("r_language", "_" + self.pers["language"], "r_language_utf", self.pers["language"]);
			else
				self setClientDvars("r_language", "_" + self.pers["language"], "r_language_utf", "");
			
			continue;
		}
		
		if(response == "weaponDrop")
		{
			weapon = self getCurrentWeapon();
			
			if(!isDefined(weapon) || weapon == "" || weapon == "none")
				continue;
		
			if(isHardpoint(weapon) || isAGrenade(weapon) || isOtherExplosive(weapon))
				continue;
	
			if(!isDefined(level.roundstarted) || !level.roundstarted)
				continue;
	
			self dropItem(weapon);
			
			continue;
		}

		//The Lobby at the end of the map
		if(menu == game["menu_eog_main"])
		{
			if(getDvarInt("scr_mod_mapvote") != 2)
				continue;
		
			if(isSubStr(response, "reset_chat_message"))
			{
				wait .1;
				self setClientDvar("chat_message", "say ");
				continue;
			}
			
			if(isSubStr(response, "vote_map"))
			{
				self thread maps\mp\gametypes\_mapvote::castVote(response);
				continue;
			}
		}
		
		//check this one last
		self thread maps\mp\gametypes\_charactermenu::characterCustomizationMenu(response);
		
		//***********************************

		if ( response == "back" )
		{
			self closeMenu();
			self closeInGameMenu();

			if ( level.console )
			{
				if( menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"] || menu == game["menu_team"] || menu == game["menu_controls"] )
				{
//					assert(self.pers["team"] == "allies" || self.pers["team"] == "axis");
	
					if( self.pers["team"] == "allies" )
						self openMenu( game["menu_class_allies"] );
					if( self.pers["team"] == "axis" )
						self openMenu( game["menu_class_axis"] );
				}
			}
			continue;
		}
		
		if(response == "changeteam")
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu(game["menu_team"]);
		}
	
		if(response == "changeclass_marines" )
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu( game["menu_changeclass_allies"] );
			continue;
		}

		if(response == "changeclass_opfor" )
		{
			self closeMenu();
			self closeInGameMenu();
			self openMenu( game["menu_changeclass_axis"] );
			continue;
		}

		if(response == "changeclass_marines_splitscreen" )
			self openMenu( "changeclass_marines_splitscreen" );

		if(response == "changeclass_opfor_splitscreen" )
			self openMenu( "changeclass_opfor_splitscreen" );
		
		if(response == "endgame")
		{
			// TODO: replace with onSomethingEvent call 
			if(level.splitscreen)
			{
				if ( level.console )
					endparty();
				level.skipVote = true;

				if ( !level.gameEnded )
				{
					level thread maps\mp\gametypes\_globallogic::forceEnd();
				}
			}
				
			continue;
		}

		if ( response == "endround" && level.console )
		{
			if ( !level.gameEnded )
			{
				level thread maps\mp\gametypes\_globallogic::forceEnd();
			}
			else
			{
				self closeMenu();
				self closeInGameMenu();
				self iprintln( &"MP_HOST_ENDGAME_RESPONSE" );
			}			
			continue;
		}

		if(menu == game["menu_team"])
		{
			switch(response)
			{
				case "allies":
				case "axis":
				case "spectator":
					break;
				
				case "autoassign":
					if(game["customEvent"] == "hideandseek")
					{
						if(game["attackers"] == "allies")
							self [[level.allies]]();
						else
							self [[level.axis]]();
					}
					else
					{				
						if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator")
							self [[level.autoassign]]();
					}
					break;
				
				case "create_player_backup":
					self closeMenu();
					self closeInGameMenu();
					self thread maps\mp\gametypes\_profilebackup::collectPlayerData();
					break;
				
				case "restore_player_backup":
					self closeMenu();
					self closeInGameMenu();
					self thread maps\mp\gametypes\_profilebackup::loadPlayerBackupFile();
					break;
			}
		}
		else if( menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"] )
		{
			self closeMenu();
			self closeInGameMenu();

			self.selectedClass = true;
			self [[level.class]](response);
		}
		else if ( !level.console )
		{
			if(menu == game["menu_quickcommands"])
				maps\mp\gametypes\_quickmessages::quickcommands(response);
			else if(menu == game["menu_quickstatements"])
				maps\mp\gametypes\_quickmessages::quickstatements(response);
			else if(menu == game["menu_quickresponses"])
				maps\mp\gametypes\_quickmessages::quickresponses(response);
		}
		
		// ======== catching response for create-a-class events ========
		/*
		responseTok = strTok( response, "," );
		
		if( isdefined( responseTok ) && responseTok.size > 1 )
		{
			if( responseTok[0] == "primary" )
			{	
				// primary weapon selection
				assertex( responseTok.size != 2, "Primary weapon selection in create-a-class-ingame is sending bad response:" + response );
				
				stat_offset = cacMenuStatOffset( menu, response );
				self setstat( stat_offset+201, ( int( tableLookup( "mp/statsTable.csv", 4, responseTok[1], 1 ) ) - 3000 ) );
			}
			else if( responseTok[0] == "attachment" )
			{	
				// primary or secondary weapon attachment selection
				assertex( responseTok.size != 3, "Weapon attachment selection in create-a-class-ingame is sending bad response:" + response );
				
				stat_offset = cacMenuStatOffset( menu, response );
				if( responseTok[1] == "primary" )
					self setstat( stat_offset+202, int( tableLookup( "mp/attachmentTable.csv", 4, responseTok[2], 9 ) ) );
				else if( responseTok[1] == "secondary" )
					self setstat( stat_offset+204, int( tableLookup( "mp/attachmentTable.csv", 4, responseTok[2], 9 ) ) );
			}
			else if( responseTok[0] == "secondary" )
			{
				// secondary weapon selection
				assertex( responseTok.size != 2, "Secondary weapon selection in create-a-class-ingame is sending bad response:" + response );
				
				stat_offset = cacMenuStatOffset( menu, response );
				self setstat( stat_offset+203, ( int( tableLookup( "mp/statsTable.csv", 4, responseTok[1], 1 ) ) - 3000 ) );
			}
			else if( responseTok[0] == "perk" )
			{
				// all 3 perks selection
				assertex( responseTok.size != 3, "Perks selection in create-a-class-ingame is sending bad response:" + response );
				
				stat_offset = cacMenuStatOffset( menu, response );
				self setstat( stat_offset+200+int(responseTok[1]), int( tableLookup( "mp/statsTable.csv", 4, responseTok[2], 1 ) ) );
			}
			else if( responseTok[0] == "sgrenade" )
			{
				assertex( responseTok.size != 2, "Special grenade selection in create-a-class-ingame is sending bad response:" + response );
				
				stat_offset = cacMenuStatOffset( menu, response );
				self setstat( stat_offset+208, ( int( tableLookup( "mp/statsTable.csv", 4, responseTok[1], 1 ) ) - 3000 ) );
			}
			else if( responseTok[0] == "camo" )
			{
				assertex( responseTok.size != 2, "Primary weapon camo skin selection in create-a-class-ingame is sending bad response:" + response );
				
				stat_offset = cacMenuStatOffset( menu, response );
				self setstat( stat_offset+209, int( tableLookup( "mp/attachmentTable.csv", 4, responseTok[2], 11 ) ) );					
			}
		}
		*/
	}
}

/*
// sort response message from CAC menu
cacMenuStatOffset( menu, response )
{
	stat_offset = -1;
	
	if( menu == "menu_cac_assault" )
		stat_offset = 0;
	else if( menu == "menu_cac_specops" )
		stat_offset = 10;
	else if( menu == "menu_cac_heavygunner" )
		stat_offset = 20;
	else if( menu == "menu_cac_demolitions" )
		stat_offset = 30;
	else if( menu == "menu_cac_sniper" )
		stat_offset = 40;
	
	assertex( stat_offset >= 0, "The response: " + response + " came from non-CAC menu" );	
	
	return stat_offset;
}
*/