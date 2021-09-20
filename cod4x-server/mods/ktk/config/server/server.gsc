init()
{
	//==============================================================================
	// News & Rules
	//==============================================================================
	// Messages which will be show on top of the screen
	setDvar("scr_mod_newsdelay", "10");	//Time in seconds between the messages
	setDvar("scr_mod_news_1", "PussTheCat.org - Kill the King");
	// add or remove as many as you want

	// Rules visible on the main menu
	setDvar("rule_1", "^5Rule #1: ^7English or French only.");
	setDvar("rule_2", "^5Rule #2: ^7No cheating.");
	setDvar("rule_3", "^5Rule #3: ^7Camping allowed, spawncamping forbidden.");
	setDvar("rule_4", "^5Rule #4: ^7Don't go out of the map if you are king.");
	setDvar("rule_5", "^5Rule #5: ^7Don't suicide if you are king.");
	setDvar("rule_6", "^5Rule #6: Respect others.");

	// Message of the Day - Visible on the main menu
	setDvar("scr_motd", "PussTheCat.org - Kill the King");

	// Smoother movement for deathrun and codjumper players
	setDvar("jump_slowdownEnable", "0");
}
