/*
 * Author: Reeveli
 * Client side function to add ace action to enable players to cut grass while prone.
 * Called as postinit.
 *
 * Arguments:
 * No parameters
 *
 */

if !(hasInterface) exitWith {};

if !(RCC_grassremoval_enable) exitWith {};

private _grass_action = [
	"Grass_removal", 
	"Remove foliage", 
	"\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_deploy_prone_ca.paa", 
	{
		[RCC_grassremoval_time, [], {
			private _object = createVehicle ['Land_ClutterCutter_large_F', position _player, [], 0, 'CAN_COLLIDE'];
			["zen_common_addObjects", [[_object]]] call CBA_fnc_serverEvent;
		}, {hint "Canceled"}, ""] call ace_common_fnc_progressBar;
	}, 
	{(vehicle _player == _player) && isTouchingGround _player && (stance player == "PRONE") && ("ACE_EntrenchingTool" in (items player))}
] call ace_interact_menu_fnc_createAction;

["Man", 1, ["ACE_SelfActions", "ACE_Equipment"], _grass_action, true] call ace_interact_menu_fnc_addActionToClass;
