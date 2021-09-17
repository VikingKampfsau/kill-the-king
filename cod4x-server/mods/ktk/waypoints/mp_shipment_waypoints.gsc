// =========================================================================================
// File Name = 'mp_shipment_waypoints.gsc'
// Map Name  = 'mp_shipment'
// =========================================================================================
// 
// This is an auto generated script file created by the PeZBOT Mod - DO NOT MODIFY!
// 
// =========================================================================================
// 
// This file contains the waypoints for the map 'mp_shipment'.
// 
// You now need to save this file as the file name at the top of this file.
// in the 'waypoint.iwd' file in a folder called the same as the map name.
// Delete the first two lines of this file and the 'dvar set logfile 0' at the end of the file.
// Create the new folder if you havent already done so and rename it to the map name.
// So - new_waypoints.iwd/mp_shipment_waypoints.gsc
// 
// you now need to edit the file 'select_map.gsc' in the btd_waypoints folder if you havent already.
// just follow the instructions at the top of the file. you will need to add the following code.
// I couldnt output double quotes to file so replace the single quotes with double quotes.
// Also i couldnt output back slashs to file so replace the forward slashs with back slashs.
/*
 
    else if(mapname == 'mp_shipment')
    {
        thread Waypoints/mp_shipment_waypoints::load_waypoints();
    }
 
*/ 
// =========================================================================================
 
