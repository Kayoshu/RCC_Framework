/*
 * Author: 1er RCC - Kay
 * Snowstorm module (from Aliascartoon scripts)
 * Create a snowstorm
 * Optional Vanilla Fog Transition possible
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object (not used)
 *
 * Return Value:
 * none
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_object", objNull, [objNull]]];
 
// module first use
if (isNil "snowstorm_on") then {
	// set Snowstorm publicvariable to default as it need to exist for init
	snowstorm_on = false;
	publicvariable "snowstorm_on";
	
	missionNamespace setVariable ["RCC_SnowstormParams", [300, false, false, false, 0, false, false, 0], true]; // set RCC_SnowstormParams variable to share active parameters
	
	// init local sfx variables on players
	{
		_x setVariable ["RCC_Alias_snowfallSfx", false, true];
		_x setVariable ["RCC_Alias_mediumfogSfx", false, true];
		_x setVariable ["RCC_Alias_snowbreathSfx", false, true];
		_x setVariable ["RCC_Alias_unitsneezeSfx", false, true];
		_x setVariable ["RCC_Alias_randomgustSfx", false, true];
		_x setVariable ["RCC_Alias_windsoundSfx", false, true];
	} foreach allPlayers;
	
	// init all server sfx
	missionNamespace setVariable ["RCC_SnowstormAmbientSounds", false, true];
	missionNamespace setVariable ["RCC_SnowstormRandomGust", false, true];
}; 

private _onConfirm = {
	params ["_dialogResult", "_callerId"];
	_dialogResult params [
		"_dummy1",
		"_snowstorm",
		"_duration_storm", 
		"_snowfall", 
		"_local_fog", 
		"_breath_vapors", 
		"_snow_burst", 
		"_unitsneeze", 
		"_ambient_sounds_al", 
		"_intensifywind", 
		"_dummy2",
		"_vanilla_fog", 
		"_vanilla_fog_duration", 
		"_vanilla_fog_density", 
		"_vanilla_fog_decay", 
		"_vanilla_fog_altitude"
	];

	if (_snowstorm == 2) then {
		missionNamespace setVariable ["RCC_SnowstormParams", [_duration_storm, _snowfall, _local_fog, _breath_vapors, _snow_burst, _unitsneeze, _intensifywind, _ambient_sounds_al], true]; // set RCC_SnowstormParams to share parameters
	};
	
	// exec initsnow server-side it not NO CHANGE
	if !(_snowstorm == 0) then {
		[[_snowstorm, _duration_storm, _snowfall, _local_fog, _breath_vapors, _snow_burst, _unitsneeze, _intensifywind, _ambient_sounds_al, _callerId], "rcc_zeus\AL_snowstorm\fn_initSnowstorm.sqf"] remoteExec ["execVM", [0, 2] select isDedicated];
	};
	
	// exec initfog server-side it not NO CHANGE
	if !(_vanilla_fog == 0) then {
		[[_snowstorm, _vanilla_fog, _vanilla_fog_duration, _vanilla_fog_density, _vanilla_fog_decay, _vanilla_fog_altitude, _callerId], "rcc_zeus\AL_snowstorm\fn_initFog.sqf"] remoteExec ["execVM", [0, 2] select isDedicated];
	};
};


private _customparams = missionNamespace getVariable "RCC_SnowstormParams"; // looking for value in missionNamespace
_customparams params ["_duration_storm", "_snowfall", "_local_fog", "_breath_vapors", "_snow_burst", "_unitsneeze", "_intensifywind", "_ambient_sounds_al"];

private _callerId = clientOwner; // get caller NetId for zeus feedback
private _actualfog = fogparams;
private _displaystatus = "Status: Off";

if (!isNil "snowstorm_remaining" && snowstorm_on) then {
	private _lifetime = snowstorm_remaining;
	_displaystatus = format["Status: %1 sec remaining", _lifetime];
};

// Module dialog 
[
	"Snowstorm & Vanilla Fog Transition", 
	[
		["LIST", [">>>>>>>>>>>>>>>>>>>> SNOWSTORM"], [[false], [""], 0, 0]], // Dummy for title
		["TOOLBOX",[_displaystatus, "Status of the snowstorm, if you choose STOP, it stops the current storm"], [0, 1, 3, [["NO CHANGE", "No change"], ["STOP", "Stop Snowstorm"], ["SNOWSTORM", "Activate snowstorm for duration"]]], true],
		["SLIDER", ["Lifetime", "Life time of the snowstorm in seconds"], [60, 3600, _duration_storm, 0]],
		["TOOLBOX:YESNO", "Enable Snow", [_snowfall]],
		["TOOLBOX:YESNO", ["Local Fog", "If true particles will be used to create sort of waves of fog and snow"], [_local_fog]],
		["TOOLBOX:YESNO", ["Enable Breath Vapors", "If true you will see breath vapors for all units, HOWEVER if you have many units in your mission you should set this false to diminish the impact on frames"], [_breath_vapors]],
		["SLIDER", ["Snow Burst", "If higher than '0' burst of snow will be generated at intervals"], [0, 120, _snow_burst, 0]],
		["TOOLBOX:YESNO", [">>> Units Sneezing/Shivering", "If is true at random units will sneeze/caugh and will shiver when snow burst occurs"], [_unitsneeze]],
		["SLIDER", ["Ambient Wolves Sounds", "Random number will be generated with your input and delay ambient sounds (0 is disable)"], [0, 120, _ambient_sounds_al, 0]],
		["TOOLBOX:YESNO", ["Intense wind", "If is true sound will blow with force"], [_intensifywind]],
		["LIST", [">>>>>>>>>>>>>>>>>>>> FOG"], [[false], [""], 0, 0]], // Dummy for title
		["TOOLBOX",["Vanilla Fog", "Vanilla fog will be transitioned by the module"], [0, 1, 3, [["NO CHANGE", "No change"], ["TRANSITION", "Transition to new values"], ["STORM", "Transition & Restore original fog after storm"]]], true],
		["SLIDER", [">>> Duration", "Time for the vanilla fog to reach values"], [10, 240, 30, 0], true],
		["SLIDER:PERCENT", [">>> Fog Density", "Density of vanilla fog after transition (displayed is current)"], [0, 1, _actualfog select 0], true],
		["SLIDER:PERCENT", [">>> Fog Decay", "Decay of vanilla fog after transition (displayed is current)"], [-1, 1, _actualfog select 1], true],
		["SLIDER", [">>> Fog Altitude", "Altitude of vanilla fog after transition (displayed is current)"], [0, 600, _actualfog select 2, 0], true]
	],
	_onConfirm,
	{},
	_callerId
] call zen_dialog_fnc_create;