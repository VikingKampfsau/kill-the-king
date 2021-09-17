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
/*--------------------------------------------------------------------------|
|				To use the tools the gametype has to be DM					|
|--------------------------------------------------------------------------*/
#include maps\mp\gametypes\_misc;

init()
{
	setDvar("player_sustainAmmo", 1);

	if(getDvar("scr_devtool") == "") setDvar("scr_devtool", 0);
	if(getDvar("scr_devtool_flypath") == "") setDvar("scr_devtool_flypath", 1);
	if(getDvar("scr_devtool_edit") == "") setDvar("scr_devtool_edit", "ladders");

	if(getDvarInt("scr_devtool") && getDvarInt("scr_devtool_flypath"))
	{
		thread drawAC130FlyRadius();
		thread drawHeliFlyPath();
	}
}

/*--------------------------------------------------------------------------|
|							DevTool to place ladders						|
|--------------------------------------------------------------------------*/
LadderPlaceTool()
{
	self endon("disconnect");
	self endon("death");

	self iPrintLnBold("^3[{+attack}] ^7= Place new ladder ^3OR ^7change height (up)");
	self iPrintLnBold("^3[{+toggleads}] ^7= Change height (down)");
	self iPrintLnBold("^3[{+frag}] ^7= Rotate");
	self iPrintLnBold("^3[{+activate}] ^7= Edit the closest ladder");
	self iPrintLnBold("^3[{+smoke}] ^7= Define bottom/top position");
	self iPrintLnBold("^3[{+melee}] ^7= Save in log");

	if(isDefined(level.ladder) && level.ladder.size > 0)
	{
		for(i=0;i<level.ladder.size;i++)
		{
			level.ladder[i].ground = level.ladder[i].origin;
			level.ladder[i] thread DebugClimbPath();
		}
	}
	
	player = self;
	ground = undefined;
	curLadder = undefined;
	placeNewLadder = true;

	while(1)
	{
		wait .05;
		
		if(player AttackButtonPressed())
		{
			if(placeNewLadder)
			{
				target = PhysicsTrace(player getEye(), player getEye() + AnglesToForward(player getPlayerAngles())*99999);
			
				if(isDefined(target))
				{
					if(isDefined(curLadder))
						curLadder++;
					else
					{
						if(!level.laddermodel.size)
							curLadder = 0;
						else
							curLadder = level.laddermodel.size;
					}
					
					placeNewLadder = false;
					maps\mp\gametypes\_ladders::spawnLadderModel(target, player.angles + (0,180,180));
				}
			}
			
			while(player AttackButtonPressed())
			{
				if(isDefined(level.laddermodel[curLadder]))
					level.laddermodel[curLadder].origin += (0,0,1);	
					
				wait .05;
			}
		}
		else if(player ADSButtonPressed())
		{
			if(placeNewLadder || !isDefined(curLadder))
				continue;

			while(player ADSButtonPressed())
			{
				if(isDefined(level.laddermodel[curLadder]))
					level.laddermodel[curLadder].origin -= (0,0,1);	
					
				wait .05;
			}			
		}
		else if(player FragButtonPressed())
		{
			if(placeNewLadder || !isDefined(curLadder))
				continue;

			while(player FragButtonPressed())
			{
				if(isDefined(level.laddermodel[curLadder]))
				{
					level.laddermodel[curLadder].angles += (0,1,0);
				
					if(level.laddermodel[curLadder].angles[1] >= 360)
						level.laddermodel[curLadder].angles = (level.laddermodel[curLadder].angles[0], 0, level.laddermodel[curLadder].angles[2]);
				}
					
				wait .05;
			}	
		}
		else if(player SecondaryOffhandButtonPressed())
		{
			if(placeNewLadder || !isDefined(curLadder))
				continue;

			if(isDefined(level.laddermodel[curLadder]))
			{
				if(!isDefined(ground))
				{
					ground = player.origin[2];
					level.laddermodel[curLadder].ground = player.origin;
					level.laddermodel[curLadder].elevation = 205 - Distance(level.laddermodel[curLadder].origin, (level.laddermodel[curLadder].origin[0], level.laddermodel[curLadder].origin[1], ground));
					iPrintLn("Bottom of the ladder defined.");					
				}
				else
				{
					ground = undefined;
					level.laddermodel[curLadder].dist = Distance(player.origin, (level.laddermodel[curLadder].origin[0], level.laddermodel[curLadder].origin[1], player.origin[2]));
					iPrintLn("Mantle distance at the top of the ladder defined.");
				}
			}

			while(player SecondaryOffhandButtonPressed())
				wait .05;
		}
		else if(player UseButtonPressed())
		{
			if(placeNewLadder)
			{
				if(level.laddermodel.size > 0)
				{
					placeNewLadder = false;
					
					tempDist = 9999999;
					for(i=0;i<level.laddermodel.size;i++)
					{
						if(Distance(player.origin, level.laddermodel[i].origin) <= tempDist && Distance(player.origin, level.laddermodel[i].origin) <= 200)
						{
							tempDist = Distance(player.origin, level.laddermodel[i].origin);
							curLadder = i;
						}
					}
				}
				
				if(!isDefined(curLadder) || !isDefined(level.laddermodel[curLadder]))
				{
					iPrintLn("There is no ladder to pick up.");
					placeNewLadder = true;
				}
				else
				{
					if(isDefined(curLadder) && isDefined(level.laddermodel[curLadder]))
					{
						iPrintLn("Ladder for edit picked up.");
						level.laddermodel[curLadder] notify("ladderpickup");
					}
					else
					{
						iPrintLn("There is no ladder to pick up.");
						placeNewLadder = true;
					}
				}
			}
			else
			{
				if(isDefined(curLadder) && isDefined(level.laddermodel[curLadder]))
				{
					placeNewLadder = true;
					level.laddermodel[curLadder] thread DebugClimbPath();
					iPrintLn("Ladder placed.");
				}
			}
			
			while(player UseButtonPressed())			
				wait .05;
		}
		else if(player MeleeButtonPressed())
		{
			if(level.laddermodel.size > 0)
			{
				setdvar("logfile", 2);
				
				println("\n\n\n");
				println("//Ladders");
				println("	case \""+getdvar("mapname")+"\":");
			
				for(i=0;i<level.laddermodel.size;i++)
				{
					if(isDefined(level.laddermodel[i].origin) && isDefined(level.laddermodel[i].angles) && isDefined(level.laddermodel[i].ground) && isDefined(level.laddermodel[i].elevation) && isDefined(level.laddermodel[i].dist))
					{
						PrintLn("spawnLadderTrigger(" + i + ", " + level.laddermodel[i].ground + ", " + level.laddermodel[i].angles[1] + ", " + level.laddermodel[i].dist + ", " + level.laddermodel[i].elevation + ", 25, 20);");
						PrintLn("spawnLadderModel(" + level.laddermodel[i].origin + ", " + level.laddermodel[i].angles + ");");
					}
				}
				
				println("	break;");
				println("\n\n\n");

				setdvar("logfile", 0);
				iPrintLn("New ladders saved to the log.");
			}
		
			while(player MeleeButtonPressed())			
				wait .05;
		}
	}
}

DebugClimbPath()
{
	self endon("ladderpickup");
	
	if(!isDefined(self.ground) || !isDefined(self.elevation) || !isDefined(self.dist))
		return;
	
	color = (0,0,1);
	while(1)
	{
		line(self.ground, self.ground + (0,0,self.elevation), color);
		line(self.ground + (0,0,self.elevation), self.ground + (0,0,self.elevation) - AnglesToForward((0,self.angles[1],0))*self.dist, color);
		wait .05;
	}
}

/*--------------------------------------------------------------------------|
|							DevTool for Antiglitch							|
|							BlockerPlaceTool by Bipo						|
|--------------------------------------------------------------------------*/
BlockerPlaceTool() {
	self iPrintLnBold("^3[{+attack}] ^7= Start new blocker ^3OR ^7finish current");
	self iPrintLnBold("^3[{+frag}] ^7= Delete current blocker");
	self iPrintLnBold("^3[{+melee}] ^7= Save in log");

	fbp = 0;
	ubp = 0;
	lmbp = 0;
	mbp = 0;
	while (1) {
		if (self usebuttonpressed()){
			if (!ubp) {
				//free button
				ubp = 1;
			}
		}
		else {ubp = 0;}
		if (self fragbuttonpressed()){
			if (!fbp) {
				if (isdefined(level.trigger)) {
					level.trigger delete();
					iPrintLn("Blocker cancelled!");
				}
				fbp = 1;
			}
		}
		else { fbp = 0; }
		if (self attackbuttonpressed()){
			if (!lmbp) {
				placeBlockNode(self.origin);
				lmbp = 1;
			}
		}
		else { lmbp = 0; }
		if (self meleebuttonpressed()){
			if (!mbp) {
				saveBlockers();
				mbp = 1;
			}
		}
		else { mbp = 0; }
		wait 0.05;
	}
}

