#include maps\mp\gametypes\_misc;

loadPezBotWaypoints()
{
	waypoints\select_map::choose();
}

/**
* Loads the levels waypoints from a csv file and convertes them for the gamemode.
*/
loadWaypoints()
{
	// workaround for maps with script waypoints, e.g stock maps
	if(isDefined(level.waypoints) && level.waypoints.size > 0)
		return level.waypoints.size;

	level.waypoints = [];
	level.waypointCount = 0;
	level.waypointLoops = 0;

	// create the full filepath for the waypoint csv file
	fileName =  "waypoints/"+ toLower(getDvar("mapname")) + "_waypoints.csv";
/#	printLn("Getting waypoints from csv: "+fileName);		#/

	// get the waypoint count, then get all the waypoint data
	level.waypointCount = int(tableLookup(fileName, 0, 0, 1));
	for(i=0; i<level.waypointCount; i++)
	{
		// create a struct for each waypoint
		waypoint = spawnStruct();
		
		// get the origin and seperate it into x, y and z values
		origin = tableLookup(fileName, 0, i+1, 1);
		orgToks = strtok(origin, " ");
		
		// convert the origin to a vector3
		waypoint.origin = (float(orgToks[0]), float(orgToks[1]), float(orgToks[2]));
		
		// save the waypoint into the waypoints array
		level.waypoints[i] = waypoint;
	}

	// go through all waypoints and link them
	for(i=0; i<level.waypointCount; i++)
	{
		waypoint = level.waypoints[i]; 
		
		// get the children waypoint IDs and seperate them
		strLnk = tableLookup(fileName, 0, i+1, 2);
		tokens = strTok(strLnk, " ");
		
		// set the waypoints children count
		waypoint.childCount = tokens.size;
		
		// add all the children as integers
		for(j=0; j<tokens.size; j++)
			waypoint.children[j] = int(tokens[j]);
	}
	
	return level.waypoints.size;
}

/**
* Returns the ID of the waypoint closest to the given origin, -1 if none is found.
*
*	@origin: Origin to find the closest waypoint to
*/
getNearestWp(origin)
{
	// set initial values for the waypoint
	nearestWp = -1;
	nearestDist = 9999999999;

	// loop through all waypoints
	for(i = 0; i < level.waypointCount; i++)
	{
		// get the squared distance
		dist = distanceSquared(origin, level.waypoints[i].origin);
    
		// check if the distance is closer than the currently closest
		if(dist < nearestDist)
		{
			// memorize the current waypoint
			nearestDist = dist;
			nearestWp = i;
		}
	}

	// return the ID of the closest waypoint
	return nearestWp;
}

