// =========================================================================================
// File Name = 'mp_blast_waypoints.gsc'
// Map Name  = 'mp_blast'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_blast'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_blast/mp_blast_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_blast')
    {
        // thread btd_waypoints/mp_blast/mp_blast_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_blast/mp_blast_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_blast/mp_blast_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_blast/mp_blast_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_blast/mp_blast_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_blast/mp_blast_anticamp::load_anticamp(); 
        // thread btd_waypoints/mp_blast/mp_blast_playerspawns::load_playerspawns(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (514.98,552.048,-191.875);
    level.waypoints[0].childCount = 3;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 5;
    level.waypoints[0].children[2] = 6;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (429.171,746.839,-191.875);
    level.waypoints[1].childCount = 3;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[1].children[2] = 5;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (317.896,1019.62,-191.875);
    level.waypoints[2].childCount = 4;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[2].children[2] = 7;
    level.waypoints[2].children[3] = 5;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (502.817,1201.25,-191.875);
    level.waypoints[3].childCount = 7;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[3].children[2] = 7;
    level.waypoints[3].children[3] = 8;
    level.waypoints[3].children[4] = 8;
    level.waypoints[3].children[5] = 9;
    level.waypoints[3].children[6] = 32;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (694.666,1088.01,-191.875);
    level.waypoints[4].childCount = 4;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 6;
    level.waypoints[4].children[2] = 7;
    level.waypoints[4].children[3] = 5;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (516.791,862.566,-191.875);
    level.waypoints[5].childCount = 6;
    level.waypoints[5].children[0] = 1;
    level.waypoints[5].children[1] = 0;
    level.waypoints[5].children[2] = 6;
    level.waypoints[5].children[3] = 7;
    level.waypoints[5].children[4] = 4;
    level.waypoints[5].children[5] = 2;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (588.897,729.943,-191.875);
    level.waypoints[6].childCount = 3;
    level.waypoints[6].children[0] = 0;
    level.waypoints[6].children[1] = 5;
    level.waypoints[6].children[2] = 4;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (513.346,1034.14,-191.875);
    level.waypoints[7].childCount = 4;
    level.waypoints[7].children[0] = 5;
    level.waypoints[7].children[1] = 2;
    level.waypoints[7].children[2] = 4;
    level.waypoints[7].children[3] = 3;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (344.688,1393.8,-191.875);
    level.waypoints[8].childCount = 4;
    level.waypoints[8].children[0] = 3;
    level.waypoints[8].children[1] = 3;
    level.waypoints[8].children[2] = 9;
    level.waypoints[8].children[3] = 27;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (515.236,1380.56,-191.875);
    level.waypoints[9].childCount = 4;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 3;
    level.waypoints[9].children[2] = 29;
    level.waypoints[9].children[3] = 32;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (843.363,1730.82,-191.875);
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 13;
    level.waypoints[10].children[1] = 32;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (935.472,2001.88,-95.875);
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 12;
    level.waypoints[11].children[1] = 13;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (905.361,2255.23,-95.875);
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 14;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (906.677,1875.56,-148.312);
    level.waypoints[13].childCount = 2;
    level.waypoints[13].children[0] = 10;
    level.waypoints[13].children[1] = 11;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (708.57,2580.96,-95.875);
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 12;
    level.waypoints[14].children[1] = 15;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (515.3,2752.48,-95.875);
    level.waypoints[15].childCount = 4;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[15].children[2] = 17;
    level.waypoints[15].children[3] = 31;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (356.163,2653.11,-95.875);
    level.waypoints[16].childCount = 3;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 24;
    level.waypoints[16].children[2] = 31;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (520.852,2915.15,-95.875);
    level.waypoints[17].childCount = 4;
    level.waypoints[17].children[0] = 15;
    level.waypoints[17].children[1] = 23;
    level.waypoints[17].children[2] = 21;
    level.waypoints[17].children[3] = 18;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (520.759,3133.3,-95.875);
    level.waypoints[18].childCount = 6;
    level.waypoints[18].children[0] = 19;
    level.waypoints[18].children[1] = 20;
    level.waypoints[18].children[2] = 21;
    level.waypoints[18].children[3] = 22;
    level.waypoints[18].children[4] = 23;
    level.waypoints[18].children[5] = 17;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (509.793,3490.97,-95.875);
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 20;
    level.waypoints[19].children[2] = 22;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (440.148,3297.42,-95.875);
    level.waypoints[20].childCount = 3;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 18;
    level.waypoints[20].children[2] = 21;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (370.465,3045.88,-95.875);
    level.waypoints[21].childCount = 3;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 18;
    level.waypoints[21].children[2] = 17;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (612.466,3271.98,-95.875);
    level.waypoints[22].childCount = 3;
    level.waypoints[22].children[0] = 19;
    level.waypoints[22].children[1] = 18;
    level.waypoints[22].children[2] = 23;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (685.464,3024.81,-95.875);
    level.waypoints[23].childCount = 3;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 18;
    level.waypoints[23].children[2] = 17;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (192.78,2354.18,-95.875);
    level.waypoints[24].childCount = 4;
    level.waypoints[24].children[0] = 16;
    level.waypoints[24].children[1] = 25;
    level.waypoints[24].children[2] = 30;
    level.waypoints[24].children[3] = 31;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (74.3093,2040.14,-95.875);
    level.waypoints[25].childCount = 3;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 26;
    level.waypoints[25].children[2] = 30;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (100.57,1856.33,-157.925);
    level.waypoints[26].childCount = 3;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 27;
    level.waypoints[26].children[2] = 28;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (236.068,1624.27,-191.875);
    level.waypoints[27].childCount = 3;
    level.waypoints[27].children[0] = 26;
    level.waypoints[27].children[1] = 8;
    level.waypoints[27].children[2] = 29;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (252.007,1730.27,-191.875);
    level.waypoints[28].childCount = 2;
    level.waypoints[28].children[0] = 29;
    level.waypoints[28].children[1] = 26;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (389.956,1469.09,-191.875);
    level.waypoints[29].childCount = 3;
    level.waypoints[29].children[0] = 9;
    level.waypoints[29].children[1] = 28;
    level.waypoints[29].children[2] = 27;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (35.5448,2221.75,-95.875);
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 25;
    level.waypoints[30].children[1] = 24;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (410.418,2567.33,-95.875);
    level.waypoints[31].childCount = 3;
    level.waypoints[31].children[0] = 15;
    level.waypoints[31].children[1] = 16;
    level.waypoints[31].children[2] = 24;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (645.956,1380.65,-191.875);
    level.waypoints[32].childCount = 3;
    level.waypoints[32].children[0] = 9;
    level.waypoints[32].children[1] = 10;
    level.waypoints[32].children[2] = 3;
 
    level.waypointCount = level.waypoints.size;
}
