#include "script_component.hpp"

if (isNil "ACL_suppliesDelivererCache") then {
    ACL_suppliesDelivererCache = [];
    {
        private _type = configName _x;
        if (getNumber (_x >> "scope") isEqualTo 2 &&
            {_type isKindOf "Air"} &&
            {!(_type isKindOf "UAV_06_base_F")} &&
            {isClass (_x >> "VehicleTransport" >> "Carrier") || {getNumber (_x >> "slingLoadMaxCargoMass") > 0}}
        ) then {
            ACL_suppliesDelivererCache pushBack [getText (_x >> "displayName"), _type];
        };
    } forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

    ACL_suppliesDelivererCache sort true;
};

[
    "Support", "Deliver Supplies",
    {
        private _box = [_this] call ACL_fnc_checkModuleTarget;
        if (isNil "_box") exitWith {};

        ["Deliver Supplies", [
                [
                    "COMBO",
                    "Side",
                    [0, SIDE_NAMES_TO_SELECT]
                ],
                [
                    "COMBO",
                    "Vehicle",
                    [0, ACL_suppliesDelivererCache apply {_x select 0}]
                ]
            ], {
                params ["_values", "_box"];
                _values params ["_sideIdx", "_vehicleIdx"];
                private _side = SIDES_TO_SELECT select _sideIdx;
                (ACL_suppliesDelivererCache select _vehicleIdx) params ["", "_type"];

                [[_box], {
                        params ["_confirmed", "_objects", "_pos", "_args"];
                        if (_confirmed) then {
                            _objects params ["_box"];
                            private _startPos = getPos _box;
                            _args params ["_side", "_type"];
                            private _aircraft = [_startPos, _startPos getDir _pos, _type, _side] call ACL_fnc_spawnVehicle;
                            if !([_aircraft, _box] call ACL_fnc_canLoadCargo) exitWith {
                                "AIRCRAFT CANNOT LOAD CARGO" call ACL_fnc_showZeusErrorMessage;
                                [_aircraft, _startPos] call ACL_fnc_taskDespawn;
                            };

                            [_aircraft, _box] call ACL_fnc_loadCargoInstant;
                            [_aircraft, _box, _pos] call ACL_fnc_taskDeliverCargo;
                            [_aircraft, _startPos, 2] call ACL_fnc_taskDespawn;
                        };
                    }, [_side, _type]
                ] call ACL_fnc_selectPosition;
            }, {}, _box
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule
