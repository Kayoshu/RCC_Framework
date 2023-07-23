/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Custom Ending with 5 texts/timers (empty texts are not displayed)
 * Invincibility is applied from the start when clicked "confirm"
 *
 * Arguments:
 * No Parameters
 *
 */

private _customendcontent = missionNamespace getVariable "RCC_CustomEndContent"; // looking for value in missionNamespace with preset texts
if (isNil "_customendcontent") then { // if undefined first time we use the module
	missionNamespace setVariable ["RCC_CustomEndContent", [
		RCC_customend_txt1, 
		RCC_customend_time1, 
		RCC_customend_txt2, 
		RCC_customend_time2, 
		RCC_customend_txt3, 
		RCC_customend_time3, 
		RCC_customend_txt4, 
		RCC_customend_time4, 
		RCC_customend_txt5, 
		RCC_customend_time5, 
		false, 
		false, 
		5, 
		false, 
		false
	], true]; // set RCC_CustomEndContent variable (11th element is dummy)
};

private _onCancel = {
	params ["_dialogResult"];
	missionNamespace setVariable ["RCC_CustomEndContent", _dialogResult, true]; // set missionNamespace variable
};

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_text1", "_timing1", "_text2", "_timing2", "_text3", "_timing3", "_text4", "_timing4", "_text5", "_timing5", "_dummy", "_failed", "_fadetime", "_fadecolor", "_invincible"];

	if (_text1 == "" && _text2 == "" && _text3 == "" && _text4 == "" && _text5 == "") exitWith {
		["All Text Empty", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
        playSound "FD_Start_F";
	};
	
	// construct dynamic texts array
	private _dynamicText = [];
	for "_i" from 0 to 8 step 2 do { 
		if !(_dialogResult#_i == "") then {
			_dynamicTextAdd = [ format ["<t' size = '1'>%1</t>", _dialogResult#_i], -1, 0.2, _dialogResult#(_i+1), 1, 0];
			_dynamicText pushBack _dynamicTextAdd;
		};
	}; 
	
	private _color = ["BLACK", "WHITE"] select _fadecolor;
	private _fadeEffect = [[0, _color, _fadetime, 1, "", "END1", 1], [0, _color, _fadetime, 1, "", "LOSER", 1]] select _failed;

	private _allPlayers = call CBA_fnc_players;
	if (_invincible) then { // apply invincibility
		systemChat "Invincibility ON";
		{
			["zen_common_allowDamage", [_x, false], _x] call CBA_fnc_targetEvent;
			if (!isNull objectParent _x) then {
				["zen_common_allowDamage", [objectParent _x, false], objectParent _x] call CBA_fnc_targetEvent;  // If player is in a vehicle, make that invincible too
			};
		} forEach _allPlayers;
	};
	
	// spawn effects & texts
	[ 
		[_dynamicText, _fadeEffect], 
		{ 
			params ["_dynamicText", "_fadeEffect"];

			private _idlayerend = ["EndingDisplay"] call BIS_fnc_rscLayer;
			for "_i" from 0 to (count _dynamicText - 1) step 1 do { 
				_handle = (_dynamicText#_i + [_idlayerend]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
				sleep 2;
			}; 
			_fadeEffect spawn BIS_fnc_fadeEffect;
		} 
	] remoteExecCall ["spawn", 0, false];
};

// Module dialog 
private _customendstored = missionNamespace getVariable "RCC_CustomEndContent"; // get value in missionNamespace with preset texts/timers
_customendstored params ["_text1", "_timing1", "_text2", "_timing2", "_text3", "_timing3", "_text4", "_timing4", "_text5", "_timing5", "_dummy", "_failed", "_fadetime", "_fadecolor", "_invincible"];

[
	"Mission Custom Ending", 
	[
		["EDIT:MULTI", "Text 1", [_text1, nil, 4]],
		["SLIDER", "Timer Text 1", [2, 20, _timing1, 0]],
		["EDIT:MULTI", "Text 2", [_text2, nil, 4]],
		["SLIDER", "Timer Text 2", [2, 20, _timing2, 0]],
		["EDIT:MULTI", "Text 3", [_text3, nil, 4]],
		["SLIDER", "Timer Text 3", [2, 20, _timing3, 0]],
		["EDIT:MULTI", "Text 4", [_text4, nil, 4]],
		["SLIDER", "Timer Text 4", [2, 20, _timing4, 0]],
		["EDIT:MULTI", "Text 5", [_text5, nil, 4]],
		["SLIDER", "Timer Text 5", [2, 20, _timing5, 0]],
		["LIST", [">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> MISSION END >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"], [[false], [""], 0, 0]], // Dummy for spacing
		["TOOLBOX", "Sets the type of ending", [_failed, 1, 2, ["Mission completed", "Mission failed"]]],
		["SLIDER", "Fade Time before end", [2, 20, _fadetime, 0]], // 2 to 20
		["TOOLBOX", "Fade Color", [_fadecolor, 1, 2, ["Black", "White"]]],
		["CHECKBOX", "Players & Vehicles invincible", [_invincible]]
	],
	_onConfirm,
	_onCancel
] call zen_dialog_fnc_create;