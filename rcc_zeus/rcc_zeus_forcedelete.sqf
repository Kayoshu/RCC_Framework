/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Forcefully delete an entity (should also work with insufficient resssources)
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object
 *
 * Return Value:
 * None
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

if (isNull _object) exitWith {
	 ["Select an object"] call zen_common_fnc_showMessage;
	 systemChat "Select an object";
	 playSound "FD_Start_F";
};

if (isPlayer _object) exitWith {
	["You can't delete players"] call zen_common_fnc_showMessage;
	systemChat "You can't delete players";
	playSound "FD_Start_F";
};

if (!isNil {crew _object}) then {
	{
		_object deleteVehicleCrew _x;
	} forEach crew _object;
};

deleteVehicle _object;

["Deleted %1", getText (configOf _object >> "displayName")] call zen_common_fnc_showMessage;
systemChat format["Deleted %1", getText (configOf _object >> "displayName")];
