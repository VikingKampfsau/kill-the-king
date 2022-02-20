/**
 * HELIPATH
 * 
 * This script implements run time generation of helicopter paths
 * for Call of Duty 4 mods and maps. It can be used to add helicopter
 * paths to maps that do not have a helicopter path build in. 
 *
 * For mod creators:
 * 
 * Mod creators should call the init function in this file.
 * This function should be called early in the mod initialization,
 * at least before the initialization of kill streaks that make use
 * of a helicopter path.   
 * The dvar scr_create_helipath must be set to "1" to enable the script.
 * Mod creators can extend the script config section of the init function
 * with map specific options to optimize or disable the creation of helicopter
 * paths. The dvar dynamic_helipath will be set to "enabled" when this script
 * has succesfully created a helicopter path and will otherwise state the reason
 * why it did not create a helicopter path.
 * 
 * For mappers:
 * 
 * Mappers should directly call the helipath_create function.
 * In its simplest form no arguments have to be specified, i.e. just call
 * helipath_create(). This will almost always result in a proper helicopter
 * path. Using the parameters of the function one can fine tune the helicopter
 * path. See the comments above the helipath_create function for a detailed
 * overview of the parameters. Please note that there must be enough distance
 * between the highest obstacle in the map and the skybox roof to support
 * the helicopter. An absolute recommended minimum is 500 units.
 * 
 * To do:
 *   - When calculating a collision free height of the helicopter path,
 *     it only checks for collisions on the circle path, not the approach and
 *     crash paths. It is desirable that at least the approach path is also
 *     checked for collisions.
 *   - When calculating a collission free height of the helicopter path and
 *     after encountering obstacles it will always use the smallest collision
 *     free height. It may be desirable to create a larger distance between
 *     the heighest obstacle and the helicopter when there is room.    
 *   - The angle of the approach paths are fixed (north, west, south).
 *     It is desirable that specific angles can be given for the three
 *     approach paths.
 * 
 *  Author: Bianco Zandbergen
 *  
 *  Release history:
 *    17 August 2013   -   initial release
 *    
 *  License:
 *    The code in this file can be used in non commercial mods or maps
 *    for the Call of Duty 4 game without prior approval of the author.
 */


/**
 * Initialize the dynamic creation of helicopter paths for mods.
 * Checks whether a helicopter path should be created at all.
 * Cases in which no helicopter path should be created are in example
 * when the map already has a helicopter path or
 * when the dvar scr_create_helipath has not been set to "1".
 * It prepares the parameters to call the helipath_create function and
 * takes into account the options set in the script config section of this
 * function and the server config. It finally calls helipath_create and after
 * returns to maps\mp\_helicopter::init() to initialize the created helicopter path. 
 * 
 * The script config section of this function
 * should be used by the modder to add map specific options. They can be
 * overridden by the server owner using dvars in the server config (except
 * when a map is disabled in the script config).  
 * 
 * map specific dvar and script config names (prefixed with the full map name):
 *   mapname_hp               - disable a map by setting this to 0 (must be
 *                              integer when used in script config)   
 *   mapname_hp_x1            - set the x1 argument of helipath_create function
 *                              similarly, all names below set the values
 *                              corresponding with parameters in the
 *                              helipath_create function   
 *   mapname_hp_y1
 *   mapname_hp_x2
 *   mapname_hp_y2
 *   mapname_hp_zmax
 *   mapname_hp_zoffset
 *   mapname_hp_nodes
 *   mapname_hp_xradius_expand
 *   mapname_hp_yradius_expand
 *   mapname_hp_airspeed_approach
 *   mapname_hp_airspeed_circle
 *   mapname_hp_airspeed_crash
 *   mapname_hp_accel_approach
 *   mapname_hp_accel_circle
 *   mapname_hp_accel_crash
 *   mapname_hp_delay_circle
 *   
 * Parameters: none
 *  
 * Return: void
 */ 
