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
#include common_scripts\utility;
#include maps\mp\_utility;

#include maps\mp\gametypes\_misc;

init()
{
	fileName = "xmodellist.txt";
	level.availablePropModels = [];
	
	if(fs_testFile(fileName))
		FS_Remove(fileName);
	
	if(game["customEvent"] != "hideandseek")
		return;

	getXmodels();
	
	file = openFile(fileName, "read");

	if(file > 0)
	{
		while(1)
		{
			value = fReadLn(file);
			
			if(!isDefined(value))
				break;
			
			if(isAllowedPropsModel(value))
				level.availablePropModels[level.availablePropModels.size] = value;
				
			if(level.availablePropModels.size == 20)
				break;
		}
	
		closeFile(file);
	}
	else
	{
		iPrintLnBold("^1Failed to read " + fileName + "!");
		iPrintLnBold("^1Ending event!");
	}
	
	if(level.availablePropModels.size == 0)
	{
		setDvar("admin_changeEvent", "none");
		wait 2;
		exec("map_restart"); //map_restart(false); default CoD4 function is just a fast_restart -> Risk to result in a Server CMD overflow
	}
	else
	{
		for(i=0;i<level.availablePropModels.size;i++)
			precacheModel(level.availablePropModels[i]);
	
		if(level.availablePropModels.size < 20)
		{
			for(i=level.availablePropModels.size;i<=20;i++)
				level.availablePropModels[i] = "";
		}
	}
}

