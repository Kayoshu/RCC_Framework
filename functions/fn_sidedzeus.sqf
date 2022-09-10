/*
 * Author: 1er RCC - Kay
 * Define custom AllVehicles registering for restricted zeus
 *
 * Arguments:
 * 0: GameMaster Module VariableName to be restricted <STRING>
 * 1: Side to register for restricted zeus <NUMBER> (0: opfor, 1: bluefor, 2: inde, 3: civ) (default: 3)
 * 2: OPTIONAL additional objects (not in chosen side) to register <ARRAY> (default: [])
 * 3: OPTIONAL objects (from chosen side) to exclude from register <ARRAY> (default: [])
 *
 * Return Value:
 * None
 *
 * Example:
 * [zeus_restricted, 0] execVM "functions\fn_sidedzeus.sqf";
 *
 */
params [["_restrictedzeus", objNull, [objNull]], ["_restrictedside", 3], ["_additionalobjects", []], ["_excludeobjects", []]];

if (!isServer) exitWith {};

if (isNull _restrictedzeus) exitWith {
	systemChat "No restricted Zeus, variable name undefined"; // local host player is server, systemChat not showing on dedicated
};

// addcuratoreditable at initpost on AllVehicles (units & vehicles)
["AllVehicles", "InitPost", {
	params ["_object"];

	[{
		params ["_object","_restrictedzeus", "_restrictedside","_additionalobjects","_excludeobjects"];
		{
			if (_x == _restrictedzeus) then {
				if ( (getNumber (configFile >> "CfgVehicles" >> typeOf _object >> "side") == _restrictedside) OR (typeOf _object in _additionalobjects) ) then {
					if !( typeOf _object in _excludeobjects) then {
						_x addCuratorEditableObjects [[_object], true];
					};
				};
			} else {
				_x addCuratorEditableObjects [[_object], true];
			};
		} forEach allCurators;
	}, [_object,_restrictedzeus, _restrictedside,_additionalobjects,_excludeobjects]] call CBA_fnc_execNextFrame;
		
}, true, [], true] call CBA_fnc_addClassEventHandler;