init()
{
  //VIKING - I always want a helipath to be created if there is none!
  if(getDvarInt("scr_heli_enabled"))
    setDvar("scr_create_helipath" , 1);

  // ============ SCRIPT CONFIG ============
  // add hard coded map specific options here
  cfg = [];
  cfg["mp_fnrp_secret_base_hp"] = 0;
  // =======================================
  
  path_start = getentarray("heli_start",      "targetname");
  loop_start = getentarray("heli_loop_start", "targetname");
  
  mapname = getDvar("mapname");
  
  if(path_start.size || loop_start.size) {
    setDvar("dynamic_helipath", "map already has helipath");
    return;
  }
  
  if(getDvar("scr_create_helipath") != "1") {
    setDvar("dynamic_helipath", "dynamic helipath disabled in config");
    return;
  }
  
  if (isDefined(cfg[mapname+"_hp"])) {
    if (int(cfg[mapname+"_hp"]) == 0) {
      setDvar("dynamic_helipath", "map is disabled in script config");
      return;
    }
  }
  
  if (getDvar(mapname+"_hp") == "0") {
    setDvar("dynamic_helipath", "map is disabled in config");
    return;
  }
      
  if (is_indoor_map()) {
    setDvar("dynamic_helipath", "map is detected as in door map");
    return;
  }
  
  x1                = undefined; 
  y1                = undefined;
  x2                = undefined; 
  y2                = undefined;
  zmax              = undefined;
  zoffset           = undefined;
  nodes             = undefined;
  xradius_expand    = undefined;
  yradius_expand    = undefined;
  airspeed_approach = undefined;
  airspeed_circle   = undefined;
  airspeed_crash    = undefined;
  accel_approach    = undefined;
  accel_circle      = undefined;
  accel_crash       = undefined;
  delay_circle      = undefined;
  
  // check for settings in script config
  if (isDefined(cfg[mapname+"_hp_x1"]))                x1                = int(cfg[mapname+"_hp_x1"]);
  if (isDefined(cfg[mapname+"_hp_y1"]))                y1                = int(cfg[mapname+"_hp_y1"]);
  if (isDefined(cfg[mapname+"_hp_x2"]))                x2                = int(cfg[mapname+"_hp_x2"]);
  if (isDefined(cfg[mapname+"_hp_y2"]))                y2                = int(cfg[mapname+"_hp_y2"]);
  if (isDefined(cfg[mapname+"_hp_zmax"]))              zmax              = int(cfg[mapname+"_hp_zmax"]);
  if (isDefined(cfg[mapname+"_hp_zoffset"]))           zoffset           = int(cfg[mapname+"_hp_zoffset"]);
  if (isDefined(cfg[mapname+"_hp_nodes"]))             nodes             = int(cfg[mapname+"_hp_nodes"]);
  if (isDefined(cfg[mapname+"_hp_xradius_expand"]))    xradius_expand    = int(cfg[mapname+"_hp_xradius_expand"]);
  if (isDefined(cfg[mapname+"_hp_yradius_expand"]))    yradius_expand    = int(cfg[mapname+"_hp_yradius_expand"]);
  if (isDefined(cfg[mapname+"_hp_airspeed_approach"])) airspeed_approach = int(cfg[mapname+"_hp_airspeed_approach"]);
  if (isDefined(cfg[mapname+"_hp_airspeed_circle"]))   airspeed_circle   = int(cfg[mapname+"_hp_airspeed_circle"]);
  if (isDefined(cfg[mapname+"_hp_airspeed_crash"]))    airspeed_crash    = int(cfg[mapname+"_hp_airspeed_crash"]);
  if (isDefined(cfg[mapname+"_hp_accel_approach"]))    accel_approach    = int(cfg[mapname+"_hp_accel_approach"]);
  if (isDefined(cfg[mapname+"_hp_accel_circle"]))      accel_circle      = int(cfg[mapname+"_hp_accel_circle"]);
  if (isDefined(cfg[mapname+"_hp_accel_crash"]))       accel_crash       = int(cfg[mapname+"_hp_accel_crash"]);
  if (isDefined(cfg[mapname+"_hp_delay_circle"]))      delay_circle      = int(cfg[mapname+"_hp_delay_circle"]);
  
  // check for settings in server config (overrides script config)
  if (getDvar(mapname+"_hp_x1") != "")                 x1                = getDvarInt(mapname+"_hp_x1");
  if (getDvar(mapname+"_hp_y1") != "")                 y1                = getDvarInt(mapname+"_hp_y1");
  if (getDvar(mapname+"_hp_x2") != "")                 x2                = getDvarInt(mapname+"_hp_x2");
  if (getDvar(mapname+"_hp_y2") != "")                 y2                = getDvarInt(mapname+"_hp_y2");
  if (getDvar(mapname+"_hp_zmax") != "")               zmax              = getDvarInt(mapname+"_hp_zmax");
  if (getDvar(mapname+"_hp_zoffset") != "")            zoffset           = getDvarInt(mapname+"_hp_zoffset");
  if (getDvar(mapname+"_hp_nodes") != "")              nodes             = getDvarInt(mapname+"_hp_nodes");
  if (getDvar(mapname+"_hp_xradius_expand") != "")     xradius_expand    = getDvarInt(mapname+"_hp_xradius_expand");
  if (getDvar(mapname+"_hp_yradius_expand") != "")     yradius_expand    = getDvarInt(mapname+"_hp_yradius_expand");
  if (getDvar(mapname+"_hp_airspeed_approach") != "")  airspeed_approach = getDvarInt(mapname+"_hp_airspeed_approach");
  if (getDvar(mapname+"_hp_airspeed_circle") != "")    airspeed_circle   = getDvarInt(mapname+"_hp_airspeed_circle");
  if (getDvar(mapname+"_hp_airspeed_crash") != "")     airspeed_crash    = getDvarInt(mapname+"_hp_airspeed_crash");
  if (getDvar(mapname+"_hp_accel_approach") != "")     accel_approach    = getDvarInt(mapname+"_hp_accel_approach");
  if (getDvar(mapname+"_hp_accel_circle") != "")       accel_circle      = getDvarInt(mapname+"_hp_accel_circle");
  if (getDvar(mapname+"_hp_accel_crash") != "")        accel_crash       = getDvarInt(mapname+"_hp_accel_crash");
  if (getDvar(mapname+"_hp_delay_circle") != "")       delay_circle      = getDvarInt(mapname+"_hp_delay_circle");
  
  result = helipath_create(x1, y1,
                           x2, y2,
                           zmax,
                           zoffset,
                           nodes,
                           xradius_expand,
                           yradius_expand,
                           airspeed_approach,
                           airspeed_circle,
                           airspeed_crash,
                           accel_approach,
                           accel_circle,
                           accel_crash,
                           delay_circle);
  resetTimeout();
  
  if(result)
    setDvar("dynamic_helipath", "enabled");
  else
    setDvar("dynamic_helipath", "disabled");  
}

