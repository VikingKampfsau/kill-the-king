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
	self endon("death");
	self endon("disconnect");

	if(self isABot())
		return;
	
	if(isDefined(level.GameNuked) && level.GameNuked && self.pers["curVision"] != "nuked")
	{
		self.pers["curVision"] = "nuked";
	
		self setClientDvars("r_FilmTweakEnable", 0,
							"r_FilmUseTweaks", 0);
		return;
	}

	if(!self getKtkStat(2405))
	{
		if(isDefined(self.pers["nvg"]) && self.pers["nvg"])
			Nightvision();
		else
			Default(0);
	}
	else
	{
		if(self isDog())
			self Dog();
		else if(self isTerminator())
			self Terminator();
		else
		{
			if(isDefined(self.pers["nvg"]) && self.pers["nvg"])
				Nightvision();
			else
				Default(1);
		}
	}
}

Default(visionEnabled)
{
	self endon("disconnect");
	self endon("death");

	if(!isDefined(self.killcam) || !self.killcam)
	{
		//always execute it on first spawn
		if(!isDefined(self.wasInKillcam))
			 self.wasInKillcam = true;
	
		if(self.wasInKillcam)
		{
			if(self isDog())
			{		
				self setClientDvars("ammoCounterHide", 1,
									"cg_drawgun", 0,
									"cg_fovmin", 95);
			}
			else
			{
				self setClientDvars("ammoCounterHide", 0,
									"cg_drawgun", 1,
									"cg_fovmin", 10);
			}
			
			self.wasInKillcam = false;
		}
	}
	
	if(visionEnabled)
	{
		if(getDvarInt("scr_mod_daynight") == 0 || !isDefined(game["daytime"]))
		{
			if(self.pers["curVision"] == "default")
				return;
			
			self.pers["curVision"] = "default";
		
			self setClientDvars("r_FilmTweakDarktint", ".7 0.85 1",
								"r_FilmTweakLighttint", "1.1 1.05 0.85", 
								"r_FilmTweakInvert", "0", 
								"r_FilmTweakBrightness", "0.075", 
								"r_FilmTweakContrast", "1.175", 
								"r_FilmTweakDesaturation", ".2",
								"r_FilmTweakEnable", "1",
								"r_FilmUseTweaks", "1");
		}
	}
	else
	{
		if(self.pers["curVision"] == "default")
			return;
			
		self.pers["curVision"] = "default";
		
		self setClientDvars("r_FilmTweakEnable", 0,
							"r_FilmUseTweaks", 0);
	}
}

Dog()
{
	self endon("death");
	self endon("disconnect");

	if(self.pers["curVision"] == "dog")
		return;
	
	self.pers["curVision"] = "dog";
	
	self setClientDvars("ammoCounterHide", 1,
						"cg_drawgun", 0,
						"cg_fovmin", 95,
						"r_FilmTweakDesaturation", "1",
						"r_FilmTweakEnable", "1",
						"r_FilmUseTweaks", "1",
						"r_FilmTweakContrast", "1.55",
						"r_FilmTweakBrightness", "0.13");
}

Terminator()
{
	self endon("death");
	self endon("disconnect");

	if(self.pers["curVision"] == "terminator")
		return;
	
	self.pers["curVision"] = "terminator";
	
	self setClientDvars("ammoCounterHide", 0,
						"r_FilmTweakDarktint", ".7 0.2 0.3",
						"r_FilmTweakLighttint", "1.1 1.05 0.85", 
						"r_FilmTweakInvert", "0", 
						"r_FilmTweakBrightness", "0.075", 
						"r_FilmTweakContrast", "1.22", 
						"r_FilmTweakDesaturation", ".3",
						"r_FilmTweakEnable", "1",
						"r_FilmUseTweaks", "1");
}

Thermal()
{
	self endon("death");
	self endon("disconnect");

	if(self.pers["curVision"] == "thermal")
		return;
	
	self.pers["curVision"] = "thermal";
	
	self setClientDvars("r_FilmTweakDarktint", "1 1 1",
						"r_FilmTweakLighttint", "1 1 1", 
						"r_FilmTweakInvert", "1", 
						"r_FilmTweakBrightness", "0.13", 
						"r_FilmTweakContrast", "1.55", 
						"r_FilmTweakDesaturation", "1",
						"r_FilmTweakEnable", "1",
						"r_FilmUseTweaks", "1");
}

Nuke()
{
	if(self.pers["curVision"] == "nuke")
		return;
	
	self.pers["curVision"] = "nuke";

	self setClientDvars("r_FilmTweakDarktint", "0.7 0.85 1",
						"r_FilmTweakLighttint", "1.1 1.05 0.85", 
						"r_FilmTweakInvert", "0", 
						"r_FilmTweakBrightness", "0", 
						"r_FilmTweakContrast", "1.4", 
						"r_FilmTweakDesaturation", "0.2",
						"r_FilmTweakEnable", "1",
						"r_FilmUseTweaks", "1");
}

Nightvision()
{
	self endon("death");
	self endon("disconnect");

	if(self.pers["curVision"] == "nightvision")
		return;
	
	self.pers["curVision"] = "nightvision";
	
	self setClientDvars("r_FilmTweakDarktint", "0 1.54321 0.000226783",
						"r_FilmTweakLighttint", "1.5797 1.9992 2.0000", 
						"r_FilmTweakInvert", "0", 
						"r_FilmTweakBrightness", "0.26", 
						"r_FilmTweakContrast", "1.63", 
						"r_FilmTweakDesaturation", "1",
						"r_FilmTweakEnable", "1",
						"r_FilmUseTweaks", "1");
}