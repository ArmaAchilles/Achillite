#include "script_component.hpp"

[
    "Players", "Heal",
    {
        private _unit = [_this, ["Man"]] call ACL_fnc_checkModuleTarget;
        if (isNil "_unit") exitWith {};

        if ((missionNamespace getVariable ["BIS_revive_mode", 0]) != 0) then {
            ["#rev", 1, _unit] call BIS_fnc_reviveOnState;
            _unit setVariable ["#rev", 1, true];
        } else {
            _unit setDamage 0;
        };
        "UNIT HEALED" call ACL_fnc_showZeusMessage;
    }
] call ACL_fnc_registerModule
