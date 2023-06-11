/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Add magazine (of each sort actually in player inventories) to ammobox or vehicle
 * (detecting advanced bandages & advanced medication)
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object with inventory (vehicle or ammobox)
 *
 * Return Value:
 * None
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_box", objNull, [objNull]]];

// if param is empty or Man unit, exit
if (isNull _box || _box isKindOf "CAManBase") exitWith {
	["Need an objet with inventory: vehicle or box", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	playSound "FD_Start_F";
};

private _onConfirm = {
	params ["_dialogResult", "_arguments"];
	_arguments params ["_box", "_ammoarray"];
	
	if (_dialogResult select 0) then {
		clearItemCargoGlobal _box;
		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearBackpackCargoGlobal _box;	
	};

	for "_i" from 0 to (count _ammoarray -1) step 1 do { 
		_box addMagazineCargoGlobal [_ammoarray#_i, _dialogResult#(_i+1)];
	}; 

};

// Construct magazine classnames array
private _ammoarray = [];
{
	_unit = _x;
	{
		_ammoarray pushBackUnique _x;
	} forEach (magazines _unit); 
} forEach allPlayers;

// Construct dynamic slider from mag array
private _dynamicSlider = [];
private _clearinventory = ["TOOLBOX:YESNO", "Clear Inventory", [true]];
_dynamicSlider pushBack _clearinventory;

for "_i" from 0 to (count _ammoarray -1) step 1 do { 
	_dynamicSliderAdd = ["SLIDER", format ["%1", getText (configFile >> "cfgMagazines" >> _ammoarray#_i >> "displayName")], [0, 50, 10, 0]];
	_dynamicSlider pushBack _dynamicSliderAdd;
}; 

// Module dialog 
[
	"Add players ammunitions", _dynamicSlider, _onConfirm, {}, [_box, _ammoarray] // _box clicked & constructed mag array passed as arguments
] call zen_dialog_fnc_create;