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
		case "AC130_NOTAVAILABLE": return "AC130 nem el�rhet�.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1AIP: Egy admin a k�vetkezot hajtotta v�gre '^&&1' &&2 j�t�koson ^1 konzol �ltal";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1AIP hiba: Nem megv�ltoztathat� a dvar '^3&&1^1'! Ok: ^3 Nincs �rt�k megadva -  Syntax helyes?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1AIP: Egy admin megv�ltoztatta a dvar-t '^3&&1^1' -r�l '^3&&2^21'-ra";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1AIP hiba: Az event m�r fut!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1AIP hiba: &&1 ^1nem tudott bejelentkezni!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1AIP Hiba: Ketto vagy t�bb j�t�kosnak ugyanez a neve.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1AIP Hiba: Nincs ilyen n�vvel rendelkezo j�t�kos.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1AIP Hiba: Nem lehet rangokat friss�teni meccs elott.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1AIP hiba: A &&1 j�t�kos jelenlegi preszt�zse ^1 magasabb - MEGSZAK�T�S";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1AIP hiba: A &&1 j�t�kos jelenlegi rankja ^1 egyezik az �jjal - MEGSZAK�T�S!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1AIP hiba: A &&1 j�t�kos jelenlegi rankja ^1 magasabb - MEGSZAK�T�S";
		case "ACP_ERROR_NO_SPAWN": return "^1AIP hiba: Nem lehet AFK-nak jel�lt j�t�kost le spawnoltatni.";
		case "ACP_EVENT_STARTED": return "^1 Egy admin elind�totta a k�vetkezot: ^3&&1^1 - P�lya �jraind�t�sa a k�vetkezo k�rben!";
		case "ACP_EVENT_STOPPED": return "^1 Egy admin meg�ll�totta a jelenlegi eventet - P�lya �jraind�t�sa a k�vetkezo k�rben!";
		case "ACP_PLAYER_MUTED": return "^1 Le vagy n�m�tva!";
		case "ACP_PLAYER_UNMUTED": return "^1 N�m�t�sod felold�sra ker�lt!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 visszat�rt a harcba.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 �t lett rakva a/az &&2-ba.";
		case "ADMIN_MSG": return "^1Adminisztr�tor �zenet";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1�t lett�l rakva a/az &&1^1-ba.";
		case "AFK_TIMER_DUPLICATED": return "AFK idoz�to megdupl�zva.";
		case "ASS_DESC": return "Meg�lni a kir�lyt.";
		case "ASSASSIN_LEFT": return "Az ^1 Orgyilkos^7 kil�pett ^7 - �j orgyilkos v�laszt�sa!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^1 A ^7&&1 ^1 Ki van kapcsolva ezen a p�ly�n.";
		case "AWARD_JUGGER_NOT_READY": return "M�g nem haszn�lhat� a juggernaut mell�ny.";
		case "BADGE_OFF": return "A jelv�ny deaktiv�lva.";
		case "BADGE_ON": return "A jelv�ny aktiv�lva.";
		case "BOX_AIRSUPPORT": return "A l�git�mogat�s parancsra v�r.";
		case "BOX_EXPLOSIVE": return "Kapt�l n�mi robban�szert.";
		case "BOX_FLASH": return "Kapt�l n�h�ny villan�gr�n�tot.";
		case "BOX_JAVELIN_PICKUP": return "Kapt�l egy javelint.";
		case "BOX_KNIVES": return "Kapt�l n�h�ny k�st.";
		case "BOX_NADES": return "Kapt�l n�h�ny gr�n�tot.";
		case "BOX_PICK": return "&&1 pontra van sz�ks�g!";
		case "BOX_POISON": return "Kapt�l n�h�ny m�rgez� gr�n�tot.";
		case "BOX_RCXD": return "RC-XD megt�ltve, �s k�szen.";
		case "BOX_TRIP": return "Dr�takad�lyt kapt�l.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Nincs el�rheto helikopter a Csomag elhoz�s�hoz.";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Csomag nem el�rheto.";
		case "CHARACTER_MENU_NO_SPEC": return "^1N�zonek kell lenned!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1A fejleszto ^7 csatlakozott a szerverhez.";
		case "DOG_SHIT": return "A kuty�dnak szarnia kell.";
		case "DOG_SUICIDE": return "Csak a kutya lehet �ngyilkos.";
		case "EVENT": return "Event : &&1";
		case "EVENT_INNOCENT_KILLED": return "Egy ^2�rtatlan ^7 meghalt!";
		case "EVENT_PLAYER_WON": return "&&1 ^7nyert ";
		case "EVENT_TRAITOR_HINT": return "Te vagy az ^1�rul�^7!";
		case "EVENT_TRAITOR_KILLED": return "Az ^1�rul�t ^7 meg�lt�k.";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Te vagy a Kir�ly";
		case "EXPLOSIVES_ALREADY_PLANTED": return "A robban�szert m�r �les�tett�k.";
		case "EXTRA_LIFE_EARNED": return "Extra �let megszerezve.";
		case "EXTRA_LIFE_USED": return "Extra �let felhaszn�lva";
		case "GHILLIE_CHANGES": return "A terepruh�d a k�vetkez� �led�s alkalm�val v�ltozik meg.";
		case "GUARD_DESC": return "V�dd a Kir�lyt!";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "A szerver �j Hardpoint Rendszert haszn�l \n nyomj ESC-et, �s menj a Hardpointok men�re!";
		case "HARDPOINTS_WILL_CHANGE": return "A Hardpointjaid  k�vetkezo k�rben megv�ltoznak.";
		case "HE_APPEARS_AFK": return "^7�gy t�nik &&1 AFK!";
		case "HELPER_LEFT": return "A ^1seg�to kil�pett ^7- �j seg�to v�laszt�sa!";
		case "HOLD_BREATH": return "Nyomj ^3&&1 ^7-t, hogy h�k�pre v�lts.";
		case "INNOCENTS_ELIMINATED": return "Minden �rtatlant meg�ltek.";
		case "INVALID_NAME": return "^1A neved �rv�nytelen �s meg lett v�ltoztatva.";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "J�rmu hat�t�von k�v�l!";
		case "KILLTHEKING": return "�ld meg a Kir�lyt";
		case "KING_DESC": return "�ld t�l.";
		case "KING_DIED": return "A Kir�lyt meg�lt�k!";
		case "KING_LEFT": return "A Kir�ly kil�pett!";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7 Megfojtotta a ^3Kir�lyt!";
		case "KING_ON_GROUND": return "A Kir�ly a f�ld�n van!";
		case "KING_SURVIVED": return "A Kir�ly t�l�lte!";
		case "LOGGED_IN": return "^1Sikeresen bejelentkezt�l!";
		case "LOGIN_FAILED": return "^1A bejelentkez�s nem siker�lt!";
		case "MAPVOTE_NEXTMAP": return "K�vetkez� p�lya: &&1";
		case "MORTAR_NOTAVAILABLE": return "Az aknavet� nem el�rhet�.";
		case "NEW_ASS_IS": return "Az �j Orgyilkos: &&1";
		case "NEW_ASSASSIN_IS": return "Az �j Orgyilkos: &&1";
		case "NEW_DOG_IS": return "Az �j kutya: &&1";
		case "NEW_KING_IS": return "Az �j Kir�ly:&&1";
		case "NEW_SLAVE_IS": return "Az �j szolga:&&1";
		case "NO_BADGE": return "Nincs jelv�nyed, amit aktiv�lhatn�l.";
		case "NO_FREE_SLOTS": return "Nincs szabad hely �j itemhez";
		case "NO_GLITCH": return "^1Ne haszn�lj glitch-et!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1K�ptelen ^7�j j�t�kost v�lasztani!";
		case "NO_PERMISSION": return "^1Nincsen meg a megfelel� jogusults�g!";
		case "NO_TRIPS": return "Nincs t�bb d�rtakad�lyod";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7csatlakozott a szerverre.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "�gy tunik elvesztetted a rankod - Vissza�ll�t�s";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7 a f�ldre k�ldte ^1&&2^7-t!";
		case "PLAYER_ON_GROUND": return "&&1 a f�ldre ker�lt!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1hal�los t�ltetet hordoz.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Nem tudod helyettes�teni a m�sodlagos fegyvered.";
		case "PRESTIGE_MAX_REACHED": return "Nincs t�bb el�rhet� Preszt�zs szint!";
		case "PRESTIGE_REQUIREMENTS": return "M�g nem �rted el a k�vetelm�nyeket!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Elobb el kell �rned a k�vetkezo rankot &&1.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Kell m�g &&1 XP";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1 Hiba biztons�gi f�jl �r�s k�zben.";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Jelenlegi preszt�zsed alacsonyabb - Megszak�t�s";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Jelenlegi preszt�zsed magasabb - Megszak�t�s";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1 Jelenlegi rankod alacsonyabb - Megszak�t�s";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1 Jelenlegi rankod magasabb - Megszak�t�s";
		case "PROFILE_BACKUP_CREATED": return "Biztons�gi f�jl elk�sz�lt - k�vetkezo p�ly�n haszn�lhat�!";
		case "PROFILE_BACKUP_LOADED": return "Biztons�gi f�jl sikeresen helyre�ll�tva";
		case "PROFILE_BACKUP_LOADING": return "^1Biztons�gi f�jl helyre�ll�t�sa - ne hagyd el a szervert!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1 A nevednek nem tal�ltunk biztons�gi f�jlt.";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "A forg�s ir�nya megv�ltoztatva!";
		case "RANK_HACKED": return "^1�gy t�nik megpr�b�ltad meghackelni a rangodat!";
		case "RCXD_NOTAVAILABLE": return "RC-XD nem el�rhet�.";
		case "REVIVED_BY": return "&&1-t �jra�lesztette &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1Nincs t�bb z�szl� ^3- ^1nincs �jra�led�s z�szl� elfoglal�s�ig!";
		case "SELECTION_IMPOSSIBLE": return "Nincs el�g j�t�kos a kiv�laszt�shoz.";
		case "SELF_REVIVED": return "&&1 �jra�lesztette mag�t.";
		case "SENTRY_GUN_BAD_SPOT": return "Nem lehet ^2Automata tornyot ^7 lerakni ide.";
		case "SPAWNPROTECTION_DISABLED": return "^1Spawn v�delem kikapcsolva.";
		case "SPAWNPROTECTION_ENABLED": return "^2Spawn v�delem bekapcsolva.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^2Or�k^7nem mehetnek az ^1Orgyilkosok ^7 �ledohely�re!";
		case "TERMINATOR_IS": return "&&1 egy Termin�tor!";
		case "TRAITORS_ELIMINATED": return "Minden �rul� meg�lve.";
		case "TRIP_ACTIVE_IN": return "Dr�takad�ly akt�v &&1 m�sodpercen bel�l.";
		case "TRIP_BAD_SPOT": return "Nem rakhatsz le dr�takad�lyt ide!";
		case "TUTORIAL_1": return "Alapvet�en a n�v mindent el�r�l. A ^2V�d�k ^7csapat tagjainak a feladata, a Kir�ly megv�d�se.";
		case "TUTORIAL_10": return "Az egyik csapat - ^2V�d�k ^7- feladata, hogy megv�dj�k a termin�lokat szerte a p�ly�n.";
		case "TUTORIAL_11": return "A m�sik csapat - ^1Mernyl�k ^7- feladata, hogy ^7egy v�rust t�ltsenek fel a termin�lokra, hogy kikapcsolj�k azokat.";
		case "TUTORIAL_2": return "A ^1Mer�nyl�k ^7csapat tagjai ennek �pp az ellenkez�j�n dolgoznak, azaz nekik meg kell �lni�k a ^2Kir�lyt^7.";
		case "TUTORIAL_3": return "A ^2Kir�lyt ^7�s a ^2V�d�it ^7egy ^2Termin�tor ^7seg�theti, aki egy er�s robot, g�pfegyverrel felszerelve.";
		case "TUTORIAL_4": return "^2A K�dot tartalmazza (befejezetlen)";
		case "TUTORIAL_5": return "Az egyik csapat - ^2V�d�k ^7- feladata, hogy megv�dj�k a ^2Kir�lyt ^7�s a b�r�ndj�t, ami a titkos k�dot tartalmazza.";
		case "TUTORIAL_6": return "A m�sik csapat - ^1Mernyl�k ^7- feladata, hogy likvid�lj�k a ^2Kir�lyt ^7az�rt, hogy ellophass�k a b�r�ndj�t";
		case "TUTORIAL_7": return "�s birtokolj�k azt egy bizonyos ideig. Amikor a ^1Mer�nyl�k ^7sikeresen ellopt�k a titkos k�dot,";
		case "TUTORIAL_8": return "akkor egy nukle�ris bomb�t lesznek k�pesek kil�ni.";
		case "TUTORIAL_9": return "^2T�rd fel a termin�lt (befejezetlen)";
		case "TUTORIAL_TITLE": return "Egy r�vid ismertet� a j�t�kr�l";
		case "UNIFORM_OF_GUARD": return "Egy Or egyenruh�ja van rajtad.";
		case "VISION_OFF": return "A l�tv�ny letiltva.";
		case "VISION_ON": return "A l�tv�ny enged�lyezve.";
		case "YOU_APPEAR_AFK": return "^1�gy t�nik AFK vagy!";
		case "YOU_APPEAR_STUCK": return "�gy t�nik beragadt�l.";
		case "YOU_HAVE_THE_WEAPON": return "M�r rendelkezel ezzel a fegyverrel.";
		case "ZIPLINE_BAD_END": return "Rossz poz�ci�n a k�t�l v�ge.";
		case "ZIPLINE_BAD_START": return "Rossz poz�ci�n a k�t�l eleje.";
		case "ZIPLINE_DESTROIED_USAGE": return "A dr�tk�telet elv�gt�k mielott haszn�lhattad volna.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Max dr�tk�t�l mennyis�g el�rve.";
		case "ZIPLINE_PLACED_END": return "K�t�l v�ge elhelyezve.";
		case "ZIPLINE_PLACED_START": return "K�t�l eleje elhelyezve.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Nem siker�lt ellopni a l�d�t.";
		case "CP_IS_A_TRAP": return &"Ez egy csapda.";
		case "CP_PRESS_USE": return &"Nyomj ^3[{+activate}], ^7hogy kinyisd a l�d�t.";
		case "DOG_SNIFF_ENEMY": return &"Nyomd meg a ^3[{+activate}] ^7hogy ellens�geket szagolj ki.";
		case "FOLLOWING": return &"K�vet�s: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD robban�sa ennyi ido m�lva : ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 elmegy ennyi ido m�lva :^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predator felrobban ennyi ido m�lva: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Automata torony felrobban ennyi ido m�lva: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Helikopter elmegy ennyi ido m�lva: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Nyomj ^3[{+activate}] ^7hogy elhagyd.";
		case "KING_IS": return &"^2A Kir�ly: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Elv�rz�s: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Legjobb Orgyilkos:";
		case "MAPRECORD_BEST_KD": return &"Legjobb K/D:";
		case "MAPRECORD_BEST_STREAK": return &"Legmagasabb Killstreak:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Leggyorsabb Kir�ly gyilkos:";
		case "MAPRECORD_LONGEST_KING": return &"Leghosszabb Kir�ly ido:";
		case "MAPRECORD_MOST_DEATHS": return &"Legt�bb hal�l:";
		case "MAPRECORD_MOST_KILLS": return &"Legt�bb �l�s:";
		case "MAPRECORD_TITLE": return &"H�ress�gek Csarnoka - A p�lya legjobb j�t�kosai (minden alkalommal)";
		case "NADE_ON_YOU": return &"Egy gr�n�t ragadt r�d!";
		case "NO_KING_YET": return &"^2M�g nincs v�lasztott Kir�ly.";
		case "NOT_ENOUGH_PLAYERS": return &"Legal�bb &&1 j�t�kos sz�ks�ges a kezd�shez!";
		case "PICK_ASSASSIN": return &"Az Orgyilkos kiv�laszt�sa";
		case "PICK_DOG": return &"A Kutya kiv�laszt�sa";
		case "PICK_KING": return &"A Kir�ly kiv�laszt�sa";
		case "PICK_SLAVE": return &"A Szolga kiv�laszt�sa";
		case "PICKED_ASSASSIN_IS": return &"Az Orgyilkos: &&1";
		case "PICKED_DOG_IS": return &"A Kutya: &&1";
		case "PICKED_KING_IS": return &"A Kir�ly: &&1";
		case "PICKED_SLAVE_IS": return &"O a rabszolga: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Az Orgyilkos kuty�j�nak vagy szolg�j�nak v�laszt�sa";
		case "WEAPONCHANGE_GUNGAME": return &"Nyomj ^3[{+activate}]^7-t az �j fegyver�rt.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Nyomj ^3[{+activate}]^7-t a fegyverv�lt�shoz.";
		case "ZIPLINE_USAGE_INFO": return &"Nyomd meg a ^3[{+activate}] ^7/ ^1 [{+melee}] ^7 hogy ^3Haszn�ld^7/^1Elpuszt�tsd ^7a menek�lo k�telet.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Nyomd meg a ^3[{+activate}] ^7-t hogy felgyorsulj.";
		case "REVIVE_INFO_YOUSELF": return &"Tartsd lenyomva a ^3[{+activate}] ^7-t, hogy �jra�leszd magad. (&&1)";
		case "REVIVE_INFO": return &"Tartsd lenyomva a ^3[{+activate}] ^7-t �jra�leszt�shez.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Nyomd meg a ^3[{+attack}] ^7-t, hogy lerakd a tornyot.";
		case "TRIP_PLANT": return &"Tartsd lenyomva a ^73[{+activate}]^7, hogy dr�takad�lyt lerakj.";		
		case "HUD_KING_HEALTH": return &"Kir�ly �lete: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Termin�tor �lete: &&1";
		case "THROWBACKGRENADE": return &"Nyomj ^3[{+activate}] ^7-t a k�s felv�tel�hez.";
		case "BOX_PRESS_USE": return &"Nyomj ^3[{+activate}]^7-t egy v�letlenszer� fegyver�rt.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_HUN";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_HUN";
		case "MONEY": return &"KTK_MONEY_HUN";
	
		default: return "";
	}
}