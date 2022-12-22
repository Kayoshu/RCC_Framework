/*
 * Author: ALIAS
 * SNOW STORM SCRIPT Init
 * Server-side script
 * 
 * Modified for 1er RCC by Kay
 *
 * Return Value:
 * snowstorm_on public variable (true if snowstorm is running)
 *
 */

if (!isServer) exitWith {}; // only on server-side

params [
	"_snowstorm",
	"_duration_storm",
	"_snowfall",
	"_local_fog",
	"_breath_vapors",
	"_snow_burst",
	"_unitsneeze",
	"_intensifywind",
	"_ambient_sounds_al",
	"_callerId"
];

// if STOP selected publicvariable false and exit script
if (_snowstorm == 1) exitWith { 
	snowstorm_on = false;
	publicvariable "snowstorm_on";
	missionNamespace setVariable ["RCC_SnowstormParams", [300, false, false, false, 0, false, false, 0], true]; // set RCC_SnowstormParams default
	
	// set all local sfx to false on players
	{
		_x setVariable ["RCC_Alias_snowfallSfx", false, true];
		_x setVariable ["RCC_Alias_mediumfogSfx", false, true];
		_x setVariable ["RCC_Alias_snowbreathSfx", false, true];
		_x setVariable ["RCC_Alias_unitsneezeSfx", false, true];
		_x setVariable ["RCC_Alias_randomgustSfx", false, true];
		_x setVariable ["RCC_Alias_windsoundSfx", false, true];
		
	} foreach allPlayers;
	
	// set all server sfx to false
	missionNamespace setVariable ["RCC_SnowstormAmbientSounds", false, true];
	missionNamespace setVariable ["RCC_SnowstormRandomGust", false, true];
	
	if !(isNil "RCC_PFEHcountdownSnow") then { // remove PerFrameHandler only if it exists
		[RCC_PFEHcountdownSnow] call CBA_fnc_removePerFrameHandler;
	};
};

// if no snowstorm active create PerFrameHandler
if (!snowstorm_on) then {
	snowstorm_on = true;
	publicvariable "snowstorm_on";
	
	// countdown server for zeus feedback
	RCC_countdownSnowEndTime = time + _duration_storm;
	RCC_PFEHcountdownSnow = [
		{
			params ["_callerId"];
			_timeLeft = RCC_countdownSnowEndTime - time;
			snowstorm_remaining = round _timeLeft;
			publicvariable "snowstorm_remaining";
			if (_timeLeft < 1) exitWith {
				snowstorm_on = false;
				publicvariable "snowstorm_on";
				[RCC_PFEHcountdownSnow] call CBA_fnc_removePerFrameHandler;
				missionNamespace setVariable ["RCC_SnowstormParams", [300, false, false, false, 0, false, false, 0], true]; // set RCC_SnowstormParams default
				// set all local sfx to false on players
				{
					_x setVariable ["RCC_Alias_snowfallSfx", false, true];
					_x setVariable ["RCC_Alias_mediumfogSfx", false, true];
					_x setVariable ["RCC_Alias_snowbreathSfx", false, true];
					_x setVariable ["RCC_Alias_unitsneezeSfx", false, true];
					_x setVariable ["RCC_Alias_randomgustSfx", false, true];
					_x setVariable ["RCC_Alias_windsoundSfx", false, true];
					
				} foreach allPlayers;
				// set all server sfx to false
				missionNamespace setVariable ["RCC_SnowstormAmbientSounds", false, true];
				missionNamespace setVariable ["RCC_SnowstormRandomGust", false, true];
				["Snowstorm Ended", -1, 1, 3, 0] remoteExec ["BIS_fnc_dynamicText", _callerId];
			};
			if (_timeLeft < 60) then {
				[format["Snowstorm remaining: %1 sec", round _timeLeft], -1, 1, 1, 0] remoteExec ["BIS_fnc_dynamicText", _callerId];
			};
		}, 10, _callerId
	] call CBA_fnc_addPerFrameHandler;
} else {
	// if already snowstorm_on only modify duration
	RCC_countdownSnowEndTime = time + _duration_storm;
};

// init hunt_alias server-side once
if (isNil "hunt_alias") then {
	[] execVM "rcc_zeus\AL_snowstorm\fn_aliasHunt.sqf";
	waitUntil {!isNil "hunt_alias"};
};

// init Alias CheckPos for each player
["rcc_zeus\AL_snowstorm\fn_checkposPlayer.sqf"] remoteExec ["execVM", 0];

// snowfallSfx
// todo: if CUP loaded maybe use snowflakes texture from chernarus winter (also used in al_trembling.sqf for snow bursts)
[[_snowfall], "rcc_zeus\AL_snowstorm\fn_snowfallSfx.sqf"] remoteExec ["execVM", 0];

// mediumfogSfx centered on player
[[_local_fog], "rcc_zeus\AL_snowstorm\fn_mediumfogSfx.sqf"] remoteExec ["execVM", 0];

// snowbreathSfx vapors around each player
[[_breath_vapors], "rcc_zeus\AL_snowstorm\fn_snowbreathSfx.sqf"] remoteExec ["execVM", 0];

// ambientSounds wolves server-side
[_ambient_sounds_al] execVM "rcc_zeus\AL_snowstorm\fn_ambientSounds.sqf";

// units sneeze around player
[[_unitsneeze], "rcc_zeus\AL_snowstorm\fn_unitsneezeSounds.sqf"] remoteExec ["execVM", 0];

// snow burst (if higher than '0' snowburst is generated based on that interval, effect on unit shivering)
[_snow_burst] execVM "rcc_zeus\AL_snowstorm\fn_snowburstServer.sqf";

// init local snowgust sfx on players
[[_unitsneeze, _snow_burst], "rcc_zeus\AL_snowstorm\fn_snowburstClient.sqf"] remoteExec ["execVM", 0];

// only local wind sound now
// not happy with the previous wind level
// ace_weather_windSimulation needed to be false and maybe ace_weather_enabled also had an effect on transition speed 
[[_intensifywind], "rcc_zeus\AL_snowstorm\fn_intensSounds.sqf"] remoteExec ["execVM", 0];
