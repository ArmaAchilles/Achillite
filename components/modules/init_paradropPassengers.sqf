#include "script_component.hpp"

[
    "Task", "Paradrop Passengers",
    {
        private _aircraft = [_this, ["Helicopter", "Plane"], false] call ACL_fnc_checkModuleTarget;
        if (isNil "_aircraft") exitWith {};

        [[_aircraft], {
            params ["_confirmed", "_objects", "_pos"];
            if (_confirmed) then {
                _objects params ["_aircraft"];
                [_aircraft, _pos] call ACL_fnc_taskParadrop;
            };
        }] call ACL_fnc_selectPosition;
    }
] call ACL_fnc_registerModule
