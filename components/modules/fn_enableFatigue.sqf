#include "script_component.hpp"

[
    "Players", "Fatigue",
    {
        private _enabled = missionNamespace getVariable ["ACL_fatigueEnabled", true];
        ["Fatigue", [
                [
                    "TOOLBOX",
                    "Fatigue",
                    [parseNumber !_enabled, ["Enabled", "Disabled"]],
                    true
                ]
            ], {
                ((_this select 0 select 0) isEqualTo 0) call ACL_fnc_enableFatigue;
            }
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
