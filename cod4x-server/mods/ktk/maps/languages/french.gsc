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
		case "AC130_NOTAVAILABLE": return "L�AC130 n�est pas disponible.";
		case "ACP_COMMAND_EXECUTED_RCON": return "^1ACP: Un admin a ex�cut� '&&1' sur &&2 ^1via rcon.";
		case "ACP_ERROR_DVAR_NO_VALUE": return "^1ACP erreur: Impossible de changer la dvar '^3&&1^1'! Raison: ^3Aucune valeur d�finie - Syntaxe correcte?";
		case "ACP_ERROR_DVAR_VALUE_CHANGED": return "^1ACP: Un admin a chang� la dvar '^3&&1^1' � '^3&&2^1'.";
		case "ACP_ERROR_EVENT_IN_PROGRESS": return "^1ACP erreur: �v�nement d�j� en cours!";
		case "ACP_ERROR_FAILED_LOGIN": return "^1ACP erreur: &&1 ^1le login n�a pas r�ussi!";
		case "ACP_ERROR_MANY_PLAYERS_FOUND": return "^1ACP Erreur: Deux ou plusieurs joueurs ont d�j� ce nom.";
		case "ACP_ERROR_NO_PLAYER_FOUND": return "^1ACP Erreur: Aucun joueur ne correspond au nom entr�.";
		case "ACP_ERROR_NO_RANKUPDATE": return "^1ACP Erreur: Impossible de mettre � jour les rangs durant le prematch.";
		case "ACP_ERROR_NO_RESTORE_PRESTIGE_HIGHER": return "^1ACP erreur: Le prestige du joueur &&1 ^1est sup�rieur � ANNULATION!";
		case "ACP_ERROR_NO_RESTORE_RANK_EQUAL": return "^1ACP erreur: Le rang du joueur &&1 ^1correspond au nouveau rang � ANNULATION!";
		case "ACP_ERROR_NO_RESTORE_RANK_HIGHER": return "^1ACP erreur: Le rang du joueur &&1 ^1est sup�rieur � ANNULATION!";
		case "ACP_ERROR_NO_SPAWN": return "^1ACP erreur: Impossible d'obliger le spawn d�un joueur marqu� comme AFK.";
		case "ACP_EVENT_STARTED": return "^1Un admin a commenc�: ^3&&1^1 � Red�marrage de la carte au prochain round!";
		case "ACP_EVENT_STOPPED": return "^1Un admin a arr�t� l��v�nement actuel � Red�marrage de la carte au prochain round!";
		case "ACP_PLAYER_MUTED": return "^1Tu es en mode muet!";
		case "ACP_PLAYER_UNMUTED": return "^1Tu n�est plus en mode muet!";
		case "ADMIN_HE_IS_BACK": return "^7&&1 est de retour au combat.";
		case "ADMIN_HE_WAS_SWITCHED": return "^7&&1 a �t� d�plac� � l'�quipe de &&2.";
		case "ADMIN_MSG": return "^1Message de l'administrateur";
		case "ADMIN_YOU_WERE_SWITCHED": return "^1Vous avez �t� d�plac� � l'�quipe de &&1.";
		case "AFK_TIMER_DUPLICATED": return "Le timer AFK a �t� dupliqu� !";
		case "ASS_DESC": return "�limine le Roi.";
		case "ASSASSIN_LEFT": return "L�^1assassin ^7 est ^1parti ^7- S�lection d�un rempla�ant!";
		case "AWARD_DISABLED_ON_THIS_MAP": return "^7&&1 ^1est d�sactiv� sur cette carte!";
		case "AWARD_JUGGER_NOT_READY": return "Tu ne peux pas utiliser l��quipement de juggernaut actuellement.";
		case "BADGE_OFF": return "Embl�me d�sactiv�.";
		case "BADGE_ON": return "Embl�me activ�.";
		case "BOX_AIRSUPPORT": return "Le support a�rien attend les ordres.";
		case "BOX_EXPLOSIVE": return "Tu as re�u des explosifs.";
		case "BOX_FLASH": return "Tu as re�u des grenades flash.";
		case "BOX_JAVELIN_PICKUP": return "Tu as re�u un javelin !";
		case "BOX_KNIVES": return "Tu as re�u des couteaux balistiques.";
		case "BOX_NADES": return "Tu as re�u des grenades.";
		case "BOX_PICK": return "&&1 points n�cessaires!";
		case "BOX_POISON": return "Tu as re�u des grenades toxiques.";
		case "BOX_RCXD": return "RC-XD arm� et par�.";
		case "BOX_TRIP": return "Tu as re�u un pi�ge.";
		case "CAREPACKAGE_NO_HELI_AVAILABLE": return "Aucun h�licopt�re disponible pour un larguage.";
		case "CAREPACKAGE_NOT_AVAILABLE": return "Colis strat�gique indisponible";
		case "CHARACTER_MENU_NO_SPEC": return "^1Tu dois �tre spectateur!";
		case "DEVELOPER_CONNECTED_TO_SERVER": return "^1Le d�veloppeur ^7a rejoint le serveur.";
		case "DOG_SHIT": return "Ton chien doit poser une p�che!";
		case "DOG_SUICIDE": return "Seulement le chien peut se suicider.";
		case "EVENT": return "Event: &&1";
		case "EVENT_INNOCENT_KILLED": return "Un ^2innocent ^7a �t� tu�!";
		case "EVENT_PLAYER_WON": return "&&1 ^7a gagn� pour la ^2&&2 ^7fois!";
		case "EVENT_TRAITOR_HINT": return "Tu es un ^1Tra�tre^7!";
		case "EVENT_TRAITOR_KILLED": return "Un ^1tra�tre ^7a �t� tu�!";
		case "EVENT_UNKNOWN_KING_HINT": return "^1Tu es le Roi!";
		case "EXPLOSIVES_ALREADY_PLANTED": return "Les explosifs sont d�j� install�s!";
		case "EXTRA_LIFE_EARNED": return "Vie suppl�mentaire obtenue.";
		case "EXTRA_LIFE_USED": return "Vie suppl�mentaire utilis�e!";
		case "GHILLIE_CHANGES": return "Votre ghillie va changer la prochaine fois.";
		case "GUARD_DESC": return "Prot�ge le Roi.";
		case "HARDPOINT_SYSTEM_NEW_INFO": return "Le serveur utilise le nouveau syst�me de s�rie d��liminations, \n Appuie sur ESC en rends-toi au menu correspondant!";
		case "HARDPOINTS_WILL_CHANGE": return "Ta s�rie d��liminations changera au prochain tour.";
		case "HE_APPEARS_AFK": return "^7&&1 est probablement AFK!";
		case "HELPER_LEFT": return "Le ^1sous-fifre ^7est ^1parti ^7-S�lection d�un rempla�ant!";
		case "HOLD_BREATH": return "Appuie sur ^3&&1 ^7pour changer en vision thermique.";
		case "INNOCENTS_ELIMINATED": return "Tous les innocents ont �t� tu�s";
		case "INVALID_NAME": return "^1Ton nom est invalide et a �t� chang�!";
		case "JAVELIN_VEHICLE_OUT_OF_RANGE": return "V�hicule hors de port�e!";
		case "KILLTHEKING": return "�limine le Roi.";
		case "KING_DESC": return "Survit.";
		case "KING_DIED": return "Le Roi est mort.";
		case "KING_LEFT": return "Le Roi a quitt� le match.";
		case "KING_ON_GROUND_ATTACKER": return "^1&&1 ^7a mis le Roi � terre!";
		case "KING_ON_GROUND": return "Le Roi est � terre!";
		case "KING_SURVIVED": return "Le Roi a surv�cu.";
		case "LOGGED_IN": return "^1Connect� avec succ�s!";
		case "LOGIN_FAILED": return "^1Connexion �chou�e!";
		case "MAPVOTE_NEXTMAP": return "Carte suivante: &&1";
		case "MORTAR_NOTAVAILABLE": return "Les mortiers sont indisponibles.";
		case "NEW_ASS_IS": return "Le nouvel Assassin est: &&1";
		case "NEW_ASSASSIN_IS": return "Le nouvel Assassin est &&1";
		case "NEW_DOG_IS": return "Le nouveau Chien est: &&1";
		case "NEW_KING_IS": return "Le nouveau Roi est: &&1";
		case "NEW_SLAVE_IS": return "Le nouvel Esclave est &&1";
		case "NO_BADGE": return "Tu n'as pas de badge � activer.";
		case "NO_FREE_SLOTS": return "Aucune place disponible pour le nouvel objet.";
		case "NO_GLITCH": return "^1Tu ne doit pas GLITCH!";
		case "NO_NEW_SELECTION_POSSIBLE": return "^1Impossible ^7de s�lectionner un nouveau joueur!";
		case "NO_PERMISSION": return "^1Autorisations insuffisantes!";
		case "NO_TRIPS": return "Tu n'as pas plus de pi�ge.";
		case "PLAYER_CONNECTED_TO_SERVER": return "^1&&1 ^7a rejoint le serveur.";
		case "PLAYER_LOST_RANK_AUTORESTORE": return "On dirait que tu a perdu ton rang � Restauration�";
		case "PLAYER_ON_GROUND_ATTACKER": return "^1&&1 ^7a mis � terre ^1&&2^7!";
		case "PLAYER_ON_GROUND": return "&&1 est � terre!";
		case "PLAYER_SEMTEX_STUCK": return "^1&&1 ^1porte un charge explosive.";
		case "PLAYER_SIDEARM_NO_REPLACE": return "Tu ne peux pas remplacer ton arme secondaire!";
		case "PRESTIGE_MAX_REACHED": return "Il y n'a plus de prestiges!";
		case "PRESTIGE_REQUIREMENTS": return "Le niveau requis n�as pas encore �t� atteint!";
		case "PRESTIGE_REQUIREMENTS_RANK": return "Tu dois d�abord atteindre le rang &&1.";
		case "PRESTIGE_REQUIREMENTS_XP": return "Tu as besoin de &&1 points d�XP suppl�mentaire.";
		case "PROFILE_BACKUP_ABORT_FILE": return "^1Erreur lors de l��criture de la sauvegarde!";
		case "PROFILE_BACKUP_ABORT_PRESTIGE": return "^1Ton prestige actuel est plus petit � Annulation";
		case "PROFILE_BACKUP_ABORT_PRESTIGE2": return "^1Ton prestige actuel est plus grand � Annulation";
		case "PROFILE_BACKUP_ABORT_RANK": return "^1Ton rang actuel est plus petit � Annulation";
		case "PROFILE_BACKUP_ABORT_RANK2": return "^1Ton rang actuel est plus grand � Annulation";
		case "PROFILE_BACKUP_CREATED": return "Sauvegarde r�ussie � elle peut �tre utilis�e d�s la prochaine carte!";
		case "PROFILE_BACKUP_LOADED": return "Restauration de la sauvegarde r�ussie!";
		case "PROFILE_BACKUP_LOADING": return "Restauration de la sauvegarde en cours � ne quitte pas le serveur!";
		case "PROFILE_BACKUP_NOT_FOUND": return "^1Aucune sauvegarde trouv�e avec ton GUID et nom!";
		case "PROPS_ROTATION_DIRECTION_CHANGED": return "La direction de la rotation a �t� chang�e!";
		case "RANK_HACKED": return "^1On dirait que tu as essay� de pirater ton rang!";
		case "RCXD_NOTAVAILABLE": return "RC-XD n'est pas disponible.";
		case "REVIVED_BY": return "&&1 est r�anim� par &&2.";
		case "REVOLT_NO_RESPAWNFLAGS": return "^1Aucun drapeau restant ^3- ^1Pas de r�apparition jusqu�� ce que ton �quipe en capture un!";
		case "SELECTION_IMPOSSIBLE": return "Il y a trop peu joueurs pour la s�lection.";
		case "SELF_REVIVED": return "&&1 s'est r�anim� tout seul.";
		case "SENTRY_GUN_BAD_SPOT": return "Impossible de d�ployer une ^2Tourelle automatique ^7ici.";
		case "SPAWNPROTECTION_DISABLED": return "^1Protection d�apparition d�sactiv�e.";
		case "SPAWNPROTECTION_ENABLED": return "^2Protection d�apparition activ�e.";
		case "SPAWNPROTECTION_GUARD_IN_ASSASSINAREA": return "^7Les ^6Gardiens ^7ne sont pas autoris�s dans l�aire d�apparition des ^1Assassins ^7!";
		case "TERMINATOR_IS": return "&&1 est Terminator!";
		case "TRAITORS_ELIMINATED": return "Tous les tra�tres ont �t� vaincus.";
		case "TRIP_ACTIVE_IN": return "Pi�ge actif dans &&1 secondes.";
		case "TRIP_BAD_SPOT": return "Tu ne peux pas utiliser de pi�ge ici!";
		case "TUTORIAL_1": return "Fondamentalement, tout est dans le titre, il y a une �quipe (les ^2Guardiens) ^7qui doit prot�ger le Roi.";
		case "TUTORIAL_10": return "Les ^2Gardiens ^7doivent prot�ger tous les terminaux de la carte.";
		case "TUTORIAL_11": return "Les ^1Assassins ^7doivent mettre un virus au terminaux.";
		case "TUTORIAL_2": return "L�autre �quipe, les ^1Assassins^7, doivent �liminer le Roi durant le m�me tour.";
		case "TUTORIAL_3": return "Le ^2Roi ^7et les ^2Guardiens ^7obtiennent un support d�un ^2Terminator ^7qui est un robuste robot, dot� d�un minigun.";
		case "TUTORIAL_4": return "^2Contenir le Code (pas finis)";
		case "TUTORIAL_5": return "Une des �quipes, les ^2Gardiens^7, doivent prot�ger le Roi et sa mallette, qui contient un code secret.";
		case "TUTORIAL_6": return "L�autre �quipe, les ^1Assassins^7, doivent �liminer le Roi, voler la mallette et la garder";
		case "TUTORIAL_7": return "pour un certaine dur�e.";
		case "TUTORIAL_8": return "Lorsque les ^1Assassins ^7ont r�ussi a vol� le code secret, une bombe nucl�aire est lanc�e.";
		case "TUTORIAL_9": return "^2Hack les Terminaux (pas finis)";
		case "TUTORIAL_TITLE": return "Informations sur le mode de jeu et le Mod";
		case "UNIFORM_OF_GUARD": return "Tu a obtenu l�uniforme d�un Gardien.";
		case "VISION_OFF": return "Visions d�sactiv�es.";
		case "VISION_ON": return "Visions activ�es.";
		case "YOU_APPEAR_AFK": return "^1Tu sembles �tre AFK!";
		case "YOU_APPEAR_STUCK": return "Tu sembles �tre bloqu�.";
		case "YOU_HAVE_THE_WEAPON": return "Tu as d�j� cette arme";
		case "ZIPLINE_BAD_END": return "Position de fin mauvaise.";
		case "ZIPLINE_BAD_START": return "Position de d�part mauvaise.";
		case "ZIPLINE_DESTROIED_USAGE": return "Cette tyrolienne a �t� coup� avant que tu ne puisses l�utiliser.";
		case "ZIPLINE_MAX_AMOUNT_REACHED": return "Nombre maximum de tyroliennes atteint.";
		case "ZIPLINE_PLACED_END": return "Position de fin plac�e.";
		case "ZIPLINE_PLACED_START": return "Position de d�part plac�e.";

		//these are used by huds so they are localized strings 
		case "CP_CANT_STEAL": return &"Impossible de voler le colis.";
		case "CP_IS_A_TRAP": return &"C'est un pi�ge.";
		case "CP_PRESS_USE": return &"Appuie sur ^3[{+activate}] pour ouvrir le colis.";
		case "DOG_SNIFF_ENEMY": return &"Appuyez sur ^3[{+activate}]^7 pour mordre les ennemis.";
		case "FOLLOWING": return &"Suivant:";
		case "HARDPOINT_TIMER_RCXD": return &"RC-XD explose dans : ^2&&1";
		case "HARDPOINT_TIMER_AC130": return &"AC130 part dans: ^2&&1";
		case "HARDPOINT_TIMER_PREDATOR": return &"Predator explose dans:^2&&1";
		case "HARDPOINT_TIMER_SENTRY": return &"Le fusil de Sentinelle explose dans: ^2&&1";
		case "HARDPOINT_TIMER_HELICOPTER": return &"Helicopt�re part dans: ^2&&1";
		case "HOLD_USE_TO_LEAVE": return &"Appuie sur ^3[{+activate}] ^7pour partir.";
		case "KING_IS": return &"^2Le Roi est: &&1";
		case "LASTSTAND_MESSAGE": return &"^1Saigner: &&1";
		case "MAPRECORD_BEST_ASSASSIN": return &"Meilleur Assassin:";
		case "MAPRECORD_BEST_KD": return &"Meilleur ratio K/D:";
		case "MAPRECORD_BEST_STREAK": return &"Plus grosse s�rie d��limination:";
		case "MAPRECORD_FASTEST_KING_KILL": return &"�limination du Roi la plus rapide:";
		case "MAPRECORD_LONGEST_KING": return &"Temps le plus long en tant que Roi:";
		case "MAPRECORD_MOST_DEATHS": return &"Le plus de morts:";
		case "MAPRECORD_MOST_KILLS": return &"Le plus d��liminations:";
		case "MAPRECORD_TITLE": return &"Tableau d�honneur � Meilleurs joueurs sur cette carte (tous les temps)";
		case "NADE_ON_YOU": return &"Une grenade est coll�e sur toi.";
		case "NO_KING_YET": return &"^2Aucun Roi pr�sentement s�lectionn�.";
		case "NOT_ENOUGH_PLAYERS": return &"Au moins &&1 joueurs n�cessaires pour commencer!";
		case "PICK_ASSASSIN": return &"S�lection de l'Assassin";
		case "PICK_DOG": return &"S�lection du Chien";
		case "PICK_KING": return &"S�lection du Roi";
		case "PICK_SLAVE": return &"S�lection de l�Esclave";
		case "PICKED_ASSASSIN_IS": return &"L'Assassin est: &&1";
		case "PICKED_DOG_IS": return &"Le Chien est: &&1";
		case "PICKED_KING_IS": return &"Le Roi est: &&1";
		case "PICKED_SLAVE_IS": return &"L'Esclave est: &&1";
		case "PICKING_ASS_SLAVE_DOG": return &"Choisissez le Chien de l'Assassin ou l'Esclave.";
		case "WEAPONCHANGE_GUNGAME": return &"Appuie sur ^3[{+activate}] ^7pour la nouvelle arme.";
		case "WEAPONCHANGE_PRESS_USE": return &"^7Appuie sur ^3[{+activate}] ^7pour changer d'arme.";
		case "ZIPLINE_USAGE_INFO": return &"Appuyez sur ^3[{+activate}] ^7/ ^1[{+melee}] ^7pour ^3Utiliser^7/^1D�truire^7la corde de secours.";
		case "HARDPOINT_PREDATOR_SPEEDUP": return &"Appuyez sur ^3[{+activate}] ^7pour acc�l�rer. ";
		case "REVIVE_INFO_YOUSELF": return &"Laissez appuyer^3[{+activate}] ^7pour vous revivre. (&&1)";
		case "REVIVE_INFO": return &"Laissez appuyer^3[{+activate}] ^7 pour r�animer. (&&1)";
		case "HARDPOINT_SENTRY_PRESS_ATTACK": return &"Appuyezv^3[{+attack}] ^7Pour d�ployez la sentinelle.";
		case "TRIP_PLANT": return &"Laissez appuyer^3[{+activate}] ^7pour planter un tripwire.";
		case "HUD_KING_HEALTH": return &"Vie du Roi : &&1";
		case "HUD_TERMINATOR_HEALTH": return &"Vie du Terminator: &&1";
		case "THROWBACKGRENADE": return &"Appuie sur ^3[{+activate}] ^7pour prendre le couteau.";
		case "BOX_PRESS_USE": return &"Appuie sur ^3[{+activate}] ^7pour obtenir une arme al�atoire.";
		
		//and these are inside a localized file because they are used in a menu or stringtable
		case "GUNGAME_STAGE": return &"KTK_GUNGAME_STAGE_FR";
		case "GUNGAME_MAXSTAGE": return &"KTK_GUNGAME_MAXSTAGE_FR";
		case "MONEY": return &"KTK_MONEY_FR";
	
		default: return "";
	}
}