/*
 * Author: ALIAS
 * SNOW STORM SCRIPT snowburst client
 * Modified for 1er RCC by Kay
 * Client-side script
 * 
 * Spawn snowburst depending on hunt_alias position
 * If _unitsneeze enable ppEffect on gust
 * Added local variable to keep status on fx running on player
 * Now possible to unable/disable fx individually
 *
 * Arguments:
 * _unitsneeze
 *
 * Return Value:
 * none
 *
 */

params ["_unitsneeze", "_snow_burst"];

if (!hasInterface) exitWith {}; // only client-side

waitUntil {!isNil "pos_p"};

if (_unitsneeze) then {
	player_act_cold = true;
} else {
	player_act_cold = false;
};

// already running & param ON then exit
if ((player getVariable "RCC_Alias_randomgustSfx") && (_snow_burst > 0)) exitWith {};

// not running & param OFF exit
if (!(player getVariable "RCC_Alias_randomgustSfx") && (_snow_burst == 0)) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((player getVariable "RCC_Alias_randomgustSfx") && (_snow_burst == 0)) exitWith { 
	player setVariable ["RCC_Alias_randomgustSfx", false];
};

// not running & param ON then set local sfx variable true
player setVariable ["RCC_Alias_randomgustSfx", true];

while {!isNull player} do {

	if ((pos_p == "Alias_open") && (player == hunt_alias)) then {
		// previously broadcasted global variable "rafala" was not used anywhere
		
		_pozitie_x = (selectrandom [1, -1]) * round (random 50);
		_pozitie_y = (selectrandom [1, -1]) * round (random 50);
		[[_pozitie_x, _pozitie_y], "rcc_zeus\AL_snowstorm\fn_tremblingSfx.sqf"] remoteExec ["execVM", 0];
		
		sleep (snow_gust#1);
	};
	
	sleep 20 + (random interval_burst);

	if !(player getVariable "RCC_Alias_randomgustSfx") exitWith {};	
};