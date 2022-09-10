/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Force a player into spectator mode regardless of his remaining lives
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached unit
 *
 * Return Value:
 * None
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

if (!isNull (getAssignedCuratorLogic _unit)) exitWith {
	["Unit is Zeus!"] call zen_common_fnc_showMessage;
	systemChat "Unit is Zeus!";
	playSound "FD_Start_F";
};

_unit setVariable ["RCC_forcespectate", true, true];