/**
 * Create the helicopter path using the given arguments.
 * Use default values or estimations of optimal default values for missing
 * arguments. The generated helicopter circle path has an ellipse shape
 * bounded by the rectangle of which the coordinates are supplied from two
 * diagonal opposite corners (like minimap corners).  
 * 
 * Parameters: 
 *   x1      - x value of first corner (similar to minimap corners)
 *   y1      - y value of first corner
 *   x2      - x value if second corner (diagonal opposite of rectangle)
 *   y2      - y value of second corner
 *   zmax    - maximum z value of playable area (i.e max z value of spawns)
 *   
 *     if any of x1, y1, x2, y2, zmax is not defined, all five values will be
 *     estimated.
 *         
 *   zoffset - offset added to zmax for the height of the helicopter path
 *             if undefined the value will be estimated
 *             in the case that an offset that will result into a collission 
 *             free helicopter path cannot be found, the creation of the 
 *             helicopter path will be aborted     
 *   nodes   - number of nodes in the helicopter circle path
 *             the value of 8 will be used when undefined
 *   xradius_expand    - units to expand the ellipse radius in the x direction
 *                       (can be a negative value to contract)
 *                       the value of -100 will be used when undefined 
 *   yradius_expand    - units to expand the ellipse radius in the y direction
 *                       (can be a negative value to contract)
 *                       the value of -100 will be used when undefined 
 *   airspeed_approach - script airspeed for approach path
 *                       the value of 50 will be used when undefined 
 *   airspeed_circle   - script airspeed for circle path
 *                       the value of 40 will be used when undefined 
 *   airspeed_crash    - script airspeed for crash path
 *                       the value of 60 will be used when undefined 
 *   accel_approach    - script acceleration for approach path
 *                       the value of 20 will be used when undefined 
 *   accel_circle      - script acceleration for circle path
 *                       the value of 15 will be used when undefined 
 *   accel_crash       - script acceleration for crash path
 *                       the value of 30 will be used when undefined 
 *   delay_circle      - script delay, time in seconds that the helicopter has
 *                       to hoover above each node
 *                       the value of 3 will be used when undefined
 *                       
 * Return: true when it has succesfully created a helicopter path, false otherwise
 *         it currently only returns false when no collision free zoffset can
 *         be found when estimation is used because the distance between the
 *         heighest obstacle and the roof of the skybox is too small
 */
