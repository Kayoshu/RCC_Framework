/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Forces a unit to wake up or go unconscious, regardless if they have stable vitals or not.
 * (works with AI without killing them)
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

// If opening on a vehicle
_unit = effectiveCommander _unit;

if !(_unit isKindOf "CAManBase") exitWith {
	 ["Select a unit"] call zen_common_fnc_showMessage;
	 systemChat "Select a unit";
	 playSound "FD_Start_F";
};

if (!alive _unit) exitWith {
	["Unit is dead"] call zen_common_fnc_showMessage;
	systemChat "Unit is dead";
	playSound "FD_Start_F";
};

["zen_common_execute", [ace_medical_status_fnc_setUnconsciousState, [_unit, !(_unit getVariable ["ACE_isUnconscious", false])]], _unit] call CBA_fnc_targetEvent;
