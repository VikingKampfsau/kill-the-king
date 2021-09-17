// =========================================================================================
// File Name = 'mp_burck_waypoints.gsc'
// Map Name  = 'mp_burck'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_burck'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_burck/mp_burck_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_burck')
    {
        // thread btd_waypoints/mp_burck/mp_burck_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_burck/mp_burck_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_burck/mp_burck_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_burck/mp_burck_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_burck/mp_burck_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_burck/mp_burck_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-426.69,343.618,128.125);
    level.waypoints[0].childCount = 2;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 41;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (-475.16,141.856,128.125);
    level.waypoints[1].childCount = 2;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-379.757,-5.29721,128.125);
    level.waypoints[2].childCount = 2;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-453.706,-372.448,128.125);
    level.waypoints[3].childCount = 4;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[3].children[2] = 6;
    level.waypoints[3].children[3] = 19;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-238.678,-488.178,128.125);
    level.waypoints[4].childCount = 4;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[4].children[2] = 19;
    level.waypoints[4].children[3] = 6;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (-0.382494,-475.038,128.125);
    level.waypoints[5].childCount = 3;
    level.waypoints[5].children[0] = 4;
    level.waypoints[5].children[1] = 7;
    level.waypoints[5].children[2] = 8;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (-457.115,-662.436,128.125);
    level.waypoints[6].childCount = 3;
    level.waypoints[6].children[0] = 3;
    level.waypoints[6].children[1] = 7;
    level.waypoints[6].children[2] = 4;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (140.318,-648.308,128.125);
    level.waypoints[7].childCount = 4;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 5;
    level.waypoints[7].children[2] = 32;
    level.waypoints[7].children[3] = 18;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (-10.8667,-360.871,128.125);
    level.waypoints[8].childCount = 3;
    level.waypoints[8].children[0] = 5;
    level.waypoints[8].children[1] = 18;
    level.waypoints[8].children[2] = 19;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (200.818,-324.718,144.125);
    level.waypoints[9].childCount = 2;
    level.waypoints[9].children[0] = 10;
    level.waypoints[9].children[1] = 18;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (203.994,-155.408,124.125);
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 9;
    level.waypoints[10].children[1] = 11;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (203.868,-13.437,124.125);
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (204.788,319.653,124.125);
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 13;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (155.113,457.038,128.125);
    level.waypoints[13].childCount = 5;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[13].children[2] = 24;
    level.waypoints[13].children[3] = 25;
    level.waypoints[13].children[4] = 40;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (116.21,363.03,124.125);
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 15;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (116.244,120.164,124.125);
    level.waypoints[15].childCount = 2;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (116.217,-59.7714,124.125);
    level.waypoints[16].childCount = 2;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 17;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (116.3,-254.105,124.125);
    level.waypoints[17].childCount = 2;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 18;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (166.984,-377.099,128.125);
    level.waypoints[18].childCount = 6;
    level.waypoints[18].children[0] = 17;
    level.waypoints[18].children[1] = 9;
    level.waypoints[18].children[2] = 8;
    level.waypoints[18].children[3] = 30;
    level.waypoints[18].children[4] = 31;
    level.waypoints[18].children[5] = 7;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-194.999,-353.614,128.125);
    level.waypoints[19].childCount = 4;
    level.waypoints[19].children[0] = 8;
    level.waypoints[19].children[1] = 4;
    level.waypoints[19].children[2] = 3;
    level.waypoints[19].children[3] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-210.109,19.8446,0.124998);
    level.waypoints[20].childCount = 4;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 21;
    level.waypoints[20].children[2] = 24;
    level.waypoints[20].children[3] = 45;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (-289.094,29.2925,0.124998);
    level.waypoints[21].childCount = 3;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 22;
    level.waypoints[21].children[2] = 23;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (-287.163,-301.389,0.124998);
    level.waypoints[22].childCount = 1;
    level.waypoints[22].children[0] = 21;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (-297.361,337.878,0.124998);
    level.waypoints[23].childCount = 1;
    level.waypoints[23].children[0] = 21;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (-205.641,410.3,128.125);
    level.waypoints[24].childCount = 4;
    level.waypoints[24].children[0] = 20;
    level.waypoints[24].children[1] = 13;
    level.waypoints[24].children[2] = 41;
    level.waypoints[24].children[3] = 44;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (523.78,437.097,128.125);
    level.waypoints[25].childCount = 4;
    level.waypoints[25].children[0] = 13;
    level.waypoints[25].children[1] = 26;
    level.waypoints[25].children[2] = 36;
    level.waypoints[25].children[3] = 39;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (523.981,46.8749,0.124999);
    level.waypoints[26].childCount = 5;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 27;
    level.waypoints[26].children[2] = 30;
    level.waypoints[26].children[3] = 52;
    level.waypoints[26].children[4] = 49;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (611.154,35.5424,0.124999);
    level.waypoints[27].childCount = 3;
    level.waypoints[27].children[0] = 26;
    level.waypoints[27].children[1] = 28;
    level.waypoints[27].children[2] = 29;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (615.284,368.875,0.124999);
    level.waypoints[28].childCount = 1;
    level.waypoints[28].children[0] = 27;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (618.797,-301.757,0.124999);
    level.waypoints[29].childCount = 1;
    level.waypoints[29].children[0] = 27;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (528.675,-384.782,128.125);
    level.waypoints[30].childCount = 4;
    level.waypoints[30].children[0] = 26;
    level.waypoints[30].children[1] = 18;
    level.waypoints[30].children[2] = 33;
    level.waypoints[30].children[3] = 32;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (320.079,-476.394,128.125);
    level.waypoints[31].childCount = 2;
    level.waypoints[31].children[0] = 18;
    level.waypoints[31].children[1] = 32;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (468.259,-660.793,128.125);
    level.waypoints[32].childCount = 4;
    level.waypoints[32].children[0] = 31;
    level.waypoints[32].children[1] = 7;
    level.waypoints[32].children[2] = 33;
    level.waypoints[32].children[3] = 30;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (715.894,-606.441,128.125);
    level.waypoints[33].childCount = 3;
    level.waypoints[33].children[0] = 32;
    level.waypoints[33].children[1] = 30;
    level.waypoints[33].children[2] = 34;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (803.383,-340.783,128.125);
    level.waypoints[34].childCount = 2;
    level.waypoints[34].children[0] = 33;
    level.waypoints[34].children[1] = 35;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (730.723,124.648,128.125);
    level.waypoints[35].childCount = 2;
    level.waypoints[35].children[0] = 34;
    level.waypoints[35].children[1] = 36;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (776.422,446.72,128.125);
    level.waypoints[36].childCount = 3;
    level.waypoints[36].children[0] = 35;
    level.waypoints[36].children[1] = 25;
    level.waypoints[36].children[2] = 37;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (770.576,592.615,128.125);
    level.waypoints[37].childCount = 2;
    level.waypoints[37].children[0] = 36;
    level.waypoints[37].children[1] = 38;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (721.097,734.342,128.125);
    level.waypoints[38].childCount = 2;
    level.waypoints[38].children[0] = 37;
    level.waypoints[38].children[1] = 39;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (445.467,695.002,128.125);
    level.waypoints[39].childCount = 3;
    level.waypoints[39].children[0] = 38;
    level.waypoints[39].children[1] = 25;
    level.waypoints[39].children[2] = 40;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (280.642,714.045,128.125);
    level.waypoints[40].childCount = 3;
    level.waypoints[40].children[0] = 39;
    level.waypoints[40].children[1] = 13;
    level.waypoints[40].children[2] = 43;
    level.waypoints[41] = spawnstruct();
    level.waypoints[41].origin = (-437.583,474.303,128.125);
    level.waypoints[41].childCount = 3;
    level.waypoints[41].children[0] = 24;
    level.waypoints[41].children[1] = 0;
    level.waypoints[41].children[2] = 42;
    level.waypoints[42] = spawnstruct();
    level.waypoints[42].origin = (-363.624,711.201,128.125);
    level.waypoints[42].childCount = 2;
    level.waypoints[42].children[0] = 41;
    level.waypoints[42].children[1] = 43;
    level.waypoints[43] = spawnstruct();
    level.waypoints[43].origin = (-77.8626,729.389,128.125);
    level.waypoints[43].childCount = 3;
    level.waypoints[43].children[0] = 42;
    level.waypoints[43].children[1] = 40;
    level.waypoints[43].children[2] = 44;
    level.waypoints[44] = spawnstruct();
    level.waypoints[44].origin = (-161.69,512.586,128.125);
    level.waypoints[44].childCount = 2;
    level.waypoints[44].children[0] = 43;
    level.waypoints[44].children[1] = 24;
    level.waypoints[45] = spawnstruct();
    level.waypoints[45].origin = (-109.551,44.9233,0.125001);
    level.waypoints[45].childCount = 4;
    level.waypoints[45].children[0] = 20;
    level.waypoints[45].children[1] = 46;
    level.waypoints[45].children[2] = 53;
    level.waypoints[45].children[3] = 54;
    level.waypoints[46] = spawnstruct();
    level.waypoints[46].origin = (18.5804,271.158,0.125001);
    level.waypoints[46].childCount = 2;
    level.waypoints[46].children[0] = 45;
    level.waypoints[46].children[1] = 47;
    level.waypoints[47] = spawnstruct();
    level.waypoints[47].origin = (186.311,263.722,0.125001);
    level.waypoints[47].childCount = 3;
    level.waypoints[47].children[0] = 46;
    level.waypoints[47].children[1] = 48;
    level.waypoints[47].children[2] = 50;
    level.waypoints[48] = spawnstruct();
    level.waypoints[48].origin = (430.056,305.774,0.125001);
    level.waypoints[48].childCount = 2;
    level.waypoints[48].children[0] = 47;
    level.waypoints[48].children[1] = 49;
    level.waypoints[49] = spawnstruct();
    level.waypoints[49].origin = (405.057,165.498,0.125001);
    level.waypoints[49].childCount = 3;
    level.waypoints[49].children[0] = 48;
    level.waypoints[49].children[1] = 50;
    level.waypoints[49].children[2] = 26;
    level.waypoints[50] = spawnstruct();
    level.waypoints[50].origin = (222.642,117.024,0.125001);
    level.waypoints[50].childCount = 4;
    level.waypoints[50].children[0] = 49;
    level.waypoints[50].children[1] = 47;
    level.waypoints[50].children[2] = 51;
    level.waypoints[50].children[3] = 54;
    level.waypoints[51] = spawnstruct();
    level.waypoints[51].origin = (227.946,-173.664,0.125001);
    level.waypoints[51].childCount = 4;
    level.waypoints[51].children[0] = 50;
    level.waypoints[51].children[1] = 52;
    level.waypoints[51].children[2] = 53;
    level.waypoints[51].children[3] = 54;
    level.waypoints[52] = spawnstruct();
    level.waypoints[52].origin = (395.358,-151.604,0.125001);
    level.waypoints[52].childCount = 2;
    level.waypoints[52].children[0] = 51;
    level.waypoints[52].children[1] = 26;
    level.waypoints[53] = spawnstruct();
    level.waypoints[53].origin = (-104.486,-234.444,0.124999);
    level.waypoints[53].childCount = 3;
    level.waypoints[53].children[0] = 51;
    level.waypoints[53].children[1] = 45;
    level.waypoints[53].children[2] = 54;
    level.waypoints[54] = spawnstruct();
    level.waypoints[54].origin = (19.0652,-32.9247,0.124999);
    level.waypoints[54].childCount = 4;
    level.waypoints[54].children[0] = 50;
    level.waypoints[54].children[1] = 45;
    level.waypoints[54].children[2] = 51;
    level.waypoints[54].children[3] = 53;
 
    level.waypointCount = level.waypoints.size;
}