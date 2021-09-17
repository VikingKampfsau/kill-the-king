#include maps\mp\gametypes\_misc;

init()
{
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";

	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);
	precacheHeadIcon("talkingicon");

	precacheString( &"QUICKMESSAGE_FOLLOW_ME" );
	precacheString( &"QUICKMESSAGE_MOVE_IN" );
	precacheString( &"QUICKMESSAGE_FALL_BACK" );
	precacheString( &"QUICKMESSAGE_SUPPRESSING_FIRE" );
	precacheString( &"QUICKMESSAGE_ATTACK_LEFT_FLANK" );
	precacheString( &"QUICKMESSAGE_ATTACK_RIGHT_FLANK" );
	precacheString( &"QUICKMESSAGE_HOLD_THIS_POSITION" );
	precacheString( &"QUICKMESSAGE_REGROUP" );
	precacheString( &"QUICKMESSAGE_ENEMY_SPOTTED" );
	precacheString( &"QUICKMESSAGE_ENEMIES_SPOTTED" );
	precacheString( &"QUICKMESSAGE_IM_IN_POSITION" );
	precacheString( &"QUICKMESSAGE_AREA_SECURE" );
	precacheString( &"QUICKMESSAGE_GRENADE" );
	precacheString( &"QUICKMESSAGE_SNIPER" );
	precacheString( &"QUICKMESSAGE_NEED_REINFORCEMENTS" );
	precacheString( &"QUICKMESSAGE_HOLD_YOUR_FIRE" );
	precacheString( &"QUICKMESSAGE_YES_SIR" );
	precacheString( &"QUICKMESSAGE_NO_SIR" );
	precacheString( &"QUICKMESSAGE_IM_ON_MY_WAY" );
	precacheString( &"QUICKMESSAGE_SORRY" );
	precacheString( &"QUICKMESSAGE_GREAT_SHOT" );
	precacheString( &"QUICKMESSAGE_TOOK_LONG_ENOUGH" );
	precacheString( &"QUICKMESSAGE_ARE_YOU_CRAZY" );	
	precacheString( &"QUICKMESSAGE_WATCH_SIX" );	
	precacheString( &"QUICKMESSAGE_COME_ON" );	
}

