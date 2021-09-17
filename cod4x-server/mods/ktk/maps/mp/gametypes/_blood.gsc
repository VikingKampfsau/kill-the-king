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

blood_pool(victim, sWeapon, sMeansOfDeath)
{
	self notify("blood_instance");
	self endon("blood_instance");
	self endon("death");

	if(game["customEvent"] == "hideandseek")
		return;
	
	if(isPlayer(victim) && victim isTerminator())
		return;

	if(isDefined(victim.NukeKilled) && victim.NukeKilled)
		return;
		
	if(isDefined(sWeapon) && sWeapon == level.ktkWeapon["disruptor"])
		return;
		
	victim thread blood_screen(sMeansOfDeath, sWeapon);
	
	if(isDefined(self))
	{
		self waitTillNotMoving();
		
		if(isDefined(victim) && isDefined(self))
		{
			trace = BulletTrace(self.origin, self.origin - (0,0,1000), false, self);

			if(isDefined(trace["position"]))
				PlayFX(level._effect["bloodpool"], trace["position"]);
		}
	}
}

blood_splat( eInflictor, attacker, sMeansOfDeath, sHitLoc, sWeapon, vDir )
{
	self endon("disconnect");

	if(game["customEvent"] == "hideandseek")
		return;
	
	if(sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_EXPLOSIVE" || sMeansOfDeath == "MOD_GRENADE_SPLASH")
		return;

	if(self isTerminator())
		return;
	
	if(self.model == "body_complete_mp_skeleton")
		return;
	
	if(isDefined(sWeapon) && sWeapon == level.ktkWeapon["disruptor"])
		return;
	
	switch( sHitLoc )
	{
		case "helmet":
		case "head":
		case "neck":
				PlayFX(level._effect["bloodsplat_head"], self getTagOrigin("j_head"), vDir);
				break;
		case "torso_upper":
		case "right_arm_upper":
		case "left_arm_upper":
				if(self isDogModel())
					PlayFX(level._effect["bloodsplat_head"], self getTagOrigin("j_spine2"), vDir);
				else
					PlayFX(level._effect["bloodsplat_head"], self getTagOrigin("j_spine4"), vDir);
				
				PlayFX(level._effect["bloodsplat"], self.origin);
				break;
		case "torso_lower":
		case "right_leg_upper":
		case "left_leg_upper":			
				if(self isDogModel())
					PlayFX(level._effect["bloodsplat_head"], self getTagOrigin("j_spine2"), vDir);
				else
					PlayFX(level._effect["bloodsplat_head"], self getTagOrigin("pelvis"), vDir);

				PlayFX(level._effect["bloodsplat"], self.origin);
				break;
		case "right_leg_lower":
		case "left_leg_lower":
		case "right_foot":
		case "left_foot":
				PlayFX(level._effect["bloodsplat_large"], self.origin);
				break;
		case "right_arm_lower":
		case "left_arm_lower":
		case "right_hand":
		case "left_hand":
				PlayFX(level._effect["bloodsplat"], self.origin);
				break;
		case "gun":
				break;
		default:
				PlayFX( level._effect["bloodsplat"] , self.origin );		
				break;
	}
}

blood_screen(sMeansOfDeath, sWeapon)
{
	self endon("death");

	if(game["customEvent"] == "hideandseek")
		return;
	
	if((isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE") || (isDefined(sWeapon) && (sWeapon == level.ktkWeapon["knife"] || sWeapon == "defaultweapon_mp" || sWeapon == level.ktkWeapon["katana"])))
	{
		trigger = spawn("trigger_radius", self.origin, 0, 100, 100);
		
		for(i=0;i<level.players.size;i++)
		{
			if(isDefined(trigger) && level.players[i] isTouching(trigger))
				level.players[i] thread blood_stain();
		}

		trigger delete();
	}
}

blood_stain()
{
	self notify("bloody_screen");
	self endon("disconnect");
	self endon("bloody_screen");

	if(self isABot())
		return;
	
	if(self getKtkStat(2411) == 0)
		return;
	
	if(isDefined(self.bloodscreen))
		self.bloodscreen destroy();
	
	self.bloodscreen = NewClientHudElem(self);
	self.bloodscreen.alignX = "left";
	self.bloodscreen.alignY = "top";
	self.bloodscreen.x = 0;
	self.bloodscreen.y = 0;
	self.bloodscreen.horzAlign = "fullscreen";
	self.bloodscreen.vertAlign = "fullscreen";
	self.bloodscreen.foreground = true;
	self.bloodscreen.archived = true;
	self.bloodscreen setShader("bloodsplat_1", 640, 480);
	
	self.bloodscreen.alpha = 1;
	wait 2;
	self.bloodscreen FadeOverTime(3);
	self.bloodscreen.alpha = 0;
	wait 3;
	
	self.bloodscreen destroy();
}