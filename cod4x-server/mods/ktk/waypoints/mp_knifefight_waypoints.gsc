// =========================================================================================
// File Name = 'mp_lgc_knifefight_waypoints.gsc'
// Map Name  = 'mp_lgc_knifefight'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_lgc_knifefight'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/mp_lgc_knifefight/mp_lgc_knifefight_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'mp_lgc_knifefight')
    {
        // thread btd_waypoints/mp_lgc_knifefight/mp_lgc_knifefight_waypoints::load_waypoints(); 
        // thread btd_waypoints/mp_lgc_knifefight/mp_lgc_knifefight_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/mp_lgc_knifefight/mp_lgc_knifefight_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/mp_lgc_knifefight/mp_lgc_knifefight_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/mp_lgc_knifefight/mp_lgc_knifefight_newpickups::load_newpickups(); 
        // thread btd_waypoints/mp_lgc_knifefight/mp_lgc_knifefight_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (81.1564,69.5665,0.125);
    level.waypoints[0].childCount = 3;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 2;
    level.waypoints[0].children[2] = 5;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (97.2031,473.158,0.125);
    level.waypoints[1].childCount = 4;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[1].children[2] = 3;
    level.waypoints[1].children[3] = 34;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (349.291,157.207,0.125);
    level.waypoints[2].childCount = 3;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 0;
    level.waypoints[2].children[2] = 33;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (103.473,782.373,0.125);
    level.waypoints[3].childCount = 3;
    level.waypoints[3].children[0] = 1;
    level.waypoints[3].children[1] = 4;
    level.waypoints[3].children[2] = 6;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (351.878,730.445,0.125);
    level.waypoints[4].childCount = 4;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[4].children[2] = 39;
    level.waypoints[4].children[3] = 34;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (343.6,427.352,0.125);
    level.waypoints[5].childCount = 2;
    level.waypoints[5].children[0] = 0;
    level.waypoints[5].children[1] = 4;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (89.5455,1107.73,0.125);
    level.waypoints[6].childCount = 5;
    level.waypoints[6].children[0] = 3;
    level.waypoints[6].children[1] = 7;
    level.waypoints[6].children[2] = 9;
    level.waypoints[6].children[3] = 39;
    level.waypoints[6].children[4] = 71;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (91.0672,1586.71,0.125);
    level.waypoints[7].childCount = 6;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 8;
    level.waypoints[7].children[2] = 9;
    level.waypoints[7].children[3] = 10;
    level.waypoints[7].children[4] = 11;
    level.waypoints[7].children[5] = 12;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (267.135,1302.36,0.125);
    level.waypoints[8].childCount = 4;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 9;
    level.waypoints[8].children[2] = 10;
    level.waypoints[8].children[3] = 38;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (97.9088,1361.21,0.125);
    level.waypoints[9].childCount = 3;
    level.waypoints[9].children[0] = 6;
    level.waypoints[9].children[1] = 7;
    level.waypoints[9].children[2] = 8;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (504.633,1620.21,0.125);
    level.waypoints[10].childCount = 6;
    level.waypoints[10].children[0] = 8;
    level.waypoints[10].children[1] = 7;
    level.waypoints[10].children[2] = 12;
    level.waypoints[10].children[3] = 14;
    level.waypoints[10].children[4] = 38;
    level.waypoints[10].children[5] = 40;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (82.8761,1971.2,0.125);
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 7;
    level.waypoints[11].children[1] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (390.308,1896.61,0.125);
    level.waypoints[12].childCount = 4;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 10;
    level.waypoints[12].children[2] = 7;
    level.waypoints[12].children[3] = 13;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (841.18,1885.24,0.125);
    level.waypoints[13].childCount = 3;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[13].children[2] = 15;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (889.251,1597.39,0.125);
    level.waypoints[14].childCount = 5;
    level.waypoints[14].children[0] = 10;
    level.waypoints[14].children[1] = 13;
    level.waypoints[14].children[2] = 15;
    level.waypoints[14].children[3] = 16;
    level.waypoints[14].children[4] = 37;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (1132.52,1903.11,0.125);
    level.waypoints[15].childCount = 4;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[15].children[2] = 13;
    level.waypoints[15].children[3] = 17;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (1294.42,1568.73,0.125);
    level.waypoints[16].childCount = 4;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 17;
    level.waypoints[16].children[2] = 14;
    level.waypoints[16].children[3] = 18;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (1460.95,1888.76,0.125);
    level.waypoints[17].childCount = 3;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 15;
    level.waypoints[17].children[2] = 19;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (1637.8,1590.24,0.125);
    level.waypoints[18].childCount = 3;
    level.waypoints[18].children[0] = 16;
    level.waypoints[18].children[1] = 19;
    level.waypoints[18].children[2] = 20;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (1877.31,1873.04,0.125);
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 17;
    level.waypoints[19].children[2] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (1972.56,1712.75,0.125);
    level.waypoints[20].childCount = 4;
    level.waypoints[20].children[0] = 19;
    level.waypoints[20].children[1] = 18;
    level.waypoints[20].children[2] = 21;
    level.waypoints[20].children[3] = 22;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (1753.75,1331.79,0.125);
    level.waypoints[21].childCount = 3;
    level.waypoints[21].children[0] = 20;
    level.waypoints[21].children[1] = 22;
    level.waypoints[21].children[2] = 41;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (1974.47,1199.97,0.125);
    level.waypoints[22].childCount = 3;
    level.waypoints[22].children[0] = 20;
    level.waypoints[22].children[1] = 21;
    level.waypoints[22].children[2] = 23;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (1963.15,932.807,0.125);
    level.waypoints[23].childCount = 4;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 24;
    level.waypoints[23].children[2] = 42;
    level.waypoints[23].children[3] = 44;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (1947.24,499.609,0.125);
    level.waypoints[24].childCount = 3;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 25;
    level.waypoints[24].children[2] = 27;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (1969.82,87.11,0.125);
    level.waypoints[25].childCount = 3;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 26;
    level.waypoints[25].children[2] = 28;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (1705.54,434.99,0.125);
    level.waypoints[26].childCount = 4;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 27;
    level.waypoints[26].children[2] = 28;
    level.waypoints[26].children[3] = 31;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (1642.99,659.56,0.125);
    level.waypoints[27].childCount = 4;
    level.waypoints[27].children[0] = 24;
    level.waypoints[27].children[1] = 26;
    level.waypoints[27].children[2] = 32;
    level.waypoints[27].children[3] = 31;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (1500.37,158.761,0.125);
    level.waypoints[28].childCount = 4;
    level.waypoints[28].children[0] = 26;
    level.waypoints[28].children[1] = 25;
    level.waypoints[28].children[2] = 29;
    level.waypoints[28].children[3] = 31;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (1137.01,143.027,0.125);
    level.waypoints[29].childCount = 4;
    level.waypoints[29].children[0] = 28;
    level.waypoints[29].children[1] = 30;
    level.waypoints[29].children[2] = 31;
    level.waypoints[29].children[3] = 33;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (966.116,456.795,0.125);
    level.waypoints[30].childCount = 6;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 31;
    level.waypoints[30].children[2] = 32;
    level.waypoints[30].children[3] = 33;
    level.waypoints[30].children[4] = 34;
    level.waypoints[30].children[5] = 36;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (1271.45,433.098,0.125);
    level.waypoints[31].childCount = 5;
    level.waypoints[31].children[0] = 30;
    level.waypoints[31].children[1] = 29;
    level.waypoints[31].children[2] = 28;
    level.waypoints[31].children[3] = 26;
    level.waypoints[31].children[4] = 27;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (1263.71,799.281,0.12491);
    level.waypoints[32].childCount = 6;
    level.waypoints[32].children[0] = 30;
    level.waypoints[32].children[1] = 27;
    level.waypoints[32].children[2] = 36;
    level.waypoints[32].children[3] = 37;
    level.waypoints[32].children[4] = 42;
    level.waypoints[32].children[5] = 34;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (682.637,137.172,0.12491);
    level.waypoints[33].childCount = 4;
    level.waypoints[33].children[0] = 30;
    level.waypoints[33].children[1] = 29;
    level.waypoints[33].children[2] = 2;
    level.waypoints[33].children[3] = 34;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (600.26,458.707,0.12491);
    level.waypoints[34].childCount = 6;
    level.waypoints[34].children[0] = 33;
    level.waypoints[34].children[1] = 1;
    level.waypoints[34].children[2] = 30;
    level.waypoints[34].children[3] = 35;
    level.waypoints[34].children[4] = 4;
    level.waypoints[34].children[5] = 32;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (568.167,800.234,0.12491);
    level.waypoints[35].childCount = 3;
    level.waypoints[35].children[0] = 34;
    level.waypoints[35].children[1] = 36;
    level.waypoints[35].children[2] = 39;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (796.28,903.261,0.12491);
    level.waypoints[36].childCount = 4;
    level.waypoints[36].children[0] = 35;
    level.waypoints[36].children[1] = 30;
    level.waypoints[36].children[2] = 32;
    level.waypoints[36].children[3] = 37;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (949.597,1264.46,0.12491);
    level.waypoints[37].childCount = 6;
    level.waypoints[37].children[0] = 32;
    level.waypoints[37].children[1] = 36;
    level.waypoints[37].children[2] = 38;
    level.waypoints[37].children[3] = 14;
    level.waypoints[37].children[4] = 40;
    level.waypoints[37].children[5] = 41;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (518.346,1242.15,0.12491);
    level.waypoints[38].childCount = 4;
    level.waypoints[38].children[0] = 37;
    level.waypoints[38].children[1] = 39;
    level.waypoints[38].children[2] = 8;
    level.waypoints[38].children[3] = 10;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (387.763,1020.09,0.12491);
    level.waypoints[39].childCount = 5;
    level.waypoints[39].children[0] = 35;
    level.waypoints[39].children[1] = 4;
    level.waypoints[39].children[2] = 6;
    level.waypoints[39].children[3] = 38;
    level.waypoints[39].children[4] = 71;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (683.251,1484.94,0.12491);
    level.waypoints[40].childCount = 2;
    level.waypoints[40].children[0] = 37;
    level.waypoints[40].children[1] = 10;
    level.waypoints[41] = spawnstruct();
    level.waypoints[41].origin = (1366.48,1338.71,0.12491);
    level.waypoints[41].childCount = 3;
    level.waypoints[41].children[0] = 37;
    level.waypoints[41].children[1] = 21;
    level.waypoints[41].children[2] = 42;
    level.waypoints[42] = spawnstruct();
    level.waypoints[42].origin = (1623.39,1035.56,0.12491);
    level.waypoints[42].childCount = 4;
    level.waypoints[42].children[0] = 41;
    level.waypoints[42].children[1] = 32;
    level.waypoints[42].children[2] = 23;
    level.waypoints[42].children[3] = 44;
    level.waypoints[43] = spawnstruct();
    level.waypoints[43].origin = (1730.11,294.264,320.125);
    level.waypoints[43].childCount = 3;
    level.waypoints[43].children[0] = 44;
    level.waypoints[43].children[1] = 45;
    level.waypoints[43].children[2] = 47;
    level.waypoints[44] = spawnstruct();
    level.waypoints[44].origin = (1769.7,799.03,64.3133);
    level.waypoints[44].childCount = 3;
    level.waypoints[44].children[0] = 43;
    level.waypoints[44].children[1] = 23;
    level.waypoints[44].children[2] = 42;
    level.waypoints[45] = spawnstruct();
    level.waypoints[45].origin = (1471.7,145.996,320.125);
    level.waypoints[45].childCount = 3;
    level.waypoints[45].children[0] = 43;
    level.waypoints[45].children[1] = 46;
    level.waypoints[45].children[2] = 48;
    level.waypoints[46] = spawnstruct();
    level.waypoints[46].origin = (1939.69,72.0074,320.125);
    level.waypoints[46].childCount = 2;
    level.waypoints[46].children[0] = 45;
    level.waypoints[46].children[1] = 47;
    level.waypoints[47] = spawnstruct();
    level.waypoints[47].origin = (1962.97,255.97,320.125);
    level.waypoints[47].childCount = 2;
    level.waypoints[47].children[0] = 46;
    level.waypoints[47].children[1] = 43;
    level.waypoints[48] = spawnstruct();
    level.waypoints[48].origin = (1093.56,74.3,320.125);
    level.waypoints[48].childCount = 2;
    level.waypoints[48].children[0] = 45;
    level.waypoints[48].children[1] = 49;
    level.waypoints[49] = spawnstruct();
    level.waypoints[49].origin = (759.103,222.151,320.125);
    level.waypoints[49].childCount = 4;
    level.waypoints[49].children[0] = 48;
    level.waypoints[49].children[1] = 50;
    level.waypoints[49].children[2] = 51;
    level.waypoints[49].children[3] = 52;
    level.waypoints[50] = spawnstruct();
    level.waypoints[50].origin = (377.475,282.492,320.125);
    level.waypoints[50].childCount = 2;
    level.waypoints[50].children[0] = 49;
    level.waypoints[50].children[1] = 51;
    level.waypoints[51] = spawnstruct();
    level.waypoints[51].origin = (279.242,132.133,320.125);
    level.waypoints[51].childCount = 2;
    level.waypoints[51].children[0] = 50;
    level.waypoints[51].children[1] = 49;
    level.waypoints[52] = spawnstruct();
    level.waypoints[52].origin = (717.684,857.38,567.225);
    level.waypoints[52].childCount = 3;
    level.waypoints[52].children[0] = 49;
    level.waypoints[52].children[1] = 53;
    level.waypoints[52].children[2] = 56;
    level.waypoints[53] = spawnstruct();
    level.waypoints[53].origin = (637.201,1092.41,564.125);
    level.waypoints[53].childCount = 4;
    level.waypoints[53].children[0] = 52;
    level.waypoints[53].children[1] = 54;
    level.waypoints[53].children[2] = 56;
    level.waypoints[53].children[3] = 57;
    level.waypoints[54] = spawnstruct();
    level.waypoints[54].origin = (276.626,1121.17,564.125);
    level.waypoints[54].childCount = 2;
    level.waypoints[54].children[0] = 53;
    level.waypoints[54].children[1] = 55;
    level.waypoints[55] = spawnstruct();
    level.waypoints[55].origin = (164.667,932.148,564.125);
    level.waypoints[55].childCount = 2;
    level.waypoints[55].children[0] = 54;
    level.waypoints[55].children[1] = 56;
    level.waypoints[56] = spawnstruct();
    level.waypoints[56].origin = (545.067,949.924,564.125);
    level.waypoints[56].childCount = 3;
    level.waypoints[56].children[0] = 55;
    level.waypoints[56].children[1] = 53;
    level.waypoints[56].children[2] = 52;
    level.waypoints[57] = spawnstruct();
    level.waypoints[57].origin = (973.144,1086.95,564.125);
    level.waypoints[57].childCount = 3;
    level.waypoints[57].children[0] = 53;
    level.waypoints[57].children[1] = 58;
    level.waypoints[57].children[2] = 62;
    level.waypoints[58] = spawnstruct();
    level.waypoints[58].origin = (1003.09,921.659,564.125);
    level.waypoints[58].childCount = 2;
    level.waypoints[58].children[0] = 57;
    level.waypoints[58].children[1] = 59;
    level.waypoints[59] = spawnstruct();
    level.waypoints[59].origin = (1350.73,912.729,564.125);
    level.waypoints[59].childCount = 4;
    level.waypoints[59].children[0] = 60;
    level.waypoints[59].children[1] = 63;
    level.waypoints[59].children[2] = 62;
    level.waypoints[59].children[3] = 58;
    level.waypoints[60] = spawnstruct();
    level.waypoints[60].origin = (1932.32,919.32,564.125);
    level.waypoints[60].childCount = 2;
    level.waypoints[60].children[0] = 59;
    level.waypoints[60].children[1] = 61;
    level.waypoints[61] = spawnstruct();
    level.waypoints[61].origin = (1927.05,1116.87,564.125);
    level.waypoints[61].childCount = 2;
    level.waypoints[61].children[0] = 60;
    level.waypoints[61].children[1] = 62;
    level.waypoints[62] = spawnstruct();
    level.waypoints[62].origin = (1444.9,1111.48,564.125);
    level.waypoints[62].childCount = 4;
    level.waypoints[62].children[0] = 61;
    level.waypoints[62].children[1] = 63;
    level.waypoints[62].children[2] = 59;
    level.waypoints[62].children[3] = 57;
    level.waypoints[63] = spawnstruct();
    level.waypoints[63].origin = (1303.66,1164.93,577.598);
    level.waypoints[63].childCount = 3;
    level.waypoints[63].children[0] = 59;
    level.waypoints[63].children[1] = 62;
    level.waypoints[63].children[2] = 64;
    level.waypoints[64] = spawnstruct();
    level.waypoints[64].origin = (1302.42,1841.5,320.125);
    level.waypoints[64].childCount = 4;
    level.waypoints[64].children[0] = 63;
    level.waypoints[64].children[1] = 65;
    level.waypoints[64].children[2] = 66;
    level.waypoints[64].children[3] = 67;
    level.waypoints[65] = spawnstruct();
    level.waypoints[65].origin = (1915.57,1759.43,320.125);
    level.waypoints[65].childCount = 2;
    level.waypoints[65].children[0] = 64;
    level.waypoints[65].children[1] = 66;
    level.waypoints[66] = spawnstruct();
    level.waypoints[66].origin = (1978.93,1955.32,320.125);
    level.waypoints[66].childCount = 2;
    level.waypoints[66].children[0] = 65;
    level.waypoints[66].children[1] = 64;
    level.waypoints[67] = spawnstruct();
    level.waypoints[67].origin = (1000.05,1959.6,320.125);
    level.waypoints[67].childCount = 2;
    level.waypoints[67].children[0] = 64;
    level.waypoints[67].children[1] = 68;
    level.waypoints[68] = spawnstruct();
    level.waypoints[68].origin = (794.927,1970.38,320.125);
    level.waypoints[68].childCount = 3;
    level.waypoints[68].children[0] = 69;
    level.waypoints[68].children[1] = 67;
    level.waypoints[68].children[2] = 73;
    level.waypoints[69] = spawnstruct();
    level.waypoints[69].origin = (666.062,1788.79,320.125);
    level.waypoints[69].childCount = 2;
    level.waypoints[69].children[0] = 68;
    level.waypoints[69].children[1] = 70;
    level.waypoints[70] = spawnstruct();
    level.waypoints[70].origin = (375.684,1796.23,320.125);
    level.waypoints[70].childCount = 3;
    level.waypoints[70].children[0] = 72;
    level.waypoints[70].children[1] = 69;
    level.waypoints[70].children[2] = 73;
    level.waypoints[71] = spawnstruct();
    level.waypoints[71].origin = (257.846,1281.4,81.5708);
    level.waypoints[71].childCount = 3;
    level.waypoints[71].children[0] = 6;
    level.waypoints[71].children[1] = 39;
    level.waypoints[71].children[2] = 72;
    level.waypoints[72] = spawnstruct();
    level.waypoints[72].origin = (279.951,1768.67,320.125);
    level.waypoints[72].childCount = 2;
    level.waypoints[72].children[0] = 71;
    level.waypoints[72].children[1] = 70;
    level.waypoints[73] = spawnstruct();
    level.waypoints[73].origin = (378.883,1935.7,320.125);
    level.waypoints[73].childCount = 2;
    level.waypoints[73].children[0] = 68;
    level.waypoints[73].children[1] = 70;
 
    level.waypointCount = level.waypoints.size;
}