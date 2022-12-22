/*
 * Author: 1er RCC - Kay
 * Fog module
 * Optional Alias Snowstorm Link
 */

params [
	"_snowstorm",
	"_vanilla_fog",
	"_vanilla_fog_duration",
	"_vanilla_fog_density",
	"_vanilla_fog_decay",
	"_vanilla_fog_altitude",
	"_callerId"
];

// vanilla fog transition (fade to chosen values, possible restore after the storm)
// still some limitations to transition speed
_vanilla_fog_duration setFog [_vanilla_fog_density, _vanilla_fog_decay, _vanilla_fog_altitude];

// spawn restore original for after storm
if (_vanilla_fog == 2 && _snowstorm == 2) then {

	al_foglevel = fogparams; // store actual fog
	publicVariable "al_foglevel";
	["Fog pulse with snowstorm"] remoteExec ["systemChat", _callerId];

	sleep 1;
	
	[
		{!snowstorm_on}, 
		{
			params ["_vanilla_fog_duration", "_callerId"];
			_vanilla_fog_duration setFog al_foglevel;
			["Fog restore after snowstorm"] remoteExec ["systemChat", _callerId];
		}, 
		[_vanilla_fog_duration, _callerId]
	] call CBA_fnc_waitUntilAndExecute;
	
};

