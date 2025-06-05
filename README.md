Features:

Configuration Menu (NativeUILua)
/config fire

1. Create/Modify Stations (Saved to local .Json file in resource/data pathway)
Main_Menu
[MenuButton]<View, Modify, Create Stations>
>ViewCreateModifyStation_Menu
></desc><Select to modify>
>[Submenu Button]<Create New>
>[H22] Engine House 22
>[H32] Engine House 32
>[Button]<Go Back>

3. Creation
[TextField]<Set Station Name> -- Engine House 26
[TextField]<Set Station # or ID> -- Ex. 22, H22, S22 etc.
[Button]<Set Teleport to Current Location> -- Sets location for teleport locationm for the station at player coords/heading
[Button]<Set Garage Interaction> -- Location for small blip to interact with station-specific garage at player coords/heading
[Button]<Set Locker Room> -- Location for small blip to interact with locker menu at player coords/heading
[Button]<Save and Exit?>
[Button]<Cancel>

4. After it is created, when modifying the station, you have the option to modify the garage

[TextField]<Set Station Name> -- Engine House 26
[TextField]<Set Station # or ID> -- Ex. 22, H22, S22 etc.
[Button]<Set Teleport to Current Location> -- Sets location for teleport locationm for the station at player coords/heading
[Button]<Set Garage Interaction> -- Location for small blip to interact with station-specific garage at player coords/heading
[MenuButton]<Modify Garage>
[Button]<Set Locker Room> -- Location for small blip to interact with locker menu at player coords/heading
[Button]<Save and Exit?>
[Button]<Cancel>



GarageMod_Menu
[SubMenu]<Add/Remove Vehicles>
[Add New Vehicle]
>[TextInput]<Enter Vehicle UID/Callsign> (Ex. 22, 32, etc.)
>[List]<Choose Apparatus Type> (This exists in a predefined list for later use, such as reqeusting backup in a menu. For fire vehicles, this is: URB_ENGINE, RUR_ENGINE, L_STICK, L_PLATFORM, L_HL, RSQ, L_RSQ, etc. -- Whereever these are defined their applicable names are also hard-coded such as URB_ENG-> Urban Engine, L_PLATFORM-> Platform Ladder. Also inlcuded should be Ambulance, Rescue Ambulance, Command POV, Command Truck, Boat, MediVac, Rescue Chopper, Tanker, Hazmat, etc.
>[Button]<Capture current> -- Sets config for components, liveries, spawncode based upon current players vehicle they are inside
>[MenuButton]<Whitelist> -- Add desc to this one, if left blank any rank can use it. If this menu button is selected, opens menu of all FD Ranks/Groups based on NDCore.cfg. If groups 'lsfd' and 'bcfd' are in this resources config as firefighter groups, then when this menubutton is clicked, it opens a submenu with rows of checkboxes which are the various ranks for the configured FF Groups. When checked only those ranks can use this vehicle.
[other vehicles as submenu options in a table]

[SubMenu]<Add/Remove SpawnLocations>
-- When in the add/remove spawnlocations menu, all current spawnlocations appear with a marker in-game showing location/heading or vector whatever the fuck applies
[Add New Location]
[Bay 1]
> *When Pressed*
>[Update Location]
> [Remove and Exit]
> [Save and Exit]
[CheckBox]<Enable Infinite Spawns>
[CheckBox]<Enable Spawn Inside Vehicle>
[CheckBox]<Enable Colision Testing> -- Ensuring vehicle doesn't spawn into another player, cancels spawn event/system if player or other vehicle is present in spawn location

Based upon this config, flesh out the rest of the script, including the interaction menu for the garage, etc. 
