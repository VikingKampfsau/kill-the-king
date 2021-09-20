init()
{
	//==============================================================================
	// Gungame
	//==============================================================================
	// The weapons the player will achieve after a kill (defenders only)
	// "scr_gungame_weapon1" is the weapon the player will start with
		
	setDvar("scr_gungame_weapon1", "beretta_mp");
	setDvar("scr_gungame_weapon2", "deserteagle_mp");
	setDvar("scr_gungame_weapon3", "beretta_silencer_mp");
	setDvar("scr_gungame_weapon4", "uzi_mp");
	setDvar("scr_gungame_weapon5", "mp5_mp");
	setDvar("scr_gungame_weapon6", "ak74u_mp");
	setDvar("scr_gungame_weapon7", "p90_mp");
	setDvar("scr_gungame_weapon8", "winchester1200_mp");
	setDvar("scr_gungame_weapon9", "m16_mp");
	setDvar("scr_gungame_weapon10", "g3_mp");
	setDvar("scr_gungame_weapon11", "m4_mp");
	setDvar("scr_gungame_weapon12", "g36c_mp");
	setDvar("scr_gungame_weapon13", "mp44_mp");
	setDvar("scr_gungame_weapon14", "ak47_mp");
	setDvar("scr_gungame_weapon15", "ak47_acog_mp");
	setDvar("scr_gungame_weapon16", "saw_mp");
	setDvar("scr_gungame_weapon17", "rpd_mp");
	setDvar("scr_gungame_weapon18", "rpd_acog_mp");
	setDvar("scr_gungame_weapon19", "saw_acog_mp");
	// add or remove as many as you want

	setDvar("scr_gungame_autoswitch", "0");	//forces the new weapon to the player (0 = no, 1 = yes)
	
	//Assassin classes
	//The result of the set values has to be 1!
	setDvar("scr_class_percentage_knife", "0.15"); //(0 = won't be chosen, < 1 = chance to be picked, 1 = the only one to be picked
	setDvar("scr_class_percentage_bolt", "0.25"); //(0 = won't be chosen, < 1 = chance to be picked, 1 = the only one to be picked
	setDvar("scr_class_percentage_scope", "0.25"); //(0 = won't be chosen, < 1 = chance to be picked, 1 = the only one to be picked
	setDvar("scr_class_percentage_strongscope", "0.2"); //(0 = won't be chosen, < 1 = chance to be picked, 1 = the only one to be picked
	setDvar("scr_class_percentage_hardscope", "0.1"); //(0 = won't be chosen, < 1 = chance to be picked, 1 = the only one to be picked
	setDvar("scr_class_percentage_katana", "0.05"); //(0 = won't be chosen, < 1 = chance to be picked, 1 = the only one to be picked
}