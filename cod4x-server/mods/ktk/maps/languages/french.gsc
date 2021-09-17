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
		case "AC130_NOTAVAILABLE": return "L’AC130 n’est pas disponible.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: Un admin a exécuté '&&1' sur &&2 ^1via rcon.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP erreur: Impossible de changer la dvar '^3&&1^1'! Raison: ^3Aucune valeur définie - Syntaxe correcte?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: Un admin a changé la dvar '^3&&1^1' à '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP erreur: Événement déjà en cours!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP erreur: &&1 ^1le login n’a pas réussi!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP Erreur: Deux ou plusieurs joueurs ont déjà ce nom.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP Erreur: Aucun joueur ne correspond au nom entré.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP Erreur: Impossible de mettre à jour les rangs durant le prematch.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP erreur: Le prestige du joueur &&1 ^1est supérieur – ANNULATION!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP erreur: Le rang du joueur &&1 ^1correspond au nouveau rang – ANNULATION!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP erreur: Le rang du joueur &&1 ^1est supérieur – ANNULATION!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP erreur: Impossible d'obliger le spawn d’un joueur marqué comme AFK.";
		case "ACP_EVENT_STARTED": return "^1Un admin a commencé: ^3&&1^1 – Redémarrage de la carte au prochain round!";
		case "ACP_EVENT_STOPPED": return "^1Un admin a arrêté l’événement actuel – Redémarrage de la carte au prochain round!";
		case "ACP_PLAYER_MUTED": return "^1Tu es en mode muet!";
		case "ACP_PLAYER_UNMUTED": return "^1Tu n’est plus en mode muet!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 est de retour au combat.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 a été déplacé à l'équipe de &&2.";
		case "ADMIN_MSG": return "^1Message de l'administrateur";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Vous avez été déplacé à l'équipe de &&1.";
		case "AFK_TIMER_DUPLICATED": return "Le timer AFK a été dupliqué !";
		case "ASS_DESC": return "Élimine le Roi.";
		case "ASSASSIN_LEFT": return "L’^1assassin ^7 est ^1parti ^7- Sélection d’un remplaçant!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^7&&1 ^1est désactivé sur cette carte!";
		case "AWARD_JUGGER_NOT_READY": return "Tu ne peux pas utiliser l’équipement de juggernaut actuellement.";
		case "BADGE_OFF": return "Emblème désactivé.";
		case "BADGE_ON": return "Emblème activé.";
		case "BOX_AIRSUPPORT": return "Le support aérien attend les ordres.";
		case "BOX_EXPLOSIVE": return "Tu as reçu des explosifs.";
		case "BOX_FLASH": return "Tu as reçu des grenades flash.";
		case "BOX_JAVELIN_PICKUP": return "Tu as reçu un javelin !";
		case "BOX_KNIVES": return "Tu as reçu des couteaux balistiques.";
		case "BOX_NADES": return "Tu as reçu des grenades.";
		case "BOX_PICK": return "&&1 points nécessaires!";
		case "BOX_POISON": return "Tu as reçu des grenades toxiques.";
		case "BOX_RCXD": return "RC-XD armé et paré.";
		case "BOX_TRIP": return "Tu as reçu un piège.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Aucun hélicoptère disponible pour un larguage.";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Colis stratégique indisponible";
		case "CHARACTER_MENU_NO_SPEC": return "^1Tu dois être spectateur!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1Le développeur ^7a rejoint le serveur.";
		case "DOG_SHIT": return "Ton chien doit poser une pêche!";
		case "DOG_SUICIDE": return "Seulement le chien peut se suicider.";
		case "EVENT": return "Event: &&1";
		case "EVENT_INNOCENT_KILLED": return "Un ^2innocent ^7a été tué !";
		case "EVENT_PLAYER_WON": return "&&1 ^7a gagné pour la ^2&&2 ^7fois!";
		case "EVENT_TRAITOR_HINT": return "Tu es un ^1Traître^7!";
		case "EVENT_TRAITOR_KILLED": return "Un ^1traître ^7a été tué!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Tu es le Roi!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Les explosifs sont déjà installés!";
		case "EXTRA_LIFE_EARNED": return "Vie supplémentaire obtenue.";
		case "EXTRA_LIFE_USED": return "Vie supplémentaire utilisée!";
		case "GHILLIE_CHANGES": return "Votre ghillie va changer la prochaine fois.";
		case "GUARD_DESC": return "Protège le Roi.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "Le serveur utilise le nouveau système de série d’éliminations, \n Appuie sur ESC en rends-toi au menu correspondant!";
		case "HARDPOINTS_WILL_CHANGE": return "Ta série d’éliminations changera au prochain tour.";
		case "HE_APPEARS_AFK": return "^7&&1 est probablement AFK!";
		case "HELPER_LEFT": return "Le ^1sous-fifre ^7est ^1parti ^7-Sélection d’un remplaçant!";
		case "HOLD_BREATH": return "Appuie sur ^3&&1 ^7pour changer en vision thermique.";
		case "INNOCENTS_ELIMINATED": return "Tous les innocents ont été tués";
		case "INVALID_NAME": return "^1Ton nom est invalide et a été changé!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "Véhicule hors de portée!";
		case "KILLTHEKING": return "Élimine le Roi.";
		case "KING_DESC": return "Survit.";
		case "KING_DIED": return "Le Roi est mort.";
		case "KING_LEFT": return "Le Roi a quitté le match.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7a mis le Roi à terre!";
		case "KING_ON_GROUND": return "Le Roi est à terre!";
		case "KING_SURVIVED": return "Le Roi a survécu.";
		case "LOGGED_IN": return "^1Connecté avec succès!";
		case "LOGIN_FAILED": return "^1Connexion échouée!";
		case "MAPVOTE_NEXTMAP": return "Carte suivante: &&1";
		case "MORTAR_NOTAVAILABLE": return "Les mortiers sont indisponibles.";
		case "NEW_ASS_IS": return "Le nouvel Assassin est: &&1";
		case "NEW_ASSASSIN_IS": return "Le nouvel Assassin est &&1";
		case "NEW_DOG_IS": return "Le nouveau Chien est: &&1";
		case "NEW_KING_IS": return "Le nouveau Roi est: &&1";
		case "NEW_SLAVE_IS": return "Le nouvel Esclave est &&1";
		case "NO_BADGE": return "Tu n'as pas de badge à activer.";
		case "NO_FREE_SLOTS": return "Aucune place disponible pour le nouvel objet.";
		case "NO_GLITCH": return "^1Tu ne doit pas GLITCH!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Impossible ^7de sélectionner un nouveau joueur!";
		case "NO_PERMISSION": return "^1Autorisations insuffisantes!";
		case "NO_TRIPS": return "Tu n'as pas plus de piège.";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7a rejoint le serveur.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "On dirait que tu a perdu ton rang – Restauration…";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7a mis à terre ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 est à terre!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1porte un charge explosive.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Tu ne peux pas remplacer ton arme secondaire!";
		case "PRESTIGE_MAX_REACHED": return "Il y n'a plus de prestiges!";
		case "PRESTIGE_REQUIREMENTS": return "Le niveau requis n’as pas encore été atteint!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Tu dois d’abord atteindre le rang &&1.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Tu as besoin de &&1 points d’XP supplémentaire.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Erreur lors de l’écriture de la sauvegarde!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Ton prestige actuel est plus petit – Annulation";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Ton prestige actuel est plus grand – Annulation";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Ton rang actuel est plus petit – Annulation";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Ton rang actuel est plus grand – Annulation";
		case "PROFILE_BACKUP_CREATED": return "Sauvegarde réussie – elle peut être utilisée dès la prochaine carte!";
		case "PROFILE_BACKUP_LOADED": return "Restauration de la sauvegarde réussie!";
		case "PROFILE_BACKUP_LOADING": return "Restauration de la sauvegarde en cours – ne quitte pas le serveur!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1Aucune sauvegarde trouvée avec ton GUID et nom!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "La direction de la rotation a été changée!";
		case "RANK_HACKED": return "^1On dirait que tu as essayé de pirater ton rang!";
		case "RCXD_NOTAVAILABLE": return "RC-XD n'est pas disponible.";
		case "REVIVED_BY": return "&&1 est réanimé par &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1Aucun drapeau restant ^3- ^1Pas de réapparition jusqu’à ce que ton équipe en capture un!";
		case "SELECTION_IMPOSSIBLE": return "Il y a trop peu joueurs pour la sélection.";
		case "SELF_REVIVED": return "&&1 s'est réanimé tout seul.";
		case "SENTRY_GUN_BAD_SPOT": return "Impossible de déployer une ^2Tourelle automatique ^7ici.";
		case "SPAWNPROTECTION_DISABLED": return "^1Protection d’apparition désactivée.";
		case "SPAWNPROTECTION_ENABLED": return "^2Protection d’apparition activée.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^7Les ^6Gardiens ^7ne sont pas autorisés dans l’aire d’apparition des ^1Assassins ^7!";
		case "TERMINATOR_IS": return "&&1 est Terminator!";
		case "TRAITORS_ELIMINATED": return "Tous les traîtres ont été vaincus.";
		case "TRIP_ACTIVE_IN": return "Piège actif dans &&1 secondes.";
		case "TRIP_BAD_SPOT": return "Tu ne peux pas utiliser de piège ici!";
		case "TUTORIAL_1": return "Fondamentalement, tout est dans le titre, il y a une équipe (les ^2Guardiens) ^7qui doit protéger le Roi.";
		case "TUTORIAL_10": return "Les ^2Gardiens ^7doivent protéger tous les terminaux de la carte.";
		case "TUTORIAL_11": return "Les ^1Assassins ^7doivent mettre un virus au terminaux.";
		case "TUTORIAL_2": return "L’autre équipe, les ^1Assassins^7, doivent éliminer le Roi durant le même tour.";
		case "TUTORIAL_3": return "Le ^2Roi ^7et les ^2Guardiens ^7obtiennent un support d’un ^2Terminator ^7qui est un robuste robot, doté d’un minigun.";
		case "TUTORIAL_4": return "^2Contenir le Code (pas finis)";
		case "TUTORIAL_5": return "Une des équipes, les ^2Gardiens^7, doivent protéger le Roi et sa mallette, qui contient un code secret.";
		case "TUTORIAL_6": return "L’autre équipe, les ^1Assassins^7, doivent éliminer le Roi, voler la mallette et la garder";
		case "TUTORIAL_7": return "pour un certaine durée.";
		case "TUTORIAL_8": return "Lorsque les ^1Assassins ^7ont réussi a volé le code secret, une bombe nucléaire est lancée.";
		case "TUTORIAL_9": return "^2Hack les Terminaux (pas finis)";
		case "TUTORIAL_TITLE": return "Informations sur le mode de jeu et le Mod";
		case "UNIFORM_OF_GUARD": return "Tu a obtenu l’uniforme d’un Gardien.";
		case "VISION_OFF": return "Visions désactivées.";
		case "VISION_ON": return "Visions activées.";
		case "YOU_APPEAR_AFK": return "^1Tu sembles être AFK!";
		case "YOU_APPEAR_STUCK": return "Tu sembles être bloqué.";
		case "YOU_HAVE_THE_WEAPON": return "Tu as déjà cette arme";
		case "ZIPLINE_BAD_END": return "Position de fin mauvaise.";
		case "ZIPLINE_BAD_START": return "Position de départ mauvaise.";
		case "ZIPLINE_DESTROIED_USAGE": return "Cette tyrolienne a été coupé avant que tu ne puisses l’utiliser.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Nombre maximum de tyroliennes atteint.";
		case "ZIPLINE_PLACED_END": return "Position de fin placée.";
		case "ZIPLINE_PLACED_START": return "Position de départ placée.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Impossible de voler le colis.";
		case "CP_IS_A_TRAP": return &"C'est un piège.";
		case "CP_PRESS_USE": return &"Appuie sur ^3[{+activate}] pour ouvrir le colis.";
		case "DOG_SNIFF_ENEMY": return &"Appuyez sur ^3[{+activate}]^7 pour mordre les ennemis.";
		case "FOLLOWING": return &"Suivant:";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD explose dans : ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 part dans: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predator explose dans:^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Le fusil de Sentinelle explose dans: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Helicoptère part dans: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Appuie sur ^3[{+activate}] ^7pour partir.";
		case "KING_IS": return &"^2Le Roi est: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Saigner: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Meilleur Assassin:";
		case "MAPRECORD_BEST_KD": return &"Meilleur ratio K/D:";
		case "MAPRECORD_BEST_STREAK": return &"Plus grosse série d’élimination:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"Élimination du Roi la plus rapide:";
		case "MAPRECORD_LONGEST_KING": return &"Temps le plus long en tant que Roi:";
		case "MAPRECORD_MOST_DEATHS": return &"Le plus de morts:";
		case "MAPRECORD_MOST_KILLS": return &"Le plus d’éliminations:";
		case "MAPRECORD_TITLE": return &"Tableau d’honneur – Meilleurs joueurs sur cette carte (tous les temps)";
		case "NADE_ON_YOU": return &"Une grenade est collée sur toi.";
		case "NO_KING_YET": return &"^2Aucun Roi présentement sélectionné.";
		case "NOT_ENOUGH_PLAYERS": return &"Au moins &&1 joueurs nécessaires pour commencer!";
		case "PICK_ASSASSIN": return &"Sélection de l'Assassin";
		case "PICK_DOG": return &"Sélection du Chien";
		case "PICK_KING": return &"Sélection du Roi";
		case "PICK_SLAVE": return &"Sélection de l’Esclave";
		case "PICKED_ASSASSIN_IS": return &"L'Assassin est: &&1";
		case "PICKED_DOG_IS": return &"Le Chien est: &&1";
		case "PICKED_KING_IS": return &"Le Roi est: &&1";
		case "PICKED_SLAVE_IS": return &"L'Esclave est: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Choisissez le Chien de l'Assassin ou l'Esclave.";
		case "WEAPONCHANGE_GUNGAME": return &"Appuie sur ^3[{+activate}] ^7pour la nouvelle arme.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Appuie sur ^3[{+activate}] ^7pour changer d'arme.";
		case "ZIPLINE_USAGE_INFO": return &"Appuyez sur ^3[{+activate}] ^7/ ^1[{+melee}] ^7pour ^3Utiliser^7/^1Détruire^7la corde de secours.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Appuyez sur ^3[{+activate}] ^7pour accélérer. ";
		case "REVIVE_INFO_YOUSELF": return &"Laissez appuyer^3[{+activate}] ^7pour vous revivre. (&&1)";
		case "REVIVE_INFO": return &"Laissez appuyer^3[{+activate}] ^7 pour réanimer. (&&1)";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Appuyezv^3[{+attack}] ^7Pour déployez la sentinelle.";
		case "TRIP_PLANT": return &"Laissez appuyer^3[{+activate}] ^7pour planter un tripwire.";
		case "HUD_KING_HEALTH": return &"Vie du Roi : &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Vie du Terminator: &&1";
		case "THROWBACKGRENADE": return &"Appuie sur ^3[{+activate}] ^7pour prendre le couteau.";
		case "BOX_PRESS_USE": return &"Appuie sur ^3[{+activate}] ^7pour obtenir une arme aléatoire.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_FR";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_FR";
		case "MONEY": return &"KTK_MONEY_FR";
	
		default: return "";
	}
}