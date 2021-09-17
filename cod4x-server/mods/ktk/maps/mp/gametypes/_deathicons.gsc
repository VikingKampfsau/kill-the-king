init()
{
	if (!level.teambased)
		return;
	
	precacheShader("headicon_dead");

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);

		player.selfDeathIcons = []; // icons that other people see which point to this player when he's dead
	}
}

updateDeathIconsEnabled()
{
	//if (!self.enableDeathIcons)
	//	self removeOtherDeathIcons();
}

addDeathIcon( entity, dyingplayer, team, timeout )
{
	if(game["customEvent"] == "hideandseek")
		return;

	if ( !level.teambased )
		return;
	
	iconOrg = entity.origin;
	
	dyingplayer endon("spawned_player");
	dyingplayer endon("disconnect");
	
	wait .05;
	maps\mp\gametypes\_globallogic::WaitTillSlowProcessAllowed();
	
	assert(team == "allies" || team == "axis");
	
	if ( getDvar( "ui_hud_showdeathicons" ) == "0" )
		return;
	if ( level.hardcoreMode )
		return;
	
	if ( isdefined( self.lastDeathIcon ) )
		self.lastDeathIcon destroy();
	
	for(i=0;i<level.players.size;i++)
	{
		if(level.players[i].pers["team"] != team)
			continue;

		if(!isDefined(level.players[i].pers["enableDeathIcons"]) || !level.players[i].pers["enableDeathIcons"])
			continue;
			
		level.players[i].newdeathicon = NewClientHudElem(level.players[i]);
		level.players[i].newdeathicon.x = iconOrg[0];
		level.players[i].newdeathicon.y = iconOrg[1];
		level.players[i].newdeathicon.z = iconOrg[2] + 54;
		level.players[i].newdeathicon.alpha = .61;
		level.players[i].newdeathicon.archived = true;
		
		if ( level.splitscreen )
			level.players[i].newdeathicon setShader("headicon_dead", 14, 14);
		else
			level.players[i].newdeathicon setShader("headicon_dead", 7, 7);
		
		level.players[i].newdeathicon setwaypoint(true);
		
		self.lastDeathIcon = level.players[i].newdeathicon;
		
		level.players[i].newdeathicon thread destroySlowly ( timeout );
	}
}

destroySlowly( timeout )
{
	self endon("death");
	
	wait timeout;
	
	self fadeOverTime(1.0);
	self.alpha = 0;
	
	wait 1.0;
	self destroy();
}
