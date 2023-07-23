/*
 * Author: Kay
 * Global function to create the necessary CBA eventhandler to be present on all possible clients.
 * Called as a post-init function.
 *
 * Arguments:
 * No Parameters
 *
 * Example:
 * ["RCC_video_play", [_videopath, _excludezeus, _excludedrivers, _environment, _userinput, _tfarmute]] call CBA_fnc_globalEvent;
 *
 * _videopath - video path (relative to mission or mod)
 * _excludezeus - boolean exclude zeus from video
 * _excludedrivers - boolean exclude all drivers from video
 * _environment - boolean disable environment sounds
 * _userinput - boolean disable user input (simulation)
 * _tfarmute - boolean tfar muting (local & radios)
 *
 */

if !(hasInterface) exitWith {}; // eventhandler not defined on server


private _eventid = ["RCC_video_play", {
	params ["_videopath", "_excludezeus", "_excludedrivers", "_environment", "_userinput", "_tfarmute"];
	
	if (_excludezeus && !isNull (getAssignedCuratorLogic player)) exitWith {};
	
	if (((driver (vehicle player)) isEqualTo player) && !((vehicle player) isKindOf "CAManBase") && _excludedrivers) exitWith {};  // if player is vehicle driver and not on foot exclude it
	
	[_videopath, _environment, _userinput, _tfarmute] spawn {
		params ["_videopath", "_environment", "_userinput", "_tfarmute"];

		if (_userinput) then {
			[ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player] call ace_safemode_fnc_lockSafety;
			player enablesimulation false;
		};
		if (_tfarmute) then {
			0 call TFAR_fnc_setVoiceVolume;
		};
		if (_environment) then {
			1.5 fadeSound 0;
			enableEnvironment [false, false];
		};
		
		private _play = [_videopath] spawn BIS_fnc_PlayVideo;
		waitUntil {scriptDone _play};
		
		if (_environment) then {
			1.5 fadeSound 1;
			enableEnvironment [true, true];
		};
		if (_tfarmute) then {
			20 call TFAR_fnc_setVoiceVolume;
		};
		if (_userinput) then {
			[ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player] call ace_safemode_fnc_unlockSafety;
			player enablesimulation true;
		};
		
	};

}] call CBA_fnc_addEventHandler;