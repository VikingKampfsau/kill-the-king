*****************************************************
*	  Kill the King v2.20 by Viking		    *
*	     steam: vikingkampfsau		    *
*	     discord: viking#1191		    *
*****************************************************

This is the custom version of the final KtK mod (v2.11) made for the ninja clan.
Due to the big amount of changes and additions i decided to release it with a new version number.

*****************************************************
*		  Important Notes & Troubleshooting		    *
*****************************************************

1) CoD4x and some custum plugins are required to run this mod.
-> Get cod4x from www.cod4x.me or compile it with the source on github.

2) The plugin handler of CoD4x changed and the plugins do not work anymore
-> You have to recompile the plugins using the source of the plugins and cod4x.
-> The source code of all required plugins are included within this package.

3) Players loosing ranks
The anti-rank-hack feature will reset the ranks for all players by giving out the message: 
"It seems like you tried to hack your rank!"
Since the feature can't know if the rank persists from an older version it's possible you will see it by mistake!
It can also happen that you loose your rank because the prestige system has changed.
->Please contact the server admin if it happens to you by mistkae and ask him to restore your rank!

4) Server / Clients crash with the error: "file sum/name mismatch"
Keep the name of the modfolder and the name of the iwd file/s inside as short as possible.
Rename the iwd coming with KtK if you have to.
If you still get the "file sum/name mismatch" error try to split the iwd into seperated pieces.

*****************************************************
*		  Known Bugs			    *
*****************************************************

The Ninja Server died before we could finish the testing.
So please let me know when you find any bugs.

Since there are some new events (small gametypes) it's quite sure that bugs appear.

*****************************************************
*		  Installation			    *
*****************************************************

Install cod4x and add the required plugins to it.
Copy the mod to your mods folder. if you already have an older version then remove it.

*****************************************************
*		     Notes			    *
*****************************************************
Informations about the gametypes are written in the
Gametypes.txt

Since the mod has lots of new weapons and models,
some maps are not compatible.
To get them running please increase the xmodel limit with cod4x.
I recommend the following line within your start parameter:
+set r_xassetnum "material=2560 xmodel=1200 xanim=3200 image=3000" 

Also read the Credits.txt and the Weapons.txt to
get further informations about the new/replaced
weapons and their authors.


*****************************************************
*	       Additional Notes	    		    *
*****************************************************

All original and composed textures or assets in this 
modification remain property of the sources respective
owners.

All used sound tracks are licensed by it's original
owners and were used for promotional use only.

