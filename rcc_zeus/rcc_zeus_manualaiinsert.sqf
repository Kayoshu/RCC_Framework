/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Set up an addAction to dismount AI groups from a helicopter
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached helicopter
 *
 * Return Value:
 * None
 *
 * Example:
 * this execVM "rcc_zeus\rcc_zeus_manualaiinsert.sqf";
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_objectModule", objNull, [objNull]]];

if (!(_objectModule isKindOf "Helicopter")) exitWith {
	["Vehicle needs to be an helicopter"] call zen_common_fnc_showMessage;
	systemChat "Vehicle needs to be an helicopter";
	playSound "FD_Start_F";
};

_objectModule addAction ["Le dismount !", {
	params ["_target", "_caller", "_actionId"];
	 
	private _vhlToDismount = _target;
	private _toDisembark = [];
	{
		if !(_x in units driver _vhlToDismount) then {
			_toDisembark pushBackUnique group _x;
		}
	} foreach crew _vhlToDismount; // find groups within the helicopter that is not from pilote crew

	if (count _toDisembark == 0) exitWith {
		systemChat "No more squad to dismount";
		_vhlToDismount vehicleChat "No more squad to dismount !";
		_vhlToDismount removeAction _actionID;
	 };
	 
	private _calledGroup = _toDisembark select 0; // get next group to disembark
	private _unitCalled = leader _calledGroup;
	private _calledUnits = units _unitCalled;
	private _arrayBuildingPos = [nearestBuilding _unitCalled buildingPos -1, [], {_x#2}, "DESCEND"] call BIS_fnc_sortBy;

	_calledGroup setBehaviour "CARELESS";
	unassignVehicle _unitCalled;
	{
		_x action ["EJECT", vehicle _x];
		_x setUnitPos "MIDDLE";
		_x setSpeedMode "FULL";
	} forEach _calledUnits;
	_calledUnits allowGetIn false;
	sleep 5;

	_calledUnits joinSilent (group _unitCalled); // avoid AI to join the group leader
	doStop _calledUnits;
	sleep 1;

	{
		if (count _arrayBuildingPos <= _forEachIndex) exitWith {};
		_x moveTo _arrayBuildingPos#_forEachIndex;
	} forEach _calledUnits; // move to an available position sorted by highest of nearestBuilding
	_calledGroup setBehaviour "COMBAT";
	
	if (count _toDisembark == 1) then {
		_vhlToDismount vehicleChat "Last squad to dismount !";
		_vhlToDismount removeAction _actionID;
	}

	// _calledUnits joinSilent (group _unitCalled); // needed if we want the group to have waypoint again
}, nil, 1.5, true, true, "", "(!isNull (getAssignedCuratorLogic player))", 5, false, "", ""];