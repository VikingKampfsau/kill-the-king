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

sniffForEnemies()
{
	self endon("disconnect");
	self endon("death");
	
	while(1)
	{
		wait .05;
		
		if(isDefined(self.lowerMessage))
		{
			self.lowerMessage.label = self GetLocalizedString("DOG_SNIFF_ENEMY"); //&"Press ^3[{+activate}] ^7to sniff for enemies.";
			self.lowerMessage.alpha = 1;
			self.lowerMessage FadeOverTime(0.05);
			self.lowerMessage.alpha = 0;
		}
	
		if(self useButtonPressed())
		{
			for(i=0;i<level.players.size;i++)
			{
				if(level.players[i] == self)
					continue;

				if(!isAlive(level.players[i]))
					continue;
					
				if(level.players[i].pers["team"] != game["defenders"])
					continue;
					
				if(Distance(self.origin, level.players[i].origin) > (450*(self.cur_kill_streak-2)))
					continue;
			
				self thread MarkSniffedEnemy(level._effect["dog_sniffed"], level.players[i]);
			}
			
			while(self useButtonPressed())
				wait .05;
		}
	}
}

//the following scripts are already prepared for the use of multiple "dogs"
MarkSniffedEnemy(effectID, target)
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(target.dogsniff_Markers) && target.dogsniff_Markers)
	{
		for(i=0;i<target.dogsniff_EffectLink.size;i++)
			target.dogsniff_EffectLink[i] thread StorePlayerInVisibleArray(self);
	}
	else
	{
		target.dogsniff_Markers = true;
	
		target.dogsniff_EffectLink = [];
		target.dogsniff_EffectLink[0] = CreateEffectLink(target, "j_mainroot");
		target.dogsniff_EffectLink[1] = CreateEffectLink(target, "j_spineupper");
		//target.dogsniff_EffectLink[2] = CreateEffectLink(target, "j_head");
		
		for(i=0;i<target.dogsniff_EffectLink.size;i++)
		{
			target.dogsniff_EffectLink[i].visibleFor = [];

			target.dogsniff_EffectLink[i] thread StorePlayerInVisibleArray(self);		
			target.dogsniff_EffectLink[i] thread UpdateVisibleStatusOnDeath(self, target, effectID);
			target.dogsniff_EffectLink[i] thread UpdateVisibleStatusOnDeath(target, target, effectID);
			target.dogsniff_EffectLink[i] linkTo(target, target.dogsniff_EffectLink[i].target);	
			wait .05;
			PlayFXOnTag(effectID, target.dogsniff_EffectLink[i], "tag_origin");
		}
	}
}

CreateEffectLink(target, tag)
{
	linker = spawn("script_model", target getTagOrigin(tag));
	linker setModel("tag_origin");
	linker.target = tag;
	
	return linker;
}

StorePlayerInVisibleArray(player, string)
{
	self endon("death");

	self hide();
	
	if(!self.visibleFor.size)
		self.visibleFor[0] = player;
	else
	{
		for(i=0;i<=self.visibleFor.size;i++)
		{
			if(isDefined(self.visibleFor[i]) && self.visibleFor[i] == player)
				break;
			
			if(!isDefined(self.visibleFor[i]) || !isPlayer(self.visibleFor[i]))
			{
				self.visibleFor[i] = player;
				break;
			}
		}
	}
	
	for(i=0;i<=self.visibleFor.size;i++)
	{
		if(isDefined(self.visibleFor[i]) && isPlayer(self.visibleFor[i]))
			self showToPlayer(self.visibleFor[i]);
	}
}


UpdateVisibleStatusOnDeath(player, target, effectID)
{
	self endon("death");

	while(isDefined(player) && isAlive(player))
		wait .1;

	if(!isDefined(player) || player == target)
	{
		if(isDefined(player))
			player.dogsniff_Markers = false;
		
		self delete();
	}
	else
	{
		self hide();
	
		for(i=0;i<self.visibleFor.size;i++)
		{
			if(isDefined(self.visibleFor[i]) && isPlayer(self.visibleFor[i]))
			{
				if(self.visibleFor[i] == player)
					self.visibleFor[i] = undefined;
				else
					self showToPlayer(self.visibleFor[i]);
			}
		}
		
		wait .05;
		PlayFXOnTag(effectID, self, "tag_origin");
	}
}