helipath_create(x1, y1,
                x2, y2,
                zmax,
                zoffset,
                nodes,
                xradius_expand,
                yradius_expand,
                airspeed_approach,
                airspeed_circle,
                airspeed_crash,
                accel_approach,
                accel_circle,
                accel_crash,
                delay_circle)
{  
  // Declarations to ensure these variables are in the scope
  xmax = undefined; ymax = undefined;
  xmin = undefined; ymin = undefined;
  
  // parameter sanity checks  
  if (!isDefined(x1) || !isDefined(y1) ||
      !isDefined(x2) || !isDefined(y2) || !isDefined(zmax)) {
    // map size not defined, estimate it
    s    = estimate_map_size();
    xmin = s.xmin; xmax = s.xmax; ymin = s.ymin; ymax = s.ymax; zmax = s.zmax;  
  } else {
    // map size defined
    if (x1 < x2) { xmin = x1; xmax = x2; }
    else         { xmax = x1; xmin = x2; }
    if (y1 < y2) { ymin = y1; ymax = y2; }
    else         { ymax = y1; ymin = y2; }
  }
  
  // default values for most parameters
  if (!isDefined(nodes))             nodes             = 8;
  if (!isDefined(xradius_expand))    xradius_expand    = -100;
  if (!isDefined(yradius_expand))    yradius_expand    = -100;
  if (!isDefined(airspeed_approach)) airspeed_approach = 50;
  if (!isDefined(airspeed_circle))   airspeed_circle   = 40;
  if (!isDefined(airspeed_crash))    airspeed_crash    = 60;
  if (!isDefined(accel_approach))    accel_approach    = 20;
  if (!isDefined(accel_circle))      accel_circle      = 15;
  if (!isDefined(accel_crash))       accel_crash       = 30;
  if (!isDefined(delay_circle))      delay_circle      = 3;
  
  xradius = ((xmax - xmin)/2) + xradius_expand;
  yradius = ((ymax - ymin)/2) + yradius_expand;
  xcenter = xmin + ((xmax - xmin)/2);
  ycenter = ymin + ((ymax - ymin)/2);
  
  xoffset_approach = xradius;
  yoffset_approach = yradius;
  
  if (xradius_expand < 0) xoffset_approach = xradius - xradius_expand;
  if (yradius_expand < 0) yoffset_approach = yradius - yradius_expand;
  
  if (!isDefined(zoffset)) {
    zoffset = 750; // minimum offset
    
    zroof = get_roof_height();
    minheight = adjust_height_obstacles((zmax+zoffset),
                                        xcenter, ycenter, xradius, yradius);
    // adjust zoffset upwards to avoid obstacles
    if ((zmax+zoffset) < minheight)  zoffset = minheight - zmax;
    // adjust zoffset downwards to avoid colliding with the skybox roof
    if ((zmax+zoffset) > (zroof-75)) zoffset = zroof - 75 - zmax;
    
    // are we still high enough to avoid obstacles? abort if not...
    if ((zmax+zoffset) < (minheight-1)) {
      setDvar("dynamic_helipath", "not enough space between highest obstacle and skybox roof");
      return false;
    }
  }
  
  // create circle path nodes
  for (i = 1; i <= nodes; i++) {
    // calculate point on ellipse
    x = int(xcenter + (xradius * cos((360/nodes)*i) ));
    y = int(ycenter + (yradius * sin((360/nodes)*i) ));
    z = int(zmax+zoffset+100);
    
    // define target to ensure a closed loop
    if (i == nodes) target = "heli_path_circle1";
    else            target = "heli_path_circle" + (i+1);
    
    targetname = "heli_path_circle" + i;
    
    helipath_add_node((x, y, z), targetname, target,
                      airspeed_circle, accel_circle, delay_circle);
  }
  
  // create heli_loop_start node
  x          = xcenter;
  y          = ycenter;
  z          = (zmax+zoffset+50);
  targetname = "heli_loop_start";
  target     = "heli_path_circle" + nodes;
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_circle, accel_circle, undefined);
  
  // create approach center node
  x          = xcenter;
  y          = ycenter;
  z          = (zmax+zoffset);
  targetname = "heli_path_approach_center";
  target     = undefined;
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create heli_dest node
  x          = (xcenter-50);
  y          = (ycenter-50);
  z          = (zmax+zoffset);
  targetname = "heli_dest";
  target     = "heli_path_approach_center";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create heli_start approach node (north 1)
  x          = xcenter;
  y          = (ycenter+yoffset_approach+200);
  z          = (zmax+zoffset);
  targetname = "heli_start";
  target     = "heli_path_approach_north1";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create approach node (north 2)
  x          = xcenter;
  y          = (ycenter+yoffset_approach+150);
  z          = (zmax+zoffset);
  targetname = "heli_path_approach_north1";
  target     = "heli_path_approach_center";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create heli_start approach node (south 1)
  x          = xcenter;
  y          = (ycenter-yoffset_approach-200);
  z          = (zmax+zoffset);
  targetname = "heli_start";
  target     = "heli_path_approach_south1";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create approach node (south 2)
  x          = xcenter;
  y          = (ycenter-yoffset_approach-150);
  z          = (zmax+zoffset);
  targetname = "heli_path_approach_south1";
  target     = "heli_path_approach_center";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create heli_start approach node (west 1)
  x          = (xcenter-xoffset_approach-200);
  y          = ycenter;
  z          = (zmax+zoffset);
  targetname = "heli_start";
  target     = "heli_path_approach_west1";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create approach node (west 2)
  x          = (xcenter-xoffset_approach-150);
  y          = ycenter;
  z          = (zmax+zoffset);
  targetname = "heli_path_approach_west1";
  target     = "heli_path_approach_center";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_approach, accel_approach, undefined);
  
  // create heli_crash_start node
  x          = xcenter;
  y          = ycenter;
  z          = (zmax+zoffset+75);
  targetname = "heli_crash_start";
  target     = "heli_path_crash1";
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_crash, accel_crash, undefined);
  
  // create crash path final node
  x          = (xcenter+xradius+200);
  y          = (ycenter+yradius+200);
  z          = (zmax+zoffset);
  targetname = "heli_path_crash1";
  target     = undefined;
  helipath_add_node((x, y, z), targetname, target,
                    airspeed_crash, accel_crash, undefined);
  
  // create heli_leave nodes
  for (i = 0; i < 4; i++) {
    switch(i) {
      case 0: // north east
        x = (xcenter+xmax);
        y = (ycenter+ymax);
        break;
      case 1: // north west
        x = (xcenter-xmax);
        y = (ycenter+ymax);
        break;
      case 2: // south west
        x = (xcenter-xmax);
        y = (ycenter-ymax);
        break;
      default: // 3, south east
        x = (xcenter+xmax);
        y = (ycenter-ymax);
        break;
    }
    
    z          = (zmax+zoffset);
    targetname = "heli_leave";
    target     = undefined;
    helipath_add_node((x, y, z), targetname, target,
                      undefined, undefined, undefined);
  }
  
  return true; 
}

