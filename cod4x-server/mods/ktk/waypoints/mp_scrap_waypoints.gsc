
// =========================================================================================
// File Name = 'mp_scrap_waypoints.gsc'
// Map Name  = 'mp_scrap'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_scrap'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_scrap/mp_scrap_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_scrap')
    {
        // thread btd_waypoints/mp_scrap/mp_scrap_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_scrap/mp_scrap_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_scrap/mp_scrap_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_scrap/mp_scrap_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_scrap/mp_scrap_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_scrap/mp_scrap_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-1095.26,-2803.24,-3.87503);
    level.waypoints[0].childCount = 2;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 21;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (-920.516,-2257.56,-3.87503);
    level.waypoints[1].childCount = 4;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[1].children[2] = 22;
    level.waypoints[1].children[3] = 32;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-1167.83,-1890.04,-3.87503);
    level.waypoints[2].childCount = 3;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[2].children[2] = 31;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-372.322,-1349.6,-3.8738);
    level.waypoints[3].childCount = 4;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[3].children[2] = 26;
    level.waypoints[3].children[3] = 32;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-272.243,-413.32,2.12149);
    level.waypoints[4].childCount = 3;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[4].children[2] = 27;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (1103.84,-177.153,0.177469);
    level.waypoints[5].childCount = 2;
    level.waypoints[5].children[0] = 4;
    level.waypoints[5].children[1] = 6;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (2536.98,-439.364,2.07244);
    level.waypoints[6].childCount = 2;
    level.waypoints[6].children[0] = 5;
    level.waypoints[6].children[1] = 7;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (1524.38,-601.263,-1.20891);
    level.waypoints[7].childCount = 3;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 8;
    level.waypoints[7].children[2] = 26;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (3178.37,-2395.22,-2.50199);
    level.waypoints[8].childCount = 2;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 9;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (3294.28,-3209.38,0.125001);
    level.waypoints[9].childCount = 2;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 10;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (2319.02,-3324.58,0.125001);
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 9;
    level.waypoints[10].children[1] = 11;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (1146.87,-3606.67,-3.07056);
    level.waypoints[11].childCount = 3;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 12;
    level.waypoints[11].children[2] = 24;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (816.018,-4023.3,-3.87501);
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 13;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (970.821,-4550.69,-3.81222);
    level.waypoints[13].childCount = 2;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (617.499,-5138.38,-3.875);
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 15;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (169.726,-4832.03,-3.875);
    level.waypoints[15].childCount = 2;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-102.789,-4164.89,-0.299724);
    level.waypoints[16].childCount = 2;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 17;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-847.059,-4186.56,48.125);
    level.waypoints[17].childCount = 2;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 18;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (-1028.65,-4034.12,48.125);
    level.waypoints[18].childCount = 2;
    level.waypoints[18].children[0] = 17;
    level.waypoints[18].children[1] = 19;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-1217.9,-3458.2,48.125);
    level.waypoints[19].childCount = 2;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-1555.34,-3503.32,48.125);
    level.waypoints[20].childCount = 2;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 21;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (-1461.34,-2622.9,-3.875);
    level.waypoints[21].childCount = 2;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 0;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (-430.873,-2576.85,-3.22472);
    level.waypoints[22].childCount = 2;
    level.waypoints[22].children[0] = 1;
    level.waypoints[22].children[1] = 23;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (-79.691,-3219.82,-3.16667);
    level.waypoints[23].childCount = 2;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 24;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (513.89,-3063.78,-0.329678);
    level.waypoints[24].childCount = 3;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 11;
    level.waypoints[24].children[2] = 25;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (379.294,-2411.12,0.124045);
    level.waypoints[25].childCount = 3;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 26;
    level.waypoints[25].children[2] = 33;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (778.555,-1773.02,-3.83067);
    level.waypoints[26].childCount = 3;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 7;
    level.waypoints[26].children[2] = 3;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-1300.56,-413.646,2.12466);
    level.waypoints[27].childCount = 2;
    level.waypoints[27].children[0] = 4;
    level.waypoints[27].children[1] = 28;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (-1353.04,-746.401,0.125);
    level.waypoints[28].childCount = 2;
    level.waypoints[28].children[0] = 27;
    level.waypoints[28].children[1] = 29;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (-1577.28,-763.748,0.125);
    level.waypoints[29].childCount = 2;
    level.waypoints[29].children[0] = 28;
    level.waypoints[29].children[1] = 30;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (-1573.64,-1645.31,-2.7958);
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 31;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (-1197.88,-1617.24,-3.87399);
    level.waypoints[31].childCount = 2;
    level.waypoints[31].children[0] = 30;
    level.waypoints[31].children[1] = 2;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (-455.118,-1784.17,-3.7121);
    level.waypoints[32].childCount = 3;
    level.waypoints[32].children[0] = 1;
    level.waypoints[32].children[1] = 3;
    level.waypoints[32].children[2] = 33;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (-257.159,-2140.51,-3.85256);
    level.waypoints[33].childCount = 2;
    level.waypoints[33].children[0] = 25;
    level.waypoints[33].children[1] = 32;
 
    level.waypointCount = level.waypoints.size;
}