*****************************************************
*		Changelog			    *
*****************************************************
2.21 (march 2021 - revived the project)
- Fixed the mapvote (menu style)
- Fixed a rare killcam crash
- Fixed the thermal message display
- Fixed the riotshield button text when it's unlocked
- Fixed the riotshield damage detection
- Fixed the score display in lower left corner
- Fixed the display of the team icons on round end
- Fixed the zombie dog model to fix weird skin deforming
- Fixed Bot rapid fire (added delay between to shots; Durating grabbed from weapon file)
- Fixed Bot spawn on round start (removed the delay)
- Fixed sensitivity of the fast-fire-detection
- Fixed the team switch on new round of HnS
- Fixed the damage detection of props in HnS
- Fixed the mod executing "cg_fov 0" for no reason when connecting 
- Fixed team switch variable when a player switches team (should fix the no weapon for guards in dog event)
- Fixed the minimum amount of players for the traitor event
- Fixed Zombie event: Fix the green knife that followed the guardians
- Fixed the server name having characters removed when the round changed
- Fixed the VIPs functions to work with the new cod4x guid system 
- Fixed the VIPs self revive (and the message)
- Fixed the bot self revive 
- Fixed the bots reviving others even if the number of players is lower than the minimum in config 
- Fixed Alien event: Fixed the invisible viewhands, when an alien becomes a guard
- Fixed the empty rotatemap when no maps in rotation 
- Fixed fov reset: cg_fov and cg_fovscale will not reset anymore when the change is not done through the settings menu of ktk
- Fixed L.K.S. event: Event will now show the last alive king as winner
- Fixed the reset of the killstreak, when last one was reached
- Fixed Reverse event: King was not picked and round just restarted
- Added a kick message when bots get replaced
- Added a kick message for players banned in config
- Added a dvar to enable/disable exploding cars in map
- Added separated skill settings for bots (king/guards/assassins) 
- Added a screen print when HnS can not start because the xmodel file is not written/read
- Added "none" as constant event to the event vote
- Added a new popup page for server changes to the admin menu
- Added noclip to the admin menu (used for debuging - don't abuse it!)
- Added a dvar to enable/disable the fast-fire/weaponswitch detection
- Added an instruction hud in upper left corner for hideandseek
- Added different health bonus for juggernaut - depending on the team
- Added forced enemy name display to 0 (disabled) when event is HnS
- Added the M40A3 for the assassins
- Added the name of the selected player to the admin menu to show who will be punished
- Added a new dvar to control if the bots can revive or not 
- Added a new killstreak setting to separate the rc car from the rc helicopter 
- Added a new setting to separate vip xp multiplier from normal xp multiplier 
- Added a new setting to define for how long the main assassin gets full ammo for the explosive crossbow (team size) 
- Added a votesystem (chat) to allow players to vote for an event or map switch, when the minplayer amount is not reached but there are no bots to play with 
- Added a setting to make the King kills not switch the assassins bots when there are X guardians bots already
- Added a shellshock (screen shaking) to players on the ground to make it a bit harder to aim (and feel like pain)
- Added a new admin function to freeze players (used for debugging)
- Added a dvar to main menu to display the song (artist and title)
- Changed empty map rotation: it will now rotate when bots online only too
- Changed the title for the "Hall of Fame" to explain that it's an "All time" leader-board
- Changed the throw time of the throwing knife
- Changed healthbar of king and terminator to hide it when a menu is on top
- Changed the adminmenu to show all players on one page
- Changed the FovScale setting to have more values
- Changed the position of Killstreak icons when the lagometer is enabled
- Changed the antiglitch triggers to not destroy RC-Toys
- Changed the suicide behaviour, it will now first explode RC-Toys (so you need to suicide twice to die)
- Changed the auto map rotation to use bot maps when there are no players are online (and the rotation contains bot maps)
- Changed the seed of the spawn helicopter and parachute (faster now)
- Changed the display name for event "none" to "None (Standard KTK)"
- Changed the 'rotate empty map' script so it will fall back to normal ktk before the map switch 
- Changed the view of the bots when climbing ladders to force them to climb up/down no matter how far away the next waypoint is 
- Changed the knife assist script to reduce the var usage
- Changed L.K.S. event: new comers have to wait for next round
- Changed L.K.S. event: it will now end when all 'real' players were killed or disconnected to avoid time consuming bot fighting
- Changed the Final Killcam to follow javelin missiles
- Changed the 'one player left' behavoiur for events; Round ends now instead of endless waiting for new players
- Removed the ammo counter for melee weapons
- Removed the last Update Date from the Loadscreen
- Removed the collision for weapon boxes so players and bots can walk through
- Removed nade cooking removed to avoid suicide
- Removed the VIPs RPG getting a new rocket at every weapon upgrade
- Removed some false sounds from weapon files
- Cleaned the admin menu to send less commands from server to client
- Cleaned the 'rotate empty map' script
- Cleanup of player variables in some files to reduce the var usage
- Updated the plugin for hideandseek
- Rewrote the thermal script to use less variables

(summer 2020 - end of development because the ninja server was shut down)

2.20 (start of ninja edition - summer 2019)
- Fixed a lot of small things,
- Fixed the announcer saying the end reason twice,
- Added bots,
- Added custom events,
- Added custom character models,
- Added a new rc-xd type (helicopter),
- Added a backup system for player ranks,
- Added an admin command to mute player text chat,
- Added a zipline to fast reach/escape from a spot,
- Added a killstreak to the dog (he can find enemies),
- Added a maprecords screen to the map end to compare player results,
- Added a custom knifeassist because cod4x removed the one of cod4,
- Changed the bloody messages (it's now a menu),
- Translations completed,
... And many other thins i can't remember... well it has been a while since 2.11 ;)

2.11 (January 2017)
- Fixed the immortal sentry-gun after the pickup,
- Fixed the removal of the sentry-gun when it's owner dies,
- Fixed the predator ground detection, no more predators under the map,
- Fixed the destruction radius of the preadtor,
- Fixed the "fall out of ac130" bug,
- Fixed the removal of the ac130 weapon when the ac130 time is over,
- Fixed the fly radius of the ac130 by adding a new calculation for the radius,
- Fixed the parachute, you will no longer be stuck in a wall or fly through the ground,
- Fixed the exit after the helicopter time,
- Fixed the removal of the targetmarkers,
- Fixed the defuse of tripwires,
- Fixed the hardpoint gain for the king,
- Fixed the double hardpoints in the hud,
- Fixed the double damage of the throwing knife,
- Fixed the "waiting for players" when there are some "late" spectators,
- Fixed the admin commands,
- Fixed the gunstage after a revive,
- Fixed the healthbar of the king when a new king was chosen,
- Fixed the magnum bug for assassins,
- Fixed the 3rd person removal after the killcam,
- Fixed the sprint and jump bug,
- Fixed the double unlockable points after playing on a homeserver,
- Fixed the missing text strings in the equipment menu,
- Fixed the winner message at the end of the map,
- Fixed the K/D ratio in the rank and challenges menu,
- Fixed the reset feature for challenges,
- Fixed the "Block hardpoint" feature - The carepackage will not use blocked hardpoints anymore,
- Fixed the rights of the different admin groups,
- Fixed the round display for spectators,
- Fixed the auto screenshot at the end of the map,
- Added a record list which is shown at the end of the map,
- Added a maprotation for different amount of players,
- Added a movement delay after a glitch teleport,
- Added a protection for higher admin ranks - lower admins can not harm higher admins anymore,
- Added a new line which is shown in bottom left giving detailed informations about a performed admin action,
- Added a new setting to disable the terminator on some maps only,
- Added a timer to see for how long the current hardpoint is active,
- Added the juggernaut to the hardpoints,
- Added a dvar to enable/disable reset for challenges,
- Added some more prestiges,
- Added a scroll protection for the m21,
- Added a killcam for a king dying through friendly fire,
- Added a feature to drop your gun,
- Added a timer for last stand,
- Added a new way to log in to the admin menu,
- Changed the amount of arrows for the crossbow equipment,
- Changed the bite of the dog, you will now always dash forward,
- Removed some xmodels.

2.10 (December 2015)
Sadly i lost track of what exactly is fixed, it was simply to much.

2.09.30 & 2.09.31 (August 2013)
- Fixed the server crash "exceeded maximum number of script variables" caused by to many players playing on the server,
- Fixed the bug that the dog was picked even if he's disabled in the config or set to a amount of needed guardians,
- Fixed the bug which caused players with the gungame perk to spawn with the first weapon after joining,
- Fixed the bug which blocked players from resetting a picked hardpoint,
- Fixed the issue that assassins loose a gained carepackage on respawn,
- Fixed the auto-weapon-change as assassin when climbing or mantling,
- Fixed the hardpoints and grenades for the picked terminator,
- Fixed the poison grenade damage during spawnprotection,
- Fixed the infinite horn bug whent he RC-XD explodes,
- Fixed the reset of the settings after a map change,
- Fixed the j_head/j_helmet server crashes (finally),
- Fixed the carepackage landing on an RC-XD,
- Fixed the money display for assassins,
- Fixed the infinite throwing knives,
- Added a dvar to choose which hardpoints the king will earn (old system or new (new = selected hardpoints in menu)),
- Added a new system to the assassin class selection which defines in percentage how often a class will be chosen,
- Added a button to check the MOTD & Rules again (class menu (the one you see when you press 'esc' ingame)),
- Added a dvar to vary the helicopter health, depending on the total amount of players on the server,
- Added a sript to pick a new king when the current one leaves within a specified time,
- Added a new dvar for the javelin so admins can set the needed time to lock a target,
- Added an ammocounter for the javelin so you can see how many ammo you have left,
- Added a script which removes the maps which was just played from the mapvote,
- Added a dvar to remove weapons around the map (e.g. poolday the little room),
- Added a button to choose between dog and slave (player settings menu),
- Added a button to the main menu to rejoin the last server played on,
- Added dvars to control the radius and damage of the tripwires,
- Added a help menu to explain the basics of the gameplay,
- Added a feature to disable hardpoints on specified maps,
- Added dvars to change the color of the gained xp popup,
- Added targetmarkers to some hardpoints (e.g. ac130),
- Added a message when the javelin is out of ammo,
- Added dvars to control the tripwire damage,
- Added a javelin for the assassins
- Changed the gore effect - it's not playing when the player survives the explosion,
- Changed the check for how many helicopters are currently in the airspace,
- Changed the mapvote - when no map was voted a random one will be picked,
- Changed the explosive crossbow  - it will now damage helicopters,
- Changed the needed amount of players for the gamestart to 2,
- Changed the weaponbox, assassins can now use it too,
- Seperated the final killcam from the normal killcam,
- Removed 2 xmodels (tire and dog poop),
- Katana, knife and dog bite can now also be used by pressing the attack button,
- Players can now move around while waiting for others.

2.09.29
- Added bloodsplatter when knifing or biting a player,
- Added a menu for admins when logging in to admin menu,
- Added a killicon for the katana,
- Added a new prestige system,
- Added a sideswitch in halftime,
- Added a dvar to control the overheat of the minigun,
- Added a dvar to manage the appearance of quickmessages,
- Added a new hardpoint system (mw3 like)
- Added suicide support to the final killcam,
- Added killcam support for mortars and the carepackage,
- Added new settings to the settings menu to enable/disable: Bloodsplatters, Knife Stabbing (Promod Knife), Killcam (not Finalkillcam), Thirdperson View for Dog, 
- Fixed the loss of poison grenades from shop, when reaching the poison grenade killstrek,
- Fixed the auto weapon switch after the death of the player which got revived,
- Fixed the team scores after switching the sides,
- Fixed the crosshair for third person,
- Fixed the target markers while beeing in heli, ac130 etc.,
- Fixed the tactical nuke when the guard gets killed during the countdown,
- Fixed the weapon change when opening a carepackage,
- Fixed the loss of the carepackge grenade after using an airstrike,
- Fixed the xp required for a new rank,
- Fixed the final killcam for last round,
- Fixed the collision for the carepackage,
- Fixed the stage hud for assassins,
- Fixed the health loss when the king gets juggernaut from the carepackage,
- Fixed the crossbow from carepackage,
- Fixed the melee usage while beeing an RC-XD,
- Fixed the bug which allowed players to login to the admin menu,
- Fixed the loss of the maprotation on server starts,
- Fixed the healthbar of the king when damaged with a katana,
- Fixed the maprotation when server is empty (only working for stock maps),
- Fixed the carepackage smoke bug which caused the carepackage not to appear,
- Fixed the trigger which blocked players when they stand under a dropped carepackage,
- Fixed the badges of the picked players on round begin,
- Fixed the overlapping menu elements.

2.09
- Added carepackages,
- Added a katana for assassins,
- Added a new Scope for Assassins,
- Added mantle support to the dog,
- Added a feature to restore lost ranks,
- Added a day-night-cylce based on realtime,
- Added enemy indicators when using AC130 etc,
- Added a horn to the RC-XD (just for a laugh),
- Added gore effects to the explosive crossbow,
- Added a new glitch detection to the antiglitch feature,
- Added a script to enable/disable the dog from certain maps,
- Added a second assassins if the dog is disabled or not supported,
- Added a function to reset challenges (somehow not working online),
- Added a menu to allow players to custimize their game a litte bit,
- Added textes to the unlockables menu to explain what the item will do,
- Added a killstreak for the dog so he's able to poop (just for a laugh),
- Added a script to delete unnecessary "script_/spawns_/trigger_ elements" from map,
- Added multilanguage support to the mod (unfinished due to the lack of translators),
- Added new hardpoints, gainable through the carepackage (Nuke, Sentry Gun, Predator, Juggernaut),
- Added a slot sytem for hardpoints to allow players to carry and use different hardpoints at the same time (like mw3),
- Fixed the self-revive for Vip's,
- Fixed the text positions on the loadscreen,
- Fixed the appearance of duplicated blood pools,
- Fixed the selection system, so it will not get stuck anymore,
- Fixed the tripwire and slightly changed it to make it more realistic,
- Fixed the filmtweak issue for players connecting when a nuke was launched,
- Fixed the script_error which was flooding the console when a player launched a hardpoint,
- Fixed the poison grenade, smoke effect will no longer be played in the air when thrown to high,
- Changed the layout of the admin menu,
- Changed the layout of the hud overlay,
- Changed the grenades to semtex grenades,
- Changed the flypath of the mortar shells,
- Changed the layout of the ghillieselection menu,
- Changed the layout of menu visible when entering the server,
- Removed the rank up notify messages.

2.08 (October 2012)
- Fixed the 'xp required' bar in the rank & challenges menu after entering a new prestige,
- Fixed the healthincrease for vips, they still have 20hp more, but will die by a knife,
- Fixed the weapon bug caused by weapon changes in gungame while beeing in a hardpoint,
- Fixed the appearing crossbow icon when dying by suicides (like minefields in map),
- Fixed the antiglich system, players in hardpoints will not be counted anymore,
- Fixed the revive of players which arent lying on the same spot they died at,
- Fixed the admin commands, so it can also be used on players in hardpoints,
- Fixed the bug which allows to use 2 position changing hardpoints at once,
- Fixed the helicopter bug which made a player invisible and unkillable,
- Fixed the killstreak for the king (Dvar: scr_hardpoint_king_weapon),
- Fixed the suicide through explosive crossbows after a team switch,
- Fixed the thermal vision on weapon changes caused by the gungame,
- Fixed the bug that players were able tp revive 2 players at once,
- Fixed the bug which allowed 2 helis/ac130 in the map at once,
- Fixed the issue with not gaining grenades at the weaponbox,
- Fixed the stickie arrows attached to players in last stand,
- Fixed the gungame weaponchange when starting to revive,
- Fixed the bug for the not crashing ah6 and helicopter,
- Fixed the partially weapon loss after beeing revived,
- Fixed the weaponloss for the king when he goes down,
- Fixed the flyheight for Helicopters and the AC130,
- Fixed the revive of players after the round ended,
- Fixed the loss of next weaponstage when reviving,
- Fixed the team assignment after beeing AFK,
- Fixed the de-/activation for the visions,
- Fixed the ammo-counter of the minigun,
- Fixed the flyheight for ac130 and ah6,
- Fixed the textures of the RC-XD,
- Fixed the angles for the RC-XD,
- Fixed the damage of the RC-XD,
- Fixed the Killicon for the dog,
- Fixed the wallbang of the ah6,
- Fixed the empty map rotation,
- Fixed the admin bagde,
- Added a killicon for the dog,
- Added serveral language supports,
- Added a shop for players in prestige ranks,
- Added a second sniper class to the assassins,
- Added new buyable stuff to the prestige shop,
- Added a numerical ammocounter (graphic settings),
- Added icons of selected players to the scoreboard,
- Added hiticons when shooting helicopters and rc-xds,
- Added lots of new glitches/elevators to the anti-glitch feature,
- Added the grenadelauncher again (Dvar: scr_mod_grenadelauncher),
- Added a pilot to the helicopters to make shooting it down faster,
- Added an admin-menu for an easier server management while playing,
- Added a timer to the weapon box (Dvar: scr_mod_weaponbox_picktime),
- Added a damage modifier for wallbangs (Dvar: scr_mod_wallbangmodifier),
- Added a script to skip helicopter-hardpoints on maps without helicopter-waypoints,
- Added a dvar to control strength of explosive crossbow (Dvar: scr_mod_expbolt_damage),
- Added a healthbar to show the remaining health of the king (Dvar: scr_ktk_kinghealthbar),
- Added a weapon index mismatch FIX - Found on openwarfaremod.com (Dvar: weap_reverse_load_MAPNAME "1"),
- Added a new spawnsystem for players joining the server after round start (Dvar: scr_mod_parachutespawn),
- Added spawnprotection to the mod (Dvars: scr_mod_spawnprotection, scr_mod_spawnprotectionradius, scr_mod_spawnprotectiontime),
- Changed the firerate of the ah6,
- Changed the icon of the weaponboxes,
- Changed the damage of the intervention,
- Changed the damageradius for the poison,
- Changed the flyeffect of the crossbow arrow,
- Changed the amount of rockets for vips to 1,
- Changed the price for the weaponbox for vips,
- Changed the throwspeed for a throwable knife,
- Changed some soundaliases for better volumes,
- Changed the revive icon, visible through walls now,
- Changed the main menu background and the loadbar on the loadscreen,
- Changed the spawnsystem for guards, they will now respawn close to the king,
- Changed the behavior for the handling of the terminator when he runs out of ammo,
- Changed the ammo system for the king - he will not receive ammo for claymores (etc),
- Changed the kill the king player abilities from a quickmessage menu to a options menu,
- Removed 9 unnecessary fx assets,
- Removed 1 unnecessary weapon asset,
- Removed 5 unnecessary image assets,
- Removed 10 unnecessary xmodel assets.

2.07 (June 2012 - first public release when i remember correctly)
- Added pain sounds
- Added blood effects
- Added icons to the random weaponbox so it can be found easier (for ppl who don't know the s&d targets)
- Added a script to log admins in rcon when they connect to the server
- Added a script which unlocks the challenges for players which have ranks from older mod versions
- Added the names of the challenges to the localizedstrings, so the name of a gained challenge will be shown ingame
- Added a dvar to control when a player switches team after he got killed by the king
- Fixed the script which detects if the dog is stuck
- Fixed the issues with wrong positions of some huds
- Fixed the buggy challenges
- Fixed the bug of the disappearing ammo counter after dying as terminator
- Fixed the rccar, so it's not getting stuck when a player is too close to an wall/object when starting
- Fixed the appearing server crash when all players leave at once after the round has started
- Fixed the admin command to switch a players team
- Fixed some errors related to the challenges,
- Fixed the mapvote, no duplicates anymore,
- Fixed the selection of the terminator,
- Fixed the teamkill through dog bites and throwable knives,
- Fixed the issue that players in last stand were choosen as terminator,
- Fixed the issue that some players were exploding on death,
- Fixed the revive system (completely rewrote the whole script!),
- Fixed the issue that guards keep their gained ac130 as assassin,
- Fixed the round end bugs for the hardpoints,
- Fixed the [j_helmet] and [j_head] server crashes (not working for maps using soldiertype woodland but did not include it),
- Fixed the quickmessage menu, stuff like thirdperson will now persist when a newround begins,
- Fixed the infinite weapon bug for the weaponbox,
- Fixed the pickup for the throwable knife,
- Fixed the animation of the dog (finally),
- Fixed the blood effects for the dog,
- Fixed the damage of the dog,
- Fixed the vision files.
- Fixed the lags when calling the helicopter,
- Fixed the lags when a guard gets into last stand,
- Fixed the light effect for the RCXD,
- Fixed the Self-Destruction-Timer for the RCXD,
- Fixed the sound volume for the RCXD,
- Fixed the RCXD, it's getting destroied when the owner dies,
- Fixed the Vip's selfrevive-system so they get up with a gun again,
- Fixed the issue that Vip's set in the config getting ignored,
- Fixed the Newsbar so its not visible when no text got assigned,
- Fixed the Headicon of the king, the icons of the weaponboxes stay untouched,
- Fixed the progressbar of the revive, it will now be removed when the medic dies,
- Fixed the roundstart, game won't start if the required amount of players is in spectator,
- Fixed the bullet impact for the helicopter and the ac130,
- Fixed the health of the terminator, it will now be what you have set in the config,
- Fixed the killstreaks so the player will now gain the achieved hardpoints,
- Fixed the throwable knife, it can now be picked up by any players and be deleted after time,
- Fixed the weaponbox, a player will not receive no weapon anymore,
- Fixed the weapon index error appearing on some maps,
- Fixed the mapvote, the voted map will now be next and the server won't freeze on scoreboard,
- Fixed tons of little script runtime errors, so the mod will run smoother (there are still some left).
- Changed the hardpoints, so they will not damage players, when the owner changed teams
- Changed the gungame, so the player will not loose the weapon he got from the weaponbox
- Changed the revive-system (Vip's can now heal themselves when they are downed)
- Changed the text of the weaponbox (it will now show the amount of required points)
- Changed the rank&challenges menu a bit (new stats)
- Changed the amount of targets for the mortar to a single one (due to many complains by players)
- Changed the picksystem for the first assassin, the king and the dog
- Changed lots of loops for a smoother run,
- Changed parts of scripts for a smoother run,
- Changed the amount of bullets for the minigun,
- Changed the mapnames on the votetable,
- Added an ah6 overwatch when the king is last guard alive,
- Added new dvars for a bigger customization,
- Added blockers to some glitch spots
- Added an anti-rank-hack feature,
- Added an icon for admins and vips,
- Added a script which switches AFK's to spectators,
- Added a crosshair to 3rd person,
- Added a suicide function to the player menu (for dog only),
- Added a real minigun to the game (raise and reload anim still buggy),
- Added a feature to repeat the hardpoints after the last one,
- Added a script which sets the gametype if a map starts with ffa,
- Removed the player model from the RC-XD.
- Added a dvar to change the helicopter back to the original cod4 one,
- Added additional damage to the victim of the dog, depending which body part gets hit,
- Rewrote the throwable knife, it isn't using the authors script anymore,
- Rewrote small parts of the revive script for a smoother run,
- Removed the ability for vips to revive themselves when the amount of regular players in the server is equal or less.
- A player will not be chosen as the terminator when he is using the RCXD, Helicopter or AC130,
- The terminator will not be chosen, when the round is over before the time limit has been reached,

2.06
- Added some more challenges
- Added an attacking sound the dog
- Added an explosion sound to the rccar
- Added prestige icons to the mod
- Added extra XP support (all extra gained xp will also be added to the score now)
- Fixed the damage of the rccar
- Fixed the overflow error which is crashing the server
- Fixed the knife which is crashing the server
- Fixed the bug that a killed terminator will explode when he dies as normal player
- Fixed the bug that a medic has no weapon, when the downed player dies
- Fixed the bug that the terminator looses his minigun when he buys a random weapon for the first time
- Fixed the huds which is showing the players current weapon stage and points
- Changed the loadscreen

2.05
- Added custom challenges to the mod
- Added a hud so the player can see his progress during the gungame
- Added a dvar to control the auto-weaponswitch during the gungame
- Added a dvar to enable/disable the healthregen
- Added a script which detects if the dog is stuck
- Added a script so a player using the rccar will not be picked as terminator
- Added new classes for the assassins (each spawn a random class)
- Fixed the thermal vision of the scopes
- Fixed the missing sound and fx for the rccar
- Fixed the bug of the negative amount of xp to level up
- Fixed the parachute
- Removed all gametypes except of KtK from the mapvote
- Removed the knife from all weapons and made it a seperated weapon
- Completely unlocked the stock challenges
- Players will now keep their hardpoints, when they finished the round as a guard

2.04
- Added new weapons
- Added an ac130 as final hardpoint
- Added tripwires to the random weaponbox
- Added a function for admins to put players in spectator and bring them back
- Added dvars to add vips through rcon
- Added dvars to ban players through rcon, no need of logging into ftp to edit the ban.txt
- Fixed the gametype called "Hellfire"
- Fixed all hardpoints, yea they are all useable now.
- Reorganized the quickmessage menu
- Reorganized the ingame menu
- Reorganized the iwd files
- Reorganized some weaponfiles
- Removed the spectator due to the possibility of gungame glitching

2.03
- Added a new gametype called "Hellfire"
- Added a roundend effect to "Contain the Code"
- Added poisongas grenades
- Added new weapons
- Added killstreaks for the king (3 kills = fast reload, 5 kills = poisongas grenades 7 kills = UMP45)
- Added a variable so the king wont be picked twice in a row
- Added a thermal vision to scopes
- Fixed the dog
- Fixed the parachute landing
- Reorganized the quickmessage menu

2.02
- Added RC-Cars to the killstreaks of the Guards
- Rewrote some parts of different scripts
- Made the mod more customizable through dvars
- Replaced the sd bomtargets with random weaponboxes

2.01
- Removed the anti-flood script since it was banning random players at mapchanges
- Fixed the bug that some players do spawn without a gun
- Auto-Switch to 3rd person in final killcam when the king got killed by a dog
- The Final Killcam will follow the knife when the king got killed by a throwable one
- Reorganizements in the script files

2.0
- Improved the message-system (now an unlimited amount of messages can be added)
- Fixed some admin commands
- Added a vote for the gametype after the mapvote
- Readded the nightvision for players
- Replaced the intervention with an improved one
- Added different ghillies for the assassins (choosable through a new menu)
- Added some new gametypes!
- Added a parachute when leaving the helicopter
- Slightly changed the terminator:	
					- added a model
					- added a helmet
					- removed sprint and jump ability

1.06
- Added new ingame challenges
- Fixed the bug for earning not reached challenges
- Fixed frozen challenge hud
- Added throwing knifes as 2 killstreak for the assasins
- Added some new killstreaks for the guards
- Added a mapvote at the end of the map

1.05
- Added ingame challenges (awards)
- Final Killcam fixed
- Double spawning after switching from guards to assassins removed

1.04
- Added commands for the admins!
- Picking Assassin/King/Terminator script got improved
- The bug of spawning without a class is now removed
- Added a killcam which shows how the king got killed
- Change of the Quickmessagemenu
- New line on top of the screen
- Added a waitdelay for the first round
- Change of some graphic settings
- Adjustments for weapons
- The king has now some claymores

1.03
- The script for picking the terminator got slightly changed
- Added xp multiplication
- Players will see a message when the explosive crossbow is stuck on them!
- Players gain XP when staying around the king

1.02
- Players can be revived only once now! The King is now killable even if a guard is camping next to him!
- The King is marked on the compass (for guards only)
- When the round is over the players will not switch the teams immediately
- The player which has killed the king will not respawn until the round will restart, he will stay at the position from where he has killed the king
- The king can not switch to the assassins any more without ending the round!
- The explosive crossbow is now sticky!

1.01
- Players can now be revived when they get into last stand!
- Added a new model for the king
- Added new custom weapons

August 2011 (first alpha test)