/**
 * Add a helicopter path node to the map.
 * 
 * Parameters: origin     - the origin of the added node
 *             targetname - the name of the node
 *             target     - the name of the next node
 *             airspeed   - script airspeed value
 *             accel      - script acceleration value
 *             delay      - script delay value
 *             
 * If for any of target, airspeed, accel, delay the value should not be set,
 * the value of undefined should be supplied as argument.
 * 
 * Return: void
 */
helipath_add_node(origin, targetname, target, airspeed, accel, delay)
{
  node = spawn("script_origin", origin);
  node.targetname = targetname;
  
  if (isdefined(target))   node.target          = target;
  if (isdefined(airspeed)) node.script_airspeed = airspeed;
  if (isdefined(accel))    node.script_accel    = accel;
  if (isdefined(delay))    node.script_delay    = delay;
}

/**
 * Tries to estimate map size using (when available) minimap corners,
 * spawns and game objects.
 * 
 * Parameters: none  
 * 
 * Return: A structure containing the largest x and y value found,
 *         the smallest x and y value found and the largest z value found.    
 */
estimate_map_size()
{
  size      =  spawnstruct();
  size.xmax =  0;
  size.xmin =  0;
  size.ymax =  0;
  size.ymin =  0;
  size.zmax =  0;
  
  spawns              = [];
  spawns[spawns.size] = "mp_dm_spawn";
  spawns[spawns.size] = "mp_dom_spawn";
  spawns[spawns.size] = "mp_dom_spawn_allies_start";
  spawns[spawns.size] = "mp_dom_spawn_axis_start";
  spawns[spawns.size] = "mp_sab_spawn_allies";
  spawns[spawns.size] = "mp_sab_spawn_allies_start";
  spawns[spawns.size] = "mp_sab_spawn_axis";
  spawns[spawns.size] = "mp_sab_spawn_axis_start";
  spawns[spawns.size] = "mp_sd_spawn_attacker";
  spawns[spawns.size] = "mp_sd_spawn_defender";
  spawns[spawns.size] = "mp_tdm_spawn";
  spawns[spawns.size] = "mp_tdm_spawn_allies_start";
  spawns[spawns.size] = "mp_tdm_spawn_axis_start";
  
  // trying to estimate using minimap corners
  ents = getEntArray("minimap_corner", "targetname");
  
  if (isDefined(ents) && ents.size == 2) {
    if (ents[0].origin[0] < ents[1].origin[0]) {
      size.xmin = ents[0].origin[0]; 
      size.xmax = ents[1].origin[0];
    } else { 
      size.xmax = ents[0].origin[0];
      size.xmin = ents[1].origin[0];
    }
    
    if (ents[0].origin[1] < ents[1].origin[1]) {
      size.ymin = ents[0].origin[1];
      size.ymax = ents[1].origin[1];
    } else { 
      size.ymax = ents[0].origin[1];
      size.ymin = ents[1].origin[1];
    }
  }
  
  ents = getEntArray();
  
  for (i = 0; i < ents.size; i++) {
    if (isDefined(ents[i].classname) && isDefined(ents[i].origin)) {
      check = false;
      
      // estimation using spawns
      for (j = 0; j < spawns.size; j++) {
        if (ents[i].classname == spawns[j]) {
          check = true;
          break;  
        }
      }
      
      // estimation using game objects
      if (isDefined(ents[i].script_gameobjectname)) {
        check = true;
      }
      
      if (check) {
        if (ents[i].origin[0] < size.xmin) size.xmin = ents[i].origin[0];
        if (ents[i].origin[0] > size.xmax) size.xmax = ents[i].origin[0];
        if (ents[i].origin[1] < size.ymin) size.ymin = ents[i].origin[1];
        if (ents[i].origin[1] > size.ymax) size.ymax = ents[i].origin[1];
        if (ents[i].origin[2] > size.zmax) size.zmax = ents[i].origin[2];
      }
    }
  }
  
  // estimation using waypoints could be added
  
  return size;
}


