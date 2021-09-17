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

SetBossModel()
{
	self maps\mp\gametypes\_teams::playerModelForWeapon( level.ktkWeapon["intervention"] );
	
	/* removed - we use the bought models now

	if(self isKing() || game["customEvent"] == "lastkingstanding")
	{
		self detachAll();
	
		if(game["defenders"] == "allies")
			self SetModel("body_complete_mp_kennedy");
		else
			self SetModel("body_complete_mp_makarov");
	}
	else if(self isTerminator())
	{
		self detachAll();
	
		if(getDvarInt("scr_ktk_terminator") == 1)
			self SetModel("playermodel_terminator");
		else if(getDvarInt("scr_ktk_terminator") == 2)
			self SetModel("playermodel_mw3_exp_juggernaunt");
	}
	else if(self isDog() || (self isAnAssassin() && game["customEvent"] == "dogfight"))
	{
		self detachAll();
	
		if(game["customEvent"] == "zombie")
			self SetModel("body_complete_zombie_hellhound");
		else
			self SetModel("german_sheperd_dog");
	}
	else if(self isMainAssassin())
	{
		if(game["customEvent"] == "none")
		{
			self detachAll();
			self SetModel("body_complete_mp_mamiya");
			return;
		}

		if(game["customEvent"] == "kingvsking")
		{
			self detachAll();
		
			if(game["attackers"] == "allies")
				self SetModel("body_complete_mp_kennedy");
			else
				self SetModel("body_complete_mp_makarov");
		}
		else if(game["customEvent"] == "zombie")
		{
			self detachAll();
		
			self SetModel("fake_player");
		}
	}*/
}