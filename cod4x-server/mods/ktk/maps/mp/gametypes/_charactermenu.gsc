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

init()
{
	level.customCharacter = [];
	level.customCharacterStat["mainassassin"] = 2425;
	level.customCharacterStat["assassin"] = 2426;
	level.customCharacterStat["zombie"] = 2427;
	level.customCharacterStat["guard"] = 2428;
	level.customCharacterStat["king"] = 2429;
	
	level.ghillieStat = 2424;
	
	thread initPlayerModels();
	thread initModelPresentation();

	while(1)
	{
		level waittill("connected", player);
		player thread initPersonalCharacter();
	}
}

initPlayerModels()
{
	//On maps with a lot of custom models the zombie event sometimes fails to precache the models
	//since the zombie event does not use mainassassin and assassin models i change the precache order
	thread precachePlayerModels(1, 10); //kings
	thread precachePlayerModels(11, 20); //guards
	
	if(game["customEvent"] == "zombie")
		thread precachePlayerModels(41, 50); //zombies

	thread precachePlayerModels(21, 30); //mainassassins
	thread precachePlayerModels(31, 40); //assassins
	
	if(game["customEvent"] != "zombie")
		thread precachePlayerModels(41, 50); //zombies
}

precachePlayerModels(startID, endID)
{
	for(i=startID;i<=endID;i++)
	{
		struct = spawnstruct();
		struct.stat = int(tablelookup("mp/playermodels.csv", 0, i, 6));
		struct.price = int(tablelookup("mp/playermodels.csv", 0, i, 7));
		struct.type = toLower(tablelookup("mp/playermodels.csv", 0, i, 1));
		struct.head = toLower(tablelookup("mp/playermodels.csv", 0, i, 4));
		struct.model = toLower(tablelookup("mp/playermodels.csv", 0, i, 3));
		struct.gear = toLower(tablelookup("mp/playermodels.csv", 0, i, 5));

		if(!isDefined(struct.stat) || struct.stat == 0)
			continue;
		
		if(!isDefined(struct.type) || struct.type == "")
			continue;

		if(!isDefined(struct.model) || struct.model == "")
			continue;
		
		if(!isDefined(level.customCharacter[struct.type]))
			level.customCharacter[struct.type] = [];
		
		precachePlayerModel(struct);
	
		level.customCharacter[struct.type][level.customCharacter[struct.type].size] = struct;
	}
}

precachePlayerModel(struct)
{
	if(isDefined(struct.model) && struct.model != "")
		precacheModel(struct.model);
		
	if(isDefined(struct.head) && struct.head != "")
		precacheModel(struct.head);
		
	if(isDefined(struct.gear) && struct.gear != "")
		precacheModel(struct.gear);
}

initModelPresentation()
{
	while(!isDefined(level.mapCenter))
		wait .05;

	level.catwalk = spawn("script_model", level.mapCenter + (0,0,1000));
	level.catwalk setModel("tag_origin"); //"whiteWall"
}

getCustomModelFromStat(type)
{
	if(self isABot())
		return level.customCharacter[type][randomInt(level.customCharacter[type].size)].model;
	
	return level.customCharacter[type][self getKtKStat(level.customCharacterStat[type])].model;
}

initPersonalCharacter()
{
	self endon("disconnect");
	
	self.pers["ghillie"] = self getGhillieFromStat();
	self.menuSelectedCharacter = undefined;
	
	self setKtkStat(2430, 1);
	self setKtkStat(2440, 1);
	self setKtkStat(2450, 1);
	self setKtkStat(2460, 1);
	self setKtkStat(2470, 1);	
	
	self.pers["currentCharacter"] = [];
	self.pers["currentCharacter"]["mainassassin"] = undefined;
	self.pers["currentCharacter"]["assassin"] = undefined;
	self.pers["currentCharacter"]["zombie"] = undefined;
	self.pers["currentCharacter"]["guard"] = undefined;
	self.pers["currentCharacter"]["king"] = undefined;
	
	self.pers["customCharacter"] = [];
	self.pers["customCharacter"]["mainassassin"] = self getCustomModelFromStat("mainassassin");
	self.pers["customCharacter"]["assassin"] = self getCustomModelFromStat("assassin");
	self.pers["customCharacter"]["zombie"] = self getCustomModelFromStat("zombie");
	self.pers["customCharacter"]["guard"] = self getCustomModelFromStat("guard");
	self.pers["customCharacter"]["king"] = self getCustomModelFromStat("king");
}