isAllowedPropsModel(modelName)
{
	if(modelName.size < 3)
		return false;

	if(int(GetSubStr(modelName, modelName.size - 1, modelName.size)) > 1)
		return false;
	
	if(isSubStr(modelName, "light"))
		return false;
	
	modelType = strToK(modelName, "_");
	
	if(isDefined(modelType) && isDefined(modelType[0]))
	{
		//disallowed models of type
		if(modelType[0] != "ch" && modelType[0] != "com" && modelType[0] != "foliage" && modelType[0] != "me" && modelType[0] != "mil" && modelType[0] != "vehicle")
			return false;

		//diallowed models by name
		switch(modelName)
		{
			case "ch_angle_support_brace": 
			case "ch_basement_door": 
			case "ch_bumper_car_st_wheel": 
			case "com_books3": 
			case "com_computer_mouse": 
			case "com_copypaper": 
			case "com_faucet01": 
			case "com_fire_bell": 
			case "com_french_bath_curtainrail": 
			case "com_french_bath_faucet": 
			case "com_french_bath_showerhead": 
			case "com_french_toiletseatcover": 
			case "com_french_toilettank": 
			case "com_gold_brick_case": 
			case "com_golden_brick": 
			case "com_greenhouse_sprinkler": 
			case "com_kitchen_faucet01": 
			case "com_milk_carton": 
			case "com_outdoor_switch": 
			case "com_restaurantkitchenvent": 
			case "com_soup_can": 
			case "com_wall_clock": 
			case "me_basket_rattan_lid": 
			case "me_basket_wicker_lid": 
			case "me_rebar02": 
			case "me_trash_line01": 
			case "me_trash_pile01": return false;
		}
		
		//disallowed models by name groups
		if(!isDefined(modelType[1]))
			return false;
		
		if(modelType[0] == "ch")
		{
			if(	isSubStr(modelName, "ch_apartment") ||
				isSubStr(modelName, "ch_banner") ||
				isSubStr(modelName, "ch_bell") ||
				isSubStr(modelName, "ch_bulletinpaperdecals") ||
				isSubStr(modelName, "ch_bunker") ||
				isSubStr(modelName, "ch_fence_plank") ||
				isSubStr(modelName, "ch_hydraulic_piston") ||
				isSubStr(modelName, "ch_icbm_consolemonitor") ||
				isSubStr(modelName, "ch_industrial_lamp") ||
				isSubStr(modelName, "ch_industrial_light") ||
				isSubStr(modelName, "ch_jeepride") ||
				isSubStr(modelName, "ch_railingpost") ||
				isSubStr(modelName, "ch_rubble") ||
				isSubStr(modelName, "ch_stair") ||
				isSubStr(modelName, "ch_wooden_fence"))
				return false;
		}
		else if(modelType[0] == "com")
		{
			if(	isSubStr(modelName, "com_airduct_s") ||
				isSubStr(modelName, "com_barrel_piece") ||
				isSubStr(modelName, "com_barrel_shard") ||
				isSubStr(modelName, "com_bottle1") ||
				isSubStr(modelName, "com_cellphone") ||
				isSubStr(modelName, "com_clipboard") ||
				isSubStr(modelName, "com_debris") ||
				isSubStr(modelName, "com_door") ||
				isSubStr(modelName, "com_electrical_pipe") ||
				isSubStr(modelName, "com_hub_cap") ||
				isSubStr(modelName, "com_night_beacon") ||
				isSubStr(modelName, "com_office_book") ||
				isSubStr(modelName, "com_plainchair_") ||
				isSubStr(modelName, "com_powerline_tower") ||
				isSubStr(modelName, "com_pipe") ||
				isSubStr(modelName, "com_prop_rail") ||
				isSubStr(modelName, "com_railpipe") ||
				isSubStr(modelName, "com_restaurantceilinglamp") ||
				isSubStr(modelName, "com_spotlightvehicle") ||
				isSubStr(modelName, "com_spray") ||
				isSubStr(modelName, "com_tin_") ||
				isSubStr(modelName, "com_vcr_tape") ||
				isSubStr(modelName, "com_window_frame"))
				return false;
		}
		else if(modelType[0] == "foliage")
		{
			if(modelType[1] != "bush" && modelType[1] != "tree")
				return false;
		}
		else if(modelType[0] == "me")
		{
			if(	isSubStr(modelName, "me_antenna") ||
				isSubStr(modelName, "me_balcony_railing") ||
				isSubStr(modelName, "me_banner") ||
				isSubStr(modelName, "me_brickwall") ||
				isSubStr(modelName, "me_cargocontainer") ||
				isSubStr(modelName, "me_chainlink_fence") ||
				isSubStr(modelName, "me_electricbox") ||
				isSubStr(modelName, "me_fruit") ||
				isSubStr(modelName, "me_picture"))
				return false;
		}
		else if(modelType[0] == "mil")
		{	
			if(	isSubStr(modelName, "mil_barbedwire") ||
				isSubStr(modelName, "mil_frame_charge") ||
				isSubStr(modelName, "mil_tntbomb"))
				return false;
		}
		else if(GetSubStr(modelName, 0, 8) == "vehicle_")
		{
			if(	isSubStr(modelName, "thermal") ||
			/*car parts*/
				isSubStr(modelName, "bumper") ||
				isSubStr(modelName, "door") ||
				isSubStr(modelName, "hood") ||
				isSubStr(modelName, "light") ||
				isSubStr(modelName, "mirror") ||
				isSubStr(modelName, "glas") ||
				isSubStr(modelName, "wheel") ||
			/*air vehicles - helicopters*/
				isSubStr(modelName, "apache") ||
				isSubStr(modelName, "blackhawk") ||
				isSubStr(modelName, "ch46e") ||
				isSubStr(modelName, "cobra") ||
				isSubStr(modelName, "mi-28") ||
				isSubStr(modelName, "mi17") ||
				isSubStr(modelName, "mi24") ||
			/*air vehicles - others*/
				isSubStr(modelName, "ac130") ||
				isSubStr(modelName, "camera") ||
				isSubStr(modelName, "harrier") ||
				isSubStr(modelName, "mig29") ||
				isSubStr(modelName, "mi17") ||
				isSubStr(modelName, "uav") ||
			/*ground vehicles - tanks*/
				isSubStr(modelName, "bmp") ||
				isSubStr(modelName, "bradley") ||
				isSubStr(modelName, "m1a1") ||
				isSubStr(modelName, "t72") ||
			/*ground vehicles - military cars*/
				isSubStr(modelName, "bm21") ||
				isSubStr(modelName, "humvee") ||
				isSubStr(modelName, "sa6") ||
				isSubStr(modelName, "semi") ||
				isSubStr(modelName, "slamram") ||
				isSubStr(modelName, "uaz") ||
				isSubStr(modelName, "zpu4") ||
			/*ground vehicles - civilian*/
				isSubStr(modelName, "bulldozer") ||
				isSubStr(modelName, "bus") ||
				isSubStr(modelName, "luxurysedan") ||
				isSubStr(modelName, "pickup") ||
				isSubStr(modelName, "truck") ||
				isSubStr(modelName, "tanker") ||
				isSubStr(modelName, "tractor"))
				return false;
		}
	}
	
	return true;
}