/**
 * Tries to determine whether a map is an in door map and thus cannot support
 * helicopters. A map is considered in door when none of the spawns and waypoints
 * checked have 750 units of collision free space above it.
 * 
 * Parameters: none  
 * 
 * Return: true when the map is determined as in door, false otherwise.
 */     
is_indoor_map()
{
  spawns              = [];
  spawns[spawns.size] = "mp_dm_spawn";
  spawns[spawns.size] = "mp_dom_spawn";
  spawns[spawns.size] = "mp_dom_spawn_allies_start";
  spawns[spawns.size] = "mp_dom_spawn_axis_start";
  spawns[spawns.size] = "mp_sab_spawn_allies";
  spawns[spawns.size] = "mp_sab_spawn_allies_start";
  spawns[spawns.size] = "mp_sab_spawn_axis";
  spawns[spawns.size] = "mp_sab_spawn_axis_start";
  spawns[spawns.size] = "mp_sd_spawn_attacker";
  spawns[spawns.size] = "mp_sd_spawn_defender";
  spawns[spawns.size] = "mp_tdm_spawn";
  spawns[spawns.size] = "mp_tdm_spawn_allies_start";
  spawns[spawns.size] = "mp_tdm_spawn_axis_start";
  
  ents = getEntArray();
  
  for (i = 0; i < ents.size; i++) {
    if (isDefined(ents[i].classname) && isDefined(ents[i].origin)) {
      for (j = 0; j < spawns.size; j++) {
        if (ents[i].classname == spawns[j]) {
          if (bulletTracePassed(ents[i].origin, 
              ents[i].origin + (0, 0, 750), false, undefined))
            return false;  
        }
      }
    }
  }
  
  resetTimeout();
  
  if (isDefined(level.waypoints)) {
    for (i = 0; i < level.waypoints.size; i+=5) {
      if (bulletTracePassed(level.waypoints[i].origin,
          level.waypoints[i].origin + (0, 0, 750), false, undefined))
        return false;
    }
  }
  
  return true;
}

