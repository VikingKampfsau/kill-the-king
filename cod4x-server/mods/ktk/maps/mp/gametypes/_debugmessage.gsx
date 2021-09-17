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

printDebugMessage(message)
{
	//we don't need the "KTK DEBUG: " at the beginning - it's just for the case we save in games_mp.log
	if(getSubStr(message, 0, 9) == "KTK DEBUG")
		message = getSubStr(message, 11, message.size);

	if(!isDefined(level.ktk_debug_logfile))
		level.ktk_debug_logfile = "ktk_debug.log";

	if(fs_testFile(level.ktk_debug_logfile))
		file = openFile(level.ktk_debug_logfile, "append");
	else
		file = openFile(level.ktk_debug_logfile, "write");
		
	if(file > 0)
	{
		timeStamp = TimeToString(getRealTime(), 0, "%Y-%m-%d %H:%M:%S");

		fPrintLn(file, timeStamp + "\t" + message);
		closeFile(file);
	}
}

printSecurityMessage(message)
{
	//we don't need the "KTK DEBUG: " at the beginning - it's just for the case we save in games_mp.log
	if(getSubStr(message, 0, 9) == "KTK DEBUG")
		message = getSubStr(message, 11, message.size);

	if(!isDefined(level.ktk_security_logfile))
		level.ktk_security_logfile = "ktk_security.log";

	if(fs_testFile(level.ktk_security_logfile))
		file = openFile(level.ktk_security_logfile, "append");
	else
		file = openFile(level.ktk_security_logfile, "write");
		
	if(file > 0)
	{
		timeStamp = TimeToString(getRealTime(), 0, "%Y-%m-%d %H:%M:%S");

		fPrintLn(file, timeStamp + "\t" + message);
		closeFile(file);
	}
}

feedbackMessage(message)
{
	//we don't need the "KTK DEBUG: " at the beginning - it's just for the case we save in games_mp.log
	if(getSubStr(message, 0, 9) == "KTK DEBUG")
		message = getSubStr(message, 11, message.size);

	if(!isDefined(level.ktk_suggestion_logfile))
		level.ktk_suggestion_logfile = "ktk_suggestions.log";

	if(fs_testFile(level.ktk_suggestion_logfile))
		file = openFile(level.ktk_suggestion_logfile, "append");
	else
		file = openFile(level.ktk_suggestion_logfile, "write");
		
	if(file > 0)
	{
		timeStamp = TimeToString(getRealTime(), 0, "%Y-%m-%d %H:%M:%S");

		fPrintLn(file, timeStamp + "\t" + message);
		closeFile(file);
	}
}

bugMessage(message)
{
	//we don't need the "KTK DEBUG: " at the beginning - it's just for the case we save in games_mp.log
	if(getSubStr(message, 0, 9) == "KTK DEBUG")
		message = getSubStr(message, 11, message.size);

	if(!isDefined(level.ktk_bugs_logfile))
		level.ktk_bugs_logfile = "ktk_bugs.log";

	if(fs_testFile(level.ktk_bugs_logfile))
		file = openFile(level.ktk_bugs_logfile, "append");
	else
		file = openFile(level.ktk_bugs_logfile, "write");
		
	if(file > 0)
	{
		timeStamp = TimeToString(getRealTime(), 0, "%Y-%m-%d %H:%M:%S");

		fPrintLn(file, timeStamp + "\t" + message);
		closeFile(file);
	}
}