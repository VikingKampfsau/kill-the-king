// =========================================================================================
// File Name = 'lolzor_waypoints.gsc'
// Map Name  = 'lolzor'
// =========================================================================================
// 
// This is an auto generated script file created by the PeZBOT Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'lolzor'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'Dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - new_waypoints.iwd/lolzor_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
/*
 
    else if(mapname == 'lolzor')
    {
        thread Waypoints/lolzor_waypoints::load_waypoints();
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-61.2132,570.787,-495.875);
    level.waypoints[0].type = "stand";
    level.waypoints[0].childCount = 3;
    level.waypoints[0].children[0] = 16;
    level.waypoints[0].children[1] = 1;
    level.waypoints[0].children[2] = 18;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (-61.2132,349.213,-495.875);
    level.waypoints[1].type = "stand";
    level.waypoints[1].childCount = 4;
    level.waypoints[1].children[0] = 7;
    level.waypoints[1].children[1] = 0;
    level.waypoints[1].children[2] = 2;
    level.waypoints[1].children[3] = 10;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-282.787,349.213,-495.875);
    level.waypoints[2].type = "stand";
    level.waypoints[2].childCount = 3;
    level.waypoints[2].children[0] = 7;
    level.waypoints[2].children[1] = 1;
    level.waypoints[2].children[2] = 10;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-240,566,-495.875);
    level.waypoints[3].type = "stand";
    level.waypoints[3].childCount = 1;
    level.waypoints[3].children[0] = 16;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-666.787,421.213,-495.875);
    level.waypoints[4].type = "stand";
    level.waypoints[4].childCount = 2;
    level.waypoints[4].children[0] = 11;
    level.waypoints[4].children[1] = 12;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (-176,1034,-495.875);
    level.waypoints[5].type = "stand";
    level.waypoints[5].childCount = 2;
    level.waypoints[5].children[0] = 15;
    level.waypoints[5].children[1] = 6;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (-62,920,-495.875);
    level.waypoints[6].type = "stand";
    level.waypoints[6].childCount = 2;
    level.waypoints[6].children[0] = 15;
    level.waypoints[6].children[1] = 5;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (-159.401,435.95,-495.875);
    level.waypoints[7].type = "stand";
    level.waypoints[7].childCount = 7;
    level.waypoints[7].children[0] = 1;
    level.waypoints[7].children[1] = 2;
    level.waypoints[7].children[2] = 8;
    level.waypoints[7].children[3] = 10;
    level.waypoints[7].children[4] = 18;
    level.waypoints[7].children[5] = 19;
    level.waypoints[7].children[6] = 16;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (-2.93947,458.726,-495.875);
    level.waypoints[8].type = "stand";
    level.waypoints[8].childCount = 2;
    level.waypoints[8].children[0] = 9;
    level.waypoints[8].children[1] = 7;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (214.312,460.207,-495.875);
    level.waypoints[9].type = "stand";
    level.waypoints[9].childCount = 3;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 40;
    level.waypoints[9].children[2] = 38;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (-279.845,444.849,-495.875);
    level.waypoints[10].type = "stand";
    level.waypoints[10].childCount = 5;
    level.waypoints[10].children[0] = 7;
    level.waypoints[10].children[1] = 11;
    level.waypoints[10].children[2] = 19;
    level.waypoints[10].children[3] = 2;
    level.waypoints[10].children[4] = 1;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (-538.683,455.649,-495.875);
    level.waypoints[11].type = "stand";
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 4;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (-642.009,579.987,-495.875);
    level.waypoints[12].type = "stand";
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 13;
    level.waypoints[12].children[1] = 4;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (-639.369,906.811,-495.875);
    level.waypoints[13].type = "stand";
    level.waypoints[13].childCount = 2;
    level.waypoints[13].children[0] = 14;
    level.waypoints[13].children[1] = 12;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (-351.704,915.676,-495.875);
    level.waypoints[14].type = "stand";
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 15;
    level.waypoints[14].children[1] = 13;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (-191.839,916.328,-495.875);
    level.waypoints[15].type = "stand";
    level.waypoints[15].childCount = 4;
    level.waypoints[15].children[0] = 5;
    level.waypoints[15].children[1] = 6;
    level.waypoints[15].children[2] = 14;
    level.waypoints[15].children[3] = 17;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-165.234,585.739,-495.875);
    level.waypoints[16].type = "stand";
    level.waypoints[16].childCount = 4;
    level.waypoints[16].children[0] = 17;
    level.waypoints[16].children[1] = 3;
    level.waypoints[16].children[2] = 0;
    level.waypoints[16].children[3] = 7;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-167.507,774.225,-495.875);
    level.waypoints[17].type = "stand";
    level.waypoints[17].childCount = 2;
    level.waypoints[17].children[0] = 15;
    level.waypoints[17].children[1] = 16;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (-61.8867,435.1,-495.875);
    level.waypoints[18].type = "stand";
    level.waypoints[18].childCount = 2;
    level.waypoints[18].children[0] = 0;
    level.waypoints[18].children[1] = 7;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-168.011,310.847,-495.875);
    level.waypoints[19].type = "stand";
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 10;
    level.waypoints[19].children[1] = 7;
    level.waypoints[19].children[2] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-163.311,174.2,-495.875);
    level.waypoints[20].type = "stand";
    level.waypoints[20].childCount = 2;
    level.waypoints[20].children[0] = 21;
    level.waypoints[20].children[1] = 19;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (-165.214,36.3017,-495.875);
    level.waypoints[21].type = "stand";
    level.waypoints[21].childCount = 2;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 22;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (-315.217,34.3635,-439.875);
    level.waypoints[22].type = "stand";
    level.waypoints[22].childCount = 2;
    level.waypoints[22].children[0] = 23;
    level.waypoints[22].children[1] = 21;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (-500.076,41.7773,-343.875);
    level.waypoints[23].type = "stand";
    level.waypoints[23].childCount = 2;
    level.waypoints[23].children[0] = 24;
    level.waypoints[23].children[1] = 22;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (-663.164,41.6928,-335.875);
    level.waypoints[24].type = "stand";
    level.waypoints[24].childCount = 2;
    level.waypoints[24].children[0] = 25;
    level.waypoints[24].children[1] = 23;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (-664.239,175.658,-279.875);
    level.waypoints[25].type = "stand";
    level.waypoints[25].childCount = 2;
    level.waypoints[25].children[0] = 26;
    level.waypoints[25].children[1] = 24;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (-664.215,302.642,-247.875);
    level.waypoints[26].type = "stand";
    level.waypoints[26].childCount = 2;
    level.waypoints[26].children[0] = 27;
    level.waypoints[26].children[1] = 25;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-431.068,302.672,-247.875);
    level.waypoints[27].type = "stand";
    level.waypoints[27].childCount = 3;
    level.waypoints[27].children[0] = 28;
    level.waypoints[27].children[1] = 37;
    level.waypoints[27].children[2] = 26;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (-421.288,190.71,-247.875);
    level.waypoints[28].type = "stand";
    level.waypoints[28].childCount = 2;
    level.waypoints[28].children[0] = 29;
    level.waypoints[28].children[1] = 27;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (-254.443,190.809,-247.875);
    level.waypoints[29].type = "stand";
    level.waypoints[29].childCount = 2;
    level.waypoints[29].children[0] = 30;
    level.waypoints[29].children[1] = 28;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (-112.156,229.79,-247.875);
    level.waypoints[30].type = "stand";
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 31;
    level.waypoints[30].children[1] = 29;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (74.3519,272.509,-247.875);
    level.waypoints[31].type = "stand";
    level.waypoints[31].childCount = 2;
    level.waypoints[31].children[0] = 32;
    level.waypoints[31].children[1] = 30;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (74.2947,459.729,-247.875);
    level.waypoints[32].type = "stand";
    level.waypoints[32].childCount = 2;
    level.waypoints[32].children[0] = 33;
    level.waypoints[32].children[1] = 31;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (31.3636,697.999,-247.875);
    level.waypoints[33].type = "stand";
    level.waypoints[33].childCount = 2;
    level.waypoints[33].children[0] = 34;
    level.waypoints[33].children[1] = 32;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (-148.136,698.138,-247.875);
    level.waypoints[34].type = "stand";
    level.waypoints[34].childCount = 2;
    level.waypoints[34].children[0] = 35;
    level.waypoints[34].children[1] = 33;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (-316.092,659.859,-247.875);
    level.waypoints[35].type = "stand";
    level.waypoints[35].childCount = 2;
    level.waypoints[35].children[0] = 36;
    level.waypoints[35].children[1] = 34;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (-412.761,640.032,-247.875);
    level.waypoints[36].type = "stand";
    level.waypoints[36].childCount = 2;
    level.waypoints[36].children[0] = 37;
    level.waypoints[36].children[1] = 35;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (-412.952,443.681,-247.875);
    level.waypoints[37].type = "stand";
    level.waypoints[37].childCount = 2;
    level.waypoints[37].children[0] = 36;
    level.waypoints[37].children[1] = 27;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (286.871,401.135,-495.875);
    level.waypoints[38].type = "stand";
    level.waypoints[38].childCount = 2;
    level.waypoints[38].children[0] = 9;
    level.waypoints[38].children[1] = 39;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (348.547,463.122,-495.875);
    level.waypoints[39].type = "stand";
    level.waypoints[39].childCount = 2;
    level.waypoints[39].children[0] = 38;
    level.waypoints[39].children[1] = 40;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (286.924,550.995,-495.875);
    level.waypoints[40].type = "stand";
    level.waypoints[40].childCount = 2;
    level.waypoints[40].children[0] = 9;
    level.waypoints[40].children[1] = 39;
 
    level.waypointCount = level.waypoints.size;
 
}