/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Toggle between limited lives and unlimited respawn
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
		missionNamespace setVariable ["RCC_TplLivesUnlimited", true, true];
		systemChat "Unlimited Lives";
	} else {
		missionNamespace setVariable ["RCC_TplLivesUnlimited", false, true];
		systemChat "Limited Tickets";
	};
	
};

private _unlimtemplate = missionNamespace getVariable "RCC_TplLivesUnlimited";

// Module dialog
[
	"Toggle Tickets Respawn", [["TOOLBOX", "Respawn", [_unlimtemplate, 1, 2, ["Limited Tickets", "Unlimited"]], true]], _onConfirm, {}
] call zen_dialog_fnc_create;