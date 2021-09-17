/*
===========================================================================
    Copyright (C) 2010-2013  Stormyy

    This file is part of CoD4X18-Server source code.

    CoD4X18-Server source code is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    CoD4X18-Server source code is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>
===========================================================================
*/
#define __STDC_FORMAT_MACROS
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "../pinc.h"



static int serverport;
void __cdecl SV_SendClaimCmd();


PCL void OnInfoRequest(pluginInfo_t *info){	// Function used to obtain information about the plugin
    // Memory pointed by info is allocated by the server binary, just fill in the fields

    // =====  MANDATORY FIELDS  =====
    info->handlerVersion.major = PLUGIN_HANDLER_VERSION_MAJOR;
    info->handlerVersion.minor = PLUGIN_HANDLER_VERSION_MINOR;	// Requested handler version

    // =====  OPTIONAL  FIELDS  =====
    info->pluginVersion.major = 1;
    info->pluginVersion.minor = 0;	// Plugin version
    strncpy(info->fullName,"Claim ingame player plugin by stormy", sizeof(info->fullName)); //Full plugin name
    strncpy(info->shortDescription,"Plugin sends claim request to http url.",sizeof(info->shortDescription)); // Short plugin description
    strncpy(info->longDescription,"Plugin sends claim request to http url.",sizeof(info->longDescription));
}


static int HTTP_DoBlockingQuery(const char *url, char* data, int *len)
{
    int stringlen = strlen(data);
    int outlen;
    int code;

    if(stringlen > *len)
    {
      stringlen = *len;
    }
    ftRequest_t* r = Plugin_HTTP_Request(url, "POST", (byte*)data, stringlen, "Content-Type: application/x-www-form-urlencoded\r\n");

    if(r == NULL)
    {
      return 0;
    }

    if(r->code != 200)
    {
      code = r->code;
      Plugin_HTTP_FreeObj(r);
      return code;
    }

    outlen = r->contentLength;
    if(outlen >= *len)
    {
      outlen = *len;
    }

    memcpy(data, r->extrecvmsg->data + r->headerLength, outlen);
    code = r->code;
    *len = outlen;
    Plugin_HTTP_FreeObj(r);
    return code;
}

PCL int OnInit(){	// Funciton called on server initiation
    Plugin_AddCommand("claimplayer", SV_SendClaimCmd, 1);
    return 0;
}


void __cdecl SV_SendClaimCmd()
{
  int numargs; // ebx@1
  int clientnum; // edi@1
  const char *cmdname; // eax@10
  client_t *wcl; // [sp+2Ch] [bp-11Ch]@1
  char screenshothandlerurl[1024];
  char identkey[256];
  char data[8192];
      char portstr[6];
      char sbuf[256];
      int len, code;

  numargs = Plugin_Cmd_Argc();

  if ( numargs <= 1 )
  {
    cmdname = Plugin_Cmd_Argv(0);
    Plugin_Printf("Usage: %s <code>\n", cmdname);
    return;
  }

  serverport = Plugin_Cvar_VariableIntegerValue("net_port");
  Plugin_Cvar_VariableStringBuffer("nehoscreenshot_url", screenshothandlerurl, sizeof(screenshothandlerurl));
  Plugin_Cvar_VariableStringBuffer("nehoscreenshot_identkey", identkey, sizeof(identkey));

  if(screenshothandlerurl[0] == 0 || identkey[0] == 0)
  {
    Plugin_PrintError("Init failure. Cvar nehoscreenshot_identkey or nehoscreenshot_url is not set\n");
    return;
  }
  data[0] = 0;
       clientnum = Plugin_Cmd_GetInvokerSlot();
       wcl = Plugin_GetClientForClientNum(clientnum);//Prints message if bad in most cases

       char playerid[20];
        snprintf(playerid, sizeof playerid, "%"PRIu64, wcl->playerid);

       Com_sprintf(portstr, sizeof(portstr), "%hu", serverport);
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "command", "CLAIM");
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "identkey", identkey);
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "serverport", portstr);
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "gamename", "Call of Duty 4 - Modern Warfare X18");
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "gamedir", "cod4");
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "player", playerid);
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "code", Plugin_Cmd_Argv(1));

       Plugin_Cvar_VariableStringBuffer("rcon_password", sbuf, sizeof(sbuf));
       Plugin_HTTP_CreateString_x_www_form_urlencoded(data, sizeof(data), "rcon", sbuf);

       len = sizeof(data);
       code = HTTP_DoBlockingQuery(screenshothandlerurl, data, &len);
       if(code != 200)
       {
         if(code > 0)
         {
           Plugin_PrintError("Init failure. Server returned code %u and message %s\n", code, data);
         }else{
           Plugin_PrintError("Init failure. Couldn't connect to server\n");
         }
         return;
       }


}