saveBlockers() {
	setdvar("logfile", 2);
	println("\n\n\n");
	
	name = "";
	if(getDvar("scr_devtool_edit") == "triggers")
	{
		name = "level.glitchtriggers";
		println("//Antiglitch-Triggers");
	}
	else
	{
		name = "level.blockers";
		println("//Antiglitch-Blockers");
	}

	if(!isDefined(name) || name == "")
		return;
	
	println("	case \""+getdvar("mapname")+"\":");
	
	for(i=0;i<level.triggers.size;i++)
	{
		trigger = level.triggers[i];
		println("		" + name + "["+i+"] = spawn(\"trigger_radius\", "+trigger.origin+",0, "+trigger.radius+", "+trigger.height+");");
	}
	
	println("	break;");
	println("\n\n\n");
	
	setdvar("logfile", 0);
	
	iPrintLn("Blockers saved to console log!");
}

placeBlockNode(origin) {
	if (!isdefined(level.trigger)) {
		trigger = spawn("trigger_radius", self.origin, 0, 100, 100);
		trigger.radius = 10;
		trigger.height = 10;
		trigger thread drawRadius((1,0,0));
		level.trigger = trigger;
		self thread updateRadius();
	}
	else
	{

		iPrintLn("Blocker placed!");
		trigger = spawn("trigger_radius", level.trigger.origin, 0, level.trigger.radius, level.trigger.height);
		trigger.radius = level.trigger.radius;
		trigger.height = level.trigger.height;
		level.triggers[level.triggers.size] = trigger;
		trigger thread drawRadius((1,1,1));
		trigger setcontents(1);
		level.trigger delete();
	}
}

updateRadius() {
	self endon("death");
	self endon("quitdraw");
	
	if (getdvar("max_radius")=="")
	setdvar("max_radius", 500);
	
	while (isdefined(level.trigger)) {
		level.trigger.radius = distance2d(level.trigger.origin,self.origin);
		if (level.trigger.radius > getdvarint("max_radius"))
		level.trigger.radius = getdvarint("max_radius");
		level.trigger.height = self.origin[2] + 52 - level.trigger.origin[2];
		wait 0.05;
	}
}

