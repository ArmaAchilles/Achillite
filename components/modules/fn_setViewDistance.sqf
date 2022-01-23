#include "script_component.hpp"

[
    "Players", "Set View Distance",
    {
        ["Set View Distance", [
                [
                    "EDIT",
                    "View Distance [m]",
                    str viewDistance,
                    true
                ],
                [
                    "EDIT",
                    "Object View Distance  [m]",
                    str (getObjectViewDistance select 0),
                    true
                ],
                [
                    "EDIT",
                    "Shadow View Distance  [m]",
                    str (getObjectViewDistance select 1),
                    true
                ]
            ], {
                ((_this select 0) apply {parseNumber _x}) call ACL_fnc_setViewDistance;
            }
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
