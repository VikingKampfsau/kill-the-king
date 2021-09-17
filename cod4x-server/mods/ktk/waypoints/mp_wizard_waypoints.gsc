
// =========================================================================================
// File Name = 'mp_wizard_waypoints.gsc'
// Map Name  = 'mp_wizard'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_wizard'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_wizard/mp_wizard_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_wizard')
    {
        // thread btd_waypoints/mp_wizard/mp_wizard_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_wizard/mp_wizard_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_wizard/mp_wizard_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_wizard/mp_wizard_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_wizard/mp_wizard_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_wizard/mp_wizard_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (924.355,-68.4039,16.125);
    level.waypoints[0].childCount = 4;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 15;
    level.waypoints[0].children[2] = 16;
    level.waypoints[0].children[3] = 36;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (916.715,299.794,16.125);
    level.waypoints[1].childCount = 3;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[1].children[2] = 23;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (903.045,636.331,16.125);
    level.waypoints[2].childCount = 2;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (567.155,944.578,16.125);
    level.waypoints[3].childCount = 2;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (225.95,917.876,16.125);
    level.waypoints[4].childCount = 4;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[4].children[2] = 21;
    level.waypoints[4].children[3] = 28;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (-135.129,944.802,16.125);
    level.waypoints[5].childCount = 2;
    level.waypoints[5].children[0] = 4;
    level.waypoints[5].children[1] = 6;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (-480.583,923.105,16.125);
    level.waypoints[6].childCount = 2;
    level.waypoints[6].children[0] = 5;
    level.waypoints[6].children[1] = 7;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (-844.751,514.782,16.125);
    level.waypoints[7].childCount = 2;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 8;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (-807.9,177.502,16.125);
    level.waypoints[8].childCount = 4;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 9;
    level.waypoints[8].children[2] = 20;
    level.waypoints[8].children[3] = 24;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (-808.082,-129.148,16.125);
    level.waypoints[9].childCount = 3;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 10;
    level.waypoints[9].children[2] = 19;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (-804.189,-480.271,16.125);
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 9;
    level.waypoints[10].children[1] = 11;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (-411.53,-810.956,16.125);
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (-42.4185,-786.918,16.125);
    level.waypoints[12].childCount = 4;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 13;
    level.waypoints[12].children[2] = 17;
    level.waypoints[12].children[3] = 32;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (251.756,-823.523,16.125);
    level.waypoints[13].childCount = 3;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[13].children[2] = 16;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (598.356,-806.365,16.125);
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 15;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (926.493,-415.131,16.125);
    level.waypoints[15].childCount = 2;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 0;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (563.982,-75.5415,16.125);
    level.waypoints[16].childCount = 6;
    level.waypoints[16].children[0] = 0;
    level.waypoints[16].children[1] = 13;
    level.waypoints[16].children[2] = 17;
    level.waypoints[16].children[3] = 21;
    level.waypoints[16].children[4] = 23;
    level.waypoints[16].children[5] = 36;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (1.61341,-312.196,16.125);
    level.waypoints[17].childCount = 5;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 12;
    level.waypoints[17].children[2] = 18;
    level.waypoints[17].children[3] = 20;
    level.waypoints[17].children[4] = 32;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (-349.008,-476.954,16.125);
    level.waypoints[18].childCount = 2;
    level.waypoints[18].children[0] = 17;
    level.waypoints[18].children[1] = 19;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-460.335,-217.956,16.125);
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 9;
    level.waypoints[19].children[2] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-383.51,146.853,16.125);
    level.waypoints[20].childCount = 5;
    level.waypoints[20].children[0] = 8;
    level.waypoints[20].children[1] = 17;
    level.waypoints[20].children[2] = 21;
    level.waypoints[20].children[3] = 19;
    level.waypoints[20].children[4] = 24;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (88.2895,517.33,16.125);
    level.waypoints[21].childCount = 5;
    level.waypoints[21].children[0] = 4;
    level.waypoints[21].children[1] = 16;
    level.waypoints[21].children[2] = 22;
    level.waypoints[21].children[3] = 20;
    level.waypoints[21].children[4] = 28;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (470.045,558.874,16.125);
    level.waypoints[22].childCount = 2;
    level.waypoints[22].children[0] = 21;
    level.waypoints[22].children[1] = 23;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (647.668,320.646,16.125);
    level.waypoints[23].childCount = 3;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 1;
    level.waypoints[23].children[2] = 16;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (-616.6,55.078,16.125);
    level.waypoints[24].childCount = 3;
    level.waypoints[24].children[0] = 20;
    level.waypoints[24].children[1] = 8;
    level.waypoints[24].children[2] = 25;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (-607.017,-258.459,130.125);
    level.waypoints[25].childCount = 3;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 26;
    level.waypoints[25].children[2] = 27;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (-475.26,-600.4,130.125);
    level.waypoints[26].childCount = 2;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 27;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-312.928,-371.295,130.125);
    level.waypoints[27].childCount = 2;
    level.waypoints[27].children[0] = 26;
    level.waypoints[27].children[1] = 25;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (40.4188,748.829,20.5772);
    level.waypoints[28].childCount = 3;
    level.waypoints[28].children[0] = 4;
    level.waypoints[28].children[1] = 21;
    level.waypoints[28].children[2] = 29;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (-250.79,733.401,130.125);
    level.waypoints[29].childCount = 3;
    level.waypoints[29].children[0] = 28;
    level.waypoints[29].children[1] = 30;
    level.waypoints[29].children[2] = 31;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (-570.485,597.405,130.125);
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 31;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (-337.521,415.366,130.125);
    level.waypoints[31].childCount = 2;
    level.waypoints[31].children[0] = 30;
    level.waypoints[31].children[1] = 29;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (59.1607,-626.127,16.125);
    level.waypoints[32].childCount = 3;
    level.waypoints[32].children[0] = 12;
    level.waypoints[32].children[1] = 17;
    level.waypoints[32].children[2] = 33;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (441.347,-599.787,130.125);
    level.waypoints[33].childCount = 3;
    level.waypoints[33].children[0] = 32;
    level.waypoints[33].children[1] = 34;
    level.waypoints[33].children[2] = 35;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (752.576,-372.131,130.125);
    level.waypoints[34].childCount = 2;
    level.waypoints[34].children[0] = 33;
    level.waypoints[34].children[1] = 35;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (457.341,-299.756,130.125);
    level.waypoints[35].childCount = 2;
    level.waypoints[35].children[0] = 34;
    level.waypoints[35].children[1] = 33;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (759.063,72.4921,16.125);
    level.waypoints[36].childCount = 3;
    level.waypoints[36].children[0] = 0;
    level.waypoints[36].children[1] = 16;
    level.waypoints[36].children[2] = 37;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (734.785,413.129,130.125);
    level.waypoints[37].childCount = 3;
    level.waypoints[37].children[0] = 36;
    level.waypoints[37].children[1] = 38;
    level.waypoints[37].children[2] = 39;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (472.125,752.435,130.125);
    level.waypoints[38].childCount = 2;
    level.waypoints[38].children[0] = 37;
    level.waypoints[38].children[1] = 39;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (414.525,415.205,130.125);
    level.waypoints[39].childCount = 2;
    level.waypoints[39].children[0] = 38;
    level.waypoints[39].children[1] = 37;
 
    level.waypointCount = level.waypoints.size;
}
