init()
{
	//==============================================================================
	// Ninja Game Events
	//==============================================================================

	//available events: "none;alien;beastking;dogfight;funday;hideandseek;kingvsking;knifeonly;lastkingstanding;reversektk;revolt;sniperonly;tankking;terror;traitors;unknownking;zombie"
	setDvar("scr_mod_ktk_events", "none;alien;beastking;dogfight;kingvsking;knifeonly;lastkingstanding;reversektk;revolt;sniperonly;tankking;terror;traitors;unknownking;zombie");
	setDvar("scr_mod_ktk_eventdays", "monday;tuesday;wednesday;thursday;friday;saturday;sunday");
	setDvar("scr_mod_ktk_eventtime_weekend", "00:00-23:59");
	setDvar("scr_mod_ktk_eventtime_midweek", "00:00-23:59");
	
	setDvar("scr_mod_minplayers_event_resettime", "20"); //time in seconds to fall back to 'normal ktk' when not enough players online to start the event
}