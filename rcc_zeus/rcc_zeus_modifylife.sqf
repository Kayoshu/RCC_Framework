/*
 * Author: 1er RCC - Kay
 * Custom Zeus module (lives template)
 * Modify individual player lives
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached player
 *
 * Return Value:
 * None
 *
 * Example:
 * this execVM "rcc_zeus\rcc_zeus_modifylife.sqf";
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult", "_unit"];
	_dialogResult params ["_lifes"];
	
	private _lifeplayerid = [_unit, nil, true] call BIS_fnc_respawnTickets; // selected player current lives
	private _plyUID = getPlayerUID _unit;
	private _oldlives = round _lifes; // store total lives after modify
	private _lifes = round _lifes - _lifeplayerid; // calculate difference for tickets change

	[_unit, _lifes] call BIS_fnc_respawnTickets; // modify selected player tickets
	missionNamespace setVariable ["RCCLives" + _plyUID, _oldlives, true]; // sync in namespace variable
	//missionNamespace setVariable [name _unit, _oldlives, true]; // set namespace to total

	systemChat format["DEBUG %2: %1 vies", _oldlives, "RCCLives" + _plyUID];
	//systemChat format["%2: %1 vies", _oldlives, name _unit];
};


private _lifeplayerid = [_unit, nil, true] call BIS_fnc_respawnTickets; // Get current lives of player displayed as current in slider

// Module dialog
[
	"Modify player lives", [["SLIDER",name _unit,[1, 12, _lifeplayerid, 0], true]], _onConfirm, {}, _unit // unit cliked as argument
] call zen_dialog_fnc_create;
