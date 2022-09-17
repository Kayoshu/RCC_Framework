/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Modify Individual Tickets
 * loop every positive player for individual modify
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

// Construct player & slider arrays
private _dynamicPlayerarray = [];
private _dynamicSliderPlayerarray = [];
private _notifyplayers = ["CHECKBOX", "Notify players", [false], true];
_dynamicSliderPlayerarray pushBack _notifyplayers;

{
	private _lifeplayerid = [_x, nil, true] call BIS_fnc_respawnTickets; // get current lives
	
	// only cycle through positive players, -1 might be logging atm or out of the ticket system if logout to lobby
	if (_lifeplayerid > 0) then {
		_dynamicPlayerAdd = ["SLIDER", name _x, [1, 12, _lifeplayerid, 0], true];
		_dynamicPlayerarray pushBack _x;
		_dynamicSliderPlayerarray pushBack _dynamicPlayerAdd;
	};
	
} forEach allPlayers;

private _onConfirm = {
	params ["_dialogResult", "_dynamicPlayerarray"]; // we use values on confirm from sliders & player objects from previously built menu _dynamicPlayerarray
	
	private _infomodified = "";
	
	for "_i" from 0 to (count _dynamicPlayerarray -1) step 1 do { 
	
		private _lifeplayerid = [(_dynamicPlayerarray#_i), nil, true] call BIS_fnc_respawnTickets; // current player lives
		private _oldlives = round (_dialogResult#(_i+1)); // store lives after modify
		
		if (_lifeplayerid != _oldlives) then { // only modify player when numbers differs
		
			private _plyUID = getPlayerUID (_dynamicPlayerarray#_i);
			private _lifes = round (_dialogResult#(_i+1)) - _lifeplayerid; // calculate difference for tickets change

			[(_dynamicPlayerarray#_i), _lifes] call BIS_fnc_respawnTickets; // modify player tickets
			missionNamespace setVariable ["RCCLives" + _plyUID, _oldlives, true]; // sync in namespace variable
			//missionNamespace setVariable [name (_dynamicPlayerarray#_i), _oldlives, true]; // sync in namespace variable

			_infomodified = _infomodified + format["DEBUG %2: %1 vies - ", _oldlives, "RCCLives" + _plyUID]; // add name for zeus display
			//_infomodified = _infomodified + format["%2: %1 vies - ", _oldlives, name (_dynamicPlayerarray#_i)]; // add name for zeus display
			
			if (_dialogResult#0) then {
				["zen_common_hint", [format["Zeus modified: %1 lives", _oldlives]], (_dynamicPlayerarray#_i)] call CBA_fnc_targetEvent; // if notify checkbox inform player
			};
		};

	}; 
	systemChat _infomodified;
};

// ZEN dialog 
[
	"Modify Individual Tickets", 
	_dynamicSliderPlayerarray,
	_onConfirm,
	{},
	_dynamicPlayerarray // player objects array passed as argument
] call zen_dialog_fnc_create;