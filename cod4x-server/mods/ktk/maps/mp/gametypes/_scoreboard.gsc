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
	setdvar("g_TeamName_" + game["defenders"], "^2Guardians");
	setdvar("g_TeamIcon_" + game["defenders"], "guards_logo");
	setdvar("g_TeamColor_" + game["defenders"], "0 0.8 0");
	setdvar("g_ScoresColor_" + game["defenders"], "0.1 0.8 0.1");

	if(isDefined(game["customEvent"]) && game["customEvent"] == "hideandseek")
	{
		setdvar("g_TeamName_" + game["defenders"], "^2Cursed Props");
		setdvar("g_TeamName_" + game["attackers"], "^1Seekers");
	}
	else if(isDefined(game["customEvent"]) && game["customEvent"] == "zombie")
		setdvar("g_TeamName_" + game["attackers"], "^1Undead Assassins");
	else if(isDefined(game["customEvent"]) && game["customEvent"] == "alien")
		setdvar("g_TeamName_" + game["attackers"], "^1Aliens");
	else
		setdvar("g_TeamName_" + game["attackers"], "^1Assassins");
	
	setdvar("g_TeamIcon_" + game["attackers"], "assassins_logo");
	setdvar("g_TeamColor_" + game["attackers"], "0.8 0 0");
	setdvar("g_ScoresColor_" + game["attackers"], "0.8 0.1 0.1");
	
	setdvar("g_ScoresColor_Spectator", ".25 .25 .25");
	setdvar("g_ScoresColor_Free", ".76 .78 .10");
	setdvar("g_teamColor_MyTeam", ".6 .8 .6" );
	setdvar("g_teamColor_EnemyTeam", "1 .45 .5" );
	
	//also overwrite the icons displayed on round end and intermission
	game["icons"][game["defenders"]] = "guards_logo";
	game["icons"][game["attackers"]] = "assassins_logo";
}