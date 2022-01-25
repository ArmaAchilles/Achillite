#include "script_component.hpp"

[
    "Environment", "Toggle Lamps",
    {
        params ["_center"];
        ["Toggle Lamps", [
                [
                    "EDIT",
                    "Radius [m]",
                    "100"
                ],
                [
                    "TOOLBOX",
                    "State",
                    [1, ["Off", "On"]]
                ]
            ], {
                params ["_values", "_center"];
                _values params ["_radius", "_state"];
                _radius = parseNumber _radius;
                _state = _state isEqualTo 1;
                private _buildings = nearestObjects [_center, ["Building"], _radius, true];
                [_buildings, _state] call ACL_fnc_switchLamp;
            }, {}, _center
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
