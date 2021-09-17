init()
{
	//==============================================================================
	// News & Rules
	//==============================================================================
	// Messages which will be show on top of the screen
	setDvar("scr_mod_newsdelay", "10");	//Time in seconds between the messages
	setDvar("scr_mod_news_1", "^5Join ^7us at ^5Facebook! ^0[Ninja]^5Kill the King");
	setDvar("scr_mod_news_2", "^7You can get your ^5prestige ^7that you earned at ^5other servers^7!");
	setDvar("scr_mod_news_3", "SUNDAY EVENT DAY!");
	// add or remove as many as you want

	// Rules visible on the main menu
	setDvar("rule_1", "^5Rule #1: ^7English only.");
	setDvar("rule_2", "^5Rule #2: ^7Glitches will be judged by admins.");
	setDvar("rule_3", "^5Rule #3: ^7Camping allowed, spawncamping forbidden.");
	setDvar("rule_4", "^5Rule #4: ^7Don't go out of the map if you are king.");
	setDvar("rule_5", "^5Rule #5: ^7Don't suicide if you are king.");
	setDvar("rule_6", "^5Rule #6: Respect others, no racism and no personal insults.");

	// Message of the Day - Visible on the main menu
	setDvar("scr_motd", "^5Join our discord group: ^3discord.gg/wDV8Eeu^7");
}