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
//Bug fixes by Bipo

#include maps\mp\_utility;
#include maps\mp\gametypes\_misc;

init()
{
	if(getDvar("scr_mod_daynight") == "") setDvar("scr_mod_daynight", 1);
	if(getDvar("scr_mod_current_time") == "") setDvar("scr_mod_current_time", "12:0:0");
	
	if(getDvarInt("scr_mod_daynight") == 0)
		return;
		
	if(!isDefined(game["daynight"]))
	{
		game["daynight"] = [];
		
		DefineDaytime("night_end", "2:30",  "1.34921", "0", "0.26", "0.5 0.5 0.5", "0.1 0.1 0.1", "0.725", "1 1 1 1");
		DefineDaytime("day_start", "8:00", "1.34921", "0.161376", "0", "1.12169 1.1746 1.06878", "0.708995 0.899471 1.01587", "1.33", "1 0 0 1");
		DefineDaytime("night_start", "22:00", "1.34921", "0", "0.26", "0.5 0.5 0.5", "0.1 0.1 0.1", "0.725", "1 1 1 1");
	}
	
	if(!isDefined(game["daynight_circle"]))
		DefineCycleState();

	thread StartDayCycle();
}

DefineDaytime(desc, time, contrast, brightness, desaturation, lighttint, darktint, sunlight, suncolor)
{
	time = StrToK(time, ":");
	slot = game["daynight"].size;

	game["daynight"][slot] = [];
	
	game["daynight"][slot]["desc"] = desc;
	game["daynight"][slot]["cycletime"] = int(time[0]) + int(time[1])/60;
	game["daynight"][slot]["contrast"] = float(contrast);
	game["daynight"][slot]["brightness"] = float(brightness);
	game["daynight"][slot]["desaturation"] = float(desaturation);
	game["daynight"][slot]["lighttint"] = lighttint;
	game["daynight"][slot]["darktint"] = darktint;
	game["daynight"][slot]["sunlight"] = float(sunlight);
	game["daynight"][slot]["suncolor"] = suncolor;
}

DefineCycleState()
{
	struct = spawnStruct();
	struct.firstCycle = true;
	struct.currentdaystate = 0;
	struct.nextdaystate = 0;
		
	game["daynight_circle"] = struct;
}

getNextIndex(i) 
{
	j = i+1;
	if(j >= game["daynight"].size)
		return 0;
	
	return j;
}

getTimeDifference(first, next)
{
	if(first > next)
		return (24 - first + next);
	
	return (next - first);
}

StartDayCycle()
{
	wait 1;
	time = strToK(getDvar("scr_mod_current_time"), ":");

	if(game["daynight_circle"].firstCycle)
	{
		for(i=0;i<3;i++)
		{
			if(!isDefined(time[i]))
				time[i] = 0;
			else
				time[i] = int(time[i]);
		}

		game["daynight_circle"].firstCycle = false;
		game["daynight_circle"].currentdaystate = game["daynight"].size-1;
		game["daynight_circle"].nextdaystate = -1;
		game["daytime"] = time[0] + (time[1]/60) + (time[2]/60/60);
		setDvar("scr_mod_current_time", time[0] + ":" + time[1] + ":" + time[2]);
		
		for(i=game["daynight"].size-1;i>=0;i--)
		{
			if(game["daytime"] >= game["daynight"][i]["cycletime"])
			{
				game["daynight_circle"].currentdaystate = i;
				game["daynight_circle"].nextdaystate = getNextIndex(i);
				break;
			}
		}
			
		if(game["daynight_circle"].currentdaystate < 0)
		{
			iPrintLnBold("Unable to start daynight system, aborting!");
			setDvar("scr_mod_daynight", game["daynight_circle"].currentdaystate);
			return;
		}
	}

	while(1)
	{
		wait .1;

		time[2] += .1;
		
		if(time[2] >= 60)
		{
			time[2] -= 60;
			time[1]++;
		}
			
		if(time[1] >= 60)
		{
			time[1] -= 60;
			time[0]++;
		}
			
		if(time[0] >= 24)
			time[0] = 0;

		setDvar("scr_mod_current_time", time[0] + ":" + time[1] + ":" + time[2]);
		game["daytime"] = (time[0] + (time[1]/60) + (time[2]/60/60));

		for(i=0;i<game["daynight"].size;i++)
		{
			if((time[0] + (time[1]/60) + (time[2]/60/60)) == game["daynight"][i]["cycletime"])
			{
				game["daynight_circle"].currentdaystate = game["daynight_circle"].nextdaystate;
				game["daynight_circle"].nextdaystate = getNextIndex(game["daynight_circle"].nextdaystate);
			}
		}
		
		contrast = CalculateVisionTweak("contrast");
		brightness = CalculateVisionTweak("brightness");
		desat = CalculateVisionTweak("desaturation");
		lighttint = CalculateVisionTweak("lighttint");
		darktint = CalculateVisionTweak("darktint");
		dt = game["daytime"] - 12;
		sundir = ( -45.0 + dt * dt / 1.6, game["daytime"] * 15, 0);
		sundir = "" + sundir[0] + " " + sundir[1] + " " + sundir[2];
		sunlight = CalculateVisionTweak("sunlight");
		suncolor = CalculateVisionTweak("suncolor");
		
		for(i=0;i<level.players.size;i++)
		{
			if(level.players[i] isABot())
				continue;
		
			if(level.players[i] isDog())
				continue;
			
			if(level.players[i] isTerminator())
				continue;

			if(isDefined(level.players[i].pers["nvg"]) && level.players[i].pers["nvg"])
				continue;

			if(isDefined(level.players[i].thermal) && level.players[i].thermal && isSniper(level.players[i] GetCurrentWeapon()) && level.players[i] AdsButtonPressed())
				continue;
				
			level.players[i] setClientDvars(	"r_FilmTweakInvert", "0",
										"r_filmTweakContrast", contrast,
										"r_filmTweakBrightness", brightness,
										"r_filmTweakDesaturation", desat,
										"r_filmTweakLightTint", lighttint,
										"r_filmTweakDarkTint", darktint,
										"r_lighttweaksunlight", sunlight,
										"r_lighttweaksuncolor", suncolor);
			
			//"r_lighttweaksundirection", sundir,
		}
	}
}

