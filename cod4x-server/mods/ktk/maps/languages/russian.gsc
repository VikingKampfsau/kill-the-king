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
		case "AC130_NOTAVAILABLE": return "AC130 недоступен.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: Админ выполнил '&&1' на &&2 ^1через rcon.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP error: Невозможно изменить dvar '^3&&1^1'! Причина: ^3Значение не определено - Синтаксик правильный?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: Админ изменил dvar' ^3&&1^1' на '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP error: Мероприятие уже запущено!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP error: &&1 ^1не удалось войти в систему!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP error: Два или более игроков, соответствующих введенному имени.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP error: Нет игроков соответствующих введенному имени.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP error: Невозможно обновить ранги в предматчевый период.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP error: Текущий престиж игрока &&1 ^1выше - АБОРТ!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP error: Текущий уровень игрока &&1 ^1соответствует новому - АБОРТ!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP error: Текущий ранг игрока &&1 ^1выше - АБОРТ!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP error: Не может возродить игрока, который помечен как AFK.";
		case "ACP_EVENT_STARTED": return "^1Админ начал: ^3&&1^1 - перезапуск карты в следующем раунде!";
		case "ACP_EVENT_STOPPED": return "^1Админ остановил текущее событие - перезапуск карты в следующем раунде!";
		case "ACP_PLAYER_MUTED": return "^1Вы приглушены!";
		case "ACP_PLAYER_UNMUTED": return "^1Вы не приглушены!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 снова в бою.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 был перенесён в &&2.";
		case "ADMIN_MSG": return "^1Сообщение Администратора";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Вас перенесли в &&1.";
		case "AFK_TIMER_DUPLICATED": return "Дублированный таймер АФК!";
		case "ASS_DESC": return "Устранить короля.";
		case "ASSASSIN_LEFT": return "^1Ассасин ^1покинул нас ^7- выбираю нового!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^1The ^7&&1 ^1отключён на этой карте!";
		case "AWARD_JUGGER_NOT_READY": return "Нельзя пока использовать костюм Джаггернаута";
		case "BADGE_OFF": return "Значок деактивирован.";
		case "BADGE_ON": return "Значок активирован.";
		case "BOX_AIRSUPPORT": return "Воздушная поддержка ждет команды.";
		case "BOX_EXPLOSIVE": return "У тебя есть взрывчатка.";
		case "BOX_FLASH": return "У тебя есть несколько светошумовых гранат.";
		case "BOX_JAVELIN_PICKUP": return "У тебя есть копье!";
		case "BOX_KNIVES": return "У тебя есть несколько ножей.";
		case "BOX_NADES": return "У тебя есть несколько гранат.";
		case "BOX_PICK": return "Требуется &&1 очков!";
		case "BOX_POISON": return "У тебя есть несколько ядовитых гранат.";
		case "BOX_RCXD": return "RC-XD заполнен и готов.";
		case "BOX_TRIP": return "У тебя есть растяжка.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Нет доступного вертолёта для Ящика снабжения";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Ящик снабжения недоступен";
		case "CHARACTER_MENU_NO_SPEC": return "^1Вы должны быть зрителем, чтобы сделать это.";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1Разработчик ^7присоединился к серверу.";
		case "DOG_SHIT": return "Ваша собака должна посрать!";
		case "DOG_SUICIDE": return "Только собака может совершить самоубийство.";
		case "EVENT": return "Мероприятие: &&1";
		case "EVENT_INNOCENT_KILLED": return "^2Невинный ^7был убит!";
		case "EVENT_PLAYER_WON": return "&&1 ^7выиграл ^2&&2 ^7время!";
		case "EVENT_TRAITOR_HINT": return "Ты ^1предатель^7!";
		case "EVENT_TRAITOR_KILLED": return "^1Предатель ^7был убит!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Ты король!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Взрывчатка уже заложена!";
		case "EXTRA_LIFE_EARNED": return "Заработанная дополнительная жизнь.";
		case "EXTRA_LIFE_USED": return "Используется дополнительная жизнь!";
		case "GHILLIE_CHANGES": return "Ваша маскировка изменится в следующий раз, когда вы заспавнитесь.";
		case "GUARD_DESC": return "Защитите короля.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "Сервер использует новую систему Хардпоинтов, \n Нажмите ESC и перейдите в меню Хардоинты!";
		case "HARDPOINTS_WILL_CHANGE": return "Ваши Хардпоинты изменяться в следующем раунде.";
		case "HE_APPEARS_AFK": return "^7&&1 похоже находится в AFK!";
		case "HELPER_LEFT": return "^1Помощник ^1покинул нас ^7- выбираю нового!";
		case "HOLD_BREATH": return "Нажмите ^3&&1 ^7чтобы переключиться на тепловое зрение.";
		case "INNOCENTS_ELIMINATED": return "Все невинные были убиты";
		case "INVALID_NAME": return "^1Ваше имя недействительно и было изменено!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Машина вне зоны досягаемости!";
		case "KILLTHEKING": return "Убить короля";
		case "KING_DESC": return "Выжить.";
		case "KING_DIED": return "Король умер.";
		case "KING_LEFT": return "Король вышел из игры.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7сбил короля с ног!";
		case "KING_ON_GROUND": return "Король лежит на земле!";
		case "KING_SURVIVED": return "Король выжил.";
		case "LOGGED_IN": return "^1Успешно вошёл в систему!";
		case "LOGIN_FAILED": return "^1Ошибка входа!";
		case "MAPVOTE_NEXTMAP": return "Следующая карта: &&1";
		case "MORTAR_NOTAVAILABLE": return "Миномёты не доступны.";
		case "NEW_ASS_IS": return "Новый Ассасин: &&1";
		case "NEW_ASSASSIN_IS": return "Новый ассасин &&1";
		case "NEW_DOG_IS": return "Новая собака &&1";
		case "NEW_KING_IS": return "Новый король &&1";
		case "NEW_SLAVE_IS": return "Новый раб &&1";
		case "NO_BADGE": return "У вас нет значка для активации.";
		case "NO_FREE_SLOTS": return "Нет свободных слотов для нового предмета.";
		case "NO_GLITCH": return "^1Не глючите!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Невозможно ^7выбрать нового игрока!";
		case "NO_PERMISSION": return "^1Недостаточно разрешений!";
		case "NO_TRIPS": return "Никаких растяжек не осталось!";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7присоединился к серверу.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "Похоже, вы потеряли свой ранг - восстановление";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7сбил с ног ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 лежит на земле";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1несет в себе смертельный заряд.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Вы не можете заменить свое боковое оружие!";
		case "PRESTIGE_MAX_REACHED": return "Больше никаких уровней престижа нет!";
		case "PRESTIGE_REQUIREMENTS": return "Требования еще не достигнуты!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Сначала вы должны достичь уровень &&1 первым.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Вам требуется &&1 больше XP.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Ошибка записи бэкап файла!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Ваш нынешний престиж ниже - АБОРТ";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Ваш нынешний престиж выше - АБОРТ";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Ваш текущий ранг ниже - АБОРТ";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Ваш текущий ранг выше - АБОРТ";
		case "PROFILE_BACKUP_CREATED": return "Создан бэкап файла - можно использовать следующую карту";
		case "PROFILE_BACKUP_LOADED": return "Бэкап успешно восстановлен!";
		case "PROFILE_BACKUP_LOADING": return "^1Восстановление бэкапа - не покидайте сервер!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1Не найден резервный файл для вашей комбинации guid-name!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "Направление вращения изменилось!";
		case "RANK_HACKED": return "^1Похоже, вы пытались взломать свой ранг!";
		case "RCXD_NOTAVAILABLE": return "RC-XD недоступен.";
		case "REVIVED_BY": return "&&1 возрождён от &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1Никаких флагов не осталось ^3- ^1никакого возрождения, пока вы не захватите флаг";
		case "SELECTION_IMPOSSIBLE": return "Не хватает игроков для отбора.";
		case "SELF_REVIVED": return "&&1 возродился сам.";
		case "SENTRY_GUN_BAD_SPOT": return "Нельзя поставить ^2Турель миниган ^7здесь.";
		case "SPAWNPROTECTION_DISABLED": return "^1Защита спавна отключена.";
		case "SPAWNPROTECTION_ENABLED": return "^2Защита спавна включена.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^2Гвардейцы ^7не допускаются в зону возрождения ^1Ассасинов^7!";
		case "TERMINATOR_IS": return "&&1 Терминатор!";
		case "TRAITORS_ELIMINATED": return "Все предатели ликвидированы";
		case "TRIP_ACTIVE_IN": return "Растяжка активна в &&1 секунде.";
		case "TRIP_BAD_SPOT": return "Вы не можете развернуть растяжку здесь!";
		case "TUTORIAL_1": return "В основном название объясняет тип игры, есть команда ^2Гвардии, ^7которая должна защищать короля.";
		case "TUTORIAL_10": return "Команда ^2Гвардии ^7должна защищать терминалы повсюду на карте.";
		case "TUTORIAL_11": return "^1Ассасины ^7должны загрузить вирус на терминалы, чтобы отключить их.";
		case "TUTORIAL_2": return "Другая команда ^1Ассасинов, ^7должна устранить короля в течение раунда.";
		case "TUTORIAL_3": return "^2Король ^7и ^2охранники ^7получают поддержку ^2Терминатора, ^7который является сильным роботом оснащенным миниганом.";
		case "TUTORIAL_4": return "^2Содержанный код (незаконченный)";
		case "TUTORIAL_5": return "Одна из команд ^2Охранники, ^7должна защищать короля и его чемодан, в котором содержится секретный код.";
		case "TUTORIAL_6": return "Другая команда ^1Ассасинов, ^7должна устранить короля, украсть чемодан и держать его";
		case "TUTORIAL_7": return "на определенное время.";
		case "TUTORIAL_8": return "Когда ^1Ассасины ^7успешно украли код - будет запущена ядерная бомба.";
		case "TUTORIAL_9": return "^2Взлом терминала (незаконченный)";
		case "TUTORIAL_TITLE": return "О тип игры & моде";
		case "UNIFORM_OF_GUARD": return "У тебя есть форма Гвардейца.";
		case "VISION_OFF": return "Visions выключен.";
		case "VISION_ON": return "Visions включён.";
		case "YOU_APPEAR_AFK": return "^1Вы находитесь в AFK!";
		case "YOU_APPEAR_STUCK": return "Похоже, вы застряли.";
		case "YOU_HAVE_THE_WEAPON": return "У тебя уже есть это оружие";
		case "ZIPLINE_BAD_END": return "Плохое положение концевого крючка.";
		case "ZIPLINE_BAD_START": return "Плохое положение стартового крючка.";
		case "ZIPLINE_DESTROIED_USAGE": return "Эта линия молнии была обрезана до того, как вы смогли ее использовать.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Максимальное количество канаты достиг.";
		case "ZIPLINE_PLACED_END": return "Конец крючка помещен.";
		case "ZIPLINE_PLACED_START": return "Пусковой крючок размещен.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Невозможно украсть ящик.";
		case "CP_IS_A_TRAP": return &"Это ловушка.";
		case "CP_PRESS_USE": return &"Удерживайте ^3[{+activate}] ^7чтобы открыть ящик.";
		case "DOG_SNIFF_ENEMY": return &"Нажмите ^3[{+activate}] ^7чтобы нюхать врагов.";
		case "FOLLOWING": return &"Следующий: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD взрывается в: ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 оставляет в: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Хищник взрывается в: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Sentry Gun взрывается в: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Вертолет улетит в: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Нажмите ^3[{+activate}] ^7чтобы выйти.";
		case "KING_IS": return &"^2Король: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Выход: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Лучший Ассасин:";
		case "MAPRECORD_BEST_KD": return &"Лучшее К/Д:";
		case "MAPRECORD_BEST_STREAK": return &"Высшая серия убийств:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Самый быстрый король-убийца:";
		case "MAPRECORD_LONGEST_KING": return &"Самое длинное время короля:";
		case "MAPRECORD_MOST_DEATHS": return &"Большинство смертей:";
		case "MAPRECORD_MOST_KILLS": return &"Большинство убийств:";
		case "MAPRECORD_TITLE": return &"Hall of Fame - Лучшие игроки этой карты (за все время)";
		case "NADE_ON_YOU": return &"На тебе застряла граната!";
		case "NO_KING_YET": return &"^2Короля еще не выбрали.";
		case "NOT_ENOUGH_PLAYERS": return &"Требуется &&1 игрока(ов), чтобы начать игру!";
		case "PICK_ASSASSIN": return &"Выбираем ассасина";
		case "PICK_DOG": return &"Выбираем собаку";
		case "PICK_KING": return &"Выбираем короля";
		case "PICK_SLAVE": return &"Выбираем раб-ассасина";
		case "PICKED_ASSASSIN_IS": return &"Ассасин: &&1";
		case "PICKED_DOG_IS": return &"Собака: &&1";
		case "PICKED_KING_IS": return &"Король: &&1";
		case "PICKED_SLAVE_IS": return &"Раб-ассасин: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Выбор собаки или раб-ассасина";
		case "WEAPONCHANGE_GUNGAME": return &"^7Нажмите ^3[{+activate}] ^7для нового оружия.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Нажмите ^3[{+activate}] ^7чтобы переключить оружие.";
		case "ZIPLINE_USAGE_INFO": return &"Нажмите ^3[{+activate}] ^7/^1[{+melee}] ^7к ^3Используйте ^7/ ^1Уничтожьте ^7спасательный трос.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Нажмите ^3[{+activate}] ^7чтобы повысить скорость.";
		case "REVIVE_INFO_YOUSELF": return &"Держите ^3[{+activate}] ^7оживить себя. (&&1)";
		case "REVIVE_INFO": return &"Держите ^3[{+activate}] ^7чтобы оживить.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Нажмите ^3[{+attack}] ^7чтобы развернуть Sentry.";
		case "TRIP_PLANT": return &"Держите ^3[{+activate}] ^7установить растяжку";
		case "HUD_KING_HEALTH": return &"Король здоровья: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Терминатор здоровья: &&1";
		case "THROWBACKGRENADE": return &"Нажмите ^3[{+activate}] ^7чтобы поднять нож.";
		case "BOX_PRESS_USE": return &"Удерживайте ^3[{+activate}] ^7чтобы получить рандом оружие.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"RUKTK_GUNGAME_STAGE_RU";
		case "GUNGAME_MAXSTAGE": return &"RUKTK_GUNGAME_MAXSTAGE_RU";
		case "MONEY": return &"RUKTK_MONEY_RU";

		default: return "";
	}
}