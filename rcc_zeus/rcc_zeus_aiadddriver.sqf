/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Add addaction "autopilot" to the vehicle
 * (Give to the player ability to spawn an AI as driver in order to move while controling the turret)
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached vehicle
 *
 * Return Value:
 * None
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_tgtVhl", objNull, [objNull]]];

// if param is empty or Man unit, exit
if (isNull _tgtVhl || !(_tgtVhl isKindOf "LandVehicle")) exitWith {
	["Need a land vehicle", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _localaction = _tgtVhl getVariable "RCC_autopilot";

if !(isNil "_localaction") exitWith {
	["Vehicle already with autopilot", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

_tgtVhl setVariable ["RCC_autopilot", true, true];

RCC_fnc_aiadddriver = {
	params ["_tgtVhl"];
	_tgtVhl addaction ["<t color='#82FA58'>Pourvoir en pilote</t>", "rcc_zeus\rcc_fnc_autoPilote.sqf", nil, 1.5, false, true, "", "vehicle _this == _target", 4, false];
};

{
	["zen_common_execute", [RCC_fnc_aiadddriver, [_tgtVhl]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;
