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
		case "AC130_NOTAVAILABLE": return "AC130 nem elérhetõ.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1AIP: Egy admin a következot hajtotta végre '^&&1' &&2 játékoson ^1 konzol által";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1AIP hiba: Nem megváltoztatható a dvar '^3&&1^1'! Ok: ^3 Nincs érték megadva -  Syntax helyes?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1AIP: Egy admin megváltoztatta a dvar-t '^3&&1^1' -ról '^3&&2^21'-ra";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1AIP hiba: Az event már fut!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1AIP hiba: &&1 ^1nem tudott bejelentkezni!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1AIP Hiba: Ketto vagy több játékosnak ugyanez a neve.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1AIP Hiba: Nincs ilyen névvel rendelkezo játékos.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1AIP Hiba: Nem lehet rangokat frissíteni meccs elott.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1AIP hiba: A &&1 játékos jelenlegi presztízse ^1 magasabb - MEGSZAKÍTÁS";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1AIP hiba: A &&1 játékos jelenlegi rankja ^1 egyezik az újjal - MEGSZAKÍTÁS!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1AIP hiba: A &&1 játékos jelenlegi rankja ^1 magasabb - MEGSZAKÍTÁS";
		case "ACP_ERROR_NO_SPAWN": return "^1AIP hiba: Nem lehet AFK-nak jelölt játékost le spawnoltatni.";
		case "ACP_EVENT_STARTED": return "^1 Egy admin elindította a következot: ^3&&1^1 - Pálya újraindítása a következo körben!";
		case "ACP_EVENT_STOPPED": return "^1 Egy admin megállította a jelenlegi eventet - Pálya újraindítása a következo körben!";
		case "ACP_PLAYER_MUTED": return "^1 Le vagy némítva!";
		case "ACP_PLAYER_UNMUTED": return "^1 Némításod feloldásra került!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 visszatért a harcba.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 át lett rakva a/az &&2-ba.";
		case "ADMIN_MSG": return "^1Adminisztrátor üzenet";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Át lettél rakva a/az &&1^1-ba.";
		case "AFK_TIMER_DUPLICATED": return "AFK idozíto megduplázva.";
		case "ASS_DESC": return "Megölni a királyt.";
		case "ASSASSIN_LEFT": return "Az ^1 Orgyilkos^7 kilépett ^7 - Új orgyilkos választása!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^1 A ^7&&1 ^1 Ki van kapcsolva ezen a pályán.";
		case "AWARD_JUGGER_NOT_READY": return "Még nem használható a juggernaut mellény.";
		case "BADGE_OFF": return "A jelvény deaktiválva.";
		case "BADGE_ON": return "A jelvény aktiválva.";
		case "BOX_AIRSUPPORT": return "A légitámogatás parancsra vár.";
		case "BOX_EXPLOSIVE": return "Kaptál némi robbanószert.";
		case "BOX_FLASH": return "Kaptál néhány villanógránátot.";
		case "BOX_JAVELIN_PICKUP": return "Kaptál egy javelint.";
		case "BOX_KNIVES": return "Kaptál néhány kést.";
		case "BOX_NADES": return "Kaptál néhány gránátot.";
		case "BOX_PICK": return "&&1 pontra van szükség!";
		case "BOX_POISON": return "Kaptál néhány mérgezõ gránátot.";
		case "BOX_RCXD": return "RC-XD megtöltve, és készen.";
		case "BOX_TRIP": return "Drótakadályt kaptál.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Nincs elérheto helikopter a Csomag elhozásához.";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Csomag nem elérheto.";
		case "CHARACTER_MENU_NO_SPEC": return "^1Nézonek kell lenned!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1A fejleszto ^7 csatlakozott a szerverhez.";
		case "DOG_SHIT": return "A kutyádnak szarnia kell.";
		case "DOG_SUICIDE": return "Csak a kutya lehet öngyilkos.";
		case "EVENT": return "Event : &&1";
		case "EVENT_INNOCENT_KILLED": return "Egy ^2ártatlan ^7 meghalt!";
		case "EVENT_PLAYER_WON": return "&&1 ^7nyert ";
		case "EVENT_TRAITOR_HINT": return "Te vagy az ^1Áruló^7!";
		case "EVENT_TRAITOR_KILLED": return "Az ^1Árulót ^7 megölték.";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Te vagy a Király";
		case "EXPLOSIVES_ALREADY_PLANTED": return "A robbanószert már élesítették.";
		case "EXTRA_LIFE_EARNED": return "Extra élet megszerezve.";
		case "EXTRA_LIFE_USED": return "Extra élet felhasználva";
		case "GHILLIE_CHANGES": return "A terepruhád a következõ éledés alkalmával változik meg.";
		case "GUARD_DESC": return "Védd a Királyt!";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "A szerver új Hardpoint Rendszert használ \n nyomj ESC-et, és menj a Hardpointok menüre!";
		case "HARDPOINTS_WILL_CHANGE": return "A Hardpointjaid  következo körben megváltoznak.";
		case "HE_APPEARS_AFK": return "^7Úgy tûnik &&1 AFK!";
		case "HELPER_LEFT": return "A ^1segíto kilépett ^7- Új segíto választása!";
		case "HOLD_BREATH": return "Nyomj ^3&&1 ^7-t, hogy hõképre válts.";
		case "INNOCENTS_ELIMINATED": return "Minden ártatlant megöltek.";
		case "INVALID_NAME": return "^1A neved érvénytelen és meg lett változtatva.";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Jármu hatótávon kívül!";
		case "KILLTHEKING": return "Öld meg a Királyt";
		case "KING_DESC": return "Éld túl.";
		case "KING_DIED": return "A Királyt megölték!";
		case "KING_LEFT": return "A Király kilépett!";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7 Megfojtotta a ^3Királyt!";
		case "KING_ON_GROUND": return "A Király a földön van!";
		case "KING_SURVIVED": return "A Király túlélte!";
		case "LOGGED_IN": return "^1Sikeresen bejelentkeztél!";
		case "LOGIN_FAILED": return "^1A bejelentkezés nem sikerült!";
		case "MAPVOTE_NEXTMAP": return "Következõ pálya: &&1";
		case "MORTAR_NOTAVAILABLE": return "Az aknavetõ nem elérhetõ.";
		case "NEW_ASS_IS": return "Az új Orgyilkos: &&1";
		case "NEW_ASSASSIN_IS": return "Az új Orgyilkos: &&1";
		case "NEW_DOG_IS": return "Az új kutya: &&1";
		case "NEW_KING_IS": return "Az új Király:&&1";
		case "NEW_SLAVE_IS": return "Az új szolga:&&1";
		case "NO_BADGE": return "Nincs jelvényed, amit aktiválhatnál.";
		case "NO_FREE_SLOTS": return "Nincs szabad hely új itemhez";
		case "NO_GLITCH": return "^1Ne használj glitch-et!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Képtelen ^7új játékost választani!";
		case "NO_PERMISSION": return "^1Nincsen meg a megfelelõ jogusultság!";
		case "NO_TRIPS": return "Nincs több dórtakadályod";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7csatlakozott a szerverre.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "Úgy tunik elvesztetted a rankod - Visszaállítás";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7 a földre küldte ^1&&2^7-t!";
		case "PLAYER_ON_GROUND": return "&&1 a földre került!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1halálos töltetet hordoz.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Nem tudod helyettesíteni a másodlagos fegyvered.";
		case "PRESTIGE_MAX_REACHED": return "Nincs több elérhetõ Presztízs szint!";
		case "PRESTIGE_REQUIREMENTS": return "Még nem érted el a követelményeket!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Elobb el kell érned a következo rankot &&1.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Kell még &&1 XP";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1 Hiba biztonsági fájl írás közben.";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Jelenlegi presztízsed alacsonyabb - Megszakítás";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Jelenlegi presztízsed magasabb - Megszakítás";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1 Jelenlegi rankod alacsonyabb - Megszakítás";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1 Jelenlegi rankod magasabb - Megszakítás";
		case "PROFILE_BACKUP_CREATED": return "Biztonsági fájl elkészült - következo pályán használható!";
		case "PROFILE_BACKUP_LOADED": return "Biztonsági fájl sikeresen helyreállítva";
		case "PROFILE_BACKUP_LOADING": return "^1Biztonsági fájl helyreállítása - ne hagyd el a szervert!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1 A nevednek nem találtunk biztonsági fájlt.";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "A forgás iránya megváltoztatva!";
		case "RANK_HACKED": return "^1Úgy tûnik megpróbáltad meghackelni a rangodat!";
		case "RCXD_NOTAVAILABLE": return "RC-XD nem elérhetõ.";
		case "REVIVED_BY": return "&&1-t újraélesztette &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1Nincs több zászló ^3- ^1nincs újraéledés zászló elfoglalásáig!";
		case "SELECTION_IMPOSSIBLE": return "Nincs elég játékos a kiválasztáshoz.";
		case "SELF_REVIVED": return "&&1 újraélesztette magát.";
		case "SENTRY_GUN_BAD_SPOT": return "Nem lehet ^2Automata tornyot ^7 lerakni ide.";
		case "SPAWNPROTECTION_DISABLED": return "^1Spawn védelem kikapcsolva.";
		case "SPAWNPROTECTION_ENABLED": return "^2Spawn védelem bekapcsolva.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^2Orök^7nem mehetnek az ^1Orgyilkosok ^7 éledohelyére!";
		case "TERMINATOR_IS": return "&&1 egy Terminátor!";
		case "TRAITORS_ELIMINATED": return "Minden áruló megölve.";
		case "TRIP_ACTIVE_IN": return "Drótakadály aktív &&1 másodpercen belül.";
		case "TRIP_BAD_SPOT": return "Nem rakhatsz le drótakadályt ide!";
		case "TUTORIAL_1": return "Alapvetõen a név mindent elárúl. A ^2Védõk ^7csapat tagjainak a feladata, a Király megvédése.";
		case "TUTORIAL_10": return "Az egyik csapat - ^2Védõk ^7- feladata, hogy megvédjék a terminálokat szerte a pályán.";
		case "TUTORIAL_11": return "A másik csapat - ^1Mernylõk ^7- feladata, hogy ^7egy vírust töltsenek fel a terminálokra, hogy kikapcsolják azokat.";
		case "TUTORIAL_2": return "A ^1Merénylõk ^7csapat tagjai ennek épp az ellenkezõjén dolgoznak, azaz nekik meg kell ölniük a ^2Királyt^7.";
		case "TUTORIAL_3": return "A ^2Királyt ^7és a ^2Védõit ^7egy ^2Terminátor ^7segítheti, aki egy erõs robot, gépfegyverrel felszerelve.";
		case "TUTORIAL_4": return "^2A Kódot tartalmazza (befejezetlen)";
		case "TUTORIAL_5": return "Az egyik csapat - ^2Védõk ^7- feladata, hogy megvédjék a ^2Királyt ^7és a bõröndjét, ami a titkos kódot tartalmazza.";
		case "TUTORIAL_6": return "A másik csapat - ^1Mernylõk ^7- feladata, hogy likvidálják a ^2Királyt ^7azért, hogy ellophassák a bõröndjét";
		case "TUTORIAL_7": return "és birtokolják azt egy bizonyos ideig. Amikor a ^1Merénylõk ^7sikeresen ellopták a titkos kódot,";
		case "TUTORIAL_8": return "akkor egy nukleáris bombát lesznek képesek kilõni.";
		case "TUTORIAL_9": return "^2Törd fel a terminált (befejezetlen)";
		case "TUTORIAL_TITLE": return "Egy rövid ismertetõ a játékról";
		case "UNIFORM_OF_GUARD": return "Egy Or egyenruhája van rajtad.";
		case "VISION_OFF": return "A látvány letiltva.";
		case "VISION_ON": return "A látvány engedélyezve.";
		case "YOU_APPEAR_AFK": return "^1Úgy tûnik AFK vagy!";
		case "YOU_APPEAR_STUCK": return "Úgy tûnik beragadtál.";
		case "YOU_HAVE_THE_WEAPON": return "Már rendelkezel ezzel a fegyverrel.";
		case "ZIPLINE_BAD_END": return "Rossz pozíción a kötél vége.";
		case "ZIPLINE_BAD_START": return "Rossz pozíción a kötél eleje.";
		case "ZIPLINE_DESTROIED_USAGE": return "A drótkötelet elvágták mielott használhattad volna.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Max drótkötél mennyiség elérve.";
		case "ZIPLINE_PLACED_END": return "Kötél vége elhelyezve.";
		case "ZIPLINE_PLACED_START": return "Kötél eleje elhelyezve.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Nem sikerült ellopni a ládát.";
		case "CP_IS_A_TRAP": return &"Ez egy csapda.";
		case "CP_PRESS_USE": return &"Nyomj ^3[{+activate}], ^7hogy kinyisd a ládát.";
		case "DOG_SNIFF_ENEMY": return &"Nyomd meg a ^3[{+activate}] ^7hogy ellenségeket szagolj ki.";
		case "FOLLOWING": return &"Követés: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD robbanása ennyi ido múlva : ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 elmegy ennyi ido múlva :^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predator felrobban ennyi ido múlva: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Automata torony felrobban ennyi ido múlva: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Helikopter elmegy ennyi ido múlva: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Nyomj ^3[{+activate}] ^7hogy elhagyd.";
		case "KING_IS": return &"^2A Király: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Elvérzés: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Legjobb Orgyilkos:";
		case "MAPRECORD_BEST_KD": return &"Legjobb K/D:";
		case "MAPRECORD_BEST_STREAK": return &"Legmagasabb Killstreak:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Leggyorsabb Király gyilkos:";
		case "MAPRECORD_LONGEST_KING": return &"Leghosszabb Király ido:";
		case "MAPRECORD_MOST_DEATHS": return &"Legtöbb halál:";
		case "MAPRECORD_MOST_KILLS": return &"Legtöbb ölés:";
		case "MAPRECORD_TITLE": return &"Hírességek Csarnoka - A pálya legjobb játékosai (minden alkalommal)";
		case "NADE_ON_YOU": return &"Egy gránát ragadt rád!";
		case "NO_KING_YET": return &"^2Még nincs választott Király.";
		case "NOT_ENOUGH_PLAYERS": return &"Legalább &&1 játékos szükséges a kezdéshez!";
		case "PICK_ASSASSIN": return &"Az Orgyilkos kiválasztása";
		case "PICK_DOG": return &"A Kutya kiválasztása";
		case "PICK_KING": return &"A Király kiválasztása";
		case "PICK_SLAVE": return &"A Szolga kiválasztása";
		case "PICKED_ASSASSIN_IS": return &"Az Orgyilkos: &&1";
		case "PICKED_DOG_IS": return &"A Kutya: &&1";
		case "PICKED_KING_IS": return &"A Király: &&1";
		case "PICKED_SLAVE_IS": return &"O a rabszolga: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Az Orgyilkos kutyájának vagy szolgájának választása";
		case "WEAPONCHANGE_GUNGAME": return &"Nyomj ^3[{+activate}]^7-t az új fegyverért.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Nyomj ^3[{+activate}]^7-t a fegyverváltáshoz.";
		case "ZIPLINE_USAGE_INFO": return &"Nyomd meg a ^3[{+activate}] ^7/ ^1 [{+melee}] ^7 hogy ^3Használd^7/^1Elpusztítsd ^7a menekülo kötelet.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Nyomd meg a ^3[{+activate}] ^7-t hogy felgyorsulj.";
		case "REVIVE_INFO_YOUSELF": return &"Tartsd lenyomva a ^3[{+activate}] ^7-t, hogy újraéleszd magad. (&&1)";
		case "REVIVE_INFO": return &"Tartsd lenyomva a ^3[{+activate}] ^7-t újraélesztéshez.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Nyomd meg a ^3[{+attack}] ^7-t, hogy lerakd a tornyot.";
		case "TRIP_PLANT": return &"Tartsd lenyomva a ^73[{+activate}]^7, hogy drótakadályt lerakj.";		
		case "HUD_KING_HEALTH": return &"Király élete: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Terminátor élete: &&1";
		case "THROWBACKGRENADE": return &"Nyomj ^3[{+activate}] ^7-t a kés felvételéhez.";
		case "BOX_PRESS_USE": return &"Nyomj ^3[{+activate}]^7-t egy véletlenszerû fegyverért.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_HUN";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_HUN";
		case "MONEY": return &"KTK_MONEY_HUN";
	
		default: return "";
	}
}