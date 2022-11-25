if !(isClass (configFile >> "CfgPatches" >> "ace_main")) exitWith {};

ClassFirstAidConvertACE = "FirstAidKit";
ClassMediConvertACE = "Medikit";
if (isClass (configFile >> "CfgPatches" >> "vn_emm")) then {
	ClassFirstAidConvertACE = "vn_o_item_firstaidkit";
	ClassMediConvertACE = "vn_b_item_medikit_01";
};

addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer"];
	if (_killed isKindOf "CAManBase") then {
		private _unit = _this select 0;
		private _items = items _unit;

		if (ClassMediConvertACE in _items) then {
			_unit removeItems ClassFirstAidConvertACE;
			_unit removeItem ClassMediConvertACE;
			_backpack = BackpackContainer _unit;
			_backpack addItemCargoGlobal ["ACE_fieldDressing", 40];
			_backpack addItemCargoGlobal ["ACE_bloodIV", 5];
			_backpack addItemCargoGlobal ["ACE_epinephrine", 10];
			_backpack addItemCargoGlobal ["ACE_morphine", 10];
			_backpack addItemCargoGlobal ["ACE_tourniquet", 8];
			_backpack addItemCargoGlobal ["ACE_splint", 4];
			_backpack addItemCargoGlobal ["ACE_bloodIV_500", 5];
		};
		
		if (ClassFirstAidConvertACE in _items) then {
			while {({_x == ClassFirstAidConvertACE} count items _unit) > 0} do {
				_unit removeItem ClassFirstAidConvertACE;
				_vest = vestContainer _unit;
				_vest addItemCargoGlobal ["ACE_fieldDressing", 5];
				_vest addItemCargoGlobal ["ACE_morphine", 1];
			};
		};
	};
}];