#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>
#include <unistd.h>

#include "../pinc.h"

/****************************
	Definitions
****************************/
#define global_maxallowed_waypoints 9999

struct global_waypoint
{
	float origin[3];
	short childCount;
	short children[global_maxallowed_waypoints];
	char type[1024];
};

int global_total_waypoints = 0;
struct global_waypoint global_waypoints[global_maxallowed_waypoints];

typedef vec_t vec3_t[3];


/****************************
	functions
****************************/
#define VectorSubtract(a,b,c) ((c)[0]=(a)[0]-(b)[0],(c)[1]=(a)[1]-(b)[1],(c)[2]=(a)[2]-(b)[2])

//import a vector from gsc call
extern void Scr_GetVector( unsigned int, float* );

//return the distance between two vectors
extern float VectorDistance( vec3_t v1, vec3_t v2 );

//add prefix to string
char* stringAddPrefix(char *string, char *prefix)
{
	if(string[0] == prefix[0])
		return string;

	char *tempString;
	int len=0;

	tempString = (char*) malloc(strlen(string)+1 * sizeof(char));
	if(tempString == NULL)
		return NULL;

	strcpy(tempString, prefix);
	strcat(tempString, string);
	strcpy(string, tempString);

	free(tempString);
	return string;
}

//removes the last char from string
void chomp(char *str) 
{
	int length = strlen(str);
	// letzten Char (hier: '\n') mit '\0' überschreiben
	if(length >= 1)
		str[length-1]='\0';
}

//removes chars from string
char* stringRemoveChars(char *string, char *removeablechars)
{
	char *ptr = string;
	ptr = strpbrk(ptr, removeablechars);
	
	while(ptr != NULL)
	{
		*ptr = ' ';
		ptr = strpbrk(ptr, removeablechars);
	}
	
	return string;
}

//replace char/string within a string
char* stringReplace(char *search, char *replace, char *string)
{
	char *tempString, *searchStart;
	int len=0;

	while(strstr(string, search) != NULL)
	{
		searchStart = strstr(string, search);
		tempString = (char*) malloc(strlen(string) * sizeof(char));
		if(tempString == NULL)
			return NULL;

		strcpy(tempString, string);

		len = searchStart - string;
		string[len] = '\0';

		strcat(string, replace);

		len += strlen(search);
		strcat(string, (char*)tempString+len);
	}

	free(tempString);
	return string;
}

//convert a string formatted vector to a real vector
float* stringtovector(char *string)
{
	int m = 0;
	char* vector[3];
	stringRemoveChars(string, "()");

	char* delimiter = ",";
	if(strchr(string, ',') == NULL)
		delimiter = " ";

	char* split = strtok(string, delimiter);
	while(split != NULL)
	{
		vector[m++] = split;
		split = strtok(NULL, delimiter);
	}

	static float vector_converted[3];
	for(int i=0;i<3;++i)
		vector_converted[i] = (float)atof(vector[i]);

	return vector_converted;
}

//returns the waypoint id of the closest waypoint
void getNearestWp()
{
	if (Plugin_Scr_GetNumParam() != 1)
		Plugin_Scr_Error("Missing paramter. usage: getNearestWp(origin)\n");

	vec3_t origin;
	Scr_GetVector(0, origin);
	
	// set initial values for the waypoint
	int nearestWp = -1;
	float nearestDist = 99999999.99;

	// loop through all waypoints
	for(int i=0; i<global_total_waypoints; ++i)
	{
		// get the distance
		float dist = VectorDistance(origin, global_waypoints[i].origin);
	
		// check if the distance is closer than the currently closest
		if(dist < nearestDist)
		{
			// memorize the current waypoint
			nearestDist = dist;
			nearestWp = i;
		}
	}

	//if no waypoint is found then return undefined
	if(nearestWp == -1)
	{
		Plugin_Scr_AddUndefined();
		return;
	}

	// return the ID of the closest waypoint
	Plugin_Scr_AddInt(nearestWp);
}

void getRandomWp()
{
	if(global_total_waypoints == 0)
		Plugin_Scr_AddUndefined();
	else
	{
		int index = rand() % global_total_waypoints;
		Plugin_Scr_AddInt(index);
	}
}

