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
|				   Do not copy or modify without permission				    |
|--------------------------------------------------------------------------*/

init()
{
	if(getDvar("scr_mod_timeannouncer") == "" ) setDvar("scr_mod_timeannouncer", "1" );

	while(!isDefined(level.roundstarted) || !level.roundstarted)
		wait .1;
	
	if(getdvarint("scr_mod_timeannouncer") == 1)
		thread timeannouncer();
}

SoundToPlayers( sound )
{
	for(i=0; i<level.players.size; i++)
		level.players[i] PlayLocalSound(sound);
}

timeannouncer()
{
	level endon("game_ended");

	while(1)
	{
		wait 1;
		
		if(isDefined(level.roundstarted) && level.roundstarted)
		{
			if(isDefined(level.NukeLaunched) && level.NukeLaunched)
				continue;
		
			if(int(maps\mp\gametypes\_globallogic::getTimeRemaining() / 1000) <= 0)
				return;
		
			switch(int(maps\mp\gametypes\_globallogic::getTimeRemaining() / 1000))
			{
				case 300:
					SoundToPlayers("5_minute_warning");
					break;

				case 180:
					SoundToPlayers("3_minutes_remain");
					break;

				case 120:
					SoundToPlayers("2_minutes_remain");
					break;

				case 60:
					SoundToPlayers("1_minute_remains");
					break;

				case 30:
					SoundToPlayers("30_seconds_remain");
					break;

				case 20:
					SoundToPlayers("20_seconds");
					break;

				case 10:
					SoundToPlayers("count_10");
					break;

				case 9:
					SoundToPlayers("count_9");
					break;

				case 8:
					SoundToPlayers("count_8");
					break;

				case 7:
					SoundToPlayers("count_7");
					break;

				case 6:
					SoundToPlayers("count_6");
					break;

				case 5:
					SoundToPlayers("count_5");
					break;

				case 4:
					SoundToPlayers("count_4");
					break;

				case 3:
					SoundToPlayers("count_3");
					break;

				case 2:
					SoundToPlayers("count_2");
					break;

				case 1:
					SoundToPlayers("count_1");
					break;
					
				default: break;
			}
		}
	}
}

roundannouncer(event)
{
	level endon("game_ended");
	
	if(isDefined(event) && !level.gameEnded)
	{
		if(event == "died") SoundToPlayers("king_died");
		else if(event == "left") SoundToPlayers("king_left");
		else if(event == "survived") SoundToPlayers("king_survived");
	}
}