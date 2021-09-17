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
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_misc;

init(attacker, victim, sWeapon, sMeansofDeath, predelay, psOffsetTime, eInflictor, thirdPerson)
{
	if(getdvar("scr_finalkillcam_time") == "") setdvar("scr_finalkillcam_time", 10);
	if(getdvar("scr_finalkillcam_posttime") == "") setdvar("scr_finalkillcam_posttime", 2);

	level waittill("play_finalcam");

	if(!isDefined(attacker))
		return;
	
	level.finalcamplaying = true;
	setDvar("finalcamplaying", 1);

	attackerNum = attacker getEntityNumber();
	killcamentity = -1;
	
	//we only want the killcam to follow the eInflictor in special cases
	if(isDefined(eInflictor))
	{
		//if it's a carepackage
		if(isDefined(eInflictor.type) && (eInflictor.type == "trappackage" || eInflictor.type == "carepackage"))
			killcamentity = eInflictor getEntityNumber();

		//if it's a javelin missile
		if(isDefined(eInflictor.type) && eInflictor.type == "javelin_missile")
			killcamentity = eInflictor getEntityNumber();
	}
	
	perks = thread maps\mp\gametypes\_globallogic::getPerks( attacker );
	attacker thread maps\mp\gametypes\_missions::FinalKill(sMeansofDeath, sWeapon);
	
	thread slowmotion();
	
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].killstreak_hud)) level.players[i].killstreak_hud destroy();
		if(isDefined(level.players[i].kdhud)) level.players[i].kdhud destroy();
	
		if(level.players[i] isABot())
			continue;
	
		level.players[i] thread DoKillcam( attackerNum, killcamentity, sWeapon, sMeansofDeath, predelay, psOffsetTime, 0, undefined, perks, attacker, victim, thirdPerson);
		level.players[i] thread maps\mp\gametypes\_huds::showAttackerName(attacker);
	}
}

DoKillcam(
	attackerNum, // entity number of the attacker
	killcamentity, // entity number of the attacker's killer entity aka helicopter or airstrike
	sWeapon,	// killing weapon
	sMeansofDeath,	// type of death
	predelay, // time between player death and beginning of killcam
	offsetTime, // something to do with how far back in time the killer was seeing the world when he made the kill; latency related, sorta
	respawn, // will the player be allowed to respawn after the killcam?
	maxtime, // time remaining until map ends; the killcam will never last longer than this. undefined = no limit
	perks, // the perks the attacker had at the time of the kill
	attacker, // entity object of attacker
	victim, // entity object of victim
	thirdPerson // play the cam in third person
)
{
	self endon("disconnect");
	level endon("game_ended");

	if(attackerNum < 0)
		return;

	//end any running killcam
	self notify("end_killcam");
		
	self.sessionstate = "dead";
	
	// length from killcam start to killcam end
	if (getdvar("scr_finalkillcam_time") == "")
	{
		if (sWeapon == "artillery_mp")
			camtime = 1.3;
		else if ( !respawn ) // if we're not going to respawn, we can take more time to watch what happened
			camtime = 5.0;
		else if (sWeapon == level.ktkWeapon["throwingKnife"])
			camtime = 4.5; // show long enough to see grenade thrown
		else
			camtime = 2.5;
	}
	else
		camtime = getdvarfloat("scr_finalkillcam_time");
	
	if (isdefined(maxtime)) {
		if (camtime > maxtime)
			camtime = maxtime;
		if (camtime < .05)
			camtime = .05;
	}
	
	// time after player death that killcam continues for
	if (getdvar("scr_finalkillcam_posttime") == "")
		postdelay = 2;
	else {
		postdelay = getdvarfloat("scr_finalkillcam_posttime");
		if (postdelay < 0.05)
			postdelay = 0.05;
	}
	
	killcamlength = camtime + postdelay;
	
	// don't let the killcam last past the end of the round.
	if (isdefined(maxtime) && killcamlength > maxtime)
	{
		// first trim postdelay down to a minimum of 1 second.
		// if that doesn't make it short enough, trim camtime down to a minimum of 1 second.
		// if that's still not short enough, cancel the killcam.
		if (maxtime < 2)
			return;

		if (maxtime - camtime >= 1) {
			// reduce postdelay so killcam ends at end of match
			postdelay = maxtime - camtime;
		}
		else {
			// distribute remaining time over postdelay and camtime
			postdelay = 1;
			camtime = maxtime - 1;
		}
		
		// recalc killcamlength
		killcamlength = camtime + postdelay;
	}

	killcamoffset = camtime + predelay;
	
	self notify ( "begin_killcam", getTime() );
	
	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.killcamentity = killcamentity;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = offsetTime;

	// ignore spectate permissions
	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", true);
	self allowSpectateTeam("none", true);
	
	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	if ( self.archivetime <= predelay ) // if we're not looking back in time far enough to even see the death, cancel
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		
		return;
	}
	
	self.killcam = true;
	
	// KILL THE KING
	//->
	self.wasInKillcam = true;
	self.killcamInThirdPerson = thirdperson;

	if(attacker isDog())
	{
		/*
		self setClientDvars("cg_thirdperson", 1,
							"ammoCounterHide", 1,
							"cg_drawgun", 0,
							"cg_fovmin", 95);	
		*/
		
		self.killcamInThirdPerson = true;
	}
	else
	{
		/*
		thirdperson = false;

		if(sWeapon == level.ktkWeapon["rccar"])
			thirdperson = true;

		self setClientDvars("ammoCounterHide", 0,
							"cg_drawgun", 1,
							"cg_fovmin", 10,
							"cg_thirdperson", thirdperson);
		*/
		
		if(sWeapon == level.ktkWeapon["rccar"])
			self.killcamInThirdPerson = true;
	}
	
	self setClientDvar("cg_thirdperson", self.killcamInThirdPerson);
	
	/*if(self isDog())
	{
		if(isDefined(self.pers["dogthirdperson"]) && self.pers["dogthirdperson"])
		{
			if(!self.killcamInThirdPerson)
				self setClientDvar("cg_thirdperson", 0);
		}
		else
		{
			if(self.killcamInThirdPerson)
				self setClientDvar("cg_thirdperson", 1);
		}
	}
	else
	{
		if(isDefined(self.pers["thirdperson"]) && self.pers["thirdperson"])
		{
			if(!self.killcamInThirdPerson)
				self setClientDvar("cg_thirdperson", 0);
		}
		else
		{
			if(self.killcamInThirdPerson)
				self setClientDvar("cg_thirdperson", 1);
		}
	}*/
	//<-
	
	self thread spawnedKillcamCleanup();
	self thread endedKillcamCleanup();
	self thread waitKillcamTime();

	self waittill("end_killcam");

	self endKillcam();

	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
}

waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_killcam");

	wait (getdvarfloat("scr_finalkillcam_time"));

	self notify("end_killcam");
}

endKillcam()
{
	self maps\mp\gametypes\_killcam::endKillcam();

	level.finalcamplaying = false;
	
	setDvar("finalcamplaying", 0);
}

spawnedKillcamCleanup()
{
	self endon("end_killcam");
	self endon("disconnect");

	self waittill("spawned");
	self endKillcam();
}

endedKillcamCleanup()
{
	self endon("end_killcam");
	self endon("disconnect");

	level waittill("game_ended");
	self endKillcam();
}

slowmotion()
{
	// this is the slowmotion of the kill
	wait getdvarfloat("scr_finalkillcam_time")*0.5;
		setDvar("timescale", "0.55");
	wait (getdvarfloat("scr_finalkillcam_time")*0.5);
		setDvar("timescale", "1");
}