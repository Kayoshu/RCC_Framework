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

modsdisplay = "";

RCC_fnc_chkModsplayer = {
	modsdisplay = getLoadedModsInfo;
};

["zen_common_execute", [RCC_fnc_chkModsplayer, [modsdisplay]], _unit] call CBA_fnc_targetEvent;

private _modsfiltered = "";
{
	// Current result is saved in variable _x
	if !(_x select 3) then {
		private _mod = _x select 1;
		_modsfiltered = _modsfiltered + _mod + " - ";
	}
	
} forEach modsdisplay;

// Module dialog
[
	"Check player mods", [["EDIT:MULTI", "Mods loaded", [_modsfiltered, nil, 24]]], {}, {}
] call zen_dialog_fnc_create;

