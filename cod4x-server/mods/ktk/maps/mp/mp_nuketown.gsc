main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_nuketown");

	setExpFog(1200, 1800, 0.66, 0.61, 0.56, 0);

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
	
	setdvar("compassmaxrange","2000");
	
	if( getDvar("g_gametype") == "ctf")
	{
		addobj("allied_flag", (1430, 390, 24), (0, 0, 0));
		addobj("axis_flag", (-1133, 3, 24), (0, 0, 0));
	}
	
	if( getDvar("g_gametype") == "ctfb")
	{
		addobj("allied_flag", (1430, 390, 24), (0, 0, 0));
		addobj("axis_flag", (-1133, 3, 24), (0, 0, 0));
	}	
	
	thread initFans();
	thread initWindows();
	thread initPopulation();
}

addobj(name, origin, angles)
{
	ent = spawn("trigger_radius", origin, 0, 48, 148);
	ent.targetname = name;
	ent.angles = angles;
}

initFans()
{
	fan = getEntArray("zz_fan", "targetname");
	
	for(i=0;i<fan.size; i++)
		fan[i] thread FanRotation();
}

FanRotation()
{
	while(1)
	{
		self rotateYaw(360,1);
		wait (0.9);
	}
}

initWindows()
{
	level.nuketown_windowfx = loadFX("props/car_glass_large");
	windtrigs = getEntArray("windtrig", "targetname");
	
	for(i=0;i<windtrigs.size;i++)
		windtrigs[i] thread monitorWindow();
}

monitorWindow()
{
	self enableGrenadeTouchDamage();

	NormalState = getEnt(self.target, "targetname");
	
	ShatteredState = getEnt(NormalState.target, "targetname");
	ShatteredState hide();
	
	WndClipState = getEnt(shatteredState.target, "targetname");
	
	BrokenState = getEnt(WndClipState.target, "targetname");
	BrokenState hide();
	
	damageTaken = 0;
	WindowShattered = false;
	
	while(1)
	{
		self waittill("damage", amount);
		
		damageTaken += amount;		
	
		if(!WindowShattered)
		{
			NormalState delete();
			ShatteredState show();
			WindowShattered = true;
		}
		
		if(damageTaken > 50)
			break;
	}
	
	self playSound("window_entry_glass_med");
	PlayFX(level.nuketown_windowfx, ShatteredState.origin );	
	
	BrokenState show();
	WndClipState delete();
	ShatteredState delete();
	self delete();
}

initPopulation()
{
	digit1_roll = getEnt("zz_digit_1", "targetname");
	digit2_roll = getEnt("zz_digit_2", "targetname");
	
	digit1 = 0;
	digit2 = 0;
	last_player_number = 0;
	
	while(1)
	{
		//players = level.players;
		players = getEntarray( "player", "classname" );
		
		if(players.size != last_player_number)
		{
			last_player_number = players.size;
			
			digit1_roll rotateRoll(digit1,0.1);
			digit2_roll rotateRoll(digit2,0.1);
			wait (0.2);
			
			digit1 = int(players.size * 0.1);
			digit2 = int(players.size % 10);
			digit1 *= 36;
			digit2 *= 36;
				
			digit1_roll rotateRoll(digit1,0.1);
			digit2_roll rotateRoll(digit2,0.1);
			wait (0.2);
			digit1 *= -1;
			digit2 *= -1;
		}
		wait (5);
	}
}