// 
/**
* Returns the A-Star path from one waypoint to another.
*	Note: ASTAR PATHFINDING ALGORITHM: CREDITS GO TO PEZBOTS!
*
*	@startWp: ID of the starting waypoint
*	@goalWp: ID of the target waypoint
*/
AStarSearch(startWp, goalWp)
{
	// info regarding the A-Star Algorithm can be found here:
	// https://en.wikipedia.org/wiki/A*_search_algorithm

	if(!isDefined(level.waypoints[startWp]) || !isDefined(level.waypoints[goalWp]))
		return -1;
	
	pQOpen = [];
	pQSize = 0;
	closedList = [];
	listSize = 0;

	s = spawnStruct();
	s.g = 0; //start node
	s.h = distance(level.waypoints[startWp].origin, level.waypoints[goalWp].origin);
	s.f = s.g + s.h;
	s.wpIdx = startWp;
	s.parent = spawnStruct();
	s.parent.wpIdx = -1;

	//push s on Open
	pQOpen[pQSize] = spawnStruct();
	pQOpen[pQSize] = s; //push s on Open
	pQSize++;

	// while Open is not empty  
	while(!PQIsEmpty(pQOpen, pQSize))
	{
		// pop node n from Open  // n has the lowest f
		n = pQOpen[0];
		highestPriority = 9999999999;
		bestNode = -1;
		for(i=0; i<pQSize; i++)
		{
			if(pQOpen[i].f < highestPriority)
			{
				bestNode = i;
				highestPriority = pQOpen[i].f;
			}
		}
    
		if(bestNode != -1)
		{
			n = pQOpen[bestNode];
			//remove node from queue    
			for(i=bestNode; i<pQSize-1; i++)
			{
				pQOpen[i] = pQOpen[i+1];
			}
			pQSize--;
		}
		else
		{
			return -1;
		}
		
		// if n is a goal node; construct path, return success
		if(n.wpIdx == goalWp)
		{
			x = n;
			for(z=0; z<1000; z++)
			{
				parent = x.parent;
				if(parent.parent.wpIdx == -1)
					return x.wpIdx;
				
				//thread DrawDebugLine(level.waypoints[x.wpIdx].origin, level.waypoints[parent.wpIdx].origin, (0,1,0));
				
				x = parent;
			}
			
			return -1;      
		}
		
		// for each successor nc of n
		for(i=0; i<level.waypoints[n.wpIdx].childCount; i++)
		{
			//newg = n.g + cost(n,nc)
			newg = n.g + distance(level.waypoints[n.wpIdx].origin, level.waypoints[level.waypoints[n.wpIdx].children[i]].origin);
      
			//if nc is in Open or Closed, and nc.g <= newg then skip
			if(PQExists(pQOpen, level.waypoints[n.wpIdx].children[i], pQSize))
			{
				//find nc in open
				nc = spawnStruct();
				for(p=0; p<pQSize; p++)
				{
					if(pQOpen[p].wpIdx == level.waypoints[n.wpIdx].children[i])
					{
						nc = pQOpen[p];
						break;
					}
				}
				
				if(nc.g <= newg)
				{
					continue;
				}
			}
			else if(PQExists(closedList, level.waypoints[n.wpIdx].children[i], listSize))
			{
				//find nc in closed list
				nc = spawnStruct();
				for(p=0; p<listSize; p++)
				{
					if(closedList[p].wpIdx == level.waypoints[n.wpIdx].children[i])
					{
						nc = closedList[p];
						break;
					}
				}
				
				if(nc.g <= newg)
				{
					continue;
				}
			}
			
			nc = spawnStruct();
			nc.parent = n;
			nc.g = newg;
			nc.h = distance(level.waypoints[level.waypoints[n.wpIdx].children[i]].origin, level.waypoints[goalWp].origin);
			nc.f = nc.g + nc.h;
			nc.wpIdx = level.waypoints[n.wpIdx].children[i];
			
			//if nc is in Closed,
			if(PQExists(closedList, nc.wpIdx, listSize))
			{
				//remove it from Closed
				deleted = false;
				for(p=0; p<listSize; p++)
				{
					if(closedList[p].wpIdx == nc.wpIdx)
					{
						for(x=p; x<listSize-1; x++)
							closedList[x] = closedList[x+1];
						
						deleted = true;
						break;
					}
					
					if(deleted)
						break;
				}
				listSize--;
			}
			
			// if nc is not yet in Open, 
			if(!PQExists(pQOpen, nc.wpIdx, pQSize))
			{
				//push nc on Open
				pQOpen[pQSize] = nc;
				pQSize++;
			}
		}
		
		// Done with children, push n onto Closed
		if(!PQExists(closedList, n.wpIdx, listSize))
		{
			closedList[listSize] = n;
			listSize++;
		}
	}
}


/**
* Returns true if the open list is empty
*
*	@Q: Open List
*	@QSize: Size of Open List
*/
PQIsEmpty(Q, QSize)
{
	if(QSize <= 0)
	{
		return true;
	}

	return false;
}


/**
* Returns true if n exists in the array Q
*
*	@Q: Array of waypoints
*	@n: Waypoint
*	@QSize: Size of array Q
*/
PQExists(Q, n, QSize)
{
	for(i=0; i<QSize; i++)
	{
		if(Q[i].wpIdx == n)
			return true;
	}

	return false;
}

ValidateNextWP(nextWp)
{
	if(!isDefined(nextWp) || !isDefined(level.waypoints[nextWp]))
		return -1;

	//Sometimes the bot can not move to self.nextWp because there is a wall between his origin and self.nextWp
	//This happens because self.myWaypoint is used to find the self.nextWp, but self.myWaypoint is not equal to self.origin
	//So if the bot can not freely move to self.nextWp we let him move to self.myWaypoint first
	trace = BulletTrace(self getEye(), level.waypoints[nextWp].origin + level.WpSightOffset, false, self);
			
	if(trace["fraction"] < 1)
	{
		nextWp = self.myWaypoint;
		
		//might be a ladder
		if(abs(self.origin[2] - level.waypoints[nextWp].origin[2]) < 150)
		{
			//perform a second to see if his self.myWaypoint is not behind a wall (like crash the garage corner at the shelf)
			trace = BulletTrace(self getEye(), level.waypoints[nextWp].origin + level.WpSightOffset, false, self);
					
			if(trace["fraction"] < 1)
			{
				//get the closest waypoint with a free path
				nextWp = getNearestWpWithFreePath(self getEye());
			}
		}
	}
		
	return nextWp;
}

getNearestWpWithFreePath(origin)
{
	// set initial values for the waypoint
	nearestWp = -1;
	nearestDist = 9999999999;

	// loop through all waypoints
	for(i = 0; i < level.waypointCount; i++)
	{
		// get the squared distance
		dist = distanceSquared(origin, level.waypoints[i].origin);
		trace = BulletTrace(origin, level.waypoints[i].origin + (0,0,50), false, undefined);
    
		// check if the distance is closer than the currently closest
		if(dist < nearestDist && trace["fraction"] == 1)
		{
			// memorize the current waypoint
			nearestDist = dist;
			nearestWp = i;
		}
	}

	// return the ID of the closest waypoint
	return nearestWp;
}