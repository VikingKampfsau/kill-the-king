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
	while(1)
	{
		level waittill("connected", player);
		
		if(!player isABot())
			player thread monitorCvars();
	}
}

monitorCvars()
{
	self endon("disconnect");

	weaponCycleChanges = 0;

	// does not work as expected - so removed again
	//fpsFails = 0;
		
	// moved to a shellshock
	//sensitivityChanged = false;
	//default_sensitivity = self GetUserinfo("sensitivity");
	
	while(1)
	{
		wait .5;
		
		if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator")
			continue;
	
		/* does not work as expected - so removed again
		if(self GetCountedFPS() < 85 || self GetCountedFPS() > 333)
		{
			fpsFails++;
			if(fpsFails >= 2)
			{
				if(self GetCountedFPS() < 85)
					self setClientDvar("com_maxfps", 85);
				else if(self GetCountedFPS() > 333)
					self setClientDvar("com_maxfps", 333);
					
				fpsFails = 0;
			}
		}*/
	
		if(getDvarInt("scr_mod_fastfireprotect"))
		{
			if(int(self GetUserinfo("cg_weaponcycledelay")) < 300)
			{
				weaponCycleChanges++;
				self setClientDvar("cg_weaponcycledelay", 300);
				
				if(weaponCycleChanges > 0 && (weaponCycleChanges/10) == int(weaponCycleChanges/10))
					exec("say ^1KtK detected a possible fast-fire-script for player: ^3" + self.name);
			}
		}
		
		/* moved to a shellshock
		if(!sensitivityChanged)
		{
			if(isInLastStand())
			{
				if(int(self GetUserinfo("sensitivity")) > 3)
				{
					sensitivityChanged = true;
					self setClientDvar("sensitivity", 3);
				}
			}
			else if(isInRCCar())
			{
				if(int(self GetUserinfo("sensitivity")) > 2)
				{
					sensitivityChanged = true;
					self setClientDvar("sensitivity", 2);
				}
			}
			else
			{
				//in case he changed sensitivity in menu or through console
				if(self GetUserinfo("sensitivity") != default_sensitivity)
				{
					default_sensitivity = self GetUserinfo("sensitivity");
					self setClientDvar("sensitivity", default_sensitivity);
				}
			}
		}
		else
		{
			if(!isInLastStand() && !isInRCCar())
			{
				sensitivityChanged = false;
				self setClientDvar("sensitivity", default_sensitivity);
			}
		}*/

		if(isDefined(game["customEvent"]))
		{
			if(game["customEvent"] == "alien")
			{
				if(int(self GetUserinfo("r_distortion")) != 1)
					self setClientDvar("r_distortion", 1);
				
				if(int(self GetUserinfo("dynEnt_active")) != 1)
					self setClientDvar("dynEnt_active", 1);
			}
			else if(game["customEvent"] == "hideandseek")
			{
				if(int(self GetUserinfo("cg_drawCrosshairNames")) != 0)
					self setClientDvar("cg_drawCrosshairNames", 0);
			}
		}
	}
}