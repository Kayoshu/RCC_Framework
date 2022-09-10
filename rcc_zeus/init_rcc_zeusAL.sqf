/*
 * Author: 1er RCC - Kay
 * Register custom RCC modules for AliasCartoon Scripts
 * Executes at mission start
 *
 * Arguments:
 * No arguments
 *
 * Return Value:
 * None
 *
 */

if (!hasInterface) exitWith {};

private _hasZen = isClass (configFile >> "CfgPatches" >> "zen_custom_modules");
if !(_hasZen) exitWith { systemChat "ZEN not detected";};

// AL fog
["1er RCC Environment", "Fog Low", {_this execVM "rcc_zeus\rcc_zeus_AL_lowfog.sqf";}, "\a3\Modules_F_Curator\Data\portraitSmoke_ca.paa"] call zen_custom_modules_fnc_register;
["1er RCC Environment", "Fog Ring", {_this execVM "rcc_zeus\rcc_zeus_AL_ringfog.sqf";}, "\a3\Modules_F_Curator\Data\iconSmoke_ca.paa"] call zen_custom_modules_fnc_register;