void getWaypointValue()
{
	if (Plugin_Scr_GetNumParam() != 2)
		Plugin_Scr_Error("Missing paramter. usage: getWaypointValue(waypointID (int), valuename (string))\n");

	int wpdId = Plugin_Scr_GetInt(0);
	char *valueName = Plugin_Scr_GetString(1);

	if(wpdId < 0 || wpdId >= global_total_waypoints)
	{
		char errormsg[1024];
		sprintf(errormsg, "Waypoint %d does not exist\n", wpdId);
		Plugin_Scr_Error(errormsg);
	}

	if(strcmp(valueName, "origin") == 0)
		Plugin_Scr_AddVector(global_waypoints[wpdId].origin);
	else if(strcmp(valueName, "childCount") == 0)
		Plugin_Scr_AddInt(global_waypoints[wpdId].childCount);
	else if(strcmp(valueName, "children") == 0)
	{
		Plugin_Scr_MakeArray();
		for(int i=0;i<global_waypoints[wpdId].childCount;++i)
		{
			Plugin_Scr_AddInt(global_waypoints[wpdId].children[i]);
			Plugin_Scr_AddArray();
		}
	}
	else if(strcmp(valueName, "type") == 0)
	{
		Plugin_Scr_AddString(global_waypoints[wpdId].type);
	}
	else
	{
		Plugin_Scr_Error("Second paramter has to be \"origin\", \"childCount\", \"children\" or \"type\")\n");
	}
}

struct pQOpen_struct
{
	int	g;
	float	h;
	float	f;
	int	wpIdx;
	int	parent;
};

int PQIsEmpty(int QSize)
{
	if(QSize <= 0)
		return 1;

	return 0;
}

int PQExists(struct pQOpen_struct Q[999], int n, int QSize)
{
	for(int i=0; i<QSize; i++)
	{
		if(Q[i].wpIdx == n)
			return 1;
	}

	return 0;
}

