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
	if(getDvar("scr_enable_nightvision") == "" ) setDvar("scr_enable_nightvision", 1 );
}

ToggleNVG()
{
	self endon("disconnect");
	
	if(!getDvarInt("scr_enable_nightvision"))
		return;
	
	if(self isABot())
		return;
	
	if(self isDog())
		return;
			
	if(self isTerminator())
		return;
	
	if(!isDefined(self.pers["nvg"]))
		return;
			
	if(self.pers["nvg"])
	{
		self.pers["nvg"] = false;
		self PlayLocalSound("item_nightvision_off");
		self thread maps\mp\gametypes\_huds::NVGHUD(0);
		self thread maps\mp\gametypes\_vision::init();
	}
	else
	{
		self.pers["nvg"] = true;
		self PlayLocalSound("item_nightvision_on");
		self thread maps\mp\gametypes\_huds::NVGHUD(1);
		self thread maps\mp\gametypes\_vision::init();
	}
}