/**
 * Estimate the heigh of the skybox roof.
 * The estimation is based on the largest distance
 * measured between a spawn or waypoint and any obstacle right above it.
 * We assume that for at least one spawn or waypoint there is no obstacle above
 * it and that this measured distance will be an estimation of the
 * height of the skybox (the first obstacle encountered in that case).
 * 
 * Parameters: none  
 * 
 * Return: estimated height of the skybox roof.
 */        
get_roof_height()
{
  max                 = 0;
  spawns              = [];
  spawns[spawns.size] = "mp_dm_spawn";
  spawns[spawns.size] = "mp_dom_spawn";
  spawns[spawns.size] = "mp_dom_spawn_allies_start";
  spawns[spawns.size] = "mp_dom_spawn_axis_start";
  spawns[spawns.size] = "mp_sab_spawn_allies";
  spawns[spawns.size] = "mp_sab_spawn_allies_start";
  spawns[spawns.size] = "mp_sab_spawn_axis";
  spawns[spawns.size] = "mp_sab_spawn_axis_start";
  spawns[spawns.size] = "mp_sd_spawn_attacker";
  spawns[spawns.size] = "mp_sd_spawn_defender";
  spawns[spawns.size] = "mp_tdm_spawn";
  spawns[spawns.size] = "mp_tdm_spawn_allies_start";
  spawns[spawns.size] = "mp_tdm_spawn_axis_start";
  
  ents = getEntArray();
  
  for (i = 0; i < ents.size; i++) {
    if (isDefined(ents[i].classname) && isDefined(ents[i].origin)) {
      for (j = 0; j < spawns.size; j++) {
        if (ents[i].classname == spawns[j]) {
          offset = 50;
          while (bulletTracePassed(ents[i].origin, 
                 ents[i].origin + (0, 0, offset), false, undefined)) {
            offset += 50;
            resetTimeout();
          }
          height = ents[i].origin[2] + offset - 50;
          if (height > max) max = height;
        }
      }
    }
  }
  
  resetTimeout();
  
  if (isDefined(level.waypoints)) {
    for (i = 0; i < level.waypoints.size; i+=5) { // check 20% of wp
      offset = 50;
      while (bulletTracePassed(level.waypoints[i].origin,
             level.waypoints[i].origin + (0, 0, offset), false, undefined)) {
        offset += 50;
        resetTimeout();
      }
      height = level.waypoints[i].origin[2] + offset - 50;
      if (height > max) max = height;
    }
  }
  
  return max;
}

/**
 * Check if the given height minus an offset will result in a
 * obstacle free helicopter circle path. It checks this by using multiple
 * bullet traces of the radius of the ellipse shaped helicopter path.
 * The height will be repeatedly increased until there are no obstacles detected.
 * 
 * Parameters: current - start height (of which an offset will be subtracted)
 *             xcenter - x value of the center of the helicopter circle path
 *             ycenter - y value of the center of the helicopter circle path
 *             xradius - radius of ellipse in x direction
 *             yradius - radius of ellipse in y direction
 *              
 * Return: A height that will likely result in a obstacle free helicopter circle path.
 */           
adjust_height_obstacles(current, xcenter, ycenter, xradius, yradius)
{
  parts  = 16;  // number of radiuses we want to check for each height  
  offset = 200; // space under the current height that must be obstacle free
  loops  = 0;   // loop counter to avoid infinite loops
  
  while (loops < 200) {
    col = false;
    
    for (i = 1; i <= parts; i++) {
    
      x = int(xcenter + (xradius * cos((360/parts)*i) ));
      y = int(ycenter + (yradius * sin((360/parts)*i) ));
      
      if (!bulletTracePassed((xcenter, ycenter, (current-offset)),
                             (x, y, (current-offset)), false, undefined)) {
        col = true;
        break;
      }
    }
    
    if (col) {
      current += 50;
    } else {
      break;
    }
    
    loops++;
    resetTimeout();
  }
  
  return current;
}