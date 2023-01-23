/*
CBA Settings 1erRCC
*/

#define CBA_SETTINGS_RCC_MAIN "1erRCC Settings - Main"
#define CBA_SETTINGS_RCC_MODCUSTOMEND "1erRCC Settings - Module CustomEnd"
#define CBA_SETTINGS_RCC_MODVIDEOS "1erRCC Settings - Module Videos"


// grass removal
[
	"RCC_grassremoval_time", 
	"SLIDER", 
	["Time to remove grass","Set to time to cut grass for sniper position"], 
	[CBA_SETTINGS_RCC_MAIN,"Self-Interactions"], 
	[5, 30, 8, 0], 
	1, 
	{}, 
	false
] call CBA_fnc_addSetting;


// module CustomEnd
["RCC_customend_txt1", "EDITBOX", ["Text 1"], [CBA_SETTINGS_RCC_MODCUSTOMEND], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_customend_time1", "SLIDER", ["Time 1"], [CBA_SETTINGS_RCC_MODCUSTOMEND], [2, 20, 4, 0], 1, {}, false] call CBA_fnc_addSetting;

["RCC_customend_txt2", "EDITBOX", ["Text 2"], [CBA_SETTINGS_RCC_MODCUSTOMEND], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_customend_time2", "SLIDER", ["Time 2"], [CBA_SETTINGS_RCC_MODCUSTOMEND], [2, 20, 4, 0], 1, {}, false] call CBA_fnc_addSetting;

["RCC_customend_txt3", "EDITBOX", ["Text 3"], [CBA_SETTINGS_RCC_MODCUSTOMEND], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_customend_time3", "SLIDER", ["Time 3"], [CBA_SETTINGS_RCC_MODCUSTOMEND], [2, 20, 4, 0], 1, {}, false] call CBA_fnc_addSetting;

["RCC_customend_txt4", "EDITBOX", ["Text 4"], [CBA_SETTINGS_RCC_MODCUSTOMEND], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_customend_time4", "SLIDER", ["Time 4"], [CBA_SETTINGS_RCC_MODCUSTOMEND], [2, 20, 4, 0], 1, {}, false] call CBA_fnc_addSetting;

["RCC_customend_txt5", "EDITBOX", ["Text 5"], [CBA_SETTINGS_RCC_MODCUSTOMEND], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_customend_time5", "SLIDER", ["Time 5"], [CBA_SETTINGS_RCC_MODCUSTOMEND], [2, 20, 4, 0], 1, {}, false] call CBA_fnc_addSetting;


// module videos
["RCC_videopath1", "EDITBOX", ["Path to video 1","ogv extension needed"], [CBA_SETTINGS_RCC_MODVIDEOS], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_videopath2", "EDITBOX", ["Path to video 2","ogv extension needed"], [CBA_SETTINGS_RCC_MODVIDEOS], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_videopath3", "EDITBOX", ["Path to video 3","ogv extension needed"], [CBA_SETTINGS_RCC_MODVIDEOS], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_videopath4", "EDITBOX", ["Path to video 4","ogv extension needed"], [CBA_SETTINGS_RCC_MODVIDEOS], "", 1, {}, false] call CBA_fnc_addSetting;
["RCC_videopath5", "EDITBOX", ["Path to video 5","ogv extension needed"], [CBA_SETTINGS_RCC_MODVIDEOS], "", 1, {}, false] call CBA_fnc_addSetting;