CalculateVisionTweak(type)
{
	if(!isDefined(type)) 
		return 0;
	
	m = 0;
	x = 0;
	value = "";
	current = game["daynight_circle"].currentdaystate;
	next = game["daynight_circle"].nextdaystate;

	if(!isDefined(current)) iPrintLnBold("current not defined");
	if(!isDefined(next)) iPrintLnBold("next not defined");
	if(!isDefined(game["daynight"][current]["cycletime"])) iPrintLnBold("game[daynight][current][cycletime] not defined");
	if(!isDefined(game["daytime"])) iPrintLnBold("game[daytime] not defined");
	if(!isDefined(current)) iPrintLnBold("current not defined");
	if(!isDefined(game["daynight"][next]["cycletime"])) iPrintLnBold("game[daynight][next][cycletime] not defined");
	
	x = getTimeDifference(game["daynight"][current]["cycletime"], game["daytime"]) / getTimeDifference(game["daynight"][current]["cycletime"], game["daynight"][next]["cycletime"]);
	
	if(type != "lighttint" && type != "darktint" && type != "suncolor")
	{
		// Steigung = Delta der Uhrzeit in diesem Bereich / Delta des Types (ex. "Contrast")
		m  = (game["daynight"][next][type] - game["daynight"][current][type]);
		
		// Berechnung des aktuellen Werts
		value = (m * x);
		
		return CheckValidValue(game["daynight"][current][type] + value, type);
	}
	
	current_value = strToK(game["daynight"][current][type], " ");
	target_value = strToK(game["daynight"][next][type], " ");
	calc = [];
	valid = [];
		
	for(i=0;i<target_value.size;i++)
	{
		// Steigung = Delta der Uhrzeit in diesem Bereich / Delta des Types (ex. "Contrast")
		m  = (float(target_value[i]) - float(current_value[i]));
		
		// Berechnung des aktuellen Werts
		calc[i] = (m * x);
	}
		
	for(i=0;i<calc.size;i++)
		valid[i] = CheckValidValue((float(current_value[i])+calc[i]), type);

	if(valid.size == 3)
		return (valid[0] + " " + valid[1] + " " + valid[2]);

	if(valid.size == 4)
		return (valid[0] + " " + valid[1] + " " + valid[2] + " " + valid[3]);
	
	return game["daynight"][current][type];
}

CheckValidValue(value, type)
{
	if(type == "contrast")
	{
		if(value > 4) return 4;
		if(value < 0) return 0;
	}
	else if(type == "brightness")
	{
		if(value > 1) return 1;
		if(value < -1) return -1;
	}
	else if(type == "desaturation")
	{
		if(value > 1) return 1;
		if(value < 0) return 0;
	}
	else if(type == "lighttint" || type == "darktint")
	{
		if(value > 2) return 2;
		if(value < 0) return 0;
	}
	else if(type == "suncolor")
	{
		if(value > 2) return 2;
		if(value < 0) return 0;
	}
	else if(type == "sunlight")
	{
		if(value > 4) return 4;
		if(value < 0) return 0;
	}
	
	return value;
}