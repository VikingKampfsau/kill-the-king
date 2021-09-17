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
| textes contain placeholders (&&1), do not delete these placeholders.|
||
| Textes used in menus and stringtables are hardcoded in a localized file,|
| they are not changeable.|
|--------------------------------------------------------------------------*/


findTranslation(ref)
{
	switch(ref)
	{
		//these are not used by huds so they are no localized string
		case "AC130_NOTAVAILABLE": return "AC130 ����������.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: ����� �������� '&&1' �� &&2 ^1����� rcon.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP error: ���������� �������� dvar '^3&&1^1'! �������: ^3�������� �� ���������� - ��������� ����������?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: ����� ������� dvar' ^3&&1^1' �� '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP error: ����������� ��� ��������!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP error: &&1 ^1�� ������� ����� � �������!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP error: ��� ��� ����� �������, ��������������� ���������� �����.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP error: ��� ������� ��������������� ���������� �����.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP error: ���������� �������� ����� � ������������ ������.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP error: ������� ������� ������ &&1 ^1���� - �����!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP error: ������� ������� ������ &&1 ^1������������� ������ - �����!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP error: ������� ���� ������ &&1 ^1���� - �����!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP error: �� ����� ��������� ������, ������� ������� ��� AFK.";
		case "ACP_EVENT_STARTED": return "^1����� �����: ^3&&1^1 - ���������� ����� � ��������� ������!";
		case "ACP_EVENT_STOPPED": return "^1����� ��������� ������� ������� - ���������� ����� � ��������� ������!";
		case "ACP_PLAYER_MUTED": return "^1�� ����������!";
		case "ACP_PLAYER_UNMUTED": return "^1�� �� ����������!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 ����� � ���.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 ��� �������� � &&2.";
		case "ADMIN_MSG": return "^1��������� ��������������";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1��� ��������� � &&1.";
		case "AFK_TIMER_DUPLICATED": return "������������� ������ ���!";
		case "ASS_DESC": return "��������� ������.";
		case "ASSASSIN_LEFT": return "^1������� ^1������� ��� ^7- ������� ������!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^1The ^7&&1 ^1�������� �� ���� �����!";
		case "AWARD_JUGGER_NOT_READY": return "������ ���� ������������ ������ ������������";
		case "BADGE_OFF": return "������ �������������.";
		case "BADGE_ON": return "������ �����������.";
		case "BOX_AIRSUPPORT": return "��������� ��������� ���� �������.";
		case "BOX_EXPLOSIVE": return "� ���� ���� ����������.";
		case "BOX_FLASH": return "� ���� ���� ��������� ������������ ������.";
		case "BOX_JAVELIN_PICKUP": return "� ���� ���� �����!";
		case "BOX_KNIVES": return "� ���� ���� ��������� �����.";
		case "BOX_NADES": return "� ���� ���� ��������� ������.";
		case "BOX_PICK": return "��������� &&1 �����!";
		case "BOX_POISON": return "� ���� ���� ��������� �������� ������.";
		case "BOX_RCXD": return "RC-XD �������� � �����.";
		case "BOX_TRIP": return "� ���� ���� ��������.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "��� ���������� �������� ��� ����� ���������";
		case "CAREPACKAGE_NOT_AVAILABLE": return "���� ��������� ����������";
		case "CHARACTER_MENU_NO_SPEC": return "^1�� ������ ���� ��������, ����� ������� ���.";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1����������� ^7������������� � �������.";
		case "DOG_SHIT": return "���� ������ ������ �������!";
		case "DOG_SUICIDE": return "������ ������ ����� ��������� ������������.";
		case "EVENT": return "�����������: &&1";
		case "EVENT_INNOCENT_KILLED": return "^2�������� ^7��� ����!";
		case "EVENT_PLAYER_WON": return "&&1 ^7������� ^2&&2 ^7�����!";
		case "EVENT_TRAITOR_HINT": return "�� ^1���������^7!";
		case "EVENT_TRAITOR_KILLED": return "^1��������� ^7��� ����!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1�� ������!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "���������� ��� ��������!";
		case "EXTRA_LIFE_EARNED": return "������������ �������������� �����.";
		case "EXTRA_LIFE_USED": return "������������ �������������� �����!";
		case "GHILLIE_CHANGES": return "���� ���������� ��������� � ��������� ���, ����� �� ������������.";
		case "GUARD_DESC": return "�������� ������.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "������ ���������� ����� ������� �����������, \n ������� ESC � ��������� � ���� ���������!";
		case "HARDPOINTS_WILL_CHANGE": return "���� ���������� ���������� � ��������� ������.";
		case "HE_APPEARS_AFK": return "^7&&1 ������ ��������� � AFK!";
		case "HELPER_LEFT": return "^1�������� ^1������� ��� ^7- ������� ������!";
		case "HOLD_BREATH": return "������� ^3&&1 ^7����� ������������� �� �������� ������.";
		case "INNOCENTS_ELIMINATED": return "��� �������� ���� �����";
		case "INVALID_NAME": return "^1���� ��� ��������������� � ���� ��������!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "������ ��� ���� ������������!";
		case "KILLTHEKING": return "����� ������";
		case "KING_DESC": return "������.";
		case "KING_DIED": return "������ ����.";
		case "KING_LEFT": return "������ ����� �� ����.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7���� ������ � ���!";
		case "KING_ON_GROUND": return "������ ����� �� �����!";
		case "KING_SURVIVED": return "������ �����.";
		case "LOGGED_IN": return "^1������� ����� � �������!";
		case "LOGIN_FAILED": return "^1������ �����!";
		case "MAPVOTE_NEXTMAP": return "��������� �����: &&1";
		case "MORTAR_NOTAVAILABLE": return "������� �� ��������.";
		case "NEW_ASS_IS": return "����� �������: &&1";
		case "NEW_ASSASSIN_IS": return "����� ������� &&1";
		case "NEW_DOG_IS": return "����� ������ &&1";
		case "NEW_KING_IS": return "����� ������ &&1";
		case "NEW_SLAVE_IS": return "����� ��� &&1";
		case "NO_BADGE": return "� ��� ��� ������ ��� ���������.";
		case "NO_FREE_SLOTS": return "��� ��������� ������ ��� ������ ��������.";
		case "NO_GLITCH": return "^1�� �������!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1���������� ^7������� ������ ������!";
		case "NO_PERMISSION": return "^1������������ ����������!";
		case "NO_TRIPS": return "������� �������� �� ��������!";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7������������� � �������.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "������, �� �������� ���� ���� - ��������������";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7���� � ��� ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 ����� �� �����";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1����� � ���� ����������� �����.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "�� �� ������ �������� ���� ������� ������!";
		case "PRESTIGE_MAX_REACHED": return "������ ������� ������� �������� ���!";
		case "PRESTIGE_REQUIREMENTS": return "���������� ��� �� ����������!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "������� �� ������ ������� ������� &&1 ������.";
		case "PRESTIGE_REQUIREMENTS_XP": return "��� ��������� &&1 ������ XP.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1������ ������ ����� �����!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1��� �������� ������� ���� - �����";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1��� �������� ������� ���� - �����";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1��� ������� ���� ���� - �����";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1��� ������� ���� ���� - �����";
		case "PROFILE_BACKUP_CREATED": return "������ ����� ����� - ����� ������������ ��������� �����";
		case "PROFILE_BACKUP_LOADED": return "����� ������� ������������!";
		case "PROFILE_BACKUP_LOADING": return "^1�������������� ������ - �� ��������� ������!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1�� ������ ��������� ���� ��� ����� ���������� guid-name!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "����������� �������� ����������!";
		case "RANK_HACKED": return "^1������, �� �������� �������� ���� ����!";
		case "RCXD_NOTAVAILABLE": return "RC-XD ����������.";
		case "REVIVED_BY": return "&&1 �������� �� &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1������� ������ �� �������� ^3- ^1�������� �����������, ���� �� �� ��������� ����";
		case "SELECTION_IMPOSSIBLE": return "�� ������� ������� ��� ������.";
		case "SELF_REVIVED": return "&&1 ���������� ���.";
		case "SENTRY_GUN_BAD_SPOT": return "������ ��������� ^2������ ������� ^7�����.";
		case "SPAWNPROTECTION_DISABLED": return "^1������ ������ ���������.";
		case "SPAWNPROTECTION_ENABLED": return "^2������ ������ ��������.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^2��������� ^7�� ����������� � ���� ����������� ^1���������^7!";
		case "TERMINATOR_IS": return "&&1 ����������!";
		case "TRAITORS_ELIMINATED": return "��� ��������� �������������";
		case "TRIP_ACTIVE_IN": return "�������� ������� � &&1 �������.";
		case "TRIP_BAD_SPOT": return "�� �� ������ ���������� �������� �����!";
		case "TUTORIAL_1": return "� �������� �������� ��������� ��� ����, ���� ������� ^2�������, ^7������� ������ �������� ������.";
		case "TUTORIAL_10": return "������� ^2������� ^7������ �������� ��������� ������� �� �����.";
		case "TUTORIAL_11": return "^1�������� ^7������ ��������� ����� �� ���������, ����� ��������� ��.";
		case "TUTORIAL_2": return "������ ������� ^1���������, ^7������ ��������� ������ � ������� ������.";
		case "TUTORIAL_3": return "^2������ ^7� ^2��������� ^7�������� ��������� ^2�����������, ^7������� �������� ������� ������� ���������� ���������.";
		case "TUTORIAL_4": return "^2����������� ��� (�������������)";
		case "TUTORIAL_5": return "���� �� ������ ^2���������, ^7������ �������� ������ � ��� �������, � ������� ���������� ��������� ���.";
		case "TUTORIAL_6": return "������ ������� ^1���������, ^7������ ��������� ������, ������� ������� � ������� ���";
		case "TUTORIAL_7": return "�� ������������ �����.";
		case "TUTORIAL_8": return "����� ^1�������� ^7������� ������ ��� - ����� �������� ������� �����.";
		case "TUTORIAL_9": return "^2����� ��������� (�������������)";
		case "TUTORIAL_TITLE": return "� ��� ���� & ����";
		case "UNIFORM_OF_GUARD": return "� ���� ���� ����� ���������.";
		case "VISION_OFF": return "Visions ��������.";
		case "VISION_ON": return "Visions �������.";
		case "YOU_APPEAR_AFK": return "^1�� ���������� � AFK!";
		case "YOU_APPEAR_STUCK": return "������, �� ��������.";
		case "YOU_HAVE_THE_WEAPON": return "� ���� ��� ���� ��� ������";
		case "ZIPLINE_BAD_END": return "������ ��������� ��������� ������.";
		case "ZIPLINE_BAD_START": return "������ ��������� ���������� ������.";
		case "ZIPLINE_DESTROIED_USAGE": return "��� ����� ������ ���� �������� �� ����, ��� �� ������ �� ������������.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "������������ ���������� ������ ������.";
		case "ZIPLINE_PLACED_END": return "����� ������ �������.";
		case "ZIPLINE_PLACED_START": return "�������� ������ ��������.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"���������� ������� ����.";
		case "CP_IS_A_TRAP": return &"��� �������.";
		case "CP_PRESS_USE": return &"����������� ^3[{+activate}] ^7����� ������� ����.";
		case "DOG_SNIFF_ENEMY": return &"������� ^3[{+activate}] ^7����� ������ ������.";
		case "FOLLOWING": return &"���������: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD ���������� �: ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 ��������� �: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"������ ���������� �: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Sentry Gun ���������� �: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"�������� ������ �: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"������� ^3[{+activate}] ^7����� �����.";
		case "KING_IS": return &"^2������: &&1";
		case "LASTSTAND_MESSAGE": return &"^1�����: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"������ �������:";
		case "MAPRECORD_BEST_KD": return &"������ �/�:";
		case "MAPRECORD_BEST_STREAK": return &"������ ����� �������:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"����� ������� ������-������:";
		case "MAPRECORD_LONGEST_KING": return &"����� ������� ����� ������:";
		case "MAPRECORD_MOST_DEATHS": return &"����������� �������:";
		case "MAPRECORD_MOST_KILLS": return &"����������� �������:";
		case "MAPRECORD_TITLE": return &"Hall of Fame - ������ ������ ���� ����� (�� ��� �����)";
		case "NADE_ON_YOU": return &"�� ���� �������� �������!";
		case "NO_KING_YET": return &"^2������ ��� �� �������.";
		case "NOT_ENOUGH_PLAYERS": return &"��������� &&1 ������(��), ����� ������ ����!";
		case "PICK_ASSASSIN": return &"�������� ��������";
		case "PICK_DOG": return &"�������� ������";
		case "PICK_KING": return &"�������� ������";
		case "PICK_SLAVE": return &"�������� ���-��������";
		case "PICKED_ASSASSIN_IS": return &"�������: &&1";
		case "PICKED_DOG_IS": return &"������: &&1";
		case "PICKED_KING_IS": return &"������: &&1";
		case "PICKED_SLAVE_IS": return &"���-�������: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"����� ������ ��� ���-��������";
		case "WEAPONCHANGE_GUNGAME": return &"^7������� ^3[{+activate}] ^7��� ������ ������.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7������� ^3[{+activate}] ^7����� ����������� ������.";
		case "ZIPLINE_USAGE_INFO": return &"������� ^3[{+activate}] ^7/^1[{+melee}] ^7� ^3����������� ^7/ ^1���������� ^7������������ ����.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"������� ^3[{+activate}] ^7����� �������� ��������.";
		case "REVIVE_INFO_YOUSELF": return &"������� ^3[{+activate}] ^7������� ����. (&&1)";
		case "REVIVE_INFO": return &"������� ^3[{+activate}] ^7����� �������.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"������� ^3[{+attack}] ^7����� ���������� Sentry.";
		case "TRIP_PLANT": return &"������� ^3[{+activate}] ^7���������� ��������";
		case "HUD_KING_HEALTH": return &"������ ��������: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"���������� ��������: &&1";
		case "THROWBACKGRENADE": return &"������� ^3[{+activate}] ^7����� ������� ���.";
		case "BOX_PRESS_USE": return &"����������� ^3[{+activate}] ^7����� �������� ������ ������.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"RUKTK_GUNGAME_STAGE_RU";
		case "GUNGAME_MAXSTAGE": return &"RUKTK_GUNGAME_MAXSTAGE_RU";
		case "MONEY": return &"RUKTK_MONEY_RU";

		default: return "";
	}
}