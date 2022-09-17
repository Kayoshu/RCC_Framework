/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * List all players actually in spectator with their respective lives:
 *     -1 is player in spectator having reconnected with 0 life
 *     0 is player dead & in spectator
 *     positive is player in "force spectator"
 *
 * Checkbox to get player out of spectator, either un-force spectator or give him 1 life
 * He will spawn at position of death or debug spawn position regardless of respawnonstart
 *
 * Arguments:
 * No Parameters
 *
 * Return Value:
 * None
 *
 */

// Construct spectators & checkbox arrays
private _dynamicPlayerarray = [];
private _dynamicSliderPlayerarray = [];
private _spectators = [] call ace_spectator_fnc_players;
private _exitcheck = true;

{
	private _lifeplayerid = [_x, nil, true] call BIS_fnc_respawnTickets; // current lives
	private _name = format["%1 (%2) %3", name _x, _lifeplayerid, [" Dead", " FORCED"] select (player getVariable "RCC_forcespectate")];
	
	_dynamicPlayerAdd = ["CHECKBOX", _name, [false], true];
	_dynamicPlayerarray pushBack _x;
	_dynamicSliderPlayerarray pushBack _dynamicPlayerAdd;
	_exitcheck = false;

} forEach _spectators;

if (_exitcheck) exitWith {
	["No players in spectator"] call zen_common_fnc_showMessage;
	systemChat "No players in spectator";
	playSound "FD_Start_F";
};

private _onConfirm = {
	params ["_dialogResult", "_dynamicPlayerarray"]; // we use values on confirm from checkbox & spectator players from previously built menu _dynamicPlayerarray
	
	private _infomodified = "Out of spectator: ";
	
	for "_i" from 0 to (count _dynamicPlayerarray -1) step 1 do { 
		if (_dialogResult#_i) then { // if player is checked get out of spectate
			if ((_dynamicPlayerarray#_i) getVariable "RCC_forcespectate") then { // if force spectate, switch variable
				(_dynamicPlayerarray#_i) setVariable ["RCC_forcespectate", false, true];
				_infomodified = _infomodified + format["%1 - ", name (_dynamicPlayerarray#_i)]; // add name for zeus display	
				
			} else { // else add 1 life and inform player
				[(_dynamicPlayerarray#_i), 1] call BIS_fnc_respawnTickets; // add 1 life
				private _plyUID = getPlayerUID (_dynamicPlayerarray#_i);
				private _lifeplayerid = [(_dynamicPlayerarray#_i), nil, true] call BIS_fnc_respawnTickets; // safety get value again
				missionNamespace setVariable ["RCCLives" + _plyUID, _lifeplayerid, true]; // sync in namespace variable
				//missionNamespace setVariable [name (_dynamicPlayerarray#_i), _lifeplayerid, true]; // sync in namespace variable
				
				systemChat format["DEBUG %1: Out of Spec", "RCCLives" + _plyUID];

				_infomodified = _infomodified + format["%1 - ", name (_dynamicPlayerarray#_i)]; // add name for zeus display
				["zen_common_hint", ["Zeus gave you 1 life"], (_dynamicPlayerarray#_i)] call CBA_fnc_targetEvent; // inform player
			};
		};
	}; 
	systemChat _infomodified;
};

// Module dialog
[
	"List players Dead & Forced Spectators", _dynamicSliderPlayerarray, _onConfirm, {}, _dynamicPlayerarray // spectator players array passed as argument
] call zen_dialog_fnc_create;
