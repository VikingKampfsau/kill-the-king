// =========================================================================================
// File Name = 'maze1_waypoints.gsc'
// Map Name  = 'maze1'
// =========================================================================================
// 
// This is an auto generated script file created by the PeZBOT Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'maze1'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'Dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - new_waypoints.iwd/maze1_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
/*
 
    else if(mapname == 'maze1')
    {
        thread Waypoints/maze1_waypoints::load_waypoints();
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-56,258,16.125);
    level.waypoints[0].type = "stand";
    level.waypoints[0].childCount = 1;
    level.waypoints[0].children[0] = 47;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (-152,258,16.125);
    level.waypoints[1].type = "stand";
    level.waypoints[1].childCount = 1;
    level.waypoints[1].children[0] = 47;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-64,-6,16.125);
    level.waypoints[2].type = "stand";
    level.waypoints[2].childCount = 1;
    level.waypoints[2].children[0] = 40;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-160,-6,16.125);
    level.waypoints[3].type = "stand";
    level.waypoints[3].childCount = 1;
    level.waypoints[3].children[0] = 40;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-416.6,-38.0192,16.125);
    level.waypoints[4].type = "stand";
    level.waypoints[4].childCount = 1;
    level.waypoints[4].children[0] = 53;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (-309.4,-30.0192,16.125);
    level.waypoints[5].type = "stand";
    level.waypoints[5].childCount = 1;
    level.waypoints[5].children[0] = 53;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (-594,-160,16.125);
    level.waypoints[6].type = "stand";
    level.waypoints[6].childCount = 1;
    level.waypoints[6].children[0] = 41;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (-594,-256,16.125);
    level.waypoints[7].type = "stand";
    level.waypoints[7].childCount = 1;
    level.waypoints[7].children[0] = 41;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (-2.6,-198.019,16.125);
    level.waypoints[8].type = "stand";
    level.waypoints[8].childCount = 1;
    level.waypoints[8].children[0] = 45;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (104.6,-206.019,16.125);
    level.waypoints[9].type = "stand";
    level.waypoints[9].childCount = 1;
    level.waypoints[9].children[0] = 45;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (448,-406,16.125);
    level.waypoints[10].type = "stand";
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 11;
    level.waypoints[10].children[1] = 84;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (352,-406,16.125);
    level.waypoints[11].type = "stand";
    level.waypoints[11].childCount = 1;
    level.waypoints[11].children[0] = 10;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (485.4,-1174.02,16.125);
    level.waypoints[12].type = "stand";
    level.waypoints[12].childCount = 1;
    level.waypoints[12].children[0] = 30;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (536.6,-1270.02,16.125);
    level.waypoints[13].type = "stand";
    level.waypoints[13].childCount = 1;
    level.waypoints[13].children[0] = 30;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (-464,-746,16.125);
    level.waypoints[14].type = "stand";
    level.waypoints[14].childCount = 1;
    level.waypoints[14].children[0] = 59;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (-368,-746,16.125);
    level.waypoints[15].type = "stand";
    level.waypoints[15].childCount = 1;
    level.waypoints[15].children[0] = 59;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-390,-992,16.125);
    level.waypoints[16].type = "stand";
    level.waypoints[16].childCount = 1;
    level.waypoints[16].children[0] = 57;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-390,-896,16.125);
    level.waypoints[17].type = "stand";
    level.waypoints[17].childCount = 1;
    level.waypoints[17].children[0] = 57;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (-553.981,-72.6,16.125);
    level.waypoints[18].type = "stand";
    level.waypoints[18].childCount = 2;
    level.waypoints[18].children[0] = 50;
    level.waypoints[18].children[1] = 49;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (-601.981,10.6,16.125);
    level.waypoints[19].type = "stand";
    level.waypoints[19].childCount = 2;
    level.waypoints[19].children[0] = 50;
    level.waypoints[19].children[1] = 49;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (-991.4,-657.981,16.125);
    level.waypoints[20].type = "stand";
    level.waypoints[20].childCount = 1;
    level.waypoints[20].children[0] = 62;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (-1058.6,-705.981,16.125);
    level.waypoints[21].type = "stand";
    level.waypoints[21].childCount = 1;
    level.waypoints[21].children[0] = 62;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (256,-762,16.125);
    level.waypoints[22].type = "stand";
    level.waypoints[22].childCount = 2;
    level.waypoints[22].children[0] = 82;
    level.waypoints[22].children[1] = 83;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (352,-762,16.125);
    level.waypoints[23].type = "stand";
    level.waypoints[23].childCount = 2;
    level.waypoints[23].children[0] = 83;
    level.waypoints[23].children[1] = 84;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (-480,-1322,16.125);
    level.waypoints[24].type = "stand";
    level.waypoints[24].childCount = 1;
    level.waypoints[24].children[0] = 67;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (-384,-1322,16.125);
    level.waypoints[25].type = "stand";
    level.waypoints[25].childCount = 1;
    level.waypoints[25].children[0] = 67;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (-160,-1610,16.125);
    level.waypoints[26].type = "stand";
    level.waypoints[26].childCount = 1;
    level.waypoints[26].children[0] = 73;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-64,-1610,16.125);
    level.waypoints[27].type = "stand";
    level.waypoints[27].childCount = 1;
    level.waypoints[27].children[0] = 73;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (375.4,-1430.02,16.125);
    level.waypoints[28].type = "stand";
    level.waypoints[28].childCount = 1;
    level.waypoints[28].children[0] = 33;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (426.6,-1382.02,16.125);
    level.waypoints[29].type = "stand";
    level.waypoints[29].childCount = 1;
    level.waypoints[29].children[0] = 33;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (609.424,-1008.31,16.125);
    level.waypoints[30].type = "stand";
    level.waypoints[30].childCount = 4;
    level.waypoints[30].children[0] = 31;
    level.waypoints[30].children[1] = 12;
    level.waypoints[30].children[2] = 13;
    level.waypoints[30].children[3] = 34;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (492.092,-882.361,16.125);
    level.waypoints[31].type = "stand";
    level.waypoints[31].childCount = 2;
    level.waypoints[31].children[0] = 32;
    level.waypoints[31].children[1] = 30;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (339.921,-1125.25,16.125);
    level.waypoints[32].type = "stand";
    level.waypoints[32].childCount = 3;
    level.waypoints[32].children[0] = 33;
    level.waypoints[32].children[1] = 31;
    level.waypoints[32].children[2] = 81;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (338.631,-1285.46,16.125);
    level.waypoints[33].type = "stand";
    level.waypoints[33].childCount = 4;
    level.waypoints[33].children[0] = 28;
    level.waypoints[33].children[1] = 29;
    level.waypoints[33].children[2] = 32;
    level.waypoints[33].children[3] = 81;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (782.204,-664.805,16.125);
    level.waypoints[34].type = "stand";
    level.waypoints[34].childCount = 2;
    level.waypoints[34].children[0] = 35;
    level.waypoints[34].children[1] = 30;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (681.026,-430.975,16.125);
    level.waypoints[35].type = "stand";
    level.waypoints[35].childCount = 2;
    level.waypoints[35].children[0] = 36;
    level.waypoints[35].children[1] = 34;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (535.87,-166.528,16.125);
    level.waypoints[36].type = "stand";
    level.waypoints[36].childCount = 3;
    level.waypoints[36].children[0] = 37;
    level.waypoints[36].children[1] = 35;
    level.waypoints[36].children[2] = 42;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (268.398,-205.526,16.125);
    level.waypoints[37].type = "stand";
    level.waypoints[37].childCount = 2;
    level.waypoints[37].children[0] = 38;
    level.waypoints[37].children[1] = 36;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (98.184,-437.5,16.125);
    level.waypoints[38].type = "stand";
    level.waypoints[38].childCount = 4;
    level.waypoints[38].children[0] = 39;
    level.waypoints[38].children[1] = 37;
    level.waypoints[38].children[2] = 82;
    level.waypoints[38].children[3] = 86;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (-96.3535,-401.343,16.125);
    level.waypoints[39].type = "stand";
    level.waypoints[39].childCount = 3;
    level.waypoints[39].children[0] = 40;
    level.waypoints[39].children[1] = 38;
    level.waypoints[39].children[2] = 78;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (-191.818,-204.277,16.125);
    level.waypoints[40].type = "stand";
    level.waypoints[40].childCount = 4;
    level.waypoints[40].children[0] = 41;
    level.waypoints[40].children[1] = 2;
    level.waypoints[40].children[2] = 3;
    level.waypoints[40].children[3] = 39;
    level.waypoints[41] = spawnstruct();
    level.waypoints[41].origin = (-440.584,-204.687,16.125);
    level.waypoints[41].type = "stand";
    level.waypoints[41].childCount = 3;
    level.waypoints[41].children[0] = 7;
    level.waypoints[41].children[1] = 6;
    level.waypoints[41].children[2] = 40;
    level.waypoints[42] = spawnstruct();
    level.waypoints[42].origin = (445.467,14.4371,16.125);
    level.waypoints[42].type = "stand";
    level.waypoints[42].childCount = 2;
    level.waypoints[42].children[0] = 43;
    level.waypoints[42].children[1] = 36;
    level.waypoints[43] = spawnstruct();
    level.waypoints[43].origin = (298.116,188.419,16.125);
    level.waypoints[43].type = "stand";
    level.waypoints[43].childCount = 3;
    level.waypoints[43].children[0] = 44;
    level.waypoints[43].children[1] = 42;
    level.waypoints[43].children[2] = 46;
    level.waypoints[44] = spawnstruct();
    level.waypoints[44].origin = (215.26,32.7217,16.125);
    level.waypoints[44].type = "stand";
    level.waypoints[44].childCount = 3;
    level.waypoints[44].children[0] = 45;
    level.waypoints[44].children[1] = 43;
    level.waypoints[44].children[2] = 46;
    level.waypoints[45] = spawnstruct();
    level.waypoints[45].origin = (72.3645,-112.939,16.125);
    level.waypoints[45].type = "stand";
    level.waypoints[45].childCount = 3;
    level.waypoints[45].children[0] = 8;
    level.waypoints[45].children[1] = 9;
    level.waypoints[45].children[2] = 44;
    level.waypoints[46] = spawnstruct();
    level.waypoints[46].origin = (182.427,163.109,16.125);
    level.waypoints[46].type = "stand";
    level.waypoints[46].childCount = 3;
    level.waypoints[46].children[0] = 47;
    level.waypoints[46].children[1] = 43;
    level.waypoints[46].children[2] = 44;
    level.waypoints[47] = spawnstruct();
    level.waypoints[47].origin = (-103.566,157.782,16.125);
    level.waypoints[47].type = "stand";
    level.waypoints[47].childCount = 4;
    level.waypoints[47].children[0] = 0;
    level.waypoints[47].children[1] = 1;
    level.waypoints[47].children[2] = 48;
    level.waypoints[47].children[3] = 46;
    level.waypoints[48] = spawnstruct();
    level.waypoints[48].origin = (-395.552,175.704,16.125);
    level.waypoints[48].type = "stand";
    level.waypoints[48].childCount = 3;
    level.waypoints[48].children[0] = 49;
    level.waypoints[48].children[1] = 47;
    level.waypoints[48].children[2] = 53;
    level.waypoints[49] = spawnstruct();
    level.waypoints[49].origin = (-590.243,159.454,16.125);
    level.waypoints[49].type = "stand";
    level.waypoints[49].childCount = 4;
    level.waypoints[49].children[0] = 18;
    level.waypoints[49].children[1] = 19;
    level.waypoints[49].children[2] = 48;
    level.waypoints[49].children[3] = 50;
    level.waypoints[50] = spawnstruct();
    level.waypoints[50].origin = (-734.626,-52.6597,16.125);
    level.waypoints[50].type = "stand";
    level.waypoints[50].childCount = 4;
    level.waypoints[50].children[0] = 51;
    level.waypoints[50].children[1] = 18;
    level.waypoints[50].children[2] = 19;
    level.waypoints[50].children[3] = 49;
    level.waypoints[51] = spawnstruct();
    level.waypoints[51].origin = (-845.568,-302.967,16.125);
    level.waypoints[51].type = "stand";
    level.waypoints[51].childCount = 3;
    level.waypoints[51].children[0] = 52;
    level.waypoints[51].children[1] = 50;
    level.waypoints[51].children[2] = 54;
    level.waypoints[52] = spawnstruct();
    level.waypoints[52].origin = (-918.625,-454.916,16.125);
    level.waypoints[52].type = "stand";
    level.waypoints[52].childCount = 1;
    level.waypoints[52].children[0] = 51;
    level.waypoints[53] = spawnstruct();
    level.waypoints[53].origin = (-408.668,84.3241,16.125);
    level.waypoints[53].type = "stand";
    level.waypoints[53].childCount = 3;
    level.waypoints[53].children[0] = 48;
    level.waypoints[53].children[1] = 4;
    level.waypoints[53].children[2] = 5;
    level.waypoints[54] = spawnstruct();
    level.waypoints[54].origin = (-743.165,-436.529,16.125);
    level.waypoints[54].type = "stand";
    level.waypoints[54].childCount = 4;
    level.waypoints[54].children[0] = 55;
    level.waypoints[54].children[1] = 51;
    level.waypoints[54].children[2] = 58;
    level.waypoints[54].children[3] = 60;
    level.waypoints[55] = spawnstruct();
    level.waypoints[55].origin = (-628.514,-677.066,16.125);
    level.waypoints[55].type = "stand";
    level.waypoints[55].childCount = 2;
    level.waypoints[55].children[0] = 56;
    level.waypoints[55].children[1] = 54;
    level.waypoints[56] = spawnstruct();
    level.waypoints[56].origin = (-720.802,-873.166,16.125);
    level.waypoints[56].type = "stand";
    level.waypoints[56].childCount = 2;
    level.waypoints[56].children[0] = 57;
    level.waypoints[56].children[1] = 55;
    level.waypoints[57] = spawnstruct();
    level.waypoints[57].origin = (-547.997,-927.414,16.125);
    level.waypoints[57].type = "stand";
    level.waypoints[57].childCount = 3;
    level.waypoints[57].children[0] = 16;
    level.waypoints[57].children[1] = 17;
    level.waypoints[57].children[2] = 56;
    level.waypoints[58] = spawnstruct();
    level.waypoints[58].origin = (-575.528,-396.681,16.125);
    level.waypoints[58].type = "stand";
    level.waypoints[58].childCount = 2;
    level.waypoints[58].children[0] = 54;
    level.waypoints[58].children[1] = 59;
    level.waypoints[59] = spawnstruct();
    level.waypoints[59].origin = (-422.567,-603.208,16.125);
    level.waypoints[59].type = "stand";
    level.waypoints[59].childCount = 4;
    level.waypoints[59].children[0] = 15;
    level.waypoints[59].children[1] = 14;
    level.waypoints[59].children[2] = 58;
    level.waypoints[59].children[3] = 63;
    level.waypoints[60] = spawnstruct();
    level.waypoints[60].origin = (-825.113,-635.583,16.125);
    level.waypoints[60].type = "stand";
    level.waypoints[60].childCount = 3;
    level.waypoints[60].children[0] = 62;
    level.waypoints[60].children[1] = 54;
    level.waypoints[60].children[2] = 61;
    level.waypoints[61] = spawnstruct();
    level.waypoints[61].origin = (-927.482,-854.359,16.125);
    level.waypoints[61].type = "stand";
    level.waypoints[61].childCount = 3;
    level.waypoints[61].children[0] = 60;
    level.waypoints[61].children[1] = 64;
    level.waypoints[61].children[2] = 62;
    level.waypoints[62] = spawnstruct();
    level.waypoints[62].origin = (-974.062,-772.011,16.125);
    level.waypoints[62].type = "stand";
    level.waypoints[62].childCount = 4;
    level.waypoints[62].children[0] = 20;
    level.waypoints[62].children[1] = 21;
    level.waypoints[62].children[2] = 60;
    level.waypoints[62].children[3] = 61;
    level.waypoints[63] = spawnstruct();
    level.waypoints[63].origin = (-328.157,-457.794,16.125);
    level.waypoints[63].type = "stand";
    level.waypoints[63].childCount = 1;
    level.waypoints[63].children[0] = 59;
    level.waypoints[64] = spawnstruct();
    level.waypoints[64].origin = (-781.48,-1148.63,16.125);
    level.waypoints[64].type = "stand";
    level.waypoints[64].childCount = 3;
    level.waypoints[64].children[0] = 65;
    level.waypoints[64].children[1] = 61;
    level.waypoints[64].children[2] = 68;
    level.waypoints[65] = spawnstruct();
    level.waypoints[65].origin = (-579.371,-1145.51,16.125);
    level.waypoints[65].type = "stand";
    level.waypoints[65].childCount = 2;
    level.waypoints[65].children[0] = 66;
    level.waypoints[65].children[1] = 64;
    level.waypoints[66] = spawnstruct();
    level.waypoints[66].origin = (-295.05,-1128.49,16.125);
    level.waypoints[66].type = "stand";
    level.waypoints[66].childCount = 3;
    level.waypoints[66].children[0] = 67;
    level.waypoints[66].children[1] = 65;
    level.waypoints[66].children[2] = 74;
    level.waypoints[67] = spawnstruct();
    level.waypoints[67].origin = (-333.975,-1263.51,16.125);
    level.waypoints[67].type = "stand";
    level.waypoints[67].childCount = 3;
    level.waypoints[67].children[0] = 24;
    level.waypoints[67].children[1] = 25;
    level.waypoints[67].children[2] = 66;
    level.waypoints[68] = spawnstruct();
    level.waypoints[68].origin = (-667.855,-1379.54,16.125);
    level.waypoints[68].type = "stand";
    level.waypoints[68].childCount = 2;
    level.waypoints[68].children[0] = 69;
    level.waypoints[68].children[1] = 64;
    level.waypoints[69] = spawnstruct();
    level.waypoints[69].origin = (-558.147,-1504.42,16.125);
    level.waypoints[69].type = "stand";
    level.waypoints[69].childCount = 2;
    level.waypoints[69].children[0] = 70;
    level.waypoints[69].children[1] = 68;
    level.waypoints[70] = spawnstruct();
    level.waypoints[70].origin = (-299.641,-1500.78,16.125);
    level.waypoints[70].type = "stand";
    level.waypoints[70].childCount = 2;
    level.waypoints[70].children[0] = 71;
    level.waypoints[70].children[1] = 69;
    level.waypoints[71] = spawnstruct();
    level.waypoints[71].origin = (-143.466,-1266.43,16.125);
    level.waypoints[71].type = "stand";
    level.waypoints[71].childCount = 2;
    level.waypoints[71].children[0] = 72;
    level.waypoints[71].children[1] = 70;
    level.waypoints[72] = spawnstruct();
    level.waypoints[72].origin = (6.9224,-1483.21,16.125);
    level.waypoints[72].type = "stand";
    level.waypoints[72].childCount = 3;
    level.waypoints[72].children[0] = 73;
    level.waypoints[72].children[1] = 71;
    level.waypoints[72].children[2] = 77;
    level.waypoints[73] = spawnstruct();
    level.waypoints[73].origin = (-88.0715,-1535.05,16.125);
    level.waypoints[73].type = "stand";
    level.waypoints[73].childCount = 3;
    level.waypoints[73].children[0] = 26;
    level.waypoints[73].children[1] = 27;
    level.waypoints[73].children[2] = 72;
    level.waypoints[74] = spawnstruct();
    level.waypoints[74].origin = (-98.5413,-871.958,16.125);
    level.waypoints[74].type = "stand";
    level.waypoints[74].childCount = 4;
    level.waypoints[74].children[0] = 66;
    level.waypoints[74].children[1] = 75;
    level.waypoints[74].children[2] = 78;
    level.waypoints[74].children[3] = 79;
    level.waypoints[75] = spawnstruct();
    level.waypoints[75].origin = (-11.4222,-1039.97,16.125);
    level.waypoints[75].type = "stand";
    level.waypoints[75].childCount = 2;
    level.waypoints[75].children[0] = 76;
    level.waypoints[75].children[1] = 74;
    level.waypoints[76] = spawnstruct();
    level.waypoints[76].origin = (98.089,-1249.82,16.125);
    level.waypoints[76].type = "stand";
    level.waypoints[76].childCount = 2;
    level.waypoints[76].children[0] = 77;
    level.waypoints[76].children[1] = 75;
    level.waypoints[77] = spawnstruct();
    level.waypoints[77].origin = (214.705,-1475.65,16.125);
    level.waypoints[77].type = "stand";
    level.waypoints[77].childCount = 2;
    level.waypoints[77].children[0] = 72;
    level.waypoints[77].children[1] = 76;
    level.waypoints[78] = spawnstruct();
    level.waypoints[78].origin = (-198.379,-657.678,16.125);
    level.waypoints[78].type = "stand";
    level.waypoints[78].childCount = 2;
    level.waypoints[78].children[0] = 39;
    level.waypoints[78].children[1] = 74;
    level.waypoints[79] = spawnstruct();
    level.waypoints[79].origin = (12.4869,-761.057,16.125);
    level.waypoints[79].type = "stand";
    level.waypoints[79].childCount = 2;
    level.waypoints[79].children[0] = 74;
    level.waypoints[79].children[1] = 80;
    level.waypoints[80] = spawnstruct();
    level.waypoints[80].origin = (114.91,-879.464,16.125);
    level.waypoints[80].type = "stand";
    level.waypoints[80].childCount = 2;
    level.waypoints[80].children[0] = 81;
    level.waypoints[80].children[1] = 79;
    level.waypoints[81] = spawnstruct();
    level.waypoints[81].origin = (241.081,-1084.09,16.125);
    level.waypoints[81].type = "stand";
    level.waypoints[81].childCount = 3;
    level.waypoints[81].children[0] = 32;
    level.waypoints[81].children[1] = 33;
    level.waypoints[81].children[2] = 80;
    level.waypoints[82] = spawnstruct();
    level.waypoints[82].origin = (152.079,-591.315,16.125);
    level.waypoints[82].type = "stand";
    level.waypoints[82].childCount = 3;
    level.waypoints[82].children[0] = 22;
    level.waypoints[82].children[1] = 38;
    level.waypoints[82].children[2] = 86;
    level.waypoints[83] = spawnstruct();
    level.waypoints[83].origin = (200.852,-712.936,16.125);
    level.waypoints[83].type = "stand";
    level.waypoints[83].childCount = 2;
    level.waypoints[83].children[0] = 22;
    level.waypoints[83].children[1] = 23;
    level.waypoints[84] = spawnstruct();
    level.waypoints[84].origin = (478.587,-546.556,16.125);
    level.waypoints[84].type = "stand";
    level.waypoints[84].childCount = 3;
    level.waypoints[84].children[0] = 85;
    level.waypoints[84].children[1] = 10;
    level.waypoints[84].children[2] = 23;
    level.waypoints[85] = spawnstruct();
    level.waypoints[85].origin = (576.638,-648.181,16.125);
    level.waypoints[85].type = "stand";
    level.waypoints[85].childCount = 1;
    level.waypoints[85].children[0] = 84;
    level.waypoints[86] = spawnstruct();
    level.waypoints[86].origin = (19.0474,-591.198,16.125);
    level.waypoints[86].type = "stand";
    level.waypoints[86].childCount = 2;
    level.waypoints[86].children[0] = 38;
    level.waypoints[86].children[1] = 82;
 
    level.waypointCount = level.waypoints.size;
 
}