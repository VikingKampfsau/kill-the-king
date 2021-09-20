init()
{
	//==============================================================================
	// Bots 
	//==============================================================================

	setDvar("scr_ktk_bots_amount", "16");				//Amount of bots to play with - they use a serverslot!
	setDvar("scr_ktk_bots_guardlimit", "7");			//Limit of bot guards - when this amount is reached bots assassins will not become guards when the king kills them
	setDvar("scr_ktk_bots_skillAssAssins", "0.6");		//0-1 -> 0 = they don't attack; default = 0.4
	setDvar("scr_ktk_bots_skillGuards", "0.3");			//0-1 -> 0 = they don't attack; default = 0.4
	setDvar("scr_ktk_bots_skillKing", "0.8");			//0-1 -> 0 = he doesn't attack; default = 0.4
	setDvar("scr_ktk_bots_maxDistance", "5000");		//the max distance the bots can see; default = 5000
	setDvar("scr_ktk_bots_startRoundWhenEmpty", "1");	//Count bots as "real" players during the minplayer wait; 0 = no, 1 = yes; default = 0
	setDvar("scr_ktk_bots_trackKing", "1");				//Tracks the king movement to calculate the best campspots for bot kings => Bot kings will learn from players where to camp; 0 = no, 1 = yes; default = 1;
	setDvar("scr_ktk_bots_reviveAmount", "3");			//Min amount of 'real' players to allow the bots to revive; 0 = bots do not revive; default = 3;
}
