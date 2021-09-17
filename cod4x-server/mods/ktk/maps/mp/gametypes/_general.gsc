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

main()
{
	thread maps\mp\testclients::init();
	thread maps\mp\gametypes\_precache::precache();
	thread maps\mp\gametypes\_dvars::setDvars();
	thread maps\mp\gametypes\_throwingknife::init();
	thread maps\mp\gametypes\_huds::init();
	thread maps\mp\gametypes\_awards::init();
	thread maps\mp\gametypes\_announcer::init();
	thread maps\mp\gametypes\_admin::init();
	thread maps\mp\gametypes\_news::init();
	thread maps\mp\gametypes\_weaponbox::init();
	thread maps\mp\gametypes\_poison::init();
	thread maps\mp\gametypes\_rccar::init();
	thread maps\mp\gametypes\_ac130::init();
	thread maps\mp\gametypes\_manned_helicopter::init();
	thread maps\mp\gametypes\_tripwire::init();
	thread maps\mp\gametypes\_minigun::init();
	thread maps\mp\gametypes\_thermal::init();
	thread maps\mp\gametypes\_bans::init();
	thread maps\mp\gametypes\_vips::init();
	thread maps\mp\gametypes\_antiglitch::init();
	thread maps\mp\gametypes\_weaponloadouts::init();
	thread maps\mp\gametypes\_ah6::init();
	thread maps\mp\gametypes\_afk::init();
	thread maps\mp\gametypes\_nightvision::init();
	thread maps\mp\gametypes\_unlockables::init();
	thread maps\mp\gametypes\_spawnprotection::init();
	thread maps\mp\gametypes\_parachute_spawn::init();
	thread maps\mp\gametypes\_language::init();
	thread maps\mp\gametypes\_daynight::init();
	thread maps\mp\gametypes\_nuke::init();
	thread maps\mp\gametypes\_cleaner::init();
	thread maps\mp\gametypes\_carepackage::init();
	thread maps\mp\gametypes\_sentrygun::init();
	thread maps\mp\gametypes\_predator::init();
	thread maps\mp\gametypes\_javelin::init();
	thread maps\mp\gametypes\_mapvote::init();
	thread maps\mp\gametypes\_helipath::init();
	thread maps\mp\gametypes\_maprecords::init();
	thread maps\mp\gametypes\_ladders::init();
	thread maps\mp\gametypes\_rchelicopter::init();
	thread maps\mp\gametypes\_bots::init();
	thread maps\mp\gametypes\_escaperope::init();
	thread maps\mp\gametypes\_revolt::init();
	thread maps\mp\gametypes\_charactermenu::init();
	thread maps\mp\gametypes\_nanosuit::init();
	thread maps\mp\gametypes\_anti_dvardump::init();
	thread maps\mp\gametypes\_knifeassist::init();
	thread maps\mp\gametypes\_hostname::init();
	thread maps\mp\gametypes\_terror::init();
	thread maps\mp\gametypes\_props::init();
	thread maps\mp\gametypes\_votesystem::init();
	
	if(level.gametype == "ktk")
		thread maps\mp\gametypes\_gungame::init();
	else if(level.gametype == "ctc")
		thread maps\mp\gametypes\_nuke::init();
}