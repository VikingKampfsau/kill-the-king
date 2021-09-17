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

collectPlayerData()
{
	self endon("disconnect");
	
	array = [];
	array["stats"] = [];
	
	array["player"] = spawnStruct();
	array["player"].entity = self;
	array["player"].name = self.name;
	array["player"].guid = self.guid;	

	//Stats:
	//- CoD4 Rank + Stats: 2301 - 2326; 2350 - 2355
	//- KtK Settings + Stats: 2356 - 2416; 2425 - 2479
	//- Challenges: 2521 - 2752	
	for(i=2301;i<=2752;i++)
	{
		if(i == 2327) i = 2350;
		else if(i == 2419) i = 2430;
		else if(i == 2480) i = 2521;
	
		entryNo = array["stats"].size;
		
		array["stats"][entryNo] = spawnStruct();
		array["stats"][entryNo].stat = i;
		array["stats"][entryNo].value = self getKtKStat(i);
	}

	thread writePlayerBackupFile(array);
}

writePlayerBackupFile(array)
{
	fileName = "/player_backups/" + array["player"].guid + ".ktk";
	
	if(fs_testFile(fileName))
	{	
		file = openFile(fileName, "read");

		if(file > 0)
		{
			curLineText = "";
			curLineInfo = [];
			while(isDefined(curLineText))
			{
				curLineText = fReadLn(file);
		
				if(isDefined(curLineText) && isSubStr(curLineText, ","))
					curLineInfo[curLineInfo.size] = strToK(curLineText, ",");
			}
	
			if(file > 0)
				closeFile(file);
	
			if(isDefined(array["player"].entity))
			{
				for(i=0;i<curLineInfo.size;i++)
				{
					if(int(curLineInfo[i][0]) != 2357)
						continue;

					if(array["player"].entity.pers["prestige"] < int(curLineInfo[i][1]))
					{
						scr_iPrintLnBold("PROFILE_BACKUP_ABORT_PRESTIGE", array["player"].entity);
						return;
					}
					else if(array["player"].entity.pers["prestige"] == int(curLineInfo[i][1]))
					{
						if(array["player"].entity.pers["rank"] < int(curLineInfo[i-1][1]))
						{
							scr_iPrintLnBold("PROFILE_BACKUP_ABORT_RANK", array["player"].entity);
							return;
						}
					}

					break;
				}
			}
		}
	}

	file = openFile(fileName, "write");

	if(file <= 0)
	{
		if(isDefined(array["player"].entity))
			scr_iPrintLnBold("PROFILE_BACKUP_ABORT_FILE", array["player"].entity);
			
		return;
	}

	timeStamp = TimeToString(getRealTime(), 0, "%Y-%m-%d %H:%M:%S");
		
	fPrintLn(file, "Profile backup for " + array["player"].name + " created on " + timeStamp);
		
	for(i=0;i<array["stats"].size;i++)
	{
		if(file <= 0)
		{
			if(isDefined(array["player"].entity))
				scr_iPrintLnBold("PROFILE_BACKUP_ABORT_FILE", array["player"].entity);
				
			return;
		}
		
		fPrintLn(file, array["stats"][i].stat + "," + array["stats"][i].value);
	}
		
	if(file > 0)
		closeFile(file);
	
	if(isDefined(array["player"].entity))
		scr_iPrintLnBold("PROFILE_BACKUP_CREATED", array["player"].entity);
}

loadPlayerBackupFile()
{
	self endon("disconnect");
	
	fileName = "/player_backups/" + self.guid + ".ktk";
	file = openFile(fileName, "read");
	
	if(file <= 0)
	{
		scr_iPrintLnBold("PROFILE_BACKUP_NOT_FOUND", self);
		return;
	}

	scr_iPrintLnBold("PROFILE_BACKUP_LOADING", self);

	curLineText = "";
	curLineInfo = [];
	while(isDefined(curLineText))
	{
		curLineText = fReadLn(file);
		
		if(isDefined(curLineText) && isSubStr(curLineText, ","))
			curLineInfo[curLineInfo.size] = strToK(curLineText, ",");
	}
	
	if(file > 0)
		closeFile(file);
	
	for(i=0;i<curLineInfo.size;i++)
	{
		if(int(curLineInfo[i][0]) != 2357)
			continue;

		if(self.pers["prestige"] > int(curLineInfo[i][1]))
		{
			scr_iPrintLnBold("PROFILE_BACKUP_ABORT_PRESTIGE2", self);
			return;
		}
		else if(self.pers["prestige"] == int(curLineInfo[i][1]))
		{
			if(self.pers["rank"] >= int(curLineInfo[i-1][1]))
			{
				scr_iPrintLnBold("PROFILE_BACKUP_ABORT_RANK2", self);
				return;
			}
		}

		break;
	}

	for(i=0;i<curLineInfo.size;i++)
	{
		if(i == int(curLineInfo.size*25/100)) self iPrintLnBold("MP_PERCENT", "25"); //self iPrintLnBold("^325% restored!");
		else if(i == int(curLineInfo.size*50/100)) self iPrintLnBold("MP_PERCENT", "50"); //self iPrintLnBold("^350% restored!");
		else if(i == int(curLineInfo.size*75/100)) self iPrintLnBold("MP_PERCENT", "75"); //self iPrintLnBold("^375% restored!"); 
	
		self setKtKStat(int(curLineInfo[i][0]), int(curLineInfo[i][1]));
		wait .05;
	}
	
	self.pers["participation"] = 0;
	self.pers["prestige"] = self maps\mp\gametypes\_rank::getPrestigeLevel();	
	self.pers["rankxp"] = self maps\mp\gametypes\_persistence::statGet("rankxp");
	self.pers["rank"] = self maps\mp\gametypes\_rank::getRankForXp(self.pers["rankxp"]);
	self setRank(self.pers["rank"], self.pers["prestige"]);
	
	for(i=0;i<self.pers["rank"];i++)
	{
		unlockedChallenge = self maps\mp\gametypes\_rank::getRankInfoUnlockChallenge(i);
		
		if(isDefined(unlockedChallenge) && unlockedChallenge != "")
			self maps\mp\gametypes\_rank::unlockChallenge(unlockedChallenge);
	}
	
	scr_iPrintLnBold("PROFILE_BACKUP_LOADED", self);
}