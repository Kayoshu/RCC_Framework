/*
 * Author: 1er RCC - Kay
 * Eventhandler to intercept projectiles in safezone/safestart
 *
 * Arguments:
 * No parameters
 *
 * Return Value:
 * None
 *
 */

 
// Init safe zone variable to false
player setVariable ["RCC_safezone", false, true];

// eventhandler for safe zone
player addEventHandler ["FiredMan", 
{ 
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

	if (missionNamespace getVariable "RCC_SafeStart" OR player getVariable "RCC_safezone") then {
		if (_weapon isEqualTo "Throw") exitWith { 
			systemChat "No throwables allowed";
			deleteVehicle _projectile;
			_unit addMagazine _magazine;
		}; 
		systemChat "No shooting allowed";
		deleteVehicle _projectile;
	};
}];
