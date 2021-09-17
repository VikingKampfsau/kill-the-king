init()
{
	//==============================================================================
	// Weapon Index Mismatch FIX - Found on openwarfaremod.com
	//==============================================================================
	// load weapons list in reverse order
	// example: set weap_reverse_load_mp_shipment", "1");

	//==============================================================================
	// Debugging 
	//==============================================================================
	//Log debug info in games_mp.log 0 = No, 1 = ALL (Info,Suggestions,Bugs,Warnings,Errors), 2 = SUG (Suggestions,Bugs,Warnings,Errors), 3 = BUG (Bugs,Warnings,Errors), 4 = WARN (Warnings,Errors), 5 = ERR (Errors Only)
	setDvar("scr_mod_debug", "1");
}