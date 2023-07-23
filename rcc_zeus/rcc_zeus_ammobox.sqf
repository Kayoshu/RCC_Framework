/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Add magazine (of each sort actually in player inventories) to ammobox or vehicle
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object with inventory (vehicle or ammobox)
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

private _magarray = []; // real magazines with ammo count > 1
private _grenadearray = []; // grenades nameSound = handgrenade
private _smokearray = []; // smokes nameSound = smokeshell
private _itemarray = []; // others items

{
	_unit = _x;
	{
		if (getNumber (configFile >> "cfgMagazines" >> _x >> "count") > 1) then {
			_magarray pushBackUnique [getNumber (configFile >> "cfgMagazines" >> _x >> "count"), _x];
		} else {
			if (getText (configFile >> "cfgMagazines" >> _x >> "nameSound") == "handgrenade") then {
				_grenadearray pushBackUnique _x;
			} else {
				if (getText (configFile >> "cfgMagazines" >> _x >> "nameSound") == "smokeshell") then {
					_smokearray pushBackUnique _x;
				} else {
					if (getText (configFile >> "cfgMagazines" >> _x >> "nameSound") != "Chemlight") then {
						_itemarray pushBackUnique _x;
					};
				};
			};
		};
	} forEach (magazines _unit); 
} forEach allPlayers;

// sort by ammo count and build final magazine array
_magarray sort false;
private _magarrayfinal = [];
{
	_magarrayfinal pushBack (_x select 1);
} forEach _magarray;

// sort by classnames
_grenadearray sort true;
_smokearray sort true;
_itemarray sort true;

// Construct dynamic slider from mag array
private _dynamicSlider = [];
private _clearinventory = ["TOOLBOX:YESNO", "Clear Inventory", [true]];
_dynamicSlider pushBack _clearinventory;

for "_i" from 0 to (count _magarrayfinal -1) step 1 do { 
	_dynamicSliderAdd = ["SLIDER", format ["%1", getText (configFile >> "cfgMagazines" >> _magarrayfinal#_i >> "displayName")], [0, 50, 40, 0]];
	_dynamicSlider pushBack _dynamicSliderAdd;
}; 

for "_i" from 0 to (count _grenadearray -1) step 1 do { 
	_dynamicSliderAdd = ["SLIDER", format ["%1", getText (configFile >> "cfgMagazines" >> _grenadearray#_i >> "displayName")], [0, 50, 8, 0]];
	_dynamicSlider pushBack _dynamicSliderAdd;
}; 

for "_i" from 0 to (count _smokearray -1) step 1 do { 
	_dynamicSliderAdd = ["SLIDER", format ["%1", getText (configFile >> "cfgMagazines" >> _smokearray#_i >> "displayName")], [0, 50, 5, 0]];
	_dynamicSlider pushBack _dynamicSliderAdd;
}; 

for "_i" from 0 to (count _itemarray -1) step 1 do { 
	_dynamicSliderAdd = ["SLIDER", format ["%1", getText (configFile >> "cfgMagazines" >> _itemarray#_i >> "displayName")], [0, 50, 4, 0]];
	_dynamicSlider pushBack _dynamicSliderAdd;
}; 

_magarrayfinal append _grenadearray;
_magarrayfinal append _smokearray;
_magarrayfinal append _itemarray;

// Module dialog 
[
	"Add players ammunitions", _dynamicSlider, _onConfirm, {}, [_box, _magarrayfinal] // _box clicked & constructed mag array passed as arguments
] call zen_dialog_fnc_create;