init()
{
	//==============================================================================
	// Random Weaponbox 
	//==============================================================================

	setDvar("scr_mod_weaponbox", "1");	// 0 = Disabled, 1 = Enabled (normal), 2 = Enabled (no collision)
	setDvar("scr_mod_weaponbox_priceGuards", "50");	// the score a player needs to use the box
	setDvar("scr_mod_weaponbox_priceAssassins", "50");	// the score a player needs to use the box
	setDvar("scr_mod_weaponbox_picktime", "1");	// time till the player gets his new weapon

	// weapons the guards can buy at the box
	setDvar("scr_mod_weaponbox_weapon_1", "airstrike_mp");
	setDvar("scr_mod_weaponbox_weapon_2", "ak47_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_3", "ak47_gl_mp");
	setDvar("scr_mod_weaponbox_weapon_4", "ak47_mp");
	setDvar("scr_mod_weaponbox_weapon_5", "ak47_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_6", "ak47_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_7", "ak74u_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_8", "ak74u_mp");
	setDvar("scr_mod_weaponbox_weapon_9", "ak74u_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_10", "ak74u_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_11", "barrett_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_12", "barrett_mp");
	setDvar("scr_mod_weaponbox_weapon_13", "beretta_mp");
	setDvar("scr_mod_weaponbox_weapon_14", "beretta_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_15", "c4_mp");
	setDvar("scr_mod_weaponbox_weapon_16", "claymore_mp");
	setDvar("scr_mod_weaponbox_weapon_17", "colt45_mp");
	setDvar("scr_mod_weaponbox_weapon_18", "colt45_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_19", "concussion_grenade_mp");
	setDvar("scr_mod_weaponbox_weapon_20", "deserteagle_mp");
	setDvar("scr_mod_weaponbox_weapon_21", "deserteaglegold_mp");
	setDvar("scr_mod_weaponbox_weapon_22", "dragunov_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_23", "dragunov_mp");
	setDvar("scr_mod_weaponbox_weapon_24", "flash_grenade_mp");
	setDvar("scr_mod_weaponbox_weapon_25", "frag_grenade_mp");
	setDvar("scr_mod_weaponbox_weapon_26", "frag_grenade_short_mp");
	setDvar("scr_mod_weaponbox_weapon_27", "g3_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_28", "g3_gl_mp");
	setDvar("scr_mod_weaponbox_weapon_29", "g3_mp");
	setDvar("scr_mod_weaponbox_weapon_30", "g3_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_31", "g3_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_32", "g36c_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_33", "g36c_gl_mp");
	setDvar("scr_mod_weaponbox_weapon_34", "g36c_mp");
	setDvar("scr_mod_weaponbox_weapon_35", "g36c_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_36", "g36c_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_37", "helicopter_mp");
	setDvar("scr_mod_weaponbox_weapon_38", "m1014_grip_mp");
	setDvar("scr_mod_weaponbox_weapon_39", "m1014_mp");
	setDvar("scr_mod_weaponbox_weapon_40", "m1014_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_41", "m14_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_42", "m14_gl_mp");
	setDvar("scr_mod_weaponbox_weapon_43", "m14_mp");
	setDvar("scr_mod_weaponbox_weapon_44", "m14_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_45", "m14_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_46", "m16_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_47", "m16_gl_mp");
	setDvar("scr_mod_weaponbox_weapon_48", "m16_mp");
	setDvar("scr_mod_weaponbox_weapon_49", "m16_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_50", "m16_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_51", "m21_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_52", "m21_mp");
	setDvar("scr_mod_weaponbox_weapon_53", "m4_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_54", "m4_gl_mp");
	setDvar("scr_mod_weaponbox_weapon_55", "m4_mp");
	setDvar("scr_mod_weaponbox_weapon_56", "m4_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_57", "m4_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_58", "m40a3_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_59", "m40a3_mp");
	setDvar("scr_mod_weaponbox_weapon_60", "m60e4_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_61", "m60e4_grip_mp");
	setDvar("scr_mod_weaponbox_weapon_62", "m60e4_mp");
	setDvar("scr_mod_weaponbox_weapon_63", "m60e4_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_64", "mortar_mp");
	setDvar("scr_mod_weaponbox_weapon_65", "mp44_mp");
	setDvar("scr_mod_weaponbox_weapon_66", "mp5_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_67", "mp5_mp");
	setDvar("scr_mod_weaponbox_weapon_68", "mp5_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_69", "mp5_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_70", "p90_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_71", "p90_mp");
	setDvar("scr_mod_weaponbox_weapon_72", "p90_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_73", "p90_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_74", "radar_mp");
	setDvar("scr_mod_weaponbox_weapon_75", "remington700_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_76", "remington700_mp");
	setDvar("scr_mod_weaponbox_weapon_77", "rpd_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_78", "rpd_grip_mp");
	setDvar("scr_mod_weaponbox_weapon_79", "rpd_mp");
	setDvar("scr_mod_weaponbox_weapon_80", "rpd_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_81", "rpg_mp");
	setDvar("scr_mod_weaponbox_weapon_82", "saw_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_83", "saw_grip_mp");
	setDvar("scr_mod_weaponbox_weapon_84", "saw_mp");
	setDvar("scr_mod_weaponbox_weapon_85", "saw_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_86", "skorpion_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_87", "skorpion_mp");
	setDvar("scr_mod_weaponbox_weapon_88", "skorpion_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_89", "skorpion_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_90", "smoke_grenade_mp");
	setDvar("scr_mod_weaponbox_weapon_91", "usp_mp");
	setDvar("scr_mod_weaponbox_weapon_92", "usp_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_93", "uzi_acog_mp");
	setDvar("scr_mod_weaponbox_weapon_94", "uzi_mp");
	setDvar("scr_mod_weaponbox_weapon_95", "uzi_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_96", "uzi_silencer_mp");
	setDvar("scr_mod_weaponbox_weapon_97", "winchester1200_mp");
	setDvar("scr_mod_weaponbox_weapon_98", "winchester1200_reflex_mp");
	setDvar("scr_mod_weaponbox_weapon_99", "tripwire");
	setDvar("scr_mod_weaponbox_weapon_100", "knife_mp");
	// add or remove as many as you want

	// weapons the assassins can buy at the box
	setDvar("scr_mod_weaponbox_assassinweapon_1", "javelin_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_2", "marker_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_3", "c4_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_4", "m21_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_5", "skorpion_silencer_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_6", "knife_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_7", "remington700_acog_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_8", "remington700_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_9", "m40a3_acog_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_10", "m40a3_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_11", "tripwire");
	setDvar("scr_mod_weaponbox_assassinweapon_12", "frag_grenade_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_13", "beretta_silencer_mp");
	setDvar("scr_mod_weaponbox_assassinweapon_14", "marker_mp");
}