/*
 * Author: ALIAS
 * SNOW STORM SCRIPT snowfall local sfx
 * Modified for 1er RCC by Kay
 * Client-side script
 * 
 * Spawn snowfall depending on player position
 * Added local variable to keep status on fx running on player
 * Now possible to unable/disable fx individually
 *
 * Arguments:
 * _snowfall
 *
 * Return Value:
 * none
 *
 */

params ["_snowfall"];

if (!hasInterface) exitWith {}; // only client-side

waitUntil {!isNil "pos_p"};

// already running & param ON then exit
if ((player getVariable "RCC_Alias_snowfallSfx") && _snowfall) exitWith {};

// not running & param OFF exit
if (!(player getVariable "RCC_Alias_snowfallSfx") && !_snowfall) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((player getVariable "RCC_Alias_snowfallSfx") && !_snowfall) exitWith { 
	player setVariable ["RCC_Alias_snowfallSfx", false];
};

// not running & param ON then set local sfx variable true
player setVariable ["RCC_Alias_snowfallSfx", true];

while {!isNull player} do {

	if (pos_p == "Alias_open") then {
		_snowfallSfx = "#particlesource" createVehiclelocal getposaTL player;
		_snowfallSfx setParticleCircle [0, [0, 0, 0]];
		_snowfallSfx setParticleRandom [0, [20, 20, 9], [0, 0, 0], 0, 0.1, [0, 0, 0, 0.1], 0, 0];
		_snowfallSfx setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, 7, [0, 0, 10], [0,0,0], 3, 1.7, 1, 1.0, [0.1], [[1,1,1,1]], [1], 0.3, 1, "", "", player];
		_snowfallSfx setDropInterval 0.005;
		waitUntil {(pos_p != "Alias_open") OR !(player getVariable "RCC_Alias_snowfallSfx")};
		deleteVehicle _snowfallSfx;
	};
	
	if (pos_p == "Alias_in_car") then {
		_snowfallSfx = "#particlesource" createVehiclelocal getposaTL player;
		_snowfallSfx setParticleCircle [0, [0, 0, 0]];
		_snowfallSfx setParticleRandom [0, [20, 20, 9], [0, 0, 0], 0, 0.1, [0, 0, 0, 0.1], 0, 0];
		_snowfallSfx setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, 7, [0, 0, 10], [0,0,0], 3, 1.7, 1, 1.0, [0.1], [[1,1,1,1]], [1], 0.3, 1, "", "", player];
		_snowfallSfx setDropInterval 0.005;
		waitUntil {(pos_p != "Alias_in_car") OR !(player getVariable "RCC_Alias_snowfallSfx")};
		deleteVehicle _snowfallSfx;
	};
	
	if (pos_p == "Alias_under_water") then {
		_snowfallSfx = "#particlesource" createVehiclelocal getposaTL player; // now use player instead of helipad attached
		_snowfallSfx setParticleCircle [0, [0, 0, 0]];
		_snowfallSfx setParticleRandom [0, [25, 25, 0], [0, 0, 0], 0, 0.1, [0, 0, 0, 0.1], 1, 1];
		_snowfallSfx setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, 4, [0, 0, 16], [0,0,0], 3, 2.0, 1, 0.7, [0.1], [[1,1,1,1]], [1], 1, 1, "", "", player]; // use player & 1 meter higher
		_snowfallSfx setDropInterval 0.005;
		waitUntil {(pos_p != "Alias_under_water") OR !(player getVariable "RCC_Alias_snowfallSfx")};
		deleteVehicle _snowfallSfx;
	};
	
	if (pos_p == "Alias_deep_sea") then {
		waitUntil {(pos_p != "Alias_deep_sea") OR !(player getVariable "RCC_Alias_snowfallSfx")};
	};
	
	if (pos_p == "Alias_in_house") then {
		_snowfallSfx = "#particlesource" createVehiclelocal getposATL Alias_building;
		_snowfallSfx setParticleCircle [Alias_sizesnow, [0, 0, 0]];
		_snowfallSfx setParticleRandom [0, [5, 5, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0.5];
		_snowfallSfx setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, 0.2, [0, 0, 1], [0,0,0], 3, 2, 1, 0, [0.1], [[1,1,1,1]], [1], 0, 1,"", "rcc_zeus\AL_snowstorm\fn_snowfallDrop.sqf", Alias_building, 0, true];
		_snowfallSfx setDropInterval 0.01;		
		waitUntil {(pos_p != "Alias_in_house") OR !(player getVariable "RCC_Alias_snowfallSfx")};
		deleteVehicle _snowfallSfx;
	};
	
	// exit while if local sfx turned OFF
	if !(player getVariable "RCC_Alias_snowfallSfx") exitWith {};

};