drawRadius(color) {
	self endon("death");
	self endon("quitdraw");
	precision = 10;
	angle = 0;
	dif = (cos(angle)*self.radius, sin(angle)*self.radius, 0);
	while (1)
	{
		for (i=0; i<precision; i++) 
		{
			difup = (0, 0, self.height);
			line(self.origin + dif, self.origin - dif, color);
			line(self.origin + dif + difup, self.origin - dif + difup, color);
			
			line(self.origin + dif, self.origin + dif + difup, color);
			line(self.origin - dif, self.origin - dif + difup, color);
			
			predif = dif;
			angle += 180/precision;
			dif = (cos(angle)*self.radius, sin(angle)*self.radius, 0);
			
			line(self.origin + predif, self.origin + dif, color);
			line(self.origin - predif, self.origin - dif, color);
			
			line(self.origin + predif + difup, self.origin + dif + difup, color);
			line(self.origin - predif + difup, self.origin - dif + difup, color);
			
		}
		wait .05;
	}
}

LaserPlaceTool()
{
	self endon("disconnect");
	self endon("death");

	self iPrintLnBold("^3[{+attack}] ^7= Place laser start/end");
	self iPrintLnBold("^3[{+activate}] ^7= Delete current laser");
	self iPrintLnBold("^3[{+melee}] ^7= Save in log");
	
	player = self;
	curLaser = undefined;
	placeNewLaser = true;

	while(1)
	{
		wait .05;
		
		if(player AttackButtonPressed())
		{
			target = PhysicsTrace(player getEye(), player getEye() + AnglesToForward(player getPlayerAngles())*99999);
			
			if(isDefined(target))
			{
				if(placeNewLaser)
				{
					if(isDefined(curLaser))
						curLaser++;
					else
					{
						if(!level.glitchtrace.size)
							curLaser = 0;
						else
							curLaser = level.glitchtrace.size;
					}
					
					placeNewLaser = false;					
					level.glitchtrace[curLaser] = spawn("script_origin", target);
					
					iPrintLn("Laser start defined.");
				}
				else
				{
					placeNewLaser = true;					
					level.glitchtrace[curLaser].end = spawn("script_origin", target);
					level.glitchtrace[curLaser] thread drawLaser();

					iPrintLn("Laser end defined.");
				}
			}
			
			while(player AttackButtonPressed())					
				wait .05;
		}
		else if(player UseButtonPressed())
		{
			if(!isDefined(curLaser))
				continue;
		
			if(isDefined(level.glitchtrace[curLaser]))
			{
				level.glitchtrace[curLaser] notify("laserdeleted");
				
				if(isDefined(level.glitchtrace[curLaser].end))
					level.glitchtrace[curLaser].end delete();
				
				if(isDefined(level.glitchtrace[curLaser]))
					level.glitchtrace[curLaser] delete();
					
				curLaser--;
			}
		
			while(player UseButtonPressed())			
				wait .05;
		}
		else if(player MeleeButtonPressed())
		{
			if(level.glitchtrace.size > 0)
			{
				setdvar("logfile", 2);
				
				println("\n\n\n");
				println("//Antiglitch-Lasers");
				println("	case \""+getdvar("mapname")+"\":");
			
				for(i=0;i<level.glitchtrace.size;i++)
				{
					if(isDefined(level.glitchtrace[i].origin) && isDefined(level.glitchtrace[i].end.origin))
					{
						PrintLn("	level.glitchtrace["+i+"] = spawn(\"script_origin\", " + level.glitchtrace[i].origin +  ");");
						PrintLn("	level.glitchtrace["+i+"].end = spawn(\"script_origin\", " + level.glitchtrace[i].end.origin +  ");");
					}
				}
				
				println("	break;");
				println("\n\n\n");
				
				setdvar("logfile", 0);
				iPrintLn("Lasers saved to the log.");
			}
		
			while(player MeleeButtonPressed())			
				wait .05;
		}
	}
}

