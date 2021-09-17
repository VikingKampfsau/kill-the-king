#include "../pinc.h"
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

#include "playerstances.h"



/*
########################
some required functions
########################
*/
int Q_stricmpn (const char *s1, const char *s2, int n) {
	int		c1, c2;

        if ( s1 == NULL ) {
           if ( s2 == NULL )
             return 0;
           else
             return -1;
        }
        else if ( s2==NULL )
          return 1;

	do {
		c1 = *s1++;
		c2 = *s2++;

		if (!n--) {
			return 0;		// strings are equal until end point
		}

		if (c1 != c2) {
			if (c1 >= 'a' && c1 <= 'z') {
				c1 -= ('a' - 'A');
			}
			if (c2 >= 'a' && c2 <= 'z') {
				c2 -= ('a' - 'A');
			}
			if (c1 != c2) {
				return c1 < c2 ? -1 : 1;
			}
		}
	} while (c1);

	return 0;		// strings are equal
}

int Q_stricmp (const char *s1, const char *s2) {
	return (s1 && s2) ? Q_stricmpn (s1, s2, 99999) : -1;
}

void Q_strncpyz( char *dest, const char *src, int destsize ) {

	if (!dest ) {
            Plugin_Scr_Error( "Q_strncpyz: NULL dest" );
	}
	if ( !src ) {
            Plugin_Scr_Error( "Q_strncpyz: NULL src" );
	}
	if ( destsize < 1 ) {
            Plugin_Scr_Error( "Q_strncpyz: destsize < 1" );
	}

	strncpy( dest, src, destsize-1 );
  dest[destsize-1] = 0;
}

void Q_strcat( char *dest, int size, const char *src ) {
	int		l1;

	l1 = strlen( dest );
	if ( l1 >= size ) {
		Plugin_Scr_Error( "Q_strcat: already overflowed" );
	}
	Q_strncpyz( dest + l1, src, size - l1 );
}

/*
============
BG_AddPredictableEventToPlayerstate
Adds a command to the playerState
============
*/
void BG_AddPredictableEventToPlayerstate(const BGEvent EventNum_, const byte EventParam_, gclient_t* Client_)
{
    if (EventNum_)
    {
        const int eventIdx = Client_->ps.eventSequence & 3;
        Client_->ps.events[eventIdx] = EventNum_;
        Client_->ps.eventParms[eventIdx] = EventParam_;
        ++Client_->ps.eventSequence;
    }
}



/*
########################
functions of the plugin
########################
*/
/*
************************
set player values
************************
*/
/*
============
PlayerCmd_ChangeJumpHeight

Usage: player setJumpHeight(<integer value>)
============
*/
void PlayerCmd_ChangeJumpHeight(scr_entref_t playerEntNum)
{
    if (Plugin_Scr_GetNumParam() != 1)
        Plugin_Error(0, "usage: player setJumpHeight(<integer value>);");

    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    client_t* clientObj = Plugin_GetClientForClientNum(playerEntNum);

    // Param check.
    qboolean value = Plugin_Scr_GetInt(0);
    if (value < 0)
        value = 0;

    // Change jump heigt
    clientObj->jumpHeight = value;    
}

/*
============
PlayerCmd_ChangeGravity

Usage: player setGravity(<integer value>)
============
*/
void PlayerCmd_ChangeGravity(scr_entref_t playerEntNum)
{
    if (Plugin_Scr_GetNumParam() != 1)
        Plugin_Error(0, "usage: player setGravity(<integer value>);");

    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    client_t* clientObj = Plugin_GetClientForClientNum(playerEntNum);

    // Param check.
    qboolean value = Plugin_Scr_GetInt(0);
    if (value < 0)
        value = 0;

    // Change gravity
    clientObj->gravity = value;    
}

/*
============
PlayerCmd_EnableNoclip

Usage: player enableNoclip(<boolean>)
============
*/
void PlayerCmd_EnableNoclip(scr_entref_t playerEntNum)
{
    if (Plugin_Scr_GetNumParam() != 1)
        Plugin_Error(0, "usage: player enableNoclip(<boolean>);");

    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    // Param check.
    qboolean noclipOn = Plugin_Scr_GetInt(0);
    if (noclipOn != qtrue && noclipOn != qfalse)
        Plugin_Scr_ParamError(0, "value must be true or false");

    // Enable Noclip
    client->noclip = noclipOn;    
}



