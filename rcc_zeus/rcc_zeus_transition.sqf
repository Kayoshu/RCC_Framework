/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Preset texts & Timers in CBA Settings
 * 4 Transition Texts (empty texts are not displayed)
 * Text position: top, middle, bottom
 *
 * Arguments:
 * No Parameters
 *
 */

params [["_pos", [0,0,0] , [[]], 3], ["_unit", objNull, [objNull]]];

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_textposition", "_text1", "_timing1", "_text2", "_timing2", "_text3", "_timing3", "_text4", "_timing4", "_side", "_persidetext"];

	if (_text1 == "" && _text2 == "" && _text3 == "" && _text4 == "") exitWith {
		["Need at least 1 text", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
        playSound "FD_Start_F";
	};
	
	if (_persidetext) then {
		[format["Sent to side: %1", _side], -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
	};
	
	// spawn texts
	[ 
		[_textposition, _text1, _timing1, _text2, _timing2, _text3, _timing3, _text4, _timing4, _side, _persidetext], { 
		
			params ["_textposition", "_text1", "_timing1", "_text2", "_timing2", "_text3", "_timing3", "_text4", "_timing4", "_side", "_persidetext"];

			if (!hasInterface) exitWith {}; // only client-side
			
			if (!((side player) in _side) && _persidetext) exitWith {};

			private "_handle";
			private _idlayertransition = ["TextTransitionDisplay"] call BIS_fnc_rscLayer;
			
			if !(_text1 == "") then {
				_text1 = [ format ["<t' size = '1'>%1</t>", _text1], -1, _textposition, _timing1, 1, 0];
				_handle = (_text1 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
			if !(_text2 == "") then {
				_text2 = [ format ["<t' size = '1'>%1</t>", _text2], -1, _textposition, _timing2, 1, 0];
				_handle = (_text2 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
			if !(_text3 == "") then {
				_text3 = [ format ["<t' size = '1'>%1</t>", _text3], -1, _textposition, _timing3, 1, 0];
				_handle = (_text3 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
			if !(_text4 == "") then {
				_text4 = [ format ["<t' size = '1'>%1</t>", _text4], -1, _textposition, _timing4, 1, 0];
				_handle = (_text4 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
		} 
	] remoteExecCall ["spawn", 0, false];
	
};

// Module dialog 
[
	"Transition Texts", 
	[
		["COMBO", "Text position", [[1, 0.3, -0.2], [["Bottom"], ["Middle"], ["Top"]], 0]],
		["EDIT:MULTI", "Text 1", ["", nil, 4], false],
		["SLIDER", "Timer Text 1", [2, 20, 5, 0], false],
		["EDIT:MULTI", "Text 2", ["", nil, 4], false],
		["SLIDER", "Timer Text 2" , [2, 20, 5, 0], false],
		["EDIT:MULTI", "Text 3", ["", nil, 4], false],
		["SLIDER", "Timer Text 3" , [2, 20, 5, 0], false],
		["EDIT:MULTI", "Text 4", ["", nil, 4], false],
		["SLIDER", "Timer Text 4" , [2, 20, 5, 0], false],
		["SIDES", "Sides"],
		["TOOLBOX:YESNO", "Texts per Sides", [false], false]
	],
	_onConfirm,
	{}
] call zen_dialog_fnc_create;
