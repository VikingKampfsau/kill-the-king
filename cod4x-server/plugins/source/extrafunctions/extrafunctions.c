#include "../pinc.h"
#include <ctype.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>


int mutedPlayers[MAX_CLIENTS];


void checkint()
{
	if (Plugin_Scr_GetNumParam() != 1)
    {
        Plugin_Scr_Error("Usage: checkint( <int> );");
        return;
    }

	char *input = Plugin_Scr_GetString(0);
	int length = strlen(input);
	int i;

	for(i = 0; i<length; i++)
	{
		if(!isdigit(input[i]))
		{
			Plugin_Scr_AddBool(qfalse);
			return;
		}
	}
	Plugin_Scr_AddBool(qtrue);
}

void makeFloat()
{
	if (Plugin_Scr_GetNumParam() != 1)
    {
        Plugin_Scr_Error("Usage: makeFloat( <string> );");
        return;
    }

	char *input = Plugin_Scr_GetString(0);
	Plugin_Scr_AddFloat(atof(input));
}

void makeColourRGB()
{
	if (Plugin_Scr_GetNumParam() != 3)
    {
        Plugin_Scr_Error("Usage: makeColourRGB( <int>, <int>, <int> );");
        return;
    }

	vec3_t colour;

	//load inputs
	int r = Plugin_Scr_GetInt(0);
	int g = Plugin_Scr_GetInt(1);
	int b = Plugin_Scr_GetInt(2);

	//check inputs are in range
	if(r < 0 && r > 255 && g < 0 && g > 255 && b < 0 && b > 255)
	{
		Plugin_Scr_ParamError( 1, "Int values need to be between 0 - 255"); 
		colour[0] = 0;
		colour[1] = 0;
		colour[2] = 0;
		Plugin_Scr_AddVector( colour );
		return;
	}

	//divide inputs by 255
	float newR = (float)r/255;
	float newG = (float)g/255;
	float newB = (float)b/255;

	colour[0] = newR;
	colour[1] = newG;
	colour[2] = newB;

	//return output
	Plugin_Scr_AddVector( colour );
}

void makeColourHEX()
{
	if (Plugin_Scr_GetNumParam() != 1)
    {
        Plugin_Scr_Error("Usage: makeColourHEX( <string> );");
        return;
    }

	char hex1[3];
	char hex2[3];
	char hex3[3];

	vec3_t colour;

	//load hex string
	char* hex = Plugin_Scr_GetString(0);

	//simple format check
	if(strlen(hex) != 7)
	{
		Plugin_Scr_ParamError( 1, "Hex needs to be in format #000000");

		colour[0] = 0;
		colour[1] = 0;
		colour[2] = 0;
		Plugin_Scr_AddVector( colour );
		return;
	}

	int r, g, b;
	char *ptr;

	hex1[0] = hex[1];
	hex1[1] = hex[2];
	hex2[0] = hex[3];
	hex2[1] = hex[4];
	hex3[0] = hex[5];
	hex3[1] = hex[6];

	r = strtol(hex1, &ptr, 16);
	g = strtol(hex2, &ptr, 16);
	b = strtol(hex3, &ptr, 16);

	if(r < 0 && r > 255 && g < 0 && g > 255 && b < 0 && b > 255)
	{

		Plugin_Scr_ParamError( 1, "Hex values are too low / high");
		colour[0] = 0;
		colour[1] = 0;
		colour[2] = 0;
		Plugin_Scr_AddVector( colour );
		return;
	}

	float newR = (float)r/255;
	float newG = (float)g/255;
	float newB = (float)b/255;

	colour[0] = newR;
	colour[1] = newG;
	colour[2] = newB;

	Plugin_Scr_AddVector( colour );
}

void scaleVector()
{
	if (Plugin_Scr_GetNumParam() != 2)
    {
        Plugin_Scr_Error("Usage: scaleVector( <vector>, <float> );");
        return;
    }
	vec3_t vector;
	Plugin_Scr_GetVector(0, &vector);
	float scale = Plugin_Scr_GetFloat(1);


	float x = (float) vector[0] * scale;
	float y = (float) vector[1] * scale;
	float z = (float) vector[2] * scale;

	vec3_t newVector = {x,y,z};

	Plugin_Scr_AddVector(newVector);
}

