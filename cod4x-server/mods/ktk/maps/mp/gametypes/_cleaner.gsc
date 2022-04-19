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
	thread DeleteTurrets();
	thread ReplaceBarrels();
	thread ReplaceCars();
	thread NoDogOnMap();
	thread NoTerminatorOnMap();
	thread DisableHardpointsOnMap();
	thread replaceBombZoneModels();

	entities = getEntArray();

	for(i=0;i<entities.size;i++)
	{
		if(isDefined(entities[i].classname))
		{
			type = entities[i].classname;
		
			if(isSubStr(type, "mp_ctf_spawn") || isSubStr(type, "mp_dm_spawn") || isSubStr(type, "mp_dom_spawn") || isSubStr(type, "mp_sab_spawn") || isSubStr(type, "mp_sd_spawn"))
				entities[i] delete();
				
			if(isSubStr(type, "weapon_") && isSubStr(type, "_mp") && getDvarInt("scr_map_weaponpickups") == 0)
				entities[i] delete();
		}
	}
}

DeleteTurrets()
{
	if(getDvarInt("scr_mod_turrets") == 1)
		return;

	turret = getentarray("misc_turret", "classname");
	for(i=0;i<turret.size;i++) turret[i] delete();
}

ReplaceCars()
{
	if(getDvarInt("scr_mod_explosive_cars") == 1 && game["customEvent"] != "hideandseek")
		return;

	exploding_cars = getEntArray("destructible", "targetname");

	for(i=0;i<exploding_cars.size;i++)
	{
		//i dont think we need to precache the model again
		//this should already happen through map compiling
		//PrecacheModel(exploding_cars[i].model);
		
		car[i] = Spawn("script_model", exploding_cars[i].origin);
		car[i] SetModel(exploding_cars[i].model);
		car[i].angles = exploding_cars[i].angles;
		exploding_cars[i] delete();
	}
}

ReplaceBarrels()
{
	if(getDvarInt("scr_mod_explosive_barrels") == 1 && game["customEvent"] != "hideandseek")
		return;

	oil_spills = getEntArray("oil_spill", "targetname");
	exploding_barrels = getEntArray ("explodable_barrel", "targetname");

	for(i=0;i<oil_spills.size;i++)
		oil_spills[i] delete();
	
	for(i=0;i<exploding_barrels.size;i++)
	{
		//i dont think we need to precache the model again
		//this should already happen through map compiling
		//PrecacheModel(exploding_barrels[i].model);
		
		barrlel[i] = Spawn("script_model", exploding_barrels[i].origin);
		barrlel[i] SetModel(exploding_barrels[i].model);
		barrlel[i].angles = exploding_barrels[i].angles;
		exploding_barrels[i] delete();
	}
}

NoDogOnMap()
{
	NoDog = StrToK(getDvar("scr_ktk_noDogMaps"), ";");
	Mapname = getDvar("mapname");
	dog_map = undefined;

	if(getDvar("dog_enabled") == "")
		setDvar("dog_enabled", getDvar("scr_ktk_dog"));
	
	if(getDvarInt("dog_enabled") == 0)
		return;
	
	for(i=0;i<NoDog.size;i++)
	{
		if(NoDog[i] == Mapname)
		{
			dog_map = false;
			break;
		}
	}
	
	if(isDefined(dog_map) && !dog_map)
		setDvar("scr_ktk_dog", 0);
	else
		setDvar("scr_ktk_dog", 1);
}

NoTerminatorOnMap()
{
	NoTerminator = StrToK(getDvar("scr_ktk_noTerminatorMaps"), ";");
	Mapname = getDvar("mapname");
	terminator_map = undefined;

	if(getDvar("terminator_enabled") == "")
		setDvar("terminator_enabled", getDvar("scr_ktk_terminator"));
	
	if(getDvarInt("terminator_enabled") == 0)
		return;
	
	for(i=0;i<NoTerminator.size;i++)
	{
		if(NoTerminator[i] == Mapname)
		{
			terminator_map = false;
			break;
		}
	}
	
	if(isDefined(terminator_map) && !terminator_map)
		setDvar("scr_ktk_terminator", 0);
	else
		setDvar("scr_ktk_terminator", 1);
}

