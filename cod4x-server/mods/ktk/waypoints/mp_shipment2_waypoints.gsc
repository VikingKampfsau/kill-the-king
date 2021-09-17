
// =========================================================================================
// File Name = 'mp_shipment2_waypoints.gsc'
// Map Name  = 'mp_shipment2'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_shipment2'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_shipment2/mp_shipment2_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_shipment2')
    {
        // thread btd_waypoints/mp_shipment2/mp_shipment2_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_shipment2/mp_shipment2_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_shipment2/mp_shipment2_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_shipment2/mp_shipment2_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_shipment2/mp_shipment2_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_shipment2/mp_shipment2_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (874.324,-768.881,11.8839);
    level.waypoints[0].childCount = 3;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 28;
    level.waypoints[0].children[2] = 43;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (942.004,-512.441,17.1258);
    level.waypoints[1].childCount = 3;
    level.waypoints[1].children[0] = 2;
    level.waypoints[1].children[1] = 27;
    level.waypoints[1].children[2] = 0;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (883.774,288.906,-0.960586);
    level.waypoints[2].childCount = 2;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (786.181,401.266,-1.23554);
    level.waypoints[3].childCount = 3;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[3].children[2] = 46;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (778.021,644.412,11.4838);
    level.waypoints[4].childCount = 4;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[4].children[2] = 34;
    level.waypoints[4].children[3] = 40;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (770.414,1036.92,13.0437);
    level.waypoints[5].childCount = 3;
    level.waypoints[5].children[0] = 4;
    level.waypoints[5].children[1] = 6;
    level.waypoints[5].children[2] = 24;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (287.975,1220.99,-0.0564313);
    level.waypoints[6].childCount = 2;
    level.waypoints[6].children[0] = 5;
    level.waypoints[6].children[1] = 7;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (8.48772,1180.73,-1.86032);
    level.waypoints[7].childCount = 5;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 8;
    level.waypoints[7].children[2] = 11;
    level.waypoints[7].children[3] = 40;
    level.waypoints[7].children[4] = 45;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (-291.168,1209.06,-1.69682);
    level.waypoints[8].childCount = 2;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 9;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (-686.379,1141.16,2.75863);
    level.waypoints[9].childCount = 3;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 10;
    level.waypoints[9].children[2] = 44;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (-896.391,801.819,6.80811);
    level.waypoints[10].childCount = 4;
    level.waypoints[10].children[0] = 9;
    level.waypoints[10].children[1] = 11;
    level.waypoints[10].children[2] = 12;
    level.waypoints[10].children[3] = 44;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (-763.214,653.569,-0.772564);
    level.waypoints[11].childCount = 4;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 12;
    level.waypoints[11].children[2] = 22;
    level.waypoints[11].children[3] = 7;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (-860.157,323.001,-3.65493);
    level.waypoints[12].childCount = 4;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 13;
    level.waypoints[12].children[2] = 21;
    level.waypoints[12].children[3] = 10;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (-930.773,-183.579,-3.48367);
    level.waypoints[13].childCount = 3;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[13].children[2] = 19;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (-813.148,-496.301,-3.87371);
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 15;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (-667.845,-600.214,1.30633);
    level.waypoints[15].childCount = 5;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[15].children[2] = 29;
    level.waypoints[15].children[3] = 30;
    level.waypoints[15].children[4] = 18;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-748.822,-1021.3,-1.33165);
    level.waypoints[16].childCount = 3;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 17;
    level.waypoints[16].children[2] = 42;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-886.396,-891.821,-2.56727);
    level.waypoints[17].childCount = 2;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 18;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (-464.031,-634.236,-3.87858);
    level.waypoints[18].childCount = 4;
    level.waypoints[18].children[0] = 17;
    level.waypoints[18].children[1] = 19;
    level.waypoints[18].children[2] = 27;
    level.waypoints[18].children[3] = 15;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-455.693,-274.636,-3.54227);
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 20;
    level.waypoints[19].children[2] = 13;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-426.819,21.3155,-3.64543);
    level.waypoints[20].childCount = 3;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 21;
    level.waypoints[20].children[2] = 26;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (-474.319,326.355,-3.07151);
    level.waypoints[21].childCount = 3;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 12;
    level.waypoints[21].children[2] = 22;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (-359.978,665.357,-2.78638);
    level.waypoints[22].childCount = 5;
    level.waypoints[22].children[0] = 21;
    level.waypoints[22].children[1] = 11;
    level.waypoints[22].children[2] = 23;
    level.waypoints[22].children[3] = 33;
    level.waypoints[22].children[4] = 44;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (16.8073,580.691,-3.16912);
    level.waypoints[23].childCount = 3;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 24;
    level.waypoints[23].children[2] = 26;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (466.193,591.971,-3.06955);
    level.waypoints[24].childCount = 5;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 25;
    level.waypoints[24].children[2] = 34;
    level.waypoints[24].children[3] = 41;
    level.waypoints[24].children[4] = 5;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (458.278,22.3041,-2.98085);
    level.waypoints[25].childCount = 5;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 26;
    level.waypoints[25].children[2] = 39;
    level.waypoints[25].children[3] = 46;
    level.waypoints[25].children[4] = 43;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (17.7527,14.6568,-3.85619);
    level.waypoints[26].childCount = 4;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 23;
    level.waypoints[26].children[2] = 20;
    level.waypoints[26].children[3] = 27;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-3.5419,-572.849,-3.37011);
    level.waypoints[27].childCount = 4;
    level.waypoints[27].children[0] = 26;
    level.waypoints[27].children[1] = 18;
    level.waypoints[27].children[2] = 1;
    level.waypoints[27].children[3] = 39;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (224.912,-1073.74,-1.43001);
    level.waypoints[28].childCount = 4;
    level.waypoints[28].children[0] = 0;
    level.waypoints[28].children[1] = 29;
    level.waypoints[28].children[2] = 39;
    level.waypoints[28].children[3] = 42;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (-113.601,-1035.43,-1.40391);
    level.waypoints[29].childCount = 2;
    level.waypoints[29].children[0] = 28;
    level.waypoints[29].children[1] = 15;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (-689.402,-76.8833,120.125);
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 15;
    level.waypoints[30].children[1] = 31;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (-691.735,111.628,120.125);
    level.waypoints[31].childCount = 2;
    level.waypoints[31].children[0] = 30;
    level.waypoints[31].children[1] = 32;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (-152.499,171.828,120.125);
    level.waypoints[32].childCount = 2;
    level.waypoints[32].children[0] = 31;
    level.waypoints[32].children[1] = 33;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (-279.178,438.777,120.125);
    level.waypoints[33].childCount = 2;
    level.waypoints[33].children[0] = 32;
    level.waypoints[33].children[1] = 22;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (655.636,634.905,0.373482);
    level.waypoints[34].childCount = 3;
    level.waypoints[34].children[0] = 24;
    level.waypoints[34].children[1] = 35;
    level.waypoints[34].children[2] = 4;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (653.291,95.0782,124.125);
    level.waypoints[35].childCount = 2;
    level.waypoints[35].children[0] = 34;
    level.waypoints[35].children[1] = 36;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (618.096,-91.9471,120.125);
    level.waypoints[36].childCount = 2;
    level.waypoints[36].children[0] = 35;
    level.waypoints[36].children[1] = 37;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (128.472,-216.517,120.125);
    level.waypoints[37].childCount = 2;
    level.waypoints[37].children[0] = 36;
    level.waypoints[37].children[1] = 38;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (258.515,-367.215,143.345);
    level.waypoints[38].childCount = 2;
    level.waypoints[38].children[0] = 37;
    level.waypoints[38].children[1] = 39;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (464.698,-628.95,5.68401);
    level.waypoints[39].childCount = 5;
    level.waypoints[39].children[0] = 38;
    level.waypoints[39].children[1] = 25;
    level.waypoints[39].children[2] = 27;
    level.waypoints[39].children[3] = 28;
    level.waypoints[39].children[4] = 43;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (268.281,964.328,-1.68696);
    level.waypoints[40].childCount = 3;
    level.waypoints[40].children[0] = 7;
    level.waypoints[40].children[1] = 41;
    level.waypoints[40].children[2] = 4;
    level.waypoints[41] = spawnstruct();
    level.waypoints[41].origin = (304.024,738.085,-0.467896);
    level.waypoints[41].childCount = 2;
    level.waypoints[41].children[0] = 40;
    level.waypoints[41].children[1] = 24;
    level.waypoints[42] = spawnstruct();
    level.waypoints[42].origin = (-184.89,-1142.14,-1.62528);
    level.waypoints[42].childCount = 2;
    level.waypoints[42].children[0] = 16;
    level.waypoints[42].children[1] = 28;
    level.waypoints[43] = spawnstruct();
    level.waypoints[43].origin = (598.823,-732.747,2.83558);
    level.waypoints[43].childCount = 3;
    level.waypoints[43].children[0] = 0;
    level.waypoints[43].children[1] = 39;
    level.waypoints[43].children[2] = 25;
    level.waypoints[44] = spawnstruct();
    level.waypoints[44].origin = (-714.341,941.571,2.06911);
    level.waypoints[44].childCount = 4;
    level.waypoints[44].children[0] = 22;
    level.waypoints[44].children[1] = 10;
    level.waypoints[44].children[2] = 9;
    level.waypoints[44].children[3] = 45;
    level.waypoints[45] = spawnstruct();
    level.waypoints[45].origin = (-581.735,1019.24,8.125);
    level.waypoints[45].childCount = 2;
    level.waypoints[45].children[0] = 44;
    level.waypoints[45].children[1] = 7;
    level.waypoints[46] = spawnstruct();
    level.waypoints[46].origin = (466.542,217.612,-2.40287);
    level.waypoints[46].childCount = 2;
    level.waypoints[46].children[0] = 3;
    level.waypoints[46].children[1] = 25;
 
    level.waypointCount = level.waypoints.size;
}
