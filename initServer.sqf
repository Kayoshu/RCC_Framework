//
// initServer.sqf
// Executes only on the server at mission start
// No parameters are passed to this script
//


// define if unlimited template selected at lobby
if (paramsArray select 0 == 10) then {
	missionNamespace setVariable ["RCC_TplLivesUnlimited", true, true];
} else {
	missionNamespace setVariable ["RCC_TplLivesUnlimited", false, true];
};


// init Restricted Zeus object register
// Parameters:
// 0: GameMaster Module VariableName
// 1: Side to register (0: opfor, 1: bluefor, 2: inde, 3: civ)
// 2: OPTIONAL additional objects <ARRAY>
// 3: OPTIONAL objects excluded <ARRAY>
// private _additionalobjects = ["I_Heli_light_03_unarmed_F","I_Heli_light_03_dynamicLoadout_F"];
// private _excludeobjects = ["O_Heli_Light_02_unarmed_F"];

// [zeus_restricted, 0, _additionalobjects, _excludeobjects] execVM "functions\fn_sidedzeus.sqf";


// mission variables for zeus modules
// missionNamespace setVariable ["CountSound", 1, true]; // init count for sound box module
missionNamespace setVariable ["RCC_CustomEndLock", false, true]; // init variable to lock custom end editing in multizeus
missionNamespace setVariable ["RCC_SafeStart", false, true]; // init variable for safestart at spawn
