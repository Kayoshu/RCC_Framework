/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Toggle safestart
 *
 * Arguments:
 * No Parameters
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_safestart", "_silent"];
	
	missionNamespace setVariable ["RCC_SafeStart", _safestart, true];
	
	if (_safestart) then {
		["RCC_player_safezone", [_silent, false]] call CBA_fnc_globalEvent;
	} else {
		// reset local variable on players
		private _players = [] call CBA_fnc_players;
		{
			_x setVariable ["RCC_safezone", false, true];
		} forEach _players;
	};
	
};

private _safestart = missionNamespace getVariable "RCC_SafeStart";

// Module dialog
[
	"Toggle Safe Start", [
		["TOOLBOX:YESNO", "Safe Start", [_safestart], true], 
		["TOOLBOX:YESNO", ["Silent Safe", "Do not inform players, use to toggle midgame"], [true], true]
	], _onConfirm, {}
] call zen_dialog_fnc_create;