characterCustomizationMenu(response)
{
	self endon("disconnect");

	if(self isABot())
		return;
	
	if(game["customEvent"] == "hideandseek")
	{
		if(self isAnAssassin())
			return;
	
		if(isSubStr(response, "change_propsmodel"))
		{
			array = strToK(response, "_");
			
			//	0		1				2
			//"change	propsmodel		ID"
				
			array[2] = int(array[2]);
			array[2] -= 1;
				
			if(array[0] == "change")
			{
				self setKtkStat(2480, array[2]);
				self thread maps\mp\gametypes\_props::attachPropModelToPlayer();
				return;
			}
		}
	}
	
	if(response == "character_menu_open")
	{
		if(isDefined(self.pers["team"]) && self.pers["team"] != "spectator")
		{
			scr_iPrintlnBold("CHARACTER_MENU_NO_SPEC", self);
			return;
		}

		self thread openCharacterMenu();
		return;
	}
		
	if(response == "delete_playermodels")
	{
		self.menuSelectedCharacter = undefined;
		
		if(isDefined(self.personalCatwalk))
			self.personalCatwalk delete();
				
		if(isDefined(self.personalCatwalkBody))
			self.personalCatwalkBody delete();
			
		if(isDefined(self.personalCatwalkHead))
			self.personalCatwalkHead delete();
		
		return;
	}
		
	if(response == "hide_playermodels")
	{
		if(isDefined(self.personalCatwalkBody))
			self.personalCatwalkBody setModel("tag_origin");
		
		if(isDefined(self.personalCatwalkHead))
			self.personalCatwalkHead setModel("tag_origin");

		return;
	}
		
	if(isSubStr(response, "show_playermodel") || isSubStr(response, "unlock_playermodel") || isSubStr(response, "change_playermodel") || isSubStr(response, "sell_playermodel"))
	{
		curModel = undefined;
		array = strToK(response, "_");
			
		//	0		1				2	 		3
		//"show		playermodel		assassin	ID"
		//"unlock	playermodel"
		//"change	playermodel"
		//"sell		playermodel"
			
		if(array[0] == "show")
		{
			if(!isDefined(self.personalCatwalk))
				return;
		
			if(!isDefined(array[3]))
				return;
			
			array[3] = int(array[3]);
			array[3] -= 1;
			
			if(array[3] >= level.customCharacter[array[2]].size)
				return;

			self.menuSelectedCharacter = array[2] + "_" + array[3];
					
			if(isDefined(self.personalCatwalkBody))
			{
				self.personalCatwalkBody setModel(level.customCharacter[array[2]][array[3]].model);
				self.personalCatwalkBody linkTo(self.personalCatwalk);
					
				if(isDefined(self.personalCatwalkHead))
				{
					self.personalCatwalkHead setModel("tag_origin");
				
					if(isDefined(level.customCharacter[array[2]][array[3]].head) && level.customCharacter[array[2]][array[3]].head != "")
					{
						self.personalCatwalkHead setModel(level.customCharacter[array[2]][array[3]].head);
						self.personalCatwalkHead.origin = self.personalCatwalkBody getTagOrigin("j_spine4");
						self.personalCatwalkHead.angles = self.personalCatwalkBody.angles;
						self.personalCatwalkHead.angles = self.personalCatwalkHead.angles + (-90, -90, 0);
						self.personalCatwalkHead linkTo(self.personalCatwalk);
					}
				}
			}
		}
		else if(array[0] == "unlock")
		{
			if(!isDefined(self.menuSelectedCharacter))
				return;
				
			curModel = strToK(self.menuSelectedCharacter, "_");
			
			if(!isDefined(curModel) || curModel.size < 2)
				return;

			curModel[1] = int(curModel[1]);
			
			if(self getKtkStat(2359) < level.customCharacter[curModel[0]][curModel[1]].price)
				return;

			if(self getKtKStat(level.customCharacter[curModel[0]][curModel[1]].stat) > 0)
			{
				self setClientDvar("character_warning", "owning_model");
				return;
			}
					
			self setKtkStat(level.customCharacter[curModel[0]][curModel[1]].stat, 1);
			self maps\mp\gametypes\_unlockables::PayUnlock("", "playermodel", level.customCharacter[curModel[0]][curModel[1]].price);
		}
		else if(array[0] == "change")
		{
			if(!isDefined(self.menuSelectedCharacter))
				return;
				
			curModel = strToK(self.menuSelectedCharacter, "_");
			
			if(!isDefined(curModel) || curModel.size < 2)
				return;
					
			curModel[1] = int(curModel[1]);
				
			if(self getKtKStat(level.customCharacter[curModel[0]][curModel[1]].stat) < 1)
			{
				self setClientDvar("character_warning", "not_owning_model");
				return;
			}
				
			self setKtkStat(level.customCharacterStat[curModel[0]], curModel[1]);
			self.pers["customCharacter"][curModel[0]] = level.customCharacter[curModel[0]][curModel[1]].model;
				
			self setClientDvar("character_warning", "model_changed");
		}
		else if(array[0] == "sell")
		{
			if(!isDefined(self.menuSelectedCharacter))
				return;
				
			curModel = strToK(self.menuSelectedCharacter, "_");
			
			if(!isDefined(curModel) || curModel.size < 2)
				return;

			curModel[1] = int(curModel[1]);
				
			if(self getKtKStat(level.customCharacter[curModel[0]][curModel[1]].stat) < 1)
			{
				self setClientDvar("character_warning", "not_owning_model");
				return;
			}
				
			//do not sell the default models
			if(curModel[1] == 0)
			{
				self setClientDvar("character_warning", "selling_default");
				return;
			}
				
			self setKtkStat(level.customCharacter[curModel[0]][curModel[1]].stat, 0);
			self setClientDvar("character_warning", "sold_model");
				
			//only reset his current model, when he sold it
			if(self getKtkStat(level.customCharacterStat[curModel[0]]) == curModel[1])
			{
				self setKtkStat(level.customCharacterStat[curModel[0]], 0);
				self.pers["customCharacter"][curModel[0]] = level.customCharacter[curModel[0]][curModel[1]].model;
					
				self setClientDvar("character_warning", "model_changed_default");
			}
				
			//gimme my money!
			self setKtkStat(2359, self getKtkStat(2359) + level.customCharacter[curModel[0]][curModel[1]].price);
			self setKtkStat(2360, self getKtkStat(2360) - level.customCharacter[curModel[0]][curModel[1]].price);
		}
			
		return;
	}
}

