#pragma once

#ifndef QDECL
#define QDECL
#endif

int QDECL Com_sprintf(char *dest, int size, const char *fmt, ...);
char* QDECL va_replacement(char *dest, int size, const char *fmt, ...);

#define	MAX_STRING_CHARS	1024	// max length of a string passed to Cmd_TokenizeString
#define mvabuf char va_buffer[MAX_STRING_CHARS]
#define va(fmt,... ) va_replacement(va_buffer, sizeof(va_buffer), fmt, __VA_ARGS__)

#define KEY_MASK_FORWARD        127
#define KEY_MASK_MOVERIGHT      127
#define KEY_MASK_BACK           129
#define KEY_MASK_MOVELEFT       129

#define KEY_MASK_FIRE           1
#define KEY_MASK_SPRINT         2
#define KEY_MASK_MELEE          4
#define KEY_MASK_RELOAD         16
#define KEY_MASK_LEANLEFT       64
#define KEY_MASK_LEANRIGHT      128
#define KEY_MASK_PRONE          256
#define KEY_MASK_CROUCH         512
#define KEY_MASK_JUMP           1024
#define KEY_MASK_ADS_MODE       2048
#define KEY_MASK_TEMP_ACTION    4096
#define KEY_MASK_HOLDBREATH     8192
#define KEY_MASK_FRAG           16384
#define KEY_MASK_SMOKE          32768
#define KEY_MASK_NIGHTVISION    262144
#define KEY_MASK_ADS            524288
#define KEY_MASK_USE            0x28

void Q_strncpyz( char *dest, const char *src, int destsize );
int Q_stricmp (const char *s1, const char *s2);
void Q_strcat( char *dest, int size, const char *src );

typedef struct PlayerButtonAction_t
{
    char* action;
    int key;
}PlayerButtonAction_t;

const PlayerButtonAction_t PlayerButtonActions[] =
{
    { "gostand",    KEY_MASK_JUMP       },
    { "gocrouch",   KEY_MASK_CROUCH     },
    { "goprone",    KEY_MASK_PRONE      },
    { "attack",     KEY_MASK_FIRE       },
    { "melee",      KEY_MASK_MELEE      },
    { "frag",       KEY_MASK_FRAG       },
    { "smoke",      KEY_MASK_SMOKE      },
    { "reload",     KEY_MASK_RELOAD     },
    { "sprint",     KEY_MASK_SPRINT     },
    { "leanleft",   KEY_MASK_LEANLEFT   },
    { "leanright",  KEY_MASK_LEANRIGHT  },
    { "ads",        KEY_MASK_ADS_MODE   },
    { "holdbreath", KEY_MASK_HOLDBREATH },
    { "use",        KEY_MASK_USE        }
};

extern char *concat(char *, char *);
extern void SV_AddServerCommand( client_t *client, const char *cmd );
extern void QDECL SV_SendServerCommand(client_t *cl, const char *fmt, ...);

/* already defined outside the plugin
// usercmd_t is sent to the server each client frame
typedef struct usercmd_s
{
    int serverTime;
    int buttons;
    int angles[3];
    byte weapon;
    byte offHandIndex;
    char forwardmove; // Must be char, not byte
    char rightmove;   // Must be char, not byte
    float meleeChargeYaw;
    byte meleeChargeDist;
	byte selectedLocation[2];
	byte pad;
} usercmd_t;
*/

typedef struct gclient_s gclient_t;