DisableHardpointsOnMap()
{
	noRCCar = StrToK(getDvar("scr_ktk_noRCCarMaps"), ";");
	noPoison = StrToK(getDvar("scr_ktk_noPoisonMaps"), ";");
	noCarepackage = StrToK(getDvar("scr_ktk_noCPMaps"), ";");
	noAirstrike = StrToK(getDvar("scr_ktk_noAirstrikeMaps"), ";");
	noMortars = StrToK(getDvar("scr_ktk_noMortarMaps"), ";");
	noHelicopter = StrToK(getDvar("scr_ktk_noHeliMaps"), ";");
	noAC130 = StrToK(getDvar("scr_ktk_noAc130Maps"), ";");
	noSentryGun = StrToK(getDvar("scr_ktk_noSentrygunMaps"), ";");
	noPredator = StrToK(getDvar("scr_ktk_noPredatorMaps"), ";");
	noNuke = StrToK(getDvar("scr_ktk_noNukeMaps"), ";");
	noJuggernaut = StrToK(getDvar("scr_ktk_noJuggernautMaps"), ";");

	thread CheckIfHardpointIsAllowed(noRCCar, "rccar");
	thread CheckIfHardpointIsAllowed(noPoison, "poison");
	thread CheckIfHardpointIsAllowed(noCarepackage, "cp");
	thread CheckIfHardpointIsAllowed(noAirstrike, "airstrike");
	thread CheckIfHardpointIsAllowed(noMortars, "mortar");
	thread CheckIfHardpointIsAllowed(noHelicopter, "heli");
	thread CheckIfHardpointIsAllowed(noAC130, "ac130");
	thread CheckIfHardpointIsAllowed(noSentryGun, "sentrygun");
	thread CheckIfHardpointIsAllowed(noPredator, "predator");
	thread CheckIfHardpointIsAllowed(noNuke, "nuke");
	thread CheckIfHardpointIsAllowed(noJuggernaut, "juggernaut");
}

CheckIfHardpointIsAllowed(array, type)
{
	Mapname = getDvar("mapname");
	hardpoint_allowed = undefined;

	setDvar("scr_" + type + "_enabled", 1);
	
	for(i=0;i<array.size;i++)
	{
		if(array[i] == Mapname)
		{
			hardpoint_allowed = false;
			break;
		}
	}
	
	if(isDefined(hardpoint_allowed) && !hardpoint_allowed)
		setDvar("scr_" + type + "_enabled", 0);
	else
		setDvar("scr_" + type + "_enabled", 1);
}

initBombZones()
{
	ktkWeaponBoxes = [];
	entities = getEntArray();
	for(i=0;i<entities.size;i++)
	{
		if(entities[i].classname != "script_model" && entities[i].classname != "script_brushmodel")
			continue;
			
		//not save enough
		//if(entities[i].model != "p_glo_bomb_stack")
		//	continue;
		
		if(!isDefined(entities[i].script_gameobjectname))
			continue;
		
		gameobjectnames = strtok(entities[i].script_gameobjectname, " ");
			
		for(j=0;j<gameobjectnames.size;j++)
		{
			if(gameobjectnames[j] == "bombzone")
			{
				ktkWeaponBoxes[ktkWeaponBoxes.size] = entities[i];
				break;
			}
		}
	}
	
	return ktkWeaponBoxes;
}

replaceBombZoneModels()
{
	if(getDvarInt("scr_mod_weaponbox") < 2)
		return;

	modelInfo = [];
	ktkWeaponBoxes = initBombZones();

	if(!isDefined(ktkWeaponBoxes) || ktkWeaponBoxes.size <= 0)
		return;

	for(i=0;i<ktkWeaponBoxes.size;i++)
	{
		// delete existing bombzone models
		if(ktkWeaponBoxes[i].classname == "script_model")
		{
			curEntry = modelInfo.size;
			modelInfo[curEntry] = spawnStruct();
			modelInfo[curEntry].origin = ktkWeaponBoxes[i].origin;
			modelInfo[curEntry].angles = ktkWeaponBoxes[i].angles;
			modelInfo[curEntry].model = ktkWeaponBoxes[i].model;
			
			ktkWeaponBoxes[i] delete();
			continue;
		}
		
		// delete bombzone clips
		if(ktkWeaponBoxes[i].classname == "script_brushmodel")
		{
			ktkWeaponBoxes[i] delete();
			continue;
		}
	}

	// spawn new bombzone models and make them solid
	for(i=0;i<modelInfo.size;i++)
	{
		trace = bulletTrace(modelInfo[i].origin+(0,0,10), modelInfo[i].origin+(0,0,-10000), false, undefined);
		spawnpoint = trace["position"];

		newBombSpotModel = spawn("script_model", spawnpoint);
		newBombSpotModel setModel("com_bomb_objective_obj");
		newBombSpotModel.angles = modelInfo[i].angles;
		
		//solid = spawn("trigger_radius", spawnpoint, 0, 50, 80);
		//solid setContents(1);
	}
}