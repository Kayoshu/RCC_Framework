/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Check for pbos on player
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
	modsdisplay = allAddonsInfo;
};

["zen_common_execute", [RCC_fnc_chkModsplayer, [modsdisplay]], _unit] call CBA_fnc_targetEvent;

private _modsfiltered = "";
{
	private _mod = _x select 0;
	_modsfiltered = _modsfiltered + _mod + " - ";
	
} forEach modsdisplay;

copyToClipboard str _modsfiltered;

// Module dialog
[
	"Check player pbos", [["EDIT:MULTI", "Mods loaded", [_modsfiltered, nil, 36]]], {}, {}
] call zen_dialog_fnc_create;