typedef struct{
	uint16_t emptystring;
	uint16_t active;
	uint16_t j_spine4;
	uint16_t j_helmet;
	uint16_t j_head;
	uint16_t all;
	uint16_t allies;
	uint16_t axis;
	uint16_t bad_path;
	uint16_t begin_firing;
	uint16_t cancel_location;
	uint16_t confirm_location;
	uint16_t crouch;
	uint16_t current;
	uint16_t damage;
	uint16_t dead;
	uint16_t death;
	uint16_t detonate;
	uint16_t direct;
	uint16_t dlight;
	uint16_t done;
	uint16_t empty;
	uint16_t end_firing;
	uint16_t entity;
	uint16_t explode;
	uint16_t failed;
	uint16_t free;
	uint16_t fraction;
	uint16_t goal;
	uint16_t goal_changed;
	uint16_t goal_yaw;
	uint16_t grenade;
	uint16_t grenade_danger;
	uint16_t grenade_fire;
	uint16_t grenade_pullback;
	uint16_t info_notnull;
	uint16_t invisible;
	uint16_t key1;
	uint16_t key2;
	uint16_t killanimscript;
	uint16_t left;
	uint16_t light;
	uint16_t movedone;
	uint16_t noclass;
	uint16_t none;
	uint16_t normal;
	uint16_t player;
	uint16_t position;
	uint16_t projectile_impact;
	uint16_t prone;
	uint16_t right;
	uint16_t reload;
	uint16_t reload_start;
	uint16_t rocket;
	uint16_t rotatedone;
	uint16_t script_brushmodel;
	uint16_t script_model;
	uint16_t script_origin;
	uint16_t snd_enveffectsprio_level;
	uint16_t snd_enveffectsprio_shellshock;
	uint16_t snd_channelvolprio_holdbreath;
	uint16_t snd_channelvolprio_pain;
	uint16_t snd_channelvolprio_shellshock;
	uint16_t stand;
	uint16_t suppression;
	uint16_t suppression_end;
	uint16_t surfacetype;
	uint16_t tag_aim;
	uint16_t tag_aim_animated;
	uint16_t tag_brass;
	uint16_t tag_butt;
	uint16_t tag_clip;
	uint16_t tag_flash;
	uint16_t tag_flash_11;
	uint16_t tag_flash_2;
	uint16_t tag_flash_22;
	uint16_t tag_flash_3;
	uint16_t tag_fx;
	uint16_t tag_inhand;
	uint16_t tag_knife_attach;
	uint16_t tag_knife_fx;
	uint16_t tag_laser;
	uint16_t tag_origin;
	uint16_t tag_weapon;
	uint16_t tag_player;
	uint16_t tag_camera;
	uint16_t tag_weapon_right;
	uint16_t tag_gasmask;
	uint16_t tag_gasmask2;
	uint16_t tag_sync;
	uint16_t target_script_trigger;
	uint16_t tempEntity;
	uint16_t top;
	uint16_t touch;
	uint16_t trigger;
	uint16_t trigger_use;
	uint16_t trigger_use_touch;
	uint16_t trigger_damage;
	uint16_t trigger_lookat;
	uint16_t truck_cam;
	uint16_t weapon_change;
	uint16_t weapon_fired;
	uint16_t worldspawn;
	uint16_t flashbang;
	uint16_t flash;
	uint16_t smoke;
	uint16_t night_vision_on;
	uint16_t night_vision_off;
	uint16_t MOD_UNKNOWN;
	uint16_t MOD_PISTOL_BULLET;
	uint16_t MOD_RIFLE_BULLET;
	uint16_t MOD_GRENADE;
	uint16_t MOD_GRENADE_SPLASH;
	uint16_t MOD_PROJECTILE;
	uint16_t MOD_PROJECTILE_SPLASH;
	uint16_t MOD_MELEE;
	uint16_t MOD_HEAD_SHOT;
	uint16_t MOD_CRUSH;
	uint16_t MOD_TELEFRAG;
	uint16_t MOD_FALLING;
	uint16_t MOD_SUICIDE;
	uint16_t MOD_TRIGGER_HURT;
	uint16_t MOD_EXPLOSIVE;
	uint16_t MOD_IMPACT;
	uint16_t script_vehicle;
	uint16_t script_vehicle_collision;
	uint16_t script_vehicle_collmap;
	uint16_t script_vehicle_corpse;
	uint16_t turret_fire;
	uint16_t turret_on_target;
	uint16_t turret_not_on_target;
	uint16_t turret_on_vistarget;
	uint16_t turret_no_vis;
	uint16_t turret_rotate_stopped;
	uint16_t turret_deactivate;
	uint16_t turretstatechange;
	uint16_t turretownerchange;
	uint16_t reached_end_node;
	uint16_t reached_wait_node;
	uint16_t reached_wait_speed;
	uint16_t near_goal;
	uint16_t veh_collision;
	uint16_t veh_predictedcollision;
	uint16_t auto_change;
	uint16_t back_low;
	uint16_t back_mid;
	uint16_t back_up;
	uint16_t begin;
	uint16_t call_vote;
	uint16_t freelook;
	uint16_t head;
	uint16_t intermission;
	uint16_t j_head_dup;
	uint16_t manual_change;
	uint16_t menuresponse;
	uint16_t neck;
	uint16_t pelvis;
	uint16_t pistol;
	uint16_t plane_waypoint;
	uint16_t playing;
	uint16_t spectator;
	uint16_t vote;
	uint16_t sprint_begin;
	uint16_t sprint_end;
	uint16_t tag_driver;
	uint16_t tag_passenger;
	uint16_t tag_gunner;
	uint16_t tag_wheel_front_left;
	uint16_t tag_wheel_front_right;
	uint16_t tag_wheel_back_left;
	uint16_t tag_wheel_back_right;
	uint16_t tag_wheel_middle_left;
	uint16_t tag_wheel_middle_right;
	uint16_t tag_detach;
	uint16_t tag_popout;
	uint16_t tag_body;
	uint16_t tag_turret;
	uint16_t tag_turret_base;
	uint16_t tag_barrel;
	uint16_t tag_engine_left;
	uint16_t tag_engine_right;
	uint16_t front_left;
	uint16_t front_right;
	uint16_t back_left;
	uint16_t back_right;
	uint16_t tag_gunner_pov;
}scr_const_t;

