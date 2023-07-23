/*
 * Author: Kay
 * Safestart Event: intercept all projectiles fires by the player 
 * Global function to create the necessary CBA eventhandler to be present on all possible clients.
 * Called as a post-init function.
 *
 * Arguments:
 * No parameters
 *
 * Example:
 * ["RCC_player_safezone", [_silent, _safezone]] call CBA_fnc_globalEvent;
 *
 * _silent - boolean Silent Event (do not inform players)
 * _safezone - boolean Safezone Event
 *
 */

if !(hasInterface) exitWith {}; // eventhandler not defined on server

private _safestartid = ["RCC_player_safezone", {
	
	params [["_silent", true], ["_safezone", false]];

	if (player getVariable "RCC_safezone") exitWith {
		// systemChat "Exit RCC_player_safezone, FiredMan Eventhandler already exist, dont duplicate";
	};
	
	player setVariable ["RCC_safezone", true, true];
	
	if !(_silent) then {
		if (_safezone) then { 
			["Entering Safe Zone", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
		} else {
			["<t color='#ff8888'>Mission in safestart, no shooting allowed</t>", -1, 1, 10, 0] spawn BIS_fnc_dynamicText;
		};
	};

	if (!(isNull (getAssignedCuratorLogic player))) then { // game already started & zeus logic assigned
		RCC_PFEHwarning = [
			{
				if (!(player getVariable "RCC_safezone")) exitWith {
					[RCC_PFEHwarning] call CBA_fnc_removePerFrameHandler;
				};
				["<t color='#ff8888'>Safestart ON</t>", -1, 1, 2, 0] spawn BIS_fnc_dynamicText;
			}, 15
		] call CBA_fnc_addPerFrameHandler;
	} else { // when first executed in initPlayerLocal, add EH on curator display
		["zen_curatorDisplayLoaded", {
			RCC_PFEHwarning = [
				{
					if (!(player getVariable "RCC_safezone")) exitWith {
						[RCC_PFEHwarning] call CBA_fnc_removePerFrameHandler;
					};
					["<t color='#ff8888'>Safestart ON</t>", -1, 1, 2, 0] spawn BIS_fnc_dynamicText;
				}, 15
			] call CBA_fnc_addPerFrameHandler;			
		}] call CBA_fnc_addEventHandler;
	};

	private _eventID = player addEventHandler ["FiredMan", 
	{ 
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
		if (_weapon isEqualTo "Throw") then { 
			_unit addMagazine _magazine;
		};
		deleteVehicle _projectile;
	}];

	[
		{!(player getVariable "RCC_safezone")}, 
		{
			player removeEventHandler ["FiredMan", _this select 0];
			if !(_this select 1) then {
				if (_this select 2) then { 
					["Exiting Safe Zone", -1, 1, 4, 0] spawn BIS_fnc_dynamicText;
				} else {
					["<t color='#ff8888'>End of safestart</t>", -1, 1, 5, 0] spawn BIS_fnc_dynamicText;
				};
			};
		}, 
		[_eventID, _silent, _safezone]
	] call CBA_fnc_waitUntilAndExecute;

}] call CBA_fnc_addEventHandler;