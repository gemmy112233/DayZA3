private["_inventory","_wpns","_mags","_idc","_isOK","_val","_item","_x","_vest1"];
_inventory = _this;
if (count _inventory > 0) then {
	_wpns = _inventory select 0;
	_mags = _inventory select 1;

	//Add weapons
	{
		if (_x == "Crossbow") then { _x = "Crossbow_DZ" }; // Convert Crossbow to Crossbow_DZ
        if ((_x isKindOf "Vest_NoCamo_Base") or (_x isKindOf "Vest_Camo_Base")) then {
            player addVest _x;
        } else {
		//Is item legal?
		_isOK = 	isClass(configFile >> "CfgWeapons" >> _x);
		if (_isOK) then {
			player addWeapon _x;
		};
        };
	} forEach _wpns;
    
	//Add inventory
	{
		private["_item","_val"];
		//is it an array?
		_idc = 109;
		if (typeName _x == "ARRAY") then {
			_item = _x select 0;
			_val = 	_x select 1;
		} else {
			_item = _x;
			_val = -1;
		};

		if (_item == "BoltSteel") then { _item = "WoodenArrow" }; // Convert BoltSteel to WoodenArrow
		_vest1 = vest player;
		WaitUntil {!isnil "_vest1"};
		//Is item legal?
		_isOK = 	isClass(configFile >> "CfgMagazines" >> _item);
		if (_isOK) then {
			if (_val != -1) then {
				player addMagazine [_item,_val];
			} else {
				player addMagazine _item;
			};
		};
		_idc = _idc + 1;
	} forEach _mags;

};