drawLaser()
{
	self endon("laserdeleted");
	
	color = (1,0,0);
	while(1)
	{
		line(self.origin, self.end.origin, color);
		wait .05;
	}
}
/*--------------------------------------------------------------------------|
|					DevTool to show heli/ac130 flypath						|
|--------------------------------------------------------------------------*/
drawAC130FlyRadius()
{
	wait 5;

	angle = 0;
	precision = 10;
	color = (0,1,0);
	origin = level.mapCenter + (0, 0, GetSkyHeight());
	radius = Distance(level.spawnMins, level.mapCenter);
	dif = (cos(angle)*radius, sin(angle)*radius, 0);
	
	if(radius > level.ac130FlyRadius)
		radius = level.ac130FlyRadius;
	
	while(getDvarInt("scr_devtool") && getDvarInt("scr_devtool_flypath"))
	{
		for(i=0;i<precision;i++)
		{
			predif = dif;
			angle += 180/precision;
			dif = (cos(angle)*radius, sin(angle)*radius, 0);
			
			line(origin + predif, origin + dif, color);
			line(origin - predif, origin - dif, color);
			
			line(origin + predif, origin + dif, color);
			line(origin - predif, origin - dif, color);
			
		}
		wait .05;
	}
}

drawHeliFlyPath()
{
	wait 5;
	
	if(!isDefined(level.heli_loop_paths) || !level.heli_loop_paths.size)
	{
		iPrintLnBold("This map has no heli path");
		return;
	}

	currentnode = level.heli_loop_paths[0];
	
	while(isDefined(currentnode.target))
	{
		nextnode = getEnt(currentnode.target, "targetname");
		
		thread debugHeliFlyPath(currentnode, nextnode);
		
		if(!isDefined(nextnode.target) || nextnode == level.heli_loop_paths[0])
			break;
		
		currentnode = nextnode;
		wait .05;
	}
}

debugHeliFlyPath(currentnode, nextnode)
{
	color = (0,1,0);
	while(getDvarInt("scr_devtool") && getDvarInt("scr_devtool_flypath"))
	{
		line(currentnode.origin, nextnode.origin, color);
		wait .05;
	}
}

/*--------------------------------------------------------------------------|
|					DevTool to setup the waypoints for bots					|
|--------------------------------------------------------------------------*/
drawWP()
{
	while(1)
	{
		for(i=0;i<level.waypoints.size;i++)
		{
			line(level.waypoints[i].origin, level.waypoints[i].origin + (0,0,96), (0,1,0), 1);
			
			for(j=0;j<level.waypoints[i].childCount;j++)
				line(level.waypoints[i].origin, level.waypoints[level.waypoints[i].children[j]].origin, (0,0,1), 1);
		}
		
		wait 0.05;
	}
}

drawSpawns()
{
	entities = getEntArray();

	for(i=0;i<entities.size;i++)
	{
		if(isDefined(entities[i].classname))
		{
			switch(entities[i].classname)
			{
				case "mp_tdm_spawn":
				case "mp_tdm_spawn_axis_start":
				case "mp_tdm_spawn_allies_start":
					spawnModel = spawn("script_model", entities[i].origin);
					spawnModel.angles = entities[i].angles;
					spawnModel setModel("body_complete_mp_kennedy");

				default: break;
			}
		}
	}
}

WaypointTool()
{
	self iPrintLnBold("^3[{+attack}] ^7= Add new waypoint");
	self iPrintLnBold("^3[{+ads}] ^7= Change waypoint type");
	self iPrintLnBold("^3[{+use}] ^7= Link waypoints");
	self iPrintLnBold("^3[{+smoke}] ^7= Un-Link waypoints");
	self iPrintLnBold("^3[{+frag}] ^7= Delete closest waypoint");
	self iPrintLnBold("^3[{+melee}] ^7= Save waypoints to log");

    level.wpToLink = -1;
    level.wpToChange = -1;
    level.linkSpamTimer = gettime();
    level.saveSpamTimer = gettime();
    level.changeSpamTimer = gettime();
	
	maps\_waypoints::loadPezBotWaypoints();
	maps\_waypoints::loadWaypoints();
	thread drawSpawns();
	thread drawWP();
	
	while(1)
	{
		if(self attackbuttonpressed())
		{
			self AddWaypoint();
		
			while(self attackbuttonpressed())
				wait .05;
		}
		
		if(self adsbuttonpressed())
		{
			self ChangeWaypointType();
		
			while(self adsbuttonpressed())
				wait .05;
		}
		
		if(self useButtonPressed())
		{
			self DeleteWaypoint();
		
			while(self useButtonPressed())
				wait .05;
		}
		
		if(self secondaryoffhandbuttonpressed())
		{
			self LinkWaypoint();
		
			while(self secondaryoffhandbuttonpressed())
				wait .05;
		}
		
		if(self fragbuttonpressed())
		{
			self UnLinkWaypoint();
		
			while(self fragbuttonpressed())
				wait .05;
		}
		
		if(self meleebuttonpressed())
		{
			self SaveStaticWaypoints();
		
			while(self meleebuttonpressed())
				wait .05;
		}
		
		wait 0.05;
	}
}