sendPropslistToPlayer()
{
	wait 1;

	self setClientDvars(
		"prop_1", getPropsNameFromModelName(level.availablePropModels[0]),
		"prop_2", getPropsNameFromModelName(level.availablePropModels[1]),
		"prop_3", getPropsNameFromModelName(level.availablePropModels[2]),
		"prop_4", getPropsNameFromModelName(level.availablePropModels[3]),
		"prop_5", getPropsNameFromModelName(level.availablePropModels[4]),
		"prop_6", getPropsNameFromModelName(level.availablePropModels[5]),
		"prop_7", getPropsNameFromModelName(level.availablePropModels[6]),
		"prop_8", getPropsNameFromModelName(level.availablePropModels[7]),
		"prop_9", getPropsNameFromModelName(level.availablePropModels[8]),
		"prop_10", getPropsNameFromModelName(level.availablePropModels[9]),
		"prop_11", getPropsNameFromModelName(level.availablePropModels[10]),
		"prop_12", getPropsNameFromModelName(level.availablePropModels[11]),
		"prop_13", getPropsNameFromModelName(level.availablePropModels[12]),
		"prop_14", getPropsNameFromModelName(level.availablePropModels[13]),
		"prop_15", getPropsNameFromModelName(level.availablePropModels[14]),
		"prop_16", getPropsNameFromModelName(level.availablePropModels[15]),
		"prop_17", getPropsNameFromModelName(level.availablePropModels[16]),
		"prop_18", getPropsNameFromModelName(level.availablePropModels[17]),
		"prop_19", getPropsNameFromModelName(level.availablePropModels[18]),
		"prop_20", getPropsNameFromModelName(level.availablePropModels[19]));

}

getPropsNameFromModelName(modelName)
{
	propsName = "";
	array = StrToK(modelName, "_");

	for(i=1;i<array.size;i++)
	{
		if(array[i].size < 3)
			return propsName;
			
		propsName = propsName + FirstLetterToUpper(array[i]) + " ";
	}
	
	return propsName;
}

attachPropModelToPlayer()
{
	self endon("disconnect");
	self endon("death");

	self notify("props_model_changed");
	
	self detachAll();
	self SetModel("fake_player");
	
	if(self getKtkStat(2480) > 19)
		self setKtkStat(2480, 19);
	
	if(isDefined(self.propsModel))
	{
		self.propsModel notify("prop_removed");
		self.propsModel delete();
	}

	self.propsModel = spawn("script_model", self.origin);
	self.propsModel.angles = self.angles;
	self.propsModel.owner = self;
	self.propsModel linkTo(self);
	self.propsModel SetModel(level.availablePropModels[self getKtkStat(2480)]);
	self.propsModel thread monitorPropsDamage();
	
	self thread monitorPropsRotation();
}

