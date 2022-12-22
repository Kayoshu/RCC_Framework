/*
 * Author: ALIAS
 * SNOW STORM SCRIPT unit sneeze sounds local sfx
 * Modified for 1er RCC by Kay
 * Client-side script
 * 
 * Spawn unit sneeze sounds around player
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

params ["_unitsneeze"];
 
if (!hasInterface) exitWith {}; // only client-side

waitUntil {!isNil "pos_p"};

// already running & param ON then exit
if ((player getVariable "RCC_Alias_unitsneezeSfx") && _unitsneeze) exitWith {};

// not running & param OFF exit
if (!(player getVariable "RCC_Alias_unitsneezeSfx") && !_unitsneeze) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((player getVariable "RCC_Alias_unitsneezeSfx") && !_unitsneeze) exitWith { 
	player setVariable ["RCC_Alias_unitsneezeSfx", false];
};

// not running & param ON then set local sfx variable true
player setVariable ["RCC_Alias_unitsneezeSfx", true];

private ["_sick_unit"];

while {!isNull player} do {

	// added underwater as new with values deepsea is approx eyelevel 0
	if (pos_p in ["Alias_open", "Alias_in_house", "Alias_in_car", "Alias_under_water"]) then {
	
		enableCamShake true;
		if (eyePos player select 2 > 0) then {
			_coughing = selectRandom ["ALsnow_tuse1", "ALsnow_tuse2", "ALsnow_tuse3", "ALsnow_tuse4", "ALsnow_tuse5", "ALsnow_tuse6"];

			// exclude ACE spectators from unit sneeze (needed for RCC tickets template)
			_spec = [] call ace_spectator_fnc_players;

			// previous use of _sick_unit = selectrandom allUnits; cycle through all units in mission (units un debug area, at the other side of the map, maybe kilometers away from actual player hearing)
			// why not select nearEntities as for breath vapors
			// if solo player with no AI around _sick_unit will always be that player
			// may need tweaking for sleep + random for frequency
			_footmobile = player nearEntities ["Man", 40];

			_playing = _footmobile - _spec;
			_sick_unit = selectRandom _playing;
			
			[_sick_unit, [_coughing, 100]] remoteExec ["say3d", 0];
		};
		if (player == _sick_unit) then {
			addCamShake [5, 1, 7];
		};
	};
	
	// you can tweak sleep value if you want to hear playable units coughing more or less often	
	sleep (120 + random 120);

	// exit while if local variable sfx false
	if !(player getVariable "RCC_Alias_unitsneezeSfx") exitWith {};	
};