openCharacterMenu()
{
	self endon("disconnect");
	
	self thread occupyCatwalk();
	self openMenu(game["menu_charactermenu"]);
}

occupyCatwalk()
{
	if(isDefined(self.personalCatwalk))
		self.personalCatwalk delete();
		
	if(isDefined(self.personalCatwalkBody))
		self.personalCatwalkBody delete();
		
	if(isDefined(self.personalCatwalkHead))
		self.personalCatwalkHead delete();
	
	self.personalCatwalk = spawn("script_model", level.catwalk.origin);
	self.personalCatwalkBody = spawn("script_model", level.catwalk.origin);
	self.personalCatwalkHead = spawn("script_model", level.catwalk.origin);
	
	self.personalCatwalkBody hide();
	self.personalCatwalkBody showToPlayer(self);
	
	self.personalCatwalkHead hide();
	self.personalCatwalkHead showToPlayer(self);
	
	self.personalCatwalkBody.angles = self.personalCatwalk.angles + (0,-90,0);
	self.personalCatwalkHead.angles = self.personalCatwalk.angles + (0,-90,0);

	//self.personalCatwalkBody.origin = level.catwalk.origin - AnglesToForward(level.catwalk.angles)*20;
	//self.personalCatwalkBody.angles = level.catwalk.angles;
	
	self.personalCatwalk thread rotateModelForPresentation();
	
	self setOrigin(level.catwalk.origin - AnglesToForward(level.catwalk.angles)*200);
	self setPlayerAngles(VectorToAngles(level.catwalk.origin - self.origin));
	
	self linkTo(level.catwalk);
}

rotateModelForPresentation()
{
	self endon("death");
	
	//self.angles = (0,0,90);
	
	while(1)
	{
		self rotateYaw(360, 5);
		wait 5;
	}
}

getGhillieFromStat()
{
	switch(self getKtKStat(level.ghillieStat))
	{
		case 1: return "woodland";
		case 2: return "desert";
		case 3: return "winter";
		default: return "none";
	}
}

getGhillieStatFromType(type)
{
	switch(type)
	{
		case "woodland": return 1;
		case "desert": return 2;
		case "winter": return 3;
		default: return 0;
	}
}