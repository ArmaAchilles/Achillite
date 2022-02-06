#include "script_component.hpp"

[
    "Task", "Seek and Destroy",
    {
        private _unit = [_this, ["AllVehicles"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};

        [[_unit], {
            params ["_confirmed", "_objects", "_pos"];
            if (_confirmed) then {
                _objects params ["_unit"];
                [group _unit, _pos] call BIS_fnc_taskAttack;
            };
        }] call ACL_fnc_selectPosition;
    }
] call ACL_fnc_registerModule
