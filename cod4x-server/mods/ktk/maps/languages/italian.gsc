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
		case "AC130_NOTAVAILABLE": return "AC130 non disponibile.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: Un admin ha eseguito '&&1' su &&2 ^1tramite rcon. ";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP Errore: Impossibile cambiare dvar ^3&&1^1'! Motivo: ^3Nessun valore definito - Sintassi corretta? ";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: Un admin ha cambiato dvar '^3&&1^1' a '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP Errore: L'evento è già iniziato! ";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP Errore: &&1 ^1login fallito! ";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP Errore: 2 o più giocatori hanno lo stesso nome.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP Errore: Nessun giocatore corrisponde al nome inserito.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP Errore: Impossibile aggiornare i gradi nel riscaldamento pre-partita.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP Errore: L'attuale prestigio del giocatore &&1 ^1è più alto - ABBANDONO!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP Errore: L'attuale grado del giocatore &&1 ^1corrisponde al nuovo - ABBANDONO!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP Errore: L'attuale grado del giocatore &&1 ^1è più alto - ABBANDONO! ";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP Errore: Impossibile spawnare un giocatore che al momento è AFK. ";
		case "ACP_EVENT_STARTED": return "^1Un admin ha eseguito: ^3&&1^1 - La mappa ricomincerà il prossimo round! ";
		case "ACP_EVENT_STOPPED": return "^1Un admin ha interrotto l'attuale evento - La mappa ricomincerà il prossimo round!";
		case "ACP_PLAYER_MUTED": return "^1Sei silenziato!";
		case "ACP_PLAYER_UNMUTED": return "^1Non sei più silenziato!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 è tornato a combattere.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 è stato spostato a &&2.";
		case "ADMIN_MSG": return "^1Messaggio dall'Amministratore";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Sei stato spostato a &&1.";
		case "AFK_TIMER_DUPLICATED": return "Timer AFK duplicato!";
		case "ASS_DESC": return "Elimina il Re.";
		case "ASSASSIN_LEFT": return "L'^1assassino ^7 ha ^1abbandonato ^7 - Scegliendo il nuovo assassino!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^1Il ^7&&1 ^1é stato disabilitato in questa mappa! ";
		case "AWARD_JUGGER_NOT_READY": return "Non puoi ancora usare il completo del juggernaut.";
		case "BADGE_OFF": return "Badge disattivato.";
		case "BADGE_ON": return "Badge attivato.";
		case "BOX_AIRSUPPORT": return "Supporto aereo in attesa di comandi.";
		case "BOX_EXPLOSIVE": return "Hai ottenuto degli esplosivi.";
		case "BOX_FLASH": return "Hai ottenuto delle granate flash.";
		case "BOX_JAVELIN_PICKUP": return "Hai ottenuto un giavellotto!";
		case "BOX_KNIVES": return "Hai ottenuto dei coltelli.";
		case "BOX_NADES": return "Hai ottenuto delle granate.";
		case "BOX_PICK": return "&&1 punti richiesti!";
		case "BOX_POISON": return "Hai ottenuto delle granate velenose.";
		case "BOX_RCXD": return "RC-XD carica e pronta.";
		case "BOX_TRIP": return "Hai ottenuto una trappola esplosiva.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Nessun Elicottero disponibile per il pacco di assistenza.";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Pacco di assistenza non disponibile. ";
		case "CHARACTER_MENU_NO_SPEC": return "^1Devi stare in modalità spettatore.";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1Lo Sviluppatore ^7è entrato nel server.";
		case "DOG_SHIT": return "Il tuo cane deve andare a cagare!";
		case "DOG_SUICIDE": return "Solo il cane può suicidarsi.";
		case "EVENT": return "Evento: &&1";
		case "EVENT_INNOCENT_KILLED": return "Un ^2innocente ^7è stato ucciso!";
		case "EVENT_PLAYER_WON": return "&&1 ^7ha vinto per la ^2&&2 ^7volta!";
		case "EVENT_TRAITOR_HINT": return "Sei un ^1Traditore^7!";
		case "EVENT_TRAITOR_KILLED": return "Un ^1traditore ^7 è stato ucciso";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Tu sei il re!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Gli esplosivi sono stati già piantati!";
		case "EXTRA_LIFE_EARNED": return "Hai guadagnato una vita extra.";
		case "EXTRA_LIFE_USED": return "Hai usato una vita extra!";
		case "GHILLIE_CHANGES": return "La tua mimetica cambierà la prossima volta che resusciterai.";
		case "GUARD_DESC": return "Proteggi il Re.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "Il server usa il nuovo sistema degli Hardpoints, \n premi ESC e vai al menu Hardpoints!";
		case "HARDPOINTS_WILL_CHANGE": return "I tuoi Hardpoints cambieranno il round seguente.";
		case "HE_APPEARS_AFK": return "^7&&1 sembra essere AFK!";
		case "HELPER_LEFT": return "L' ^1aiutante ^7 se ne è ^1andato ^7- Scegliendone uno nuovo!";
		case "HOLD_BREATH": return "Premi ^3&&1 ^7per passare alla visuale termica.";
		case "INNOCENTS_ELIMINATED": return "Tutti gli innocenti sono stati uccisi";
		case "INVALID_NAME": return "^1Il tuo nome non è valido ed è stato cambiato!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Il veicolo è fuori dalla portata!";
		case "KILLTHEKING": return "Uccidi il Re";
		case "KING_DESC": return "Sopravvivi.";
		case "KING_DIED": return "Il Re è morto.";
		case "KING_LEFT": return "Il Re ha abbandonato la partita.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7 ha ucciso il Re!";
		case "KING_ON_GROUND": return "Il Re è a terra!";
		case "KING_SURVIVED": return "Il Re è sopravvissuto.";
		case "LOGGED_IN": return "^1Loggato con successo!";
		case "LOGIN_FAILED": return "^1Login fallito!";
		case "MAPVOTE_NEXTMAP": return "Prossima Mappa: &&1";
		case "MORTAR_NOTAVAILABLE": return "Mortai non disponibili.";
		case "NEW_ASS_IS": return "Il nuovo Assassino è: &&1";
		case "NEW_ASSASSIN_IS": return "Il nuovo assassino è &&1";
		case "NEW_DOG_IS": return "Il nuovo cane è &&1";
		case "NEW_KING_IS": return "Il nuovo Re è &&1";
		case "NEW_SLAVE_IS": return "Il nuovo schiavo è &&1";
		case "NO_BADGE": return "Non hai nessun Badge da attivare.";
		case "NO_FREE_SLOTS": return "Non ci sono slot liberi per il nuovo oggetto.";
		case "NO_GLITCH": return "^1Non glitchare!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Impossibile ^7scegliere un nuovo giocatore!";
		case "NO_PERMISSION": return "^1Permessi Insufficienti.";
		case "NO_TRIPS": return "Nessuna trappola esplosiva rimasta!";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7 si è unito al server.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "Sembra che tu abbia perso il tuo livello - Ripristino";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7ha abbattuto ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 è a terra!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1trasporta una carica mortale.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Non puoi cambiare la tua arma da taglio!";
		case "PRESTIGE_MAX_REACHED": return "Non ci sono più livelli prestigio!";
		case "PRESTIGE_REQUIREMENTS": return "Requisiti ancora non raggiunti!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Devi raggiungere il grado &&1 prima.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Hai bisogno di ancora &&1 XP.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Errore nello scrivere il file di backup!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Il tuo attuale prestigio è più basso - Abbandono";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Il tuo attuale prestigio è più alto - Abbandono";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Il tuo attuale livello è più basso - Abbandono";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Il tuo attuale livello è più alto - Abbandono";
		case "PROFILE_BACKUP_CREATED": return "File di backup creato - utilizzabile dalla prossima mappa!";
		case "PROFILE_BACKUP_LOADED": return "Backup ripristinato con successo!";
		case "PROFILE_BACKUP_LOADING": return "^1Ripristinando il backup - non uscire dal server!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1Nessun backup file trovato per la tua combinazione guid-nome!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "Direzione della rotazione cambiata!";
		case "RANK_HACKED": return "^1Sembra che tu abbia provato ad hackerare il tuo livello!";
		case "RCXD_NOTAVAILABLE": return "RC-XD non disponibile.";
		case "REVIVED_BY": return "&&1 è stato salvato da &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1Nessuna bandiera disponibile ^3- ^1non puoi resuscitare finchè non prendi una bandiera!";
		case "SELECTION_IMPOSSIBLE": return "Non ci sono abbastanza giocatori per la scelta.";
		case "SELF_REVIVED": return "&&1 si è curato da solo.";
		case "SENTRY_GUN_BAD_SPOT": return "Non puoi piazzare una ^2Sentry Gun ^7qui.";
		case "SPAWNPROTECTION_DISABLED": return "^1Protezione spawn disabilitata.";
		case "SPAWNPROTECTION_ENABLED": return "^2Protezione spawn attivata.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "I ^2Guardiani ^7 non possono entrare nella zona spawn degli ^1Assassini^7!";
		case "TERMINATOR_IS": return "&&1 è il Terminator!";
		case "TRAITORS_ELIMINATED": return "Tutti i traditori sono stati eliminati";
		case "TRIP_ACTIVE_IN": return "Trappola esplosiva attiva in &&1 secondi.";
		case "TRIP_BAD_SPOT": return "Non puoi piazzare la trappola esplosiva qui!";
		case "TUTORIAL_1": return "Praticamente il nome spiega come si gioca, c'è una squadra, le ^2Guardie, ^che hanno il compito di proteggere il Re.";
		case "TUTORIAL_10": return "Una squadra, le ^2Guardie^7, devono proteggere i terminali di tutta la mappa.";
		case "TUTORIAL_11": return "Gli ^1Assassini ^7devono posizionare ai terminali dei virus per metterli fuori uso.";
		case "TUTORIAL_2": return "L'altra squadra, gli ^1Assassini^7, devono eliminare il Re entro la fine del round, che termina prima se il Re muore.";
		case "TUTORIAL_3": return "Il ^2Re ^7e le ^2Guardie ^7sono aiutati da un ^2Terminator ^7che è un robot cazzuto, equipaggiato con una minigun.";
		case "TUTORIAL_4": return "^2Contiene il Codice (non finito)";
		case "TUTORIAL_5": return "Una delle squadre, le ^2Guardie^7, deve proteggere il Re e la sua valigetta, che contiene un codice segreto.";
		case "TUTORIAL_6": return "L'altra squadra, gli ^1Assassini^7, devono eliminare il Re, e rubare la valigetta e tenerla con loro";
		case "TUTORIAL_7": return "per un certo periodo di tempo.";
		case "TUTORIAL_8": return "Quando gli ^1Assassini ^7ruberanno il codice, una bomba atomica verrà lanciata.";
		case "TUTORIAL_9": return "^2Hackera i Terminali (non finita)";
		case "TUTORIAL_TITLE": return "Informazioni sul tipo di gioco & sulla Mod";
		case "UNIFORM_OF_GUARD": return "Hai guadagnato un'uniforme da guardiano.";
		case "VISION_OFF": return "Visuale disattivata.";
		case "VISION_ON": return "Visuale abilitata.";
		case "YOU_APPEAR_AFK": return "^1Sembra che tu sia AFK!";
		case "YOU_APPEAR_STUCK": return "Sembra che tu sia bloccato.";
		case "YOU_HAVE_THE_WEAPON": return "Hai già quest'arma";
		case "ZIPLINE_BAD_END": return "Posizione finale del gancio negativa.";
		case "ZIPLINE_BAD_START": return "Posizione iniziale del gancio negativa.";
		case "ZIPLINE_DESTROIED_USAGE": return "Questo cavo è stato tagliato prima che tu potessi usarlo.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Quantità massima di cavo raggiunto.";
		case "ZIPLINE_PLACED_END": return "Fine del gancio piazzata.";
		case "ZIPLINE_PLACED_START": return "Inizio del gancio piazzato.";
			
		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Impossibilitato a rubare la cassa.";
		case "CP_IS_A_TRAP": return &"E' una trappola.";
		case "CP_PRESS_USE": return &"Tieni premuto ^3[{+activate}] ^7 per aprire la cassa.";
		case "DOG_SNIFF_ENEMY": return &"Premi ^3[{+activate}] ^7per fiutare i nemici.";
		case "FOLLOWING": return &"Seguente: ";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD esploderà in: ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 andrà via in: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predatore esploderà in: ^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Sentry Gun esploderà in: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"L'elicottero andrà via in: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Premi ^3[{+activate}] ^7per lasciare.";
		case "KING_IS": return &"^2Il Re è: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Sanguinamento: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Miglior Assassino:";
		case "MAPRECORD_BEST_KD": return &"Miglior K/D:";
		case "MAPRECORD_BEST_STREAK": return &"Numero più altro di uccisioni consecutive:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Uccisore del Re più veloce:";
		case "MAPRECORD_LONGEST_KING": return &"Tempo come Re più lungo:";
		case "MAPRECORD_MOST_DEATHS": return &"Più morti:";
		case "MAPRECORD_MOST_KILLS": return &"Più uccisioni:";
		case "MAPRECORD_TITLE": return &"Hall of fame - Miglior giocatori di questa mappa (tutti i tempi)";
		case "NADE_ON_YOU": return &"Hai una granata attaccata addosso!";
		case "NO_KING_YET": return &"^2Nessun Re ancora scelto.";
		case "NOT_ENOUGH_PLAYERS": return &"Servono almeno &&1 giocatori per cominciare!";
		case "PICK_ASSASSIN": return &"Scelta dell'Assassino";
		case "PICK_DOG": return &"Scelta del cane";
		case "PICK_KING": return &"Scelta del Re";
		case "PICK_SLAVE": return &"Scelta dello schiavo dell'Assassino";
		case "PICKED_ASSASSIN_IS": return &"L'Assassino è: &&1";
		case "PICKED_DOG_IS": return &"Il Cane è: &&1";
		case "PICKED_KING_IS": return &"Il Re è: &&1";
		case "PICKED_SLAVE_IS": return &"Lo Schiavo è: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Scelta del Cane o dello Schiavo dell'Assassino";
		case "WEAPONCHANGE_GUNGAME": return &"Premi ^3[{+activate}] ^7per una nuova arma.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Premi ^3[{+activate}] ^7per cambiare arma.";
		case "ZIPLINE_USAGE_INFO": return &"Premi ^3[{+activate}] ^7/ ^1[{+melee}] ^7per ^3Usare^7/^1Distruggere ^7la corda per scappare.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Premi ^3[{+activate}] ^7per aumentare la velocità.";
		case "REVIVE_INFO_YOUSELF": return &"Tieni premuto ^3[{+activate}] ^7per resuscitare te stesso. (&&1)";
		case "REVIVE_INFO": return &"Tieni premuto ^3[{+activate}] ^7per resuscitare.";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Premi ^3[{+attack}] ^7per piazzare una Sentry.";
		case "TRIP_PLANT": return &"Tieni premuto ^3[{+activate}] ^7per piazzare una trappola esplosiva.";
		case "HUD_KING_HEALTH": return &"Salute del Re: &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Salute del Terminator: &&1";
		case "THROWBACKGRENADE": return &"Premi ^3[{+activate}] ^7per raccogliere il pugnale.";
		case "BOX_PRESS_USE": return &"Premi ^3[{+activate}] ^7per ottenere un'arma a caso.";

		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_IT";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_IT";
		case "MONEY": return &"KTK_MONEY_IT";

		default: return "";
	}
}