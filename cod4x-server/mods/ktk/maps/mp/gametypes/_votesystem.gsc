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
	level.KtKVotes = [];
	level.KtKVoters	= [];

	level.KtKVoting = false;

	level.KtKVoteStorage = "";
	level.KtKVoteInProgress = undefined;
}

startVote(player, type)
{
	if(!isDefined(type))
	{
		if(isDefined(player))
			exec("tell " + player.name + " ^1Invalide vote type - aborting!");
	
		return;
	}

	if(!level.ktkPlayerWaiter)
		return;
		
	if(!level.KtKVoting)
		return;

	if(isDefined(level.KtKVoteInProgress))
		return;

	switch(type)
	{
		case "map":
		case "mapvote":
		case "nextmap":
		case "rotatemap":
		case "switchmap":
			type = "mapvote";
			exec("say ^2Vote started^7: ^1" + type);
			exec("say ^7type: ^1$vote mapname ^7in chat!");
			break;
		
		case "mode":
		case "event":
		case "gametype":
		case "gamemode":
			type = "event";
			exec("say ^2Vote started^7: ^1" + type);
			exec("say ^7type: ^1$vote eventname ^7in chat!");
			break;
		
		default:
			if(isDefined(player))
				exec("tell " + player.name + " ^1Invalide vote type - aborting!");
			else
				exec("say ^1Invalide vote type - aborting!");
			return;
	}
	
	level.KtKVoteInProgress = type;
	
	time = level.mapvotetime*2;
	while(time >= 0)
	{
		time -= 1;
		wait 1;
	}
	
	winner = GetVoteWinner();
	
	if(isDefined(winner))
	{
		if(level.KtKVoteInProgress == "mapvote")
		{
			setDvar("sv_maprotation","gametype " + level.gametype + " map " + winner);
			setDvar("sv_maprotationcurrent", "gametype " + level.gametype + " map " + winner);
		}
		else if(level.KtKVoteInProgress == "event")
			setDvar("admin_changeEvent", winner);

		maps\mp\gametypes\_bots::updatePezbotMapList();
		wait 2;
		exitLevel(false);
	}

	level.KtKVoteInProgress = undefined;
}

castVote(player, argument)
{	
	if(!isDefined(level.KtKVoteInProgress))
		return;

	if(!isDefined(player))
		return;
		
	if(!isDefined(argument))
	{
		exec("tell " + player.name + " ^1Missing vote parameter!");
		return;
	}
		
	if(isInArray(level.KtKVoters, player))
	{
		exec("tell " + player.name + " ^1You can not vote twice!");
		return;
	}
	
	if(!isValideVote(argument))
	{
		if(level.KtKVoteInProgress == "mapvote")
			exec("tell " + player.name + " ^1This map is not available on this server!");
		else if(level.KtKVoteInProgress == "event")
			exec("tell " + player.name + " ^1This event is not available on this server!");

		return;
	}
	
	exec("tell " + player.name + " ^2Vote accepted!");
	
	level.KtKVoters[level.KtKVoters.size] = player;

	if(isDefined(level.KtKVotes[argument]))
		level.KtKVotes[argument].votes++;
	else
	{
		level.KtKVoteStorage = level.KtKVoteStorage + argument + ",";
	
		level.KtKVotes[argument] = spawnStruct();
		level.KtKVotes[argument].votes = 1;
	}
}

isValideVote(voteArgument)
{
	if(level.KtKVoteInProgress == "mapvote")
	{
		if(getDvarInt("scr_mod_mapvote") > 0)
			rotation = strTok(getDvar("rotation"), ";");
		else
		{
			rotation = strTok(getDvar("sv_maprotation"), " ");
			
			for(i=0;i<3;i++)
			{
				if(!isDefined(rotation) || rotation.size <= 0)
					break;
			
				if(i == 0)
					rotation = removeElementFromArray(rotation, "gametype");
				else if(i == 1)
					rotation = removeElementFromArray(rotation, level.gametype);
				else if(i == 2)
					rotation = removeElementFromArray(rotation, "map");
			}
		}

		if(isDefined(rotation) && rotation.size > 0)
		{
			if(isInArray(rotation, voteArgument))
				return true;
		}
		
		return false;
	}
	
	if(level.KtKVoteInProgress == "event")
	{
		events = strToK(getDvar("scr_mod_ktk_events"), ";");
		
		if(isDefined(events) && events.size > 0)
		{
			voteArgument = getEventNameFromShortcut(toLower(voteArgument));
		
			if(isInArray(events, voteArgument))
				return true;
		}
		
		return false;
	}
	
	return false;
}

GetVoteWinner()
{
	input = strToK(level.KtKVoteStorage, ",");

	if(!isDefined(input) || input.size <= 0)
		return;
		
	tempValue = 0;
	tempWinner = [];
	
	for(i=0;i<input.size;i++)
	{
		if(level.KtKVotes[input[i]].votes >= tempValue)
		{
			tempValue = level.KtKVotes[input[i]].votes;
		
			curEntry = tempWinner.size;
			tempWinner[curEntry] = spawnStruct();
			tempWinner[curEntry].name = input[i];
			tempWinner[curEntry].votes = tempValue;
		}
	}

	if(tempWinner.size > 0)
	{
		for(i=1;i<=3;i++)
		{
			if((tempWinner.size - i) >= 0)
				exec("say ^7" + i + ". " + tempWinner[tempWinner.size -i].name + " (^3" + tempWinner[tempWinner.size -i].votes +"^7)");
			else
				exec("say ^7" + i + ". ---");
		}
	
		wait 3;
	
		exec("say ^2Vote ended - ^3" + tempWinner[tempWinner.size -1].name + " ^2won!");
		return tempWinner[tempWinner.size -1].name;
	}
	
	exec("say ^1Vote ended - No votes cast!");
	return undefined;
}