playermenu(response) 
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	/*switch(response)		
	{
		case "1": //enter next prestige

			maxrankxp = maps\mp\gametypes\_rank::getRankInfoMaxXp( level.maxRank );
		
			if(self.pers["rank"] == level.maxRank && self.pers["rankxp"] == maxrankxp && self.pers["prestige"] != level.maxPrestige)			
			{
				self.pers["prestige"]++;
				self.pers["rankxp"] = 1;
				self.pers["rank"] = self maps\mp\gametypes\_rank::getRankForXp( self.pers["rankxp"] );
				
				self UpdateRankInfo();
				self setKtkStat( 251, self.pers["rank"] );
				self setKtkStat( 252, self.pers["rank"] );
			
				self setRank( 0, self.pers["prestige"] );
				self setKtkStat( 2359, self getKtkStat(2359) + 1 );
			}
			else if(self.pers["prestige"] == level.maxPrestige)
				scr_iPrintLnBold("PRESTIGE_MAX_REACHED", self);
			else
				scr_iPrintLnBold("PRESTIGE_REQUIREMENTS", self);
				
			break;
			
		case "2": //toggle badges

			if(self getKtkStat(2358) == 0)
			{
				if(!self.pers["admin"] && !self.pers["vip"])
				{
					scr_iPrintLnBold("NO_BADGE", self);
					return;
				}
				
				self setKtkStat(2358, 1);
				scr_iPrintLnBold("BADGE_ON"));
				
				if(self.pers["admin"]) self.statusicon = "admin_icon";
				else if(self.pers["vip"]) self.statusicon = "vip_icon";
			}
			else
			{
				scr_iPrintLnBold("BADGE_OFF", self);
				self.statusicon = "";
				self setKtkStat(2358, 0);
			}
			break;
			
		case "3": //toggle thirdperson view

			if(!isdefined(self.pers["thirdperson"]) || (isdefined(self.pers["thirdperson"]) && !self.pers["thirdperson"]))
			{
				self setClientDvar("cg_thirdperson",1);
				self.pers["thirdperson"] = true;
			}
			else
			{
				self setClientDvar("cg_thirdperson",0);
				self.pers["thirdperson"] = false;
			}
			
			self thread maps\mp\gametypes\_huds::Crosshair();
			break;
			
		case "4": //toggle laser

			if(!isdefined(self.pers["laser"]) || (isdefined(self.pers["laser"]) && !self.pers["laser"]))
			{
				self setClientDvar("cg_laserforceon",1);
				self.pers["laser"] = true;
			}
			else
			{
				self setClientDvar("cg_laserforceon",0);
				self.pers["laser"] = false;
			}
			break;

		case "5": //toggle FoV

			if(!isdefined(self.pers["maxfov"]) || (isdefined(self.pers["maxfov"]) && !self.pers["maxfov"]))
			{
				self setClientDvar( "cg_fov", "80" );
				self.pers["maxfov"] = true;
			}
			else
			{
				self setClientDvar( "cg_fov", "65" );
				self.pers["maxfov"] = false;
			}
			break;
			
		case "6": //toggle Vision

			if(!isdefined(self.pers["vision"]) || (isdefined(self.pers["vision"]) && self.pers["vision"]))
			{
				scr_iPrintLnBold("VISION_OFF", self);
				self.pers["vision"] = false;
				self thread maps\mp\gametypes\_vision::init();
			}
			else
			{
				scr_iPrintLnBold("VISION_ON", self);
				self.pers["vision"] = true;
				self thread maps\mp\gametypes\_vision::init();
			}
			break;
		
		case "7": //suicide

			if(self isDog())
				self suicide();
			else
				scr_iPrintLnBold("DOG_SUICIDE", self);
			break;
			
		default: return;
	}*/
}

quickcommands(response)
{
	self endon ( "disconnect" );
	
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;
	
	switch(response)		
	{
		case "1":
			soundalias = "mp_cmd_followme";
			saytext = &"QUICKMESSAGE_FOLLOW_ME";
			//saytext = "Follow Me!";
			break;

		case "2":
			soundalias = "mp_cmd_movein";
			saytext = &"QUICKMESSAGE_MOVE_IN";
			//saytext = "Move in!";
			break;

		case "3":
			soundalias = "mp_cmd_fallback";
			saytext = &"QUICKMESSAGE_FALL_BACK";
			//saytext = "Fall back!";
			break;

		case "4":
			soundalias = "mp_cmd_suppressfire";
			saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
			//saytext = "Suppressing fire!";
			break;

		case "5":
			soundalias = "mp_cmd_attackleftflank";
			saytext = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
			//saytext = "Attack left flank!";
			break;

		case "6":
			soundalias = "mp_cmd_attackrightflank";
			saytext = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
			//saytext = "Attack right flank!";
			break;

		case "7":
			soundalias = "mp_cmd_holdposition";
			saytext = &"QUICKMESSAGE_HOLD_THIS_POSITION";
			//saytext = "Hold this position!";
			break;

		default:
			assert(response == "8");
			soundalias = "mp_cmd_regroup";
			saytext = &"QUICKMESSAGE_REGROUP";
			//saytext = "Regroup!";
			break;
	}
	
	thread maps\mp\gametypes\_bots::reactToOrder(soundalias);

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;
	self restoreHeadIcon();	
}

