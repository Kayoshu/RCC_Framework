/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * 4 Transition Texts (empty texts are not displayed)
 *
 * Arguments:
 * No Parameters
 *
 * Return Value:
 * None
 *
 */

private _onConfirm = {
	params ["_dialogResult"];
	_dialogResult params ["_text1", "_timing1", "_text2", "_timing2", "_text3", "_timing3", "_text4", "_timing4", "_side", "_persidetext"];

	if (_text1 == "" && _text2 == "" && _text3 == "" && _text4 == "") exitWith {
        ["Need at least 1 text"] call zen_common_fnc_showMessage;
		systemChat "Need at least 1 text";
        playSound "FD_Start_F";
	};
	
	if (_persidetext) then {
		systemChat format["Sent to side: %1", _side];
	};
	
	// spawn texts
	[ 
		[_text1, _timing1, _text2, _timing2, _text3, _timing3, _text4, _timing4, _side, _persidetext], { 
		
			params ["_text1", "_timing1", "_text2", "_timing2", "_text3", "_timing3", "_text4", "_timing4", "_side", "_persidetext"];
			
			if (!((side player) in _side) && _persidetext) exitWith {};

			private "_handle";
			private _idlayertransition = ["TextTransitionDisplay"] call BIS_fnc_rscLayer;
			
			if !(_text1 == "") then {
				_text1 = [ format ["<t' size = '1'>%1</t>", _text1], -1, 0.2, _timing1, 1, 0];
				_handle = (_text1 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
			if !(_text2 == "") then {
				_text2 = [ format ["<t' size = '1'>%1</t>", _text2], -1, 0.2, _timing2, 1, 0];
				_handle = (_text2 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
			if !(_text3 == "") then {
				_text3 = [ format ["<t' size = '1'>%1</t>", _text3], -1, 0.2, _timing3, 1, 0];
				_handle = (_text3 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
			if !(_text4 == "") then {
				_text4 = [ format ["<t' size = '1'>%1</t>", _text4], -1, 0.2, _timing4, 1, 0];
				_handle = (_text4 + [_idlayertransition]) spawn BIS_fnc_dynamicText;
				waitUntil {scriptDone _handle};
			};
		} 
	] remoteExecCall ["spawn", [0, -2] select isDedicated, false];
	
};

// Module dialog 
[
	"Transition Time Change", 
	[
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
