/*
RCC settings
*/
#define CBA_SETTINGS_RCC "1erRCC Settings"

[
	"RCC_grass_removal", 
	"SLIDER", 
	["Time to remove grass","Set to time to cut grass for sniper position"], 
	[CBA_SETTINGS_RCC,"Main"], 
	[5, 30, 8, 0], 
	1, 
	{}, 
	false
] call CBA_fnc_addSetting;