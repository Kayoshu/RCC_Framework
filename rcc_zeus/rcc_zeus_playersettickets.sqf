/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Set all alive players Tickets to a number
 * loop every positive player and set them to number chosen
 *
 * Arguments:
 * No Parameters
 *
 * Return Value:
 * None
 *
 */

if (missionNamespace getVariable "RCC_TplLivesUnlimited") exitWith {
	["Unlimited Lives, Toggle Limited Tickets First"] call zen_common_fnc_showMessage;
	systemChat "Unlimited Lives, Toggle Limited Tickets First";
	playSound "FD_Start_F";
};

private _onConfirm = {
	params ["_dialogResult"]; // we use values on confirm from slider & checkbox
	_dialogResult params ["_notify", "_livestoset"];
	
	{
		private _lifeplayerid = [_x , nil, true] call BIS_fnc_respawnTickets; // current lives
		
		if (_lifeplayerid > 0) then { // only cycle through positive players, -1 might be logging atm or out of the ticket system if logout to lobby
		
			private _plyUID = getPlayerUID _x;
			private _varlives = (round _livestoset) - _lifeplayerid; // calculate total to modify tickets
			[_x, _varlives] call BIS_fnc_respawnTickets; // set tickets
			missionNamespace setVariable ["RCCLives" + _plyUID, round _livestoset, true]; // sync in namespace variable

			if (_notify) then {
				["zen_common_hint", [format["Zeus has set everyone to %1 lives", round _livestoset]], _x] call CBA_fnc_targetEvent; // if notify checkbox inform player
			};
		};
	} forEach allPlayers;
	
	systemChat format["Every player has %1 lives", round _livestoset];

};

// Module dialog 
[
	"Set all alive players Tickets to a number", 
	[
		["CHECKBOX", "Notify players", [false], true],
		["SLIDER", "Set Everyone Lives to", [1 ,10, 1, 0], true]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;
