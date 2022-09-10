/*
 * Author: 1er RCC - Kay
 * Action "autopilot"
 * Give to the player ability to spawn an AI as driver in order to move while controling the turret.
 *
 * Arguments:
 * 0: vehicle triggering action
 * 1: player triggering action
 *
 * Return Value:
 * None
 *
 * Example (in eden init field):
 * this setVariable ["RCC_autopilot", true, true];
 * this addaction ["<t color='#82FA58'>Pourvoir en pilote</t>", "rcc_zeus\rcc_fnc_autoPilote.sqf", nil, 1.5, false, true, "", "vehicle _this == _target", 4, false];
 *
 */
params ["_vehicle", "_caller"];

if (isPlayer (driver _vehicle)) exitWith {systemChat "Vous êtes déjà à la place de conducteur.";};
if !(isNull (driver _vehicle)) then {deleteVehicle (driver _vehicle)};

private _sidecaller = side _caller;
private _classDriver = "";

switch (_sidecaller) do
{
	case west: {
		_classDriver = "B_Soldier_F"; // B_Soldier_F: Nato fusilier
		// BWA3_Crew_Multi: @bwmod crew
	};
	case east: {
		_classDriver = "O_crew_F"; // O_crew_F: Opfor crew
	};
	case independent: {
		_classDriver = "I_crew_F"; // I_crew_F: AAF crew
	};
	case civilian: {
		_classDriver = "C_man_1";
	};
};

_grpcaller = group _caller;
_pilote = _grpcaller createUnit [_classDriver, getPosATL _caller, [], 0, "NONE"];
systemChat "Pilote créé";
_pilote moveInDriver _vehicle;
_pilote disableAI "all";

_pilote addEventHandler ["GetOutMan", {deleteVehicle (_this select 0);}];
_pilote addEventHandler ["SeatSwitchedMan", {deleteVehicle (_this select 0);}];