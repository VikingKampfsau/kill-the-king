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
#include maps\mp\gametypes\_misc;

precache()
{
	//Scoreboard & Players
	precacheShader("assassins_logo");
	precacheShader("guards_logo");
	precacheShader("king_marker");
	precacheShader("waypoint_defend");
	precacheShader("crosshair");
	precacheHeadIcon("revive");
	precacheHeadIcon("king_marker");
	precacheStatusIcon("vip_icon");
	precacheStatusIcon("admin_icon");
	precacheStatusIcon("assassins_logo");
	precacheStatusIcon("hud_dog_melee");
	precacheStatusIcon("guards_logo");
	
	//playermodels that do not change
	precacheModel("viewmodel_base_viewhands");
	//assassins
	precacheModel("head_mp_usmc_ghillie");
	precacheModel("body_mp_usmc_woodland_sniper");
	precacheModel("head_mp_usmc_ghillie_desert");
	precacheModel("body_mp_usmc_desert_sniper");
	precacheModel("head_mp_usmc_ghillie_winter");
	precacheModel("body_mp_usmc_winter_sniper");
	//assassins - events
	precacheModel("body_complete_mp_predator");
	precacheModel("body_complete_mp_predator_invisible");
	precacheModel("body_complete_mp_alien");
	precacheModel("body_complete_mp_alien_invisible");
	//guards
	precacheModel("playermodel_terminator");
	precacheModel("playermodel_mw3_exp_juggernaunt");
	//hardpoints & nanosuit
	precacheModel("fake_player");
	precacheModel("viewhands_fake_player");
	//developer fun (removed from scripts)
	//precacheModel("body_mp_gogo_dancer");
	//precacheModel("head_mp_gogo_dancer");
	
	/*playermodels that change are precached through _charactermenu.gsc
	precacheModel("body_complete_mp_makarov");
	precacheModel("body_complete_mp_kennedy");
	precacheModel("body_complete_mp_skeleton");
	precacheModel("body_complete_mp_military_police");
	precacheModel("body_mp_ciaagent");
	precacheModel("head_mp_ciaagent");
	precacheModel("body_complete_mp_mamiya");
	precacheModel("body_mp_vietcong");
	precacheModel("head_mp_vietcong");
	precacheModel("body_mp_rebel");
	precacheModel("head_mp_rebel");
	precacheModel("body_mp_african");
	precacheModel("head_mp_african1");
	*/
	
	//HUD
	precacheShader("hud_grenadeicon");
	precacheShader("blood_background");
	precacheShader("juggernaut_view");
	precacheShader("compass_waypoint_bomb");
	precacheShader("waypoint_bomb");
	precacheShader("waypoint_defend");
	precacheShader("hud_suitcase_bomb");
	precacheShader("hud_health");
	precacheShader("armor_overlay");
	precacheShader("compassping_enemyfiring");
	
	//Mortar
	level._effect["mortartrail"] = loadfx ("smoke/smoke_geotrail_hellfire");
	level._effect["mortarexplosion_brick"] = loadfx("explosions/grenadeExp_blacktop");
	level._effect["mortarexplosion_ceramic"] = loadfx("explosions/grenadeexp_default");
	level._effect["mortarexplosion_concrete"] = loadfx("explosions/grenadeExp_blacktop");
	level._effect["mortarexplosion_default"] = loadfx("explosions/grenadeexp_default");
	level._effect["mortarexplosion_dirt"] = loadfx("explosions/artilleryExp_dirt_brown");
	level._effect["mortarexplosion_glass"] = loadfx("explosions/grenadeExp_windowblast");
	level._effect["mortarexplosion_metal"] = loadfx("explosions/grenadeExp_metal");
	level._effect["mortarexplosion_plaster"] = loadfx("explosions/grenadeExp_blacktop");
	level._effect["mortarexplosion_rock"] = loadfx("explosions/grenadeExp_blacktop");
	level._effect["mortarexplosion_snow"] = loadfx("explosions/grenadeExp_snow");
	level._effect["mortarexplosion_water"] = loadfx("explosions/mortarExp_water");
	level._effect["mortarexplosion_wood"] = loadfx("explosions/grenadeExp_wood");

	
	/*Napalm - Taken out due to fps drops
	precacheLocationSelector( "map_artillery_selector" );
	level.napalm_airstrikefx = loadfx ("napalm/fx_napalmExp_md_blk_smk");
	level.fx_airstrike_afterburner = loadfx ("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx ("smoke/jet_contrail");*/
	
	//UAV
	//PrecacheModel("vehicle_uav");
	
	//Manned Helicopter & Parachute Spawn
	precacheModel("parachute");
	precacheModel("vehicle_blackhawk");
	precacheShader("white");
	precacheShader("ac130_overlay_25mm");
	level.effect["turret_dirt_impact"] = LoadFX( "impacts/20mm_dirt_impact" );
	
	//Dog
	precacheModel("german_sheperd_dog");
	precacheModel("body_complete_zombie_hellhound");
	precacheModel("dog_alien_minion");
	level._effect["dog_sniffed"] = LoadFX("killtheking/dog_bloodlust");

	//RC-Car
	precacheModel("rccar");	
	level._effect["blinking_red"] = LoadFX( "misc/light_c4_blink" );
	level._effect["rc_car_explosion"] = LoadFX( "explosions/aa_explosion" );
	precacheModel( "rchelicopter" );
	level._effect["rc_heli_smoke_white"] = LoadFX(""); //smoke from car maybe?
	level._effect["rc_heli_smoke_black"] = LoadFX(""); //smoke from car maybe?
	level._effect["rc_heli_explode"] = LoadFX("explosions/aa_explosion"); //a greande explosion maybe?
	level._effect["heli_turret_flash"] = loadFx("muzzleflashes/pistolflash");
	
	//Poisongas
	level.poisongas_fx = LoadFX("killtheking/poisongas");
	
	// Tripwire
	level._effect["tripwireexplosion"] = LoadFX( "explosions/aa_explosion" );
	
	//Knife
	precacheModel("worldmodel_knife");
	
	//Weaponbox
	precacheShader( "compass_waypoint_captureneutral" );
	precacheShader( "waypoint_targetneutral" );
	
	//Blood
	level._effect["bloodpool"] = loadfx( "impacts/deathfx_bloodpool" );
	//level._effect["bloodpool2"] = loadfx( "impacts/deathfx_bloodpool_ambush" );
	level._effect["bloodsplat"] = loadfx( "impacts/flesh_hit_splat" );
	level._effect["bloodsplat_large"] = loadfx( "impacts/flesh_hit_splat_large" );
	level._effect["bloodsplat_head"] = loadfx( "impacts/flesh_hit_head_fatal_exit" );
	level._effect["gib_splat"] = loadfx( "gore/gib_splat" );
	level._effect["distorted_death"] = loadfx( "killtheking/distortion_explosion_big" );
	precacheModel("fleshy_boot");
	precacheShader("bloodsplat_1");
	
	//NVG
	precacheShader("nightvision_overlay_goggles");
	precacheShader("hud_icon_nvg");
	
	//ExtraLife
	precacheShader("stance_stand");
	
	//Hardpoints - Targetmarker
	precacheShader("waypoint_kill");
	
	//AC130
	precacheModel("ac130miniplane_big");
	precacheModel("ac130miniplane_medium");
	precacheModel("ac130miniplane_small");
	
	//Riotshield
	precacheModel("worldmodel_riot_shield_iw5");
	level._effect["riotshield_impact"] = loadfx( "impacts/small_metalhit" );
	
	//Last Stand & Revive
	precacheShellShock("laststand");
}

