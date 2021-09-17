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
		case "AC130_NOTAVAILABLE": return "AC130 no disponible.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: Un admin ha ejecutado '&&1' en &&2 ^1vía rcon.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP error: No se puede cambiar el dvar '^3&&1^1'! Razón: ^3No hay un valor definido - Sintaxis correcta?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: Un admin ha cambiado un dvar '^3&&1^1' to '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP error: Evento ya en ejecución!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP error: &&1 ^1Inicio de sesión fallido!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP Error: Dos o mas jugadores coinciden con el nombre ingresado.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP Error: Ningun jugador con ese nombre.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP Error: Imposible editar los rangos en el periodo prepartida.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP error: El actual prestigio del jugador &&1 ^1es más alto - ABORTANDO!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP error: El actual rango del jugador &&1 ^1es el mismo que el nuevo - ABORTANDO!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP error: El actual rango del jugador &&1 ^1 es más alto - ABORTANDO!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP error: No se puede forzar en reaparecimiento de un jugador que está AFK.";
		case "ACP_EVENT_STARTED": return "^1Un admin ha empezado: ^3&&1^1 - Reiniciando mapa en la siguiente ronda!";
		case "ACP_EVENT_STOPPED": return "^1Un admin ha parado el evento actual - Reiniciando mapa en la siguiente ronda!";
		case "ACP_PLAYER_MUTED": return "^1Estás silenciado!";
		case "ACP_PLAYER_UNMUTED": return "^1Silencio desactivado! ";
		case "ADMIN_HE_IS_BACK": return "^7&&1 está de vuelta en el combate.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 se trasladó a los &&2.";
		case "ADMIN_MSG": return "^1Administrador Mensaje";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Usted se mudó a los &&1.";
		case "AFK_TIMER_DUPLICATED": return "El tiempo lejos del teclado se ha duplicado";
		case "ASS_DESC": return "Eliminar al Rey.";
		case "ASSASSIN_LEFT": return "El ^1asesino ^7 se ha ^1ido ^7- Escogiendo uno nuevo!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^1El ^7&&1 ^1está desactivado en este mapa!";
		case "AWARD_JUGGER_NOT_READY": return "Aún no puedes usar el traje de juggernaut.";
		case "BADGE_OFF": return "Insignia desactivada.";
		case "BADGE_ON": return "Insignia activada.";
		case "BOX_AIRSUPPORT": return "Soporte aéreo a la espera de comandos.";
		case "BOX_EXPLOSIVE": return "Tienes algunos explosivos.";
		case "BOX_FLASH": return "Tienes algunas cegadoras.";
		case "BOX_JAVELIN_PICKUP": return "Tienes una jabalina!";
		case "BOX_KNIVES": return "Tienes algunos cuchillos.";
		case "BOX_NADES": return "Tienes tiene algunas granadas.";
		case "BOX_PICK": return "&&1 puntos requeridos!";
		case "BOX_POISON": return "Tengo algunas granadas venenosas.";
		case "BOX_RCXD": return "RC-XD lleno y listo.";
		case "BOX_TRIP": return "Tengo un cable de tracción.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "No hay helicópteros disponibles para el paquete de ayuda.";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Paquete de ayuda no disponible";
		case "CHARACTER_MENU_NO_SPEC": return "^1Tienes que ser un espectador!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1El desarrollador ^7ha entrado al servidor";
		case "DOG_SHIT": return "¡Tu perro tiene que cagar!";
		case "DOG_SUICIDE": return "Sólo el perro puede suicidarse.";
		case "EVENT": return "Evento: &&1";
		case "EVENT_INNOCENT_KILLED": return "Un ^2Inocente^7fue ejecutado!";
		case "EVENT_PLAYER_WON": return "&&1 ^7 ha ganado por ^2&&2 ^7vez!";
		case "EVENT_TRAITOR_HINT": return "Eres un ^1traidor^7!";
		case "EVENT_TRAITOR_KILLED": return "Un ^1Traidor ^7 fue ejecutado!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Tú eres el rey!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Explosivos ya plantados!";
		case "EXTRA_LIFE_EARNED": return "Vida extra ganada";
		case "EXTRA_LIFE_USED": return "Vida extra usada!";
		case "GHILLIE_CHANGES": return "Su ghillie cambiará la próxima vez que inicie.";
		case "GUARD_DESC": return "Proteger el Rey.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "El servidor usa el nuevo sistema de Hardpoints, \n Presiona ESC y ve al menú de Hardpoints!";
		case "HARDPOINTS_WILL_CHANGE": return "Tus hardpoints cambiarán la siguiente ronda";
		case "HE_APPEARS_AFK": return "^7&&1 parece ser AFK!";
		case "HELPER_LEFT": return "El ^1ayudante ^7se ha ^1ido^7 - Escogiendo uno nuevo!";
		case "HOLD_BREATH": return "Pulse ^3&&1 ^7para cambiar a visión térmica.";
		case "INNOCENTS_ELIMINATED": return "Todos los inocentes fueron ejecutados";
		case "INVALID_NAME": return "^1Tu nombre era inválido y ha sido cambiado!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Vehículo fuera de alcance!";
		case "KILLTHEKING": return "Mata al Rey";
		case "KING_DESC": return "Sobrevivir.";
		case "KING_DIED": return "El Rey ha muerto.";
		case "KING_LEFT": return "El Rey ha dejado.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7ha derribado al rey!";
		case "KING_ON_GROUND": return "El Rey está en el suelo!";
		case "KING_SURVIVED": return "El Rey ha sobrevivido.";
		case "LOGGED_IN": return "^1Correctamente conectado!";
		case "LOGIN_FAILED": return "^1Login fallado!";
		case "MAPVOTE_NEXTMAP": return "Siguiente Mapa: &&1";
		case "MORTAR_NOTAVAILABLE": return "Los morteros no disponible.";
		case "NEW_ASS_IS": return "El nuevo Assassin es: &&1";
		case "NEW_ASSASSIN_IS": return "El nuevo asesino es &&1";
		case "NEW_DOG_IS": return "El nuevo perro es &&1";
		case "NEW_KING_IS": return "El nuevo Rey es &&1";
		case "NEW_SLAVE_IS": return "El nuevo esclavo es &&1";
		case "NO_BADGE": return "Usted no tiene ninguna Insignia para activar.";
		case "NO_FREE_SLOTS": return "No hay espacio para el nuevo item.";
		case "NO_GLITCH": return "^1No falla!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Incapaz ^1de elegir un nuevo jugador/a!";
		case "NO_PERMISSION": return "^1Permisos Insuficientes!";
		case "NO_TRIPS": return "No hay cables de tensión a la izquierda!";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7 ha entrado al servidor.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "Parece que has perdido tu rango - Restaurando";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7ha derribado a ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 está en el suelo!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1lleva una carga mortal.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "¡No puedes reemplazar tu arma de brazo lateral!";
		case "PRESTIGE_MAX_REACHED": return "No hay niveles de prestigio más!";
		case "PRESTIGE_REQUIREMENTS": return "Los requisitos no alcanzó todavía!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Tienes que alcanzar el rango &&1 primero.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Necesitas &&1 más de XP.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Error escribiendo el archivo de copia de seguridad!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Tu prestigio actual es más bajo - Abortando!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Tu prestigio actual es más alto - Abortando! ";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Tu rango actual es más bajo - Abortando! ";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Tu rango actual es más alto - Abortando! ";
		case "PROFILE_BACKUP_CREATED": return "Archivo de copia de seguridad creado - usable en el siguiente mapa!";
		case "PROFILE_BACKUP_LOADED": return "Archivo de copia de seguridad restaurado!";
		case "PROFILE_BACKUP_LOADING": return "^1Restaurando copia de seguridad - no te vayas del servidor!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1No se ha encontrado ninguna copia de seguridad con la combinación de tu guid-nombre!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "Dirección de rotación cambiada!";
		case "RANK_HACKED": return "^1Parece que trató de hackear tu rango!";
		case "RCXD_NOTAVAILABLE": return "RC-XD no disponible.";
		case "REVIVED_BY": return "&&1 he revivido por &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1No quedan banderas ^3- ^1no reaparecereis hasta que obtengáis una bandera!";
		case "SELECTION_IMPOSSIBLE": return "No hay suficientes jugadores para la selección.";
		case "SELF_REVIVED": return "&&1 se ha restablecido.";
		case "SENTRY_GUN_BAD_SPOT": return "No puedes colocar un ^2Centinela ^7aquí.";
		case "SPAWNPROTECTION_DISABLED": return "^1Protección de Spawn desactivar.";
		case "SPAWNPROTECTION_ENABLED": return "^2Spawn Protección activada.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "Los ^2Guardianes^7no tienen permitido estar en el área de reaparición de los ^1Asesinos^7!";
		case "TERMINATOR_IS": return "&&1 es Terminator!";
		case "TRAITORS_ELIMINATED": return "Todos los traidores eliminados";
		case "TRIP_ACTIVE_IN": return "Cable trampa activado en &&1 segundos.";
		case "TRIP_BAD_SPOT": return "No se puede implementar un cable trampa aquí!";
		case "TUTORIAL_1": return "Básicamente, el nombre se explica el tipo de juego, hay un equipo, los ^2guardias, ^7que tiene que proteger al rey.";
		case "TUTORIAL_10": return "Un equipo, los ^2Guardias^7, tiene que proteger a los terminales en cualquier parte del mapa.";
		case "TUTORIAL_11": return "Los ^1Asesinos ^7tienen que cargar un virus en los terminales para cerrarlas.";
		case "TUTORIAL_2": return "El otro equipo, el ^1Asesinos^7, tiene que eliminar el rey dentro de la ronda.";
		case "TUTORIAL_3": return "El ^2Rey ^7y la ^2Guardia ^7se apoya por un ^2Terminator ^7que es un robot, fuerte equipado con una ametralladora.";
		case "TUTORIAL_4": return "^2Contienen el código (sin terminar)";
		case "TUTORIAL_5": return "Uno de los equipos, la ^2Guardia^7, tienes que proteger al rey y su maleta, que contiene un código secreto.";
		case "TUTORIAL_6": return "El otro equipo, el del ^1Asesino^7, tiene que eliminar al rey, para robar la maleta y mantenerlo";
		case "TUTORIAL_7": return "ara una cierta cantidad de tiempo.";
		case "TUTORIAL_8": return "Cuando el ^1Asesino ^7con éxito robado el código, una bomba nuclear se puso en marcha.";
		case "TUTORIAL_9": return "^2Hackear los Terminales (sin terminar)";
		case "TUTORIAL_TITLE": return "Acerca de los tipos de juego y la Mod";
		case "UNIFORM_OF_GUARD": return "Tienes un uniforme de guardián.";
		case "VISION_OFF": return "Visiones desactivada.";
		case "VISION_ON": return "Visiones habilitado.";
		case "YOU_APPEAR_AFK": return "^1Parece que estás AFK!";
		case "YOU_APPEAR_STUCK": return "Usted parece estar atascado.";
		case "YOU_HAVE_THE_WEAPON": return "Ya tienes este arma";
		case "ZIPLINE_BAD_END": return "Mala posición del gancho final.";
		case "ZIPLINE_BAD_START": return "Mala posición del gancho de inicio.";
		case "ZIPLINE_DESTROIED_USAGE": return "Esta tirolina fue cortada antes de que las hayas podido usar.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Máxima cantidad de tirolinas alcanzada.";
		case "ZIPLINE_PLACED_END": return "Gancho final colocado.";
		case "ZIPLINE_PLACED_START": return "Gancho inicial colocado.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"No se puede robar la caja.";
		case "CP_IS_A_TRAP": return &"Es una trampa.";
		case "CP_PRESS_USE": return &"Pulse ^3[{+activate}] ^7para abrir la caja.";
		case "DOG_SNIFF_ENEMY": return &"Presiona ^3[{+activate}] ^7para olfatear a los enemigos.";
		case "FOLLOWING": return &"Siguientes: ";
		case "HARDPOINT_TIMER_RCXD": return &"El RC-XD explota en: ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"El AC130 se va en: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"El Predator explota en: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"El Centinela explota en: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"El Helicóptero se va en: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Pulse ^3[{+activate}] ^7para dejar.";
		case "KING_IS": return &"^2El rey es: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Sangrando: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Mejor Asesino:";
		case "MAPRECORD_BEST_KD": return &"Mejor B/M:";
		case "MAPRECORD_BEST_STREAK": return &"Racha de bajas más alta:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Ejecutante del rey más rápido:";
		case "MAPRECORD_LONGEST_KING": return &"Tiempo como rey más largo:";
		case "MAPRECORD_MOST_DEATHS": return &"Más muertes:";
		case "MAPRECORD_MOST_KILLS": return &"Más bajas:";
		case "MAPRECORD_TITLE": return &"Muro de la fama - Mejores jugadores en este mapa (todos los tiempos)";
		case "NADE_ON_YOU": return &"Una granada se ha quedado atascado en usted!";
		case "NO_KING_YET": return &"^2Ningún Rey se ha seleccionado aún.";
		case "NOT_ENOUGH_PLAYERS": return &"Por lo menos &&1 jugadores necesitan para empezar!";
		case "PICK_ASSASSIN": return &"La elección del Asesino";
		case "PICK_DOG": return &"La elección del Perro";
		case "PICK_KING": return &"La elección del Rey";
		case "PICK_SLAVE": return &"Escoger el esclavo del asesino";
		case "PICKED_ASSASSIN_IS": return &"El Asesino es: &&1";
		case "PICKED_DOG_IS": return &"El Perro es: &&1";
		case "PICKED_KING_IS": return &"El Rey es: &&1";
		case "PICKED_SLAVE_IS": return &"El esclavo es: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Escogiendo Asesino, perro o esclavo";
		case "WEAPONCHANGE_GUNGAME": return &"Pulse ^3[{+activate}] ^7para la nueva arma.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Presione ^3[{+activate}] ^7para cambiar el arma.";
		case "ZIPLINE_USAGE_INFO": return &"Presiona ^3[{+activate}] ^7/ ^1[{+melee}] ^7para ^3Usar^7/^1Destruir ^7la cuerda de escape.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Presiona ^3[{+activate}] ^7 para acelerar.";
		case "REVIVE_INFO_YOUSELF": return &"Mantén ^3[{+activate}] ^7para revivirte";
		case "REVIVE_INFO": return &"Mantén ^3[{+activate}] ^7 para revivir.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Presiona ^3[{+attack}] para colocar el centinela";
		case "TRIP_PLANT": return &"Mantén ^3[{+activate}] ^7 para plantar un cable trampa.";
		case "HUD_KING_HEALTH": return &"Vida del Rey: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Vida del Terminator: &&1";
		case "THROWBACKGRENADE": return &"Pulse ^3[{+activate}] ^7para recoger el cuchillo.";
		case "BOX_PRESS_USE": return &"Mantenga ^3[{+activate}] ^7para obtener un arma al azar.";

		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_ESP";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_ESP";
		case "MONEY": return &"KTK_MONEY_ESP";

		default: return "";
	}
}