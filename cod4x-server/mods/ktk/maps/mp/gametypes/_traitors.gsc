// https://en.wikipedia.org/wiki/Trouble_in_Terrorist_Town

#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

getAlivePlayersInTraitorEvent(team)
{
	amount = 0;
	for(i=0;i<level.players.size;i++)
	{
		if(!isAlive(level.players[i]))
			continue;
	
		if(team == "traitors")
		{
			if(isDefined(level.players[i].isATraitor) && level.players[i].isATraitor)
				amount++;
		}
		else
		{
			if(isDefined(level.players[i].isAnInnocent) && level.players[i].isAnInnocent)
				amount++;
		}
	}

	return amount;
}

monitorTraitorEventEnd()
{
	level endon("game_ended");
	
	while(!level.roundStarted)
		wait .05;
	
	traitors = 0;
	innocents = 0;
	
	while(1)
	{
		wait .05;

		traitors = getAlivePlayersInTraitorEvent("traitors");
		innocents = getAlivePlayersInTraitorEvent("innocents");
		
		if(traitors == 0)
		{
			thread maps\mp\gametypes\ktk::onEndGame("innocents", "TRAITORS_ELIMINATED", undefined);
			break;
		}
		
		if(innocents == 0)
		{
			thread maps\mp\gametypes\ktk::onEndGame("traitors", "INNOCENTS_ELIMINATED", undefined);
			break;
		}
	}
}

endRoundText(winner, endReasonText)
{
	self endon ( "disconnect" );
	self notify ( "reset_outcome" );

	// wait for notifies to finish
	while ( self.doingNotify )
		wait 0.05;

	self endon ( "reset_outcome" );
	
	if ( level.splitscreen )
	{
		titleSize = 2.0;
		textSize = 1.5;
		spacing = 10;
		font = "default";
	}
	else
	{
		titleSize = 3.0;
		textSize = 2.0;
		spacing = 10;
		font = "objective";
	}

	duration = 60000;

	outcomeTitle = createFontString( font, titleSize );
	outcomeTitle setPoint( "TOP", undefined, 0, 30 );
	outcomeTitle.glowAlpha = 1;
	outcomeTitle.hideWhenInMenu = false;
	outcomeTitle.archived = false;

	outcomeText = createFontString( font, textSize );
	outcomeText setParent( outcomeTitle );
	outcomeText setPoint( "TOP", "BOTTOM", 0, 30 - spacing );
	outcomeText.glowAlpha = 1;
	outcomeText.hideWhenInMenu = false;
	outcomeText.archived = false;

	if(winner == "traitors")
	{
		if(isDefined(self.isATraitor) && self.isATraitor)
		{
			outcomeTitle.color = (0.6, 0.9, 0.6);
			outcomeTitle setText( game["strings"]["round_win"] );
		}
		else
		{
			outcomeTitle.glowColor = (0, 0, 0);
			outcomeTitle setText( game["strings"]["round_loss"] );
		}
	}
	else
	{
		if(isDefined(self.isATraitor) && self.isATraitor)
		{
			outcomeTitle.glowColor = (0, 0, 0);
			outcomeTitle setText( game["strings"]["round_loss"] );
		}
		else
		{
			outcomeTitle.color = (0.6, 0.9, 0.6);
			outcomeTitle setText( game["strings"]["round_win"] );
		}
	}
	
	outcomeTitle.glowColor = (0, 0, 0);
	
	outcomeText.glowColor = (0.2, 0.3, 0.7);
	outcomeText setText( endReasonText );
	
	outcomeTitle setPulseFX( 100, duration, 1000 );
	outcomeText setPulseFX( 100, duration, 1000 );
	
	self thread resetTeamOutcomeNotify( outcomeTitle, outcomeText, undefined, undefined, undefined, undefined, undefined );
}