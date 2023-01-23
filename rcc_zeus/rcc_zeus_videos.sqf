/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Play Videos (path defined in CBA settings)
 *
 * Arguments:
 * No Parameters
 *
 * Return Value:
 * None
 *
 */

private _videopath_array = ["", RCC_videopath1, RCC_videopath2, RCC_videopath3, RCC_videopath4, RCC_videopath5, RCC_videopath6, RCC_videopath7, RCC_videopath8];
 
private _onConfirm = {
	params ["_dialogResult", "_videopath_array"];
	
	_dialogResult params ["_path_number", "_excludezeus", "_excludedrivers", "_environment", "_userinput", "_tfarmute"];

	if (_videopath_array#_path_number == "") exitWith {
		["No vid selected", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
        playSound "FD_Start_F";
	};
	
	["RCC_video_play", [_videopath_array#_path_number, _excludezeus, _excludedrivers, _environment, _userinput]] call CBA_fnc_globalEvent;
	
};

// Module dialog 

[
	"Play Videos", 
	[
		["TOOLBOX",["Videos"], [0, count _videopath_array, 1, [
			["Select one of the 6 videos below"], 
			[_videopath_array select 1], 
			[_videopath_array select 2], 
			[_videopath_array select 3], 
			[_videopath_array select 4], 
			[_videopath_array select 5], 
			[_videopath_array select 6], 
			[_videopath_array select 7], 
			[_videopath_array select 8]
		]], true], 
		["TOOLBOX:YESNO", "Exclude Zeus", [false], true], 
		["TOOLBOX:YESNO", "Exclude Vehicule Drivers", [false], true], 
		["TOOLBOX:YESNO", "Disable Sounds", [false], true], 
		["TOOLBOX:YESNO", "Disable User Input", [false], true], 
		["TOOLBOX:YESNO", "TFAR Mute", [false], true]
	],
	_onConfirm,
	{}, 
	_videopath_array
] call zen_dialog_fnc_create;