monitorPropsRotation()
{
	level endon("game_ended");
	
	self endon("disconnect");
	self endon("death");

	self endon("props_model_changed");
	
	rotationType = 0;
	degrees = 5;
	while(1)
	{
		wait .05;
		
		if(!isDefined(self.propsModel))
			continue;
		
		if(self secondaryOffhandButtonPressed())
		{
			self.propsModel unlink();
			
			if(!rotationType)
				self.propsModel.angles -= (degrees, 0, 0);
			else
				self.propsModel.angles += (degrees, 0, 0);
			
			//self iPrintLnBold(self.propsModel.angles[0]);
			
			self.propsModel.origin = self.origin;
			self.propsModel linkTo(self);
			continue;
		}
		
		if(self leanLeftButtonPressed())
		{
			self.propsModel unlink();
			
			if(!rotationType)
				self.propsModel.angles -= (0, degrees, 0);
			else
				self.propsModel.angles += (0, degrees, 0);
			
			//self iPrintLnBold(self.propsModel.angles[1]);
			
			self.propsModel.origin = self.origin;
			self.propsModel linkTo(self);
			continue;
		}
		
		if(self leanRightButtonPressed())
		{
			self.propsModel unlink();
			
			if(self.propsModel.angles[2] <= -45 || self.propsModel.angles[2] >= 45)
				continue;
			
			if(!rotationType)
				self.propsModel.angles -= (0, 0, degrees);
			else
				self.propsModel.angles += (0, 0, degrees);
			
			//self iPrintLnBold(self.propsModel.angles[2]);
			
			self.propsModel.origin = self.origin;
			self.propsModel linkTo(self);
			continue;
		}
		
		//auto rotate - get the angles of the ground at the current position
		if(self fragButtonPressed())
		{
			if(self isOnGround())
			{
				ground = self maps\mp\_utility::getPlant();
			
				self.propsModel unlink();
				self.propsModel.angles = ground.angles;
				self.propsModel.origin = ground.origin;
				self.propsModel linkTo(self);
			}
			
			while(self fragButtonPressed())
				wait .05;
			
			continue;
		}
		
		//reset rotation
		if(self attackButtonPressed())
		{
			self.propsModel unlink();
			self.propsModel.angles = self.angles;
			self.propsModel.origin = self.origin;
			self.propsModel linkTo(self);
		
			while(self attackButtonPressed())
				wait .05;
			
			continue;
		}
		
		if(self useButtonPressed())
		{
			while(self useButtonPressed())
				wait .05;
			
			rotationType = !rotationType;
			scr_iPrintLnBold("PROPS_ROTATION_DIRECTION_CHANGED", self);
			
			continue;
		}
	}
}

monitorPropsDamage()
{
	self endon("prop_removed");

	self setCanDamage(true);
	self.health = 1;

	while(1)
	{
		self waittill("damage", damage, attacker, vDir, vPoint, sMeansOfDeath);

		iPrintLnBold(attacker.name);

		if(isPlayer(attacker) && attacker isAGuard())
			continue;

		attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
		
		if(isDefined(self))
		{
			if(isDefined(self.owner))
				self.owner ktkFinishPlayerDamage(attacker, attacker, self.owner.health, 0, "MOD_SUICIDE", attacker getCurrentWeapon(), attacker.origin, VectorToAngles(self.owner.origin - attacker.origin), "none", 0);
			else
			{
				attacker maps\mp\gametypes\_rank::giveRankXP( "kill", 150 );
				self delete();
			}
		}
			
		break;
	}
}

teleportSeekerAway()
{
	self endon("disconnect");
	self endon("death");
	
	if(isDefined(self.propsModel))
	{
		self.propsModel notify("prop_removed");
		self.propsModel delete();
	}
	
	if(level.ktkPlayerWaiter)
		return;
	
	if(level.roundstarted)
		return;
	
	oldOrigin = self.origin;
	
	ent = spawn("script_model", self.origin);
	ent.origin = self.origin + (0, 0, 100000);
	
	self setOrigin(ent.origin);
	self linkTo(ent);
	
	while(!level.roundstarted)
		wait .1;
		
	self setOrigin(oldOrigin);
	self unlink();
}