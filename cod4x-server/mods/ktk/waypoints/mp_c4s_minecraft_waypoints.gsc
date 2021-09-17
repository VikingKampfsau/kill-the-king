// =========================================================================================
// File Name = 'mp_c4s_minecraft_waypoints.gsc'
// Map Name  = 'mp_c4s_minecraft'
// =========================================================================================
// 
// This is an auto generated script file created by the PeZBOT Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_c4s_minecraft'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'Dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - new_waypoints.iwd/mp_c4s_minecraft_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
/*
 
    else if(mapname == 'mp_c4s_minecraft')
    {
        thread Waypoints/mp_c4s_minecraft_waypoints::load_waypoints();
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-1884,-1221,216.125);
    level.waypoints[0].type = "stand";
    level.waypoints[0].childCount = 2;
    level.waypoints[0].children[0] = 2;
    level.waypoints[0].children[1] = 88;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (-1530,-858,216.125);
    level.waypoints[1].type = "stand";
    level.waypoints[1].childCount = 3;
    level.waypoints[1].children[0] = 85;
    level.waypoints[1].children[1] = 84;
    level.waypoints[1].children[2] = 2;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-1711,-1176,216.125);
    level.waypoints[2].type = "stand";
    level.waypoints[2].childCount = 3;
    level.waypoints[2].children[0] = 84;
    level.waypoints[2].children[1] = 0;
    level.waypoints[2].children[2] = 1;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-1465,-1317,0.125);
    level.waypoints[3].type = "stand";
    level.waypoints[3].childCount = 2;
    level.waypoints[3].children[0] = 54;
    level.waypoints[3].children[1] = 50;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-366,-1372,36.125);
    level.waypoints[4].type = "stand";
    level.waypoints[4].childCount = 2;
    level.waypoints[4].children[0] = 5;
    level.waypoints[4].children[1] = 66;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (-365,-1280,36.125);
    level.waypoints[5].type = "stand";
    level.waypoints[5].childCount = 2;
    level.waypoints[5].children[0] = 66;
    level.waypoints[5].children[1] = 4;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (568,-1911,36.125);
    level.waypoints[6].type = "stand";
    level.waypoints[6].childCount = 2;
    level.waypoints[6].children[0] = 24;
    level.waypoints[6].children[1] = 78;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (340,-2120,36.125);
    level.waypoints[7].type = "stand";
    level.waypoints[7].childCount = 2;
    level.waypoints[7].children[0] = 78;
    level.waypoints[7].children[1] = 79;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (426,-2173,36.125);
    level.waypoints[8].type = "stand";
    level.waypoints[8].childCount = 3;
    level.waypoints[8].children[0] = 79;
    level.waypoints[8].children[1] = 9;
    level.waypoints[8].children[2] = 80;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (420.395,-2128.84,36.125);
    level.waypoints[9].type = "stand";
    level.waypoints[9].childCount = 2;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 79;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (-304,-828,0.125);
    level.waypoints[10].type = "stand";
    level.waypoints[10].childCount = 2;
    level.waypoints[10].children[0] = 26;
    level.waypoints[10].children[1] = 25;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (-1233,-2186,-179.875);
    level.waypoints[11].type = "stand";
    level.waypoints[11].childCount = 3;
    level.waypoints[11].children[0] = 44;
    level.waypoints[11].children[1] = 13;
    level.waypoints[11].children[2] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (-1344,-2187,-179.875);
    level.waypoints[12].type = "stand";
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 45;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (-1233,-2232,-179.875);
    level.waypoints[13].type = "stand";
    level.waypoints[13].childCount = 3;
    level.waypoints[13].children[0] = 42;
    level.waypoints[13].children[1] = 11;
    level.waypoints[13].children[2] = 14;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (-1344,-2233,-179.875);
    level.waypoints[14].type = "stand";
    level.waypoints[14].childCount = 2;
    level.waypoints[14].children[0] = 13;
    level.waypoints[14].children[1] = 45;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (-1691,-840,0.125);
    level.waypoints[15].type = "stand";
    level.waypoints[15].childCount = 1;
    level.waypoints[15].children[0] = 83;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-1634.5,-841.5,0.125);
    level.waypoints[16].type = "stand";
    level.waypoints[16].childCount = 1;
    level.waypoints[16].children[0] = 83;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-64.1842,-783.528,0.124999);
    level.waypoints[17].type = "stand";
    level.waypoints[17].childCount = 2;
    level.waypoints[17].children[0] = 18;
    level.waypoints[17].children[1] = 25;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (164.334,-783.791,0.124999);
    level.waypoints[18].type = "stand";
    level.waypoints[18].childCount = 2;
    level.waypoints[18].children[0] = 19;
    level.waypoints[18].children[1] = 17;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (263.098,-927.981,0.124999);
    level.waypoints[19].type = "stand";
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 20;
    level.waypoints[19].children[1] = 18;
    level.waypoints[19].children[2] = 70;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (263.317,-1096.24,0.124999);
    level.waypoints[20].type = "stand";
    level.waypoints[20].childCount = 3;
    level.waypoints[20].children[0] = 21;
    level.waypoints[20].children[1] = 19;
    level.waypoints[20].children[2] = 70;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (419.393,-1089.61,0.124999);
    level.waypoints[21].type = "stand";
    level.waypoints[21].childCount = 2;
    level.waypoints[21].children[0] = 22;
    level.waypoints[21].children[1] = 20;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (420.975,-1278.72,0.124999);
    level.waypoints[22].type = "stand";
    level.waypoints[22].childCount = 3;
    level.waypoints[22].children[0] = 23;
    level.waypoints[22].children[1] = 21;
    level.waypoints[22].children[2] = 68;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (493.499,-1426.08,0.124999);
    level.waypoints[23].type = "stand";
    level.waypoints[23].childCount = 2;
    level.waypoints[23].children[0] = 24;
    level.waypoints[23].children[1] = 22;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (575.137,-1622.12,0.124999);
    level.waypoints[24].type = "stand";
    level.waypoints[24].childCount = 2;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 6;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (-184.108,-807.826,0.124999);
    level.waypoints[25].type = "stand";
    level.waypoints[25].childCount = 2;
    level.waypoints[25].children[0] = 17;
    level.waypoints[25].children[1] = 10;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (-435.887,-809.057,0.124999);
    level.waypoints[26].type = "stand";
    level.waypoints[26].childCount = 2;
    level.waypoints[26].children[0] = 27;
    level.waypoints[26].children[1] = 10;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-628.491,-809.273,0.124999);
    level.waypoints[27].type = "stand";
    level.waypoints[27].childCount = 4;
    level.waypoints[27].children[0] = 28;
    level.waypoints[27].children[1] = 26;
    level.waypoints[27].children[2] = 34;
    level.waypoints[27].children[3] = 62;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (-643.925,-672.02,0.124999);
    level.waypoints[28].type = "stand";
    level.waypoints[28].childCount = 2;
    level.waypoints[28].children[0] = 29;
    level.waypoints[28].children[1] = 27;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (-656.403,-496.865,0.124999);
    level.waypoints[29].type = "stand";
    level.waypoints[29].childCount = 3;
    level.waypoints[29].children[0] = 33;
    level.waypoints[29].children[1] = 28;
    level.waypoints[29].children[2] = 30;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (-737.564,-382.407,0.124999);
    level.waypoints[30].type = "stand";
    level.waypoints[30].childCount = 2;
    level.waypoints[30].children[0] = 29;
    level.waypoints[30].children[1] = 31;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (-739.913,-218.85,0.124999);
    level.waypoints[31].type = "stand";
    level.waypoints[31].childCount = 2;
    level.waypoints[31].children[0] = 30;
    level.waypoints[31].children[1] = 32;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (-571.42,-181.784,0.124999);
    level.waypoints[32].type = "stand";
    level.waypoints[32].childCount = 2;
    level.waypoints[32].children[0] = 31;
    level.waypoints[32].children[1] = 33;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (-552.048,-412.242,0.124999);
    level.waypoints[33].type = "stand";
    level.waypoints[33].childCount = 2;
    level.waypoints[33].children[0] = 29;
    level.waypoints[33].children[1] = 32;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (-643.963,-999.668,0.124999);
    level.waypoints[34].type = "stand";
    level.waypoints[34].childCount = 4;
    level.waypoints[34].children[0] = 59;
    level.waypoints[34].children[1] = 27;
    level.waypoints[34].children[2] = 35;
    level.waypoints[34].children[3] = 63;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (-652.615,-1242.08,0.124999);
    level.waypoints[35].type = "stand";
    level.waypoints[35].childCount = 3;
    level.waypoints[35].children[0] = 34;
    level.waypoints[35].children[1] = 36;
    level.waypoints[35].children[2] = 69;
    level.waypoints[36] = spawnstruct();
    level.waypoints[36].origin = (-652.455,-1501.02,0.124999);
    level.waypoints[36].type = "stand";
    level.waypoints[36].childCount = 3;
    level.waypoints[36].children[0] = 35;
    level.waypoints[36].children[1] = 37;
    level.waypoints[36].children[2] = 69;
    level.waypoints[37] = spawnstruct();
    level.waypoints[37].origin = (-652.312,-1730.23,0.124999);
    level.waypoints[37].type = "stand";
    level.waypoints[37].childCount = 2;
    level.waypoints[37].children[0] = 36;
    level.waypoints[37].children[1] = 38;
    level.waypoints[38] = spawnstruct();
    level.waypoints[38].origin = (-652.278,-1893.35,-143.875);
    level.waypoints[38].type = "stand";
    level.waypoints[38].childCount = 2;
    level.waypoints[38].children[0] = 37;
    level.waypoints[38].children[1] = 39;
    level.waypoints[39] = spawnstruct();
    level.waypoints[39].origin = (-652.214,-2040.95,-179.875);
    level.waypoints[39].type = "stand";
    level.waypoints[39].childCount = 2;
    level.waypoints[39].children[0] = 38;
    level.waypoints[39].children[1] = 40;
    level.waypoints[40] = spawnstruct();
    level.waypoints[40].origin = (-652.115,-2194.05,-179.875);
    level.waypoints[40].type = "stand";
    level.waypoints[40].childCount = 2;
    level.waypoints[40].children[0] = 39;
    level.waypoints[40].children[1] = 41;
    level.waypoints[41] = spawnstruct();
    level.waypoints[41].origin = (-852.158,-2209.81,-179.875);
    level.waypoints[41].type = "stand";
    level.waypoints[41].childCount = 2;
    level.waypoints[41].children[0] = 40;
    level.waypoints[41].children[1] = 43;
    level.waypoints[42] = spawnstruct();
    level.waypoints[42].origin = (-1150.59,-2241.83,-179.875);
    level.waypoints[42].type = "stand";
    level.waypoints[42].childCount = 2;
    level.waypoints[42].children[0] = 13;
    level.waypoints[42].children[1] = 43;
    level.waypoints[43] = spawnstruct();
    level.waypoints[43].origin = (-1014.11,-2216.48,-179.875);
    level.waypoints[43].type = "stand";
    level.waypoints[43].childCount = 3;
    level.waypoints[43].children[0] = 44;
    level.waypoints[43].children[1] = 41;
    level.waypoints[43].children[2] = 42;
    level.waypoints[44] = spawnstruct();
    level.waypoints[44].origin = (-1130.87,-2171.43,-179.875);
    level.waypoints[44].type = "stand";
    level.waypoints[44].childCount = 2;
    level.waypoints[44].children[0] = 43;
    level.waypoints[44].children[1] = 11;
    level.waypoints[45] = spawnstruct();
    level.waypoints[45].origin = (-1514.97,-2206.33,-179.875);
    level.waypoints[45].type = "stand";
    level.waypoints[45].childCount = 3;
    level.waypoints[45].children[0] = 12;
    level.waypoints[45].children[1] = 46;
    level.waypoints[45].children[2] = 14;
    level.waypoints[46] = spawnstruct();
    level.waypoints[46].origin = (-1515.67,-2048.89,-179.875);
    level.waypoints[46].type = "stand";
    level.waypoints[46].childCount = 2;
    level.waypoints[46].children[0] = 45;
    level.waypoints[46].children[1] = 47;
    level.waypoints[47] = spawnstruct();
    level.waypoints[47].origin = (-1515.73,-1877.58,-125.875);
    level.waypoints[47].type = "stand";
    level.waypoints[47].childCount = 2;
    level.waypoints[47].children[0] = 46;
    level.waypoints[47].children[1] = 48;
    level.waypoints[48] = spawnstruct();
    level.waypoints[48].origin = (-1515.9,-1751.56,0.125);
    level.waypoints[48].type = "stand";
    level.waypoints[48].childCount = 3;
    level.waypoints[48].children[0] = 47;
    level.waypoints[48].children[1] = 49;
    level.waypoints[48].children[2] = 57;
    level.waypoints[49] = spawnstruct();
    level.waypoints[49].origin = (-1450.39,-1588.91,0.125);
    level.waypoints[49].type = "stand";
    level.waypoints[49].childCount = 2;
    level.waypoints[49].children[0] = 48;
    level.waypoints[49].children[1] = 50;
    level.waypoints[50] = spawnstruct();
    level.waypoints[50].origin = (-1372.39,-1400.7,0.125);
    level.waypoints[50].type = "stand";
    level.waypoints[50].childCount = 3;
    level.waypoints[50].children[0] = 49;
    level.waypoints[50].children[1] = 51;
    level.waypoints[50].children[2] = 3;
    level.waypoints[51] = spawnstruct();
    level.waypoints[51].origin = (-1313.43,-1206.43,0.125);
    level.waypoints[51].type = "stand";
    level.waypoints[51].childCount = 2;
    level.waypoints[51].children[0] = 52;
    level.waypoints[51].children[1] = 50;
    level.waypoints[52] = spawnstruct();
    level.waypoints[52].origin = (-1307.81,-1014.74,0.125);
    level.waypoints[52].type = "stand";
    level.waypoints[52].childCount = 4;
    level.waypoints[52].children[0] = 53;
    level.waypoints[52].children[1] = 51;
    level.waypoints[52].children[2] = 58;
    level.waypoints[52].children[3] = 60;
    level.waypoints[53] = spawnstruct();
    level.waypoints[53].origin = (-1483.79,-1014.82,0.125);
    level.waypoints[53].type = "stand";
    level.waypoints[53].childCount = 2;
    level.waypoints[53].children[0] = 52;
    level.waypoints[53].children[1] = 83;
    level.waypoints[54] = spawnstruct();
    level.waypoints[54].origin = (-1572.34,-1329.77,0.125);
    level.waypoints[54].type = "stand";
    level.waypoints[54].childCount = 2;
    level.waypoints[54].children[0] = 55;
    level.waypoints[54].children[1] = 3;
    level.waypoints[55] = spawnstruct();
    level.waypoints[55].origin = (-1709.64,-1392.6,0.125);
    level.waypoints[55].type = "stand";
    level.waypoints[55].childCount = 2;
    level.waypoints[55].children[0] = 56;
    level.waypoints[55].children[1] = 54;
    level.waypoints[56] = spawnstruct();
    level.waypoints[56].origin = (-1738.74,-1476.7,0.125);
    level.waypoints[56].type = "stand";
    level.waypoints[56].childCount = 2;
    level.waypoints[56].children[0] = 57;
    level.waypoints[56].children[1] = 55;
    level.waypoints[57] = spawnstruct();
    level.waypoints[57].origin = (-1579.78,-1624.29,0.125);
    level.waypoints[57].type = "stand";
    level.waypoints[57].childCount = 2;
    level.waypoints[57].children[0] = 48;
    level.waypoints[57].children[1] = 56;
    level.waypoints[58] = spawnstruct();
    level.waypoints[58].origin = (-996.591,-1015.93,0.125);
    level.waypoints[58].type = "stand";
    level.waypoints[58].childCount = 2;
    level.waypoints[58].children[0] = 59;
    level.waypoints[58].children[1] = 52;
    level.waypoints[59] = spawnstruct();
    level.waypoints[59].origin = (-786.14,-1016.04,0.125);
    level.waypoints[59].type = "stand";
    level.waypoints[59].childCount = 4;
    level.waypoints[59].children[0] = 34;
    level.waypoints[59].children[1] = 58;
    level.waypoints[59].children[2] = 61;
    level.waypoints[59].children[3] = 69;
    level.waypoints[60] = spawnstruct();
    level.waypoints[60].origin = (-1191.76,-837.307,0.125);
    level.waypoints[60].type = "stand";
    level.waypoints[60].childCount = 2;
    level.waypoints[60].children[0] = 61;
    level.waypoints[60].children[1] = 52;
    level.waypoints[61] = spawnstruct();
    level.waypoints[61].origin = (-966.483,-813.714,0.125);
    level.waypoints[61].type = "stand";
    level.waypoints[61].childCount = 3;
    level.waypoints[61].children[0] = 60;
    level.waypoints[61].children[1] = 59;
    level.waypoints[61].children[2] = 62;
    level.waypoints[62] = spawnstruct();
    level.waypoints[62].origin = (-796.649,-823.916,0.125);
    level.waypoints[62].type = "stand";
    level.waypoints[62].childCount = 2;
    level.waypoints[62].children[0] = 27;
    level.waypoints[62].children[1] = 61;
    level.waypoints[63] = spawnstruct();
    level.waypoints[63].origin = (-404.361,-1023.62,36.125);
    level.waypoints[63].type = "stand";
    level.waypoints[63].childCount = 2;
    level.waypoints[63].children[0] = 64;
    level.waypoints[63].children[1] = 34;
    level.waypoints[64] = spawnstruct();
    level.waypoints[64].origin = (-216.792,-1003.38,36.125);
    level.waypoints[64].type = "stand";
    level.waypoints[64].childCount = 3;
    level.waypoints[64].children[0] = 66;
    level.waypoints[64].children[1] = 65;
    level.waypoints[64].children[2] = 63;
    level.waypoints[65] = spawnstruct();
    level.waypoints[65].origin = (-21.6785,-1002.2,36.125);
    level.waypoints[65].type = "stand";
    level.waypoints[65].childCount = 1;
    level.waypoints[65].children[0] = 64;
    level.waypoints[66] = spawnstruct();
    level.waypoints[66].origin = (-272.29,-1241.29,36.125);
    level.waypoints[66].type = "stand";
    level.waypoints[66].childCount = 4;
    level.waypoints[66].children[0] = 67;
    level.waypoints[66].children[1] = 5;
    level.waypoints[66].children[2] = 4;
    level.waypoints[66].children[3] = 64;
    level.waypoints[67] = spawnstruct();
    level.waypoints[67].origin = (-58.5515,-1269.57,36.125);
    level.waypoints[67].type = "stand";
    level.waypoints[67].childCount = 2;
    level.waypoints[67].children[0] = 68;
    level.waypoints[67].children[1] = 66;
    level.waypoints[68] = spawnstruct();
    level.waypoints[68].origin = (238.357,-1295.33,0.125002);
    level.waypoints[68].type = "stand";
    level.waypoints[68].childCount = 2;
    level.waypoints[68].children[0] = 22;
    level.waypoints[68].children[1] = 67;
    level.waypoints[69] = spawnstruct();
    level.waypoints[69].origin = (-754.837,-1332.26,0.125001);
    level.waypoints[69].type = "stand";
    level.waypoints[69].childCount = 3;
    level.waypoints[69].children[0] = 59;
    level.waypoints[69].children[1] = 36;
    level.waypoints[69].children[2] = 35;
    level.waypoints[70] = spawnstruct();
    level.waypoints[70].origin = (117.173,-1040.95,108.125);
    level.waypoints[70].type = "stand";
    level.waypoints[70].childCount = 3;
    level.waypoints[70].children[0] = 71;
    level.waypoints[70].children[1] = 20;
    level.waypoints[70].children[2] = 19;
    level.waypoints[71] = spawnstruct();
    level.waypoints[71].origin = (-59.2656,-1052.33,180.125);
    level.waypoints[71].type = "stand";
    level.waypoints[71].childCount = 3;
    level.waypoints[71].children[0] = 74;
    level.waypoints[71].children[1] = 75;
    level.waypoints[71].children[2] = 70;
    level.waypoints[72] = spawnstruct();
    level.waypoints[72].origin = (-340.101,-1349.21,180.125);
    level.waypoints[72].type = "stand";
    level.waypoints[72].childCount = 2;
    level.waypoints[72].children[0] = 76;
    level.waypoints[72].children[1] = 73;
    level.waypoints[73] = spawnstruct();
    level.waypoints[73].origin = (-380.242,-1017.22,180.125);
    level.waypoints[73].type = "stand";
    level.waypoints[73].childCount = 3;
    level.waypoints[73].children[0] = 74;
    level.waypoints[73].children[1] = 72;
    level.waypoints[73].children[2] = 77;
    level.waypoints[74] = spawnstruct();
    level.waypoints[74].origin = (-190.678,-959.282,180.125);
    level.waypoints[74].type = "stand";
    level.waypoints[74].childCount = 3;
    level.waypoints[74].children[0] = 73;
    level.waypoints[74].children[1] = 71;
    level.waypoints[74].children[2] = 77;
    level.waypoints[75] = spawnstruct();
    level.waypoints[75].origin = (57.2067,-1237.34,180.125);
    level.waypoints[75].type = "stand";
    level.waypoints[75].childCount = 3;
    level.waypoints[75].children[0] = 71;
    level.waypoints[75].children[1] = 76;
    level.waypoints[75].children[2] = 77;
    level.waypoints[76] = spawnstruct();
    level.waypoints[76].origin = (-98.8406,-1354.88,180.125);
    level.waypoints[76].type = "stand";
    level.waypoints[76].childCount = 3;
    level.waypoints[76].children[0] = 75;
    level.waypoints[76].children[1] = 72;
    level.waypoints[76].children[2] = 77;
    level.waypoints[77] = spawnstruct();
    level.waypoints[77].origin = (-229.812,-1135.28,180.125);
    level.waypoints[77].type = "stand";
    level.waypoints[77].childCount = 4;
    level.waypoints[77].children[0] = 76;
    level.waypoints[77].children[1] = 74;
    level.waypoints[77].children[2] = 73;
    level.waypoints[77].children[3] = 75;
    level.waypoints[78] = spawnstruct();
    level.waypoints[78].origin = (353.138,-2047.31,36.125);
    level.waypoints[78].type = "stand";
    level.waypoints[78].childCount = 2;
    level.waypoints[78].children[0] = 6;
    level.waypoints[78].children[1] = 7;
    level.waypoints[79] = spawnstruct();
    level.waypoints[79].origin = (353.721,-2189.93,36.125);
    level.waypoints[79].type = "stand";
    level.waypoints[79].childCount = 3;
    level.waypoints[79].children[0] = 8;
    level.waypoints[79].children[1] = 9;
    level.waypoints[79].children[2] = 7;
    level.waypoints[80] = spawnstruct();
    level.waypoints[80].origin = (539.343,-2183.62,90.125);
    level.waypoints[80].type = "stand";
    level.waypoints[80].childCount = 2;
    level.waypoints[80].children[0] = 81;
    level.waypoints[80].children[1] = 8;
    level.waypoints[81] = spawnstruct();
    level.waypoints[81].origin = (676.939,-2186.3,180.125);
    level.waypoints[81].type = "stand";
    level.waypoints[81].childCount = 2;
    level.waypoints[81].children[0] = 82;
    level.waypoints[81].children[1] = 80;
    level.waypoints[82] = spawnstruct();
    level.waypoints[82].origin = (677.666,-2078.7,180.125);
    level.waypoints[82].type = "stand";
    level.waypoints[82].childCount = 1;
    level.waypoints[82].children[0] = 81;
    level.waypoints[83] = spawnstruct();
    level.waypoints[83].origin = (-1636.21,-1017.53,0.125001);
    level.waypoints[83].type = "stand";
    level.waypoints[83].childCount = 4;
    level.waypoints[83].children[0] = 53;
    level.waypoints[83].children[1] = 16;
    level.waypoints[83].children[2] = 15;
    level.waypoints[83].children[3] = 93;
    level.waypoints[84] = spawnstruct();
    level.waypoints[84].origin = (-1585.14,-1080.37,216.125);
    level.waypoints[84].type = "stand";
    level.waypoints[84].childCount = 5;
    level.waypoints[84].children[0] = 2;
    level.waypoints[84].children[1] = 88;
    level.waypoints[84].children[2] = 1;
    level.waypoints[84].children[3] = 85;
    level.waypoints[84].children[4] = 89;
    level.waypoints[85] = spawnstruct();
    level.waypoints[85].origin = (-1678.98,-855.407,216.125);
    level.waypoints[85].type = "stand";
    level.waypoints[85].childCount = 4;
    level.waypoints[85].children[0] = 86;
    level.waypoints[85].children[1] = 1;
    level.waypoints[85].children[2] = 87;
    level.waypoints[85].children[3] = 84;
    level.waypoints[86] = spawnstruct();
    level.waypoints[86].origin = (-1897.35,-834.463,216.125);
    level.waypoints[86].type = "stand";
    level.waypoints[86].childCount = 2;
    level.waypoints[86].children[0] = 85;
    level.waypoints[86].children[1] = 87;
    level.waypoints[87] = spawnstruct();
    level.waypoints[87].origin = (-1877.87,-974.647,216.125);
    level.waypoints[87].type = "stand";
    level.waypoints[87].childCount = 3;
    level.waypoints[87].children[0] = 88;
    level.waypoints[87].children[1] = 86;
    level.waypoints[87].children[2] = 85;
    level.waypoints[88] = spawnstruct();
    level.waypoints[88].origin = (-1877.91,-1048.36,216.125);
    level.waypoints[88].type = "stand";
    level.waypoints[88].childCount = 3;
    level.waypoints[88].children[0] = 87;
    level.waypoints[88].children[1] = 0;
    level.waypoints[88].children[2] = 84;
    level.waypoints[89] = spawnstruct();
    level.waypoints[89].origin = (-1520.3,-1018.54,216.125);
    level.waypoints[89].type = "stand";
    level.waypoints[89].childCount = 2;
    level.waypoints[89].children[0] = 84;
    level.waypoints[89].children[1] = 90;
    level.waypoints[90] = spawnstruct();
    level.waypoints[90].origin = (-1403.71,-1018.99,216.125);
    level.waypoints[90].type = "stand";
    level.waypoints[90].childCount = 3;
    level.waypoints[90].children[0] = 89;
    level.waypoints[90].children[1] = 91;
    level.waypoints[90].children[2] = 92;
    level.waypoints[91] = spawnstruct();
    level.waypoints[91].origin = (-1381.34,-926.864,216.125);
    level.waypoints[91].type = "stand";
    level.waypoints[91].childCount = 1;
    level.waypoints[91].children[0] = 90;
    level.waypoints[92] = spawnstruct();
    level.waypoints[92].origin = (-1377.49,-1106.87,216.125);
    level.waypoints[92].type = "stand";
    level.waypoints[92].childCount = 1;
    level.waypoints[92].children[0] = 90;
    level.waypoints[93] = spawnstruct();
    level.waypoints[93].origin = (-1874.3,-1025.82,0.125);
    level.waypoints[93].type = "stand";
    level.waypoints[93].childCount = 1;
    level.waypoints[93].children[0] = 83;
 
    level.waypointCount = level.waypoints.size;
 
}