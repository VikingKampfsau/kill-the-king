// =========================================================================================
// File Name = 'mp_laugh_waypoints.gsc'
// Map Name  = 'mp_laugh'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_laugh'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_laugh/mp_laugh_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_laugh')
    {
        // thread btd_waypoints/mp_laugh/mp_laugh_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_laugh/mp_laugh_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_laugh/mp_laugh_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_laugh/mp_laugh_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_laugh/mp_laugh_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_laugh/mp_laugh_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (15.125,671.028,0.00387334);
    level.waypoints[0].childCount = 2;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 6;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (15.1285,1008.87,0.103873);
    level.waypoints[1].childCount = 3;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[1].children[2] = 3;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (464.875,1008.87,0.103873);
    level.waypoints[2].childCount = 3;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[2].children[2] = 6;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (462.627,741.683,0.0566517);
    level.waypoints[3].childCount = 5;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[3].children[2] = 6;
    level.waypoints[3].children[3] = 1;
    level.waypoints[3].children[4] = 5;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (464.875,431.125,0.0226672);
    level.waypoints[4].childCount = 3;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[4].children[2] = 6;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (161.691,440.734,0.0330358);
    level.waypoints[5].childCount = 4;
    level.waypoints[5].children[0] = 4;
    level.waypoints[5].children[1] = 6;
    level.waypoints[5].children[2] = 3;
    level.waypoints[5].children[3] = 7;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (173.468,709.799,0.124999);
    level.waypoints[6].childCount = 5;
    level.waypoints[6].children[0] = 5;
    level.waypoints[6].children[1] = 0;
    level.waypoints[6].children[2] = 3;
    level.waypoints[6].children[3] = 2;
    level.waypoints[6].children[4] = 4;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (29.3551,479.714,0.124999);
    level.waypoints[7].childCount = 2;
    level.waypoints[7].children[0] = 5;
    level.waypoints[7].children[1] = 8;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (32.55,998.074,192.125);
    level.waypoints[8].childCount = 2;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 9;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (439.39,1008.88,192.125);
    level.waypoints[9].childCount = 2;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 10;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (447.399,443.037,384.125);
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 9;
    level.waypoints[10].children[1] = 11;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (36.7976,439.017,384.125);
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (25.2234,1002.18,576.125);
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 13;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (450.767,1008.88,576.125);
    level.waypoints[13].childCount = 2;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (464.874,533.226,768.125);
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 15;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (454.046,431.125,768.125);
    level.waypoints[15].childCount = 2;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (30.5303,431.125,768.125);
    level.waypoints[16].childCount = 2;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 17;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (24.3426,1000.57,960.125);
    level.waypoints[17].childCount = 2;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 18;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (445.67,1008.03,960.125);
    level.waypoints[18].childCount = 2;
    level.waypoints[18].children[0] = 17;
    level.waypoints[18].children[1] = 19;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (450.07,532.33,1152.13);
    level.waypoints[19].childCount = 2;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (444.957,443.472,1152.13);
    level.waypoints[20].childCount = 2;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 21;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (41.3176,433.98,1152.13);
    level.waypoints[21].childCount = 2;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 22;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (47.8735,1008.87,1344.13);
    level.waypoints[22].childCount = 2;
    level.waypoints[22].children[0] = 21;
    level.waypoints[22].children[1] = 23;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (441.296,1008.87,1344.13);
    level.waypoints[23].childCount = 2;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 24;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (455.202,539.048,1536.13);
    level.waypoints[24].childCount = 2;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 25;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (454.831,431.125,1536.13);
    level.waypoints[25].childCount = 2;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 26;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (44.5963,445.92,1536.13);
    level.waypoints[26].childCount = 2;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 27;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (32.842,905.761,1728.13);
    level.waypoints[27].childCount = 2;
    level.waypoints[27].children[0] = 26;
    level.waypoints[27].children[1] = 28;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (23.584,1004.33,1728.13);
    level.waypoints[28].childCount = 2;
    level.waypoints[28].children[0] = 27;
    level.waypoints[28].children[1] = 29;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (454.52,1008.79,1728.13);
    level.waypoints[29].childCount = 2;
    level.waypoints[29].children[0] = 28;
    level.waypoints[29].children[1] = 30;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (423.331,463.246,1728.13);
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 31;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (58.6538,476.62,1728.13);
    level.waypoints[31].childCount = 1;
    level.waypoints[31].children[0] = 30;
 
    level.waypointCount = level.waypoints.size;
}