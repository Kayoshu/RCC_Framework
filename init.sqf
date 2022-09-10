//
// init.sqf
// Executes at mission start
// No parameters are passed to this script
//

// init ACE Medical convert on Killed AI
execVM "functions\fn_FirstAidconvertACE.sqf";

// init RCC Zeus Custom Modules
execVM "rcc_zeus\init_rcc_zeus.sqf";
execVM "rcc_zeus\init_rcc_zeusAL.sqf";
