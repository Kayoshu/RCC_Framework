/*
 * Author: ALIAS
 * SNOW STORM SCRIPT snowburst server
 * Modified for 1er RCC by Kay
 * Server-side script
 * 
 * Select random snowburst sound & gust velocity
 * Server-side that can run on PerFrameEventHandler during all snowstorm
 * Also run the client side part of snowgust/shivering
 *
 * Arguments:
 * _snow_burst
 *
 * Return Value:
 * snow_gust, gustvelocity_x, gustvelocity_y
 *
 */

params ["_snow_burst"];
 
if (!isServer) exitWith {}; // only on server-side

// already running & param ON then exit with new loop duration
if ((missionNamespace getVariable "RCC_SnowstormRandomGust") && (_snow_burst > 0)) exitWith {
	interval_burst = _snow_burst;
	publicVariable "interval_burst";
};

// not running & param OFF exit
if (!(missionNamespace getVariable "RCC_SnowstormRandomGust") && (_snow_burst == 0)) exitWith {};

// already running & param OFF then exit with local sfx variable false
if ((missionNamespace getVariable "RCC_SnowstormRandomGust") && (_snow_burst == 0)) exitWith { 
	missionNamespace setVariable ["RCC_SnowstormRandomGust", false, true];
};

missionNamespace setVariable ["RCC_SnowstormRandomGust", true, true];
interval_burst = _snow_burst;
publicVariable "interval_burst";

private _PFEHselectRandomGust = [
	{
		snow_gust = selectrandom [["ALsnow_rafala1", 12], ["ALsnow_rafala2", 8.5], ["ALsnow_rafala3", 17], ["ALsnow_rafala5", 13], ["ALsnow_rafala6", 16], ["ALsnow_rafala7", 13.5]];
		publicVariable "snow_gust";
		
		gustvelocity_x = (selectrandom [1, -1]) * round (2 + random 5);
		gustvelocity_y = (selectrandom [1, -1]) * round (2 + random 5);
		publicVariable "gustvelocity_x";
		publicVariable "gustvelocity_y";
		
		if !(missionNamespace getVariable "RCC_SnowstormRandomGust") exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};
	}, 60
] call CBA_fnc_addPerFrameHandler;
