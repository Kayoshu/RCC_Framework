/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Forcefully delete an entity (should also work with insufficient resssources)
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

if (isNull _object) exitWith {
	["Select an object", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	 playSound "FD_Start_F";
};

if (isPlayer _object) exitWith {
	["You cannot delete players", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

if (!isNil {crew _object}) then {
	{
		_object deleteVehicleCrew _x;
	} forEach crew _object;
};

deleteVehicle _object;

systemChat format["Deleted %1", getText (configOf _object >> "displayName")];
