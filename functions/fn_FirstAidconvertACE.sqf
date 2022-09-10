addMissionEventHandler ["EntityKilled", {
	params ["_killed", "_killer"];	
	if (_killed isKindOf "CAManBase") then {
		private _unit = _this select 0;
		private _items = items _unit;

		if ("Medikit" in _items) then {
			while {({_x == "FirstAidKit"} count items _unit) > 0} do {
				_unit removeItem "FirstAidKit";
			};
		};
		
		while {({_x == "Medikit"} count items _unit) > 0} do {
			_unit removeItem "Medikit";
			_backpack = BackpackContainer _unit;
			_backpack addItemCargoGlobal ["ACE_fieldDressing", 40];
			_backpack addItemCargoGlobal ["ACE_bloodIV", 5];
			_backpack addItemCargoGlobal ["ACE_epinephrine", 10];
			_backpack addItemCargoGlobal ["ACE_morphine", 10];
			_backpack addItemCargoGlobal ["ACE_tourniquet", 10];
			_backpack addItemCargoGlobal ["ACE_splint", 5];
			_backpack addItemCargoGlobal ["ACE_bloodIV_500", 5];
		};
		while {({_x == "FirstAidKit"} count items _unit) > 0} do {
			_unit removeItem "FirstAidKit";
			_vest = vestContainer _unit;
			_vest addItemCargoGlobal ["ACE_fieldDressing", 5];
			_vest addItemCargoGlobal ["ACE_morphine", 1];
		};
	};
}];