void setMute()
{
	if (Plugin_Scr_GetNumParam() != 2)
    {
        Plugin_Scr_Error("Usage: setMute( <player>, <int> );");
        return;
    }

	gentity_t* ent = Plugin_Scr_GetEntity(0);
	int value = Plugin_Scr_GetInt(1);

	if(value != 0 && value != 1)
	{
		Plugin_Scr_ParamError( 1, "int value need to be 0 or 1");
		return;
	}

	int clientNumber = ent->s.clientNum;
	client_t* player = Plugin_GetClientForClientNum(clientNumber);
	int slot = Plugin_ClientToSlot(player);



	mutedPlayers[slot] = value;
}

void checkMute()
{
	if (Plugin_Scr_GetNumParam() != 1)
    {
        Plugin_Scr_Error("Usage: checkMute( <player> );");
        return;
    }

	gentity_t* ent = Plugin_Scr_GetEntity(0);
	int clientNumber = ent->s.clientNum;
	client_t* player = Plugin_GetClientForClientNum(clientNumber);
	int slot = Plugin_ClientToSlot(player);

	if(mutedPlayers[slot] == 0)
		Plugin_Scr_AddBool(qfalse);
	if(mutedPlayers[slot] == 1)
		Plugin_Scr_AddBool(qtrue);
}

void upper()
{
	if (Plugin_Scr_GetNumParam() != 1)
    {
        Plugin_Scr_Error("Usage: toUpper( <string> );");
        return;
    }

    char* string = Plugin_Scr_GetString(0);

    int i;
    for(i = 0; i<strlen(string); i++)
    	string[i] = toupper(string[i]);

    Plugin_Scr_AddString(string);
}

PCL void OnPlayerDC(client_t* client, const char* reason)
{
	//when player leave unmute the slot
	int slot = Plugin_ClientToSlot(client);
	mutedPlayers[slot] = 0;
}

PCL void OnMessageSent(char *message,int slot, qboolean *show, int type)
{
	//if players slot is muted dont show msg
	if(mutedPlayers[slot] == 1)
		*show = qfalse;
}


PCL int OnInit()
{
	Plugin_ScrAddFunction("isStringInt", &checkint);
	Plugin_ScrAddFunction("stringToFloat", &makeFloat);
	Plugin_ScrAddFunction("colourRGB", &makeColourRGB);
	Plugin_ScrAddFunction("colourHEX", &makeColourHEX);
	Plugin_ScrAddFunction("colourHEX", &makeColourHEX);
	Plugin_ScrAddFunction("scaleVector", &scaleVector);
	Plugin_ScrAddFunction("mutePlayerChat", &setMute);
	Plugin_ScrAddFunction("isPlayerChatMuted", &checkMute);
	Plugin_ScrAddFunction("toUpper", &upper);

	return 0;
}


PCL void OnInfoRequest(pluginInfo_t *info){	// Function used to obtain information about the plugin
    // Memory pointed by info is allocated by the server binary, just fill in the fields

    // =====  MANDATORY FIELDS  =====
    info->handlerVersion.major = PLUGIN_HANDLER_VERSION_MAJOR;
    info->handlerVersion.minor = PLUGIN_HANDLER_VERSION_MINOR;	// Requested handler version

    // =====  OPTIONAL  FIELDS  =====
    info->pluginVersion.major = 1;
    info->pluginVersion.minor = 0;	// Plugin version
    strncpy(info->fullName,"Extra Functions",sizeof(info->fullName)); //Full plugin name
    strncpy(info->shortDescription,"Adds some extra functions to codx server",sizeof(info->shortDescription)); // Short plugin description
    strncpy(info->longDescription,"Adds some extra functions to codx server",sizeof(info->longDescription));
}