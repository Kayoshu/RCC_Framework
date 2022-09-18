/*
 * initPlayerLocal.sqf
 * Executes locally when player joins mission
 *
 * Parameters: _player, _didJIP
 *
 */
params ["_player", "_didJIP"];

waitUntil {!isNull player};
if (!hasInterface || isDedicated) exitWith {};

// Lives saving in missionNamespace
private _plyUID = getPlayerUID player;
private _lifeplayerid = missionNamespace getVariable "RCCLives" + _plyUID; // looking for value in missionNamespace for that player

if (isNil "_lifeplayerid") then { // if undefined then it's a first login
	_chosen = paramsArray select 0;
	[player, _chosen] call BIS_fnc_respawnTickets; // set mission parameters chosen lives
	missionNamespace setVariable ["RCCLives" + _plyUID, _chosen, true]; // sync in namespace variable
	systemChat format["Login %2: %1 lives", _chosen, _plyUID];
} else {
	if !(_lifeplayerid == 0) then {
		[player, _lifeplayerid] call BIS_fnc_respawnTickets;  // if already defined we set player lives to that number
		private _tickets = [player, nil, true] call BIS_fnc_respawnTickets;
		missionNamespace setVariable ["RCCLives" + _plyUID, _tickets, true]; // sync in namespace variable
		systemChat format["Reconnect %2: %1 lives", _tickets, _plyUID];
	}
};

// Init spectator variables
player setVariable ["RCC_forcespectate", false, true];
player setVariable ["RCC_IsSpectator", false];

RCC_CrowsZAModLoaded = isClass (configFile >> "CfgPatches" >> "CrowsZA"); // CrowsZA locally loaded
RCC_ACEModLoaded = isClass (configFile >> "CfgPatches" >> "ace_main"); // ACE locally loaded

// Init Spectator Watch CBA FrameEventhandler
RCC_CBASpectateWatch = [
	{
		// not IsSpectator
		if !(player getVariable "RCC_IsSpectator") then {
			// player run out of tickets OR is force spectator
			if ([player, nil, true] call BIS_fnc_respawnTickets < 1 OR player getVariable "RCC_forcespectate") then {
				player setVariable ["RCC_IsSpectator", true];
				
				[] spawn {
					// fix for issue #2 need to be in unscheduled to use sleep and time respawndialog closing
					hintSilent "Going into Spectator";
					sleep 6;
					["close"] call BIS_fnc_showRespawnMenu;
					
					if (RCC_ACEModLoaded) then {
						["ace_captives_setHandcuffed", [player, true], player] call CBA_fnc_targetEvent;	
					} else {
						player setCaptive true;
					};
					
					[true, true, true] call ace_spectator_fnc_setSpectator;
					sleep 2;
					
					private _players = [] call CBA_fnc_players;
					private _spec = [] call ace_spectator_fnc_players;
					private _game_masters = _players select {!(isNull (getAssignedCuratorLogic _x))};
					private _viewable = _players - _game_masters - _spec;
					[_viewable, [player]] call ace_spectator_fnc_updateUnits;
				};

			}
		} else { // IsSpectator
			// player has positive tickets AND is not force spectator
			if ([player, nil, true] call BIS_fnc_respawnTickets > 0 && !(player getVariable "RCC_forcespectate")) then {
				player setVariable ["RCC_IsSpectator", false];
				[] spawn {
					sleep 5;
					[false, true, true] call ace_spectator_fnc_setSpectator;
				
					if (RCC_ACEModLoaded) then {
						["ace_captives_setHandcuffed", [player, false], player] call CBA_fnc_targetEvent;	
					} else {
						player setCaptive false;
					};
				};
			};				
		};
	}, 3
] call CBA_fnc_addPerFrameHandler;

// Call the script to init safestart/safezone client side
execVM "functions\fn_safestart_client.sqf";
