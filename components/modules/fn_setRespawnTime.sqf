#include "script_component.hpp"

[
    "Respawn", "Set Respawn Time",
    {
        ["Set Respawn Time", [
                [
                    "EDIT",
                    "Time [s]",
                    str ([] call ACL_fnc_getPlayerRespawnTime),
                    true
                ]
            ], {
                params ["_values"];
                _values params ["_time"];
                (parseNumber _time) call ACL_fnc_setPlayerRespawnTime;
            }
        ] call ACL_fnc_createDialog;
    }
] call ACL_fnc_registerModule;
