/*
 * Author: ALIAS
 * SNOW STORM SCRIPT medium fog local sfx
 * Modified for 1er RCC by Kay
 * Client-side script
 * 
 * Spawn fog depending on player position
 * Added local variable to keep status on fx running on player
 * Now possible to unable/disable fx individually
 *
 * Arguments:
 * _local_fog
 *
 * Return Value:
 * none
 *
 */

params ["_local_fog"];

if (!hasInterface) exitWith {}; // only client-side

waitUntil {!isNil "pos_p"};

// already running & param ON then exit
if ((player getVariable "RCC_Alias_mediumfogSfx") && _local_fog) exitWith {};

// not running & param OFF exit
if (!(player getVariable "RCC_Alias_mediumfogSfx") && !_local_fog) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((player getVariable "RCC_Alias_mediumfogSfx") && !_local_fog) exitWith { 
	player setVariable ["RCC_Alias_mediumfogSfx", false];
};

// not running & param ON then set local sfx variable true
player setVariable ["RCC_Alias_mediumfogSfx", true];

while {!isNull player} do {

	if (pos_p == "Alias_open") then {
		_localfogSfx  = "#particlesource" createVehicleLocal (getpos player);
		_localfogSfx  setParticleCircle [10, [3 , 3, 0]];
		_localfogSfx  setParticleRandom [2, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
		_localfogSfx  setParticleParams [["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 8, [0, 0, 0], [-1, -1, 0], 3, 10.15, 7.9, 0.03, [5, 10, 10], [[0.5, 0.5, 0.5, 0], [0.5, 0.5, 0.5, 0.1], [1, 1, 1, 0]], [1], 1, 0, "", "", player];
		_localfogSfx  setDropInterval 0.1;
		waitUntil {(pos_p != "Alias_open") OR !(player getVariable "RCC_Alias_mediumfogSfx")};
		deleteVehicle _localfogSfx ;
	};
	
	if (pos_p == "Alias_in_car") then {
		_localfogSfx  = "#particlesource" createVehicleLocal (getpos player);
		_localfogSfx  setParticleCircle [30, [3, 3, 0]];
		_localfogSfx  setParticleRandom [0, [0.25, 0.25, 0], [1, 1, 0], 1, 1,[ 0, 0, 0, 0.1], 0, 0];
		_localfogSfx  setParticleParams [["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 4, [0, 0, 0], [-1, -1, 0], 3, 10.15, 7.9, 0.03, [5, 10, 20], [[0.5, 0.5, 0.5, 0], [0.5, 0.5, 0.5, 0.1], [1, 1, 1, 0]], [1], 1, 0, "", "", player];
		_localfogSfx  setDropInterval 0.1;		
		waitUntil {(pos_p != "Alias_in_car") OR !(player getVariable "RCC_Alias_mediumfogSfx")};
		deleteVehicle _localfogSfx ;
	};
	
	if (pos_p == "Alias_in_house") then {
		_localfogSfx  = "#particlesource" createVehicleLocal (getpos player);
		_localfogSfx  setParticleCircle [Alias_sizesnow, [3, 3, 0]];
		_localfogSfx  setParticleRandom [0, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0];
		_localfogSfx  setParticleParams [["\A3\data_f\cl_basic",1,0,1], "", "Billboard", 1, 4, [0, 0, 0], [-1, -1, 0], 3, 10.15, 7.9, 0.03, [5, 10, 20], [[0.5, 0.5, 0.5, 0], [0.5, 0.5, 0.5, 0.1], [1, 1, 1, 0]], [1], 1, 0, "", "", player];
		_localfogSfx  setDropInterval 0.1;		
		waitUntil {(pos_p != "Alias_in_house") OR !(player getVariable "RCC_Alias_mediumfogSfx")};
		deleteVehicle _localfogSfx ;
	};
	
	if (pos_p == "Alias_under_water") then {
		waitUntil {(pos_p != "Alias_under_water") OR !(player getVariable "RCC_Alias_mediumfogSfx")};
	};
	
	if (pos_p == "Alias_deep_sea") then {
		waitUntil {(pos_p != "Alias_deep_sea") OR !(player getVariable "RCC_Alias_mediumfogSfx")};
	};
	
	// exit while if local sfx turned OFF
	if !(player getVariable "RCC_Alias_mediumfogSfx") exitWith {};

};