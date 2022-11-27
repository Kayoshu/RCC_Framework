/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Check for mods on player
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached unit
 *
 * Return Value:
 * In ZEN Popup
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

//if is  not player, exit
if (isNull _unit || !(isPlayer _unit)) exitWith {
	["Select a player"] call zen_common_fnc_showMessage;
	systemChat "Select a player";
	playSound "FD_Start_F";
};

private _plyUID = getPlayerUID _unit;
private _modsdisplay = missionNamespace getVariable "RCCMods" + _plyUID; // looking for value in missionNamespace for that player

// Module dialog
[
	"Check player mods", [
		["EDIT:MULTI", name _unit, [_plyUID, nil, 1]],
		["EDIT:MULTI", "Mods loaded", [_modsdisplay, nil, 12]]
	], {}, {}
] call zen_dialog_fnc_create;
