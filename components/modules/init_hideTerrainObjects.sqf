#include "script_component.hpp"

[
    "Environment", "Hide Terrain Objects",
    {
        params ["_center"];

        ["Hide Terrain Object", [
                ["TOOLBOX", "Mode", [1, ["Show", "Hide"]]],
                ["EDIT", "Radius [m]", "100"]
            ], {
                params ["_values", "_center"];
                _values params ["_hide", "_radius", "_buildings", "_walls", "_vegetation", "_others"];
                _hide =  _hide isEqualTo 1;
                _radius = parseNumber _radius;
                [_center, [], _radius, _hide] call ACL_fnc_hideTerrainObjects;
            }, {}, _center
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
