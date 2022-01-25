#include "script_component.hpp"

[
    "Fire Support", "Artillery Fire Mission",
    {
        private _arty = [_this, ["LandVehicle"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_arty") exitWith {};
        private _ammoList = getArtilleryAmmo [_arty];
        if (_ammoList isEqualTo []) exitWith {
            "HAS TO BE AN ARTILLERY UNIT" call ACL_fnc_showZeusErrorMessage;
        };

        ["Artillery Fire Mission", [
                [
                    "COMBO",
                    "Ammo",
                    [0, _ammoList apply {getText (configFile >> "CfgMagazines" >> _x >> "displayName")}]
                ],
                [
                    "EDIT",
                    "Rounds",
                    "1"
                ]
            ], {
                params ["_values", "_args"];
                _values params ["_ammoIdx", "_rounds"];
                _args params ["_arty", "_ammoList"];
                _ammo = _ammoList select _ammoIdx;
                _rounds = parseNumber _rounds;
                [
                    [_arty], {
                        params ["_confirmed", "_objects", "_pos", "_args"];
                        if (_confirmed) then {
                            _objects params ["_arty"];
                            _args params ["_ammo", "_rounds"];
                            private _eta = _arty getArtilleryETA [_pos, _ammo];
                            if (_eta < 0) then {
                                "TARGET NOT IN RANGE" call ACL_fnc_showZeusErrorMessage;
                            };
                            format ["ARTILLERY ETA: %1 SECONDS", _eta] call ACL_fnc_showZeusMessage;
                            _arty doArtilleryFire [_pos, _ammo, _rounds];
                        };
                    }, [_ammo, _rounds]
                ] call ACL_fnc_selectPosition;
            }, {}, [_arty, _ammoList]
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule
