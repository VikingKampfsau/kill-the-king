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
}

ThermalScope(curWeapon)
{
	self endon("disconnect");
	self endon("death");
	
	self.thermal = false;
	while(self GetCurrentWeapon() == curWeapon)
	{
		wait 0.05;

		if(self playerADS() == 1)
		{
			if(self UseButtonPressed())
			{
				while(self UseButtonPressed())	
					wait 0.05;
				
				self.thermal = !self.thermal;
				
				if(self.thermal)
					self thread maps\mp\gametypes\_vision::Thermal();
				else
					self thread maps\mp\gametypes\_vision::init();
			}
		}
		else
		{
			if(self.thermal)
			{
				self thread maps\mp\gametypes\_vision::init();
				self.thermal = false;
			}
		}
	}
	
	if(self.thermal)
	{
		self thread maps\mp\gametypes\_vision::init();
		self.thermal = false;
	}
}