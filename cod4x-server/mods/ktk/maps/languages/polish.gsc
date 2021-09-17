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
		case "AC130_NOTAVAILABLE": return "AC130 nie jest dostepny.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: Admin wykonal  '&&1' na &&2 ^1przez rcon.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "ACP blad: nie mozna zmienic dvar '^3&&1^1'! Reason: no value defined-skladnia poprawna?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: Admin zmienil dvar '^3&&1^1' na '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP blad: Event aktualnie trwa!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP blad:  &&1^1Nie udalo sie zalogowac!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP blad: Dwoch lub wiecej graczy pasuje do wpisanej nazwy.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "1ACP blad: Nie znaleziono gracza o takiej nazwie.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP Error: Niemozliwe jest aktualizowanie rang w okresie przed meczem";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP blad: Obecny prestiz gracza &&1 jest wyzszy - przerywamy!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP blad: Obecna ranga gracza &&1 ^pasuje do nowej - ANULOWANIE!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP blad: Obecna ranga gracza &&1 ^1jest wyzsza -ANULOWANIE!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP blad: Nie mozna wymusic odrodzenia na graczu, który jest oznaczony jako AFK";
		case "ACP_EVENT_STARTED": return "^1Admin rozpoczal:^3&&^1-Restartowanie mapy w nastepnej rundzie!";
		case "ACP_EVENT_STOPPED": return "^1Admin zatrzymal obecny event - Restartowanie mapy w nastepnej rundzie!";
		case "ACP_PLAYER_MUTED": return "Jestes wyciszony!";
		case "ACP_PLAYER_UNMUTED": return "Juz nie jestes wyciszony!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 wrócil do walki.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 zostal przeniesiony do &&2.";
		case "ADMIN_MSG": return "^1Wiadomosc od administratora";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Zostales przeniesiony do &&1.";
		case "AFK_TIMER_DUPLICATED": return "Czasomierz AFK zdublowany!";
		case "ASS_DESC": return "Zabij Króla.";
		case "ASSASSIN_LEFT": return "^1Zabójca wyszedl^7- Wybieranie nowego!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "&&1 ^1jest zablokowany na tej mapie!";
		case "AWARD_JUGGER_NOT_READY": return "Nie mozesz jeszcze uzywac stroju juggernauta.";
		case "BADGE_OFF": return "Odznaka wylaczona.";
		case "BADGE_ON": return "Odznaka aktywowana.";
		case "BOX_AIRSUPPORT": return "Nalot oczekuje wezwania.";
		case "BOX_EXPLOSIVE": return "Otrzymales materialy wybuchowe.";
		case "BOX_FLASH": return "Otrzymales kilka flash'y.";
		case "BOX_JAVELIN_PICKUP": return "Dostales oszczep!";
		case "BOX_KNIVES": return "Otrzymales noze do rzucania.";
		case "BOX_NADES": return "Otrzymales granaty.";
		case "BOX_PICK": return "Wymagana ilosc punktów to &&1!";
		case "BOX_POISON": return "Otrzymales trujace granaty.";
		case "BOX_RCXD": return "RC-XD jest gotowy.";
		case "BOX_TRIP": return "Otrzymales mine laserowa.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Helikopter niedostepny w pakiecie opieki";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Carepackage niedostepne";
		case "CHARACTER_MENU_NO_SPEC": return "Musisz byc widzem!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1Deweloper^7dolaczyl do serwera.";
		case "DOG_SHIT": return "Twoj pies musi sie zalatwic";
		case "DOG_SUICIDE": return "Tylko pies moze popelnic samobójstwo.";
		case "EVENT": return "Event: &&1";
		case "EVENT_INNOCENT_KILLED": return "^2Zabito ^7niewinnego!";
		case "EVENT_PLAYER_WON": return "&&1 ^7wygral za ^2&&2 ^7czas!";
		case "EVENT_TRAITOR_HINT": return "Jestes ^1zdrajca^7!";
		case "EVENT_TRAITOR_KILLED": return "^1Zdrajca ^7zostal zamordowany!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Jestes krolem!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Ladunek wybuchowy podstawiony!";
		case "EXTRA_LIFE_EARNED": return "Zdobyto dodatkowe zycia";
		case "EXTRA_LIFE_USED": return "Dodatkowe zycia uzyte";
		case "GHILLIE_CHANGES": return "Twój kamuflaz zostanie zmieniony po kolejnym narodzeniu.";
		case "GUARD_DESC": return "Chron Króla.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "Server uzywa nowego systemu Hardpoint, \n nacisnij klawisz ESC i przejdz do menu Hardpoints!";
		case "HARDPOINTS_WILL_CHANGE": return "Twoje Hardpoints zmieni sie w nastepnej rundzie.";
		case "HE_APPEARS_AFK": return "^7&&1 jest AFK!";
		case "HELPER_LEFT": return "^1Asystent wyszedl ^7- wybierz nowy!";
		case "HOLD_BREATH": return "Nacisnij ^3&&1 ^7,aby wlaczyc termowizjer.";
		case "INNOCENTS_ELIMINATED": return "Wszyscy niewinni zostali zamordowani";
		case "INVALID_NAME": return "^1Twoje imie jest wadliwe i zostalo zmienione";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Pojazd poza zasiegiem";
		case "KILLTHEKING": return "Zabic Króla";
		case "KING_DESC": return "Przetrwaj.";
		case "KING_DIED": return "Król zostal zabity.";
		case "KING_LEFT": return "Król wyszedl z gry.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7powalil krola na ziemie!";
		case "KING_ON_GROUND": return "Król jest na ziemi!";
		case "KING_SURVIVED": return "Król przezyl.";
		case "LOGGED_IN": return "^1Zostales zalogowany!";
		case "LOGIN_FAILED": return "^1Blad logowania!";
		case "MAPVOTE_NEXTMAP": return "Nastepna mapa: &&1";
		case "MORTAR_NOTAVAILABLE": return "Mozdzierz nie jest dostepna.";
		case "NEW_ASS_IS": return "Nowym Assassynem jest: &&1";
		case "NEW_ASSASSIN_IS": return "Nowym assasynem jest &&1";
		case "NEW_DOG_IS": return "Nowym psem jest &&1";
		case "NEW_KING_IS": return "Nowym krolem jest &&1";
		case "NEW_SLAVE_IS": return "Nowym niewolnikiem jest &&1";
		case "NO_BADGE": return "Nie masz odznaki do aktywowania.";
		case "NO_FREE_SLOTS": return "Brak miejsca na nowe itemy";
		case "NO_GLITCH": return "^1Nie wykorzystuj bledów mapy!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Nie mozna ^7wybrac nowego gracza!";
		case "NO_PERMISSION": return "^1Niewystarczajace uprawnienia!";
		case "NO_TRIPS": return "Nie posiadasz min laserowych!";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7dolaczyl do serwera.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "Wyglada na to, ze straciles range - Odzyskanie";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7zestrzelic ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 jest na ziemi!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1niesie ze soba smiertelny pocisk.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Nie mozesz wymienic broni bocznej!";
		case "PRESTIGE_MAX_REACHED": return "Brak dalszych poziomów prestizu!";
		case "PRESTIGE_REQUIREMENTS": return "Nie osiagnales(as) odpowiedniego poziomu!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Najpierw musisz osiagnac range &&1.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Potrzebujesz &&1 Wiecej XP.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Blad zapisu pliku kopii zapasowej!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Twój obecny prestiz ponizej - aborcja";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Twój obecny prestiz wyzszy - aborcja";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Twój obecny ranga ponizej - aborcja";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Twój obecny ranga wyzszy - aborcja";
		case "PROFILE_BACKUP_CREATED": return "Utworzono plik kopii zapasowej - nadajaca sie do uzycia nastepujaca Mapa!";
		case "PROFILE_BACKUP_LOADED": return "Kopia zapasowa zostala pomyslnie przywrócona!";
		case "PROFILE_BACKUP_LOADING": return "^1Przywracanie kopii zapasowej - nie opuszczaj serwera!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1Nie znaleziono pliku kopii zapasowej dla Twojej kombinacji guid-name!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "Kierunek obrotów sie zmienil!";
		case "RANK_HACKED": return "^1Wyglada na to ze próbujesz hackowac swój ranking!";
		case "RCXD_NOTAVAILABLE": return "RC-XD nie jest dostepny.";
		case "REVIVED_BY": return "&&1 zostal(a) usdrowiony(a) przez &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "Brak FLAG ^3 - ^1bez odrodzenia, dopóki nie zdobedziesz flagi!";
		case "SELECTION_IMPOSSIBLE": return "Niewystarczajaca ilosc graczy do wyboru.";
		case "SELF_REVIVED": return "&&1 uzdrowil(a) sam(a) siebie.";
		case "SENTRY_GUN_BAD_SPOT": return "Nie mozna wdrozyc ^2Sentry Gun ^7tutaj.";
		case "SPAWNPROTECTION_DISABLED": return "^2Ochrona wylaczona.";
		case "SPAWNPROTECTION_ENABLED": return "^2Ochrona wlaczona.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^2Strazniki ^7nie sa dozwolone w tarle ^1Assassins^7!";
		case "TERMINATOR_IS": return "&&1 jest Terminatorem!";
		case "TRAITORS_ELIMINATED": return "Wszyscy zdrajcy wyeliminowani";
		case "TRIP_ACTIVE_IN": return "Tripwire aktywny w & & 1 sekund.";
		case "TRIP_BAD_SPOT": return "Nie mozesz polozyc miny laserowej w tym miejscu!";
		case "TUTORIAL_1": return "W podstawach nazwa Moda wyjasnia sposób rozgrywki. Jednym z zespolów sa ^2Obroncy, ^7którzy staraja sie chronic Króla.";
		case "TUTORIAL_10": return "^2Obroncy powinni chronic terminale znajdujace sie na mapie.";
		case "TUTORIAL_11": return "^1Assassyni musza wgrac wirusa do terminala aby go zniszczyc.";
		case "TUTORIAL_2": return "Drugi zespól, którym sa ^1Assassyni musza zabic Króla.";
		case "TUTORIAL_3": return "^2Król i ^2Obroncy sa wspierani przez ^2Terminatora, ^7który jest robotem wyposazonym w miniguna.";
		case "TUTORIAL_4": return "^2Zawiera kod (niedokonczone)";
		case "TUTORIAL_5": return "Zadaniem ^2Obronców jest ochrona Króla i jego teczki, która zawiera strzezony kod.";
		case "TUTORIAL_6": return "Zadaniem ^1Assassynów jest zabicie Króla i kradziez teczki, która musza przetrzymac";
		case "TUTORIAL_7": return "przez pewien okres czasu.";
		case "TUTORIAL_8": return "Gdy ^1Assassyni ^7zdobeda kod, bomba atomowa zostanie odpalona.";
		case "TUTORIAL_9": return "^2Hackowanie Terminatora (niedokonczone)";
		case "TUTORIAL_TITLE": return "Informacje o rozgrywce i Modzie";
		case "UNIFORM_OF_GUARD": return "Masz Mundur straznika.";
		case "VISION_OFF": return "Widzenie wylaczone.";
		case "VISION_ON": return "Widzenie wlaczone.";
		case "YOU_APPEAR_AFK": return "^1Wydajesz sie byc AFK!";
		case "YOU_APPEAR_STUCK": return "Utknales.";
		case "YOU_HAVE_THE_WEAPON": return "Masz juz te bron.";
		case "ZIPLINE_BAD_END": return "Zla pozycja haka.";
		case "ZIPLINE_BAD_START": return "Zla pozycja haka.";
		case "ZIPLINE_DESTROIED_USAGE": return "Ten zamek zostal przeciety, zanim zdazyles go uzyc.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Maksymalna ilosc linii zip osiagnieta.";
		case "ZIPLINE_PLACED_END": return "Hak umieszczony.";
		case "ZIPLINE_PLACED_START": return "Hak startowy umieszczony.";
			
		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Nie mozna ukrasc skrzynie.";
		case "CP_IS_A_TRAP": return &"To jest pulapka.";
		case "CP_PRESS_USE": return &"Trzymaj ^3[{+activate}] ^7to otworzyc skrzynie.";
		case "DOG_SNIFF_ENEMY": return &"Nacisnij ^3[{+activate}] ^7aby powachac wrogów.";
		case "FOLLOWING": return &"Kolejny: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD explodes w: ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 liscie w: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predator explodes w:: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Sentry Gun explodes w:: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Helicopter liscie w: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Nacisnij ^3[{+activate}] ^7aby opuscic.";
		case "KING_IS": return &"^2Królem jest: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Krwawienie out: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Najlepszy Assasyn:";
		case "MAPRECORD_BEST_KD": return &"Najlepsze K/D:";
		case "MAPRECORD_BEST_STREAK": return &"Najwiekszy killstreak:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Najszybszy zabojca krola:";
		case "MAPRECORD_LONGEST_KING": return &"Twoje Hardpoints zmieni sie w nastepnej rundzie:";
		case "MAPRECORD_MOST_DEATHS": return &"Najwiecej smierci:";
		case "MAPRECORD_MOST_KILLS": return &"Najwiecej zabojstw:";
		case "MAPRECORD_TITLE": return &"Hall of Fame - najlepsi gracze na tej mapie (caly czas)";
		case "NADE_ON_YOU": return &"Granat przyczepil sie do ciebie!";
		case "NO_KING_YET": return &"^2Król nie zostal jeszcze wybrany.";
		case "NOT_ENOUGH_PLAYERS": return &"Potrzeba co najmniej &&1 graczy, aby rozpoczac!";
		case "PICK_ASSASSIN": return &"Wybieranie Assassyna";
		case "PICK_DOG": return &"Wybieranie psa";
		case "PICK_KING": return &"Wybieranie Króla";
		case "PICK_SLAVE": return &"Grzebiac niewolnika";
		case "PICKED_ASSASSIN_IS": return &"Assassynem jest: &&1";
		case "PICKED_DOG_IS": return &"Psem jest: &&1";
		case "PICKED_KING_IS": return &"Królem jest: &&1";
		case "PICKED_SLAVE_IS": return &"Niewolnik jest: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Wybieranie psa assassins lub niewolnika";
		case "WEAPONCHANGE_GUNGAME": return &"Nacisnij ^3[{+activate}] ^7,aby uzyc nowej broni.";
		case "WEAPONCHANGE_PRESS_USE": return &"Nacisnij ^3[{+activate}] ^7,aby zmienic bron.";
		case "ZIPLINE_USAGE_INFO": return &"Nacisnij ^3[{+activate}] ^7/ ^1[{+melee}] ^7aby ^3uzyc^7/^1zniszczyc ^7line ratunkowa.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Nacisnij ^3[{+activate}] ^7zeby przyspieszyc.";
		case "REVIVE_INFO_YOUSELF": return &"Przytrzymaj ^3[{+acvivate}] ^7aby ozywic siebie. (&&1)";
		case "REVIVE_INFO": return &"Przytrzymaj ^3[{+activatej}] ^7aby ozywic.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Nacisnij ^3[{+attack}] ^7Aby rozmiescic wartownika.";
		case "TRIP_PLANT": return &"Przytrzymaj ^3[{+activatej}] ^7aby zalozyc drut.";
		case "HUD_KING_HEALTH": return &"Krol zdrowie: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Terminator zdrowie: &&1";
		case "THROWBACKGRENADE": return &"Nacisnij ^3[{+activate}] ^7,aby podniesc nóz.";
		case "BOX_PRESS_USE": return &"Przytrztmaj ^3[{+activate}] ^7,aby zdobyc losowa bron.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_PL";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_PL";
		case "MONEY": return &"KTK_MONEY_PL";

		default: return "";
	}
}