quickstatements(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;
	
	switch(response)		
	{
		case "1":
			soundalias = "mp_stm_enemyspotted";
			saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
			//saytext = "Enemy spotted!";
			break;

		case "2":
			soundalias = "mp_stm_enemiesspotted";
			saytext = &"QUICKMESSAGE_ENEMIES_SPOTTED";
			//saytext = "Enemy down!";
			break;

		case "3":
			soundalias = "mp_stm_iminposition";
			saytext = &"QUICKMESSAGE_IM_IN_POSITION";
			//saytext = "I'm in position.";
			break;

		case "4":
			soundalias = "mp_stm_areasecure";
			saytext = &"QUICKMESSAGE_AREA_SECURE";
			//saytext = "Area secure!";
			break;

		case "5":
			soundalias = "mp_stm_watchsix";
			saytext = &"QUICKMESSAGE_WATCH_SIX";
			//saytext = "Grenade!";
			break;

		case "6":
			soundalias = "mp_stm_sniper";
			saytext = &"QUICKMESSAGE_SNIPER";
			//saytext = "Sniper!";
			break;

		default:
			assert(response == "7");
			soundalias = "mp_stm_needreinforcements";
			saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
			//saytext = "Need reinforcements!";
			break;
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;
	self restoreHeadIcon();
}

quickresponses(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
		return;

	self.spamdelay = true;

	switch(response)		
	{
		case "1":
			soundalias = "mp_rsp_yessir";
			saytext = &"QUICKMESSAGE_YES_SIR";
			//saytext = "Yes Sir!";
			break;

		case "2":
			soundalias = "mp_rsp_nosir";
			saytext = &"QUICKMESSAGE_NO_SIR";
			//saytext = "No Sir!";
			break;

		case "3":
			soundalias = "mp_rsp_onmyway";
			saytext = &"QUICKMESSAGE_IM_ON_MY_WAY";
			//saytext = "On my way.";
			break;

		case "4":
			soundalias = "mp_rsp_sorry";
			saytext = &"QUICKMESSAGE_SORRY";
			//saytext = "Sorry.";
			break;

		case "5":
			soundalias = "mp_rsp_greatshot";
			saytext = &"QUICKMESSAGE_GREAT_SHOT";
			//saytext = "Great shot!";
			break;

		default:
			assert(response == "6");
			soundalias = "mp_rsp_comeon";
			saytext = &"QUICKMESSAGE_COME_ON";
			//saytext = "Took long enough!";
			break;
	}

	self saveHeadIcon();
	self doQuickMessage(soundalias, saytext);

	wait 2;
	self.spamdelay = undefined;
	self restoreHeadIcon();
}

doQuickMessage( soundalias, saytext )
{
	if(getDvarInt("scr_mod_quickmessages") == 0)
		return;

	if(self.sessionstate != "playing")
		return;

	if ( self.pers["team"] == "allies" )
	{
		if ( game["allies"] == "sas" )
			prefix = "UK_";
		else
			prefix = "US_";
	}
	else
	{
		if ( game["axis"] == "russian" )
			prefix = "RU_";
		else
			prefix = "AB_";
	}

	if(isdefined(level.QuickMessageToAll) && level.QuickMessageToAll)
	{
		self.headiconteam = "none";
		self.headicon = "talkingicon";

		if(getDvarInt("scr_mod_quickmessages") == 1) 
			self playSound( prefix+soundalias );
		else if(getDvarInt("scr_mod_quickmessages") == 2)
			self sayAll(saytext);
		else
		{
			self playSound( prefix+soundalias );
			self sayAll(saytext);
		}
	}
	else
	{
		if(self.sessionteam == "allies")
			self.headiconteam = "allies";
		else if(self.sessionteam == "axis")
			self.headiconteam = "axis";
		
		self.headicon = "talkingicon";

		if(getDvarInt("scr_mod_quickmessages") == 1) 
			self playSound( prefix+soundalias );
		else if(getDvarInt("scr_mod_quickmessages") == 2)
			self sayTeam( saytext );
		else
		{
			self playSound( prefix+soundalias );
			self sayTeam( saytext );
		}
	}
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