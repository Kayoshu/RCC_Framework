/*
 * Author: 1er RCC - Kay
 * Custom Zeus Right-Click action
 * Teleport player on squad member
 *
 * Arguments:
 * 0: player
 *
 * Return Value:
 * None
 *
 * Example:
 * this execVM "rcc_zeus\rcc_zeus_tpsquadmember.sqf";
 *
 */
params ["_hoveredEntity"];

private _onConfirm = {
	params ["_dialogResult","_in"];
	_dialogResult params ["_tpTarget"];
	_in params ["_hoveredEntity"];
	
	if (isNull _hoveredEntity) exitWith {};

	_hoveredEntity setvelocity [0,0,0]; // Reset velocity 

	// if target in vehicle
	if (_tpTarget != vehicle _tpTarget) then {
		// try to move into vehicle, if it can't, just move next to vehicle
		private _movedIntoVic = _hoveredEntity moveInAny (vehicle _tpTarget);
		if (!_movedIntoVic) then {
			_hoveredEntity setVehiclePosition [_tpTarget, [], 0, ""]; // failed to move into, we just gonna tp next to vic
		};
	} else {
		_hoveredEntity setVehiclePosition [_tpTarget, [], 0, ""]; // not in vic, teleport directly
	};	
};

private _allSquadMembers = units group _hoveredEntity;
_allSquadMembers deleteAt (_allSquadMembers find _hoveredEntity); // Remove _hoveredEntity from the list

if (count _allSquadMembers == 0) exitWith {
	 ["Player is alone in squad"] call zen_common_fnc_showMessage;
	 systemChat "Player is alone in squad";
	 playSound "FD_Start_F";
};

// Get pretty names array
private _allSquadMembersNames = _allSquadMembers apply {
	private _name = "";
	if (_x == leader _x) then {
		_name = format ["[SL] - %1", name _x]
	} else {
		_name = name _x
	};
	
	if (_x != vehicle _x) then {_name = _name + format [" - [%1]", getText (configFile >> "cfgVehicles" >> typeOf vehicle _x >> "displayName")]}; // If in vic, add vic tag
	
	_name;
};

[
	"Select SquadMember to teleport to", 
	[
		["LIST","Squad Members",[_allSquadMembers, _allSquadMembersNames, 0, 16]]
	],
	_onConfirm,
	{},
	_hoveredEntity
] call zen_dialog_fnc_create;
