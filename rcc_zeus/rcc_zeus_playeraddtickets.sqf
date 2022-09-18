/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Add Tickets to all alive players
 * loop every positive player and add tickets to all of them
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
	_dialogResult params ["_notify", "_livestoadd"];
	
	{
		private _lifeplayerid = [_x , nil, true] call BIS_fnc_respawnTickets; // get current lives
		
		if (_lifeplayerid > 0) then { // only cycle through positive players, -1 might be logging atm or out of the ticket system if logout to lobby
		
			private _plyUID = getPlayerUID _x;
			private _varlives = round _livestoadd + _lifeplayerid; // calculate total to store in namespace
			[_x, round _livestoadd] call BIS_fnc_respawnTickets; // set tickets
			missionNamespace setVariable ["RCCLives" + _plyUID, _varlives, true]; // sync in namespace variable

			if (_notify) then {
				["zen_common_hint", [format["Zeus has added %1 lives to everyone", round _livestoadd]], _x] call CBA_fnc_targetEvent; // if notify checkbox inform player
			};
		};
	} forEach allPlayers;

	systemChat format["%1 lives added to every alive player", round _livestoadd];

};


// Module dialog 
[
	"Add Tickets to all alive players", 
	[
		["CHECKBOX", "Notify players", [false], true],
		["SLIDER", "Lives to add to all alive players", [1 ,10, 1, 0], true]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;
