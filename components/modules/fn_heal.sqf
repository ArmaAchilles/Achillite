#include "script_component.hpp"

[
    "Players", "Heal",
    {
        params ["", "_unit"];

        if ((missionNamespace getVariable ["BIS_revive_mode", 0]) != 0) then {
            ["#rev", 1, _unit] call BIS_fnc_reviveOnState;
            _unit setVariable ["#rev", 1, true];
        } else {
            _unit setDamage 0;
        };
    }
] call ACL_fnc_registerModule
