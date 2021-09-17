
// =========================================================================================
// File Name = 'mp_dust3_waypoints.gsc'
// Map Name  = 'mp_dust3'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_dust3'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_dust3/mp_dust3_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_dust3')
    {
        // thread btd_waypoints/mp_dust3/mp_dust3_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_dust3/mp_dust3_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_dust3/mp_dust3_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_dust3/mp_dust3_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_dust3/mp_dust3_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_dust3/mp_dust3_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (3052.15,-712.221,0.125);
    level.waypoints[0].childCount = 2;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 33;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (3062.63,-1414.2,0.125);
    level.waypoints[1].childCount = 2;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (3310.62,-1497.75,32.125);
    level.waypoints[2].childCount = 2;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (3362.7,-1644.84,32.125);
    level.waypoints[3].childCount = 2;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (2684.96,-1741.58,-63.9911);
    level.waypoints[4].childCount = 3;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[4].children[2] = 32;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (1680.33,-1734.86,-63.875);
    level.waypoints[5].childCount = 4;
    level.waypoints[5].children[0] = 4;
    level.waypoints[5].children[1] = 6;
    level.waypoints[5].children[2] = 8;
    level.waypoints[5].children[3] = 9;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (1641.98,-1923.18,-47.9914);
    level.waypoints[6].childCount = 2;
    level.waypoints[6].children[0] = 5;
    level.waypoints[6].children[1] = 7;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (1012.31,-1917.59,-47.875);
    level.waypoints[7].childCount = 2;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 8;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (1013.82,-1727.38,-190.485);
    level.waypoints[8].childCount = 3;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 5;
    level.waypoints[8].children[2] = 10;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (1625.61,-1493.9,-63.875);
    level.waypoints[9].childCount = 3;
    level.waypoints[9].children[0] = 5;
    level.waypoints[9].children[1] = 10;
    level.waypoints[9].children[2] = 11;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (1001.67,-1494.04,-63.875);
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 9;
    level.waypoints[10].children[1] = 8;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (1523.49,-1068.2,-63.875);
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 9;
    level.waypoints[11].children[1] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (1259.03,-901.772,-63.875);
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 13;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (1000.96,-1042.16,-63.875);
    level.waypoints[13].childCount = 2;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (822.162,-866.427,-63.875);
    level.waypoints[14].childCount = 3;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 15;
    level.waypoints[14].children[2] = 36;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (50.3141,-830.069,-63.875);
    level.waypoints[15].childCount = 3;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[15].children[2] = 45;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (29.8799,-187.332,16.125);
    level.waypoints[16].childCount = 3;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 17;
    level.waypoints[16].children[2] = 47;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (14.4596,992.204,16.125);
    level.waypoints[17].childCount = 2;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 18;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (820.243,998.463,-63.875);
    level.waypoints[18].childCount = 2;
    level.waypoints[18].children[0] = 17;
    level.waypoints[18].children[1] = 19;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (1040.27,702.988,-31.875);
    level.waypoints[19].childCount = 2;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (1669.12,722.972,-31.875);
    level.waypoints[20].childCount = 3;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 21;
    level.waypoints[20].children[2] = 43;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (1784.21,982.388,-31.875);
    level.waypoints[21].childCount = 2;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 22;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (2548.07,977.12,-47.875);
    level.waypoints[22].childCount = 3;
    level.waypoints[22].children[0] = 21;
    level.waypoints[22].children[1] = 23;
    level.waypoints[22].children[2] = 26;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (3278.19,959.256,-31.875);
    level.waypoints[23].childCount = 2;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 24;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (3151.62,692.578,-47.8833);
    level.waypoints[24].childCount = 2;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 25;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (3045.36,601.143,-47.9331);
    level.waypoints[25].childCount = 2;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 26;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (2638.27,620.718,-47.9495);
    level.waypoints[26].childCount = 3;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 27;
    level.waypoints[26].children[2] = 22;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (2765.93,448.571,-47.9993);
    level.waypoints[27].childCount = 3;
    level.waypoints[27].children[0] = 26;
    level.waypoints[27].children[1] = 28;
    level.waypoints[27].children[2] = 31;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (3210.4,446.336,-47.875);
    level.waypoints[28].childCount = 2;
    level.waypoints[28].children[0] = 27;
    level.waypoints[28].children[1] = 29;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (3255.39,232.891,-1.875);
    level.waypoints[29].childCount = 2;
    level.waypoints[29].children[0] = 28;
    level.waypoints[29].children[1] = 30;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (3247.22,127.404,-255.875);
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 31;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (2772.9,-208.001,-255.875);
    level.waypoints[31].childCount = 4;
    level.waypoints[31].children[0] = 30;
    level.waypoints[31].children[1] = 27;
    level.waypoints[31].children[2] = 32;
    level.waypoints[31].children[3] = 40;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (2669.72,-1072.91,-223.658);
    level.waypoints[32].childCount = 2;
    level.waypoints[32].children[0] = 31;
    level.waypoints[32].children[1] = 4;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (2408.51,-669.57,0.125);
    level.waypoints[33].childCount = 2;
    level.waypoints[33].children[0] = 0;
    level.waypoints[33].children[1] = 34;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (2132.37,-642.99,-63.875);
    level.waypoints[34].childCount = 2;
    level.waypoints[34].children[0] = 33;
    level.waypoints[34].children[1] = 35;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (2028.45,-458.083,-63.875);
    level.waypoints[35].childCount = 2;
    level.waypoints[35].children[0] = 34;
    level.waypoints[35].children[1] = 36;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (802.72,-469.232,-63.875);
    level.waypoints[36].childCount = 4;
    level.waypoints[36].children[0] = 35;
    level.waypoints[36].children[1] = 14;
    level.waypoints[36].children[2] = 37;
    level.waypoints[36].children[3] = 46;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (974.298,-218.184,-63.875);
    level.waypoints[37].childCount = 3;
    level.waypoints[37].children[0] = 36;
    level.waypoints[37].children[1] = 38;
    level.waypoints[37].children[2] = 44;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (2098.89,-209.636,-255.997);
    level.waypoints[38].childCount = 3;
    level.waypoints[38].children[0] = 37;
    level.waypoints[38].children[1] = 39;
    level.waypoints[38].children[2] = 41;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (2276.9,-293.052,-255.912);
    level.waypoints[39].childCount = 2;
    level.waypoints[39].children[0] = 38;
    level.waypoints[39].children[1] = 40;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (2406.42,-185.994,-255.984);
    level.waypoints[40].childCount = 2;
    level.waypoints[40].children[0] = 39;
    level.waypoints[40].children[1] = 31;
    level.waypoints[41] = spawnstruct();
    level.waypoints[41].origin = (2146.95,228.825,-255.875);
    level.waypoints[41].childCount = 2;
    level.waypoints[41].children[0] = 38;
    level.waypoints[41].children[1] = 42;
    level.waypoints[42] = spawnstruct();
    level.waypoints[42].origin = (1688.54,258.145,-112.375);
    level.waypoints[42].childCount = 2;
    level.waypoints[42].children[0] = 41;
    level.waypoints[42].children[1] = 43;
    level.waypoints[43] = spawnstruct();
    level.waypoints[43].origin = (1674.8,483.669,-31.875);
    level.waypoints[43].childCount = 2;
    level.waypoints[43].children[0] = 42;
    level.waypoints[43].children[1] = 20;
    level.waypoints[44] = spawnstruct();
    level.waypoints[44].origin = (219.403,-210.84,-63.875);
    level.waypoints[44].childCount = 2;
    level.waypoints[44].children[0] = 37;
    level.waypoints[44].children[1] = 45;
    level.waypoints[45] = spawnstruct();
    level.waypoints[45].origin = (197.208,-667.767,-63.875);
    level.waypoints[45].childCount = 2;
    level.waypoints[45].children[0] = 44;
    level.waypoints[45].children[1] = 15;
    level.waypoints[46] = spawnstruct();
    level.waypoints[46].origin = (556.74,-1038.26,-63.875);
    level.waypoints[46].childCount = 2;
    level.waypoints[46].children[0] = 36;
    level.waypoints[46].children[1] = 47;
    level.waypoints[47] = spawnstruct();
    level.waypoints[47].origin = (82.8345,-689.216,-63.875);
    level.waypoints[47].childCount = 2;
    level.waypoints[47].children[0] = 46;
    level.waypoints[47].children[1] = 16;
 
    level.waypointCount = level.waypoints.size;
}
