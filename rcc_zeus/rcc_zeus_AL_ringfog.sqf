/*
 * Author: 1er RCC - Kay
 * Ring Fog module (from Aliascartoon scripts)
 * Add a ring fog centered on an helipad at position
 *
 * Arguments:
 * 0: fog position
 * 1: attached object (not used)
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult", "_pos"];
	
	_maincolor = _dialogResult select 0;
	
	_HeliPos= ASLToATL (_pos);	
	_helipad = createVehicle ["Land_HelipadEmpty_F", _pos vectorAdd [0, 0, 1], [], 0, "CAN_COLLIDE"];
	_helipad setposATL _HeliPos;
	_helipad setVariable ["AL_high_ON", true, true]; // still setting a variable on object created, could be used to delete all at once
	
	[[_helipad, _maincolor], "rcc_zeus\AL_localfog\high_fog.sqf"] remoteExec ["execVM", 0, true];
	["zen_common_addObjects", [[_helipad]]] call CBA_fnc_serverEvent;

};

// Module dialog 
[
	"Spawn ring fog at position", [["COLOR", "Fog Color", [1,1,1], true]], _onConfirm, {}, _pos // _pos passed as argument
] call zen_dialog_fnc_create;