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
		case "AC130_NOTAVAILABLE": return "AC130 nicht verf�gbar.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: Ein Admin f�hrte '&&1' bei &&2 per rcon aus.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP error: Dvar '^3&&1^1' konnte nicht ge�ndert werden! Grund: ^3Fehlender Wert - Syntax richtig?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP error: Ein Admin �nderte die dvar '^3&&1^1' zu '^3&&2^1.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP error: Event l�uft bereits!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP error: &&1 ^1login fehlgeschlagen!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP Error: Es wurden mehrere Spieler mit diesem Namen gefunden.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP Error: Kein Spieler mit diesem Namen gefunden.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP Error: R�nge k�nnen vor Rundenstart nicht ver�ndert werden.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP error: Das aktuelle Prestige von &&1 ^1ist h�her - Abbruch!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP error: Der aktuelle Rang von &&1 ^1ist identisch - Abbruch!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP error: Der aktuelle Rang von &&1 ^1ist h�her - Abbruch!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP error: Ein abwesender Spieler kann nicht zwangsgespawnt werden.";
		case "ACP_EVENT_STARTED": return "^1Ein Admin startet: ^3&&1^1 - Kartenneustart n�chste Runde!";
		case "ACP_EVENT_STOPPED": return "^1Ein Admin beendet: ^3&&1^1 - Kartenneustart n�chste Runde!";
		case "ACP_PLAYER_MUTED": return "^1Du bist stumm!";
		case "ACP_PLAYER_UNMUTED": return "^1Du bist nicht mehr stumm!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 ist dem Kampf beigetreten.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 wurde den &&2 hinzugef�gt.";
		case "ADMIN_MSG": return "^1Administratornachricht";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Du wurdest den &&1 hinzugef�gt.";
		case "AFK_TIMER_DUPLICATED": return "AFK Timer verdoppelt!";
		case "ASS_DESC": return "Eliminiere den K�nig.";
		case "ASSASSIN_LEFT": return "Der ^1Assassine ^7ist gefl�chtet!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^7&&1 ^1ist auf dieser Karte nicht vorhanden!";
		case "AWARD_JUGGER_NOT_READY": return "Anzug momentan nicht nutzbar.";
		case "BADGE_OFF": return "Emblem deaktiviert.";
		case "BADGE_ON": return "Emblem aktiviert.";
		case "BOX_AIRSUPPORT": return "Luftunterst�tzung erwartet Befehle.";
		case "BOX_EXPLOSIVE": return "Du hast eine Explosivwaffe erhalten.";
		case "BOX_FLASH": return "Du hast Blendgranaten erhalten.";
		case "BOX_JAVELIN_PICKUP": return "Du hast eine Javelin erhalten.";
		case "BOX_KNIVES": return "Du hast Wurfmesser erhalten.";
		case "BOX_NADES": return "Du hast Granaten erhalten.";
		case "BOX_PICK": return "&&1 Punkte ben�tigt!";
		case "BOX_POISON": return "Du hast Giftgranaten erhalten.";
		case "BOX_RCXD": return "RC-XD betankt und bereit.";
		case "BOX_TRIP": return "Du hast eine Stolperfalle erhalten.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Kein Helikopter f�r das Carepackage verf�gar";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Carepackage nicht verf�gbar";
		case "CHARACTER_MENU_NO_SPEC": return "^1Du musst Zuschauer sein!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1Der Entwickler hat den Server betreten.";
		case "DOG_SHIT": return "Dein Hund muss kacken!";
		case "DOG_SUICIDE": return "Nur der Hund kann sich selbst t�ten.";
		case "EVENT": return "Event";
		case "EVENT_INNOCENT_KILLED": return "Ein ^2Unschuldiger ^7wurde get�tet!";
		case "EVENT_PLAYER_WON": return "&&1 ^7hat das ^2&&2 ^7Mal gewonnen!";
		case "EVENT_TRAITOR_HINT": return "Du bist ein ^1Verr�ter^7!";
		case "EVENT_TRAITOR_KILLED": return "Ein ^1Verr�ter ^7wurde get�tet!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Du bist der K�nig!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Bombe bereits gelegt!";
		case "EXTRA_LIFE_EARNED": return "Extra-Leben erhalten.";
		case "EXTRA_LIFE_USED": return "Extra-Leben verbraucht.";
		case "GHILLIE_CHANGES": return "Dein Tarnanzug �ndert sich beim n�chsten Spieleinstieg.";
		case "GUARD_DESC": return "Besch�tze den K�nig.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "Server verwendet das neue Hardpoint System, \n Dr�cke ESC und �ffne das Hardpoint Men�!";
		case "HARDPOINTS_WILL_CHANGE": return "Deine Killstreaks �ndern sich n�chste Runde.";
		case "HE_APPEARS_AFK": return "^7&&1 scheint AFK zu sein!";
		case "HELPER_LEFT": return "Der ^1Helfer ^7ist gefl�chtet ^7- W�hle neu!";
		case "HOLD_BREATH": return "Dr�cke ^3&&1 ^7um zur Thermalsicht zu wechseln.";
		case "INNOCENTS_ELIMINATED": return "Alle Unschuldigen wurden get�tet";
		case "INVALID_NAME": return "^1Dein Name ist ung�ltig und wurde ge�ndert!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Fahrzeug au�er Reichweite!";
		case "KILLTHEKING": return "T�te den K�nig";
		case "KING_DESC": return "�berlebe.";
		case "KING_DIED": return "Der K�nig ist gestorben.";
		case "KING_LEFT": return "Der K�nig ist gefl�chtet.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7hat den K�nig zu Fall gebracht!";
		case "KING_ON_GROUND": return "Der K�nig ist am Boden!";
		case "KING_SURVIVED": return "Der K�nig hat �berlebt.";
		case "LOGGED_IN": return "^1Erfolgreich eingeloggt!";
		case "LOGIN_FAILED": return "^1Login fehlerhaft!";
		case "MAPVOTE_NEXTMAP": return "N�chste Map: &&1";
		case "MORTAR_NOTAVAILABLE": return "M�rser nicht verf�gbar.";
		case "NEW_ASS_IS": return "Der neue Assassine ist: &&1";
		case "NEW_ASSASSIN_IS": return "Der neue Assassine ist &&1";
		case "NEW_DOG_IS": return "Der neue Hund ist &&1";
		case "NEW_KING_IS": return "Der neue K�nig ist &&1";
		case "NEW_SLAVE_IS": return "Der neue Helfer ist &&1";
		case "NO_BADGE": return "Du hast kein Emblem das aktiviert werden k�nnte.";
		case "NO_FREE_SLOTS": return "Keine freien Slots f�r das neue Item.";
		case "NO_GLITCH": return "^1Nicht glitchen!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Konnte keinen Spieler ausw�hlen!";
		case "NO_PERMISSION": return "^1Keine Berechtigung!";
		case "NO_TRIPS": return "Keine Stolperdr�hte �brig!";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7hat den Server betreten.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "Rangverlust? - Wiederherstellung�";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7hat ^1&&2^7zu Fall gebracht!";
		case "PLAYER_ON_GROUND": return "&&1 ist am Boden!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1tr�gt eine t�tliche Ladung.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Die Sekund�rwaffe kann nicht ersetzt werden!";
		case "PRESTIGE_MAX_REACHED": return "Es gibt keine weiteren Prestiger�nge!";
		case "PRESTIGE_REQUIREMENTS": return "Voraussetzung nicht erf�llt!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Du musst erst Rank &&1 erreichen.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Du ben�tigst noch &&1 XP.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Fehler beim Schreiben des Backups!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Dein aktuelles prestige ist niedriger - Abbruch";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Dein aktuelles prestige ist h�her - Abbruch";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Dein aktueller Rang ist niedriger - Abbruch";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Dein aktueller Rang ist h�her - Abbruch";
		case "PROFILE_BACKUP_CREATED": return "Backup erstellt - verwandbar ab der n�chsten Karte!";
		case "PROFILE_BACKUP_LOADED": return "Backup erfolgreich geladen!";
		case "PROFILE_BACKUP_LOADING": return "^1Lade Backup - Bleib auf dem Server!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1Kein Backup mit deiner GUID-Name-Kombination vorhanden!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "Drehrichtung ge�ndert!";
		case "RANK_HACKED": return "^1Es scheint als h�ttest du deinen Rang gehackt!";
		case "RCXD_NOTAVAILABLE": return "RC-XD nicht verf�gbar.";
		case "REVIVED_BY": return "&&1 wurde von &&2 geheilt.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1Kein Flaggen ^3- ^1Kein Respawn! Erobere Flaggen!";
		case "SELECTION_IMPOSSIBLE": return "Nicht gen�gen Spieler f�r eine Auswahl.";
		case "SELF_REVIVED": return "&&1 hat sich selbst geheilt.";
		case "SENTRY_GUN_BAD_SPOT": return "^2Gesch�tz ^7hier nicht platzierbar.";
		case "SPAWNPROTECTION_DISABLED": return "^2Spawnschutz deaktiviert.";
		case "SPAWNPROTECTION_ENABLED": return "^2Spawnschutz aktiviert.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^2Guards ^7 m�ssen au�erhalb des Spawnbereichs der ^1Assassine ^7bleiben!";
		case "TERMINATOR_IS": return "&&1 ist Terminator!";
		case "TRAITORS_ELIMINATED": return "Alle Verr�ter eliminiert";
		case "TRIP_ACTIVE_IN": return "Stolperdraht aktiv in &&1 Sekunden.";
		case "TRIP_BAD_SPOT": return "Stolperfallen k�nnen hier nicht plaziert werden!";
		case "TUTORIAL_1": return "Im Prinzip erkl�rt der Name den Spieltyp. Es gibt ein Team, die ^2Guards, ^7welches den K�nig besch�tzen muss.";
		case "TUTORIAL_10": return "Ein Team, die ^2Guards^7, m�ssen die auf der Karte verteilten Terminale besch�tzen.";
		case "TUTORIAL_11": return "Das andere Team, die ^1Assassine^7, m�ssen diese durch uploaden eines Viruses zerst�ren.";
		case "TUTORIAL_2": return "Das andere Team, die ^1Assassine^7,  muss den K�nig innerhalb der Runde ausschalten.";
		case "TUTORIAL_3": return "Der ^2K�nig ^7und die ^2Guards ^7werden vom ^2Terminator^7, einem Roboter mit einer Minigun, unterst�tzt.";
		case "TUTORIAL_4": return "^2Contain the Code (unvollst�ndig)";
		case "TUTORIAL_5": return "Eines der Teams, die ^2Guards^7, m�ssen den K�inig und seinen Koffer, in dem sich ein geheimer Code befindet, besch�tzen.";
		case "TUTORIAL_6": return "Das andere Team, die ^1Assassine^7, m�ssen den K�nig ausschalten, den Koffer stehlen und diesen";
		case "TUTORIAL_7": return "�ber eine bestimmte Zeit halten.";
		case "TUTORIAL_8": return "Haben die ^1Assassine ^7den Code erfolgreich gestohlen wird ein atomarer Vernichtungsschlag eingeleitet.";
		case "TUTORIAL_9": return "^2Hack the Terminals (unvollst�ndig)";
		case "TUTORIAL_TITLE": return "�ber den Spieltyp & die Mod";
		case "UNIFORM_OF_GUARD": return "Du hast die Uniform eines Guards erhalten";
		case "VISION_OFF": return "Visionen deaktiviert.";
		case "VISION_ON": return "Visionen aktiviert.";
		case "YOU_APPEAR_AFK": return "^1Du scheinst AFK zu sein!";
		case "YOU_APPEAR_STUCK": return "Du scheinst festzusitzen.";
		case "YOU_HAVE_THE_WEAPON": return "Du besitzt diese Waffe bereits";
		case "ZIPLINE_BAD_END": return "Schlechte Endposition.";
		case "ZIPLINE_BAD_START": return "Schlechte Startposition.";
		case "ZIPLINE_DESTROIED_USAGE": return "Die Seilrutsche wurde bereits zerst�rt.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Max. Anzahl von Seilrutschen erreicht.";
		case "ZIPLINE_PLACED_END": return "Endposition festgelegt.";
		case "ZIPLINE_PLACED_START": return "Startposition festgelegt.";
			
		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Stehlen der Kiste nicht m�glich.";
		case "CP_IS_A_TRAP": return &"Es ist eine Falle.";
		case "CP_PRESS_USE": return &"Halte ^3[{+activate}] ^7zum �ffnen der Kiste.";
		case "DOG_SNIFF_ENEMY": return &"Dr�cke ^3[{+activate}] um Feinde aufzusp�ren.";
		case "FOLLOWING": return &"Folge: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD explodiert in: ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 verschwindet in: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predator explodiert in: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Sentry Gun explodiert in: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Helikopter verschwindet in: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Dr�cke ^3[{+activate}] ^7zum verlassen.";
		case "KING_IS": return &"^2Der K�nig ist: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Verblutet in: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Bester Assassine:";
		case "MAPRECORD_BEST_KD": return &"Beste K/D:";
		case "MAPRECORD_BEST_STREAK": return &"H�chste Killstreak:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Schnellster K�nigt�ter:";
		case "MAPRECORD_LONGEST_KING": return &"L�ngste Amtszeit:";
		case "MAPRECORD_MOST_DEATHS": return &"Meiste Tode:";
		case "MAPRECORD_MOST_KILLS": return &"Meiste Absch�sse:";
		case "MAPRECORD_TITLE": return &"Hall of Fame - Beste Spiele auf dieser Karte (Jemals)";
		case "NADE_ON_YOU": return &"Eine Granate h�ngt an dir!";
		case "NO_KING_YET": return &"^2Kein K�nig ausgew�hlt.";
		case "NOT_ENOUGH_PLAYERS": return &"Mindestens &&1 Spieler f�r den Spielstart ben�tigt!";
		case "PICK_ASSASSIN": return &"W�hle den Assassine";
		case "PICK_DOG": return &"W�hle den Hund";
		case "PICK_KING": return &"W�hle den K�nig";
		case "PICK_SLAVE": return &"W�hle den Sklaven des Assassine";
		case "PICKED_ASSASSIN_IS": return &"Der Assassine ist: &&1";
		case "PICKED_DOG_IS": return &"Der Hund ist: &&1";
		case "PICKED_KING_IS": return &"Der K�nig ist: &&1";
		case "PICKED_SLAVE_IS": return &"Der Sklave ist: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"W�hle den Hund oder Helfer";
		case "WEAPONCHANGE_GUNGAME": return &"Dr�cke ^3[{+activate}] ^7f�r eine neue Waffe.";
		case "WEAPONCHANGE_PRESS_USE": return &"Dr�cke ^3[{+activate}] ^7um die Waffe zu wechseln.";
		case "ZIPLINE_USAGE_INFO": return &"Dr�cke ^3[{+activate}] ^7/ ^1[{+melee}] ^7um das Seil zu ^3verwenden^7/^1zerst�ren^7.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Dr�cke ^3[{+activate}] ^7zum beschleunigen.";
		case "REVIVE_INFO_YOUSELF": return &"Halte ^3[{+activate}] ^7um dich selbst zu verarzten. (&&1)";
		case "REVIVE_INFO": return &"Halte ^3[{+activate}] ^7um aufzuhelfen.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Dr�cke ^3[{+activate}] ^7um eine Sentry zu platzieren.";
		case "TRIP_PLANT": return &"Halte ^3[{+activate}] ^7um eine Stolperfalle zu legen.";
		case "HUD_KING_HEALTH": return &"K�nig HP: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Terminator HP: &&1";
		case "THROWBACKGRENADE": return &"Dr�cke ^3[{+activate}] ^7um das Messer aufzuheben.";
		case "BOX_PRESS_USE": return &"Halte ^3[{+activate}] ^7um eine Waffe zu kaufen.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_DE";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_DE";
		case "MONEY": return &"KTK_MONEY_DE";

		default: return "";
	}
}