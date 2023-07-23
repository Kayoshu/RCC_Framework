/*
 * Author: 1er RCC - Kay
 * Register custom RCC modules and right-click actions
 * Executes at mission start
 *
 */

if (!hasInterface) exitWith {};

private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
if !(_hasZen) exitWith { systemChat "ZEN not detected";};


// Custom Modules in Right Panel

// Related to AI
["1er RCC AI", "AI Set Manual Dismount", {_this execVM "rcc_zeus\rcc_zeus_manualaiinsert.sqf";}, "\z\ace\addons\fastroping\UI\Icon_Waypoint.paa"] call zen_custom_modules_fnc_register;
["1er RCC AI", "AI Set Vehicle Driver", {_this execVM "rcc_zeus\rcc_zeus_aiadddriver.sqf";}, "\z\ace\addons\sitting\UI\sit_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC AI", "Un-Garrison (enable PATH)", {_this execVM "rcc_zeus\rcc_zeus_ungarrison.sqf";}, "\z\ace\addons\zeus\UI\Icon_Module_Zeus_UnGarrison_ca.paa"] call zen_custom_modules_fnc_register;
// Interaction with inventories
["1er RCC Inventory", "Add ACE Medical", {_this execVM "rcc_zeus\rcc_zeus_acemedicbox.sqf";}, "x\zen\addons\context_actions\ui\medical_cross_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Inventory", "Add Players Ammunitions", {_this execVM "rcc_zeus\rcc_zeus_ammobox.sqf";}, "\a3\ui_f\data\igui\cfg\simpletasks\types\rifle_ca.paa"] call zen_custom_modules_fnc_register;
// Tickets
["1er RCC Tickets", "Add Tickets to all alive players", {execVM "rcc_zeus\rcc_zeus_playeraddtickets.sqf";}, "x\zen\addons\context_actions\ui\add_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Tickets", "List Dead & Spectators", {execVM "rcc_zeus\rcc_zeus_listspectator.sqf";}, "\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Tickets", "Modify Individual Tickets", {execVM "rcc_zeus\rcc_zeus_playertickets.sqf";}, "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Tickets", "Set all alive players Tickets", {execVM "rcc_zeus\rcc_zeus_playersettickets.sqf";}, "\a3\Modules_F_Curator\Data\portraitRespawnTickets_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Tickets", "Toggle Tickets Respawn", {execVM "rcc_zeus\rcc_zeus_toggleunlimited.sqf";}, "\a3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa"] call zen_custom_modules_fnc_register;
// Scenario flow
["1er RCC Scenario", "Custom Ending", {execVM "rcc_zeus\rcc_zeus_customend.sqf";}, "\a3\Modules_F_Curator\Data\iconEndMission_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Scenario", "Fade Music", {execVM "rcc_zeus\rcc_zeus_fademusic.sqf";}, "\a3\Modules_F_Curator\Data\portraitMusic_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Scenario", "Safe Start", {execVM "rcc_zeus\rcc_zeus_togglesafestart.sqf";}] call zen_custom_modules_fnc_register;
["1er RCC Scenario", "Transition", {execVM "rcc_zeus\rcc_zeus_transition.sqf";}, "\a3\ui_f\data\igui\cfg\simpletasks\types\wait_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Scenario", "Transition Time", {execVM "rcc_zeus\rcc_zeus_transitiontime.sqf";}, "\a3\Modules_F_Curator\Data\iconSkiptime_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Scenario", "Videos", {execVM "rcc_zeus\rcc_zeus_videos.sqf";}, "\a3\Modules_F_Curator\Data\portraitCuratorSetCamera_ca.paa"] call zen_custom_modules_fnc_register;
// Various Tools
["1er RCC Tools", "Check Mods Player", {_this execVM "rcc_zeus\rcc_zeus_chkmodsplayer.sqf";}] call zen_custom_modules_fnc_register;
["1er RCC Tools", "Force Delete", {_this execVM "rcc_zeus\rcc_zeus_forcedelete.sqf";}, "\z\ace\addons\zeus\UI\Icon_Module_Zeus_Editable_Objects_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Tools", "Group Cap Reset", {execVM "rcc_zeus\rcc_zeus_unitcap.sqf";}, "\a3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Tools", "Toggle Consciousness", {_this execVM "rcc_zeus\rcc_zeus_toggleconsciousness.sqf";}, "\z\ace\addons\zeus\UI\Icon_Module_Zeus_Unconscious_ca.paa"] call zen_custom_modules_fnc_register;
// Vanilla Fog
["1er RCC Environment", "Vanilla Fog", {_this execVM "rcc_zeus\rcc_zeus_vanillaFog.sqf";}, "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call zen_custom_modules_fnc_register;

// Custom Right-Click Actions

// Checks if unit object, is not null and is alive. Required to filter away if right-clicked on group as the other if-checks dont work with group
RCC_fnc_isAlivePlayerUnit = {
	params ["_unit"];
	private _result = false;

	if (typeName _unit != "OBJECT") exitWith { _result = false; _result;}; // check if not group, before 

	if (!isNull _unit && alive _unit && _unit isKindOf "CAManBase" && isPlayer _unit) then {
		_result = true;
	};
	_result;
};

RCC_CrowsZAModLoaded = isClass (configFile >> "CfgPatches" >> "CrowsZA"); // CrowsZA locally loaded

// TP to squadmate
private _tpsquadmemberaction = [
	"teleport_to_squadmate", 
	"Teleport To Squadmate", 
	["x\zen\addons\context_actions\ui\marker_ca.paa", [1, 0.5, 0, 0.7]], 
	{[_position, _hoveredEntity] execVM "rcc_zeus\rcc_zeus_tpsquadmember.sqf";}, 
	{[_hoveredEntity] call RCC_fnc_isAlivePlayerUnit && !RCC_CrowsZAModLoaded}
] call zen_context_menu_fnc_createAction;

[_tpsquadmemberaction, [], 15] call zen_context_menu_fnc_addAction;

// Toggle consciousness (in Heal subfolder)
private _playertoggleconsciousness = [
	"player_toggle_consciousness", 
	"Toggle Consciousness", 
	["\z\ace\addons\zeus\UI\Icon_Module_Zeus_Unconscious_ca.paa", [1, 0.5, 0, 0.9]], 
	{[_position, _hoveredEntity] execVM "rcc_zeus\rcc_zeus_toggleconsciousness.sqf";}, 
	{[_hoveredEntity] call RCC_fnc_isAlivePlayerUnit}
] call zen_context_menu_fnc_createAction;

[_playertoggleconsciousness, ["HealUnits"], 0] call zen_context_menu_fnc_addAction;

// Modify player lives
private _playermodifylife = [
	"player_modify_life", 
	"Modify Lives", 
	["\a3\Modules_F_Curator\Data\portraitRespawnTickets_ca.paa", [0, 0, 1, 0.9]], 
	{[_position, _hoveredEntity] execVM "rcc_zeus\rcc_zeus_modifylife.sqf";}, 
	{[_hoveredEntity] call RCC_fnc_isAlivePlayerUnit && !(missionNamespace getVariable "RCC_TplLivesUnlimited")}
] call zen_context_menu_fnc_createAction;

[_playermodifylife, [], 0] call zen_context_menu_fnc_addAction;

// Force Spectator (in Captives subfolder)
private _playerforcespectator = [
	"player_force_spectator", 
	"Force Spectator", 
	["\a3\Modules_F_Curator\Data\portraitCurator_ca.paa", [1, 0.9, 0, 0.7]], 
	{[_position, _hoveredEntity] execVM "rcc_zeus\rcc_zeus_forcespectator.sqf";}, 
	{[_hoveredEntity] call RCC_fnc_isAlivePlayerUnit}
] call zen_context_menu_fnc_createAction;

[_playerforcespectator, ["Captives"], 0] call zen_context_menu_fnc_addAction;

// New suppressive fire
private _suppress_new = [
	"Rev_suppress",
	"Suppressive fire",
	"\x\zen\addons\modules\ui\target_ca.paa",
	{
		[_objects select 0] call RCC_fnc_suppress;
	},
	{
		(count _objects) > 0;
	},
	[],
	{},
	{
		params ["_action","_parameters"];
		private _unit = (_parameters select 1) select 0;
		private _group = group _unit;
		if (!isNil {_group getVariable ["Rev_suppression",nil]}) then {
			_action set [1, "Stop suppressive fire"];
			_action set [4, {private _target = (group (_objects # 0) getVariable ["Rev_suppression",nil]); deleteVehicle _target}];
		};
	}
] call zen_context_menu_fnc_createAction;

[_suppress_new, [], 0] call zen_context_menu_fnc_addAction;
