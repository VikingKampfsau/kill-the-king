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
	level.bannedplayers = [];
	
	for(index=1; getDvar("scr_mod_banned_" + index) != ""; index++)
	{ 
		string = strTok(getDvar("scr_mod_banned_" + index ), ":");
		
		if(string.size <= 3)
			level.bannedplayers[level.bannedplayers.size] = string;
	}  
	
	thread onPlayerConnected(); 
}

onPlayerConnected()
{ 
	for(;;) 
	{ 
		level waittill("connected", player); 
		
		player thread isBanned();
		player thread isMuted();
	} 
} 
 
isBanned() 
{ 
	self endon("disconnect");
	
	if(self isABot())
		return;
	
	for(i=0;i<level.bannedplayers.size;i++)
	{ 
		if(self.guid /*self GetUniquePlayerID()*/ == level.bannedplayers[i][0])
		{
			exec("kick " + self getEntityNumber() + " you are banned from this server!");
			break; 
		} 
	}
}

isMuted()
{
	self endon("disconnect");
	
	if(self maps\mp\gametypes\_mute::isMutedOnThisServer())
	{
		if(!isPlayerChatMuted(self))
			mutePlayerChat(self, 1);
	}
}