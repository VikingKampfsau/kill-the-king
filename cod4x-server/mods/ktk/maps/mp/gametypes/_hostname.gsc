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
	//Change this to whatever character you like.
	level.hostnameSeperator = "|";

	if(level.hostnameSeperator.size > 1)
		return;

	if(level.gametype == "ktk")
	{
		if(isDefined(level.roundLimit) && level.roundLimit > 0)
		{
			curRound = (game["roundsplayed"]+1);
			setDvar("sv_hostname", getOriginalHostname() + " " + level.hostnameSeperator + " Round: " + curRound + "/" + level.roundLimit + " ^7Event: ^3" + getEventName(game["customEvent"]));
		}
		else
		{
			setDvar("sv_hostname", getOriginalHostname() + " " + level.hostnameSeperator + " Round: " + 1 + "/" + 1 + " ^7Event: ^3" + getEventName(game["customEvent"]));
		}
	}
}
 
getOriginalHostname()
{
	hostname = GetDvar("sv_hostname");

	if(isSubStr(hostname, " Round: "))
	{
		hostnameParts = strToK(hostname, level.hostnameSeperator);

		hostname = "";
		for(i=0;i<(hostnameParts.size-1);i++)
			hostname = hostname + hostnameParts[i] + level.hostnameSeperator;
	}
	
	if(hostname != "")
	{
		while(hostname.size > 1 && (getSubStr(hostname, hostname.size - 1, hostname.size) == " " || getSubStr(hostname, hostname.size - 1, hostname.size) == level.hostnameSeperator))
			hostname = getSubStr(hostname, 0, hostname.size - 1);
	}

	return hostname;
}