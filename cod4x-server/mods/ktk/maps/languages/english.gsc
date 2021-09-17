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
| Here are the translations for textes used in scripts (.gsc and .gsx files)|
| only. You are free to change them - just keep any eye on the syntax. Some |
| textes contain placeholders (&&1), do not delete these placeholders.		|
|																			|
| Textes used in menus and stringtables are hardcoded in a localized file,	|
| they are not changeable.													|
|--------------------------------------------------------------------------*/


findTranslation(ref)
{
	switch(ref)
	{
		//these are not used by huds so they are no localized strings
		case "AC130_NOTAVAILABLE": return "AC130 not available.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: An admin executed '&&1' on &&2 ^1via rcon.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP error: Can not change dvar '^3&&1^1'! Reason: ^3No value defined - Syntax correct?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: An admin changed dvar '^3&&1^1' to '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP error: Event already running!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP error: &&1 ^1failed to login!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP Error: Two or more players matching the entered name.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP Error: No players matching the entered name.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP Error: Impossible to update ranks in prematch period.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP error: The current prestige of player &&1 ^1is higher - ABORTING!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP error: The current rank of player &&1 ^1matches the new one - ABORTING!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP error: The current rank of player &&1 ^1is higher - ABORTING!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP error: Can not force spawn a player which is marked as AFK.";
		case "ACP_EVENT_STARTED": return "^1An admin started: ^3&&1^1 - Restarting map next round!";
		case "ACP_EVENT_STOPPED": return "^1An admin stopped the current event - Restarting map next round!";
		case "ACP_PLAYER_MUTED": return "^1You are muted!";
		case "ACP_PLAYER_UNMUTED": return "^1You are unmuted!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 is back in combat.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 was moved to the &&2.";
		case "ADMIN_MSG": return "^1Administrator Message";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1You were moved to the &&1.";
		case "AFK_TIMER_DUPLICATED": return "AFK timer duplicated!";
		case "ASS_DESC": return "Eliminate the King.";
		case "ASSASSIN_LEFT": return "The ^1assassin ^7 has ^1left ^7- Picking a new one!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^1The ^7&&1 ^1is disabled on this map!";
		case "AWARD_JUGGER_NOT_READY": return "Can not use the juggernaut suit yet.";
		case "BADGE_OFF": return "Badge deactivated.";
		case "BADGE_ON": return "Badge activated.";
		case "BOX_AIRSUPPORT": return "Airsupport awaiting commands.";
		case "BOX_EXPLOSIVE": return "You got some explosives.";
		case "BOX_FLASH": return "You got some flash grenades.";
		case "BOX_JAVELIN_PICKUP": return "You got a javelin!";
		case "BOX_KNIVES": return "You got some knives.";
		case "BOX_NADES": return "You got some grenades.";
		case "BOX_PICK": return "&&1 points required!";
		case "BOX_POISON": return "You got some poison grenades.";
		case "BOX_RCXD": return "RC-XD filled and ready.";
		case "BOX_TRIP": return "You got a tripwire.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "No Helicopter available for Carepackage";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Carepackage not available";
		case "CHARACTER_MENU_NO_SPEC": return "^1You have to be a spectator!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1The developer ^7has joined the server.";
		case "DOG_SHIT": return "Your dog has to take a shit!";
		case "DOG_SUICIDE": return "Only the dog can suicide.";
		case "EVENT": return "Event: &&1";
		case "EVENT_INNOCENT_KILLED": return "An ^2innocent ^7was killed!";
		case "EVENT_PLAYER_WON": return "&&1 ^7has won for the ^2&&2 ^7time!";
		case "EVENT_TRAITOR_HINT": return "You are a ^1Traitor^7!";
		case "EVENT_TRAITOR_KILLED": return "A ^1traitor ^7was killed!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1You are the king!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Explosives already planted!";
		case "EXTRA_LIFE_EARNED": return "Extra life earned.";
		case "EXTRA_LIFE_USED": return "Extra life used!";
		case "GHILLIE_CHANGES": return "Your ghillie will change the next time you spawn.";
		case "GUARD_DESC": return "Protect the King.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "Server uses the new Hardpoint System, \n Press ESC and go to the Hardpoints menu!";
		case "HARDPOINTS_WILL_CHANGE": return "Your Hardpoints will change the next round.";
		case "HE_APPEARS_AFK": return "^7&&1 appears to be AFK!";
		case "HELPER_LEFT": return "The ^1helper ^7has ^1left ^7- Picking a new one!";
		case "HOLD_BREATH": return "Press ^3&&1 ^7to switch to thermal vision.";
		case "INNOCENTS_ELIMINATED": return "All innocents were killed";
		case "INVALID_NAME": return "^1Your name is invalid and was changed!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Vehicle out of range!";
		case "KILLTHEKING": return "Kill the King";
		case "KING_DESC": return "Survive.";
		case "KING_DIED": return "The King has died.";
		case "KING_LEFT": return "The King has left.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7has downed the king!";
		case "KING_ON_GROUND": return "The King is on the ground!";
		case "KING_SURVIVED": return "The King has survived.";
		case "LOGGED_IN": return "^1Successfully logged in!";
		case "LOGIN_FAILED": return "^1Login failed!";
		case "MAPVOTE_NEXTMAP": return "Next Map: &&1";
		case "MORTAR_NOTAVAILABLE": return "Mortars not available.";
		case "NEW_ASS_IS": return "The new Assassin is: &&1";
		case "NEW_ASSASSIN_IS": return "The new assassin is &&1";
		case "NEW_DOG_IS": return "The new dog is &&1";
		case "NEW_KING_IS": return "The new King is &&1";
		case "NEW_SLAVE_IS": return "The new slave is &&1";
		case "NO_BADGE": return "You have no Badge to activate.";
		case "NO_FREE_SLOTS": return "No free slots for the new item.";
		case "NO_GLITCH": return "^1Do not glitch!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Unable ^7to pick a new player!";
		case "NO_PERMISSION": return "^1Insufficient Permissions!";
		case "NO_TRIPS": return "No tripwires left!";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7has joined the server.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "Looks like you have lost your rank - Restoring";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7has downed ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 is on the ground!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1carries a deadly charge.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "You can not replace your side-arm weapon!";
		case "PRESTIGE_MAX_REACHED": return "There are no further prestige levels!";
		case "PRESTIGE_REQUIREMENTS": return "Requirements not reached yet!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "You have to reach rank &&1 first.";
		case "PRESTIGE_REQUIREMENTS_XP": return "You need &&1 more XP.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Error writing backup file!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Your current prestige is lower - Aborting";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Your current prestige is higher - Aborting";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Your current rank is lower - Aborting";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Your current rank is higher - Aborting";
		case "PROFILE_BACKUP_CREATED": return "Backup file created - useable next map!";
		case "PROFILE_BACKUP_LOADED": return "Backup successfully restored!";
		case "PROFILE_BACKUP_LOADING": return "^1Restoring backup - do not leave the server!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1No backup file found for your guid-name combination!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "Direction of the rotation changed!";
		case "RANK_HACKED": return "^1It seems like you tried to hack your rank!";
		case "RCXD_NOTAVAILABLE": return "RC-XD not available.";
		case "REVIVED_BY": return "&&1 got revived by &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1No flags left ^3- ^1no respawn until you capture a flag!";
		case "SELECTION_IMPOSSIBLE": return "Not enough players for the selection.";
		case "SELF_REVIVED": return "&&1 has revived himself.";
		case "SENTRY_GUN_BAD_SPOT": return "Can not deploy a ^2Sentry Gun ^7here.";
		case "SPAWNPROTECTION_DISABLED": return "^1Spawnprotection disabled.";
		case "SPAWNPROTECTION_ENABLED": return "^2Spawnprotection enabled.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^2Guards ^7 are not allowed in the spawnarea of the ^1Assassins^7!";
		case "TERMINATOR_IS": return "&&1 is Terminator!";
		case "TRAITORS_ELIMINATED": return "All traitors eliminated";
		case "TRIP_ACTIVE_IN": return "Tripwire active in &&1 seconds.";
		case "TRIP_BAD_SPOT": return "You can't deploy a tripwire here!";
		case "TUTORIAL_1": return "Basically the name explains the gametype, there is a team, the ^2Guards, ^7which has to protect the king.";
		case "TUTORIAL_10": return "A team, the ^2Guards^7, has to protect the terminals everywhere in the map.";
		case "TUTORIAL_11": return "The ^1Assassins ^7have to upload a virus to the terminals to shut them down.";
		case "TUTORIAL_2": return "The other team, the ^1Assassins^7, have to eliminate the king within the round.";
		case "TUTORIAL_3": return "The ^2King ^7and the ^2Guards ^7get supported by a ^2Terminator ^7which is a strong robot, equiped with a minigun.";
		case "TUTORIAL_4": return "^2Contain the Code (unfinished)";
		case "TUTORIAL_5": return "One of the teams, the ^2Guards^7, have to protect the king and his suitcase, which contains a secret code.";
		case "TUTORIAL_6": return "The other team, the ^1Assassins^7, have to eliminate the king, to steal the suitcase and to hold it";
		case "TUTORIAL_7": return "for a certain amount of time.";
		case "TUTORIAL_8": return "When the ^1Assassins ^7have sucessfuly stolen the code, a nuke will be launched.";
		case "TUTORIAL_9": return "^2Hack the Terminals (unfinished)";
		case "TUTORIAL_TITLE": return "About the Gametypes & the Mod";
		case "UNIFORM_OF_GUARD": return "You got a uniform of a guard.";
		case "VISION_OFF": return "Visions disabled.";
		case "VISION_ON": return "Visions enabled.";
		case "YOU_APPEAR_AFK": return "^1You appear to be AFK!";
		case "YOU_APPEAR_STUCK": return "You appear to be stuck.";
		case "YOU_HAVE_THE_WEAPON": return "You already have this weapon";
		case "ZIPLINE_BAD_END": return "Bad end hook position.";
		case "ZIPLINE_BAD_START": return "Bad start hook position.";
		case "ZIPLINE_DESTROIED_USAGE": return "This zipline was cut before you could use it.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Max amount of ziplines reached.";
		case "ZIPLINE_PLACED_END": return "End hook placed.";
		case "ZIPLINE_PLACED_START": return "Start hook placed.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Unable to steal the crate.";
		case "CP_IS_A_TRAP": return &"It's a trap.";
		case "CP_PRESS_USE": return &"Hold ^3[{+activate}] ^7to open the crate.";
		case "DOG_SNIFF_ENEMY": return &"Press ^3[{+activate}] ^7to sniff for enemies.";
		case "FOLLOWING": return &"Following: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD explodes in: ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 leaves in: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predator explodes in: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Sentry Gun explodes in: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Helicopter leaves in: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Press ^3[{+activate}] ^7to leave.";
		case "KING_IS": return &"^2The King is: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Bleeding out: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Best Assassin:";
		case "MAPRECORD_BEST_KD": return &"Best K/D:";
		case "MAPRECORD_BEST_STREAK": return &"Highest Killstreak:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Fastest King killer:";
		case "MAPRECORD_LONGEST_KING": return &"Longest Kingtime:";
		case "MAPRECORD_MOST_DEATHS": return &"Most deaths:";
		case "MAPRECORD_MOST_KILLS": return &"Most kills:";
		case "MAPRECORD_TITLE": return &"Hall of Fame - Best players on this map (All time)";
		case "NADE_ON_YOU": return &"A grenade is stuck on you!";
		case "NO_KING_YET": return &"^2No King chosen yet.";
		case "NOT_ENOUGH_PLAYERS": return &"At least &&1 players needed to start!";
		case "PICK_ASSASSIN": return &"Picking the Assassin";
		case "PICK_DOG": return &"Picking the Dog";
		case "PICK_KING": return &"Picking the King";
		case "PICK_SLAVE": return &"Picking the Assassin's slave";
		case "PICKED_ASSASSIN_IS": return &"The Assassin is: &&1";
		case "PICKED_DOG_IS": return &"The Dog is: &&1";
		case "PICKED_KING_IS": return &"The King is: &&1";
		case "PICKED_SLAVE_IS": return &"The Slave is: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Picking the Assassin's Dog or Slave";
		case "WEAPONCHANGE_GUNGAME": return &"Press ^3[{+activate}] ^7for the new weapon.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Press ^3[{+activate}] ^7to switch the weapon.";
		case "ZIPLINE_USAGE_INFO": return &"Press ^3[{+activate}] ^7/ ^1[{+melee}] ^7to ^3Use^7/^1Destroy ^7the escape rope.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Press ^3[{+activate}] ^7to speed up.";
		case "REVIVE_INFO_YOUSELF": return &"Hold ^3[{+activate}] ^7to revive yourself. (&&1)";
		case "REVIVE_INFO": return &"Hold ^3[{+activate}] ^7to revive.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Press ^3[{+attack}] ^7to deploy the Sentry.";
		case "TRIP_PLANT": return &"Hold ^3[{+activate}] ^7to plant a tripwire.";
		case "HUD_KING_HEALTH": return &"King health: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Terminator health: &&1";
		case "THROWBACKGRENADE": return &"Press ^3[{+activate}] ^7to pick up the knife.";
		case "BOX_PRESS_USE": return &"Hold ^3[{+activate}] ^7to get a random weapon.";

		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_ENG";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_ENG";
		case "MONEY": return &"KTK_MONEY_ENG";

		default: return "";
	}
}