DefineWeapons()
{
	//Weapon Definitions
	level.ktkWeapon = [];
	level.ktkWeapons = [];
	thread WeaponDefinition("dbShotgun", "m1014");
	thread WeaponDefinition("crossbow", "gl");
	thread WeaponDefinition("crossbowExp", "c4");
	thread WeaponDefinition("intervention", "m40a3");
	thread WeaponDefinition("magnum", "beretta", "silencer");
	thread WeaponDefinition("mg42", "rpd", "acog");
	thread WeaponDefinition("minigun", "saw", "acog");
	thread WeaponDefinition("mortars", "mortar");
	thread WeaponDefinition("mosinnagat", "remington700", "acog");
	thread WeaponDefinition("m21Silencer", "m21");
	thread WeaponDefinition("throwingKnife", "frag_grenade");
	thread WeaponDefinition("rccar", "radar");
	thread WeaponDefinition("poisongas", "smoke_grenade");
	thread WeaponDefinition("knife", "knife");
	thread WeaponDefinition("ac130", "skorpion", "acog");
	thread WeaponDefinition("syrette", "concussion_grenade");
	thread WeaponDefinition("sentrygun", "m60e4", "acog");
	thread WeaponDefinition("predator", "ak74u", "acog");
	thread WeaponDefinition("nuke", "m1014", "grip");
	thread WeaponDefinition("juggernaut", "winchester1200", "grip");
	thread WeaponDefinition("katana", "skorpion", "silencer");
	thread WeaponDefinition("ump45", "mp5");
	thread WeaponDefinition("ump45Acog", "mp5", "acog");
	thread WeaponDefinition("ump45Silencer", "mp5", "silencer");
	thread WeaponDefinition("ump45Reflex", "mp5", "reflex");
	thread WeaponDefinition("famas", "uzi");
	thread WeaponDefinition("famasAcog", "uzi", "acog");
	thread WeaponDefinition("famasSilencer", "uzi", "silencer");
	thread WeaponDefinition("famasReflex", "uzi", "reflex");
	thread WeaponDefinition("aug", "g36c");
	thread WeaponDefinition("augAcog", "g36c", "acog");
	thread WeaponDefinition("augSilencer", "g36c", "silencer");
	thread WeaponDefinition("augReflex", "g36c", "reflex");
	thread WeaponDefinition("marker", "marker");
	thread WeaponDefinition("riotshield", "riotshield");
	thread WeaponDefinition("disruptor", "briefcase_bomb");
	thread WeaponDefinition("c4bomb", "briefcase_bomb_defuse");
	thread WeaponDefinition("javelin", "javelin");
}

