/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Toggle safestart
 *
 * Arguments:
 * No Parameters
 *
 * Return Value:
 * None
 *
 */

private _onConfirm = {
	params ["_dialogResult"];
	
	if (_dialogResult select 0) then {
		missionNamespace setVariable ["RCC_SafeStart", true, true];
		["Safestart ON", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	} else {
		missionNamespace setVariable ["RCC_SafeStart", false, true];
		["Safestart OFF", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	};
	
};

private _safestart = missionNamespace getVariable "RCC_SafeStart";

// Module dialog
[
	"Toggle Safe Start", [["TOOLBOX", "Safe Start", [_safestart, 1, 2, ["Off ", "ON"]], true]], _onConfirm, {}
] call zen_dialog_fnc_create;