AddWaypoint()
{
	pos = self.origin;
    for(i=0;i<level.waypoints.size;i++)
    {
        if(Distance(level.waypoints[i].origin, pos) <= 30.0)
            return;
    }

	level.waypointCount = level.waypoints.size;
	level.waypoints[level.waypointCount] = spawnstruct();
    level.waypoints[level.waypointCount].origin = pos;
    level.waypoints[level.waypointCount].type = "stand";
    level.waypoints[level.waypointCount].children = [];
    level.waypoints[level.waypointCount].childCount = 0;

    iprintln("Added Waypoint " + level.waypointCount); 
}

ChangeWaypointType()
{
    if((gettime()-level.changeSpamTimer) < 1000)
		return;

    level.changeSpamTimer = gettime();
    wpTochange = -1;
	pos = self.origin;
  
    for(i=0;i<level.waypoints.size;i++)
    {
        if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
            wpTochange = i;
            break;
        }
    }
  
	if(wpTochange != -1)
    {
        if(level.waypoints[wpTochange].type == "stand")
        {
			iprintln(&"DEBUG_CHANGE_CLIMB");
            level.waypoints[wpTochange].type = "climb";
			level.waypoints[wpTochange].angles = self getplayerangles();
			return;
        }
		
		if(level.waypoints[wpTochange].type == "climb")
        { 
			iprintln(&"DEBUG_CHANGE_NORMAL");
            level.waypoints[wpTochange].type = "stand";
			level.waypoints[wpTochange].angles = -1;
			return;
        }
    }
}

DeleteWaypoint()
{
	pos = self.origin;
    for(i=0;i<level.waypoints.size;i++)
    {
        if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
			//remove all links in children
            //for each child c
            for(c=0;c<level.waypoints[i].childCount;c++)
            {
                //remove links to its parent i
                for(c2=0;c2<level.waypoints[level.waypoints[i].children[c]].childCount;c2++)
                {
                    // child of i has a link to i as one of its children, so remove it
                    if(level.waypoints[level.waypoints[i].children[c]].children[c2] == i)
                    {
                        //remove entry by shuffling list over top of entry
                        for(c3 = c2; c3 < level.waypoints[level.waypoints[i].children[c]].childCount-1; c3++)
                            level.waypoints[level.waypoints[i].children[c]].children[c3] = level.waypoints[level.waypoints[i].children[c]].children[c3+1];

                        //removed child
                        level.waypoints[level.waypoints[i].children[c]].childCount--;
                        break;
                    }
                }
            }
      
			//remove waypoint from list
			for(x=i;x<level.waypoints.size;x++)
				level.waypoints[x] = level.waypoints[x+1];
	  
            //reassign all child links to their correct values
            for(r=0;r<level.waypoints.size;r++)
            {
                for(c=0;c<level.waypoints[r].childCount;c++)
                {
                    if(level.waypoints[r].children[c] > i)
                        level.waypoints[r].children[c]--;
                }
            }
			
            iprintln("Deleted Waypoint " + i);
            return;
        }
    }
}