scr_const_t scr_const;

typedef enum BGEvent
{
    EV_NONE = 0,
    EV_FOLIAGE_SOUND,
    EV_STOP_WEAPON_SOUND,
    EV_SOUND_ALIAS,
    EV_SOUND_ALIAS_AS_MASTER,
    EV_STOPSOUNDS,
    EV_STANCE_FORCE_STAND,
    EV_STANCE_FORCE_CROUCH,
    EV_STANCE_FORCE_PRONE,
    EV_ITEM_PICKUP,
    EV_AMMO_PICKUP,
    EV_NOAMMO,
    EV_EMPTYCLIP,
    EV_EMPTY_OFFHAND,
    EV_RESET_ADS,
    EV_RELOAD,
    EV_RELOAD_FROM_EMPTY,
    EV_RELOAD_START,
    EV_RELOAD_END,
    EV_RELOAD_START_NOTIFY,
    EV_RELOAD_ADDAMMO,
    EV_RAISE_WEAPON,
    EV_FIRST_RAISE_WEAPON,
    EV_PUTAWAY_WEAPON,
    EV_WEAPON_ALT,
    EV_PULLBACK_WEAPON,
    EV_FIRE_WEAPON,
    EV_FIRE_WEAPON_LASTSHOT,
    EV_RECHAMBER_WEAPON,
    EV_EJECT_BRASS,
    EV_MELEE_SWIPE,
    EV_FIRE_MELEE,
    EV_PREP_OFFHAND,
    EV_USE_OFFHAND,
    EV_SWITCH_OFFHAND,
    EV_MELEE_HIT,
    EV_MELEE_MISS,
    EV_MELEE_BLOOD,
    EV_FIRE_WEAPON_MG42,
    EV_FIRE_QUADBARREL_1,
    EV_FIRE_QUADBARREL_2,
    EV_BULLET_HIT,
    EV_BULLET_HIT_CLIENT_SMALL,
    EV_BULLET_HIT_CLIENT_LARGE,
    EV_GRENADE_BOUNCE,
    EV_GRENADE_EXPLODE,
    EV_ROCKET_EXPLODE,
    EV_ROCKET_EXPLODE_NOMARKS,
    EV_FLASHBANG_EXPLODE,
    EV_CUSTOM_EXPLODE,
    EV_CUSTOM_EXPLODE_NOMARKS,
    EV_CHANGE_TO_DUD,
    EV_DUD_EXPLODE,
    EV_DUD_IMPACT,
    EV_BULLET,
    EV_PLAY_FX,
    EV_PLAY_FX_ON_TAG,
    EV_PHYS_EXPLOSION_SPHERE,
    EV_PHYS_EXPLOSION_CYLINDER,
    EV_PHYS_EXPLOSION_JOLT,
    EV_PHYS_JITTER,
    EV_EARTHQUAKE,
    EV_GRENADE_SUICIDE,
    EV_DETONATE,
    EV_NIGHTVISION_WEAR,
    EV_NIGHTVISION_REMOVE,
    EV_OBITUARY,
    EV_NO_FRAG_GRENADE_HINT,
    EV_NO_SPECIAL_GRENADE_HINT,
    EV_TARGET_TOO_CLOSE_HINT,
    EV_TARGET_NOT_ENOUGH_CLEARANCE,
    EV_LOCKON_REQUIRED_HINT,
    EV_FOOTSTEP_SPRINT,
    EV_FOOTSTEP_RUN,
    EV_FOOTSTEP_WALK,
    EV_FOOTSTEP_PRONE,
    EV_JUMP,
    EV_LANDING_DEFAULT,
    EV_LANDING_BARK,
    EV_LANDING_BRICK,
    EV_LANDING_CARPET,
    EV_LANDING_CLOTH,
    EV_LANDING_CONCRETE,
    EV_LANDING_DIRT,
    EV_LANDING_FLESH,
    EV_LANDING_FOLIAGE,
    EV_LANDING_GLASS,
    EV_LANDING_GRASS,
    EV_LANDING_GRAVEL,
    EV_LANDING_ICE,
    EV_LANDING_METAL,
    EV_LANDING_MUD,
    EV_LANDING_PAPER,
    EV_LANDING_PLASTER,
    EV_LANDING_ROCK,
    EV_LANDING_SAND,
    EV_LANDING_SNOW,
    EV_LANDING_WATER,
    EV_LANDING_WOOD,
    EV_LANDING_ASPHALT,
    EV_LANDING_CERAMIC,
    EV_LANDING_PLASTIC,
    EV_LANDING_RUBBER,
    EV_LANDING_CUSHION,
    EV_LANDING_FRUIT,
    EV_LANDING_PAINTEDMETAL,
    EV_LANDING_PAIN_DEFAULT,
    EV_LANDING_PAIN_BARK,
    EV_LANDING_PAIN_BRICK,
    EV_LANDING_PAIN_CARPET,
    EV_LANDING_PAIN_CLOTH,
    EV_LANDING_PAIN_CONCRETE,
    EV_LANDING_PAIN_DIRT,
    EV_LANDING_PAIN_FLESH,
    EV_LANDING_PAIN_FOLIAGE,
    EV_LANDING_PAIN_GLASS,
    EV_LANDING_PAIN_GRASS,
    EV_LANDING_PAIN_GRAVEL,
    EV_LANDING_PAIN_ICE,
    EV_LANDING_PAIN_METAL,
    EV_LANDING_PAIN_MUD,
    EV_LANDING_PAIN_PAPER,
    EV_LANDING_PAIN_PLASTER,
    EV_LANDING_PAIN_ROCK,
    EV_LANDING_PAIN_SAND,
    EV_LANDING_PAIN_SNOW,
    EV_LANDING_PAIN_WATER,
    EV_LANDING_PAIN_WOOD,
    EV_LANDING_PAIN_ASPHALT,
    EV_LANDING_PAIN_CERAMIC,
    EV_LANDING_PAIN_PLASTIC,
    EV_LANDING_PAIN_RUBBER,
    EV_LANDING_PAIN_CUSHION,
    EV_LANDING_PAIN_FRUIT,
    EV_LANDING_PAIN_PAINTEDMETAL
}BGEvent;

