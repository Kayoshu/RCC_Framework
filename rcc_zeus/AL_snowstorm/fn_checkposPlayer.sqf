/*
 * Author: ALIAS
 * SNOW STORM SCRIPT checkposPlayer
 * Modified for 1er RCC by Kay
 * Client-side script
 * 
 * Check position of player
 *
 * Arguments:
 * none
 *
 * Return Value:
 * pos_p local player variable
 * Alias_in_house, Alias_under_water, Alias_deep_sea, Alias_in_car, Alias_open
 *
 */

if (!hasInterface) exitWith {}; // only client-side

if (player getVariable "checkposPlayerSnow") exitWith {}; // if already set keep it running

// function to check position
RCC_fnc_AliasInHouse = {

	_house = lineIntersectsSurfaces [getPosWorld _this, getPosWorld _this vectorAdd [0, 0, 50], _this, objNull, true, 1, "GEOM", "NONE"];
	
	if (((_house select 0) select 3) isKindOf "house") exitWith	{
		pos_p = "Alias_in_house";
		Alias_building = ((_house select 0) select 3);
		private _alias_house = typeOf ((_house select 0) select 3);
		Alias_sizesnow = sizeof _alias_house;
	};
	
	// not using anymore helipad attachTo, objects were never deleted, new were created if player disconnect/reconnect
	// underwater now using player as particle source
	if ((getPosASL _this select 2 < -0.5) && (getPosASL _this select 2 > -2)) exitWith {pos_p = "Alias_under_water";};

	// tweaked values of underwater/deepsea	
	if (getPosASL _this select 2 < -2) exitWith {pos_p = "Alias_deep_sea";};
	
	if ((_this != vehicle _this) && (getPosASL _this select 2 > 0)) exitWith {pos_p = "Alias_in_car";};
	
	pos_p = "Alias_open";
};

player setVariable ["checkposPlayerSnow", true];

private _PFEHcheckpos = [
	{
		if (!snowstorm_on) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
			player setVariable ["checkposPlayerSnow", false];
		};
		if (snowstorm_on) then {
			player call RCC_fnc_AliasInHouse;
		};
	}, 1
] call CBA_fnc_addPerFrameHandler;