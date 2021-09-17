#include common_scripts\utility;
#include maps\mp\_utility;

main()
{
	maps\mp\_load::main();
    maps\mp\_compass::setupMiniMap("compass_map_mp_osg_hijacked");	
		
	ambientPlay("ambient_backlot_ext");
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert"; 	
	
	setdvar( "r_specularcolorscale", "1" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");
	
	thread initFX();
	thread initAmbientSounds();
	thread initWater();
	thread initRotations();
	thread initDrowning();
}

//****************************
//			fx
//****************************
initFX()
{
	level._effect["fog_bog_a"]					    = loadfx ("weather/fog_bog_a");
	level._effect[ "hawks" ]						= loadfx( "misc/hawks" );
	level._effect[ "bird_seagull_flock_large" ]		= loadfx( "misc/bird_seagull_flock_large" );
	level._effect[ "bro_wave" ] 				    = loadfx( "misc/bro_wave" );
	level._effect[ "bro_jacuzi" ] 				    = loadfx( "misc/bro_jacuzi" );

	maps\mp\_fx::loopfx("bird_seagull_flock_large", (-1848.9, 114.079, 1039), 1);
	maps\mp\_fx::loopfx("bird_seagull_flock_large", (1102.9, 1365.78, 1042), 1);
	maps\mp\_fx::loopfx("bird_seagull_flock_large", (1423.27, -1018.41, 1042), 1);
	maps\mp\_fx::loopfx("bird_seagull_flock_large", (4543.66 ,91.611, 1320), 1);
  
 	ent = maps\mp\_utility::createOneshotEffect( "hawks" );
    ent.v[ "origin" ] = ( 1553.08, 160.804, 1843 );
    ent.v[ "angles" ] = ( 270, 0, 0 );
    ent.v[ "fxid" ] = "hawks";
    ent.v[ "delay" ] = -15;
	
	if ( getdvar( "clientSideEffects" ) != "1" )
	{
     	ent = maps\mp\_utility::createOneshotEffect( "fog_bog_a" );
     	ent.v[ "origin" ] = ( 1561.0,  548.0, 564.0 );
     	ent.v[ "angles" ] = ( 270, 0, 0 );
     	ent.v[ "fxid" ] = "fog_bog_a";
     	ent.v[ "delay" ] = -15;
	}
}

//****************************
//			sound
//****************************
initAmbientSounds()
{
	//mp_osg_algiers custom sounds
	maps\mp\_fx::loopSound("stream", (-1027.54, 125.629, 416), 1);
	maps\mp\_fx::loopSound("stream", (1564.02, 555.316, 548), 1);
	maps\mp\_fx::loopSound("resturanr", (2797.23, 56.6608, 613), 1);
	maps\mp\_fx::loopSound("seacruise", (2360.36, 37.2822, 564), 1);
	maps\mp\_fx::loopSound("seagulls", (-1848.9, 114.079, 1039), 1);
	maps\mp\_fx::loopSound("seagulls", (1102.9, 1365.78, 1042), 1);
	maps\mp\_fx::loopSound("seagulls", (1423.27, -1018.41, 1042), 1);
	maps\mp\_fx::loopSound("seagulls", (4543.66, 91.611, 1320), 1);
	maps\mp\_fx::loopSound("bro_cruise_engine", (1404.19, 313.338, 340.562), 1);
	maps\mp\_fx::loopSound("bro_cruise_engine", (1605.19, 313.338, 340.562), 1);
	maps\mp\_fx::loopSound("surf", (2653.23, 917.51, 365.562), 1);
	maps\mp\_fx::loopSound("surf", (1417.27, 1028.14, 365.562), 1);
	maps\mp\_fx::loopSound("surf", (299.564, 879.363, 365.562), 1);
	maps\mp\_fx::loopSound("surf", (-612.149, 855.475, 364.562), 1);
	maps\mp\_fx::loopSound("surf", (-1504.79, 157.386, 364.562), 1);
	maps\mp\_fx::loopSound("surf", (-825.772, -498.742, 364.562), 1);
	maps\mp\_fx::loopSound("surf", (124.088, -623.627, 364.562), 1);
	maps\mp\_fx::loopSound("surf", (1344.79, -532.074, 364.562), 1);
	maps\mp\_fx::loopSound("surf", (2676.12, -562.947, 478.562), 1);
	maps\mp\_fx::loopSound("surf", (3809.08, -360.768, 478.562), 1);
	maps\mp\_fx::loopSound("washer", (244.678, 381.982, 496), 1);
	maps\mp\_fx::loopSound("boyfriend", (1563.85, 643.003, 568), 1);
	maps\mp\_fx::loopSound("bro_bubbles", (523.415, 24.8223, 520.532), 1);
	maps\mp\_fx::loopSound("bro_bubbles", (2876.65, -160.2, 566.532), 1);
}

//****************************
//			water
//****************************
initWater()
{
    randomStartDelay = randomfloatrange( -20, -15);

    global_FX( "bro_wave", "bro_wave", "misc/bro_wave", randomStartDelay ); 
    global_FX( "bro_pool", "bro_pool", "misc/bro_pool", randomStartDelay ); 
    global_FX( "bro_jacuzi", "bro_jacuzi", "misc/bro_jacuzi", randomStartDelay ); 
	global_FX( "shower_spray", "shower_spray", "misc/shower_spray", randomStartDelay, "bro_shower" );
	global_FX( "shower_steam", "shower_steam", "misc/shower_steam", randomStartDelay);
	global_FX( "shower_wall_large", "shower_wall_large", "distortion/shower_wall_large", randomStartDelay);	
}

global_FX( targetname, fxName, fxFile, delay, soundalias )
{
    // script_structs
    ents = getstructarray(targetname,"targetname");
    if ( !isdefined( ents ) )
        return;
    if ( ents.size <= 0 )
        return;
    
    for ( i = 0 ; i < ents.size ; i++ )
        ents[i] global_FX_create( fxName, fxFile, delay, soundalias );
}

global_FX_create( fxName, fxFile, delay, soundalias )
{
    if ( !isdefined( level._effect ) )
        level._effect = [];
    if ( !isdefined( level._effect[ fxName ] ) )
        level._effect[ fxName ]    = loadfx( fxFile );
    
    // default effect angles if they dont exist
    if ( !isdefined( self.angles ) )
        self.angles = ( 270, 90, 90 );
    
    ent = createOneshotEffect( fxName );
    ent.v[ "origin" ] = ( self.origin );
    ent.v[ "angles" ] = ( self.angles );
    ent.v[ "fxid" ] = fxName;
    ent.v[ "delay" ] = delay;
    
	if ( isdefined( soundalias ) )
        ent.v[ "soundalias" ] = soundalias;
}

//****************************
//			rotation
//****************************
initRotations()
{
	for(z=1;z<=4;z++)
	{
		rotate_obj = undefined;
	
		switch(z)
		{
			case 1: rotate_obj = getentarray("rotate_ball", 	"targetname"); break;
			case 2: rotate_obj = getentarray("rotate", 			"targetname"); break;
			case 3: rotate_obj = getentarray("rotate_bro_sign", "targetname"); break;
			case 4: rotate_obj = getentarray("rotatemin", 		"targetname"); break;
		}
	
		if(isdefined(rotate_obj))
		{
			for(i=0;i<rotate_obj.size;i++)
			{
				if(!isdefined(rotate_obj[i].speed))
					rotate_obj[i].speed = 10;
				
				if(!isdefined(rotate_obj[i].direction))
				{
					if(z == 4)
						rotate_obj[i].direction = -1;
					else
						rotate_obj[i].direction = 1;
				}
				
				if(!isdefined(rotate_obj[i].script_noteworthy))
				{
					if(z == 1)
						rotate_obj[i].script_noteworthy = "y";
					else
						rotate_obj[i].script_noteworthy = "z";
				}
				
				rotate_obj[i] thread doRotate();
			}
		}
	}
}

doRotate()
{
	for(;;)
	{
		if (self.script_noteworthy == "z")
			self rotateYaw(self.direction * 360, self.speed);
		else if (self.script_noteworthy == "x")
			self rotateRoll(self.direction * 360, self.speed);
		else if (self.script_noteworthy == "y")
			self rotatePitch(self.direction* 360, self.speed);
		wait (self.speed-0.1);
	}
}

//****************************
//			drowning
//****************************
initDrowning()
{	
	precacheShader("black");
	precacheShader("white");
	
	level.barsize = 288;
	level.drowntime = 8;
	level.hurttime = 6;
	
	drownage = getentarray("drown","targetname");
	
	if(isDefined(drownage))
	{
		for(d = 0; d < drownage.size; d++)
		{
			drownage[d].waterlevel = 408;
			drownage[d] thread water();
		}
	}
	
	drownage = undefined;
	drownage = getentarray("drown1","targetname");
	
	if(isDefined(drownage))
	{
		for(d = 0; d < drownage.size; d++)
		{
			drownage[d].waterlevel = 563;
			drownage[d] thread water();
		}
	}
}

water()
{
	while(1)
	{
		self waittill("trigger", player);
		
		if(player.sessionstate != "playing")
			continue;
			
		if(player getPlayerEyes()[2] < self.waterlevel && !isDefined(self.drowning))
			player thread drown(self);
	}
}

drown(trigger)
{
	self endon("disconnect");

	if(!isDefined(trigger))
		return;
		
	if(!isDefined(trigger.target))
		return;
	
	dceiling = getent(trigger.target,"targetname");

	if(!isDefined(dceiling))
		return;
	
	if(isDefined(self.water_vision))
		self.water_vision destroy();
	
	if(isDefined(self.progressbackground))
		self.progressbackground destroy();
	
	if(isDefined(self.progressbar))
		self.progressbar destroy();
	
	self.water_vision = newClientHudElem(self);
	self.water_vision.x = 0;
	self.water_vision.y = 0;
	self.water_vision setshader ("white", 640, 480);
	self.water_vision.alignX = "left";
	self.water_vision.alignY = "top";
	self.water_vision.horzAlign = "fullscreen";
	self.water_vision.vertAlign = "fullscreen";
	self.water_vision.color = (.16, .38, .5);
	self.water_vision.alpha = .75;
	
	self.progressbackground = newClientHudElem(self);
	self.progressbackground.alignX = "center";
	self.progressbackground.alignY = "middle";
	self.progressbackground.x = 320;
	self.progressbackground.y = 385;
	self.progressbackground.alpha = 0.5;
	self.progressbackground setShader("black", (level.barsize + 4), 14);

	self.progressbar = newClientHudElem(self);
	self.progressbar.alignX = "left";
	self.progressbar.alignY = "middle";
	self.progressbar.x = (320 - (level.barsize / 2.0));
	self.progressbar.y = 385;
	self.progressbar setShader("white", 0, 8);
	self.progressbar scaleOverTime(level.drowntime, level.barsize, 8);
	
	self.drowning = true;
	
	f = 0; 
	self.progresstime = 0;
	
	while(isAlive(self))
	{
		wait .05;
		
		if(!self isTouching(trigger))
			break;
			
		if(self isTouching(dceiling))
			break;
			
		if(self getPlayerEyes()[2] >= self.waterlevel)
			break;

		if(self.progresstime < level.drowntime)
		{
			f++; 
			self.progresstime += 0.05;
			
			if(self.progresstime >= level.hurttime && f >= 4)
			{
				self FinishPlayerDamage(self, self, 5, 0, "MOD_SUICIDE", "none", self.origin, VectorToAngles(self.origin - self.origin), "none", 0);
				f = 0;
			}
			
			continue;
		}
	}
	
	if(isAlive(self))
	{
		switch(randomInt(4))
		{
			case 1: self iPrintLnBold("That's what happens when you swim in water scooters wee'd in!!"); break;
			case 2: self iPrintLnBold("OMG was that a turd."); break;
			case 3: self iPrintLnBold("You're shark food."); break;
			default: self iPrintLnBold("You choked on Joes Mankini."); break;
		}
		
		self suicide();
	}
	
	self.progressbackground destroy();
	self.progressbar destroy();
	self.water_vision destroy();
	
	self.drowning = undefined;
	self.sounder = undefined;
}

getPlayerEyes()
{
	playerEyes = self.origin;

	switch( self getStance())
	{
		case "prone": playerEyes += (0,0,11); break;
		case "crouch": playerEyes += (0,0,40); break;
		case "stand": playerEyes += (0,0,60); break;
	}

	return playerEyes;   
}