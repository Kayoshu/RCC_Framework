/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Add ACE medical to ammobox or vehicle
 * (detecting advanced bandages & advanced medication)
 *
 * Arguments:
 * 0: logic position (not used)
 * 1: attached object with inventory (vehicle or ammobox)
 *
 * Return Value:
 * None
 *
 * Example:
 * _this execVM "rcc_zeus\rcc_zeus_acemedicbox.sqf";
 *
 */
params [["_pos", [0,0,0] , [[]], 3], ["_box", objNull, [objNull]]];

// if _box is empty or Man unit, exit
if (isNull _box || _box isKindOf "CAManBase") exitWith {
	["Need an objet with inventory: vehicle or box"] call zen_common_fnc_showMessage;
	systemChat "Need an objet with inventory: vehicle or box";
	playSound "FD_Start_F";
};

private _onConfirm = {
	params ["_dialogResult", "_arguments"];
	_arguments params ["_box", "_medicalarray"];

	if (_dialogResult select 0) then {
		clearItemCargoGlobal _box;
		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearBackpackCargoGlobal _box;	
	};

	for "_i" from 0 to (count _dialogResult -1) step 1 do { 
		_box addWeaponCargoGlobal [_medicalarray#(_i*2), _dialogResult#(_i+1)];
	}; 
};

// Construct medical classnames & numbers array
private _medicalarray = ["ACE_fieldDressing", 60, "ACE_tourniquet", 40, "ACE_splint", 20, "ACE_morphine", 25, "ACE_epinephrine", 25, "ACE_bloodIV", 20, "ACE_bloodIV_500", 20, "ACE_bloodIV_250", 20, "ACE_personalAidKit", 0, "ACE_bodyBag", 0];

if (ace_medical_treatment_advancedBandages != 0) then {
	_medicalarray append ["ACE_elasticBandage", 40, "ACE_packingBandage", 40, "ACE_quikclot", 40];
};
if (ace_medical_treatment_advancedMedication) then {
	_medicalarray append ["ACE_adenosine", 25];
};

// Construct dynamic slider from medical array
private _dynamicSlider = [];
private _clearinventory = ["TOOLBOX:YESNO", "Clear Inventory", [true]];
_dynamicSlider pushBack _clearinventory;

for "_i" from 0 to (count _medicalarray -1) step 2 do { 
	_dynamicSliderAdd = ["SLIDER", format ["%1", getText (configFile >> "cfgWeapons" >> _medicalarray#_i >> "displayName")], [0, 80, _medicalarray#(_i+1), 0]];
	_dynamicSlider pushBack _dynamicSliderAdd;
}; 

// Module dialog
[
	"Add ACE Medical", _dynamicSlider, _onConfirm, {}, [_box, _medicalarray] // _box clicked & constructed medical array passed as arguments
] call zen_dialog_fnc_create;
