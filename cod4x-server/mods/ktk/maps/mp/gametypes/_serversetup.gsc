init()
{
	if(!isDefined(game["roundsplayed"]) || game["roundsplayed"])
	{
		config\server\admins::init();
		config\server\bans::init();
		config\server\bots::init();
		config\server\debug::init();
		config\server\events::init();
		config\server\gameplay::init();
		config\server\gametypes::init();
		config\server\gungame::init();
		config\server\hardpoints::init();
		config\server\server::init();
		config\server\vips::init();
		config\server\weaponbox::init();
		
		if(!isDefined(game["customEvent"]))
			return;
			
		switch(game["customEvent"])
		{
			case "alien": 				config\events\alien::init(); break;
			case "beastking": 			config\events\beastking::init(); break;
			case "dogfight": 			config\events\dogfight::init(); break;
			case "funday": 				config\events\funday::init(); break;
			case "kingvsking": 			config\events\kingvsking::init(); break;
			case "hideandseek": 		config\events\hideandseek::init(); break;
			case "knifeonly": 			config\events\knifeonly::init(); break;
			case "lastkingstanding":	config\events\lastkingstanding::init(); break;
			case "reversektk": 			config\events\reversektk::init(); break;
			case "revolt": 				config\events\revolt::init(); break;
			case "sniperonly": 			config\events\sniperonly::init(); break;
			case "tankking": 			config\events\tankking::init(); break;
			case "terror": 				config\events\terror::init(); break;
			case "traitors": 			config\events\traitors::init(); break;
			case "unknownking": 		config\events\unknownking::init(); break;
			case "zombie": 				config\events\zombie::init(); break;
			default:					break;
		}
	}
}