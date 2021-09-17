#include "../pinc.h"
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

#include "animatedxmodel.h"

/*########################
functions of the plugin
########################*/

/* this stuff was to see how it actually works and is not needed anymore
int G_FindConfigstringIndex( char *name, int start, int max, qboolean create )
{
	int		i;
	char	s[MAX_STRING_CHARS];

	if ( !name || !name[0] ) {
		return 0;
	}

	for ( i=1 ; i<max ; i++ ) {
		Plugin_SV_GetConfigstring( start + i, s, sizeof( s ) );
		//Plugin_Printf("index: %d, string: %s\n", i, s);
		if ( !s[0] ) {
			break;
		}
		if ( !strcmp( s, name ) ) {
			return i;
		}
	}

	if ( !create ) {
		return 0;
	}

	if ( i == max ) {
		Plugin_Scr_Error( "G_FindConfigstringIndex: overflow" );
	}

	Plugin_SV_SetConfigstring( start + i, name );

	return i;
}

int G_ModelIndex(char *name)
{
	return G_FindConfigstringIndex(name, INDEX_SEARCH_START, INDEX_SEARCH_END, qtrue);
}

void G_SetModel_New(gentity_t *ent, char *modelName)
{
	ent->model = G_ModelIndex(modelName);
}*/

void GScr_SpawnAnimatedModel()
{
	if(Plugin_Scr_GetNumParam() != 5)
	{
		Plugin_Scr_Error("Usage: spawnAnimatedXmodel(<origin>, <rotation>, <xmodel>, <xanim>");
		return;
	}

	vec3_t origin;
	vec3_t angles;
	char* xmodel;
	char* xanim;
	
	Scr_GetVector(0, origin);
	Scr_GetVector(1, angles);

	xmodel = Plugin_Scr_GetString(2);
	xanim = Plugin_Scr_GetString(3);
	
	gentity_t* gentity;
	gentity = G_Spawn();
	
	scr_const.script_model = Plugin_Scr_AllocString("script_model");
	Scr_SetString((unsigned short*)&gentity->classname, (unsigned short)scr_const.script_model);

	gentity->r.currentOrigin[0] = origin[0];
	gentity->r.currentOrigin[1] = origin[1];
	gentity->r.currentOrigin[2] = origin[2];	

	gentity->spawnflags = 0;

	G_SetModel(gentity, xmodel);

	//how to add an anim? :(
	//->

	gentity_t* player = Plugin_Scr_GetEntity(4);
	XanimCloneAnimtree(player, gentity);

	//<-

	if(G_CallSpawnEntity(gentity))
	{
		Plugin_Scr_AddEntity(gentity);
	}
	else
	{
		Plugin_Scr_Error("Unable to spawn animated xmodel");
	}
}

/*########################
required plugin init
########################*/
/*============
Function used to load the new functions and methods of the plugin
============*/
PCL int OnInit()
{
    Plugin_ScrAddFunction("spawnAnimatedXmodel", GScr_SpawnAnimatedModel);
    return 0;
}

/*============
Function used to obtain information about the plugin
Memory pointed by info is allocated by the server binary, just fill in the fields
============*/
PCL void OnInfoRequest(pluginInfo_t *info)
{
    // =====  MANDATORY FIELDS  =====
    info->handlerVersion.major = PLUGIN_HANDLER_VERSION_MAJOR;
    info->handlerVersion.minor = PLUGIN_HANDLER_VERSION_MINOR;    // Requested handler version

    // =====  OPTIONAL  FIELDS  =====
    info->pluginVersion.major = 1;    // Plugin version
    info->pluginVersion.minor = 0;    // Plugin sub version
    strncpy(info->fullName,"Animated Xmodels",sizeof(info->fullName)); //Full plugin name
    strncpy(info->shortDescription,"Spawns animated xmodels",sizeof(info->shortDescription)); // Short plugin description
    strncpy(info->longDescription,"Spawns animated xmodels",sizeof(info->longDescription));  // Long plugin description
}

