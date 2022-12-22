/*
 * Author: ALIAS
 * SNOW STORM SCRIPT ambient sounds global sfx
 * Modified for 1er RCC by Kay
 * Server-side script
 * 
 * Spawn ambient sounds around hunt_alias
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
 
params ["_ambient_sounds"];

if (!isServer) exitWith {};  // only on server-side

// already running & param ON then exit with new loop duration
if ((missionNamespace getVariable "RCC_SnowstormAmbientSounds") && (_ambient_sounds > 0)) exitWith {
	RCC_SnowstormAmbientSoundsLoop = _ambient_sounds;
};

// not running & param OFF exit
if (!(missionNamespace getVariable "RCC_SnowstormAmbientSounds") && (_ambient_sounds == 0)) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((missionNamespace getVariable "RCC_SnowstormAmbientSounds") && (_ambient_sounds == 0)) exitWith { 
	missionNamespace setVariable ["RCC_SnowstormAmbientSounds", false, true];
};

// not running & param ON then set loop duration and continue 
if (!(missionNamespace getVariable "RCC_SnowstormAmbientSounds") && (_ambient_sounds > 0)) then { 
	RCC_SnowstormAmbientSoundsLoop = _ambient_sounds;
	missionNamespace setVariable ["RCC_SnowstormAmbientSounds", true, true];
};

// previously hardcoded path
lupus_01 = getMissionPath ((getArray (missionConfigFile >> "CfgSounds" >> "ALsnow_lup01" >> "sound")) select 0);
lupus_02 = getMissionPath ((getArray (missionConfigFile >> "CfgSounds" >> "ALsnow_lup02" >> "sound")) select 0);
lupus_03 = getMissionPath ((getArray (missionConfigFile >> "CfgSounds" >> "ALsnow_lup03" >> "sound")) select 0);

while {missionNamespace getVariable "RCC_SnowstormAmbientSounds"} do {

	sleep (60 + random RCC_SnowstormAmbientSoundsLoop);
	
	// previous test of pos_p is useless in server context
	_natura = selectRandom [lupus_01, lupus_02, lupus_03];
	_relpos = hunt_alias getRelPos [100 + (random 200), 360];
	playSound3D [_natura, "", false, [_relpos#0, _relpos#1, 50 + (random 100)], 0.2, 0.7, 2000];

};