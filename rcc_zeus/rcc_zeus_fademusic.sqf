/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Modify music volume over time
 *
 * Arguments:
 * No Parameters
 *
 * TODO: Rework wuth CBA Event instead of zen_common_execute
 */

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_volume", "_timing"];
	
	RCC_fnc_modifyMusic = {
		params ["_volume", "_timing"];
		_timing fadeMusic _volume;
	};
	
	{
		["zen_common_execute", [RCC_fnc_modifyMusic, [_volume, _timing]], _x] call CBA_fnc_targetEvent;
	} forEach allPlayers;
};

[
	"Fade Music", 
	[
		["SLIDER", "Volume", [0, 1, musicVolume, 2], true],
		["SLIDER", "Time (sec)", [0, 30, 5, 0]]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;
