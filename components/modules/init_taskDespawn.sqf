#include "script_component.hpp"

[
    "Task", "Despawn",
    {
        private _unit = [_this, ["AllVehicles"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};

        [[_unit], {
            params ["_confirmed", "_objects", "_pos"];
            if (_confirmed) then {
                _objects params ["_unit"];
                [group _unit, _pos, 2] call ACL_fnc_taskDespawn;
            };
        }] call ACL_fnc_selectPosition;
    }
] call ACL_fnc_registerModule
