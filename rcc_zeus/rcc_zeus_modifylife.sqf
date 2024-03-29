/*
 * Author: 1er RCC - Kay
 * Called from a ZEN context menu action.
 * Modify individual player lives
 *
 * Arguments:
 * 0: position (not used)
 * 1: object player
 *
 * Example:
 * [_position, _player] execVM "rcc_zeus\rcc_zeus_modifylife.sqf";
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult", "_unit"];
	_dialogResult params ["_lifes"];
	
	private _lifeplayerid = [_unit, nil, true] call BIS_fnc_respawnTickets; // selected player current lives
	private _plyUID = getPlayerUID _unit;
	private _newlives = round _lifes; // store total lives after modify
	private _lifes = _newlives - _lifeplayerid; // calculate difference for tickets change

	[_unit, _lifes] call BIS_fnc_respawnTickets; // modify selected player tickets
	missionNamespace setVariable ["RCCLives" + _plyUID, _newlives, true]; // sync in namespace variable

	systemChat format["%3 %2: %1 vies", _newlives, _plyUID, name _unit];
};


private _lifeplayerid = [_unit, nil, true] call BIS_fnc_respawnTickets; // Get current lives of player displayed as current in slider

// Module dialog
[
	"Modify player lives", [["SLIDER",name _unit,[1, 12, _lifeplayerid, 0], true]], _onConfirm, {}, _unit // unit cliked as argument
] call zen_dialog_fnc_create;
