spawnDecoy(owner)
{
	self endon("death");
	
	objID = 15;
	Objective_Add(objID, "invisible");
	
	wait 2;
	
	timer = 0;
	while(isDefined(self) && timer <= 7)
	{
		addTime = randomFloat(0.65);
		wait addTime;
		
		PlayFxOnTag(level.effect["decoy"], self, "polysurface22");
		self DecoySoundForWeapon(level.GunGameWeapons[randomInt(level.GunGameWeapons.size)]);

		Objective_Icon(objID, "compassping_enemyfiring");
		Objective_State(objID, "active");
		Objective_OnEntity(objID, self);
		
		Objective_Team(objID, game["attackers"]);
		Objective_Team(objID, game["defenders"]);
			
		timer += addTime;
	}
	
	Objective_Delete(objID);
	
	if(isDefined(self))
		self delete();
}

DecoySoundForWeapon(weapon)
{
	self endon("death");
	
	if(!isDefined(weapon))
		weapon = "ak47_mp";

	if(isSubStr(weapon, "m4_"))
		self PlaySound("weap_m4carbine_fire_npc");
	else if(isSubStr(weapon, "rpd_"))
		self PlaySound("weap_degtyarev_rpd_fire_npc");
	else if(isSubStr(weapon, "dragunov_"))
		self PlaySound("weap_dragunovsniper_fire_npc");
	else if(isSubStr(weapon, "p90_"))
		self PlaySound("weap_fnp90_fire_npc");
	else if(isSubStr(weapon, "m14_"))
		self PlaySound("weap_m14sniper_fire_npc");
	else if(isSubStr(weapon, "colt45_"))
		self PlaySound("weap_m1911colt45_fire_npc");
	else if(isSubStr(weapon, "saw_"))
		self PlaySound("weap_m249saw_fire_npc");
	else if(isSubStr(weapon, "m40a3_"))
		self PlaySound("weap_m40a3sniper_fire_npc");
	else if(isSubStr(weapon, "m60e4_"))
		self PlaySound("weap_m60_fire_npc");
	else if(isSubStr(weapon, "m21_"))
		self PlaySound("weap_m82sniper_fire_npc");
	else if(isSubStr(weapon, "beretta_"))
		self PlaySound("weap_m9_fire_npc");
	else if(isSubStr(weapon, "uzi_"))
		self PlaySound("weap_miniuzi_fire_npc");
	else if(isSubStr(weapon, "remington700_"))
		self PlaySound("weap_rem700sniper_fire_npc");
	else if(isSubStr(weapon, "usp_"))
		self PlaySound("weap_usp45_fire_npc");
	else if(isSubStr(weapon, "winchester1200_"))
		self PlaySound("weap_winch1200_fire_npc");
	else
	{
		letter = "";
		
		for(i=0;i<=weapon.size;i++)
		{
			letter = getSubStr(weapon, i, i+1);
			
			if(letter == "_") break;
		}
		
		weaponRef = getSubStr(weapon, 0, i);
		
		self PlaySound("weap_" + weaponRef + "_fire_npc");
	}
}