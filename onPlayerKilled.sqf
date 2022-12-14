/*
 * onPlayerKilled.sqf
 * Executed when player is killed in singleplayer or in multiplayer mission
 * This event script will also fire at the beginning of a mission if respawnOnStart is 0 or 1
 *
 * Parameters: _oldUnit, _killer, _respawn, _respawnDelay
 *
 */
params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];


// Handle lives synchro according to limited/unlimited template
private _unlimtemplate = missionNamespace getVariable "RCC_TplLivesUnlimited";

// unlimited template
if (_unlimtemplate) then {
	[player, 1] call BIS_fnc_respawnTickets; // allways +1 at death if unlimited template
};

// synchro to namespace
private _lifeplayerid = [player, nil, true] call BIS_fnc_respawnTickets; // get current lives after death
private _plyUID = getPlayerUID player;
missionNamespace setVariable ["RCCLives" + _plyUID, _lifeplayerid, true]; // sync in namespace variable
