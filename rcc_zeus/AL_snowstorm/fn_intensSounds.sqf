/*
 * Author: ALIAS
 * SNOW STORM SCRIPT wind sounds local sfx
 * Modified for 1er RCC by Kay
 * Client-side script
 * 
 * Spawn local wind sound around player
 * Added mission variable to keep status of fx running
 * Now possible to unable/disable fx individually
 *
 * Arguments:
 * _ambient_sounds
 *
 * Return Value:
 * none
 *
 */

params ["_intensifywind"];

if (!hasInterface) exitWith {}; // only client-side

// already running & param ON then exit
if ((player getVariable "RCC_Alias_windsoundSfx") && _intensifywind) exitWith {};

// not running & param OFF exit
if (!(player getVariable "RCC_Alias_windsoundSfx") && !_intensifywind) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((player getVariable "RCC_Alias_windsoundSfx") && !_intensifywind) exitWith { 
	player setVariable ["RCC_Alias_windsoundSfx", false];
};

// not running & param ON then set local sfx variable true
player setVariable ["RCC_Alias_windsoundSfx", true];

while {player getVariable "RCC_Alias_windsoundSfx"} do {
	playSound "ALsnow_bcgwind";
	sleep 42;
};