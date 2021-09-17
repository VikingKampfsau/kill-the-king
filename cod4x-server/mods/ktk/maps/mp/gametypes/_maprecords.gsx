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
	level.mapRecordsFile = "maprecords/" + level.script + ".csv";

	while(1)
	{
		level waittill("connected", player);
		
		player thread defineRecordVariable("totalkills");
		player thread defineRecordVariable("totaldeaths");
		player thread defineRecordVariable("kdratio");
		player thread defineRecordVariable("killstreak");
		player thread defineRecordVariable("kingskilled");
		player thread defineRecordVariable("kingkilltime");
		player thread defineRecordVariable("kingtime");
	}
}

defineRecordVariable(type)
{
	self endon("disconnect");
	
	if(!isDefined(self.pers[type]))
		self.pers[type] = 0;
}

showMapRecords()
{
	if(getDvarInt("scr_mod_maprecords") == 0)
		return;

	level.HoF = [];
	
	if(!isDefined(game["maprecords"]))
		thread getExistingRecordsFromFile();

	thread CreateHoFHudShader("background", -1, "left", "top", 0, 0, "fullscreen", "fullscreen", false, 1, 0, 1, "black", 640, 480);
	wait 1; //thats the fadeOverTime of the background

	for(i=0;i<=7;i++)
	{
		switch(i)
		{
			case 1:
				thread CreateHoFHudTitle("totalkills", 0, "left", "middle", 70, -150, "left", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_MOST_KILLS", getPlayerForRecord("totalkills", "more")); break;
			case 2:
				thread CreateHoFHudTitle("totaldeaths", 0, "left", "middle", 70, -120, "left", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_MOST_DEATHS", getPlayerForRecord("totaldeaths", "more")); break;
			case 3:
				thread CreateHoFHudTitle("kdratio", 0, "left", "middle", 70, -90, "left", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_BEST_KD", getPlayerForRecord("kdratio", "more")); break;
			case 4:
				thread CreateHoFHudTitle("killstreak", 0, "left", "middle", 70, -60, "left", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_BEST_STREAK", getPlayerForRecord("killstreak", "more")); break;
			case 5:
				thread CreateHoFHudTitle("kingskilled", 0, "left", "middle", 70, -30, "left", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_BEST_ASSASSIN", getPlayerForRecord("kingskilled", "more")); break;
			case 6:
				thread CreateHoFHudTitle("kingkilltime", 0, "left", "middle", 70, 0, "left", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_FASTEST_KING_KILL", getPlayerForRecord("kingkilltime", "less")); break;
			case 7:
				thread CreateHoFHudTitle("kingtime", 0, "left", "middle", 70, 30, "left", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_LONGEST_KING", getPlayerForRecord("kingtime", "more")); break;
			default: 
				thread CreateHoFHudTitle("title", 0, "center", "middle", 0, -200, "center", "middle", true, 1, "objective", 1.7, 0.7, (0.8, 0.2, 0.2), (40, 22000, 200), "MAPRECORD_TITLE", undefined); break;
		}
		
		if(i == 0)
			wait 1.5;
	}
	
	if(isDefined(level.HoF["background"]))
		level.HoF["background"] HudFadeOutAndRemove(7, 1);
		
	wait 2;
		
	updateRecordsFile();
}

CreateHoFHudShader(name, sort, alignX, alignY, x, y, horzAlign, vertAlign, foreground, fadeOverTime, minAlpha, maxAlpha, shader, shaderWidth, shaderHeight)
{
	if(isDefined(level.HoF[name]))
		level.HoF[name] destroy();

	level.HoF[name] = newHudElem();
	level.HoF[name].sort = sort;
	level.HoF[name].alignX = alignX;
	level.HoF[name].alignY = alignY;
	level.HoF[name].x = x;
	level.HoF[name].y = y;
	level.HoF[name].horzAlign = horzAlign;
	level.HoF[name].vertAlign = vertAlign;
	level.HoF[name].foreground = foreground;
	level.HoF[name] setShader(shader, shaderWidth, shaderHeight);
	level.HoF[name].alpha = minAlpha;
	level.HoF[name] fadeOverTime(fadeOverTime);
	level.HoF[name].alpha = maxAlpha;
}

CreateHoFHudTitle(name, sort, alignX, alignY, x, y, horzAlign, vertAlign, foreground, alpha, font, fontscale, glowalpha, glowcolor, pulsetime, text, player)
{
	if(!isDefined(level.HoF[name]))
		level.HoF[name] = spawnStruct();

	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i] isABot())
			continue;
	
		if(!isDefined(level.players[i].HoF))
			level.players[i].HoF = [];
	
		if(isDefined(level.players[i].HoF[name]))
			level.players[i].HoF[name] destroy();

		level.players[i].HoF[name] = NewClientHudElem(level.players[i]);
		level.players[i].HoF[name].sort = sort;
		level.players[i].HoF[name].alignX = alignX;
		level.players[i].HoF[name].alignY = alignY;
		level.players[i].HoF[name].x = x;
		level.players[i].HoF[name].y = y;
		level.players[i].HoF[name].horzalign = horzalign;
		level.players[i].HoF[name].vertalign = vertalign;
		level.players[i].HoF[name].foreground = foreground;
		level.players[i].HoF[name].alpha = alpha;
		level.players[i].HoF[name].font = font;
		level.players[i].HoF[name].fontscale = fontscale; //min 1.4; max 4.6
		level.players[i].HoF[name].glowalpha = glowalpha;
		level.players[i].HoF[name].glowcolor = glowcolor; //(rot, grün, blau)
		level.players[i].HoF[name].label = level.players[i] GetLocalizedString(text);
		level.players[i].HoF[name] SetPulseFX(40, 22000, 200);	//(x,y,z) 1000 = 1 sec
		
		if(name == "title")
			level.players[i].HoF[name] thread HudFadeOutAndRemove(8.5, 1);
		else
			level.players[i].HoF[name] thread HudFadeOutAndRemove(5, 1);
	}
	
	if(name != "title")
		thread CreateHoFHudText(name, sort, alignX, alignY, x, y, horzAlign, vertAlign, foreground, alpha, font, fontscale, glowalpha, glowcolor, pulsetime, player);
}

CreateHoFHudText(name, sort, alignX, alignY, x, y, horzAlign, vertAlign, foreground, alpha, font, fontscale, glowalpha, glowcolor, pulsetime, player)
{
	if(isDefined(level.HoF[name].winner))
		level.HoF[name].winner destroy();

	level.HoF[name].winner = NewHudElem();
	level.HoF[name].winner.sort = sort;
	level.HoF[name].winner.alignX = "center";
	level.HoF[name].winner.alignY = alignY;
	level.HoF[name].winner.x = x-x;
	level.HoF[name].winner.y = y;
	level.HoF[name].winner.horzalign = "center";
	level.HoF[name].winner.vertalign = vertalign;
	level.HoF[name].winner.foreground = foreground;
	level.HoF[name].winner.alpha = alpha;
	level.HoF[name].winner.font = font;
	level.HoF[name].winner.fontscale = fontscale; //min 1.4; max 4.6
	level.HoF[name].winner.glowalpha = glowalpha;
	level.HoF[name].winner.glowcolor = glowcolor; //(rot, grün, blau)
	level.HoF[name].winner.label = &"";
	
	if(isDefined(level.HoF[name].winnerValue))
		level.HoF[name].winnerValue destroy();

	level.HoF[name].winnerValue = NewHudElem();
	level.HoF[name].winnerValue.sort = sort;
	level.HoF[name].winnerValue.alignX = "right";
	level.HoF[name].winnerValue.alignY = alignY;
	level.HoF[name].winnerValue.x = 0-x;
	level.HoF[name].winnerValue.y = y;
	level.HoF[name].winnerValue.horzalign = "right";
	level.HoF[name].winnerValue.vertalign = vertalign;
	level.HoF[name].winnerValue.foreground = foreground;
	level.HoF[name].winnerValue.alpha = alpha;
	level.HoF[name].winnerValue.font = font;
	level.HoF[name].winnerValue.fontscale = fontscale; //min 1.4; max 4.6
	level.HoF[name].winnerValue.glowalpha = glowalpha;
	level.HoF[name].winnerValue.glowcolor = glowcolor; //(rot, grün, blau)
	level.HoF[name].winnerValue.label = &"";

	if(!isDefined(game["maprecords"]))
		game["maprecords"] = [];
			
	if(!isDefined(game["maprecords"][name]))
		game["maprecords"][name] = spawnStruct();
	
	if(!isDefined(game["maprecords"][name].value))		
		game["maprecords"][name].value = 0;
	
	if(!isDefined(game["maprecords"][name].player))
	game["maprecords"][name].player = " ";
	
	if(isDefined(player) || (isDefined(game["maprecords"]) && isDefined(game["maprecords"][name])))
	{
		level.HoF[name].winner.label = &"&&1";
		
		if(isDefined(player))
			level.HoF[name].winner SetPlayerNameString(player);
		else
			level.HoF[name].winner SetText(game["maprecords"][name].player);
			
		
		level.HoF[name].winner SetPulseFX(40, 22000, 200);	//(x,y,z) 1000 = 1 sec
		
		//wait 1;
		level.HoF[name].winnerValue SetPulseFX(40, 22000, 200);	//(x,y,z) 1000 = 1 sec

		switch(name)
		{
			case "killstreak":
			case "totalkills":
				level.HoF[name].winnerValue.label = &"&&1 kill(s)";
				
				if(isDefined(player))
					level.HoF[name].winnerValue SetValue(player.pers[name]);
				else
					level.HoF[name].winnerValue SetValue(game["maprecords"][name].value);
				
				break;
			
			case "totaldeaths":
				level.HoF[name].winnerValue.label = &"&&1 death(s)";
				
				if(isDefined(player))
					level.HoF[name].winnerValue SetValue(player.pers[name]);
				else
					level.HoF[name].winnerValue SetValue(game["maprecords"][name].value);
				
				break;
			
			case "kdratio":
				level.HoF[name].winnerValue.label = &"&&1 k(s)/d(s)";
				
				if(isDefined(player))
					level.HoF[name].winnerValue SetValue(player.pers[name]);
				else
					level.HoF[name].winnerValue SetValue(game["maprecords"][name].value);
				
				break;
			
			case "kingskilled":
				level.HoF[name].winnerValue.label = &"&&1 king(s)";
				
				if(isDefined(player))
					level.HoF[name].winnerValue SetValue(player.pers[name]);
				else
					level.HoF[name].winnerValue SetValue(game["maprecords"][name].value);
				
				break;
			
			case "kingkilltime":
			case "kingtime": 
				if(isDefined(player))
				{
					level.HoF[name].winnerValue.label = &"&&1 second(s)"; 
				
					if(player.pers[name] > 60)
					{
						player.pers[name] = int((player.pers[name]/60)*100)/100;
						helpstring = "" + player.pers[name] + "";
						helper = strTok(helpstring, ".");
		
						if(!isDefined(helper[1]))
							helper[1] = 0;
						else
							helper[1] = int((int(helper[1])*60)/100);

						player.pers[name] = "" + helper[0] + ":" + helper[1];
								
						level.HoF[name].winnerValue.label = &"&&1 minute(s)"; 
					}
					
					level.HoF[name].winnerValue SetText(player.pers[name]);
				}
				else
				{
					level.HoF[name].winnerValue.label = &"&&1 second(s)"; 
				
					if(game["maprecords"][name].value > 60)
					{
						game["maprecords"][name].value = int((game["maprecords"][name].value/60)*100)/100;
						helpstring = "" + game["maprecords"][name].value + "";
						helper = strTok(helpstring, ".");
		
						if(!isDefined(helper[1]))
							helper[1] = 0;
						else
							helper[1] = int((int(helper[1])*60)/100);

						game["maprecords"][name].value = "" + helper[0] + ":" + helper[1];
								
						level.HoF[name].winnerValue.label = &"&&1 minute(s)"; 
					}
					
					level.HoF[name].winnerValue SetText(game["maprecords"][name].value);
				}
				break;

			default: level.HoF[name].winnerValue.label = &""; break;
		}
		
		if(isDefined(player))
		{
			game["maprecords"][name].value = player.pers[name];
			game["maprecords"][name].player = player.name;
		}
	}
	
	if(isDefined(level.HoF[name].winner))
	{
		level.HoF[name].winnerValue thread HudFadeOutAndRemove(5, 1);
		level.HoF[name].winner thread HudFadeOutAndRemove(5, 1);
	}
}

getPlayerForRecord(type, order)
{
	if(isDefined(game["maprecords"]) && isDefined(game["maprecords"][type]))
		temp = int(game["maprecords"][type].value);
	else
	{
		if(order == "less")
			temp = 9999999;
		else
			temp = 0;
	}

	player = undefined;
	for(i=0;i<level.players.size;i++)
	{
		if((order == "more" && level.players[i].pers[type] >= temp) || (order == "less" && level.players[i].pers[type] > 0 && level.players[i].pers[type] <= temp))
		{
			temp = level.players[i].pers[type];
			player = level.players[i];
		}

	}

	/*if(!isDefined(player))
	{
		if(isDefined(level.players) && level.players.size > 0)
			player = level.players[randomInt(level.players.size)];
	}*/
	
	return player;	
}

HudFadeOutAndRemove(delay, fadeTime)
{
	self endon("death");

	if(delay > 0)
		wait delay;
	
	if(isDefined(self))
	{
		self fadeOverTime(fadeTime);
		self.alpha = 0;
	}

	if(fadeTime > 0)
		wait fadeTime;

	if(isDefined(self))
		self destroy();
}

getExistingRecordsFromFile()
{
	if(fs_testFile(level.mapRecordsFile))
	{
		file = openFile(level.mapRecordsFile, "read");
		
		if(file > 0)
		{
			game["maprecords"] = [];
			while(1)
			{
				value = fReadLn(file);
				
				if(!isDefined(value) || value == "" || value == " ")
					break;
				
				value = strToK(value, ";");
				
				game["maprecords"][value[0]] = spawnStruct();
				game["maprecords"][value[0]].value = int(value[1]);
				game["maprecords"][value[0]].player = value[2];
			}
		
			closeFile(file);
			
			if(isDefined(game["maprecords"]) && game["maprecords"].size <= 0)
				game["maprecords"] = undefined;
		}
	}
}

updateRecordsFile()
{
	if(!isDefined(game["maprecords"]))
		return;

	file = openFile(level.mapRecordsFile, "write");

	if(file > 0)
	{
		fPrintLn(file, "totalkills;" + game["maprecords"]["totalkills"].value + ";" + game["maprecords"]["totalkills"].player);
		fPrintLn(file, "totaldeaths;" + game["maprecords"]["totaldeaths"].value + ";" + game["maprecords"]["totaldeaths"].player);
		fPrintLn(file, "kdratio;" + game["maprecords"]["kdratio"].value + ";" + game["maprecords"]["kdratio"].player);
		fPrintLn(file, "killstreak;" + game["maprecords"]["killstreak"].value + ";" + game["maprecords"]["killstreak"].player);
		fPrintLn(file, "kingskilled;" + game["maprecords"]["kingskilled"].value + ";" + game["maprecords"]["kingskilled"].player);
		fPrintLn(file, "kingkilltime;" + game["maprecords"]["kingkilltime"].value + ";" + game["maprecords"]["kingkilltime"].player);
		fPrintLn(file, "kingtime;" + game["maprecords"]["kingtime"].value + ";" + game["maprecords"]["kingtime"].player);
			
		closeFile(file);
	}
}