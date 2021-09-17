// =========================================================================================
// File Name = 'lolzor2_waypoints.gsc'
// Map Name  = 'lolzor2'
// =========================================================================================
// 
// This is an auto generated script file created by the BTD Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'lolzor2'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - waypoint.iwd/lolzor2/lolzor2_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
// 
// Uncomment the correct line once you have created and added the scripts (remove the // )
// 
/*
 
    else if(mapname == 'lolzor2')
    {
        // thread btd_waypoints/lolzor2/lolzor2_waypoints::load_waypoints(); 
        // thread btd_waypoints/lolzor2/lolzor2_zomspawns::load_zomspawns(); 
        // thread btd_waypoints/lolzor2/lolzor2_tradespawns::load_tradespawns(); 
		// thread btd_waypoints/lolzor2/lolzor2_chopperdrops::load_chopperdrops(); 
		// thread btd_waypoints/lolzor2/lolzor2_newpickups::load_newpickups(); 
        // thread btd_waypoints/lolzor2/lolzor2_anticamp::load_anticamp(); 
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints = [];
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-938.008,-186.292,248.125);
    level.waypoints[0].childCount = 2;
    level.waypoints[0].children[0] = 1;
    level.waypoints[0].children[1] = 9;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (-724.541,-141.836,248.125);
    level.waypoints[1].childCount = 3;
    level.waypoints[1].children[0] = 0;
    level.waypoints[1].children[1] = 2;
    level.waypoints[1].children[2] = 8;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-734.109,232.911,248.125);
    level.waypoints[2].childCount = 2;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 3;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-463.811,251.779,248.125);
    level.waypoints[3].childCount = 2;
    level.waypoints[3].children[0] = 2;
    level.waypoints[3].children[1] = 4;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-203.656,265.87,248.125);
    level.waypoints[4].childCount = 2;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 5;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (-203.602,5.03154,248.125);
    level.waypoints[5].childCount = 2;
    level.waypoints[5].children[0] = 4;
    level.waypoints[5].children[1] = 6;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (-201.135,-253.191,248.125);
    level.waypoints[6].childCount = 2;
    level.waypoints[6].children[0] = 5;
    level.waypoints[6].children[1] = 7;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (-593.728,-279.849,248.125);
    level.waypoints[7].childCount = 2;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 8;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (-721.132,-277.577,248.125);
    level.waypoints[8].childCount = 2;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 1;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (-944.417,-434.908,160.125);
    level.waypoints[9].childCount = 2;
    level.waypoints[9].children[0] = 0;
    level.waypoints[9].children[1] = 10;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (-845.673,-433.475,160.125);
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 9;
    level.waypoints[10].children[1] = 11;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (-450.621,-431.671,0.125);
    level.waypoints[11].childCount = 2;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (-446.4,-117.916,0.125);
    level.waypoints[12].childCount = 4;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 13;
    level.waypoints[12].children[2] = 19;
    level.waypoints[12].children[3] = 20;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (-580.158,-125.464,0.125);
    level.waypoints[13].childCount = 3;
    level.waypoints[13].children[0] = 12;
    level.waypoints[13].children[1] = 14;
    level.waypoints[13].children[2] = 20;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (-584.661,-19.4997,0.125);
    level.waypoints[14].childCount = 4;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 15;
    level.waypoints[14].children[2] = 20;
    level.waypoints[14].children[3] = 21;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (-589.256,134.652,0.124999);
    level.waypoints[15].childCount = 3;
    level.waypoints[15].children[0] = 14;
    level.waypoints[15].children[1] = 16;
    level.waypoints[15].children[2] = 20;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-474.978,134.672,0.124999);
    level.waypoints[16].childCount = 4;
    level.waypoints[16].children[0] = 15;
    level.waypoints[16].children[1] = 17;
    level.waypoints[16].children[2] = 20;
    level.waypoints[16].children[3] = 25;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-331.363,135.498,0.124999);
    level.waypoints[17].childCount = 3;
    level.waypoints[17].children[0] = 16;
    level.waypoints[17].children[1] = 18;
    level.waypoints[17].children[2] = 20;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (-326.924,15.9112,0.124999);
    level.waypoints[18].childCount = 4;
    level.waypoints[18].children[0] = 17;
    level.waypoints[18].children[1] = 19;
    level.waypoints[18].children[2] = 20;
    level.waypoints[18].children[3] = 28;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-333.919,-115.261,0.124999);
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 18;
    level.waypoints[19].children[1] = 12;
    level.waypoints[19].children[2] = 20;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-460.81,-10.6695,0.124999);
    level.waypoints[20].childCount = 8;
    level.waypoints[20].children[0] = 12;
    level.waypoints[20].children[1] = 16;
    level.waypoints[20].children[2] = 13;
    level.waypoints[20].children[3] = 14;
    level.waypoints[20].children[4] = 19;
    level.waypoints[20].children[5] = 18;
    level.waypoints[20].children[6] = 15;
    level.waypoints[20].children[7] = 17;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (-913.467,-12.1862,0.124999);
    level.waypoints[21].childCount = 2;
    level.waypoints[21].children[0] = 14;
    level.waypoints[21].children[1] = 26;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (-466.195,462.499,0.124999);
    level.waypoints[22].childCount = 4;
    level.waypoints[22].children[0] = 23;
    level.waypoints[22].children[1] = 25;
    level.waypoints[22].children[2] = 24;
    level.waypoints[22].children[3] = 27;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (-473.287,558.83,0.124999);
    level.waypoints[23].childCount = 3;
    level.waypoints[23].children[0] = 22;
    level.waypoints[23].children[1] = 24;
    level.waypoints[23].children[2] = 27;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (-337.337,459.319,0.124999);
    level.waypoints[24].childCount = 3;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 25;
    level.waypoints[24].children[2] = 22;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (-467.028,366.014,0.124999);
    level.waypoints[25].childCount = 4;
    level.waypoints[25].children[0] = 24;
    level.waypoints[25].children[1] = 22;
    level.waypoints[25].children[2] = 16;
    level.waypoints[25].children[3] = 27;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (-915.077,464.591,0.124999);
    level.waypoints[26].childCount = 2;
    level.waypoints[26].children[0] = 21;
    level.waypoints[26].children[1] = 27;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-597.602,463.406,0.124999);
    level.waypoints[27].childCount = 4;
    level.waypoints[27].children[0] = 26;
    level.waypoints[27].children[1] = 22;
    level.waypoints[27].children[2] = 25;
    level.waypoints[27].children[3] = 23;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (-44.1584,1.30152,0.125001);
    level.waypoints[28].childCount = 3;
    level.waypoints[28].children[0] = 18;
    level.waypoints[28].children[1] = 29;
    level.waypoints[28].children[2] = 31;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (-3.00391,-61.8237,0.125001);
    level.waypoints[29].childCount = 3;
    level.waypoints[29].children[0] = 28;
    level.waypoints[29].children[1] = 30;
    level.waypoints[29].children[2] = 93;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (57.3419,-1.30068,0.125001);
    level.waypoints[30].childCount = 3;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 31;
    level.waypoints[30].children[2] = 63;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (-9.76306,58.2251,0.125001);
    level.waypoints[31].childCount = 3;
    level.waypoints[31].children[0] = 30;
    level.waypoints[31].children[1] = 28;
    level.waypoints[31].children[2] = 32;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (-5.13246,258.544,0.125001);
    level.waypoints[32].childCount = 2;
    level.waypoints[32].children[0] = 31;
    level.waypoints[32].children[1] = 33;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (4.36962,517.392,0.125001);
    level.waypoints[33].childCount = 2;
    level.waypoints[33].children[0] = 32;
    level.waypoints[33].children[1] = 34;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (4.79351,800.901,0.125001);
    level.waypoints[34].childCount = 4;
    level.waypoints[34].children[0] = 33;
    level.waypoints[34].children[1] = 35;
    level.waypoints[34].children[2] = 41;
    level.waypoints[34].children[3] = 42;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (-128.925,800.045,0.125001);
    level.waypoints[35].childCount = 3;
    level.waypoints[35].children[0] = 34;
    level.waypoints[35].children[1] = 36;
    level.waypoints[35].children[2] = 42;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (-129.13,925.288,0.125001);
    level.waypoints[36].childCount = 4;
    level.waypoints[36].children[0] = 35;
    level.waypoints[36].children[1] = 37;
    level.waypoints[36].children[2] = 42;
    level.waypoints[36].children[3] = 50;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (-144.875,1038.85,0.125001);
    level.waypoints[37].childCount = 3;
    level.waypoints[37].children[0] = 36;
    level.waypoints[37].children[1] = 38;
    level.waypoints[37].children[2] = 42;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (-13.9233,1049.39,0.125001);
    level.waypoints[38].childCount = 4;
    level.waypoints[38].children[0] = 37;
    level.waypoints[38].children[1] = 39;
    level.waypoints[38].children[2] = 42;
    level.waypoints[38].children[3] = 43;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (136.875,1072.87,0.125001);
    level.waypoints[39].childCount = 3;
    level.waypoints[39].children[0] = 38;
    level.waypoints[39].children[1] = 40;
    level.waypoints[39].children[2] = 42;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (136.761,950.527,0.125001);
    level.waypoints[40].childCount = 4;
    level.waypoints[40].children[0] = 39;
    level.waypoints[40].children[1] = 41;
    level.waypoints[40].children[2] = 42;
    level.waypoints[40].children[3] = 48;
    level.waypoints[41] = spawnstruct();
    level.waypoints[41].origin = (132.481,810.807,0.125001);
    level.waypoints[41].childCount = 3;
    level.waypoints[41].children[0] = 40;
    level.waypoints[41].children[1] = 34;
    level.waypoints[41].children[2] = 42;
    level.waypoints[42] = spawnstruct();
    level.waypoints[42].origin = (-8.18351,911.528,0.125001);
    level.waypoints[42].childCount = 8;
    level.waypoints[42].children[0] = 34;
    level.waypoints[42].children[1] = 38;
    level.waypoints[42].children[2] = 37;
    level.waypoints[42].children[3] = 41;
    level.waypoints[42].children[4] = 40;
    level.waypoints[42].children[5] = 36;
    level.waypoints[42].children[6] = 39;
    level.waypoints[42].children[7] = 35;
    level.waypoints[43] = spawnstruct();
    level.waypoints[43].origin = (-13.4113,1385.27,0.124999);
    level.waypoints[43].childCount = 2;
    level.waypoints[43].children[0] = 38;
    level.waypoints[43].children[1] = 44;
    level.waypoints[44] = spawnstruct();
    level.waypoints[44].origin = (464.927,1386.39,0.124999);
    level.waypoints[44].childCount = 2;
    level.waypoints[44].children[0] = 43;
    level.waypoints[44].children[1] = 45;
    level.waypoints[45] = spawnstruct();
    level.waypoints[45].origin = (464.355,1038.92,0.124999);
    level.waypoints[45].childCount = 4;
    level.waypoints[45].children[0] = 44;
    level.waypoints[45].children[1] = 46;
    level.waypoints[45].children[2] = 48;
    level.waypoints[45].children[3] = 49;
    level.waypoints[46] = spawnstruct();
    level.waypoints[46].origin = (570.284,923.554,0.124999);
    level.waypoints[46].childCount = 3;
    level.waypoints[46].children[0] = 45;
    level.waypoints[46].children[1] = 47;
    level.waypoints[46].children[2] = 49;
    level.waypoints[47] = spawnstruct();
    level.waypoints[47].origin = (461.883,804.256,0.124999);
    level.waypoints[47].childCount = 3;
    level.waypoints[47].children[0] = 46;
    level.waypoints[47].children[1] = 48;
    level.waypoints[47].children[2] = 49;
    level.waypoints[48] = spawnstruct();
    level.waypoints[48].origin = (362.136,935.193,0.124999);
    level.waypoints[48].childCount = 4;
    level.waypoints[48].children[0] = 47;
    level.waypoints[48].children[1] = 45;
    level.waypoints[48].children[2] = 49;
    level.waypoints[48].children[3] = 40;
    level.waypoints[49] = spawnstruct();
    level.waypoints[49].origin = (461.24,929.445,0.124999);
    level.waypoints[49].childCount = 4;
    level.waypoints[49].children[0] = 46;
    level.waypoints[49].children[1] = 48;
    level.waypoints[49].children[2] = 47;
    level.waypoints[49].children[3] = 45;
    level.waypoints[50] = spawnstruct();
    level.waypoints[50].origin = (-430.231,914.791,0.124999);
    level.waypoints[50].childCount = 2;
    level.waypoints[50].children[0] = 36;
    level.waypoints[50].children[1] = 51;
    level.waypoints[51] = spawnstruct();
    level.waypoints[51].origin = (-433.469,1295.65,160.125);
    level.waypoints[51].childCount = 2;
    level.waypoints[51].children[0] = 50;
    level.waypoints[51].children[1] = 52;
    level.waypoints[52] = spawnstruct();
    level.waypoints[52].origin = (-439.713,1414.95,160.125);
    level.waypoints[52].childCount = 2;
    level.waypoints[52].children[0] = 51;
    level.waypoints[52].children[1] = 53;
    level.waypoints[53] = spawnstruct();
    level.waypoints[53].origin = (-207.647,1415.13,248.125);
    level.waypoints[53].childCount = 2;
    level.waypoints[53].children[0] = 52;
    level.waypoints[53].children[1] = 54;
    level.waypoints[54] = spawnstruct();
    level.waypoints[54].origin = (-156.826,1341.94,248.125);
    level.waypoints[54].childCount = 2;
    level.waypoints[54].children[0] = 53;
    level.waypoints[54].children[1] = 55;
    level.waypoints[55] = spawnstruct();
    level.waypoints[55].origin = (-152.289,1181.58,248.125);
    level.waypoints[55].childCount = 3;
    level.waypoints[55].children[0] = 54;
    level.waypoints[55].children[1] = 56;
    level.waypoints[55].children[2] = 62;
    level.waypoints[56] = spawnstruct();
    level.waypoints[56].origin = (212.842,1181.98,248.125);
    level.waypoints[56].childCount = 2;
    level.waypoints[56].children[0] = 55;
    level.waypoints[56].children[1] = 57;
    level.waypoints[57] = spawnstruct();
    level.waypoints[57].origin = (270.07,1000.34,248.125);
    level.waypoints[57].childCount = 2;
    level.waypoints[57].children[0] = 56;
    level.waypoints[57].children[1] = 58;
    level.waypoints[58] = spawnstruct();
    level.waypoints[58].origin = (271.976,713.809,248.125);
    level.waypoints[58].childCount = 2;
    level.waypoints[58].children[0] = 57;
    level.waypoints[58].children[1] = 59;
    level.waypoints[59] = spawnstruct();
    level.waypoints[59].origin = (2.73831,684.212,248.125);
    level.waypoints[59].childCount = 2;
    level.waypoints[59].children[0] = 58;
    level.waypoints[59].children[1] = 60;
    level.waypoints[60] = spawnstruct();
    level.waypoints[60].origin = (-256.249,672.607,248.125);
    level.waypoints[60].childCount = 2;
    level.waypoints[60].children[0] = 59;
    level.waypoints[60].children[1] = 61;
    level.waypoints[61] = spawnstruct();
    level.waypoints[61].origin = (-259.73,941.819,248.125);
    level.waypoints[61].childCount = 2;
    level.waypoints[61].children[0] = 60;
    level.waypoints[61].children[1] = 62;
    level.waypoints[62] = spawnstruct();
    level.waypoints[62].origin = (-287.852,1171.53,248.125);
    level.waypoints[62].childCount = 2;
    level.waypoints[62].children[0] = 61;
    level.waypoints[62].children[1] = 55;
    level.waypoints[63] = spawnstruct();
    level.waypoints[63].origin = (326.589,9.37814,0.125);
    level.waypoints[63].childCount = 4;
    level.waypoints[63].children[0] = 30;
    level.waypoints[63].children[1] = 64;
    level.waypoints[63].children[2] = 70;
    level.waypoints[63].children[3] = 71;
    level.waypoints[64] = spawnstruct();
    level.waypoints[64].origin = (332.004,128.969,0.125);
    level.waypoints[64].childCount = 3;
    level.waypoints[64].children[0] = 63;
    level.waypoints[64].children[1] = 65;
    level.waypoints[64].children[2] = 71;
    level.waypoints[65] = spawnstruct();
    level.waypoints[65].origin = (453.164,129.064,0.125);
    level.waypoints[65].childCount = 4;
    level.waypoints[65].children[0] = 64;
    level.waypoints[65].children[1] = 66;
    level.waypoints[65].children[2] = 71;
    level.waypoints[65].children[3] = 79;
    level.waypoints[66] = spawnstruct();
    level.waypoints[66].origin = (584.271,144.875,0.125);
    level.waypoints[66].childCount = 3;
    level.waypoints[66].children[0] = 65;
    level.waypoints[66].children[1] = 67;
    level.waypoints[66].children[2] = 71;
    level.waypoints[67] = spawnstruct();
    level.waypoints[67].origin = (589.766,2.82739,0.125);
    level.waypoints[67].childCount = 4;
    level.waypoints[67].children[0] = 66;
    level.waypoints[67].children[1] = 68;
    level.waypoints[67].children[2] = 71;
    level.waypoints[67].children[3] = 72;
    level.waypoints[68] = spawnstruct();
    level.waypoints[68].origin = (597.472,-136.421,0.125001);
    level.waypoints[68].childCount = 3;
    level.waypoints[68].children[0] = 67;
    level.waypoints[68].children[1] = 69;
    level.waypoints[68].children[2] = 71;
    level.waypoints[69] = spawnstruct();
    level.waypoints[69].origin = (459.614,-131.514,0.125001);
    level.waypoints[69].childCount = 4;
    level.waypoints[69].children[0] = 68;
    level.waypoints[69].children[1] = 70;
    level.waypoints[69].children[2] = 71;
    level.waypoints[69].children[3] = 77;
    level.waypoints[70] = spawnstruct();
    level.waypoints[70].origin = (330.001,-136.875,0.125001);
    level.waypoints[70].childCount = 3;
    level.waypoints[70].children[0] = 69;
    level.waypoints[70].children[1] = 63;
    level.waypoints[70].children[2] = 71;
    level.waypoints[71] = spawnstruct();
    level.waypoints[71].origin = (453.442,7.52425,0.124999);
    level.waypoints[71].childCount = 8;
    level.waypoints[71].children[0] = 70;
    level.waypoints[71].children[1] = 65;
    level.waypoints[71].children[2] = 66;
    level.waypoints[71].children[3] = 68;
    level.waypoints[71].children[4] = 67;
    level.waypoints[71].children[5] = 64;
    level.waypoints[71].children[6] = 63;
    level.waypoints[71].children[7] = 69;
    level.waypoints[72] = spawnstruct();
    level.waypoints[72].origin = (923.848,24.3873,0.125001);
    level.waypoints[72].childCount = 2;
    level.waypoints[72].children[0] = 67;
    level.waypoints[72].children[1] = 73;
    level.waypoints[73] = spawnstruct();
    level.waypoints[73].origin = (928.119,-458.67,0.125001);
    level.waypoints[73].childCount = 2;
    level.waypoints[73].children[0] = 72;
    level.waypoints[73].children[1] = 74;
    level.waypoints[74] = spawnstruct();
    level.waypoints[74].origin = (583.308,-450.921,0.125001);
    level.waypoints[74].childCount = 4;
    level.waypoints[74].children[0] = 73;
    level.waypoints[74].children[1] = 75;
    level.waypoints[74].children[2] = 76;
    level.waypoints[74].children[3] = 77;
    level.waypoints[75] = spawnstruct();
    level.waypoints[75].origin = (444.549,-580.495,0.125001);
    level.waypoints[75].childCount = 3;
    level.waypoints[75].children[0] = 74;
    level.waypoints[75].children[1] = 76;
    level.waypoints[75].children[2] = 78;
    level.waypoints[76] = spawnstruct();
    level.waypoints[76].origin = (444.644,-477.588,0.125001);
    level.waypoints[76].childCount = 4;
    level.waypoints[76].children[0] = 75;
    level.waypoints[76].children[1] = 77;
    level.waypoints[76].children[2] = 74;
    level.waypoints[76].children[3] = 78;
    level.waypoints[77] = spawnstruct();
    level.waypoints[77].origin = (459.916,-366.417,0.125001);
    level.waypoints[77].childCount = 4;
    level.waypoints[77].children[0] = 76;
    level.waypoints[77].children[1] = 78;
    level.waypoints[77].children[2] = 74;
    level.waypoints[77].children[3] = 69;
    level.waypoints[78] = spawnstruct();
    level.waypoints[78].origin = (359.904,-449.402,0.125001);
    level.waypoints[78].childCount = 3;
    level.waypoints[78].children[0] = 77;
    level.waypoints[78].children[1] = 75;
    level.waypoints[78].children[2] = 76;
    level.waypoints[79] = spawnstruct();
    level.waypoints[79].origin = (453.628,433.374,0.125001);
    level.waypoints[79].childCount = 2;
    level.waypoints[79].children[0] = 65;
    level.waypoints[79].children[1] = 80;
    level.waypoints[80] = spawnstruct();
    level.waypoints[80].origin = (817.507,431.144,160.125);
    level.waypoints[80].childCount = 2;
    level.waypoints[80].children[0] = 79;
    level.waypoints[80].children[1] = 81;
    level.waypoints[81] = spawnstruct();
    level.waypoints[81].origin = (938.532,434.748,160.125);
    level.waypoints[81].childCount = 2;
    level.waypoints[81].children[0] = 80;
    level.waypoints[81].children[1] = 82;
    level.waypoints[82] = spawnstruct();
    level.waypoints[82].origin = (942.358,200.284,248.125);
    level.waypoints[82].childCount = 2;
    level.waypoints[82].children[0] = 81;
    level.waypoints[82].children[1] = 83;
    level.waypoints[83] = spawnstruct();
    level.waypoints[83].origin = (861.626,158.778,248.125);
    level.waypoints[83].childCount = 2;
    level.waypoints[83].children[0] = 82;
    level.waypoints[83].children[1] = 84;
    level.waypoints[84] = spawnstruct();
    level.waypoints[84].origin = (721.238,163.493,248.125);
    level.waypoints[84].childCount = 3;
    level.waypoints[84].children[0] = 83;
    level.waypoints[84].children[1] = 85;
    level.waypoints[84].children[2] = 92;
    level.waypoints[85] = spawnstruct();
    level.waypoints[85].origin = (716.271,-55.2536,248.125);
    level.waypoints[85].childCount = 2;
    level.waypoints[85].children[0] = 84;
    level.waypoints[85].children[1] = 86;
    level.waypoints[86] = spawnstruct();
    level.waypoints[86].origin = (680.099,-249.748,248.125);
    level.waypoints[86].childCount = 2;
    level.waypoints[86].children[0] = 85;
    level.waypoints[86].children[1] = 87;
    level.waypoints[87] = spawnstruct();
    level.waypoints[87].origin = (414.887,-283.22,248.125);
    level.waypoints[87].childCount = 2;
    level.waypoints[87].children[0] = 86;
    level.waypoints[87].children[1] = 88;
    level.waypoints[88] = spawnstruct();
    level.waypoints[88].origin = (225.225,-271.429,248.125);
    level.waypoints[88].childCount = 2;
    level.waypoints[88].children[0] = 87;
    level.waypoints[88].children[1] = 89;
    level.waypoints[89] = spawnstruct();
    level.waypoints[89].origin = (211.523,-18.9438,248.125);
    level.waypoints[89].childCount = 2;
    level.waypoints[89].children[0] = 88;
    level.waypoints[89].children[1] = 90;
    level.waypoints[90] = spawnstruct();
    level.waypoints[90].origin = (208.356,254.742,248.125);
    level.waypoints[90].childCount = 2;
    level.waypoints[90].children[0] = 89;
    level.waypoints[90].children[1] = 91;
    level.waypoints[91] = spawnstruct();
    level.waypoints[91].origin = (450.101,258.714,248.125);
    level.waypoints[91].childCount = 2;
    level.waypoints[91].children[0] = 90;
    level.waypoints[91].children[1] = 92;
    level.waypoints[92] = spawnstruct();
    level.waypoints[92].origin = (686.086,277.114,248.125);
    level.waypoints[92].childCount = 2;
    level.waypoints[92].children[0] = 91;
    level.waypoints[92].children[1] = 84;
    level.waypoints[93] = spawnstruct();
    level.waypoints[93].origin = (-8.73938,-197.626,0.125);
    level.waypoints[93].childCount = 2;
    level.waypoints[93].children[0] = 29;
    level.waypoints[93].children[1] = 94;
    level.waypoints[94] = spawnstruct();
    level.waypoints[94].origin = (22.4942,-407.872,0.125);
    level.waypoints[94].childCount = 2;
    level.waypoints[94].children[0] = 93;
    level.waypoints[94].children[1] = 95;
    level.waypoints[95] = spawnstruct();
    level.waypoints[95].origin = (-14.6939,-683.165,0.125);
    level.waypoints[95].childCount = 2;
    level.waypoints[95].children[0] = 94;
    level.waypoints[95].children[1] = 96;
    level.waypoints[96] = spawnstruct();
    level.waypoints[96].origin = (-12.6645,-809.53,0.125);
    level.waypoints[96].childCount = 4;
    level.waypoints[96].children[0] = 95;
    level.waypoints[96].children[1] = 97;
    level.waypoints[96].children[2] = 103;
    level.waypoints[96].children[3] = 104;
    level.waypoints[97] = spawnstruct();
    level.waypoints[97].origin = (123.352,-804.269,0.125);
    level.waypoints[97].childCount = 3;
    level.waypoints[97].children[0] = 96;
    level.waypoints[97].children[1] = 98;
    level.waypoints[97].children[2] = 104;
    level.waypoints[98] = spawnstruct();
    level.waypoints[98].origin = (121.255,-931.609,0.125);
    level.waypoints[98].childCount = 4;
    level.waypoints[98].children[0] = 97;
    level.waypoints[98].children[1] = 99;
    level.waypoints[98].children[2] = 104;
    level.waypoints[98].children[3] = 112;
    level.waypoints[99] = spawnstruct();
    level.waypoints[99].origin = (135.395,-1059.06,0.125);
    level.waypoints[99].childCount = 3;
    level.waypoints[99].children[0] = 98;
    level.waypoints[99].children[1] = 100;
    level.waypoints[99].children[2] = 104;
    level.waypoints[100] = spawnstruct();
    level.waypoints[100].origin = (13.7272,-1049.34,0.125);
    level.waypoints[100].childCount = 4;
    level.waypoints[100].children[0] = 99;
    level.waypoints[100].children[1] = 101;
    level.waypoints[100].children[2] = 104;
    level.waypoints[100].children[3] = 105;
    level.waypoints[101] = spawnstruct();
    level.waypoints[101].origin = (-136.873,-1071.87,0.125001);
    level.waypoints[101].childCount = 3;
    level.waypoints[101].children[0] = 100;
    level.waypoints[101].children[1] = 102;
    level.waypoints[101].children[2] = 104;
    level.waypoints[102] = spawnstruct();
    level.waypoints[102].origin = (-136.871,-943.559,0.125001);
    level.waypoints[102].childCount = 4;
    level.waypoints[102].children[0] = 101;
    level.waypoints[102].children[1] = 103;
    level.waypoints[102].children[2] = 104;
    level.waypoints[102].children[3] = 110;
    level.waypoints[103] = spawnstruct();
    level.waypoints[103].origin = (-136.848,-813.207,0.125001);
    level.waypoints[103].childCount = 3;
    level.waypoints[103].children[0] = 102;
    level.waypoints[103].children[1] = 96;
    level.waypoints[103].children[2] = 104;
    level.waypoints[104] = spawnstruct();
    level.waypoints[104].origin = (8.68744,-925.902,0.125001);
    level.waypoints[104].childCount = 8;
    level.waypoints[104].children[0] = 96;
    level.waypoints[104].children[1] = 100;
    level.waypoints[104].children[2] = 99;
    level.waypoints[104].children[3] = 103;
    level.waypoints[104].children[4] = 101;
    level.waypoints[104].children[5] = 98;
    level.waypoints[104].children[6] = 97;
    level.waypoints[104].children[7] = 102;
    level.waypoints[105] = spawnstruct();
    level.waypoints[105].origin = (25.5934,-1377.87,0.125002);
    level.waypoints[105].childCount = 2;
    level.waypoints[105].children[0] = 100;
    level.waypoints[105].children[1] = 106;
    level.waypoints[106] = spawnstruct();
    level.waypoints[106].origin = (-455.978,-1394.77,0.125002);
    level.waypoints[106].childCount = 2;
    level.waypoints[106].children[0] = 105;
    level.waypoints[106].children[1] = 107;
    level.waypoints[107] = spawnstruct();
    level.waypoints[107].origin = (-456.064,-1041.15,0.125002);
    level.waypoints[107].childCount = 4;
    level.waypoints[107].children[0] = 106;
    level.waypoints[107].children[1] = 108;
    level.waypoints[107].children[2] = 109;
    level.waypoints[107].children[3] = 110;
    level.waypoints[108] = spawnstruct();
    level.waypoints[108].origin = (-551.797,-920.433,0.125002);
    level.waypoints[108].childCount = 3;
    level.waypoints[108].children[0] = 107;
    level.waypoints[108].children[1] = 109;
    level.waypoints[108].children[2] = 111;
    level.waypoints[109] = spawnstruct();
    level.waypoints[109].origin = (-474.067,-920.327,0.125002);
    level.waypoints[109].childCount = 4;
    level.waypoints[109].children[0] = 108;
    level.waypoints[109].children[1] = 110;
    level.waypoints[109].children[2] = 111;
    level.waypoints[109].children[3] = 107;
    level.waypoints[110] = spawnstruct();
    level.waypoints[110].origin = (-366.046,-941.608,0.125002);
    level.waypoints[110].childCount = 4;
    level.waypoints[110].children[0] = 109;
    level.waypoints[110].children[1] = 111;
    level.waypoints[110].children[2] = 107;
    level.waypoints[110].children[3] = 102;
    level.waypoints[111] = spawnstruct();
    level.waypoints[111].origin = (-462.031,-829.543,0.125002);
    level.waypoints[111].childCount = 3;
    level.waypoints[111].children[0] = 110;
    level.waypoints[111].children[1] = 108;
    level.waypoints[111].children[2] = 109;
    level.waypoints[112] = spawnstruct();
    level.waypoints[112].origin = (435.824,-927.108,0.125002);
    level.waypoints[112].childCount = 2;
    level.waypoints[112].children[0] = 98;
    level.waypoints[112].children[1] = 113;
    level.waypoints[113] = spawnstruct();
    level.waypoints[113].origin = (435.716,-1293.01,160.125);
    level.waypoints[113].childCount = 2;
    level.waypoints[113].children[0] = 112;
    level.waypoints[113].children[1] = 114;
    level.waypoints[114] = spawnstruct();
    level.waypoints[114].origin = (443.415,-1421.72,160.125);
    level.waypoints[114].childCount = 2;
    level.waypoints[114].children[0] = 113;
    level.waypoints[114].children[1] = 115;
    level.waypoints[115] = spawnstruct();
    level.waypoints[115].origin = (210.502,-1418.54,248.125);
    level.waypoints[115].childCount = 2;
    level.waypoints[115].children[0] = 114;
    level.waypoints[115].children[1] = 116;
    level.waypoints[116] = spawnstruct();
    level.waypoints[116].origin = (159.42,-1327.17,248.125);
    level.waypoints[116].childCount = 2;
    level.waypoints[116].children[0] = 115;
    level.waypoints[116].children[1] = 117;
    level.waypoints[117] = spawnstruct();
    level.waypoints[117].origin = (172.833,-1185.41,248.125);
    level.waypoints[117].childCount = 3;
    level.waypoints[117].children[0] = 116;
    level.waypoints[117].children[1] = 118;
    level.waypoints[117].children[2] = 125;
    level.waypoints[118] = spawnstruct();
    level.waypoints[118].origin = (-114.658,-1193.99,248.125);
    level.waypoints[118].childCount = 2;
    level.waypoints[118].children[0] = 117;
    level.waypoints[118].children[1] = 119;
    level.waypoints[119] = spawnstruct();
    level.waypoints[119].origin = (-273.73,-1096.98,248.125);
    level.waypoints[119].childCount = 2;
    level.waypoints[119].children[0] = 118;
    level.waypoints[119].children[1] = 120;
    level.waypoints[120] = spawnstruct();
    level.waypoints[120].origin = (-243.45,-910.608,248.125);
    level.waypoints[120].childCount = 2;
    level.waypoints[120].children[0] = 119;
    level.waypoints[120].children[1] = 121;
    level.waypoints[121] = spawnstruct();
    level.waypoints[121].origin = (-256.495,-692.356,248.125);
    level.waypoints[121].childCount = 2;
    level.waypoints[121].children[0] = 120;
    level.waypoints[121].children[1] = 122;
    level.waypoints[122] = spawnstruct();
    level.waypoints[122].origin = (-12.078,-677.678,248.125);
    level.waypoints[122].childCount = 2;
    level.waypoints[122].children[0] = 121;
    level.waypoints[122].children[1] = 123;
    level.waypoints[123] = spawnstruct();
    level.waypoints[123].origin = (255.148,-671.922,248.125);
    level.waypoints[123].childCount = 2;
    level.waypoints[123].children[0] = 122;
    level.waypoints[123].children[1] = 124;
    level.waypoints[124] = spawnstruct();
    level.waypoints[124].origin = (259.117,-939.106,248.125);
    level.waypoints[124].childCount = 2;
    level.waypoints[124].children[0] = 123;
    level.waypoints[124].children[1] = 125;
    level.waypoints[125] = spawnstruct();
    level.waypoints[125].origin = (279.12,-1160.71,248.125);
    level.waypoints[125].childCount = 2;
    level.waypoints[125].children[0] = 124;
    level.waypoints[125].children[1] = 117;
 
    level.waypointCount = level.waypoints.size;
}