// 0x08052562
void __cdecl BG_AddPredictableEventToPlayerstate(const BGEvent EventNum_, const byte EventParam_, gclient_t* Client_);

// animations
typedef enum {
	BOTH_DEATH1,
	BOTH_DEAD1,
	BOTH_DEATH2,
	BOTH_DEAD2,
	BOTH_DEATH3,
	BOTH_DEAD3,

	TORSO_GESTURE,

	TORSO_ATTACK,
	TORSO_ATTACK2,

	TORSO_DROP,
	TORSO_RAISE,

	TORSO_STAND,
	TORSO_STAND2,

	LEGS_WALKCR,
	LEGS_WALK,
	LEGS_RUN,
	LEGS_BACK,
	LEGS_SWIM,

	LEGS_JUMP,
	LEGS_LAND,

	LEGS_JUMPB,
	LEGS_LANDB,

	LEGS_IDLE,
	LEGS_IDLECR,

	LEGS_TURN,

	TORSO_GETFLAG,
	TORSO_GUARDBASE,
	TORSO_PATROL,
	TORSO_FOLLOWME,
	TORSO_AFFIRMATIVE,
	TORSO_NEGATIVE,

	MAX_ANIMATIONS,

	LEGS_BACKCR,
	LEGS_BACKWALK,
	FLAG_RUN,
	FLAG_STAND,
	FLAG_STAND2RUN,

	MAX_TOTALANIMATIONS
} animNumber_t;

typedef struct animation_s {
	int		firstFrame;
	int		numFrames;
	int		loopFrames;			// 0 to numFrames
	int		frameLerp;			// msec between frames
	int		initialLerp;		// msec to get to first frame
	int		reversed;			// true if animation is reversed
	int		flipflop;			// true if animation should flipflop back to base
} animation_t;

typedef struct {
	// state (in / out)
	playerState_t	*ps;

	// command (in)
	usercmd_t	cmd;
	int			tracemask;			// collide against these types of surfaces
	int			debugLevel;			// if set, diagnostic output will be printed
	qboolean	noFootsteps;		// if the game is setup for no footsteps by the server
	qboolean	gauntletHit;		// true if a gauntlet attack would actually hit something

	int			framecount;

	// results (out)
	int			numtouch;
	int			touchents[MAXTOUCH];

	vec3_t		mins, maxs;			// bounding box size

	int			watertype;
	int			waterlevel;

	float		xyspeed;

	// for fixed msec Pmove
	int			pmove_fixed;
	int			pmove_msec;

	// callbacks to test the world
	// these will be different functions during game and cgame
	void		(*trace)( trace_t *results, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, int passEntityNum, int contentMask );
	int			(*pointcontents)( const vec3_t point, int passEntityNum );
} pmove_t;
