/*
 * Author: ALIAS
 * SNOW STORM SCRIPT Init JIP
 * Client-side script
 * Check if snowstorm initialized, if so check missionNamespace variable to exec local sfx
 * 
 * Modified for 1er RCC by Kay
 *
 * Return Value:
 * local sfx variable for snowstorm
 *
 */

if (isNil "snowstorm_on") exitWith {}; // exit if snowstorm not init

if !(snowstorm_on) exitWith {}; // exit also if not running local variable will be set by PerFrameHandler
 
private _customparams = missionNamespace getVariable "RCC_SnowstormParams"; // looking for value in missionNamespace
_customparams params ["_duration_storm", "_snowfall", "_local_fog", "_breath_vapors", "_snow_burst", "_unitsneeze", "_intensifywind", "_ambient_sounds_al"];

// init all local variables sfx to default
player setVariable ["RCC_Alias_snowfallSfx", false, true];
player setVariable ["RCC_Alias_mediumfogSfx", false, true];
player setVariable ["RCC_Alias_snowbreathSfx", false, true];
player setVariable ["RCC_Alias_unitsneezeSfx", false, true];
player setVariable ["RCC_Alias_randomgustSfx", false, true];
player setVariable ["RCC_Alias_windsoundSfx", false, true];

// init Alias CheckPos for player
execVM "rcc_zeus\AL_snowstorm\fn_checkposPlayer.sqf";

// snowfallSfx
[_snowfall] execVM "rcc_zeus\AL_snowstorm\fn_snowfallSfx.sqf";

// mediumfogSfx on player
[_local_fog] execVM "rcc_zeus\AL_snowstorm\fn_mediumfogSfx.sqf";

// snowbreathSfx vapors around
[_breath_vapors]execVM "rcc_zeus\AL_snowstorm\fn_snowbreathSfx.sqf";

// units sneeze around
[_unitsneeze] execVM "rcc_zeus\AL_snowstorm\fn_unitsneezeSounds.sqf";

// local snowgust sfx
[_unitsneeze, _snow_burst] execVM "rcc_zeus\AL_snowstorm\fn_snowburstClient.sqf";

// local wind sound
[_intensifywind] execVM "rcc_zeus\AL_snowstorm\fn_intensSounds.sqf";
