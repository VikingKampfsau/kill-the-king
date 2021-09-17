// weapon and script by Rycoon
// additional sound script written myself
#include maps\mp\gametypes\_misc;

init()
{
	PrecacheShellShock("frag_grenade_mp");
	level.poisongas_fx = LoadFX("killtheking/poisongas");
}

poisonOnPlayerSpawn()
{
	self endon("disconnect");
	
	if(isDisabledHardpoint(level.ktkWeapon["poisongas"]))
		return;
		
	self StopLocalSound("tabun_shock");
	self StopLocalSound("tabun_shock_end");
		
	self.HasCalledBefore = false;
	self thread WatchPoisonGasUsage();
}

WatchPoisonGasUsage()
{
	self endon("disconnect");
	self endon("death");
	
	if(self isABot())
		return;
	
	while(1)
	{
		self waittill("grenade_fire", proj, WeapName );
		if( weapName != level.ktkWeapon["poisongas"] )
			continue;
		
		proj thread WatchPoisonGasGrenade( self );
	}
}

WatchPoisonGasGrenade( owner )
{
	self endon("death");

	self waitTillNotMoving();

	self PlaySound("smokegrenade_explode_default");
	PlayFXOnTag( level.poisongas_fx, self, "polysurface22" );
	
	if( !isDefined( self ) || !isDefined( owner ) )
		return;
	
	maxtime = 15*2;		//SET ME; max smoke duration ( take it double! )
	time = 0;
	radius = 30;
	maxradius = 230;	//SET ME
	dmg = 15;			//SET ME
	
	while( isDefined( self ) && isDefined( owner ) )
	{
		if( time >= maxtime )
			break;
		for(i=0;i<level.players.size;i++)
		{
			if(!isDefined(level.players[i]) || !isPlayer(level.players[i]))
				continue;
		
			if( self SightConeTrace( level.players[i] GetEye(), self ) > 0 &&
				Distance( self.origin, level.players[i].origin ) <= radius && 
				level.players[i] != owner && 
				owner.pers["team"] != level.players[i].pers["team"] &&
				level.players[i] isAnAssassin() &&
				(!isDefined(level.players[i].godmode) || !level.players[i].godmode))
			{
				if(isAlive( level.players[i] ))
					level.players[i] thread InhalePoison(self, maxradius, dmg, owner);
			}
		}
		if( radius < maxradius )
			radius += 20;
		time++;
		wait 0.5;
	}
	if( isDefined( self ) )
		self delete();
}

InhalePoison(poisongrenade, maxradius, dmg, owner)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");

	if(!isDefined(level.roundstarted) || !level.roundstarted)
		return;
	
	if(!isDefined(self) || !isDefined(poisongrenade) || !isDefined(maxradius) || !isDefined(dmg) || !isDefined(owner))
		return;
	
	self thread PainSound(poisongrenade, maxradius);
	self ktkFinishPlayerDamage(poisongrenade, owner, dmg, 0, "MOD_PROJECTILE", level.ktkWeapon["poisongas"], poisongrenade.origin, VectorToAngles( self.origin - poisongrenade.origin ), "none", 0);
	self ShellShock("frag_grenade_mp" , 1 );
}

PainSound(poisongrenade, maxradius)
{
	self endon("death");
	self endon("disconnect");

	if(!isDefined(self.HasCalledBefore) || !self.HasCalledBefore)
		self.HasCalledBefore = true;
	else
		return;

	SoundPlaying = false;

	while(1)
	{
		wait .1;
		
		InsideGas = self CheckDistance(poisongrenade, maxradius);
		
		if(!isDefined(InsideGas))
			break;
		
		if(InsideGas && !SoundPlaying)
		{
			self PlayLocalSound("tabun_shock");
			SoundPlaying = true;
		}
		else if(!InsideGas)
		{
			self StopLocalSound("tabun_shock");
			self PlayLocalSound("tabun_shock_end");
			self.HasCalledBefore = false;
			break;
		}
	}
}

CheckDistance(poisongrenade, maxradius )
{
	self endon("death");
	self endon("disconnect");

	if(!isDefined(self) || !isDefined(poisongrenade) || !isDefined(maxradius))
		return;
	
	if(Distance(self.origin, poisongrenade.origin) <= maxradius)
		return true;
		
	return false;
}