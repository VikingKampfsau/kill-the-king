init()
{
	//==============================================================================
	// Special Players - The Admins
	//==============================================================================
	// Here you can set the admins for your server
	// *the name can be different from the player name used on the server*
	// *powers are admin (access to all features), mod (access to all features except ban) and member (access to spectate only)*
	
	// example: setDvar("scr_loginpass_admin_1", "name;password;power");
	setDvar("scr_loginpass_admin_1", "");
	setDvar("scr_loginpass_admin_2", "");
	setDvar("scr_loginpass_admin_3", "");
	// add as many as you want

	// Automatically login to rcon when loging into admin panel (Admins only!)
	setDvar("scr_admin_rconlogin", "1");	//0 = Disabled, 1 = Enabled
	
	setDvar("scr_admin_autoGetSS", "0");	//Capturing a PB screenshot of all players every X seconds, 0 = Disbaled
}