/*
************************
get player values
************************
*/
/*
============
PlayerCmd_GetPing

Usage: player getPing()
============
*/
void PlayerCmd_GetPing(scr_entref_t playerEntNum)
{
    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    client_t* clientObj = Plugin_GetClientForClientNum(playerEntNum);

    // Get its value
    Plugin_Scr_AddInt(clientObj->ping);    
}

/*
============
PlayerCmd_GetJumpHeight

Usage: player getJumpHeight()
============
*/
void PlayerCmd_GetJumpHeight(scr_entref_t playerEntNum)
{
    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    client_t* clientObj = Plugin_GetClientForClientNum(playerEntNum);

    // Get its value
    Plugin_Scr_AddInt(clientObj->jumpHeight);    
}

/*
============
PlayerCmd_GetGravity

Usage: player getGravity()
============
*/
void PlayerCmd_GetGravity(scr_entref_t playerEntNum)
{
    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    client_t* clientObj = Plugin_GetClientForClientNum(playerEntNum);

    // Get its value
    Plugin_Scr_AddInt(clientObj->gravity);    
}

/*
============
PlayerCmd_GetNoclip

Usage: player getNoclip()
============
*/
void PlayerCmd_GetNoclip(scr_entref_t playerEntNum)
{
    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    // Get its value
    Plugin_Scr_AddBool(client->noclip);    
}



/*
************************
force a player event
************************
*/
/*
============
PlayerCmd_SetStance

Usage: player setStance(<string stance>)
============
*/
void PlayerCmd_SetStance(scr_entref_t playerEntNum)
{
    if (Plugin_Scr_GetNumParam() != 1)
        Plugin_Error(0, "usage: player setStance(<string stance>);");

    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    scr_const.crouch = Plugin_Scr_AllocString("crouch");
    scr_const.prone = Plugin_Scr_AllocString("prone");
    scr_const.stand = Plugin_Scr_AllocString("stand");

    // Param check.
    short stanceIdx = Plugin_Scr_GetConstString(0);
    if (stanceIdx != (unsigned short)scr_const.stand && stanceIdx != (unsigned short)scr_const.crouch && stanceIdx != (unsigned short)scr_const.prone)
        Plugin_Scr_ParamError(0, "stance must be one of {stand, crouch, prone}");

    // Get the new stance
    BGEvent event = stanceIdx == (unsigned short)scr_const.stand ? EV_STANCE_FORCE_STAND : stanceIdx == (unsigned short)scr_const.crouch ? EV_STANCE_FORCE_CROUCH : EV_STANCE_FORCE_PRONE;

    // Force the new stance
    BG_AddPredictableEventToPlayerstate(event,0,client);
}

/*
============
PlayerCmd_PlayerAction

Usage: player playerAction(<string action>)
============
*/
void PlayerCmd_PlayerAction(scr_entref_t playerEntNum)
{
    if (Plugin_Scr_GetNumParam() != 1)
        Plugin_Error(0, "usage: player playerAction(<string action>);");

    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    // Param check.
    char* action = Plugin_Scr_GetString(0);
    BGEvent event;
    
    if (strcmp(action, "stand") == 0)
        event = EV_STANCE_FORCE_STAND;
    else if (strcmp(action, "crouch") == 0)
        event = EV_STANCE_FORCE_CROUCH;
    else if (strcmp(action, "prone") == 0)
        event = EV_STANCE_FORCE_PRONE;
    else if (strcmp(action, "attack") == 0)
        event = EV_FIRE_WEAPON;
    else
        Plugin_Scr_ParamError(0, "action must be one of:\n- stand\n- crouch\n- prone\n- attack");

    // Force the action
    BG_AddPredictableEventToPlayerstate(event,0,client);
}
/*
void PlayerCmd_PressButton(scr_entref_t playerEntNum)
{
    int i;
    qboolean key_found;
    char buffer[1024];
    mvabuf;

    if (Plugin_Scr_GetNumParam() != 1)
        Plugin_Error(0, "usage: player playerAction(<string (+/-)action>);");

    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    char* action = Plugin_Scr_GetString(0);

    if (action[0] != '+' && action[0] != '-')
        Plugin_Scr_ParamError(0, "Sign for action must be '+' or '-'.");

    key_found = qfalse;
    for (i = 0; i < sizeof(PlayerButtonActions) / sizeof(PlayerButtonAction_t); ++i)
    {
        if (!Q_stricmp(&action[1], PlayerButtonActions[i].action))
        {
            key_found = qtrue;
            if (action[0] == '+')
                client->buttons |= PlayerButtonActions[i].key;
            else
                client->buttons &= ~(PlayerButtonActions[i].key);

            //e prints the text in lower left corner
            //what do i have to use instead of 'e' to make the client listen for the cmd and to execute it?
            //client_t* clientObj = Plugin_GetClientForClientNum(playerEntNum);
            //SV_SendServerCommand(clientObj, "e \"^5Command^2: %s\"", action);

            return;
        }
    }

    if (!key_found)
    {
        buffer[0] = '\0';
        for (i = 0; i < sizeof(PlayerButtonActions) / sizeof(PlayerButtonAction_t); ++i)
        {
            Q_strcat(buffer, 1024, " ");
            Q_strcat(buffer, 1024, PlayerButtonActions[i].action);
        }
        Plugin_Scr_ParamError(0, va("Unknown action. Must be one of:%s.", buffer));
    }
}*/

























