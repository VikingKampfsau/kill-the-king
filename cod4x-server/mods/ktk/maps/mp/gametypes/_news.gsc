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
#include maps\mp\gametypes\_misc;

init()
{
	level.newsdelay = GetDvarInt("scr_mod_newsdelay");
	
	if(GetDvar("scr_mod_newsdelay") == "" || GetDvarInt("scr_mod_newsdelay") < 30)
		level.newsdelay = 30;
	
	setNews();
}

setNews()
{
	current = 1;
	
	while(1)
	{
		if(getDvar("scr_mod_news_" + current) == "")
			current = 1;
		
		for(i=0;i<level.players.size;i++)
		{
			if(level.players[i] isABot())
				continue;
		
			level.players[i] setClientDvar("ktk_news", getDvar("scr_mod_news_" + current));
		}
		
		current++;
		wait level.newsdelay;
	}
}