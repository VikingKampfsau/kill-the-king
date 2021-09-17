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

init()
{
	addScriptCommand("bug", 1);
	addScriptCommand("bugs", 1);

	addScriptCommand("suggest", 1);
	addScriptCommand("suggestion", 1);
	
	addScriptCommand("myguid", 1);
	
	addScriptCommand("vote", 1);
}

Callback_ScriptCommand(command, arguments)
{
	waittillframeend;

	//if self is defined it was called by a player -  else with rcon
	if(isDefined(self))
		caller = " (" + self.name + ";" + self.guid + ")";
	else
		caller = " (rcon)";

	switch(command)
	{
		case "bug":
		case "bugs": maps\mp\gametypes\_misc::DebugMessage(3, arguments + caller); break;

		case "suggest":
		case "suggestion": maps\mp\gametypes\_misc::DebugMessage(2, arguments + caller); break;
		
		case "myguid": exec("tell " + self.name + " Your GUID: " + self.guid); break;
		
		case "vote":
			input = strToK(arguments, " ");
			
			if(!isDefined(level.KtKVoteInProgress))
				maps\mp\gametypes\_votesystem::startVote(self, input[0]);
			else
				maps\mp\gametypes\_votesystem::castVote(self, input[0]);
			
			break;
		
		default: break;
	}
}