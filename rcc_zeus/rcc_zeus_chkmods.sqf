/*
 * Author: 1er RCC - Kay
 * Custom Zeus module
 * Check for indesirable mods
 * (bullet_cases & dzn_VOF)
 *
 * Arguments:
 * No Parameters
  *
 * Return Value:
 * Log in systemChat
 *
 */

modsdisplayServer = "";
RCC_fnc_chkModsServer = {
	if (isClass (configFile >> "CfgPatches" >> "bullet_cases")) then {
		modsdisplayServer = "Server: HZ found";
	};
};

["zen_common_execute", [RCC_fnc_chkModsServer, []]] call CBA_fnc_serverEvent;

modsdisplay = "Clients: ";
RCC_fnc_chkModsClient = {
	params ["_textedisplay"];
	if (isClass (configFile >> "CfgPatches" >> "bullet_cases")) then {
		modsdisplay = _textedisplay + format["%1 HZ - ", name player];
	};
};

{
	["zen_common_execute", [RCC_fnc_chkModsClient, [modsdisplay]], _x] call CBA_fnc_targetEvent;
} forEach allPlayers;


systemChat modsdisplayServer;
systemChat modsdisplay;