/*
===================
PM_StartTorsoAnim
===================
*/
pmove_t	*pm;
pml_t	pml;

static void PM_StartTorsoAnim( int anim ) {
	if ( pm->ps->pm_type >= PM_DEAD ) {
		return;
	}
	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
		| anim;
}
static void PM_StartLegsAnim( int anim ) {
	if ( pm->ps->pm_type >= PM_DEAD ) {
		return;
	}
	if ( pm->ps->legsTimer > 0 ) {
		return;		// a high priority animation is running
	}
	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
		| anim;
}

static void PM_ContinueLegsAnim( int anim ) {
	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) {
		return;
	}
	if ( pm->ps->legsTimer > 0 ) {
		return;		// a high priority animation is running
	}
	PM_StartLegsAnim( anim );
}

static void PM_ContinueTorsoAnim( int anim ) {
	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) {
		return;
	}
	if ( pm->ps->torsoTimer > 0 ) {
		return;		// a high priority animation is running
	}
	PM_StartTorsoAnim( anim );
}

static void PM_ForceLegsAnim( int anim ) {
	pm->ps->legsTimer = 0;
	PM_StartLegsAnim( anim );
}


/*
============
VikingAnimTest

Usage: player setEpicAnim(<int anim>)
============
*/

void VikingAnimTest(scr_entref_t playerEntNum)
{
    if (Plugin_Scr_GetNumParam() != 1)
        Plugin_Error(0, "usage: player setEpicAnim(<int anim>);");

    // Object check.
    gentity_t* entity = Plugin_GetGentityForEntityNum(playerEntNum);
    gclient_t* client = entity->client;

    if (!client)
        Plugin_Scr_ObjectError("entity is not a client");

    int anim = LEGS_JUMP;// Plugin_Scr_GetInt(0);
    
    if(anim == LEGS_JUMP)
      PM_ForceLegsAnim(anim);
    else
      PM_StartTorsoAnim(anim);
}




/*
########################
required plugin init
########################
*/
/*
============
Function used to load the new functions and methods of the plugin
============
*/
PCL int OnInit()
{
    Plugin_ScrAddMethod("setJumpHeight", PlayerCmd_ChangeJumpHeight);
    Plugin_ScrAddMethod("setGravity", PlayerCmd_ChangeGravity);
    Plugin_ScrAddMethod("enableNoclip", PlayerCmd_EnableNoclip);
	
    Plugin_ScrAddMethod("getPing", PlayerCmd_GetPing);
    Plugin_ScrAddMethod("getJumpHeight", PlayerCmd_GetJumpHeight);
    Plugin_ScrAddMethod("getGravity", PlayerCmd_GetGravity);
    Plugin_ScrAddMethod("getNoclip", PlayerCmd_GetNoclip);
	
    Plugin_ScrAddMethod("setstance", PlayerCmd_SetStance);
    Plugin_ScrAddMethod("playerAction", PlayerCmd_PlayerAction);

    Plugin_ScrAddMethod("setEpicAnim", VikingAnimTest);

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
    info->handlerVersion.minor = PLUGIN_HANDLER_VERSION_MINOR;    // Requested handler version

    // =====  OPTIONAL  FIELDS  =====
    info->pluginVersion.major = 1;    // Plugin version
    info->pluginVersion.minor = 0;    // Plugin sub version
    strncpy(info->fullName,"Stance modifier",sizeof(info->fullName)); //Full plugin name
    strncpy(info->shortDescription,"Adds setStance to old codx servers",sizeof(info->shortDescription)); // Short plugin description
    strncpy(info->longDescription,"Adds setStance to old codx servers",sizeof(info->longDescription));  // Long plugin description
}
