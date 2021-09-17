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

writeMuteFile(reason)
{
	self endon("disconnect");

	fileName = "/muted_players/" + self.guid /*self GetUniquePlayerID()*/ + ".muted";
	file = openFile(fileName, "write");

	if(file <= 0)
		return;

	timeStamp = TimeToString(getRealTime(), 0, "%Y-%m-%d %H:%M:%S");		
	fPrintLn(file, self.name + " muted on " + timeStamp);
	fPrintLn(file, "Reason: " + reason);
		
	if(file > 0)
		closeFile(file);
	
	scr_iprintlnbold("ACP_PLAYER_MUTED", self);
}

deleteMuteFile(guid)
{
	fileName = "/muted_players/" + guid + ".muted";
	FS_Remove(fileName);
}

isMutedOnThisServer()
{
	self endon("disconnect");
	
	return(fs_testFile("/muted_players/" + self.guid /*self GetUniquePlayerID()*/ + ".muted"));
}