LinkWaypoint()
{
    //dont spam linkage
    if((gettime()-level.linkSpamTimer) < 1000)
        return;

    level.linkSpamTimer = gettime();
    wpToLink = -1;
	pos = self.origin;
  
    for(i=0;i<level.waypoints.size;i++)
    {
        if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
            wpToLink = i;
            break;
        }
    }
  
    //if the nearest waypoint is valid
    if(wpToLink != -1)
    {
        //if we have already pressed link on another waypoint, then link them up
        if(level.wpToLink != -1 && level.wpToLink != wpToLink)
        {
            level.waypoints[level.wpToLink].children[level.waypoints[level.wpToLink].childcount] = wpToLink;
            level.waypoints[level.wpToLink].childcount++;
      
            level.waypoints[wpToLink].children[level.waypoints[wpToLink].childcount] = level.wpToLink;
            level.waypoints[wpToLink].childcount++;
      
            iprintln("Waypoint " + wpToLink + " Linked to " + level.wpToLink);
            level.wpToLink = -1;
        }
        else //otherwise store the first link point
        {
            level.wpToLink = wpToLink;
            iprintln("Waypoint Link Started");
        }
    }
    else
    {
        level.wpToLink = -1;
        iprintln("Waypoint Link Cancelled");
    }
}

UnLinkWaypoint()
{
    //dont spam linkage
    if((gettime()-level.linkSpamTimer) < 1000)
        return;

    level.linkSpamTimer = gettime();
    wpToLink = -1;
	pos = self.origin;
  
    for(i=0;i<level.waypoints.size;i++)
    {
		if(Distance(level.waypoints[i].origin, pos) <= 30.0)
        {
            wpToLink = i;
            break;
        }
    }
  
    //if the nearest waypoint is valid
    if(wpToLink != -1)
    {
        //if we have already pressed link on another waypoint, then break the link
        if(level.wpToLink != -1 && level.wpToLink != wpToLink)
        {
            //do first waypoint
            for(i=0;i<level.waypoints[level.wpToLink].childCount;i++)
            {
                if(level.waypoints[level.wpToLink].children[i] == wpToLink)
                {
                    //shuffle list down
                    for(c=i;c<level.waypoints[level.wpToLink].childCount-1;c++)
                        level.waypoints[level.wpToLink].children[c] = level.waypoints[level.wpToLink].children[c+1];

                    level.waypoints[level.wpToLink].childCount--;
                    break;
                }
            }
      
            //do second waypoint  
            for(i=0;i<level.waypoints[wpToLink].childCount;i++)
            {
                if(level.waypoints[wpToLink].children[i] == level.wpToLink)
                {
                    //shuffle list down
                    for(c=i;c<level.waypoints[wpToLink].childCount-1;c++)
                        level.waypoints[wpToLink].children[c] = level.waypoints[wpToLink].children[c+1];

                    level.waypoints[wpToLink].childCount--;
                    break;
                }
            }
      
            iprintln("Waypoint " + wpToLink + " Broken to " + level.wpToLink);
            level.wpToLink = -1;
        }
        else //otherwise store the first link point
        {
            level.wpToLink = wpToLink;
            iprintln("Waypoint De-Link Started");
        }
    }
    else
    {
        level.wpToLink = -1;
        iprintln("Waypoint De-Link Cancelled");
    }
}

