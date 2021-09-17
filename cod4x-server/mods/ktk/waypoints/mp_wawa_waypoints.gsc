// =========================================================================================
// File Name = 'mp_wawa_waypoints.gsc'
// Map Name  = 'mp_wawa'
// =========================================================================================
// 
// This is an auto generated script file created by the PeZBOT Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_wawa'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'Dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - new_waypoints.iwd/mp_wawa_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
/*
 
    else if(mapname == 'mp_wawa')
    {
        thread Waypoints/mp_wawa_waypoints::load_waypoints();
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-496,1138,0.125);
    level.waypoints[0].type = "stand";
    level.waypoints[0].childCount = 2;
    level.waypoints[0].children[0] = 33;
    level.waypoints[0].children[1] = 16;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (34,648,0.125);
    level.waypoints[1].type = "stand";
    level.waypoints[1].childCount = 2;
    level.waypoints[1].children[0] = 13;
    level.waypoints[1].children[1] = 14;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-568,166,0.125);
    level.waypoints[2].type = "stand";
    level.waypoints[2].childCount = 2;
    level.waypoints[2].children[0] = 12;
    level.waypoints[2].children[1] = 19;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-730,592,0.125);
    level.waypoints[3].type = "stand";
    level.waypoints[3].childCount = 3;
    level.waypoints[3].children[0] = 38;
    level.waypoints[3].children[1] = 37;
    level.waypoints[3].children[2] = 31;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-810.787,938.787,0.125);
    level.waypoints[4].type = "stand";
    level.waypoints[4].childCount = 3;
    level.waypoints[4].children[0] = 31;
    level.waypoints[4].children[1] = 32;
    level.waypoints[4].children[2] = 34;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (58.7868,1090.79,0.125);
    level.waypoints[5].type = "stand";
    level.waypoints[5].childCount = 2;
    level.waypoints[5].children[0] = 14;
    level.waypoints[5].children[1] = 15;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (-85.2132,173.213,0.125);
    level.waypoints[6].type = "stand";
    level.waypoints[6].childCount = 3;
    level.waypoints[6].children[0] = 9;
    level.waypoints[6].children[1] = 10;
    level.waypoints[6].children[2] = 11;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (-898.787,301.213,0.125);
    level.waypoints[7].type = "stand";
    level.waypoints[7].childCount = 3;
    level.waypoints[7].children[0] = 20;
    level.waypoints[7].children[1] = 19;
    level.waypoints[7].children[2] = 40;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (-280,1114,0.125);
    level.waypoints[8].type = "stand";
    level.waypoints[8].childCount = 1;
    level.waypoints[8].children[0] = 16;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (154.003,71.5643,0.125001);
    level.waypoints[9].type = "stand";
    level.waypoints[9].childCount = 2;
    level.waypoints[9].children[0] = 6;
    level.waypoints[9].children[1] = 11;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (26.4226,322.913,0.125001);
    level.waypoints[10].type = "stand";
    level.waypoints[10].childCount = 3;
    level.waypoints[10].children[0] = 6;
    level.waypoints[10].children[1] = 13;
    level.waypoints[10].children[2] = 25;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (-224.773,109.34,0.125001);
    level.waypoints[11].type = "stand";
    level.waypoints[11].childCount = 4;
    level.waypoints[11].children[0] = 12;
    level.waypoints[11].children[1] = 6;
    level.waypoints[11].children[2] = 24;
    level.waypoints[11].children[3] = 9;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (-418.976,103.672,0.125001);
    level.waypoints[12].type = "stand";
    level.waypoints[12].childCount = 3;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 36;
    level.waypoints[12].children[2] = 2;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (91.9285,495.316,0.125001);
    level.waypoints[13].type = "stand";
    level.waypoints[13].childCount = 3;
    level.waypoints[13].children[0] = 10;
    level.waypoints[13].children[1] = 1;
    level.waypoints[13].children[2] = 14;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (117.567,814.49,0.125001);
    level.waypoints[14].type = "stand";
    level.waypoints[14].childCount = 6;
    level.waypoints[14].children[0] = 1;
    level.waypoints[14].children[1] = 5;
    level.waypoints[14].children[2] = 15;
    level.waypoints[14].children[3] = 13;
    level.waypoints[14].children[4] = 17;
    level.waypoints[14].children[5] = 18;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (147.046,1130.12,0.125001);
    level.waypoints[15].type = "stand";
    level.waypoints[15].childCount = 3;
    level.waypoints[15].children[0] = 5;
    level.waypoints[15].children[1] = 14;
    level.waypoints[15].children[2] = 16;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-132.495,1166.75,0.125001);
    level.waypoints[16].type = "stand";
    level.waypoints[16].childCount = 5;
    level.waypoints[16].children[0] = 0;
    level.waypoints[16].children[1] = 8;
    level.waypoints[16].children[2] = 17;
    level.waypoints[16].children[3] = 15;
    level.waypoints[16].children[4] = 39;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-146.304,1032.87,0.125001);
    level.waypoints[17].type = "stand";
    level.waypoints[17].childCount = 4;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 18;
    level.waypoints[17].children[2] = 27;
    level.waypoints[17].children[3] = 14;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (-236.369,893.085,0.125001);
    level.waypoints[18].type = "stand";
    level.waypoints[18].childCount = 4;
    level.waypoints[18].children[0] = 28;
    level.waypoints[18].children[1] = 27;
    level.waypoints[18].children[2] = 17;
    level.waypoints[18].children[3] = 14;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-653.238,86.7116,0.125001);
    level.waypoints[19].type = "stand";
    level.waypoints[19].childCount = 4;
    level.waypoints[19].children[0] = 2;
    level.waypoints[19].children[1] = 20;
    level.waypoints[19].children[2] = 21;
    level.waypoints[19].children[3] = 7;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-879.29,135.468,0.125001);
    level.waypoints[20].type = "stand";
    level.waypoints[20].childCount = 4;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 7;
    level.waypoints[20].children[2] = 21;
    level.waypoints[20].children[3] = 40;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (-718.634,274.848,0.125001);
    level.waypoints[21].type = "stand";
    level.waypoints[21].childCount = 3;
    level.waypoints[21].children[0] = 22;
    level.waypoints[21].children[1] = 20;
    level.waypoints[21].children[2] = 19;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (-669.331,419.514,0.125001);
    level.waypoints[22].type = "stand";
    level.waypoints[22].childCount = 4;
    level.waypoints[22].children[0] = 38;
    level.waypoints[22].children[1] = 21;
    level.waypoints[22].children[2] = 23;
    level.waypoints[22].children[3] = 36;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (-510.336,430.912,0.125001);
    level.waypoints[23].type = "stand";
    level.waypoints[23].childCount = 4;
    level.waypoints[23].children[0] = 36;
    level.waypoints[23].children[1] = 35;
    level.waypoints[23].children[2] = 22;
    level.waypoints[23].children[3] = 24;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (-258.833,414.346,0.125001);
    level.waypoints[24].type = "stand";
    level.waypoints[24].childCount = 6;
    level.waypoints[24].children[0] = 25;
    level.waypoints[24].children[1] = 36;
    level.waypoints[24].children[2] = 11;
    level.waypoints[24].children[3] = 23;
    level.waypoints[24].children[4] = 35;
    level.waypoints[24].children[5] = 26;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (-115.317,497.915,0.125001);
    level.waypoints[25].type = "stand";
    level.waypoints[25].childCount = 3;
    level.waypoints[25].children[0] = 26;
    level.waypoints[25].children[1] = 24;
    level.waypoints[25].children[2] = 10;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (-171.203,634.576,0.125001);
    level.waypoints[26].type = "stand";
    level.waypoints[26].childCount = 3;
    level.waypoints[26].children[0] = 27;
    level.waypoints[26].children[1] = 25;
    level.waypoints[26].children[2] = 24;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-184.656,795.647,0.125001);
    level.waypoints[27].type = "stand";
    level.waypoints[27].childCount = 3;
    level.waypoints[27].children[0] = 18;
    level.waypoints[27].children[1] = 26;
    level.waypoints[27].children[2] = 17;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (-407.859,905.903,0.125001);
    level.waypoints[28].type = "stand";
    level.waypoints[28].childCount = 3;
    level.waypoints[28].children[0] = 29;
    level.waypoints[28].children[1] = 18;
    level.waypoints[28].children[2] = 39;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (-550.366,816.287,0.125001);
    level.waypoints[29].type = "stand";
    level.waypoints[29].childCount = 4;
    level.waypoints[29].children[0] = 34;
    level.waypoints[29].children[1] = 28;
    level.waypoints[29].children[2] = 35;
    level.waypoints[29].children[3] = 30;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (-710.386,711.15,0.125001);
    level.waypoints[30].type = "stand";
    level.waypoints[30].childCount = 5;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 38;
    level.waypoints[30].children[2] = 37;
    level.waypoints[30].children[3] = 35;
    level.waypoints[30].children[4] = 34;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (-946.32,850.549,0.125001);
    level.waypoints[31].type = "stand";
    level.waypoints[31].childCount = 4;
    level.waypoints[31].children[0] = 37;
    level.waypoints[31].children[1] = 4;
    level.waypoints[31].children[2] = 3;
    level.waypoints[31].children[3] = 32;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (-932.735,1074.35,0.125001);
    level.waypoints[32].type = "stand";
    level.waypoints[32].childCount = 4;
    level.waypoints[32].children[0] = 4;
    level.waypoints[32].children[1] = 33;
    level.waypoints[32].children[2] = 34;
    level.waypoints[32].children[3] = 31;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (-706.957,1179.11,0.125001);
    level.waypoints[33].type = "stand";
    level.waypoints[33].childCount = 4;
    level.waypoints[33].children[0] = 32;
    level.waypoints[33].children[1] = 0;
    level.waypoints[33].children[2] = 34;
    level.waypoints[33].children[3] = 39;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (-660.665,987.633,0.125001);
    level.waypoints[34].type = "stand";
    level.waypoints[34].childCount = 5;
    level.waypoints[34].children[0] = 33;
    level.waypoints[34].children[1] = 29;
    level.waypoints[34].children[2] = 30;
    level.waypoints[34].children[3] = 32;
    level.waypoints[34].children[4] = 4;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (-549.258,607.244,0.125001);
    level.waypoints[35].type = "stand";
    level.waypoints[35].childCount = 4;
    level.waypoints[35].children[0] = 23;
    level.waypoints[35].children[1] = 29;
    level.waypoints[35].children[2] = 24;
    level.waypoints[35].children[3] = 30;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (-466.68,290.244,0.125001);
    level.waypoints[36].type = "stand";
    level.waypoints[36].childCount = 4;
    level.waypoints[36].children[0] = 12;
    level.waypoints[36].children[1] = 24;
    level.waypoints[36].children[2] = 23;
    level.waypoints[36].children[3] = 22;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (-965.264,657.986,0.125001);
    level.waypoints[37].type = "stand";
    level.waypoints[37].childCount = 5;
    level.waypoints[37].children[0] = 31;
    level.waypoints[37].children[1] = 30;
    level.waypoints[37].children[2] = 38;
    level.waypoints[37].children[3] = 3;
    level.waypoints[37].children[4] = 40;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (-847.249,532.715,0.125001);
    level.waypoints[38].type = "stand";
    level.waypoints[38].childCount = 5;
    level.waypoints[38].children[0] = 3;
    level.waypoints[38].children[1] = 30;
    level.waypoints[38].children[2] = 37;
    level.waypoints[38].children[3] = 22;
    level.waypoints[38].children[4] = 40;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (-388.181,1178.2,0.125001);
    level.waypoints[39].type = "stand";
    level.waypoints[39].childCount = 3;
    level.waypoints[39].children[0] = 28;
    level.waypoints[39].children[1] = 16;
    level.waypoints[39].children[2] = 33;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (-968.142,304.232,0.124999);
    level.waypoints[40].type = "stand";
    level.waypoints[40].childCount = 4;
    level.waypoints[40].children[0] = 37;
    level.waypoints[40].children[1] = 20;
    level.waypoints[40].children[2] = 7;
    level.waypoints[40].children[3] = 38;
 
    level.waypointCount = level.waypoints.size;
 
}