load_waypoints()
{
 
    level.waypoints[0] = spawnstruct();
    level.waypoints[0].origin = (-1.7,406.3,192);
    level.waypoints[0].type = "stand";
    level.waypoints[0].childCount = 4;
    level.waypoints[0].children[0] = 6;
    level.waypoints[0].children[1] = 19;
    level.waypoints[0].children[2] = 3;
    level.waypoints[0].children[3] = 27;
    level.waypoints[1] = spawnstruct();
    level.waypoints[1].origin = (-686,278.79,202.6);
    level.waypoints[1].type = "stand";
    level.waypoints[1].childCount = 3;
    level.waypoints[1].children[0] = 3;
    level.waypoints[1].children[1] = 2;
    level.waypoints[1].children[2] = 28;
    level.waypoints[2] = spawnstruct();
    level.waypoints[2].origin = (-669,706.1,193);
    level.waypoints[2].type = "stand";
    level.waypoints[2].childCount = 2;
    level.waypoints[2].children[0] = 1;
    level.waypoints[2].children[1] = 4;
    level.waypoints[3] = spawnstruct();
    level.waypoints[3].origin = (-442.2,384.5,194.2);
    level.waypoints[3].type = "stand";
    level.waypoints[3].childCount = 6;
    level.waypoints[3].children[0] = 1;
    level.waypoints[3].children[1] = 4;
    level.waypoints[3].children[2] = 0;
    level.waypoints[3].children[3] = 16;
    level.waypoints[3].children[4] = 27;
    level.waypoints[3].children[5] = 28;
    level.waypoints[4] = spawnstruct();
    level.waypoints[4].origin = (-127.28,730.6,193.6);
    level.waypoints[4].type = "stand";
    level.waypoints[4].childCount = 3;
    level.waypoints[4].children[0] = 3;
    level.waypoints[4].children[1] = 2;
    level.waypoints[4].children[2] = 32;
    level.waypoints[5] = spawnstruct();
    level.waypoints[5].origin = (208.3,586.4,197.1);
    level.waypoints[5].type = "stand";
    level.waypoints[5].childCount = 3;
    level.waypoints[5].children[0] = 6;
    level.waypoints[5].children[1] = 4;
    level.waypoints[5].children[2] = 35;
    level.waypoints[6] = spawnstruct();
    level.waypoints[6].origin = (450.1,385.7,192);
    level.waypoints[6].type = "stand";
    level.waypoints[6].childCount = 5;
    level.waypoints[6].children[0] = 7;
    level.waypoints[6].children[1] = 0;
    level.waypoints[6].children[2] = 5;
    level.waypoints[6].children[3] = 20;
    level.waypoints[6].children[4] = 25;
    level.waypoints[7] = spawnstruct();
    level.waypoints[7].origin = (401.8,57.6,192);
    level.waypoints[7].type = "stand";
    level.waypoints[7].childCount = 4;
    level.waypoints[7].children[0] = 6;
    level.waypoints[7].children[1] = 18;
    level.waypoints[7].children[2] = 8;
    level.waypoints[7].children[3] = 21;
    level.waypoints[8] = spawnstruct();
    level.waypoints[8].origin = (455.4,-314,193.2);
    level.waypoints[8].type = "stand";
    level.waypoints[8].childCount = 5;
    level.waypoints[8].children[0] = 7;
    level.waypoints[8].children[1] = 17;
    level.waypoints[8].children[2] = 9;
    level.waypoints[8].children[3] = 21;
    level.waypoints[8].children[4] = 22;
    level.waypoints[9] = spawnstruct();
    level.waypoints[9].origin = (175.7,-495.7,192.6);
    level.waypoints[9].type = "stand";
    level.waypoints[9].childCount = 4;
    level.waypoints[9].children[0] = 8;
    level.waypoints[9].children[1] = 10;
    level.waypoints[9].children[2] = 24;
    level.waypoints[9].children[3] = 34;
    level.waypoints[10] = spawnstruct();
    level.waypoints[10].origin = (-190.9,-591.4,195.8);
    level.waypoints[10].type = "stand";
    level.waypoints[10].childCount = 3;
    level.waypoints[10].children[0] = 13;
    level.waypoints[10].children[1] = 11;
    level.waypoints[10].children[2] = 9;
    level.waypoints[11] = spawnstruct();
    level.waypoints[11].origin = (-556,-576.4,191);
    level.waypoints[11].type = "stand";
    level.waypoints[11].childCount = 3;
    level.waypoints[11].children[0] = 10;
    level.waypoints[11].children[1] = 13;
    level.waypoints[11].children[2] = 12;
    level.waypoints[12] = spawnstruct();
    level.waypoints[12].origin = (-704.1,-302.7,192.5);
    level.waypoints[12].type = "stand";
    level.waypoints[12].childCount = 2;
    level.waypoints[12].children[0] = 11;
    level.waypoints[12].children[1] = 14;
    level.waypoints[13] = spawnstruct();
    level.waypoints[13].origin = (-342.8,-318,197.7);
    level.waypoints[13].type = "stand";
    level.waypoints[13].childCount = 4;
    level.waypoints[13].children[0] = 17;
    level.waypoints[13].children[1] = 10;
    level.waypoints[13].children[2] = 11;
    level.waypoints[13].children[3] = 15;
    level.waypoints[14] = spawnstruct();
    level.waypoints[14].origin = (-600.6,-110.9,195.1);
    level.waypoints[14].type = "stand";
    level.waypoints[14].childCount = 3;
    level.waypoints[14].children[0] = 15;
    level.waypoints[14].children[1] = 12;
    level.waypoints[14].children[2] = 30;
    level.waypoints[15] = spawnstruct();
    level.waypoints[15].origin = (-476.7,-108.5,192);
    level.waypoints[15].type = "stand";
    level.waypoints[15].childCount = 3;
    level.waypoints[15].children[0] = 13;
    level.waypoints[15].children[1] = 14;
    level.waypoints[15].children[2] = 16;
    level.waypoints[16] = spawnstruct();
    level.waypoints[16].origin = (-453.6,68.1,192);
    level.waypoints[16].type = "stand";
    level.waypoints[16].childCount = 4;
    level.waypoints[16].children[0] = 3;
    level.waypoints[16].children[1] = 18;
    level.waypoints[16].children[2] = 15;
    level.waypoints[16].children[3] = 28;
    level.waypoints[17] = spawnstruct();
    level.waypoints[17].origin = (-3.1,-299.5,192.7);
    level.waypoints[17].type = "stand";
    level.waypoints[17].childCount = 3;
    level.waypoints[17].children[0] = 18;
    level.waypoints[17].children[1] = 8;
    level.waypoints[17].children[2] = 13;
    level.waypoints[18] = spawnstruct();
    level.waypoints[18].origin = (2.67,73.4,192);
    level.waypoints[18].type = "stand";
    level.waypoints[18].childCount = 4;
    level.waypoints[18].children[0] = 19;
    level.waypoints[18].children[1] = 7;
    level.waypoints[18].children[2] = 17;
    level.waypoints[18].children[3] = 16;
    level.waypoints[19] = spawnstruct();
    level.waypoints[19].origin = (1.2,186.5,193.4);
    level.waypoints[19].type = "stand";
    level.waypoints[19].childCount = 3;
    level.waypoints[19].children[0] = 0;
    level.waypoints[19].children[1] = 18;
    level.waypoints[19].children[2] = 31;
    level.waypoints[20] = spawnstruct();
    level.waypoints[20].origin = (689.9,268.9,192);
    level.waypoints[20].type = "stand";
    level.waypoints[20].childCount = 3;
    level.waypoints[20].children[0] = 6;
    level.waypoints[20].children[1] = 26;
    level.waypoints[20].children[2] = 29;
    level.waypoints[21] = spawnstruct();
    level.waypoints[21].origin = (518.984,-73.7115,192.077);
    level.waypoints[21].type = "stand";
    level.waypoints[21].childCount = 3;
    level.waypoints[21].children[0] = 7;
    level.waypoints[21].children[1] = 8;
    level.waypoints[21].children[2] = 33;
    level.waypoints[22] = spawnstruct();
    level.waypoints[22].origin = (666.767,-411.292,193.342);
    level.waypoints[22].type = "stand";
    level.waypoints[22].childCount = 3;
    level.waypoints[22].children[0] = 23;
    level.waypoints[22].children[1] = 8;
    level.waypoints[22].children[2] = 33;
    level.waypoints[23] = spawnstruct();
    level.waypoints[23].origin = (641.034,-594.69,193.007);
    level.waypoints[23].type = "stand";
    level.waypoints[23].childCount = 2;
    level.waypoints[23].children[0] = 24;
    level.waypoints[23].children[1] = 22;
    level.waypoints[24] = spawnstruct();
    level.waypoints[24].origin = (314.922,-568.756,195.837);
    level.waypoints[24].type = "stand";
    level.waypoints[24].childCount = 2;
    level.waypoints[24].children[0] = 23;
    level.waypoints[24].children[1] = 9;
    level.waypoints[25] = spawnstruct();
    level.waypoints[25].origin = (511.787,726.464,192.077);
    level.waypoints[25].type = "stand";
    level.waypoints[25].childCount = 3;
    level.waypoints[25].children[0] = 6;
    level.waypoints[25].children[1] = 26;
    level.waypoints[25].children[2] = 35;
    level.waypoints[26] = spawnstruct();
    level.waypoints[26].origin = (660.866,688.142,192.077);
    level.waypoints[26].type = "stand";
    level.waypoints[26].childCount = 2;
    level.waypoints[26].children[0] = 25;
    level.waypoints[26].children[1] = 20;
    level.waypoints[27] = spawnstruct();
    level.waypoints[27].origin = (-185.714,460.091,192.077);
    level.waypoints[27].type = "stand";
    level.waypoints[27].childCount = 3;
    level.waypoints[27].children[0] = 0;
    level.waypoints[27].children[1] = 3;
    level.waypoints[27].children[2] = 32;
    level.waypoints[28] = spawnstruct();
    level.waypoints[28].origin = (-530.823,242.686,192.326);
    level.waypoints[28].type = "stand";
    level.waypoints[28].childCount = 3;
    level.waypoints[28].children[0] = 1;
    level.waypoints[28].children[1] = 3;
    level.waypoints[28].children[2] = 16;
    level.waypoints[29] = spawnstruct();
    level.waypoints[29].origin = (711.228,25.2176,201.125);
    level.waypoints[29].type = "stand";
    level.waypoints[29].childCount = 1;
    level.waypoints[29].children[0] = 20;
    level.waypoints[30] = spawnstruct();
    level.waypoints[30].origin = (-639.7,137.441,201.125);
    level.waypoints[30].type = "stand";
    level.waypoints[30].childCount = 1;
    level.waypoints[30].children[0] = 14;
    level.waypoints[31] = spawnstruct();
    level.waypoints[31].origin = (257.357,148.73,201.125);
    level.waypoints[31].type = "stand";
    level.waypoints[31].childCount = 1;
    level.waypoints[31].children[0] = 19;
    level.waypoints[32] = spawnstruct();
    level.waypoints[32].origin = (-156.114,617.657,194.681);
    level.waypoints[32].type = "stand";
    level.waypoints[32].childCount = 2;
    level.waypoints[32].children[0] = 4;
    level.waypoints[32].children[1] = 27;
    level.waypoints[33] = spawnstruct();
    level.waypoints[33].origin = (656.389,-108.257,192.558);
    level.waypoints[33].type = "stand";
    level.waypoints[33].childCount = 2;
    level.waypoints[33].children[0] = 21;
    level.waypoints[33].children[1] = 22;
    level.waypoints[34] = spawnstruct();
    level.waypoints[34].origin = (172.465,-598.946,193.226);
    level.waypoints[34].type = "stand";
    level.waypoints[34].childCount = 1;
    level.waypoints[34].children[0] = 9;
    level.waypoints[35] = spawnstruct();
    level.waypoints[35].origin = (252.991,749.713,197.697);
    level.waypoints[35].type = "stand";
    level.waypoints[35].childCount = 2;
    level.waypoints[35].children[0] = 5;
    level.waypoints[35].children[1] = 25;
 
    level.waypointCount = level.waypoints.size;
}