SaveStaticWaypoints()
{
	if((gettime()-level.saveSpamTimer) < 1500)
		return;

	level.saveSpamTimer = gettime();
	setDvar("logfile", 1);

	mapname = tolower(getDvar("mapname"));
	filename = mapname + "_waypoints.gsc";

	info = [];
	info[0] = "// =========================================================================================";
	info[1] = "// File Name = '" + filename + "'";
	info[2] = "// Map Name  = '" + mapname + "'";
	info[3] = "// =========================================================================================";
	info[4] = "// ";
	info[5] = "// This is an auto generated script file created by the PeZBOT Mod - DO NOT MODIFY!";
	info[6] = "// ";
	info[7] = "// =========================================================================================";
	info[8] = "// ";
	info[9] = "// This file contains the waypoints for the map '" + mapname + "'.";	
	info[10] = "// ";
	info[11] = "// You now need to save this file as the file name at the top of this file.";
	info[12] = "// in the 'waypoint.iwd' file in a folder called the same as the map name.";
	info[13] = "// Delete the first two lines of this file and the 'Dvar set logfile 0' at the end of the file.";
	info[14] = "// Create the new folder if you havent already done so and rename it to the map name.";
	info[15] = "// So - new_waypoints.iwd/" + filename;
	info[16] = "// ";
	info[17] = "// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.";
	info[18] = "// just follow the instructions at the top of the file. you will need to add the following code.";
	info[19] = "// I couldnt output double quotes to file so replace the single quotes with double quotes.";
	info[20] = "// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.";
	info[21] = "/*";
	info[22] = " ";
	info[23] = "    else if(mapname == '"+ mapname +"')";
	info[24] = "    {";
	info[25] = "        thread Waypoints/" + mapname + "_waypoints::load_waypoints();";
	info[26] = "    }";
	info[27] = " ";
	info[28] = "*/ ";
	info[29] = "// =========================================================================================";
	info[30] = " ";	
	
	for(i = 0; i < info.size; i++)
		println(info[i]);
	
	scriptstart = [];
	scriptstart[0] = "load_waypoints()";
	scriptstart[1] = "{";
	
	for(i = 0; i < scriptstart.size; i++)
		println(scriptstart[i]);

	for(w=0;w<level.waypoints.size;w++)
	{
		waypointstruct = "    level.waypoints[" + w + "] = spawnstruct();";
		println(waypointstruct);
	
		waypointstring = "    level.waypoints[" + w + "].origin = "+ "(" + level.waypoints[w].origin[0] + "," + level.waypoints[w].origin[1] + "," + level.waypoints[w].origin[2] + ");";
		println(waypointstring);

		waypointtype = "    level.waypoints[" + w + "].type = " + "\"" + level.waypoints[w].type + "\"" + ";";
		println(waypointtype);
		
		waypointchild = "    level.waypoints[" + w + "].childCount = " + level.waypoints[w].childCount + ";";
		println(waypointchild);

		for(c=0;c<level.waypoints[w].childCount;c++)
		{
			childstring = "    level.waypoints[" + w + "].children[" + c + "] = " + level.waypoints[w].children[c] + ";";
			println(childstring);      
		}
		
		if(level.waypoints[w].type == "climb" || level.waypoints[w].type == "mantle" || level.waypoints[w].type == "jump" || level.waypoints[w].type == "plant")
		{
		    waypointangle = "    level.waypoints[" + w + "].angles = " + level.waypoints[w].angles + ";";
			println(waypointangle);
		}
		
		if(level.waypoints[w].type == "climb" || level.waypoints[w].type == "mantle" || level.waypoints[w].type == "plant")
		{
			waypointusestate = "    level.waypoints[" + w + "].use = true;";
			println(waypointusestate);
		}
	}
	
	scriptmiddle = [];
	scriptmiddle[0] = " ";
	scriptmiddle[1] = "    level.waypointCount = level.waypoints.size;";
	scriptmiddle[2] = " ";
	
	for(i=0;i<scriptmiddle.size;i++)
		println(scriptmiddle[i]);
	
	scriptend = [];
	scriptend[0] = "}";
	
	for(i = 0; i < scriptend.size; i++)
		println(scriptend[i]);

	setDvar("logfile", 0);

	wait 1;
	iprintlnBold("^0Waypoints Outputted To Console Log In Mod Folder");
	wait 1;
	iprintlnBold("^0Close Game & Follow Instructions In File");
}