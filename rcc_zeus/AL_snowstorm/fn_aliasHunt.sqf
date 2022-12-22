/*
 * Author: ALIAS
 * SNOW STORM SCRIPT aliasHunt
 * Modified for 1er RCC by Kay
 * Server-side script
 * 
 * Give a random public hunt_alias each 60sec for localized FXs
 * Once init this runs forever on server
 * Same code as thunderstorm as it only runs once on server (will be moved to global function later)
 * 
 * same func is also used in duststorm & monsoon
 * (files are not the same and not checking isNil hunt_alias)
 *
 * Arguments:
 * none
 *
 * Return Value:
 * hunt_alias public variable
 *
 */

if (!isServer) exitWith {}; // only on server-side

private _PFEHhunt_alias = [
	{
		_allunits = [];
		
		// exclude ACE spectators from alias hunt (needed for RCC tickets template)
		private _players = [] call CBA_fnc_players;
		private _spec = [] call ace_spectator_fnc_players;
		private _playing = _players - _spec;
		
		{
			if (alive _x) then {_allunits pushBack _x};
		}  foreach _playing;
		
		hunt_alias = selectRandom _allunits;
		publicVariable "hunt_alias";

	}, 60
] call CBA_fnc_addPerFrameHandler;
