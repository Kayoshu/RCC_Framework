/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Reset Group Limit (288) by deleting empty group
 *
 * Arguments:
 * No Parameters
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _countgroup = 0;
private _countemptygroup = 0;

{
	_countgroup = _countgroup + 1;
	if (count units _x == 0) then {
		_countemptygroup = _countemptygroup + 1;
	}
} forEach allGroups;

private _onConfirm = {
	params ["_dialogResult" ,"_countemptygroup"];
	
	if !(_dialogResult select 0) exitWith {};

	RCC_fnc_GroupDelete = {
		{
			if (count units _x == 0) then {
				deleteGroup _x;
			}
		} forEach allGroups;
	};

	["zen_common_execute", [RCC_fnc_GroupDelete, []]] call CBA_fnc_globalEvent;
	
	[format["%1 Empty Groups deleted", _countemptygroup], -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _currengrouptotal = format["%1 groups, %2 empty", _countgroup, _countemptygroup];

// Module dialog 
[
	_currengrouptotal, [["TOOLBOX:YESNO", "Clear Empty groups", [true], true]], _onConfirm, {}, _countemptygroup // empty groups as argument
] call zen_dialog_fnc_create;