WeaponDefinition(name, weaponfile, attachment)
{
	if(!isDefined(attachment) || attachment == "")
		level.ktkWeapon[name] = weaponfile + "_mp";
	else
		level.ktkWeapon[name] = weaponfile + "_" + attachment + "_mp";
		
	cur = level.ktkWeapons.size;
	level.ktkWeapons[cur]["name"] = name;
	level.ktkWeapons[cur]["weapon"] = level.ktkWeapon[name];
	
	precacheItem(level.ktkWeapon[name]);
}

precacheWeaponSelection()
{
	//build the weapon array
	weaponList = [];

	//events
	if(game["customEvent"] == "alien")
		weaponList[weaponList.size] = level.ktkWeapon["disruptor"];
	else if(game["customEvent"] == "terror")
		weaponList[weaponList.size] = level.ktkWeapon["c4bomb"];
		
	//hardpoints
	//weaponList[weaponList.size] = "napalm_mp";
	weaponList[weaponList.size] = "marker_mp";
	weaponList[weaponList.size] = "artillery_mp";
	weaponList[weaponList.size] = "airstrike_mp";
	weaponList[weaponList.size] = "helicopter_mp";
	weaponList[weaponList.size] = level.ktkWeapon["rccar"];
	weaponList[weaponList.size] = level.ktkWeapon["mortars"];
	weaponList[weaponList.size] = level.ktkWeapon["ac130"];
	weaponList[weaponList.size] = level.ktkWeapon["predator"];
	weaponList[weaponList.size] = level.ktkWeapon["sentrygun"];
	weaponList[weaponList.size] = level.ktkWeapon["nuke"];

	//grenades
	weaponList[weaponList.size] = "flash_grenade_mp";
	weaponList[weaponList.size] = "frag_grenade_short_mp";
	weaponList[weaponList.size] = level.ktkWeapon["poisongas"];
	weaponList[weaponList.size] = level.ktkWeapon["throwingKnife"];
	
	//explosives
	weaponList[weaponList.size] = "gl_mp";
	weaponList[weaponList.size] = "rpg_mp";
	weaponList[weaponList.size] = "claymore_mp";
	weaponList[weaponList.size] = level.ktkWeapon["crossbowExp"];
	
	//equipment
	weaponList[weaponList.size] = level.ktkWeapon["knife"];
	weaponList[weaponList.size] = level.ktkWeapon["riotshield"];
	
	//character weapons
	weaponList[weaponList.size] = "defaultweapon_mp";
	weaponList[weaponList.size] = level.king_primary;
	weaponList[weaponList.size] = level.king_secondary;
	weaponList[weaponList.size] = level.assassin_primary;
	weaponList[weaponList.size] = level.assassin_secondary;
	weaponList[weaponList.size] = level.ktkWeapon["crossbowExp"];
	weaponList[weaponList.size] = level.ktkWeapon["knife"];
	weaponList[weaponList.size] = level.ktkWeapon["throwingKnife"];
	weaponList[weaponList.size] = level.ktkWeapon["katana"];
	weaponList[weaponList.size] = level.ktkWeapon["mosinnagat"];
	weaponList[weaponList.size] = level.ktkWeapon["intervention"];
	weaponList[weaponList.size] = "remington700_mp";
	weaponList[weaponList.size] = "m40a3_acog_mp";
	
	//gungame, weaponbox and carepackage are precached in their gsc files
	
	//preache
	for(i=0;i<weaponList.size;i++)
		precacheItem(weaponList[i]);
	
}