void AStarSearch()
{
	if (Plugin_Scr_GetNumParam() != 2)
		Plugin_Scr_Error("Missing paramter. usage: var = AStarSearch(startWp (int), goalWp(int))\n");

	int startWp = Plugin_Scr_GetInt(0);
	int goalWp = Plugin_Scr_GetInt(1);

	if(startWp < 0 || startWp >= global_total_waypoints)
	{
		Plugin_Scr_AddUndefined();
		return;
	}

	if(goalWp < 0 || goalWp >= global_total_waypoints)
	{
		Plugin_Scr_AddUndefined();
		return;
	}

	if(goalWp == startWp)
	{
		Plugin_Scr_AddInt(startWp);
		return;
	}

/*
this is not a solution which can be used simply because it's searching for
the lowest f from current position to the final target.
this means that always the closest step (= closest child from current position)
is used but the "closest" next step is not the same as the "best" next step.
to find the "best" step the shortest path has to be calculated first.
sooo... sadly we have to stick with the a* algorithm

	struct waypoint_struct current;
	current.g = 0.0;
	current.h = VectorDistance(global_waypoints[startWp].origin, global_waypoints[goalWp].origin);
	current.f = current.g + current.h;
	current.wpIdx = startWp;
	
	struct waypoint_struct child;
	child = current;

	struct waypoint_struct next;
	next = current;

	double curf = 0.0;
	double newg = 0.0;
	int nextMovementWp = -1;
	int previousMovementWp = -1;

	//do i really have to calculate the whole path?
	//wouldn't it be enough to calculate the next step only
	//while(current.wpIdx != goalWp && previousMovementWp != next.wpIdx)
	{
		for(int a=0; a<global_waypoints[current.wpIdx].childCount; ++a)
		{
			child.g = next.g + VectorDistance(global_waypoints[current.wpIdx].origin, global_waypoints[global_waypoints[current.wpIdx].children[a]].origin);
			child.h = VectorDistance(global_waypoints[global_waypoints[current.wpIdx].children[a]].origin, global_waypoints[goalWp].origin);
			child.f = child.g + child.h;
			child.wpIdx = global_waypoints[current.wpIdx].children[a];

			//break if there is only one children (this works)
			if(global_waypoints[next.wpIdx].childCount == 1)
			{
				next = child;
				//Plugin_Printf("Next/Only WP: %d\n", next.wpIdx);
				break;
			}

			//skip the child if it's the place we came from (this works for the while loop only)
			if(child.wpIdx == startWp || child.wpIdx == previousMovementWp)
			{
				//if(child.wpIdx == startWp)
				//	Plugin_Printf("Skip Child: %d - Reason: %d is the startWp\n", child.wpIdx, startWp);

				//if(child.wpIdx == previousMovementWp)
				//	Plugin_Printf("Skip Child: %d - Reason: %d is the previous WP\n", child.wpIdx, previousMovementWp);

				continue;
			}

			Plugin_Printf("curf: %f - child_f: %f - child: %d\n", curf, child.f, child.wpIdx);

			if(child.f <= curf || curf == 0.0)
			{
				//Plugin_Printf("Changed WP: %d\n", child.wpIdx);
				next = child;
				curf = child.f;
			}
		}

		previousMovementWp = current.wpIdx;

		//Plugin_Printf("Test WP: %d\n", next.wpIdx);
		current = next;
		curf = 0.0;

		if(nextMovementWp == -1)
			nextMovementWp = next.wpIdx;
	}

	//return the very first child
	if(nextMovementWp != -1)
	{
		Plugin_Printf("Next WP: %d - Goal: %d\n", nextMovementWp, goalWp);
		Plugin_Scr_AddInt(nextMovementWp);
		return;
	}

	Plugin_Scr_AddUndefined();
*/

	struct pQOpen_struct pQOpen[global_maxallowed_waypoints];
	struct pQOpen_struct closedList[global_maxallowed_waypoints];
	struct pQOpen_struct calculatedPath[global_maxallowed_waypoints];

	int pQSize = 0;
	int listSize = 0;
	int pathSize = 0;

	//push s on Open
	pQOpen[pQSize].g = 0;
	pQOpen[pQSize].h = VectorDistance(global_waypoints[startWp].origin, global_waypoints[goalWp].origin);
	pQOpen[pQSize].f = pQOpen[pQSize].g + pQOpen[pQSize].h;
	pQOpen[pQSize].wpIdx = startWp;
	pQOpen[pQSize].parent = -1;

	pQSize++;

	struct pQOpen_struct nc;
	struct pQOpen_struct n;
	struct pQOpen_struct x;

	while(!PQIsEmpty(pQSize))
	{
		// pop node n from Open  // n has the lowest f
		n = pQOpen[0];
		int highestPriority = 999999999;
		int bestNode = -1;
		for(int i=0; i<pQSize; ++i)
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
			for(int j=bestNode; j<pQSize-1; ++j)
				pQOpen[j] = pQOpen[j+1];

			pQSize--;
		}
		else
		{
			Plugin_Scr_AddUndefined();
			return;
		}
		
		// if n is a goal node; construct path, return success
		if(n.wpIdx == goalWp)
		{
			x = n;

			//better a for loop instead of an infinite while loop
			for(int z=0; z<999; ++z)
			{
				//if the parent of the current WP is the startWP then this is our next step
				if(x.parent == startWp)
				{
					Plugin_Scr_AddInt(x.wpIdx);
					return;
				}

				for(int o=pathSize;o>=0;--o)
				{
					if(calculatedPath[o].wpIdx == x.parent)
					{
						x = calculatedPath[o];
						break;
					}
				}
			}

			Plugin_Scr_AddUndefined();
			return; 
		}
		
		for(int a=0; a<global_waypoints[n.wpIdx].childCount; ++a)
		{
			int newg = n.g + VectorDistance(global_waypoints[n.wpIdx].origin, global_waypoints[global_waypoints[n.wpIdx].children[a]].origin);
	  
			//if nc is in Open or Closed, and nc.g <= newg then skip
			if(PQExists(pQOpen, global_waypoints[n.wpIdx].children[a], pQSize))
			{
				//find nc in open
				for(int p=0; p<pQSize; p++)
				{
					if(pQOpen[p].wpIdx == global_waypoints[n.wpIdx].children[a])
					{
						nc = pQOpen[p];
						break;
					}
				}

				if(nc.g <= newg)
					continue;
			}
			else if(PQExists(closedList, global_waypoints[n.wpIdx].children[a], listSize))
			{
				//find nc in closed list
				for(int p=0; p<listSize; p++)
				{
					if(closedList[p].wpIdx == global_waypoints[n.wpIdx].children[a])
					{
						nc = closedList[p];
						break;
					}
				}
				
				if(nc.g <= newg)
					continue;
			}

			nc.parent = n.wpIdx;
			nc.g = newg;
			nc.h = VectorDistance(global_waypoints[global_waypoints[n.wpIdx].children[a]].origin, global_waypoints[goalWp].origin);
			nc.f = nc.g + nc.h;
			nc.wpIdx = global_waypoints[n.wpIdx].children[a];

			//if nc is in Closed,
			if(PQExists(closedList, nc.wpIdx, listSize))
			{
				//remove it from Closed
				int deleted = 0;
				for(int p=0; p<listSize; p++)
				{
					if(closedList[p].wpIdx == nc.wpIdx)
					{
						for(int z=p; z<listSize-1; ++z)
							closedList[z] = closedList[z+1];
						
						deleted = 1;
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

				//i am not sure if this is the right place to build the path array.
				//returning the beginning of the path by looping through this array
				//works but calculatedPath contains unused content as well.
				calculatedPath[pathSize] = nc;
				pathSize++;
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


//Loads the levels waypoints from a gsc file and stores them in an array
void loadWaypointsFromGSC()
{
	int wpId = -1;
	int childId;

	char homepath[1024];
	char modpath[1024];
	char waypointspath[1024];
	char filepath[1024];	

	Plugin_Cvar_VariableStringBuffer("fs_homepath", homepath, sizeof(homepath));
	Plugin_Cvar_VariableStringBuffer("fs_game", modpath, sizeof(modpath));
	Plugin_Cvar_VariableStringBuffer("waypoint_filepath", waypointspath, sizeof(waypointspath));

	stringAddPrefix(modpath, "/");
	stringAddPrefix(waypointspath, "/");

	strcpy(filepath, homepath);
	strcat(filepath, modpath);
	strcat(filepath, waypointspath);

	if(strstr(filepath, ".gsc") == NULL)
		strcat(filepath, ".gsc");

	FILE *file = fopen(filepath, "r");
	char str[100];

	Plugin_Printf("Looking for waypoint file of type gsc in: %s\n", filepath);

	if(file == NULL)
	{
		Plugin_Printf("Unable to open waypoint file - Skipping GSC import.\n");
		return;
	}

	//loop through the txt file
	while(fgets(str, 100, file) != 0)
	{
		if(strstr(str, ";") == NULL)
			continue;

		chomp(str);

		if(strstr(str, "spawnstruct") != NULL)
		{
			wpId++;
			childId = -1;
			global_total_waypoints++;
			continue;
		}
		else
		{
			int j = 0;
			char* array[999];
			char* split = strtok(str, "=");
			while(split != NULL)
			{
				array[j++] = split;
				split = strtok(NULL, ";");
			}

			for(int i=0;i<(j-1);++i)
			{
				if(array[i] == NULL || strcmp(array[i], "") == 1)
					break;
			 
				//this is the position of the waypoint
				if(strstr(array[i], "origin") != NULL)
				{
					float vector[3];
					memcpy(vector, stringtovector(array[i+1]), sizeof(vector));
					memcpy(global_waypoints[wpId].origin, vector, sizeof(vector));
					break;
				}
				
				//this is the amount of linked waypoints
				else if(strstr(array[i], "childCount") != NULL)
				{
					global_waypoints[wpId].childCount = (short)atoi(array[i+1]);
					break;
				}
				
				//this is the exact index of a linked waypoint
				else if(strstr(array[i], "children") != NULL)
				{
					childId += 1;
					global_waypoints[wpId].children[childId] = (short)atoi(array[i+1]);
					break;
				}

				//defines the action for the bot - quite useless but let's import it
				else if(strstr(array[i], "type") != NULL)
				{
					strcpy(global_waypoints[wpId].type, array[i+1]);
					break;
				}
			}
		}
	}
	
	fclose(file);
}

//Loads the levels waypoints from a csv file and stores them in an array
void loadWaypointsFromCSV()
{
	int wpId = -1;
	
	char homepath[1024];
	char modpath[1024];
	char waypointspath[1024];
	char filepath[1024];	

	Plugin_Cvar_VariableStringBuffer("fs_homepath", homepath, sizeof(homepath));
	Plugin_Cvar_VariableStringBuffer("fs_game", modpath, sizeof(modpath));
	Plugin_Cvar_VariableStringBuffer("waypoint_filepath", waypointspath, sizeof(waypointspath));

	stringAddPrefix(modpath, "/");
	stringAddPrefix(waypointspath, "/");

	strcpy(filepath, homepath);
	strcat(filepath, modpath);
	strcat(filepath, waypointspath);

	if(strstr(filepath, ".csv") == NULL)
		strcat(filepath, ".csv");

	FILE *file = fopen(filepath, "r");
	char str[100];

	Plugin_Printf("Looking for waypoint file of type csv in: %s\n", filepath);

	if(file == NULL)
	{
		Plugin_Printf("Unable to open waypoint file - Skipping CSV import.\n");
		return;
	}

	//loop through the txt file
	while(fgets(str, 100, file) != 0)
	{
		if(strstr(str, ",") == NULL)
			continue;

		chomp(str);

		int j = 0;
		char* array[999];
		char* split = strtok(str, ",");
		while(split != NULL)
		{
			array[j++] = split;
			split = strtok(NULL, ",");
		}

		if(array[0] == NULL || strcmp(array[0], "") == 1)
			break;

		if(strcmp(array[0], "0") == 0)
			continue;

		wpId = (short)atoi(array[0]) - 1;
		global_total_waypoints++;

		//this is the position of the waypoint
		float vector[3];
		stringReplace(" ", ",", array[1]);
		memcpy(vector, stringtovector(array[1]), sizeof(vector));
		memcpy(global_waypoints[wpId].origin, vector, sizeof(vector));

		//this is the exact index of a linked waypoint
		int childId = 0;
		char* child_split = strtok(array[2], " ");
		while(child_split != NULL)
		{
			global_waypoints[wpId].children[childId] = (short)atoi(child_split);
			child_split = strtok(NULL, " ");
			childId++;
		}
		global_waypoints[wpId].childCount = childId-1;
	}
	
	fclose(file);
}

//void main()
void loadWaypoints()
{
	loadWaypointsFromGSC();
	
	if(global_total_waypoints == 0)
		loadWaypointsFromCSV();

	if(global_total_waypoints == 0)
		Plugin_Printf("No waypoints imported.\n");
	else
		Plugin_Printf("Imported %d waypoints.\n", global_total_waypoints);

	Plugin_Scr_AddInt(global_total_waypoints);

	return;
}

void refreshGlobalWaypointArray()
{
	for(int i=0;i<global_maxallowed_waypoints;++i)
	{
		for(int j=0;j<3;++j)
			global_waypoints[i].origin[j] = 0.0;		

		for(int k=0;k<global_waypoints[i].childCount;++k)
			global_waypoints[i].children[k] = 0;
		
		global_waypoints[i].childCount = 0;
		strcpy(global_waypoints[i].type, "");
	}
}




//print to console - just for debugging
void consolePrint()
{
	char *string = Plugin_Scr_GetString(0);

	Plugin_Printf("%s\n", string);
	return;
}

/*
########################
required plugin functions
########################
*/
void OnPreFastRestart()
{
	refreshGlobalWaypointArray();
	global_total_waypoints = 0;
}

void OnExitLevel()
{
	refreshGlobalWaypointArray();
	global_total_waypoints = 0;
}

/*
============
Function used to load the new functions and methods of the plugin
============
*/
PCL int OnInit()
{
	Plugin_ScrAddFunction("getNearestWp", getNearestWp);
	Plugin_ScrAddFunction("AStarSearch", AStarSearch);
	Plugin_ScrAddFunction("loadWaypoints", loadWaypoints);
	Plugin_ScrAddFunction("getRandomWp", getRandomWp);
	Plugin_ScrAddFunction("getWaypointValue", getWaypointValue);

	Plugin_ScrAddFunction("consolePrint", consolePrint);

	Plugin_Cvar_RegisterString("waypoint_filepath", "", 0, "The filepath for waypoint files.");

	return 0;
}

/*
============
Function used to obtain information about the plugin
Memory pointed by info is allocated by the server binary, just fill in the fields
============
*/
PCL void OnInfoRequest(pluginInfo_t *info)
{
	// =====  MANDATORY FIELDS  =====
	info->handlerVersion.major = PLUGIN_HANDLER_VERSION_MAJOR;
	info->handlerVersion.minor = PLUGIN_HANDLER_VERSION_MINOR;	// Requested handler version

	// =====  OPTIONAL  FIELDS  =====
	info->pluginVersion.major = 1;	// Plugin version
	info->pluginVersion.minor = 0;	// Plugin sub version
	strncpy(info->fullName,"Waypoint Loader",sizeof(info->fullName)); //Full plugin name
	strncpy(info->shortDescription,"Load waypoints to server memory and use AStarSearch for bots",sizeof(info->shortDescription)); // Short plugin description
	strncpy(info->longDescription,"Load waypoints to server memory and use AStarSearch for bots",sizeof(info->longDescription));  // Long plugin description
}

