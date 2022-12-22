/*
 * Author: ALIAS
 * SNOW STORM SCRIPT breath vapor local sfx
 * Modified for 1er RCC by Kay
 * Client-side script
 * 
 * Spawn breath vapor on units around player
 * Added local variable to keep status on fx running on player
 * Now possible to unable/disable fx individually
 *
 * Arguments:
 * _breath_vapors
 *
 * Return Value:
 * none
 *
 */

params ["_breath_vapors"];

if (!hasInterface) exitWith {}; // only client-side

// already running & param ON then exit
if ((player getVariable "RCC_Alias_snowbreathSfx") && _breath_vapors) exitWith {};

// not running & param OFF exit
if (!(player getVariable "RCC_Alias_snowbreathSfx") && !_breath_vapors) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((player getVariable "RCC_Alias_snowbreathSfx") && !_breath_vapors) exitWith { 
	player setVariable ["RCC_Alias_snowbreathSfx", false];
};

// not running & param ON then set local sfx variable true
player setVariable ["RCC_Alias_snowbreathSfx", true];

private _alias_breath = "Land_HelipadEmpty_F" createVehiclelocal [0, 0, 0];
_alias_breath attachto [player, [0, 0.2, 0], "head"];

while {!isNull player} do {

	if ((alive player) && (eyePos player select 2 > 0)) then {
		private _footmobile = player nearEntities ["Man", 20];
		_rnd = selectrandom _footmobile;
		_alias_breath attachto [_rnd, [0, 0.1, 0], "head"];
		_flow = (getposasl _alias_breath vectorFromTo (_alias_breath getRelPos [10, 90])) vectorMultiply 0.5;
	
		drop [["\A3\data_f\ParticleEffects\Universal\Universal",16,12,8,1], "", "Billboard", 0.15, 0.3, [0, 0, 0], [_flow#0, _flow#1, -0.2], 3, 1.2, 1, 0, [0.1, 0.2, 0.3], [[1, 1, 1, 0.05], [1, 1, 1, 0.2], [1, 1, 1, 0.05]], [0.1], 0, 0.04, "", "rcc_zeus\AL_snowstorm\fn_snowbreathDrop.sqf", _alias_breath, 90];
		sleep 0.15;
		
		drop [["\A3\data_f\ParticleEffects\Universal\Universal",16,12,8,1], "", "Billboard", 0.15, 0.3, [0, 0, 0], [_flow#0/2, _flow#1/2, -0.2], 3, 1.2, 1, 0, [0.1, 0.2, 0.3], [[1, 1, 1, 0.05], [1, 1, 1, 0.1], [1, 1, 1, 0]], [0.1], 0, 0.04, "", "", _alias_breath, 90];
		sleep (5 + random 5);
	} else {
		sleep 10;
	};
	
	// exit while if local sfx turned OFF
	if !(player getVariable "RCC_Alias_snowbreathSfx") exitWith {};
};

// delete breath vapor helipad when local fx disabled
deleteVehicle _alias_breath;